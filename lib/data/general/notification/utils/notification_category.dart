
import 'package:pihka_frontend/localizations.dart';

sealed class NotificationCategory {
  final String id;
  const NotificationCategory({required this.id});

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
  );

  @override
  String get title => R.strings.notification_category_messages;
}

class NotificationCategoryLikes extends NotificationCategory {
  const NotificationCategoryLikes() : super(
    id: "notification_category_likes",
  );

  @override
  String get title => R.strings.notification_category_likes;
}

class NotificationCategoryModerationRequestStatus extends NotificationCategory {
  const NotificationCategoryModerationRequestStatus() : super(
    id: "notification_category_moderation_request_status",
  );

  @override
  String get title => R.strings.notification_category_moderation_request_status;
}
