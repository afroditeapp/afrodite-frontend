import 'dart:convert';

import 'package:app/data/general/notification/utils/notification_id.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:openapi/api.dart';
import 'package:utils/utils.dart';

final _log = Logger("NotificationPayload");

@immutable
class NotificationPayload extends Immutable {
  final LocalNotificationId notificationId;
  const NotificationPayload({required this.notificationId});

  static const String _notificationId = "id";

  String toJson() {
    final Map<String, String> map = {};
    map[_notificationId] = notificationId.value.toString();
    return jsonEncode(map);
  }

  static ParsedPayload? parse(String jsonPayload) {
    final jsonObject = jsonDecode(jsonPayload);
    if (jsonObject is! Map<String, Object?>) {
      _log.error("Payload is not JSON object");
      return null;
    }
    return parseMap(jsonObject);
  }

  static ParsedPayload? parseMap(Map<String, Object?> jsonObject) {
    if (!jsonObject.containsKey(_notificationId)) {
      _log.error("Notification ID is missing from the payload");
      return null;
    }
    final notificationIdValue = jsonObject[_notificationId];
    if (notificationIdValue is! String) {
      _log.error("Notification ID is not a string");
      return null;
    }
    final notificationIdInt = int.tryParse(notificationIdValue);
    if (notificationIdInt == null) {
      _log.error("Notification ID is not an int");
      return null;
    }

    final LocalNotificationId notificationId = LocalNotificationId(notificationIdInt);

    final NavigationAction action;
    if (notificationId == NotificationIdStatic.likeReceived.id) {
      action = NavigateToLikes();
    } else if (notificationId == NotificationIdStatic.newsItemAvailable.id) {
      action = NavigateToNews();
    } else if (notificationId == NotificationIdStatic.genericMessageReceived.id) {
      action = NavigateToConversationList();
    } else if (notificationId.value >=
        NotificationIdStatic.firstNewMessageNotificationId.id.value) {
      final conversationId = NotificationIdStatic.revertNewMessageNotificationIdCalculation(
        notificationId,
      );
      action = NavigateToConversation(conversationId: conversationId);
    } else if (notificationId == NotificationIdStatic.mediaContentModerationAccepted.id ||
        notificationId == NotificationIdStatic.mediaContentModerationRejected.id ||
        notificationId == NotificationIdStatic.mediaContentModerationDeleted.id) {
      action = NavigateToContentManagement();
    } else if (notificationId == NotificationIdStatic.profileNameModerationAccepted.id ||
        notificationId == NotificationIdStatic.profileNameModerationRejected.id ||
        notificationId == NotificationIdStatic.profileTextModerationAccepted.id ||
        notificationId == NotificationIdStatic.profileTextModerationRejected.id) {
      action = NavigateToMyProfile();
    } else if (notificationId == NotificationIdStatic.automaticProfileSearchCompleted.id) {
      action = NavigateToAutomaticProfileSearchResults();
    } else if (notificationId == NotificationIdStatic.adminNotification.id) {
      action = NavigateToModeratorTasks();
    } else {
      _log.error("Unknown notification ID");
      return null;
    }

    return ParsedPayload(action);
  }
}

class ParsedPayload {
  final NavigationAction action;
  ParsedPayload(this.action);
}

sealed class NavigationAction {}

class NavigateToLikes extends NavigationAction {}

class NavigateToNews extends NavigationAction {}

class NavigateToConversationList extends NavigationAction {}

class NavigateToConversation extends NavigationAction {
  final ConversationId conversationId;
  NavigateToConversation({required this.conversationId});
}

class NavigateToContentManagement extends NavigationAction {}

class NavigateToMyProfile extends NavigationAction {}

// TODO(quality): Opening another automatic profile search result screen
//                is possible and that breaks the first's iterator state
//                as server supports only one iterator state.
//                This can be fixed with creating only one profile grid
//                and displaying it on every screen which is how
//                received likes screen works.

class NavigateToAutomaticProfileSearchResults extends NavigationAction {}

class NavigateToModeratorTasks extends NavigationAction {}
