



import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:app/data/app_version.dart';
import 'package:database/database.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:app/api/api_manager.dart';
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

enum ServerSlot {
  account,
  profile,
  media,
  chat;

  Stream<String?> Function(AccountDatabase) getterForRefreshTokenKey() {
    switch (this) {
      case ServerSlot.account: return (db) => db.daoTokens.watchRefreshTokenAccount();
      case ServerSlot.media: return (db) => db.daoTokens.watchRefreshTokenMedia();
      case ServerSlot.profile: return (db) => db.daoTokens.watchRefreshTokenProfile();
      case ServerSlot.chat: return (db) => db.daoTokens.watchRefreshTokenChat();
    }
  }

  Future<void> Function(AccountDatabase) setterForRefreshTokenKey(String newValue) {
    switch (this) {
      case ServerSlot.account: return (db) => db.daoTokens.updateRefreshTokenAccount(newValue);
      case ServerSlot.media: return (db) => db.daoTokens.updateRefreshTokenMedia(newValue);
      case ServerSlot.profile: return (db) => db.daoTokens.updateRefreshTokenProfile(newValue);
      case ServerSlot.chat: return (db) => db.daoTokens.updateRefreshTokenChat(newValue);
    }
  }

  Stream<String?> Function(AccountDatabase) getterForAccessTokenKey() {
    switch (this) {
      case ServerSlot.account: return (db) => db.daoTokens.watchAccessTokenAccount();
      case ServerSlot.media: return (db) => db.daoTokens.watchAccessTokenMedia();
      case ServerSlot.profile: return (db) => db.daoTokens.watchAccessTokenProfile();
      case ServerSlot.chat: return (db) => db.daoTokens.watchAccessTokenChat();
    }
  }

  Future<void> Function(AccountDatabase) setterForAccessTokenKey(String newValue) {
    switch (this) {
      case ServerSlot.account: return (db) => db.daoTokens.updateAccessTokenAccount(newValue);
      case ServerSlot.media: return (db) => db.daoTokens.updateAccessTokenMedia(newValue);
      case ServerSlot.profile: return (db) => db.daoTokens.updateAccessTokenProfile(newValue);
      case ServerSlot.chat: return (db) => db.daoTokens.updateAccessTokenChat(newValue);
    }
  }
}

enum ServerConnectionError {
  /// Invalid token, so new login required.
  invalidToken,
  /// Server unreachable, server connection broke or protocol error.
  connectionFailure,
  /// Unsupported client version.
  unsupportedClientVersion,
}

sealed class ServerConnectionState {}
/// No connection. Initial and after closing state.
class ReadyToConnect implements ServerConnectionState {
  @override
  bool operator ==(Object other) {
    return other is ReadyToConnect;
  }

  @override
  int get hashCode => runtimeType.hashCode;
}
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
  @override
  bool operator ==(Object other) {
    return other is Ready;
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

/// No connection. Connection ended in error.
class Error implements ServerConnectionState {
  final ServerConnectionError error;
  Error(this.error);

  @override
  String toString() {
    return "Error: $error";
  }

  @override
  bool operator ==(Object other) {
    return (other is Error && error == other.error);
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

class ServerConnection {
  final ServerSlot _server;
  String _address;
  final AccountDatabaseManager db;
  final AccountBackgroundDatabaseManager accountBackgroundDb;

  WebSocketWrapper? _connection;

  final BehaviorSubject<ServerConnectionState> _state =
    BehaviorSubject.seeded(ReadyToConnect());
  final PublishSubject<ServerWsEvent> _events =
    PublishSubject();

  Stream<ServerConnectionState> get state => _state;
  Stream<ServerWsEvent> get serverEvents => _events;

  StreamSubscription<NavigatorStateData>? _navigationSubscription;

  bool _startInProgress = false;

  ServerConnection(this._server, this._address, this.db, this.accountBackgroundDb);

  /// Starts new connection if it does not already exists.
  Future<void> start() async {
    if (_startInProgress) {
      log.warning("Connection start already in progress");
      return;
    }
    _startInProgress = true;

    await close();
    await _state.firstWhere((v) => _state.value is ReadyToConnect || _state.value is Error);
    // Connection is now closed

    _state.add(Connecting());
    unawaited(_connect().then((value) => null)); // Connect in background.

    _navigationSubscription ??= NavigationStateBlocInstance.getInstance().navigationStateStream.listen((navigationState) {
      final ws = _connection;
      if (ws != null) {
        ws.updatePingInterval(navigationState);
      }
    });

    _startInProgress = false;
  }

  Future<void> _connect() async {
    log.info("Starting to connect");

    var protocolState = ConnectionProtocolState.receiveFirstMessage;

    final accessToken = await db.accountStreamSingle(_server.getterForAccessTokenKey()).ok();
    if (accessToken == null) {
      _state.add(Error(ServerConnectionError.invalidToken));
      return;
    }
    final refreshToken = await db.accountStreamSingle(_server.getterForRefreshTokenKey()).ok();
    if (refreshToken == null) {
      _state.add(Error(ServerConnectionError.invalidToken));
      return;
    }

    final WebSocketWrapper ws;
    if (kIsWeb) {
      if (!_address.startsWith("http")) {
        throw UnsupportedError("Unsupported URI scheme");
      }
      final wsAddress = Uri.parse(_address.replaceFirst("http", "ws"));
      try {
        ws = WebSocketWrapper(WebSocketChannel.connect(wsAddress, protocols: ["0", accessToken]));
        _connection = ws;
      } catch (e) {
        log.error("Server connection: WebScocket connecting exception");
        log.fine(e);
        _state.add(Error(ServerConnectionError.connectionFailure));
        return;
      }
    } else {
      final r = Random.secure();
      final bytes = List<int>.generate(16, (_) => r.nextInt(255));
      final key = base64.encode(bytes);

      final client = IOClient(HttpClient(context: await createSecurityContextForBackendConnection()));
      final headers = {
        HttpHeaders.connectionHeader: "upgrade",
        HttpHeaders.upgradeHeader: "websocket",
        "sec-websocket-version": "13",
        "sec-websocket-key": key,
        "sec-websocket-protocol": "0,$accessToken",
      };
      final request = Request("GET", Uri.parse(_address));
      request.headers.addAll(headers);

      final IOStreamedResponse response;
      try {
        response = await client.send(request);
      } on ClientException catch (e) {
        log.error("Server connection: client exception");
        log.fine(e);
        _state.add(Error(ServerConnectionError.connectionFailure));
        return;
      } on HandshakeException catch (e) {
        log.error("Server connection: handshake exception");
        log.fine(e);
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
      ws = WebSocketWrapper(IOWebSocketChannel(webSocket));
      _connection = ws;
    }

    // Client starts the messaging
    ws.connection.sink.add(clientVersionInfoBytes());

    Future<void> handleConnectionIsReadyForDataSync() async {
      ws.connection.sink.add(await syncDataBytes(db, accountBackgroundDb));
      protocolState = ConnectionProtocolState.receiveEvents;
      log.info("Connection ready");
      _state.add(Ready());
      await ws.updatePingInterval(NavigationStateBlocInstance.getInstance().navigationState);
    }

    ws
      .connection
      .stream
      .asyncMap((message) async {
        switch (protocolState) {
          case ConnectionProtocolState.receiveFirstMessage: {
            if (message is List<int>) {
              switch (message) {
                case [0]:
                  await handleConnectionIsReadyForDataSync();
                case [1]:
                  final byteToken = base64Decode(refreshToken);
                  ws.connection.sink.add(byteToken);
                  protocolState = ConnectionProtocolState.receiveNewRefreshToken;
                case [2]:
                  await _endConnectionToGeneralError(error: ServerConnectionError.unsupportedClientVersion);
                default:
                  await _endConnectionToGeneralError();
              }
              final newRefreshToken = base64Encode(message);
              await db.accountAction(_server.setterForRefreshTokenKey(newRefreshToken));

            } else {
              await _endConnectionToGeneralError();
            }
          }
          case ConnectionProtocolState.receiveNewRefreshToken: {
            if (message is List<int>) {
              final newRefreshToken = base64Encode(message);
              await db.accountAction(_server.setterForRefreshTokenKey(newRefreshToken));
              protocolState = ConnectionProtocolState.receiveNewAccessToken;
            } else {
              await _endConnectionToGeneralError();
            }
          }
          case ConnectionProtocolState.receiveNewAccessToken: {
            if (message is List<int>) {
              final newAccessToken = base64Url
                .encode(message)
                .replaceAll("=", "");
              await db.accountAction(_server.setterForAccessTokenKey(newAccessToken));
              await handleConnectionIsReadyForDataSync();
            } else {
              await _endConnectionToGeneralError();
            }
          }
          case ConnectionProtocolState.receiveEvents: {
            if (message is String) {
              final event = EventToClient.fromJson(jsonDecode(message));
              if (event != null) {
                _events.add(EventToClientContainer(event));
              }
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
          if (_connection == null) {
            // Client closed the connection.
            return;
          }

          if (ws.connection.closeCode != null &&
            ws.connection.closeCode == status.internalServerError) {
            log.error("Invalid token");
            _state.add(Error(ServerConnectionError.invalidToken));
          } else {
            log.error("Connection closed");
            _state.add(Error(ServerConnectionError.connectionFailure));
          }
          ws.close();
          _connection = null;
        },
        cancelOnError: true,
      );
  }

  Future<void> _endConnectionToGeneralError({ServerConnectionError error = ServerConnectionError.connectionFailure}) async {
    // Nullify connection to make sure that onDone is called when
    // _connection is null. This order seems not required but, this style
    // feels safer.
    final c = _connection;
    _connection = null;
    if (c != null)  {
      await c.close();
      _state.add(Error(error));
    }
  }

  Future<void> close({bool logoutClose = false}) async {
    // Nullify connection to make sure that onDone is called when
    // _connection is null. This order seems not required but, this style
    // feels safer.
    final c = _connection;
    _connection = null;
    await c?.close();
    // Run this even if null to make sure that state is overriden
    if (logoutClose) {
      _state.add(Error(ServerConnectionError.invalidToken));
    } else {
      _state.add(ReadyToConnect());
    }
  }

  /// Just close connection and do not send events.
  Future<void> dispose() async {
    // Nullify connection to make sure that onDone is called when
    // _connection is null. This order seems not required but, this style
    // feels safer.
    final c = _connection;
    _connection = null;
    await c?.close();
  }

  void setAddress(String address) {
    _address = address;
  }

  bool inUse() {
    return !(_state.value is ReadyToConnect || _state.value is Error);
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

// TODO(prod): Implement sync data version handling

Future<Uint8List> syncDataBytes(AccountDatabaseManager db, AccountBackgroundDatabaseManager accountBackgroundDb) async {
  final syncVersionAccount = await db.accountStreamSingle(
    (db) => db.daoSyncVersions.watchSyncVersionAccount()
  ).ok() ?? forceSync;
  final syncVersionReceivedLikes = await accountBackgroundDb.accountStreamSingle(
    (db) => db.daoNewReceivedLikesAvailable.watchSyncVersionReceivedLikes()
  ).ok() ?? forceSync;
  final syncVersionClientConfig = await db.accountStreamSingle(
    (db) => db.daoSyncVersions.watchSyncVersionClientConfig()
  ).ok() ?? forceSync;
  final syncVersionProfile = await db.accountStreamSingle(
    (db) => db.daoSyncVersions.watchSyncVersionProfile()
  ).ok() ?? forceSync;
  final syncVersionNews = await accountBackgroundDb.accountStreamSingle(
    (db) => db.daoNews.watchSyncVersionNews()
  ).ok() ?? forceSync;
  final syncVersionMediaContent = await db.accountStreamSingle(
    (db) => db.daoSyncVersions.watchSyncVersionMediaContent()
  ).ok() ?? forceSync;
  final syncVersionDailyLikesLeft = await db.accountStreamSingle(
    (db) => db.daoLimits.watchDailyLikesLeftSyncVersion()
  ).ok() ?? forceSync;

  final currentMaintenanceInfo = await db.accountStreamSingle(
    (db) => db.daoServerMaintenance.watchServerMaintenanceInfo()
  ).ok();
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
