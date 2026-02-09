import 'dart:async';

import 'package:app/data/utils/repository_instances.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:rxdart/rxdart.dart';
import 'package:utils/utils.dart';

final _log = Logger("EventRouter");

class EventRouter {
  EventRouter({required this.repositories}) {
    for (final type in EventType.values) {
      final subject = PublishSubject<EventToClient>();
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
  final Map<EventType, PublishSubject<EventToClient>> _subjects = {};
  final Map<EventType, StreamSubscription<void>> _subscriptions = {};

  void route(EventToClient event) {
    final subject = _subjects[event.event];
    if (subject == null) {
      _log.error("Missing subject for ${event.event}");
      return;
    }
    if (subject.isClosed) {
      _log.error("Subject closed for ${event.event}");
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

  Future<void> _dispatch(EventType type, EventToClient event) async {
    final chat = repositories.chat;
    final profile = repositories.profile;
    final media = repositories.media;
    final account = repositories.account;

    switch (type) {
      case EventType.accountStateChanged:
        await account.receiveAccountState();
      case EventType.contentProcessingStateChanged:
        final contentProcessingEvent = event.contentProcessingStateChanged;
        if (contentProcessingEvent != null) {
          account.emitContentProcessingStateChanged(contentProcessingEvent);
        } else {
          _log.error("Missing content processing state for $type");
        }
      case EventType.scheduledMaintenanceStatus:
        final maintenanceEvent = event.scheduledMaintenanceStatus;
        if (maintenanceEvent != null) {
          await account.handleServerMaintenanceStatusEvent(maintenanceEvent);
        } else {
          _log.error("Missing maintenance status for $type");
        }
      case EventType.receivedLikesChanged:
        await chat.receivedLikesCountRefresh();
      case EventType.newMessageReceived:
        await chat.receiveNewMessages();
      case EventType.clientConfigChanged:
        await profile.receiveClientConfig();
      case EventType.profileChanged:
        await profile.reloadMyProfile();
      case EventType.newsCountChanged:
        await account.receiveNewsCount();
      case EventType.mediaContentModerationCompleted:
        await media.handleMediaContentModerationCompletedEvent();
      case EventType.profileStringModerationCompleted:
        await profile.handleProfileStringModerationCompletedEvent();
      case EventType.automaticProfileSearchCompleted:
        await profile.handleAutomaticProfileSearchCompletedEvent();
      case EventType.mediaContentChanged:
        await media.reloadMyMediaContent();
      case EventType.dailyLikesLeftChanged:
        await chat.reloadDailyLikesLimit();
      case EventType.pushNotificationInfoChanged:
        await repositories.common.receivePushNotificationInfo();
      case EventType.adminNotification:
        await account.receiveAdminNotification();
      case EventType.typingStart:
        final typingStart = event.typingStart;
        if (typingStart != null) {
          chat.typingIndicatorManager.handleReceivedTypingStart(typingStart);
        } else {
          _log.error("Missing typing start for $type");
        }
      case EventType.typingStop:
        final typingStop = event.typingStop;
        if (typingStop != null) {
          chat.typingIndicatorManager.handleReceivedTypingStop(typingStop);
        } else {
          _log.error("Missing typing stop for $type");
        }
      case EventType.checkOnlineStatusResponse:
        final response = event.checkOnlineStatusResponse;
        if (response != null) {
          await chat.checkOnlineStatusManager.handleCheckOnlineStatusResponse(
            response.a,
            response.l,
          );
        } else {
          _log.error("Missing check online status response for $type");
        }
      case EventType.messageDeliveryInfoChanged:
        await chat.receiveMessageDeliveryInfo();
      default:
        _log.error("Unknown EventToClient type: $type");
    }
  }
}
