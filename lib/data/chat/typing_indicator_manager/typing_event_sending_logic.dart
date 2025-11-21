import 'dart:async';

import 'package:app/api/server_connection_manager.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';

final _log = Logger("TypingEventSendingLogic");

enum _TypingEventSendingState { idle, waitTimeOngoing }

const _DEFAULT_WAIT_TIME = 1;

class TypingEventSendingLogic {
  final ServerConnectionManager _connectionManager;

  _TypingEventSendingState _state = _TypingEventSendingState.idle;
  Timer? _waitTimer;
  (AccountId, bool)? _latestSentEvent;
  (AccountId, bool)? _latestEvent;
  int _waitTimeSeconds = _DEFAULT_WAIT_TIME;
  bool _typingIndicatorEnabled = false;

  TypingEventSendingLogic(this._connectionManager);

  void updateConfig(int? minWaitSecondsBetweenSendingMessages, bool enabled) {
    _waitTimeSeconds = minWaitSecondsBetweenSendingMessages ?? _DEFAULT_WAIT_TIME;
    _typingIndicatorEnabled = enabled;
  }

  void handleTypingEvent(AccountId accountId, bool isTyping) {
    switch (_state) {
      case _TypingEventSendingState.idle:
        _sendEventIfNeeded((accountId, isTyping));
        _state = _TypingEventSendingState.waitTimeOngoing;
        _waitTimer = Timer(Duration(seconds: _waitTimeSeconds), _onWaitTimeElapsed);
      case _TypingEventSendingState.waitTimeOngoing:
        _latestEvent = (accountId, isTyping);
    }
  }

  void _onWaitTimeElapsed() {
    _waitTimer?.cancel();
    _waitTimer = null;

    final latestEvent = _latestEvent;
    if (latestEvent != null) {
      _sendEventIfNeeded(latestEvent);
      _waitTimer = Timer(Duration(seconds: _waitTimeSeconds), _onWaitTimeElapsed);
    } else {
      _state = _TypingEventSendingState.idle;
    }
  }

  void _sendEventIfNeeded((AccountId, bool) latestEvent) {
    if (latestEvent.$1 != _latestSentEvent?.$1 ||
        !(latestEvent.$2 == false && _latestSentEvent?.$2 == false)) {
      _sendTypingEvent(latestEvent.$1, latestEvent.$2);
      _latestSentEvent = latestEvent;
    }

    _latestEvent = null;
  }

  void _sendTypingEvent(AccountId accountId, bool isTyping) {
    if (!_typingIndicatorEnabled) {
      return;
    }

    if (isTyping) {
      _log.fine("Sending typing start event to ${accountId.aid}");
      final event = EventToServer(a: accountId, t: EventToServerType.typingStart);
      _connectionManager.sendEventToServer(event);
    } else {
      _log.fine("Sending typing stop event");
      final event = EventToServer(t: EventToServerType.typingStop);
      _connectionManager.sendEventToServer(event);
    }
  }

  void dispose() {
    _waitTimer?.cancel();
    _waitTimer = null;
  }
}
