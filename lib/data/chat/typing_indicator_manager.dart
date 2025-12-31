import 'dart:async';

import 'package:app/api/server_connection_manager.dart';
import 'package:app/data/account_repository.dart';
import 'package:app/data/chat/typing_indicator_manager/typing_event_receiving_logic.dart';
import 'package:app/data/chat/typing_indicator_manager/typing_event_sending_logic.dart';
import 'package:openapi/api.dart';

class TypingIndicatorManager {
  final ServerConnectionManager _connectionManager;
  final AccountRepository _accountRepository;

  StreamSubscription<ClientFeaturesConfig>? _configSubscription;
  late final TypingEventSendingLogic _sendingLogic;
  late final TypingEventReceivingLogic _receivingLogic;

  TypingIndicatorManager(this._connectionManager, this._accountRepository) {
    _sendingLogic = TypingEventSendingLogic(_connectionManager);
    _receivingLogic = TypingEventReceivingLogic(_accountRepository.db);

    _configSubscription = _accountRepository.clientFeaturesConfig.listen((config) {
      final typingIndicatorConfig = config.chat?.typingIndicator;
      if (typingIndicatorConfig != null) {
        _sendingLogic.updateConfig(typingIndicatorConfig.minWaitSecondsBetweenRequestsClient, true);
        _receivingLogic.updateConfig(typingIndicatorConfig.startEventTtlSeconds);
      } else {
        _sendingLogic.updateConfig(null, false);
      }
    });
  }

  void handleTypingEvent(AccountId accountId, bool isTyping) {
    _sendingLogic.handleTypingEvent(accountId, isTyping);
  }

  Future<void> dispose() async {
    await _configSubscription?.cancel();
    _sendingLogic.dispose();
    await _receivingLogic.dispose();
  }

  void handleReceivedTypingStart(AccountId accountId) {
    _receivingLogic.handleTypingStart(accountId);
  }

  void handleReceivedTypingStop(AccountId accountId) {
    _receivingLogic.handleTypingStop(accountId);
  }

  Stream<bool> getTypingState(AccountId accountId) {
    return _receivingLogic.getTypingState(accountId);
  }
}
