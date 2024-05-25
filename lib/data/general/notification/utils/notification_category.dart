
import 'package:pihka_frontend/data/notification_manager.dart';
import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/storage/kv.dart';

sealed class NotificationCategory {
  final String id;
  final bool headsUpNotification;
  const NotificationCategory({required this.id, this.headsUpNotification = false});

  String get title;

  KvBoolean get _isEnabledValueLocation;

  Future<bool> isEnabled() async {
    return await KvBooleanManager.getInstance().getValue(_isEnabledValueLocation) ?? NOTIFICATION_CATEGORY_ENABLED_DEFAULT;
  }

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

  @override
  KvBoolean get _isEnabledValueLocation => KvBoolean.localNotificationSettingMessages;
}

class NotificationCategoryLikes extends NotificationCategory {
  const NotificationCategoryLikes() : super(
    id: "notification_category_likes",
    headsUpNotification: true,
  );

  @override
  String get title => R.strings.notification_category_likes;

  @override
  KvBoolean get _isEnabledValueLocation => KvBoolean.localNotificationSettingLikes;
}

class NotificationCategoryModerationRequestStatus extends NotificationCategory {
  const NotificationCategoryModerationRequestStatus() : super(
    id: "notification_category_moderation_request_status",
    headsUpNotification: true,
  );

  @override
  String get title => R.strings.notification_category_moderation_request_status;

  @override
  KvBoolean get _isEnabledValueLocation =>
    KvBoolean.localNotificationSettingModerationRequestStatus;
}
