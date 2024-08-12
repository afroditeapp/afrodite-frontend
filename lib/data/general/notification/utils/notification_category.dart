
import 'package:database/database.dart';
import 'package:pihka_frontend/data/notification_manager.dart';
import 'package:pihka_frontend/database/account_background_database_manager.dart';
import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/utils/result.dart';

typedef IsEnabledGetter = Stream<bool?> Function(AccountBackgroundDatabase);

sealed class NotificationCategory {
  final String id;
  final bool headsUpNotification;
  const NotificationCategory({required this.id, this.headsUpNotification = false});

  String get title;

  IsEnabledGetter get _isEnabledValueLocation;

  Future<bool> isEnabled(AccountBackgroundDatabaseManager accountBackgroundDb) async {
    final value = await accountBackgroundDb.accountStreamSingle(_isEnabledValueLocation).ok();
    return value ?? NOTIFICATION_CATEGORY_ENABLED_DEFAULT;
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
  IsEnabledGetter get _isEnabledValueLocation => (db) => db.daoLocalNotificationSettings.watchMessages();
}

class NotificationCategoryLikes extends NotificationCategory {
  const NotificationCategoryLikes() : super(
    id: "notification_category_likes",
    headsUpNotification: true,
  );

  @override
  String get title => R.strings.notification_category_likes;

  @override
  IsEnabledGetter get _isEnabledValueLocation => (db) => db.daoLocalNotificationSettings.watchLikes();
}

class NotificationCategoryModerationRequestStatus extends NotificationCategory {
  const NotificationCategoryModerationRequestStatus() : super(
    id: "notification_category_moderation_request_status",
    headsUpNotification: true,
  );

  @override
  String get title => R.strings.notification_category_moderation_request_status;

  @override
  IsEnabledGetter get _isEnabledValueLocation => (db) => db.daoLocalNotificationSettings.watchModerationRequestStatus();
}
