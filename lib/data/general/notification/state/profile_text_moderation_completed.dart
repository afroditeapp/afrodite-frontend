


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

class NotificationProfileTextModerationCompleted extends AppSingletonNoInit {
  NotificationProfileTextModerationCompleted._();
  static final _instance = NotificationProfileTextModerationCompleted._();
  factory NotificationProfileTextModerationCompleted.getInstance() {
    return _instance;
  }

  final notifications = NotificationManager.getInstance();

  static Future<void> handleProfileTextModerationCompleted(
    ProfileTextModerationCompletedNotification notification,
    AccountBackgroundDatabaseManager accountBackgroundDb,
  ) async {
    final showAccepted = await accountBackgroundDb.accountData(
      (db) => db.daoProfileTextModerationCompletedNotificationTable.shouldAcceptedNotificationBeShown(notification.accepted, notification.acceptedViewed)
    ).ok() ?? false;

    if (showAccepted) {
      await NotificationProfileTextModerationCompleted.getInstance().show(ModerationCompletedState.accepted, accountBackgroundDb);
    }

    final showRejected = await accountBackgroundDb.accountData(
      (db) => db.daoProfileTextModerationCompletedNotificationTable.shouldRejectedNotificationBeShown(notification.rejected, notification.rejectedViewed)
    ).ok() ?? false;

    if (showRejected) {
      await NotificationProfileTextModerationCompleted.getInstance().show(ModerationCompletedState.rejected, accountBackgroundDb);
    }
  }

  Future<void> show(ModerationCompletedState state, AccountBackgroundDatabaseManager accountBackgroundDb) async {
    final NotificationId id = switch (state) {
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
      category: const NotificationCategoryProfileTextModerationCompleted(),
      notificationPayload: NavigateToMyProfile(sessionId: await notifications.getSessionId()),
      accountBackgroundDb: accountBackgroundDb,
    );
  }
}
