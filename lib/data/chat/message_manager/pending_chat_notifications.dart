import 'package:app/data/general/notification/state/message_received.dart';
import 'package:database/database.dart';
import 'package:openapi/api.dart';
import 'package:app/api/server_connection_manager.dart';
import 'package:app/data/chat/message_key_generator.dart';
import 'package:app/database/account_database_manager.dart';
import 'package:app/utils/result.dart';

class PendingChatNotificationUtils {
  final MessageKeyManager messageKeyManager;
  final ApiManager api;
  final AccountDatabaseManager db;

  PendingChatNotificationUtils(this.messageKeyManager, this.api, this.db);

  Future<void> receivePendingChatNotifications() async {
    final keysResult = await messageKeyManager.getKeysWhenChatIsEnabled();
    if (keysResult.isErr()) {
      return;
    }

    final pending = await api.chat((api) => api.getPendingChatNotifications()).ok();
    if (pending == null || pending.notifications.isEmpty) {
      return;
    }

    for (final notification in pending.notifications) {
      await _handlePendingChatNotification(notification);
    }

    final handled = PendingChatNotificationList(notifications: pending.notifications);
    await api.chatAction((api) => api.postDeletePendingChatNotifications(handled));
  }

  Future<void> _handlePendingChatNotification(PendingChatNotification notification) async {
    final accountId = notification.accountIdSender;
    final messageCount = notification.messageCount;

    await db.accountAction(
      (db) => db.chatUnreadMessagesCount.setUnreadMessagesCount(
        accountId,
        UnreadMessagesCount(messageCount),
      ),
    );

    ConversationId? conversationId = await db
        .accountData((db) => db.chatUnreadMessagesCount.getConversationId(accountId))
        .ok();
    if (conversationId == null) {
      final result = await api.chat((api) => api.getConversationId(accountId.aid)).ok();
      conversationId = result?.value;
    }

    if (notification.pushNotificationSent) {
      return;
    }

    if (conversationId == null) {
      if (messageCount > 0) {
        await NotificationMessageReceived.getInstance().showFallbackMessageReceivedNotification(db);
      }
      return;
    }

    await NotificationMessageReceived.getInstance().updateMessageReceivedCount(
      accountId,
      messageCount,
      conversationId,
      db,
    );
  }
}
