



import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:math';

import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:pihka_frontend/api/api_manager.dart';
import 'package:pihka_frontend/api/api_provider.dart';
import 'package:pihka_frontend/storage/kv.dart';
import 'package:rxdart/rxdart.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';

enum ServerSlot {
  account,
  profile,
  media;

  KvString toRefreshTokenKey() {
    switch (this) {
      case ServerSlot.account: return KvString.accountRefreshToken;
      case ServerSlot.media: return KvString.mediaRefreshToken;
      case ServerSlot.profile: return KvString.profileRefreshToken;
    }
  }

  KvString toAccessTokenKey() {
    switch (this) {
      case ServerSlot.account: return KvString.accountAccessToken;
      case ServerSlot.media: return KvString.mediaAccessToken;
      case ServerSlot.profile: return KvString.profileAccessToken;
    }
  }
}

enum ServerConnectionError {
  /// Invalid token, so new login required.
  invalidToken,
  /// Server unreachable, server connection broke or protocol error.
  connectionFailure,
}

sealed class ServerConnectionState {}
/// No connection. Initial and after closing state.
class ReadyToConnect implements ServerConnectionState {}
/// Connection exists. Connecting to server or getting new tokens.
class Connecting implements ServerConnectionState {}
/// Connection exists. New tokens received and event listening started.
class Ready implements ServerConnectionState {}
/// No connection. Connection ended in error.
class Error implements ServerConnectionState {
  final ServerConnectionError error;
  Error(this.error);
}

enum ConnectionProtocolState {
  receiveNewRefreshToken,
  receiveNewAccessToken,
  receiveEvents,
}

class ServerConnection {
  final ServerSlot _server;
  String _address;

  IOWebSocketChannel? _connection;
  ConnectionProtocolState _protocolState = ConnectionProtocolState.receiveNewRefreshToken;

  final BehaviorSubject<ServerConnectionState> _state =
    BehaviorSubject.seeded(ReadyToConnect());
  final PublishSubject<ServerWsEvent> _events =
    PublishSubject();

  Stream<ServerConnectionState> get state => _state;
  Stream<ServerWsEvent> get serverEvents => _events;

  ServerConnection(this._server, this._address);

  /// Starts new connection if it does not already exists.
  Future<void> start() async {
    await close();
    _state.add(Connecting());
    _protocolState = ConnectionProtocolState.receiveNewRefreshToken;
    unawaited(_connect().then((value) => null)); // Connect in backgorund.
  }

  Future<void> _connect() async {
    final storage = KvStorageManager.getInstance();

    final accessToken = await storage.getString(_server.toAccessTokenKey());
    if (accessToken == null) {
      _state.add(Error(ServerConnectionError.invalidToken));
      return;
    }
    final refreshToken = await storage.getString(_server.toRefreshTokenKey());
    if (refreshToken == null) {
      _state.add(Error(ServerConnectionError.invalidToken));
      return;
    }

    final r = Random.secure();
    final bytes = List<int>.generate(16, (_) => r.nextInt(255));
    final key = base64.encode(bytes);

    final client = IOClient();
    final headers = {
      accessTokenHeaderName: accessToken,
      HttpHeaders.connectionHeader: "upgrade",
      HttpHeaders.upgradeHeader: "websocket",
      "sec-websocket-version": "13",
      "sec-websocket-key": key,
    };
    final request = Request("GET", Uri.parse(_address));
    request.headers.addAll(headers);

    final IOStreamedResponse response;
    try {
       response = await client.send(request);
    } on ClientException catch (e) {
      print(e);
      _state.add(Error(ServerConnectionError.connectionFailure));
      return;
    }

    if (response.statusCode == HttpStatus.unauthorized) {
      _state.add(Error(ServerConnectionError.invalidToken));
      return;
    } else if (response.statusCode != HttpStatus.switchingProtocols) {
      _state.add(Error(ServerConnectionError.connectionFailure));
      return;
    }

    final webSocket = WebSocket.fromUpgradedSocket(await response.detachSocket(), serverSide: false);
    final IOWebSocketChannel ws = IOWebSocketChannel(webSocket);
    _connection = ws;

    // Client starts the messaging
    final byteToken = base64Decode(refreshToken);
    ws.sink.add(byteToken);

    ws
      .stream
      .asyncMap((message) async {
        switch (_protocolState) {
          case ConnectionProtocolState.receiveNewRefreshToken: {
            if (message is List<int>) {
              final newRefreshToken = base64Encode(message);
              await storage.setString(_server.toRefreshTokenKey(), newRefreshToken);
              _protocolState = ConnectionProtocolState.receiveNewAccessToken;
            } else {
              await _endConnectionToGeneralError();
            }
          }
          case ConnectionProtocolState.receiveNewAccessToken: {
            if (message is String) {
              await storage.setString(_server.toAccessTokenKey(), message);
              _protocolState = ConnectionProtocolState.receiveEvents;
              _state.add(Ready());
            } else {
              await _endConnectionToGeneralError();
            }
          }
          case ConnectionProtocolState.receiveEvents: {
            if (message is String) {
              switch (message) {
                case _: _events.add(ServerWsEvent.todo);
              }
            }
          }
        }
      })
      .listen(
        null,
        onError: (Object error) {
          print(error);
          _connection = null;
          _state.add(Error(ServerConnectionError.connectionFailure));
        },
        onDone: () {
          if (_connection == null) {
            // Client closed the connection.
            return;
          }

          if (ws.closeCode != null &&
            ws.closeCode == status.internalServerError) {
            _state.add(Error(ServerConnectionError.invalidToken));
          } else {
            _state.add(Error(ServerConnectionError.connectionFailure));
          }
          _connection = null;
        },
        cancelOnError: true,
      );
  }

  Future<void> _endConnectionToGeneralError() async {
    await _connection?.sink.close(status.goingAway);
    _connection = null;
    _state.add(Error(ServerConnectionError.connectionFailure));
  }

  Future<void> close() async {
    await _connection?.sink.close(status.goingAway);
    _connection = null;
    _state.add(ReadyToConnect());
  }

  void setAddress(String address) {
    _address = address;
  }

  bool inUse() {
    return !(_state.value is ReadyToConnect || _state.value is Error);
  }
}
