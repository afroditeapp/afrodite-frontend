import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:app/assets.dart';
import 'package:app/utils/result.dart';
import 'package:utils/utils.dart';
import 'package:web_socket/io_web_socket.dart';
import 'package:web_socket/web_socket.dart' as ws;
import 'package:rxdart/rxdart.dart';

import 'common.dart';

sealed class HttpClientManagerCmd<T> {
  final BehaviorSubject<Result<T, Object>?> completed = BehaviorSubject.seeded(null);

  /// Can be called only once
  Future<Result<T, Object>> waitCompletionAndDispose() async {
    final value = await completed.whereType<Result<T, Object>>().first;
    await completed.close();
    return value;
  }
}

class GetHttpClientCmd extends HttpClientManagerCmd<Client> {
  final String serverAddress;
  GetHttpClientCmd(this.serverAddress);
}

/// Manages HTTP and WebSocket clients app wide.
///
/// Multiple HTTP clients can exist at the same time, one per server address.
class HttpClientManager implements HttpClientManagerInterface {
  static final _instance = HttpClientManager._();
  HttpClientManager._();
  factory HttpClientManager.getInstance() {
    return _instance;
  }

  final Map<String, Client> _httpClients = {};
  final PublishSubject<HttpClientManagerCmd<Object>> _cmds = PublishSubject();
  bool _initDone = false;

  @override
  Future<void> init(String serverAddress) async {
    if (_initDone) {
      return;
    }
    _initDone = true;

    _listenCmds();
    await getHttpClient(serverAddress);
  }

  @override
  Future<Client> getHttpClient(String serverAddress) async {
    final cmd = GetHttpClientCmd(serverAddress);
    _cmds.add(cmd);
    final result = await cmd.waitCompletionAndDispose();
    return switch (result) {
      Ok(:final v) => v,
      Err(:final e) => throw e,
    };
  }

  StreamSubscription<void> _listenCmds() {
    return _cmds
        .asyncMap((cmd) async {
          try {
            switch (cmd) {
              case GetHttpClientCmd(:final serverAddress):
                final existing = _httpClients[serverAddress];
                final Client client;
                if (existing == null) {
                  client = await _createHttpClient(serverAddress);
                  _httpClients[serverAddress] = client;
                } else {
                  client = existing;
                }
                cmd.completed.add(Ok(client));
            }
          } catch (error) {
            cmd.completed.add(Err(error));
          }
        })
        .listen(null);
  }

  Future<Client> _createHttpClient(String serverAddress) async {
    return IOClient(
      HttpClient(context: await createSecurityContextForBackendConnection(serverAddress)),
    );
  }

  @override
  Future<ws.WebSocket?> connectWebSocket(
    String serverAddress,
    List<String> protocols, {
    required String path,
  }) async {
    final websocketAddress = buildWebSocketAddress(serverAddress, path);
    final bytes = generate128BitRandomValue();
    final key = base64.encode(bytes);

    final client = IOClient(
      HttpClient(context: await createSecurityContextForBackendConnection(serverAddress)),
    );
    final headers = {
      HttpHeaders.connectionHeader: "upgrade",
      HttpHeaders.upgradeHeader: "websocket",
      "sec-websocket-version": "13",
      "sec-websocket-key": key,
      "sec-websocket-protocol": protocols.join(","),
    };
    final request = Request("GET", Uri.parse(websocketAddress));
    request.headers.addAll(headers);

    final IOStreamedResponse response = await client.send(request);

    if (response.statusCode != HttpStatus.switchingProtocols) {
      return null;
    }

    final socket = WebSocket.fromUpgradedSocket(await response.detachSocket(), serverSide: false);
    return IOWebSocket.fromWebSocket(socket);
  }
}
