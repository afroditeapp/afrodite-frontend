


import 'package:openapi/api.dart';
import 'package:pihka_frontend/data/general/notification/utils/notification_category.dart';
import 'package:pihka_frontend/data/general/notification/utils/notification_id.dart';
import 'package:pihka_frontend/data/general/notification/utils/notification_payload.dart';
import 'package:pihka_frontend/data/notification_manager.dart';
import 'package:pihka_frontend/database/database_manager.dart';
import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/utils.dart';
import 'package:pihka_frontend/utils/result.dart';

class NotificationMessageReceived extends AppSingletonNoInit {
  NotificationMessageReceived._();
  static final _instance = NotificationMessageReceived._();
  factory NotificationMessageReceived.getInstance() {
    return _instance;
  }

  final notifications = NotificationManager.getInstance();
  final db = DatabaseManager.getInstance();

  final DynamicNotificationIdMap<AccountId, NotificationState> _state = DynamicNotificationIdMap(
    range: NotificationIdDynamic.messageReceived.range,
  );

  Future<void> updateMessageReceivedCount(AccountId accountId, int count) async {
    if (count <= 0) {
      final currentState = _state.removeState(accountId);
      if (currentState != null) {
        await notifications.hideNotification(currentState.id);
      }
    } else {
      final currentState = _state.getState(accountId, defaultValue: NotificationState(messageCount: count));
      currentState.state.messageCount = count;
      await _showNotification(accountId, currentState);
    }
  }

  Future<void> _showNotification(AccountId account, NotificationIdAndState<NotificationState> state) async {
    final sessionId = await db.commonStreamSingle((db) => db.watchNotificationSessionId());
    final profileLocalId = await db.profileData((db) => db.getProfileLocalDbId(account)).ok();
    final profileEntry = await db.profileData((db) => db.getProfileEntry(account)).ok();
    if (sessionId == null || profileLocalId == null || profileEntry == null) {
      return;
    }

    final String profileTitle = profileEntry.profileTitle();

    final String title;
    if (state.state.messageCount == 1) {
      title = R.strings.notification_message_received_single(profileTitle);
    } else if (state.state.messageCount > 1) {
      title = R.strings.notification_message_received_multiple(profileTitle);
    } else {
      return;
    }

    await notifications.sendNotification(
      id: state.id,
      title: title,
      category: const NotificationCategoryLikes(),
      notificationPayload: NavigateToConversation(
        profileLocalDbId: profileLocalId,
        sessionId: sessionId,
      ),
    );
  }
}

class NotificationState {
  int messageCount;
  NotificationState({required this.messageCount});
}
