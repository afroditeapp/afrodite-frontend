
import 'package:pihka_frontend/data/general/notification/utils/notification_category.dart';
import 'package:pihka_frontend/data/general/notification/utils/notification_id.dart';
import 'package:pihka_frontend/data/general/notification/utils/notification_payload.dart';
import 'package:pihka_frontend/data/notification_manager.dart';
import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/utils.dart';

class NotificationMessageReceivedStatic extends AppSingletonNoInit {
  NotificationMessageReceivedStatic._();
  static final _instance = NotificationMessageReceivedStatic._();
  factory NotificationMessageReceivedStatic.getInstance() {
    return _instance;
  }

  final notifications = NotificationManager.getInstance();

  Future<void> updateState(bool visible) async {
    await _showNotification(visible);
  }

  Future<void> _showNotification(bool visible) async {
    if (visible) {
      await notifications.sendNotification(
        id: NotificationIdStatic.messageReceived.id,
        title: R.strings.notification_message_received_single_generic,
        category: const NotificationCategoryMessages(),
        notificationPayload: NavigateToConversationList(sessionId: await notifications.getSessionId()),
      );
    } else {
      await notifications.hideNotification(NotificationIdStatic.messageReceived.id);
    }
  }
}

class NotificationState {
  int messageCount;
  NotificationState({required this.messageCount});
}
