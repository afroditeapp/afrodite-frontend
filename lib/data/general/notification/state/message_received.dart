


import 'package:openapi/api.dart';
import 'package:pihka_frontend/data/general/notification/utils/notification_category.dart';
import 'package:pihka_frontend/data/general/notification/utils/notification_id.dart';
import 'package:pihka_frontend/data/general/notification/utils/notification_payload.dart';
import 'package:pihka_frontend/data/notification_manager.dart';
import 'package:pihka_frontend/database/database_manager.dart';
import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/logic/app/app_visibility_provider.dart';
import 'package:pihka_frontend/logic/app/bottom_navigation_state.dart';
import 'package:pihka_frontend/logic/app/navigator_state.dart';
import 'package:pihka_frontend/model/freezed/logic/main/navigator_state.dart';
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
    if (count <= 0 || isConversationUiOpen(accountId) || isConversationListUiOpen()) {
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
    final profileLocalId = await db.profileData((db) => db.getProfileLocalDbId(account)).ok();
    final profileEntry = await db.profileData((db) => db.getProfileEntry(account)).ok();
    if (profileLocalId == null || profileEntry == null) {
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
      category: const NotificationCategoryMessages(),
      notificationPayload: NavigateToConversation(
        profileLocalDbId: profileLocalId,
        sessionId: await notifications.getSessionId(),
      ),
    );
  }

  bool isConversationUiOpen(AccountId accountId) {
    final lastPage = NavigationStateBlocInstance.getInstance().bloc.state.pages.lastOrNull;
    final info = lastPage?.pageInfo;
    return info is ConversationPageInfo &&
      info.accountId == accountId &&
      AppVisibilityProvider.getInstance().isForeground;
  }

  // TODO(prod): Perhaps delete this once the push notifications are identical
  // with the other conversation notifications.
  // All matches should have a specific notification ID which can be used
  // in push notifications as well. Create a separate encrypted database
  // which can be accesssed when app is started using push notification.
  bool isConversationListUiOpen() {
    final currentMainScreen = BottomNavigationStateBlocInstance.getInstance().bloc.state.screen;
    final lastPage = NavigationStateBlocInstance.getInstance().bloc.state.pages;
    return currentMainScreen == BottomNavigationScreenId.chats &&
      lastPage.length == 1;
  }
}

class NotificationState {
  int messageCount;
  NotificationState({required this.messageCount});
}
