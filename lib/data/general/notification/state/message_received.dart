


import 'package:openapi/api.dart';
import 'package:app/data/general/notification/utils/notification_category.dart';
import 'package:app/data/general/notification/utils/notification_id.dart';
import 'package:app/data/general/notification/utils/notification_payload.dart';
import 'package:app/data/notification_manager.dart';
import 'package:app/database/account_background_database_manager.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/app/app_visibility_provider.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:utils/utils.dart';
import 'package:app/utils/result.dart';

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

    if (count <= 0 || _isConversationUiOpen(accountId) || notificationShown) {
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
        receiverAccountId: accountBackgroundDb.accountId(),
      ),
      accountBackgroundDb: accountBackgroundDb,
    );
  }

  bool _isConversationUiOpen(AccountId accountId) {
    final lastPage = NavigationStateBlocInstance.getInstance().navigationState.pages.lastOrNull;
    final info = lastPage?.pageInfo;
    return info is ConversationPageInfo &&
      info.accountId == accountId &&
      AppVisibilityProvider.getInstance().isForeground;
  }
}

class NotificationState {
  int messageCount;
  NotificationState({required this.messageCount});
}
