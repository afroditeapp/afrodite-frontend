


import 'package:pihka_frontend/data/general/notification/utils/notification_category.dart';
import 'package:pihka_frontend/data/general/notification/utils/notification_id.dart';
import 'package:pihka_frontend/data/general/notification/utils/notification_payload.dart';
import 'package:pihka_frontend/data/notification_manager.dart';
import 'package:pihka_frontend/database/database_manager.dart';
import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/utils.dart';

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

  Future<void> show(ModerationRequestStateSimple state) async {
    _state = state;
    await _updateNotification();
  }

  Future<void> hide() async {
    _state = null;
    await _updateNotification();
  }

  Future<void> _updateNotification() async {
    final sessionId = await db.commonStreamSingle((db) => db.watchNotificationSessionId());
    final state = _state;
    if (sessionId == null || state == null) {
      await notifications.hideNotification(notificationId);
      return;
    }

    final String title = switch (state) {
      ModerationRequestStateSimple.accepted => R.strings.notification_moderation_request_status_accepted,
      ModerationRequestStateSimple.rejected => R.strings.notification_moderation_request_status_rejected,
    };

    await notifications.sendNotification(
      id: notificationId,
      title: title,
      category: const NotificationCategoryLikes(),
      notificationPayload: NavigateToModerationRequestStatus(sessionId: sessionId),
    );
  }
}

enum ModerationRequestStateSimple {
  accepted,
  rejected,
}
