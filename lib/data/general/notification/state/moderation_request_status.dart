


import 'package:app/data/general/notification/utils/notification_category.dart';
import 'package:app/data/general/notification/utils/notification_id.dart';
import 'package:app/data/general/notification/utils/notification_payload.dart';
import 'package:app/data/notification_manager.dart';
import 'package:app/database/account_background_database_manager.dart';
import 'package:app/database/database_manager.dart';
import 'package:app/localizations.dart';
import 'package:utils/utils.dart';

class NotificationMediaContentModerationCompleted extends AppSingletonNoInit {
  NotificationMediaContentModerationCompleted._();
  static final _instance = NotificationMediaContentModerationCompleted._();
  factory NotificationMediaContentModerationCompleted.getInstance() {
    return _instance;
  }

  final notificationIdAccepted = NotificationIdStatic.mediaContentModerationAccepted.id;
  final notificationIdRejected = NotificationIdStatic.mediaContentModerationRejected.id;
  final notifications = NotificationManager.getInstance();
  final db = DatabaseManager.getInstance();

  Future<void> show(ModerationCompletedState state, AccountBackgroundDatabaseManager accountBackgroundDb) async {
    final NotificationId id = switch (state) {
      ModerationCompletedState.accepted => notificationIdAccepted,
      ModerationCompletedState.rejected => notificationIdRejected,
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
