import 'dart:async';

import 'package:app/data/account_repository.dart';
import 'package:app/data/chat/check_online_status_manager/check_online_status_sending_logic.dart';
import 'package:app/database/account_database_manager.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:app/api/server_connection_manager.dart';

final _log = Logger("CheckOnlineStatusManager");

class CheckOnlineStatusManager {
  final AccountDatabaseManager _accountDb;

  StreamSubscription<ClientFeaturesConfig>? _configSubscription;
  late final CheckOnlineStatusSendingLogic _sendingLogic;

  CheckOnlineStatusManager(
    ServerConnectionManager connectionManager,
    AccountRepository accountRepository,
    this._accountDb,
  ) {
    _sendingLogic = CheckOnlineStatusSendingLogic(connectionManager, _accountDb);

    _configSubscription = accountRepository.clientFeaturesConfig.listen((config) {
      final checkOnlineStatusConfig = config.chat?.checkOnlineStatus;
      if (checkOnlineStatusConfig != null) {
        _sendingLogic.updateConfig(
          checkOnlineStatusConfig.minWaitSecondsBetweenRequestsClient,
          true,
        );
      } else {
        _sendingLogic.updateConfig(null, false);
      }
    });
  }

  void handleCheckOnlineStatusRequest(AccountId accountId) {
    _sendingLogic.handleCheckOnlineStatusRequest(accountId);
  }

  Future<void> dispose() async {
    await _configSubscription?.cancel();
    _sendingLogic.dispose();
  }

  Future<void> handleCheckOnlineStatusResponse(AccountId accountId, int lastSeenTime) async {
    _log.fine(
      "Received check online status response for ${accountId.aid}, last seen time: $lastSeenTime",
    );
    await _accountDb.accountAction(
      (db) => db.profile.updateProfileLastSeenTimeIfNeeded(accountId, lastSeenTime),
    );
  }
}
