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
    final showAccepted =
        await accountBackgroundDb
            .accountDataWrite(
              (db) => db.notification.mediaContentAccepted.shouldBeShown(notification.accepted),
            )
            .ok() ??
        false;

    if (showAccepted) {
      await NotificationMediaContentModerationCompleted.getInstance().show(
        ModerationCompletedState.accepted,
        accountBackgroundDb,
      );
    }

    final showRejected =
        await accountBackgroundDb
            .accountDataWrite(
              (db) => db.notification.mediaContentRejected.shouldBeShown(notification.rejected),
            )
            .ok() ??
        false;

    if (showRejected) {
      await NotificationMediaContentModerationCompleted.getInstance().show(
        ModerationCompletedState.rejected,
        accountBackgroundDb,
      );
    }

    final showDeleted =
        await accountBackgroundDb
            .accountDataWrite(
              (db) => db.notification.mediaContentDeleted.shouldBeShown(notification.deleted),
            )
            .ok() ??
        false;

    if (showDeleted) {
      await NotificationMediaContentModerationCompleted.getInstance().show(
        ModerationCompletedState.deleted,
        accountBackgroundDb,
      );
    }
  }

  Future<void> show(
    ModerationCompletedState state,
    AccountBackgroundDatabaseManager accountBackgroundDb,
  ) async {
    final LocalNotificationId id = switch (state) {
      ModerationCompletedState.accepted => NotificationIdStatic.mediaContentModerationAccepted.id,
      ModerationCompletedState.rejected => NotificationIdStatic.mediaContentModerationRejected.id,
      ModerationCompletedState.deleted => NotificationIdStatic.mediaContentModerationDeleted.id,
    };
    final String title = switch (state) {
      ModerationCompletedState.accepted => R.strings.notification_media_content_accepted,
      ModerationCompletedState.rejected => R.strings.notification_media_content_rejected,
      ModerationCompletedState.deleted => R.strings.notification_media_content_deleted,
    };
    await notifications.sendNotification(
      id: id,
      title: title,
      body: state == ModerationCompletedState.deleted
          ? R.strings.notification_media_content_deleted_description
          : null,
      category: const NotificationCategoryMediaContentModerationCompleted(),
      notificationPayload: NavigateToContentManagement(
        receiverAccountId: accountBackgroundDb.accountId(),
      ),
      accountBackgroundDb: accountBackgroundDb,
    );
  }
}

enum ModerationCompletedState { accepted, rejected, deleted }
