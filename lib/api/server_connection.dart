



import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:database/database.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/api/api_manager.dart';
import 'package:pihka_frontend/api/api_provider.dart';
import 'package:pihka_frontend/assets.dart';
import 'package:pihka_frontend/database/account_database_manager.dart';
import 'package:pihka_frontend/logic/app/navigator_state.dart';
import 'package:pihka_frontend/model/freezed/logic/main/navigator_state.dart';
import 'package:pihka_frontend/utils.dart';
import 'package:pihka_frontend/utils/result.dart';
import 'package:rxdart/rxdart.dart';
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
  receiveNewRefreshToken,
  receiveNewAccessToken,
  receiveEvents,
}

class ServerConnection {
  final ServerSlot _server;
  String _address;
  final AccountDatabaseManager db;

  WebSocket? _connection;

  final BehaviorSubject<ServerConnectionState> _state =
    BehaviorSubject.seeded(ReadyToConnect());
  final PublishSubject<ServerWsEvent> _events =
    PublishSubject();

  Stream<ServerConnectionState> get state => _state;
  Stream<ServerWsEvent> get serverEvents => _events;

  StreamSubscription<NavigatorStateData>? _navigationSubscription;

  bool _startInProgress = false;

  ServerConnection(this._server, this._address, this.db);

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

    _navigationSubscription ??= NavigationStateBlocInstance.getInstance().bloc.stream.listen((navigationState) {
      final ws = _connection;
      if (ws != null) {
        updatePingInterval(ws, navigationState);
      }
    });

    _startInProgress = false;
  }

  Future<void> _connect() async {
    log.info("Starting to connect");

    var protocolState = ConnectionProtocolState.receiveNewRefreshToken;

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

    final r = Random.secure();
    final bytes = List<int>.generate(16, (_) => r.nextInt(255));
    final key = base64.encode(bytes);

    final client = IOClient(HttpClient(context: await createSecurityContextForBackendConnection()));
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
    _connection = webSocket;
    updatePingInterval(webSocket, NavigationStateBlocInstance.getInstance().bloc.state);
    final IOWebSocketChannel ws = IOWebSocketChannel(webSocket);

    // Client starts the messaging
    ws.sink.add(clientVersionInfoBytes());
    final byteToken = base64Decode(refreshToken);
    ws.sink.add(byteToken);

    ws
      .stream
      .asyncMap((message) async {
        switch (protocolState) {
          case ConnectionProtocolState.receiveNewRefreshToken: {
            if (message is List<int>) {
              final newRefreshToken = base64Encode(message);
              await db.accountAction(_server.setterForRefreshTokenKey(newRefreshToken));
              protocolState = ConnectionProtocolState.receiveNewAccessToken;
            } else if (message is String) {
              await _endConnectionToGeneralError(error: ServerConnectionError.unsupportedClientVersion);
            } else {
              await _endConnectionToGeneralError();
            }
          }
          case ConnectionProtocolState.receiveNewAccessToken: {
            if (message is String) {
              await db.accountAction(_server.setterForAccessTokenKey(message));
              ws.sink.add(await syncDataBytes(db));
              protocolState = ConnectionProtocolState.receiveEvents;
              log.info("Connection ready");
              _state.add(Ready());
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

          if (ws.closeCode != null &&
            ws.closeCode == status.internalServerError) {
            log.error("Invalid token");
            _state.add(Error(ServerConnectionError.invalidToken));
          } else {
            log.error("Connection closed");
            _state.add(Error(ServerConnectionError.connectionFailure));
          }
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
      await c.close(status.goingAway);
      _state.add(Error(error));
    }
  }

  Future<void> close({bool logoutClose = false}) async {
    // Nullify connection to make sure that onDone is called when
    // _connection is null. This order seems not required but, this style
    // feels safer.
    final c = _connection;
    _connection = null;
    await c?.close(status.goingAway);
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
    await c?.close(status.goingAway);
  }

  void setAddress(String address) {
    _address = address;
  }

  bool inUse() {
    return !(_state.value is ReadyToConnect || _state.value is Error);
  }

  void updatePingInterval(WebSocket ws, NavigatorStateData navigatorState) {
    final visiblePage = navigatorState.pages.lastOrNull;
    const CONVERSATION_PING_INTERVAL = Duration(seconds: 10);
    const DEFAULT_PING_INTERVAL = Duration(minutes: 5);
    if (visiblePage != null && visiblePage.pageInfo is ConversationPageInfo && ws.pingInterval != CONVERSATION_PING_INTERVAL) {
      ws.pingInterval = CONVERSATION_PING_INTERVAL;
    } else if (ws.pingInterval != DEFAULT_PING_INTERVAL) {
      ws.pingInterval = DEFAULT_PING_INTERVAL;
    }
  }
}

Uint8List clientVersionInfoBytes() {
  const protocolVersion = 0;
  final int platform;
  if (Platform.isAndroid) {
    platform = 0;
  } else if (Platform.isIOS) {
    platform = 1;
  } else {
    throw UnimplementedError("Platform not supported");
  }
  final protocolBytes = <int>[protocolVersion, platform];
  const major = 0;
  const minor = 0;
  const patch = 0;
  protocolBytes.addAll(u16VersionToLittleEndianBytes(major));
  protocolBytes.addAll(u16VersionToLittleEndianBytes(minor));
  protocolBytes.addAll(u16VersionToLittleEndianBytes(patch));
  return Uint8List.fromList(protocolBytes);
}

Uint8List u16VersionToLittleEndianBytes(int version) {
  final buffer = ByteData(2);
  if (version < 0 || version > 0xFFFF) {
    throw ArgumentError("Version must be 16 bit integer");
  }
  buffer.setInt16(0, version, Endian.little);
  return buffer.buffer.asUint8List();
}

const forceSync = 255;
/*
    Account = 0,
    ReveivedLikes = 1,
    ReveivedBlocks = 2,
    SentLikes = 3,
    SentBlocks = 4,
    Matches = 5,
    AvailableProfileAttributes = 6,
    Profile = 7,
*/

// TODO(prod): Implement sync data version handling

Future<Uint8List> syncDataBytes(AccountDatabaseManager db) async {
  final syncVersionAccount = await db.accountStreamSingle(
    (db) => db.daoSyncVersions.watchSyncVersionAccount()
  ).ok() ?? forceSync;
  final syncVersionReceivedLikes = await db.accountStreamSingle(
    (db) => db.daoSyncVersions.watchSyncVersionReceivedLikes()
  ).ok() ?? forceSync;
  final syncVersionReceivedBlocks = await db.accountStreamSingle(
    (db) => db.daoSyncVersions.watchSyncVersionReceivedBlocks()
  ).ok() ?? forceSync;
  final syncVersionSentLikes = await db.accountStreamSingle(
    (db) => db.daoSyncVersions.watchSyncVersionSentLikes()
  ).ok() ?? forceSync;
  final syncVersionSentBlocks = await db.accountStreamSingle(
    (db) => db.daoSyncVersions.watchSyncVersionSentBlocks()
  ).ok() ?? forceSync;
  final syncVersionMatches = await db.accountStreamSingle(
    (db) => db.daoSyncVersions.watchSyncVersionMatches()
  ).ok() ?? forceSync;
  final syncVersionAvailableProfileAttributes = await db.accountStreamSingle(
    (db) => db.daoSyncVersions.watchSyncVersionAvailableProfileAttributes()
  ).ok() ?? forceSync;
  final syncVersionProfile = await db.accountStreamSingle(
    (db) => db.daoSyncVersions.watchSyncVersionProfile()
  ).ok() ?? forceSync;

  final bytes = <int>[
    0, // Account
    syncVersionAccount,
    1, // ReveivedLikes
    syncVersionReceivedLikes,
    2, // ReveivedBlocks
    syncVersionReceivedBlocks,
    3, // SentLikes
    syncVersionSentLikes,
    4, // SentBlocks
    syncVersionSentBlocks,
    5, // Matches
    syncVersionMatches,
    6, // AvailableProfileAttributes
    syncVersionAvailableProfileAttributes,
    7, // Profile
    syncVersionProfile,
  ];

  return Uint8List.fromList(bytes);
}
