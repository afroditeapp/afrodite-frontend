


import 'package:openapi/api.dart';
import 'package:pihka_frontend/data/general/notification/utils/notification_category.dart';
import 'package:pihka_frontend/data/general/notification/utils/notification_id.dart';
import 'package:pihka_frontend/data/general/notification/utils/notification_payload.dart';
import 'package:pihka_frontend/data/notification_manager.dart';
import 'package:pihka_frontend/database/account_background_database_manager.dart';
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

  Future<void> updateMessageReceivedCount(AccountId accountId, int count, AccountBackgroundDatabaseManager accountBackgroundDb) async {
    final notificationIdInt = await accountBackgroundDb.accountData((db) => db.daoNewMessageNotification.getOrCreateNewMessageNotificationId(accountId)).ok();
    if (notificationIdInt == null) {
      return;
    }

    final notificationId = NotificationIdStatic.calculateNotificationIdForNewMessageNotifications(notificationIdInt);
    final notificationShown = await accountBackgroundDb.accountData((db) => db.daoNewMessageNotification.getNotificationShown(accountId)).ok() ?? false;

    if (count <= 0 || _isConversationUiOpen(accountId) || _isConversationListUiOpen() || notificationShown) {
      await notifications.hideNotification(notificationId);
    } else {
      await _showNotification(accountId, notificationId, accountBackgroundDb);
    }
  }

  Future<void> _showNotification(AccountId account, NotificationId id, AccountBackgroundDatabaseManager accountBackgroundDb) async {
    final profileTitle = await accountBackgroundDb.profileData((db) => db.getProfileTitle(account)).ok();

    final String title;
    if (profileTitle == null) {
      // TODO(prod): What about the case when there is no profile title?
      //             Is it possible? Perhaps if some account is already a match
      //             when login happens the account's profile data is not in DB.
      //             There is two options: provide the name from server together
      //             with ID or download all profiles of matches or sent likes
      //             when login happens.
      title = R.strings.notification_message_received_single_generic;
    } else {
      title = R.strings.notification_message_received_single(profileTitle.profileTitle());
    }

    // Message count is not supported.
    // if (state.state.messageCount == 1) {
    //   title = R.strings.notification_message_received_single(profileTitle);
    // } else if (state.state.messageCount > 1) {
    //   title = R.strings.notification_message_received_multiple(profileTitle);
    // } else {
    //   return;
    // }

    await notifications.sendNotification(
      id: id,
      title: title,
      category: const NotificationCategoryMessages(),
      notificationPayload: NavigateToConversation(
        notificationId: id,
        sessionId: await notifications.getSessionId(),
      ),
      accountBackgroundDb: accountBackgroundDb,
    );
  }

  bool _isConversationUiOpen(AccountId accountId) {
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
  bool _isConversationListUiOpen() {
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
