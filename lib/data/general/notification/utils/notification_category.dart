
import 'package:app/data/general/notification/utils/notification_category_group.dart';
import 'package:database/database.dart';
import 'package:app/data/notification_manager.dart';
import 'package:app/database/account_background_database_manager.dart';
import 'package:app/localizations.dart';
import 'package:app/utils/result.dart';

typedef IsEnabledGetter = Stream<bool?> Function(AccountBackgroundDatabase);

sealed class NotificationCategory {
  final String id;
  final NotificationCategoryGroup group;
  final bool headsUpNotification;
  const NotificationCategory({
    required this.id,
    required this.group,
    this.headsUpNotification = false,
  });

  String get title;

  IsEnabledGetter get _isEnabledValueLocation;

  Future<bool> isEnabled(AccountBackgroundDatabaseManager accountBackgroundDb) async {
    final value = await accountBackgroundDb.accountStreamSingle(_isEnabledValueLocation).ok();
    return value ?? NOTIFICATION_CATEGORY_ENABLED_DEFAULT;
  }

  static const List<NotificationCategory> all = [
    NotificationCategoryLikes(),
    NotificationCategoryMessages(),
    NotificationCategoryMediaContentModerationCompleted(),
    NotificationCategoryProfileTextModerationCompleted(),
    NotificationCategoryNewsItemAvailable(),
    NotificationCategoryAutomaticProfileSearch(),
  ];
}

class NotificationCategoryMessages extends NotificationCategory {
  const NotificationCategoryMessages() : super(
    id: "notification_category_messages",
    group: const NotificationCategoryGroupChat(),
    headsUpNotification: true,
  );

  @override
  String get title => R.strings.notification_category_messages;

  @override
  IsEnabledGetter get _isEnabledValueLocation => (db) => db.daoAppNotificationSettingsTable.watchMessages();
}

class NotificationCategoryLikes extends NotificationCategory {
  const NotificationCategoryLikes() : super(
    id: "notification_category_likes",
    group: const NotificationCategoryGroupChat(),
    headsUpNotification: true,
  );

  @override
  String get title => R.strings.notification_category_likes;

  @override
  IsEnabledGetter get _isEnabledValueLocation => (db) => db.daoAppNotificationSettingsTable.watchLikes();
}

class NotificationCategoryMediaContentModerationCompleted extends NotificationCategory {
  const NotificationCategoryMediaContentModerationCompleted() : super(
    id: "notification_category_media_content_moderation_completed",
    group: const NotificationCategoryGroupContentModeration(),
    headsUpNotification: true,
  );

  @override
  String get title => R.strings.notification_category_media_content_moderation_completed;

  @override
  IsEnabledGetter get _isEnabledValueLocation => (db) => db.daoAppNotificationSettingsTable.watchMediaContentModerationCompleted();
}

class NotificationCategoryProfileTextModerationCompleted extends NotificationCategory {
  const NotificationCategoryProfileTextModerationCompleted() : super(
    id: "notification_category_profile_text_moderation_completed",
    group: const NotificationCategoryGroupContentModeration(),
    headsUpNotification: true,
  );

  @override
  String get title => R.strings.notification_category_profile_text_moderation_completed;

  @override
  IsEnabledGetter get _isEnabledValueLocation => (db) => db.daoAppNotificationSettingsTable.watchProfileAppNotificationSettings().map((v) => v?.profileTextModeration);
}

class NotificationCategoryNewsItemAvailable extends NotificationCategory {
  const NotificationCategoryNewsItemAvailable() : super(
    id: "notification_category_news_item_available",
    group: const NotificationCategoryGroupGeneral(),
    headsUpNotification: true,
  );

  @override
  String get title => R.strings.notification_category_news_item_available;

  @override
  IsEnabledGetter get _isEnabledValueLocation => (db) => db.daoAppNotificationSettingsTable.watchNews();
}

class NotificationCategoryAutomaticProfileSearch extends NotificationCategory {
  const NotificationCategoryAutomaticProfileSearch() : super(
    id: "notification_category_automatic_profile_search",
    group: const NotificationCategoryGroupGeneral(),
    headsUpNotification: true,
  );

  @override
  String get title => R.strings.notification_category_automatic_profile_search;

  @override
  IsEnabledGetter get _isEnabledValueLocation => (db) => db.daoAppNotificationSettingsTable.watchProfileAppNotificationSettings().map((v) => v?.automaticProfileSearch);
}
