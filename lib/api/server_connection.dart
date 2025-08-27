import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:app/data/app_version.dart';
import 'package:database/database.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:app/api/server_connection_manager.dart';
import 'package:app/api/websocket_wrapper.dart';
import 'package:app/assets.dart';
import 'package:app/database/account_background_database_manager.dart';
import 'package:app/database/account_database_manager.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:utils/utils.dart';
import 'package:app/utils/result.dart';
import 'package:rxdart/rxdart.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

var log = Logger("ServerConnection");

enum ServerConnectionError {
  /// Invalid token, so new login required.
  invalidToken,

  /// Server unreachable, server connection broke or protocol error.
  connectionFailure,

  /// Unsupported client version.
  unsupportedClientVersion,
}

sealed class ServerConnectionState {}

/// Connection exists. Connecting to server or getting new tokens.
class Connecting implements ServerConnectionState {
  @override
  bool operator ==(Object other) {
    return other is Connecting;
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

/// Connection exists. New tokens received and event listening started.
class Ready implements ServerConnectionState {
  final AccessToken token;
  const Ready(this.token);

  @override
  bool operator ==(Object other) {
    return other is Ready && other.token == token;
  }

  @override
  int get hashCode => Object.hash(runtimeType.hashCode, token);
}

/// Connection closed
class Closed implements ServerConnectionState {
  final ServerConnectionError? error;
  Closed(this.error);

  @override
  String toString() {
    return "Closed, error: $error";
  }

  @override
  bool operator ==(Object other) {
    return (other is Closed && error == other.error);
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);
}

enum ConnectionProtocolState {
  receiveFirstMessage,
  receiveNewRefreshToken,
  receiveNewAccessToken,
  receiveEvents,
}

String _addWebSocketRoutePathToAddress(String baseUrl) {
  final base = Uri.parse(baseUrl);

  final newAddress = Uri(
    scheme: base.scheme,
    host: base.host,
    port: base.port,
    path: "/common_api/connect",
  ).toString();

  return newAddress;
}

class ServerConnection {
  final WebSocketWrapper _connection;
  final AccountDatabaseManager db;
  final AccountBackgroundDatabaseManager accountBackgroundDb;
  final Sink<ServerWsEvent> _serverEvents;

  var _protocolState = ConnectionProtocolState.receiveFirstMessage;

  final BehaviorSubject<ServerConnectionState> _state = BehaviorSubject.seeded(Connecting());
  Stream<ServerConnectionState> get state => _state;

  StreamSubscription<void>? _connectionSubscription;
  StreamSubscription<NavigatorStateData>? _navigationSubscription;

  bool _isClosed = false;

  ServerConnection._(this._connection, this.db, this.accountBackgroundDb, this._serverEvents);

  static Future<Result<ServerConnection, ServerConnectionError>> connect(
    String serverAddress,
    AccessToken accessToken,
    RefreshToken refreshToken,
    AccountDatabaseManager db,
    AccountBackgroundDatabaseManager accountBackgroundDb,
    Sink<ServerWsEvent> serverEvents,
  ) async {
    final websocketAddress = _addWebSocketRoutePathToAddress(serverAddress);

    final WebSocketWrapper ws;
    if (kIsWeb) {
      if (!websocketAddress.startsWith("http")) {
        throw UnsupportedError("Unsupported URI scheme");
      }
      final wsAddress = Uri.parse(websocketAddress.replaceFirst("http", "ws"));
      try {
        ws = WebSocketWrapper(
          WebSocketChannel.connect(wsAddress, protocols: ["0", accessToken.token]),
        );
      } catch (e) {
        // TODO(prod): Change so that it is possible to detect
        //             ServerConnectionError.invalidToken.
        log.error("Server connection: WebScocket connecting exception");
        log.fine(e);
        return const Err(ServerConnectionError.connectionFailure);
      }
    } else {
      final bytes = generate128BitRandomValue();
      final key = base64.encode(bytes);

      final client = IOClient(
        HttpClient(context: await createSecurityContextForBackendConnection()),
      );
      final headers = {
        HttpHeaders.connectionHeader: "upgrade",
        HttpHeaders.upgradeHeader: "websocket",
        "sec-websocket-version": "13",
        "sec-websocket-key": key,
        "sec-websocket-protocol": "0,${accessToken.token}",
      };
      final request = Request("GET", Uri.parse(websocketAddress));
      request.headers.addAll(headers);

      final IOStreamedResponse response;
      try {
        response = await client.send(request);
      } on ClientException catch (e) {
        log.error("Server connection: client exception");
        log.fine(e);
        return const Err(ServerConnectionError.connectionFailure);
      } on HandshakeException catch (e) {
        log.error("Server connection: handshake exception");
        log.fine(e);
        return const Err(ServerConnectionError.connectionFailure);
      }

      if (response.statusCode == HttpStatus.unauthorized) {
        return const Err(ServerConnectionError.invalidToken);
      } else if (response.statusCode != HttpStatus.switchingProtocols) {
        return const Err(ServerConnectionError.connectionFailure);
      }

      final webSocket = WebSocket.fromUpgradedSocket(
        await response.detachSocket(),
        serverSide: false,
      );
      ws = WebSocketWrapper(IOWebSocketChannel(webSocket));
    }

    final connection = ServerConnection._(ws, db, accountBackgroundDb, serverEvents);
    connection._handleConnection(accessToken, refreshToken);
    return Ok(connection);
  }

  void _handleConnection(AccessToken accessToken, RefreshToken refreshToken) {
    // Client starts the messaging
    _connection.connection.sink.add(clientVersionInfoBytes());

    _connectionSubscription = _connection.connection.stream
        .asyncMap((message) async {
          switch (_protocolState) {
            case ConnectionProtocolState.receiveFirstMessage:
              if (message is List<int>) {
                switch (message) {
                  case [0]:
                    await handleConnectionIsReadyForDataSync(accessToken);
                  case [1]:
                    final byteToken = base64Decode(refreshToken.token);
                    _connection.connection.sink.add(byteToken);
                    _protocolState = ConnectionProtocolState.receiveNewRefreshToken;
                  case [2]:
                    await _endConnectionToGeneralError(
                      error: ServerConnectionError.unsupportedClientVersion,
                    );
                  default:
                    await _endConnectionToGeneralError();
                }
              } else {
                await _endConnectionToGeneralError();
              }
            case ConnectionProtocolState.receiveNewRefreshToken:
              if (message is List<int>) {
                final newRefreshToken = RefreshToken(token: base64Encode(message));
                await db.accountAction((db) => db.loginSession.updateRefreshToken(newRefreshToken));
                _protocolState = ConnectionProtocolState.receiveNewAccessToken;
              } else {
                await _endConnectionToGeneralError();
              }
            case ConnectionProtocolState.receiveNewAccessToken:
              if (message is List<int>) {
                final newAccessToken = AccessToken(
                  token: base64Url.encode(message).replaceAll("=", ""),
                );
                await db.accountAction((db) => db.loginSession.updateAccessToken(newAccessToken));
                await handleConnectionIsReadyForDataSync(newAccessToken);
              } else {
                await _endConnectionToGeneralError();
              }
            case ConnectionProtocolState.receiveEvents:
              if (message is String) {
                final event = EventToClient.fromJson(jsonDecode(message));
                if (event != null) {
                  _serverEvents.add(EventToClientContainer(event));
                }
              }
          }
        })
        .listen(
          null,
          onError: (Object error) {
            log.error("Connection exception");
            log.fine("$error");
            _endConnectionToGeneralError();
          },
          onDone: () {
            if (_connection.connection.closeCode != null &&
                _connection.connection.closeCode == status.internalServerError) {
              log.error("Invalid token");
              _state.add(Closed(ServerConnectionError.invalidToken));
            } else {
              log.error("Connection closed");
              _state.add(Closed(ServerConnectionError.connectionFailure));
            }
            _connection.close();
          },
          cancelOnError: true,
        );
  }

  Future<void> handleConnectionIsReadyForDataSync(AccessToken token) async {
    _connection.connection.sink.add(await syncDataBytes(db, accountBackgroundDb));
    _protocolState = ConnectionProtocolState.receiveEvents;
    log.info("Connection ready");
    _state.add(Ready(token));
    _navigationSubscription = NavigationStateBlocInstance.getInstance().navigationStateStream
        .listen((navigationState) {
          _connection.updatePingInterval(navigationState);
        });
  }

  Future<void> _endConnectionToGeneralError({
    ServerConnectionError error = ServerConnectionError.connectionFailure,
  }) async {
    if (_isClosed) {
      return;
    }
    _isClosed = true;
    await _connection.close();
    _state.add(Closed(error));
    await _connectionSubscription?.cancel();
    await _navigationSubscription?.cancel();
  }

  Future<void> close() async {
    if (_isClosed) {
      return;
    }
    _isClosed = true;
    await _connection.close();
    _state.add(Closed(null));
    await _connectionSubscription?.cancel();
    await _navigationSubscription?.cancel();
  }
}

Uint8List clientVersionInfoBytes() {
  const protocolVersion = 1;
  final int platform;
  if (kIsWeb) {
    platform = 2;
  } else if (Platform.isAndroid) {
    platform = 0;
  } else if (Platform.isIOS) {
    platform = 1;
  } else {
    throw UnimplementedError("Platform not supported");
  }
  final protocolBytes = <int>[protocolVersion, platform];
  final major = AppVersionManager.getInstance().major;
  final minor = AppVersionManager.getInstance().minor;
  final patch = AppVersionManager.getInstance().patch;
  protocolBytes.addAll(u16ToLittleEndianBytes(major));
  protocolBytes.addAll(u16ToLittleEndianBytes(minor));
  protocolBytes.addAll(u16ToLittleEndianBytes(patch));
  return Uint8List.fromList(protocolBytes);
}

const forceSync = 255;
/*
    Account = 0,
    ReveivedLikes = 1,
    ClientConfig = 2,
    Profile = 3,
    News = 4,
    MediaContent = 5,
    DailyLikesLeft = 6,
    /// Special value without valid [SyncVersionFromClient] informing
    /// the server that client has info that server maintenance is scheduled.
    ServerMaintenanceIsScheduled = 255,
*/

Future<Uint8List> syncDataBytes(
  AccountDatabaseManager db,
  AccountBackgroundDatabaseManager accountBackgroundDb,
) async {
  final syncVersionAccount =
      await db.accountStreamSingle((db) => db.common.watchSyncVersionAccount()).ok() ?? forceSync;
  final syncVersionReceivedLikes =
      await accountBackgroundDb
          .accountStreamSingle((db) => db.newReceivedLikesCount.watchSyncVersionReceivedLikes())
          .ok() ??
      forceSync;
  final syncVersionClientConfig =
      await db.accountStreamSingle((db) => db.common.watchSyncVersionClientConfig()).ok() ??
      forceSync;
  final syncVersionProfile =
      await db.accountStreamSingle((db) => db.common.watchSyncVersionProfile()).ok() ?? forceSync;
  final syncVersionNews =
      await accountBackgroundDb.accountStreamSingle((db) => db.news.watchSyncVersionNews()).ok() ??
      forceSync;
  final syncVersionMediaContent =
      await db.accountStreamSingle((db) => db.common.watchSyncVersionMediaContent()).ok() ??
      forceSync;
  final syncVersionDailyLikesLeft =
      await db.accountStreamSingle((db) => db.like.watchDailyLikesLeftSyncVersion()).ok() ??
      forceSync;

  final currentMaintenanceInfo = await db
      .accountStreamSingle((db) => db.common.watchServerMaintenanceInfo())
      .ok();
  final sendMaintenanceSyncVersion = currentMaintenanceInfo?.maintenanceLatest != null;

  final bytes = <int>[
    0, // Account
    syncVersionAccount,
    1, // ReveivedLikes
    syncVersionReceivedLikes,
    2, // ClientConfig
    syncVersionClientConfig,
    3, // Profile
    syncVersionProfile,
    4, // News
    syncVersionNews,
    5, // Media content
    syncVersionMediaContent,
    6, // Daily likes left
    syncVersionDailyLikesLeft,
    if (sendMaintenanceSyncVersion) 255,
    if (sendMaintenanceSyncVersion) 0,
  ];

  return Uint8List.fromList(bytes);
}
