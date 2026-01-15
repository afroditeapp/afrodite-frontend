import 'package:database_account/database_account.dart';
import 'package:database_model/database_model.dart';
import 'package:drift/drift.dart';
import 'package:openapi/api.dart' as api;

import '../../schema.dart' as schema;

part 'unread_messages_count.g.dart';

@DriftAccessor(tables: [schema.UnreadMessagesCount, schema.NewMessageNotification])
class DaoReadChatUnreadMessagesCount extends DatabaseAccessor<AccountDatabase>
    with _$DaoReadChatUnreadMessagesCountMixin {
  DaoReadChatUnreadMessagesCount(super.db);

  Future<UnreadMessagesCount?> getUnreadMessageCount(api.AccountId accountId) async {
    final r = await (select(
      unreadMessagesCount,
    )..where((t) => t.accountId.equals(accountId.aid))).getSingleOrNull();

    return r?.unreadMessagesCount;
  }

  Stream<UnreadMessagesCount?> watchUnreadMessageCount(api.AccountId accountId) {
    return (selectOnly(unreadMessagesCount)
          ..addColumns([unreadMessagesCount.unreadMessagesCount])
          ..where(unreadMessagesCount.accountId.equals(accountId.aid)))
        .map((r) {
          final raw = r.read(unreadMessagesCount.unreadMessagesCount);
          if (raw == null) {
            return null;
          } else {
            return UnreadMessagesCount(raw);
          }
        })
        .watchSingleOrNull();
  }

  Stream<int?> watchUnreadConversationsCount() {
    final countExpression = countAll(
      filter: unreadMessagesCount.unreadMessagesCount.isBiggerThanValue(0),
    );
    return (selectOnly(unreadMessagesCount)..addColumns([countExpression])).map((r) {
      return r.read(countExpression);
    }).watchSingleOrNull();
  }

  Future<api.ConversationId?> getConversationId(api.AccountId id) async {
    return await (select(
      newMessageNotification,
    )..where((t) => t.accountId.equals(id.aid))).map((r) => r.conversationId).getSingleOrNull();
  }

  Future<api.AccountId?> convertConversationIdToAccountId(api.ConversationId conversationId) async {
    return await (select(newMessageNotification)
          ..where((t) => t.conversationId.equals(conversationId.id)))
        .map((r) => r.accountId)
        .getSingleOrNull();
  }

  Future<bool> getNewMessageNotificationShown(api.AccountId accountId) async {
    final r = await (select(
      newMessageNotification,
    )..where((t) => t.accountId.equals(accountId.aid))).getSingleOrNull();
    return r?.notificationShown ?? false;
  }
}
