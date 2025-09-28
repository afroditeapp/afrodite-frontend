import 'package:app/localizations.dart';

sealed class NotificationCategoryGroup {
  final String id;
  const NotificationCategoryGroup({required this.id});

  String get title;

  static const List<NotificationCategoryGroup> all = [
    NotificationCategoryGroupGeneral(),
    NotificationCategoryGroupChat(),
    NotificationCategoryGroupContentModeration(),
  ];
}

class NotificationCategoryGroupGeneral extends NotificationCategoryGroup {
  const NotificationCategoryGroupGeneral() : super(id: "group_general");

  @override
  String get title => R.strings.notification_category_group_general;
}

class NotificationCategoryGroupChat extends NotificationCategoryGroup {
  const NotificationCategoryGroupChat() : super(id: "group_chat");

  @override
  String get title => R.strings.notification_category_group_chat;
}

class NotificationCategoryGroupContentModeration extends NotificationCategoryGroup {
  const NotificationCategoryGroupContentModeration() : super(id: "group_content_moderation");

  @override
  String get title => R.strings.notification_category_group_content_moderation;
}
