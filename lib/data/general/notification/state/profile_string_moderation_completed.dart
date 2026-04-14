import 'package:app/data/general/notification/utils/notification_category.dart';
import 'package:app/data/general/notification/utils/notification_id.dart';
import 'package:app/data/notification_manager.dart';
import 'package:app/database/account_database_manager.dart';
import 'package:app/localizations.dart';
import 'package:utils/utils.dart';

class NotificationProfileStringModerationCompleted extends AppSingletonNoInit {
  NotificationProfileStringModerationCompleted._();
  static final _instance = NotificationProfileStringModerationCompleted._();
  factory NotificationProfileStringModerationCompleted.getInstance() {
    return _instance;
  }

  final notifications = NotificationManager.getInstance();

  Future<void> hideAll() async {
    await notifications.hideNotification(NotificationIdStatic.profileNameModerationCompleted.id);
    await notifications.hideNotification(NotificationIdStatic.profileTextModerationCompleted.id);
  }

  static Future<void> handleNameAccepted(AccountDatabaseManager db) async {
    await NotificationProfileStringModerationCompleted.getInstance()._showNameNotification(
      ModerationCompletedState.accepted,
      db,
    );
  }

  static Future<void> handleNameRejected(AccountDatabaseManager db) async {
    await NotificationProfileStringModerationCompleted.getInstance()._showNameNotification(
      ModerationCompletedState.rejected,
      db,
    );
  }

  static Future<void> handleTextAccepted(AccountDatabaseManager db) async {
    await NotificationProfileStringModerationCompleted.getInstance()._showTextNotification(
      ModerationCompletedState.accepted,
      db,
    );
  }

  static Future<void> handleTextRejected(AccountDatabaseManager db) async {
    await NotificationProfileStringModerationCompleted.getInstance()._showTextNotification(
      ModerationCompletedState.rejected,
      db,
    );
  }

  Future<void> _showNameNotification(
    ModerationCompletedState state,
    AccountDatabaseManager db,
  ) async {
    final LocalNotificationId id = NotificationIdStatic.profileNameModerationCompleted.id;
    final String title = switch (state) {
      ModerationCompletedState.accepted => R.strings.notification_profile_name_accepted,
      ModerationCompletedState.rejected => R.strings.notification_profile_name_rejected,
    };

    await notifications.sendNotification(
      id: id,
      title: title,
      category: const NotificationCategoryProfileStringModerationCompleted(),
      db: db,
    );
  }

  Future<void> _showTextNotification(
    ModerationCompletedState state,
    AccountDatabaseManager db,
  ) async {
    final LocalNotificationId id = NotificationIdStatic.profileTextModerationCompleted.id;
    final String title = switch (state) {
      ModerationCompletedState.accepted => R.strings.notification_profile_text_accepted,
      ModerationCompletedState.rejected => R.strings.notification_profile_text_rejected,
    };

    await notifications.sendNotification(
      id: id,
      title: title,
      category: const NotificationCategoryProfileStringModerationCompleted(),
      db: db,
    );
  }
}

enum ModerationCompletedState { accepted, rejected }
