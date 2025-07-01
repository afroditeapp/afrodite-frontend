

import 'dart:convert';

import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:app/data/general/notification/utils/notification_id.dart';
import 'package:openapi/api.dart';
import 'package:utils/utils.dart';

final log = Logger("NotificationPayload");

@immutable
sealed class NotificationPayload extends Immutable {
  final NotificationPayloadTypeString payloadType;
  final AccountId receiverAccountId;
  const NotificationPayload({
    required this.payloadType,
    required this.receiverAccountId,
  });

  Map<String, Object?> additionalData() {
    return {};
  }

  static const String _payloadTypeKey = "t";
  static const String _receiverAccountId = "r";

  String toJson() {
    final Map<String, Object?> map = {};
    map.addEntries(additionalData().entries);
    map[_payloadTypeKey] = payloadType.value;
    map[_receiverAccountId] = receiverAccountId.aid;
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

    if (!jsonObject.containsKey(_receiverAccountId)) {
      log.error("Notification session ID is missing from the payload");
      return null;
    }
    final receiverAccountIdString = jsonObject[_receiverAccountId];
    if (receiverAccountIdString is! String) {
      log.error("Receiver Account ID is not a string");
      return null;
    }

    final AccountId receiverAccountId = AccountId(aid: receiverAccountIdString);

    switch (payloadTypeValue) {
      case NotificationPayloadTypeString.stringNavigateToLikes:
        return NavigateToLikes(receiverAccountId: receiverAccountId);
      case NotificationPayloadTypeString.stringNavigateToNews:
        return NavigateToNews(receiverAccountId: receiverAccountId);
      case NotificationPayloadTypeString.stringNavigateToConversationList:
        return NavigateToConversationList(receiverAccountId: receiverAccountId);
      case NotificationPayloadTypeString.stringNavigateToConversation:
        return NavigateToConversation.parseFromJsonObject(jsonObject, receiverAccountId);
      case NotificationPayloadTypeString.stringNavigateToContentManagement:
        return NavigateToContentManagement(receiverAccountId: receiverAccountId);
      case NotificationPayloadTypeString.stringNavigateToMyProfile:
        return NavigateToMyProfile(receiverAccountId: receiverAccountId);
      case NotificationPayloadTypeString.stringNavigateToAutomaticProfileSearchResults:
        return NavigateToAutomaticProfileSearchResults(receiverAccountId: receiverAccountId);
      case NotificationPayloadTypeString.stringNavigateToModeratorTasks:
        return NavigateToModeratorTasks(receiverAccountId: receiverAccountId);
      default:
        log.error("Payload type is unknown");
        return null;
    }
  }
}

class NavigateToLikes extends NotificationPayload {
  const NavigateToLikes({
    required super.receiverAccountId,
  }) : super(
    payloadType: NotificationPayloadTypeString.navigateToLikes,
  );
}

class NavigateToNews extends NotificationPayload {
  const NavigateToNews({
    required super.receiverAccountId,
  }) : super(
    payloadType: NotificationPayloadTypeString.navigateToNews,
  );
}

class NavigateToConversationList extends NotificationPayload {
  const NavigateToConversationList({
    required super.receiverAccountId,
  }) : super(
    payloadType: NotificationPayloadTypeString.navigateToConversationList,
  );
}

class NavigateToConversation extends NotificationPayload {
  final NotificationId notificationId;

  const NavigateToConversation({
    required this.notificationId,
    required super.receiverAccountId,
  }) : super(
    payloadType: NotificationPayloadTypeString.navigateToConversation,
  );

  static const String _notificationIdKey = "notificationId";
  static NotificationPayload? parseFromJsonObject(Map<String, Object?> jsonObject, AccountId receiverAccountId) {
    if (!jsonObject.containsKey(_notificationIdKey)) {
      log.error("NavigateToConversation payload parsing error: notification ID is missing");
      return null;
    }
    final idValue = jsonObject[_notificationIdKey];
    final NotificationId id;
    if (idValue is double) {
      id = NotificationId(idValue.toInt());

    } else if (idValue is int) {
      id = NotificationId(idValue);
    } else {
      log.error("NavigateToConversation payload parsing error: notification ID is not an integer");
      return null;
    }
    return NavigateToConversation(
      notificationId: id,
      receiverAccountId: receiverAccountId,
    );
  }

  @override
  Map<String, Object?> additionalData() => {
    _notificationIdKey: notificationId.value,
  };
}

class NavigateToContentManagement extends NotificationPayload {
  const NavigateToContentManagement({
    required super.receiverAccountId,
  }) : super(
    payloadType: NotificationPayloadTypeString.navigateToContentManagement,
  );
}

class NavigateToMyProfile extends NotificationPayload {
  const NavigateToMyProfile({
    required super.receiverAccountId,
  }) : super(
    payloadType: NotificationPayloadTypeString.navigateToMyProfile,
  );
}

// TODO(quality): Opening another automatic profile search result screen
//                is possible and that breaks the first's iterator state
//                as server supports only one iterator state.
//                This can be fixed with creating only one profile grid
//                and displaying it on every screen which is how
//                received likes screen works.

class NavigateToAutomaticProfileSearchResults extends NotificationPayload {
  const NavigateToAutomaticProfileSearchResults({
    required super.receiverAccountId,
  }) : super(
    payloadType: NotificationPayloadTypeString.navigateToAutomaticProfileSearchResults,
  );
}

class NavigateToModeratorTasks extends NotificationPayload {
  const NavigateToModeratorTasks({
    required super.receiverAccountId,
  }) : super(
    payloadType: NotificationPayloadTypeString.navigateToModeratorTasks,
  );
}

enum NotificationPayloadTypeString {
  navigateToLikes(value: stringNavigateToLikes),
  navigateToNews(value: stringNavigateToNews),
  navigateToConversation(value: stringNavigateToConversation),
  navigateToConversationList(value: stringNavigateToConversationList),
  navigateToContentManagement(value: stringNavigateToContentManagement),
  navigateToMyProfile(value: stringNavigateToMyProfile),
  navigateToAutomaticProfileSearchResults(value: stringNavigateToAutomaticProfileSearchResults),
  navigateToModeratorTasks(value: stringNavigateToModeratorTasks);

  final String value;
  const NotificationPayloadTypeString({
    required this.value,
  });

  static const String stringNavigateToLikes = "navigate_to_likes";
  static const String stringNavigateToNews = "navigate_to_news";
  static const String stringNavigateToConversation = "navigate_to_conversation";
  static const String stringNavigateToConversationList = "navigate_to_conversation_list";
  static const String stringNavigateToContentManagement = "navigate_to_content_management";
  static const String stringNavigateToMyProfile = "navigate_to_my_profile";
  static const String stringNavigateToAutomaticProfileSearchResults = "navigate_to_automatic_profile_search_results";
  static const String stringNavigateToModeratorTasks = "navigate_to_moderator_tasks";
}
