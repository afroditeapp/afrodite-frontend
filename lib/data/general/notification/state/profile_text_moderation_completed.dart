


import 'package:app/data/general/notification/state/media_content_moderation_completed.dart';
import 'package:app/data/general/notification/utils/notification_category.dart';
import 'package:app/data/general/notification/utils/notification_id.dart';
import 'package:app/data/general/notification/utils/notification_payload.dart';
import 'package:app/data/notification_manager.dart';
import 'package:app/database/account_background_database_manager.dart';
import 'package:app/localizations.dart';
import 'package:app/utils/result.dart';
import 'package:openapi/api.dart';
import 'package:utils/utils.dart';

class NotificationProfileStringModerationCompleted extends AppSingletonNoInit {
  NotificationProfileStringModerationCompleted._();
  static final _instance = NotificationProfileStringModerationCompleted._();
  factory NotificationProfileStringModerationCompleted.getInstance() {
    return _instance;
  }

  final notifications = NotificationManager.getInstance();

  static Future<void> handleProfileStringModerationCompleted(
    ProfileStringModerationCompletedNotification notification,
    AccountBackgroundDatabaseManager accountBackgroundDb,
  ) async {
    final showNameAccepted = await accountBackgroundDb.accountDataWrite(
      (db) => db.notification.profileNameAccepted.shouldBeShown(notification.nameAccepted)
    ).ok() ?? false;

    if (showNameAccepted) {
      await NotificationProfileStringModerationCompleted.getInstance()._showNameNotification(ModerationCompletedState.accepted, accountBackgroundDb);
    }

    final showNameRejected = await accountBackgroundDb.accountDataWrite(
      (db) => db.notification.profileNameRejected.shouldBeShown(notification.nameRejected)
    ).ok() ?? false;

    if (showNameRejected) {
      await NotificationProfileStringModerationCompleted.getInstance()._showNameNotification(ModerationCompletedState.rejected, accountBackgroundDb);
    }

    final showTextAccepted = await accountBackgroundDb.accountDataWrite(
      (db) => db.notification.profileTextAccepted.shouldBeShown(notification.textAccepted)
    ).ok() ?? false;

    if (showTextAccepted) {
      await NotificationProfileStringModerationCompleted.getInstance()._showTextNotification(ModerationCompletedState.accepted, accountBackgroundDb);
    }

    final showTextRejected = await accountBackgroundDb.accountDataWrite(
      (db) => db.notification.profileTextRejected.shouldBeShown(notification.textRejected)
    ).ok() ?? false;

    if (showTextRejected) {
      await NotificationProfileStringModerationCompleted.getInstance()._showTextNotification(ModerationCompletedState.rejected, accountBackgroundDb);
    }
  }

  Future<void> _showNameNotification(ModerationCompletedState state, AccountBackgroundDatabaseManager accountBackgroundDb) async {
    final LocalNotificationId id = switch (state) {
      ModerationCompletedState.accepted => NotificationIdStatic.profileNameModerationAccepted.id,
      ModerationCompletedState.rejected => NotificationIdStatic.profileNameModerationRejected.id,
    };
    final String title = switch (state) {
      ModerationCompletedState.accepted => R.strings.notification_profile_name_accepted,
      ModerationCompletedState.rejected => R.strings.notification_profile_name_rejected,
    };

    if (state == ModerationCompletedState.accepted) {
      await notifications.hideNotification(NotificationIdStatic.profileNameModerationRejected.id);
    } else if (state == ModerationCompletedState.rejected) {
      await notifications.hideNotification(NotificationIdStatic.profileNameModerationAccepted.id);
    }

    await notifications.sendNotification(
      id: id,
      title: title,
      category: const NotificationCategoryProfileStringModerationCompleted(),
      notificationPayload: NavigateToMyProfile(receiverAccountId: accountBackgroundDb.accountId()),
      accountBackgroundDb: accountBackgroundDb,
    );
  }

  Future<void> _showTextNotification(ModerationCompletedState state, AccountBackgroundDatabaseManager accountBackgroundDb) async {
    final LocalNotificationId id = switch (state) {
      ModerationCompletedState.accepted => NotificationIdStatic.profileTextModerationAccepted.id,
      ModerationCompletedState.rejected => NotificationIdStatic.profileTextModerationRejected.id,
    };
    final String title = switch (state) {
      ModerationCompletedState.accepted => R.strings.notification_profile_text_accepted,
      ModerationCompletedState.rejected => R.strings.notification_profile_text_rejected,
    };

    if (state == ModerationCompletedState.accepted) {
      await notifications.hideNotification(NotificationIdStatic.profileTextModerationRejected.id);
    } else if (state == ModerationCompletedState.rejected) {
      await notifications.hideNotification(NotificationIdStatic.profileTextModerationAccepted.id);
    }

    await notifications.sendNotification(
      id: id,
      title: title,
      category: const NotificationCategoryProfileStringModerationCompleted(),
      notificationPayload: NavigateToMyProfile(receiverAccountId: accountBackgroundDb.accountId()),
      accountBackgroundDb: accountBackgroundDb,
    );
  }
}
