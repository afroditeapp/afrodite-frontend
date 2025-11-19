import 'dart:async';

import 'package:openapi/api.dart';

enum _TypingEventSendingState { idle, waitTimeOngoing }

class TypingEventSendingLogic {
  final void Function(AccountId, bool) _sendEvent;

  _TypingEventSendingState _state = _TypingEventSendingState.idle;
  Timer? _waitTimer;
  (AccountId, bool)? _latestSentEvent;
  (AccountId, bool)? _latestEvent;
  int _waitTimeSeconds = 2;

  TypingEventSendingLogic(this._sendEvent);

  void updateConfig(int? minWaitSecondsBetweenSendingMessages) {
    _waitTimeSeconds = (minWaitSecondsBetweenSendingMessages ?? 0) + 2;
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
      _sendEvent(latestEvent.$1, latestEvent.$2);
      _latestSentEvent = latestEvent;
    }

    _latestEvent = null;
  }

  void dispose() {
    _waitTimer?.cancel();
    _waitTimer = null;
  }
}
