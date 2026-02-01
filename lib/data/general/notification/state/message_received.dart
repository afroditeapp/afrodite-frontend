import 'package:app/ui/normal/chat/conversation_page.dart';
import 'package:openapi/api.dart';
import 'package:app/data/general/notification/utils/notification_category.dart';
import 'package:app/data/general/notification/utils/notification_id.dart';
import 'package:app/data/notification_manager.dart';
import 'package:app/database/account_database_manager.dart';
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
    AccountDatabaseManager db, {
    bool onlyDbUpdate = false,
  }) async {
    final dbConversationId = await db
        .accountData((db) => db.chatUnreadMessagesCount.getConversationId(accountId))
        .ok();
    final ConversationId conversationId;
    if (dbConversationId == null) {
      if (conversation == null) {
        return;
      }
      await db.accountAction(
        (db) => db.chatUnreadMessagesCount.setConversationId(accountId, conversation),
      );
      conversationId = conversation;
    } else {
      conversationId = dbConversationId;
    }

    final notificationId = NotificationIdStatic.calculateNotificationIdForNewMessageNotifications(
      conversationId,
    );
    final notificationShown =
        await db
            .accountData(
              (db) => db.chatUnreadMessagesCount.getNewMessageNotificationShown(accountId),
            )
            .ok() ??
        false;

    if (count <= 0 || _isConversationUiOpen(accountId) || notificationShown) {
      await notifications.hideNotification(notificationId);
    } else if (!onlyDbUpdate) {
      await _showNotification(accountId, notificationId, count, db);
    }
  }

  Future<void> _showNotification(
    AccountId account,
    LocalNotificationId id,
    int count,
    AccountDatabaseManager db,
  ) async {
    final profileEntry = await db.accountData((db) => db.profile.getProfileEntry(account)).ok();

    final String title;
    if (profileEntry == null) {
      if (count > 1) {
        title = R.strings.notification_message_received_multiple_generic;
      } else {
        title = R.strings.notification_message_received_single_generic;
      }
    } else if (count > 1) {
      title = R.strings.notification_message_received_multiple(
        profileEntry.profileNameOrFirstCharacterProfileName(),
      );
    } else {
      title = R.strings.notification_message_received_single(
        profileEntry.profileNameOrFirstCharacterProfileName(),
      );
    }

    await notifications.sendNotification(
      id: id,
      title: title,
      category: const NotificationCategoryMessages(),
      db: db,
    );
  }

  bool _isConversationUiOpen(AccountId accountId) {
    final lastPage = NavigationStateBlocInstance.getInstance().navigationState.pages.lastOrNull;
    return lastPage is ConversationPage &&
        lastPage.accountId == accountId &&
        AppVisibilityProvider.getInstance().isForeground;
  }

  /// Fallback notification if conversation ID downloading fails.
  Future<void> showFallbackMessageReceivedNotification(AccountDatabaseManager db) async {
    await notifications.sendNotification(
      id: NotificationIdStatic.genericMessageReceived.id,
      title: R.strings.notification_message_received_single_generic,
      category: const NotificationCategoryMessages(),
      db: db,
    );
  }
}

class NotificationState {
  int messageCount;
  NotificationState({required this.messageCount});
}
