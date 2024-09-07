
import 'dart:async';
import 'dart:typed_data';

import 'package:pihka_frontend/model/freezed/logic/main/navigator_state.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

const _CONVERSATION_PING_INTERVAL = Duration(seconds: 10);
const _DEFAULT_PING_INTERVAL = Duration(minutes: 5);

class WebSocketWrapper {
  final WebSocketChannel connection;
  WebSocketWrapper(this.connection);

  bool _closed = false;
  Duration? _pingInterval;
  StreamSubscription<void>? _pingTimer;

  Future<void> close() async {
    if (_closed) {
      return;
    }
    _closed = true;

    final p = _pingTimer;
    _pingTimer = null;
    await p?.cancel();
    if (connection.closeCode == null) {
      await connection.sink.close();
    }
  }

  /// Start "ping" logic which makes WebSocket to error if server can't receive
  /// the sent binary message.
  Future<void> updatePingInterval(NavigatorStateData navigatorState) async {
    if (_closed) {
      // Connection is closed
      return;
    }

    final visiblePage = navigatorState.pages.lastOrNull;

    if (visiblePage != null && visiblePage.pageInfo is ConversationPageInfo && _pingInterval != _CONVERSATION_PING_INTERVAL) {
      await _resetPingLogic(_CONVERSATION_PING_INTERVAL);
    } else if (_pingInterval != _DEFAULT_PING_INTERVAL) {
      await _resetPingLogic(_DEFAULT_PING_INTERVAL);
    }
  }

  Future<void> _resetPingLogic(Duration interval) async {
    final p = _pingTimer;
    _pingTimer = null;
    await p?.cancel();
    _pingInterval = interval;
    _pingTimer = Stream<void>.periodic(interval, (_) {
      if (!_closed && connection.closeCode == null) {
        connection.sink.add(Uint8List(0)); // Server ignores empty binary messages
      }
    }).listen((_) {});
  }
}
