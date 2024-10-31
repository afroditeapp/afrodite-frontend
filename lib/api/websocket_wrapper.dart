
import 'dart:async';
import 'dart:typed_data';

import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

const _CONVERSATION_PING_INTERVAL = Duration(seconds: 10);
const _DEFAULT_PING_INTERVAL = Duration(minutes: 5);

class WebSocketWrapper {
  final WebSocketChannel connection;
  WebSocketWrapper(this.connection);

  bool _closed = false;

  Duration? _extraPingTimerInterval;
  StreamSubscription<void>? _extraPingTimer;

  StreamSubscription<void>? _defaultPingTimer;

  Future<void> close() async {
    if (_closed) {
      return;
    }
    _closed = true;

    final p = _extraPingTimer;
    final p2 = _defaultPingTimer;
    _extraPingTimer = null;
    _defaultPingTimer = null;
    await p?.cancel();
    await p2?.cancel();
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

    if (visiblePage != null && visiblePage.pageInfo is ConversationPageInfo && _extraPingTimerInterval != _CONVERSATION_PING_INTERVAL) {
      await _resetPingLogicForExtraTimer(_CONVERSATION_PING_INTERVAL);
    } else if (_extraPingTimerInterval != null) {
      await _resetPingLogicForExtraTimer(null);
    }

    _defaultPingTimer ??= Stream<void>.periodic(_DEFAULT_PING_INTERVAL, (_) {
      if (!_closed && connection.closeCode == null) {
        connection.sink.add(Uint8List(0)); // Server ignores empty binary messages
      }
    }).listen((_) {});
  }

  /// Null stops the extra timer
  Future<void> _resetPingLogicForExtraTimer(Duration? interval) async {
    final p = _extraPingTimer;
    _extraPingTimer = null;
    await p?.cancel();
    _extraPingTimerInterval = interval;
    if (interval != null) {
      _extraPingTimer = Stream<void>.periodic(interval, (_) {
        if (!_closed && connection.closeCode == null) {
          connection.sink.add(Uint8List(0)); // Server ignores empty binary messages
        }
      }).listen((_) {});
    }
  }
}
