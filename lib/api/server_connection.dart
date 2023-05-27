



import 'dart:convert';

import 'package:pihka_frontend/api/api_manager.dart';
import 'package:pihka_frontend/api/api_provider.dart';
import 'package:pihka_frontend/storage/kv.dart';
import 'package:rxdart/rxdart.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

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
  invalidTokenSent,
  /// Server unreachable, server connection broke or protocol error.
  connectionFailure,
}

sealed class ServerConnectionState {}
/// Initial state.
class ReadyToConnect implements ServerConnectionState {}
/// Connecting to server or getting new tokens.
class Connecting implements ServerConnectionState {}
/// New tokens received and event listening started.
class Ready implements ServerConnectionState {}
class Error implements ServerConnectionState {
  final ServerConnectionError error;
  Error(this.error);
}
class ManuallyClosed implements ServerConnectionState {}


// sealed class ServerConnectionEvent {}
// class NewRefreshToken implements ServerConnectionEvent {
//   final String newRefreshToken;
//   NewRefreshToken(this.newRefreshToken);
// }
// class NewAccessToken implements ServerConnectionEvent {
//   final String newAccessToken;
//   NewAccessToken(this.newAccessToken);
// }
// class EventFromServerTodo implements ServerConnectionEvent {}

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
  void start() {
    if (_state.value is ReadyToConnect || _state.value is Error) {
      return;
    }
    _protocolState = ConnectionProtocolState.receiveNewRefreshToken;
    _state.add(Connecting());
    _connect().then((value) => {});
  }

  Future<void> _connect() async {
    final storage = KvStorageManager.getInstance();

    final accessToken = await storage.getString(_server.toAccessTokenKey());
    if (accessToken == null) {
      return;
    }
    final refreshToken = await storage.getString(_server.toRefreshTokenKey());
    if (refreshToken == null) {
      return;
    }

    final ws = IOWebSocketChannel.connect(
      _address,
      headers: { accessTokenHeaderName: accessToken },
    );
    _connection = ws;

    // Client starts the messaging
    final byteToken = base64Decode(refreshToken);
    ws.sink.add(byteToken);

    ws
      .stream
      .doOnDone(() {
        if (_connection == null) {
          // Expected disconnect
          return;
        }

        if (ws.closeCode != null &&
          ws.closeCode == status.internalServerError) {
          _state.add(Error(ServerConnectionError.invalidTokenSent));
        } else {
          _state.add(Error(ServerConnectionError.connectionFailure));
        }
        _connection = null;
      })
      .doOnError((errorException, _) {
        print(errorException);
        _state.add(Error(ServerConnectionError.connectionFailure));
        _connection = null;
      })
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
      .listen(null);
  }

  // void _sendEvent(Sink<ApiManagerEvent> events, ServerConnectionEvent event) {
  //   events.add(EventFromConnection(server, event));
  // }

  Future<void> _endConnectionToGeneralError() async {
    _connection = null;
    await _connection?.sink.close(status.goingAway);
    _state.add(Error(ServerConnectionError.connectionFailure));
  }

  Future<void> close() async {
    _connection = null;
    await _connection?.sink.close(status.goingAway);
    _state.add(ManuallyClosed());
  }

  void setAddress(String address) {
    _address = address;
  }

  bool inUse() {
    return _state.value is! ReadyToConnect;
  }
}
