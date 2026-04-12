import 'dart:async';

import 'package:app/api/server_connection_protocol/server.dart';
import 'package:app/localizations.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:app/data/utils/repository_instances.dart';
import 'package:logging/logging.dart';
import 'package:rxdart/rxdart.dart';
import 'package:utils/utils.dart';

final _log = Logger("EventRouter");

class EventRouter {
  EventRouter({required this.repositories}) {
    for (final type in ServerMessageTypeCode.values) {
      final subject = PublishSubject<ServerMessage>();
      _subjects[type] = subject;
      _subscriptions[type] = subject
          .asyncMap((event) async {
            try {
              await _dispatch(type, event);
            } catch (error, stackTrace) {
              _log.error("Event stream error for $type, error: $error");
              _log.finest(stackTrace);
            }
          })
          .listen(null);
    }
  }

  final RepositoryInstances repositories;
  final Map<ServerMessageTypeCode, PublishSubject<ServerMessage>> _subjects = {};
  final Map<ServerMessageTypeCode, StreamSubscription<void>> _subscriptions = {};

  void route(ServerMessage event) {
    final subject = _subjects[event.type];
    if (subject == null) {
      _log.error("Missing subject for ${event.type}");
      return;
    }
    if (subject.isClosed) {
      _log.error("Subject closed for ${event.type}");
      return;
    }
    subject.add(event);
  }

  Future<void> close() async {
    for (final subscription in _subscriptions.values) {
      await subscription.cancel();
    }
    for (final subject in _subjects.values) {
      await subject.close();
    }
  }

  Future<void> _dispatch(ServerMessageTypeCode type, ServerMessage event) async {
    final chat = repositories.chat;
    final profile = repositories.profile;
    final media = repositories.media;
    final account = repositories.account;

    switch (type) {
      case ServerMessageTypeCode.accountStateChanged:
        await account.receiveAccountState();
      case ServerMessageTypeCode.contentProcessingStateChanged:
        final contentProcessingEvent = event.contentProcessingStateChanged;
        if (contentProcessingEvent != null) {
          account.emitContentProcessingStateChanged(contentProcessingEvent);
        } else {
          _log.error("Missing content processing state for $type");
        }
      case ServerMessageTypeCode.scheduledMaintenanceStatus:
        final maintenanceEvent = event.scheduledMaintenanceStatus;
        if (maintenanceEvent != null) {
          await account.handleServerMaintenanceStatusEvent(maintenanceEvent);
        } else {
          _log.error("Missing maintenance status for $type");
        }
      case ServerMessageTypeCode.receivedLikesChanged:
        await chat.receivedLikesCountRefresh();
      case ServerMessageTypeCode.newMessageReceived:
        await chat.receiveNewMessages();
      case ServerMessageTypeCode.pendingChatNotificationsChanged:
        await chat.receivePendingChatNotifications();
      case ServerMessageTypeCode.pendingAppNotificationsChanged:
        await account.handlePendingAppNotificationsChangedEvent();
      case ServerMessageTypeCode.clientConfigChanged:
        await profile.receiveClientConfig();
      case ServerMessageTypeCode.profileChanged:
        await profile.reloadMyProfile();
      case ServerMessageTypeCode.responseResetProfilePaging:
      case ServerMessageTypeCode.responseNextProfilePage:
      case ServerMessageTypeCode.responseAutomaticProfileSearchResetProfilePaging:
      case ServerMessageTypeCode.responseAutomaticProfileSearchNextProfilePage:
        // WebSocketApiRequestManager handles these
        break;
      case ServerMessageTypeCode.newsCountChanged:
        await account.receiveNewsCount();
      case ServerMessageTypeCode.mediaContentChanged:
        await media.reloadMyMediaContent();
      case ServerMessageTypeCode.dailyLikesLeftChanged:
        await chat.reloadDailyLikesLimit();
      case ServerMessageTypeCode.pushNotificationInfoChanged:
        await repositories.common.receivePushNotificationInfo();
      case ServerMessageTypeCode.adminBotNotification:
        // Ignore event as it's only for admin bot
        break;
      case ServerMessageTypeCode.webSocketConnectionAttemptsRemaining:
        final remaining = event.webSocketConnectionAttemptsRemaining;
        if (remaining != null) {
          showSnackBar(
            R.strings.server_connection_indicator_websocket_attempts_remaining_today(
              remaining.toString(),
            ),
          );
        } else {
          _log.error("Missing remaining websocket attempts for $type");
        }
      case ServerMessageTypeCode.typingStart:
        final typingStart = event.typingStart;
        if (typingStart != null) {
          chat.typingIndicatorManager.handleReceivedTypingStart(typingStart);
        } else {
          _log.error("Missing typing start for $type");
        }
      case ServerMessageTypeCode.typingStop:
        final typingStop = event.typingStop;
        if (typingStop != null) {
          chat.typingIndicatorManager.handleReceivedTypingStop(typingStop);
        } else {
          _log.error("Missing typing stop for $type");
        }
      case ServerMessageTypeCode.onlineStatusUpdated:
        final response = event.checkOnlineStatusResponse;
        if (response != null) {
          await chat.checkOnlineStatusManager.handleCheckOnlineStatusResponse(
            response.a,
            response.l,
          );
        } else {
          _log.error("Missing check online status response for $type");
        }
      case ServerMessageTypeCode.messageDeliveryInfoChanged:
        await chat.receiveMessageDeliveryInfo();
      case ServerMessageTypeCode.latestSeenMessageChanged:
        await chat.receiveLatestSeenMessageInfo();
    }
  }
}
