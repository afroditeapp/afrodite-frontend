
import 'package:database/database.dart';
import 'package:app/data/notification_manager.dart';
import 'package:app/database/account_background_database_manager.dart';
import 'package:app/localizations.dart';
import 'package:app/utils/result.dart';

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
    NotificationCategoryInitialContentModeration(),
    NotificationCategoryNewsItemAvailable(),
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

class NotificationCategoryInitialContentModeration extends NotificationCategory {
  const NotificationCategoryInitialContentModeration() : super(
    id: "notification_category_initial_content_moderation",
    headsUpNotification: true,
  );

  @override
  String get title => R.strings.notification_category_initial_content_moderation;

  @override
  IsEnabledGetter get _isEnabledValueLocation => (db) => db.daoLocalNotificationSettings.watchInitialContentModeration();
}

class NotificationCategoryNewsItemAvailable extends NotificationCategory {
  const NotificationCategoryNewsItemAvailable() : super(
    id: "notification_category_news_item_available",
    headsUpNotification: true,
  );

  @override
  String get title => R.strings.notification_category_news_item_available;

  @override
  IsEnabledGetter get _isEnabledValueLocation => (db) => db.daoLocalNotificationSettings.watchNewsItemAvailable();
}
