import 'dart:async';

import 'package:openapi/api.dart';
import 'package:rxdart/rxdart.dart';

class TypingEventReceivingLogic {
  final Map<AccountId, bool> _typingStates = {};
  final Map<AccountId, Timer?> _ttlTimers = {};
  final BehaviorSubject<Map<AccountId, bool>> _typingStateChanges = BehaviorSubject.seeded({});

  Stream<Map<AccountId, bool>> get typingStateChanges => _typingStateChanges;

  int _startEventTtlSeconds = 5; // Default TTL

  void updateConfig(int startEventTtlSeconds) {
    if (startEventTtlSeconds > 0) {
      _startEventTtlSeconds = startEventTtlSeconds;
    }
  }

  void handleTypingStart(AccountId accountId) {
    // Cancel existing timer if any
    _ttlTimers[accountId]?.cancel();

    // Set typing state to true
    _typingStates[accountId] = true;
    _typingStateChanges.add(_typingStates);

    // Start TTL timer to automatically stop typing indicator
    _ttlTimers[accountId] = Timer(Duration(seconds: _startEventTtlSeconds), () {
      _typingStates[accountId] = false;
      _typingStateChanges.add(_typingStates);
      _ttlTimers.remove(accountId);
    });
  }

  void handleTypingStop(AccountId accountId) {
    // Cancel timer
    _ttlTimers[accountId]?.cancel();
    _ttlTimers.remove(accountId);

    // Set typing state to false
    _typingStates[accountId] = false;
    _typingStateChanges.add(_typingStates);
  }

  Stream<bool> getTypingState(AccountId accountId) {
    return _typingStateChanges.map((states) => states[accountId] ?? false);
  }

  Future<void> dispose() async {
    for (final timer in _ttlTimers.values) {
      timer?.cancel();
    }
    _ttlTimers.clear();
    await _typingStateChanges.close();
  }
}
