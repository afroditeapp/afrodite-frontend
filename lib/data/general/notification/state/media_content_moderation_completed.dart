


import 'package:app/data/general/notification/utils/notification_category.dart';
import 'package:app/data/general/notification/utils/notification_id.dart';
import 'package:app/data/general/notification/utils/notification_payload.dart';
import 'package:app/data/notification_manager.dart';
import 'package:app/database/account_background_database_manager.dart';
import 'package:app/localizations.dart';
import 'package:app/utils/result.dart';
import 'package:openapi/api.dart';
import 'package:utils/utils.dart';

class NotificationMediaContentModerationCompleted extends AppSingletonNoInit {
  NotificationMediaContentModerationCompleted._();
  static final _instance = NotificationMediaContentModerationCompleted._();
  factory NotificationMediaContentModerationCompleted.getInstance() {
    return _instance;
  }

  final notifications = NotificationManager.getInstance();

  static Future<void> handleMediaContentModerationCompleted(
    MediaContentModerationCompletedNotification notification,
    AccountBackgroundDatabaseManager accountBackgroundDb,
  ) async {
    final showAccepted = await accountBackgroundDb.accountData(
      (db) => db.daoMediaContentModerationCompletedNotificationTable.shouldAcceptedNotificationBeShown(notification.accepted)
    ).ok() ?? false;

    if (showAccepted) {
      await NotificationMediaContentModerationCompleted.getInstance().show(ModerationCompletedState.accepted, accountBackgroundDb);
    }

    final showRejected = await accountBackgroundDb.accountData(
      (db) => db.daoMediaContentModerationCompletedNotificationTable.shouldRejectedNotificationBeShown(notification.rejected)
    ).ok() ?? false;

    if (showRejected) {
      await NotificationMediaContentModerationCompleted.getInstance().show(ModerationCompletedState.rejected, accountBackgroundDb);
    }
  }

  Future<void> show(ModerationCompletedState state, AccountBackgroundDatabaseManager accountBackgroundDb) async {
    final NotificationId id = switch (state) {
      ModerationCompletedState.accepted => NotificationIdStatic.mediaContentModerationAccepted.id,
      ModerationCompletedState.rejected => NotificationIdStatic.mediaContentModerationRejected.id,
    };
    final String title = switch (state) {
      ModerationCompletedState.accepted => R.strings.notification_media_content_accepted,
      ModerationCompletedState.rejected => R.strings.notification_media_content_rejected,
    };
    await notifications.sendNotification(
      id: id,
      title: title,
      category: const NotificationCategoryMediaContentModerationCompleted(),
      notificationPayload: NavigateToContentManagement(sessionId: await notifications.getSessionId()),
      accountBackgroundDb: accountBackgroundDb,
    );
  }
}

enum ModerationCompletedState {
  accepted,
  rejected,
}
