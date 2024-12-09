

import 'dart:convert';

import 'package:database/database.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:app/data/general/notification/utils/notification_id.dart';
import 'package:utils/utils.dart';

final log = Logger("NotificationPayload");

@immutable
sealed class NotificationPayload extends Immutable {
  final NotificationPayloadTypeString payloadType;
  final NotificationSessionId sessionId;
  const NotificationPayload({
    required this.payloadType,
    required this.sessionId,
  });

  Map<String, Object?> additionalData() {
    return {};
  }

  static const String _payloadTypeKey = "payloadType";
  static const String _notificationSessionIdKey = "notificationSessionId";

  String toJson() {
    final Map<String, Object?> map = {};
    map.addEntries(additionalData().entries);
    map[_payloadTypeKey] = payloadType.value;
    map[_notificationSessionIdKey] = sessionId.id;
    return jsonEncode(map);
  }

  static NotificationPayload? parse(
    String jsonPayload,
  ) {

    final jsonObject = jsonDecode(jsonPayload);
    if (jsonObject is! Map<String, Object?>) {
      log.error("Payload is not JSON object");
      return null;
    }

    if (!jsonObject.containsKey(_payloadTypeKey)) {
      log.error("Payload type is missing from the payload");
      return null;
    }
    final payloadTypeValue = jsonObject[_payloadTypeKey];
    if (payloadTypeValue is! String) {
      log.error("Payload type is not a string");
      return null;
    }

    if (!jsonObject.containsKey(_notificationSessionIdKey)) {
      log.error("Notification session ID is missing from the payload");
      return null;
    }
    final sessionIdValue = jsonObject[_notificationSessionIdKey];
    if (sessionIdValue is! int) {
      log.error("Notification session ID is not an integer");
      return null;
    }
    final sessionId = NotificationSessionId(id: sessionIdValue);

    switch (payloadTypeValue) {
      case NotificationPayloadTypeString.stringNavigateToLikes:
        return NavigateToLikes(sessionId: sessionId);
      case NotificationPayloadTypeString.stringNavigateToNews:
        return NavigateToNews(sessionId: sessionId);
      case NotificationPayloadTypeString.stringNavigateToConversationList:
        return NavigateToConversationList(sessionId: sessionId);
      case NotificationPayloadTypeString.stringNavigateToConversation:
        return NavigateToConversation.parseFromJsonObject(jsonObject, sessionId);
      case NotificationPayloadTypeString.stringNavigateToContentManagement:
        return NavigateToContentManagement(sessionId: sessionId);
      default:
        log.error("Payload type is unknown");
        return null;
    }
  }
}

class NavigateToLikes extends NotificationPayload {
  const NavigateToLikes({
    required NotificationSessionId sessionId
  }) : super(
    payloadType: NotificationPayloadTypeString.navigateToLikes,
    sessionId: sessionId,
  );
}

class NavigateToNews extends NotificationPayload {
  const NavigateToNews({
    required NotificationSessionId sessionId
  }) : super(
    payloadType: NotificationPayloadTypeString.navigateToNews,
    sessionId: sessionId,
  );
}

class NavigateToConversationList extends NotificationPayload {
  const NavigateToConversationList({
    required NotificationSessionId sessionId
  }) : super(
    payloadType: NotificationPayloadTypeString.navigateToConversationList,
    sessionId: sessionId,
  );
}

class NavigateToConversation extends NotificationPayload {
  final NotificationId notificationId;

  const NavigateToConversation({
    required this.notificationId,
    required NotificationSessionId sessionId,
  }) : super(
    payloadType: NotificationPayloadTypeString.navigateToConversation,
    sessionId: sessionId,
  );

  static const String _notificationIdKey = "notificationId";
  static NotificationPayload? parseFromJsonObject(Map<String, Object?> jsonObject, NotificationSessionId sessionId) {
    if (!jsonObject.containsKey(_notificationIdKey)) {
      log.error("NavigateToConversation payload parsing error: notification ID is missing");
      return null;
    }
    final id = jsonObject[_notificationIdKey];
    if (id is! int) {
      log.error("NavigateToConversation payload parsing error: notification ID is not an integer");
      return null;
    }
    return NavigateToConversation(
      notificationId: NotificationId(id),
      sessionId: sessionId,
    );
  }

  @override
  Map<String, Object?> additionalData() => {
    _notificationIdKey: notificationId.value,
  };
}

class NavigateToContentManagement extends NotificationPayload {
  const NavigateToContentManagement({
    required NotificationSessionId sessionId,
  }) : super(
    payloadType: NotificationPayloadTypeString.navigateToContentManagement,
    sessionId: sessionId,
  );
}

enum NotificationPayloadTypeString {
  navigateToLikes(value: stringNavigateToLikes),
  navigateToNews(value: stringNavigateToNews),
  navigateToConversation(value: stringNavigateToConversation),
  navigateToConversationList(value: stringNavigateToConversationList),
  navigateToContentManagement(value: stringNavigateToContentManagement);

  final String value;
  const NotificationPayloadTypeString({
    required this.value,
  });

  static const String stringNavigateToLikes = "navigate_to_likes";
  static const String stringNavigateToNews = "navigate_to_news";
  static const String stringNavigateToConversation = "navigate_to_conversation";
  static const String stringNavigateToConversationList = "navigate_to_conversation_list";
  static const String stringNavigateToContentManagement = "navigate_to_content_management";
}
