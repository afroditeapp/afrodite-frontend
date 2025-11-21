import 'dart:async';

import 'package:app/api/server_connection_manager.dart';
import 'package:app/database/account_database_manager.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';

final _log = Logger("CheckOnlineStatusSendingLogic");

enum _CheckOnlineStatusSendingState { idle, waitTimeOngoing }

const _DEFAULT_WAIT_TIME = 1;

class CheckOnlineStatusSendingLogic {
  final ServerConnectionManager _connectionManager;
  final AccountDatabaseManager _accountDb;

  _CheckOnlineStatusSendingState _state = _CheckOnlineStatusSendingState.idle;
  Timer? _waitTimer;
  AccountId? _latestAccountId;
  int _waitTimeSeconds = _DEFAULT_WAIT_TIME;
  bool _checkOnlineStatusEnabled = false;

  CheckOnlineStatusSendingLogic(this._connectionManager, this._accountDb);

  void updateConfig(int? minWaitSecondsBetweenRequestsClient, bool enabled) {
    _waitTimeSeconds = minWaitSecondsBetweenRequestsClient ?? _DEFAULT_WAIT_TIME;
    _checkOnlineStatusEnabled = enabled;
  }

  void handleCheckOnlineStatusRequest(AccountId accountId) {
    if (!_checkOnlineStatusEnabled) {
      return;
    }

    switch (_state) {
      case _CheckOnlineStatusSendingState.idle:
        _sendEventAndClearLatestAccountId(accountId);
        _state = _CheckOnlineStatusSendingState.waitTimeOngoing;
        _waitTimer = Timer(Duration(seconds: _waitTimeSeconds), _onWaitTimeElapsed);
      case _CheckOnlineStatusSendingState.waitTimeOngoing:
        _latestAccountId = accountId;
    }
  }

  void _onWaitTimeElapsed() {
    _waitTimer?.cancel();
    _waitTimer = null;

    final latestAccountId = _latestAccountId;
    if (latestAccountId != null) {
      _sendEventAndClearLatestAccountId(latestAccountId);
      _waitTimer = Timer(Duration(seconds: _waitTimeSeconds), _onWaitTimeElapsed);
    } else {
      _state = _CheckOnlineStatusSendingState.idle;
    }
  }

  void _sendEventAndClearLatestAccountId(AccountId accountId) {
    _sendCheckOnlineStatusEvent(accountId);
    _latestAccountId = null;
  }

  Future<void> _sendCheckOnlineStatusEvent(AccountId accountId) async {
    final isOnline = await _isAccountOnlineInDb(accountId);

    _log.fine("Sending check online status event to ${accountId.aid}, online status: $isOnline");
    final event = EventToServer(a: accountId, o: isOnline, t: EventToServerType.checkOnlineStatus);
    await _connectionManager.sendEventToServer(event);
  }

  Future<bool> _isAccountOnlineInDb(AccountId accountId) async {
    final profileEntryResult = await _accountDb.accountData(
      (db) => db.profile.getProfileEntry(accountId),
    );

    final profileEntry = profileEntryResult.ok();

    // If lastSeenTime is -1, the profile is currently online
    return profileEntry?.lastSeenTimeValue == -1;
  }

  void dispose() {
    _waitTimer?.cancel();
    _waitTimer = null;
  }
}
