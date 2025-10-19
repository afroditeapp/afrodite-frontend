import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:app/data/app_version.dart';
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
import 'package:web_socket/web_socket.dart' as ws;
import 'package:web_socket/io_web_socket.dart';

final _log = Logger("ServerConnection");

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
  /// If null, connection is closed manually
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

    final protocols = ["v1", "t${accessToken.token}", clientVersionInfoString()];

    final WebSocketWrapper webSocketWrapper;
    if (kIsWeb) {
      if (!websocketAddress.startsWith("http")) {
        throw UnsupportedError("Unsupported URI scheme");
      }
      final wsAddress = Uri.parse(websocketAddress.replaceFirst("http", "ws"));
      try {
        webSocketWrapper = WebSocketWrapper(
          await ws.WebSocket.connect(wsAddress, protocols: protocols),
        );
      } catch (e) {
        _log.error("Server connection: WebScocket connecting exception");
        _log.fine(e);
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
        "sec-websocket-protocol": protocols.join(","),
      };
      final request = Request("GET", Uri.parse(websocketAddress));
      request.headers.addAll(headers);

      final IOStreamedResponse response;
      try {
        response = await client.send(request);
      } on ClientException catch (e) {
        _log.error("Server connection: client exception");
        _log.fine(e);
        return const Err(ServerConnectionError.connectionFailure);
      } on HandshakeException catch (e) {
        _log.error("Server connection: handshake exception");
        _log.fine(e);
        return const Err(ServerConnectionError.connectionFailure);
      }

      if (response.statusCode != HttpStatus.switchingProtocols) {
        return const Err(ServerConnectionError.connectionFailure);
      }

      final webSocket = WebSocket.fromUpgradedSocket(
        await response.detachSocket(),
        serverSide: false,
      );
      webSocketWrapper = WebSocketWrapper(IOWebSocket.fromWebSocket(webSocket));
    }

    final connection = ServerConnection._(webSocketWrapper, db, accountBackgroundDb, serverEvents);
    connection._handleConnection(accessToken, refreshToken);
    return Ok(connection);
  }

  void _handleConnection(AccessToken accessToken, RefreshToken refreshToken) {
    _connectionSubscription = _connection.connection.events
        .asyncMap((message) async {
          if (message is ws.CloseReceived) {
            await _endConnectionToGeneralError();
            return;
          }
          switch (_protocolState) {
            case ConnectionProtocolState.receiveFirstMessage:
              if (message is ws.BinaryDataReceived) {
                switch (message.data) {
                  case [0]:
                    await handleConnectionIsReadyForDataSync(accessToken);
                  case [1]:
                    final byteToken = base64Decode(refreshToken.token);
                    _connection.connection.sendBytes(byteToken);
                    _protocolState = ConnectionProtocolState.receiveNewRefreshToken;
                  case [2]:
                    await _endConnectionToGeneralError(
                      error: ServerConnectionError.unsupportedClientVersion,
                    );
                  case [3]:
                    await _endConnectionToGeneralError(error: ServerConnectionError.invalidToken);
                  default:
                    await _endConnectionToGeneralError();
                }
              } else {
                await _endConnectionToGeneralError();
              }
            case ConnectionProtocolState.receiveNewRefreshToken:
              if (message is ws.BinaryDataReceived) {
                final newRefreshToken = RefreshToken(token: base64Encode(message.data));
                await db.accountAction((db) => db.loginSession.updateRefreshToken(newRefreshToken));
                _protocolState = ConnectionProtocolState.receiveNewAccessToken;
              } else {
                await _endConnectionToGeneralError();
              }
            case ConnectionProtocolState.receiveNewAccessToken:
              if (message is ws.BinaryDataReceived) {
                final newAccessToken = AccessToken(
                  token: base64Url.encode(message.data).replaceAll("=", ""),
                );
                await db.accountAction((db) => db.loginSession.updateAccessToken(newAccessToken));
                await handleConnectionIsReadyForDataSync(newAccessToken);
              } else {
                await _endConnectionToGeneralError();
              }
            case ConnectionProtocolState.receiveEvents:
              if (message is ws.TextDataReceived) {
                final event = EventToClient.fromJson(jsonDecode(message.text));
                if (event != null) {
                  _serverEvents.add(EventToClientContainer(event));
                }
              }
          }
        })
        .listen(
          null,
          onError: (Object error) {
            _log.error("Connection message handling exception");
            _log.fine("$error");
            _endConnectionToGeneralError();
          },
          cancelOnError: true,
        );
  }

  Future<void> handleConnectionIsReadyForDataSync(AccessToken token) async {
    final bytes = await syncDataBytes(db, accountBackgroundDb);
    if (_isClosed) {
      return;
    }
    _connection.connection.sendBytes(bytes);
    _protocolState = ConnectionProtocolState.receiveEvents;
    _log.info("Connection ready");
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
    await _connectionSubscription?.cancel();
    await _navigationSubscription?.cancel();
    await _connection.close();
    _state.add(Closed(error));
    await _state.close();
  }

  Future<void> close() async {
    if (_isClosed) {
      return;
    }
    _isClosed = true;
    await _connectionSubscription?.cancel();
    await _navigationSubscription?.cancel();
    await _connection.close();
    _state.add(Closed(null));
    await _state.close();
  }
}

String clientVersionInfoString() {
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
  final major = AppVersionManager.getInstance().major;
  final minor = AppVersionManager.getInstance().minor;
  final patch = AppVersionManager.getInstance().patch;
  return "c${platform}_${major}_${minor}_$patch";
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
    PushNotificationInfo = 7,
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
  final syncVersionPushNotificationInfo =
      await accountBackgroundDb
          .accountStreamSingle((db) => db.loginSession.watchPushNotificationInfoSyncVersion())
          .ok() ??
      forceSync;

  final currentMaintenanceInfo = await db
      .accountStreamSingle((db) => db.common.watchServerMaintenanceInfo())
      .ok();
  final sendMaintenanceSyncVersion = currentMaintenanceInfo?.startTime != null;

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
    7, // Push notification info
    syncVersionPushNotificationInfo,
    if (sendMaintenanceSyncVersion) 255,
    if (sendMaintenanceSyncVersion) 0,
  ];

  return Uint8List.fromList(bytes);
}
