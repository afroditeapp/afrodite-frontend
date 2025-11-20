import 'dart:async';

import 'package:app/api/server_connection_manager.dart';
import 'package:app/data/account_repository.dart';
import 'package:app/data/chat/typing_indicator_manager/typing_event_receiving_logic.dart';
import 'package:app/data/chat/typing_indicator_manager/typing_event_sending_logic.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:rxdart/rxdart.dart';

final _log = Logger("TypingIndicatorManager");

class TypingIndicatorManager {
  final ServerConnectionManager _connectionManager;
  final AccountRepository _accountRepository;

  // Relay for typing events from UI
  final PublishSubject<(AccountId, bool)> _typingEventsRelay = PublishSubject();
  PublishSubject<(AccountId, bool)> get typingEventsRelay => _typingEventsRelay;

  StreamSubscription<void>? _typingEventsSubscription;
  StreamSubscription<ClientFeaturesConfig>? _configSubscription;
  late final TypingEventSendingLogic _sendingLogic;
  late final TypingEventReceivingLogic _receivingLogic;
  bool _typingIndicatorEnabled = false;

  TypingIndicatorManager(this._connectionManager, this._accountRepository) {
    _sendingLogic = TypingEventSendingLogic(_sendTypingEvent);
    _receivingLogic = TypingEventReceivingLogic();

    _typingEventsSubscription = _typingEventsRelay.listen((event) {
      final (accountId, isTyping) = event;
      _sendingLogic.handleTypingEvent(accountId, isTyping);
    });

    _configSubscription = _accountRepository.clientFeaturesConfig.listen((config) {
      final typingIndicatorConfig = config.chat?.typingIndicator;
      if (typingIndicatorConfig != null) {
        _typingIndicatorEnabled = true;
        _sendingLogic.updateConfig(typingIndicatorConfig.minWaitSecondsBetweenRequestsClient);
        _receivingLogic.updateConfig(typingIndicatorConfig.startEventTtlSeconds);
      } else {
        _typingIndicatorEnabled = false;
      }
    });
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

  Future<void> dispose() async {
    await _typingEventsSubscription?.cancel();
    await _configSubscription?.cancel();
    _sendingLogic.dispose();
    await _receivingLogic.dispose();
    await _typingEventsRelay.close();
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
