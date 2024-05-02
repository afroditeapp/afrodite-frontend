
import 'package:pihka_frontend/localizations.dart';

sealed class NotificationCategory {
  final String id;
  final bool headsUpNotification;
  const NotificationCategory({required this.id, this.headsUpNotification = false});

  String get title;

  static const List<NotificationCategory> all = [
    NotificationCategoryLikes(),
    NotificationCategoryMessages(),
    NotificationCategoryModerationRequestStatus(),
  ];
}

class NotificationCategoryMessages extends NotificationCategory {
  const NotificationCategoryMessages() : super(
    id: "notification_category_messages",
    headsUpNotification: true,
  );

  @override
  String get title => R.strings.notification_category_messages;
}

class NotificationCategoryLikes extends NotificationCategory {
  const NotificationCategoryLikes() : super(
    id: "notification_category_likes",
    headsUpNotification: true,
  );

  @override
  String get title => R.strings.notification_category_likes;
}

class NotificationCategoryModerationRequestStatus extends NotificationCategory {
  const NotificationCategoryModerationRequestStatus() : super(
    id: "notification_category_moderation_request_status",
    headsUpNotification: true,
  );

  @override
  String get title => R.strings.notification_category_moderation_request_status;
}
