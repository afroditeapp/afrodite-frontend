import 'package:database_account_foreground/database_account_foreground.dart';
import 'package:database_model/database_model.dart';
import 'package:drift/drift.dart';
import 'package:openapi/api.dart' as api;

import '../../schema.dart' as schema;

part 'unread_messages_count.g.dart';

@DriftAccessor(tables: [schema.UnreadMessagesCount, schema.NewMessageNotification])
class DaoWriteChatUnreadMessagesCount extends DatabaseAccessor<AccountForegroundDatabase>
    with _$DaoWriteChatUnreadMessagesCountMixin {
  DaoWriteChatUnreadMessagesCount(super.db);

  Future<UnreadMessagesCount> incrementUnreadMessagesCount(api.AccountId accountId) async {
    return await transaction(() async {
      final currentUnreadMessageCount =
          await db.read.chatUnreadMessagesCount.getUnreadMessageCount(accountId) ??
          UnreadMessagesCount(0);
      final updatedValue = UnreadMessagesCount(currentUnreadMessageCount.count + 1);
      await setUnreadMessagesCount(accountId, updatedValue);
      return updatedValue;
    });
  }

  Future<void> setUnreadMessagesCount(
    api.AccountId accountId,
    UnreadMessagesCount unreadMessagesCountValue,
  ) async {
    await into(unreadMessagesCount).insertOnConflictUpdate(
      UnreadMessagesCountCompanion.insert(
        accountId: accountId,
        unreadMessagesCount: Value(unreadMessagesCountValue),
      ),
    );
  }

  Future<void> setConversationId(api.AccountId accountId, api.ConversationId value) async {
    await into(newMessageNotification).insertOnConflictUpdate(
      NewMessageNotificationCompanion.insert(accountId: accountId, conversationId: Value(value)),
    );
  }

  Future<void> setNewMessageNotificationShown(api.AccountId accountId, bool value) async {
    await into(newMessageNotification).insertOnConflictUpdate(
      NewMessageNotificationCompanion.insert(accountId: accountId, notificationShown: Value(value)),
    );
  }
}
