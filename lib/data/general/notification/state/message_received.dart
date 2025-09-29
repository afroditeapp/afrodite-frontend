import 'package:app/ui/normal/chat/conversation_page.dart';
import 'package:openapi/api.dart';
import 'package:app/data/general/notification/utils/notification_category.dart';
import 'package:app/data/general/notification/utils/notification_id.dart';
import 'package:app/data/notification_manager.dart';
import 'package:app/database/account_background_database_manager.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/app/app_visibility_provider.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:utils/utils.dart';
import 'package:app/utils/result.dart';

class NotificationMessageReceived extends AppSingletonNoInit {
  NotificationMessageReceived._();
  static final _instance = NotificationMessageReceived._();
  factory NotificationMessageReceived.getInstance() {
    return _instance;
  }

  final notifications = NotificationManager.getInstance();

  Future<void> updateMessageReceivedCount(
    AccountId accountId,
    int count,
    ConversationId? conversation,
    AccountBackgroundDatabaseManager accountBackgroundDb, {
    bool onlyDbUpdate = false,
  }) async {
    final dbConversationId = await accountBackgroundDb
        .accountData((db) => db.notification.getConversationId(accountId))
        .ok();
    final ConversationId conversationId;
    if (dbConversationId == null) {
      if (conversation == null) {
        return;
      }
      await accountBackgroundDb.accountAction(
        (db) => db.notification.setConversationId(accountId, conversation),
      );
      conversationId = conversation;
    } else {
      conversationId = dbConversationId;
    }

    final notificationId = NotificationIdStatic.calculateNotificationIdForNewMessageNotifications(
      conversationId,
    );
    final notificationShown =
        await accountBackgroundDb
            .accountData((db) => db.notification.getNewMessageNotificationShown(accountId))
            .ok() ??
        false;

    if (count <= 0 || _isConversationUiOpen(accountId) || notificationShown) {
      await notifications.hideNotification(notificationId);
    } else if (!onlyDbUpdate) {
      await _showNotification(accountId, notificationId, count, accountBackgroundDb);
    }
  }

  Future<void> _showNotification(
    AccountId account,
    LocalNotificationId id,
    int count,
    AccountBackgroundDatabaseManager accountBackgroundDb,
  ) async {
    final profileTitle = await accountBackgroundDb
        .accountData((db) => db.profile.getProfileTitle(account))
        .ok();

    final String title;
    if (profileTitle == null) {
      if (count > 1) {
        title = R.strings.notification_message_received_multiple_generic;
      } else {
        title = R.strings.notification_message_received_single_generic;
      }
    } else if (count > 1) {
      title = R.strings.notification_message_received_multiple(profileTitle.profileTitle());
    } else {
      title = R.strings.notification_message_received_single(profileTitle.profileTitle());
    }

    await notifications.sendNotification(
      id: id,
      title: title,
      category: const NotificationCategoryMessages(),
      accountBackgroundDb: accountBackgroundDb,
    );
  }

  bool _isConversationUiOpen(AccountId accountId) {
    final lastPage = NavigationStateBlocInstance.getInstance().navigationState.pages.lastOrNull;
    return lastPage is ConversationPage &&
        lastPage.accountId == accountId &&
        AppVisibilityProvider.getInstance().isForeground;
  }

  /// Fallback notification if conversation ID downloading fails.
  Future<void> showFallbackMessageReceivedNotification(
    AccountBackgroundDatabaseManager accountBackgroundDb,
  ) async {
    await notifications.sendNotification(
      id: NotificationIdStatic.genericMessageReceived.id,
      title: R.strings.notification_message_received_single_generic,
      category: const NotificationCategoryMessages(),
      accountBackgroundDb: accountBackgroundDb,
    );
  }
}

class NotificationState {
  int messageCount;
  NotificationState({required this.messageCount});
}
