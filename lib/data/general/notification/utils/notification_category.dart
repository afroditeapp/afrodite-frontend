
import 'package:database/database.dart';
import 'package:pihka_frontend/data/notification_manager.dart';
import 'package:pihka_frontend/database/database_manager.dart';
import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/utils/app_error.dart';
import 'package:pihka_frontend/utils/result.dart';

sealed class NotificationCategory {
  final String id;
  final bool headsUpNotification;
  const NotificationCategory({required this.id, this.headsUpNotification = false});

  String get title;

  Stream<bool?> Function(AccountDatabase) get _isEnabledDbValueGetter;

  Future<bool> isEnabled() async {
    final result = await DatabaseManager.getInstance().accountStreamSingle(_isEnabledDbValueGetter);
    switch (result) {
      case Ok():
        return result.value;
      case Err():
        if (result.error is MissingRequiredValue) {
          return NOTIFICATION_CATEGORY_ENABLED_DEFAULT;
        } else {
          return false;
        }
    }
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
  Stream<bool?> Function(AccountDatabase) get _isEnabledDbValueGetter =>
    (db) => db.daoLocalNotificationSettings.watchMessages();
}

class NotificationCategoryLikes extends NotificationCategory {
  const NotificationCategoryLikes() : super(
    id: "notification_category_likes",
    headsUpNotification: true,
  );

  @override
  String get title => R.strings.notification_category_likes;

  @override
  Stream<bool?> Function(AccountDatabase) get _isEnabledDbValueGetter =>
    (db) => db.daoLocalNotificationSettings.watchLikes();
}

class NotificationCategoryModerationRequestStatus extends NotificationCategory {
  const NotificationCategoryModerationRequestStatus() : super(
    id: "notification_category_moderation_request_status",
    headsUpNotification: true,
  );

  @override
  String get title => R.strings.notification_category_moderation_request_status;

  @override
  Stream<bool?> Function(AccountDatabase) get _isEnabledDbValueGetter =>
    (db) => db.daoLocalNotificationSettings.watchModerationRequestStatus();
}
