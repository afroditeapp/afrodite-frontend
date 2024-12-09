


import 'package:app/data/general/notification/utils/notification_category.dart';
import 'package:app/data/general/notification/utils/notification_id.dart';
import 'package:app/data/general/notification/utils/notification_payload.dart';
import 'package:app/data/notification_manager.dart';
import 'package:app/database/account_background_database_manager.dart';
import 'package:app/database/database_manager.dart';
import 'package:app/localizations.dart';
import 'package:utils/utils.dart';

class NotificationModerationRequestStatus extends AppSingletonNoInit {
  NotificationModerationRequestStatus._();
  static final _instance = NotificationModerationRequestStatus._();
  factory NotificationModerationRequestStatus.getInstance() {
    return _instance;
  }

  final notificationId = NotificationIdStatic.moderationRequestStatus.id;
  final notifications = NotificationManager.getInstance();
  final db = DatabaseManager.getInstance();

  ModerationRequestStateSimple? _state;

  Future<void> show(ModerationRequestStateSimple state, AccountBackgroundDatabaseManager accountBackgroundDb) async {
    _state = state;
    await _updateNotification(accountBackgroundDb);
  }

  Future<void> hide(AccountBackgroundDatabaseManager accountBackgroundDb) async {
    _state = null;
    await _updateNotification(accountBackgroundDb);
  }

  Future<void> _updateNotification(AccountBackgroundDatabaseManager accountBackgroundDb) async {
    final state = _state;
    if (state == null) {
      await notifications.hideNotification(notificationId);
      return;
    }

    final String title = switch (state) {
      ModerationRequestStateSimple.accepted => R.strings.notification_initial_content_moderation_accepted,
      ModerationRequestStateSimple.rejected => R.strings.notification_initial_content_moderation_rejected,
    };

    await notifications.sendNotification(
      id: notificationId,
      title: title,
      category: const NotificationCategoryInitialContentModeration(),
      notificationPayload: NavigateToContentManagement(sessionId: await notifications.getSessionId()),
      accountBackgroundDb: accountBackgroundDb,
    );
  }
}

enum ModerationRequestStateSimple {
  accepted,
  rejected,
}
