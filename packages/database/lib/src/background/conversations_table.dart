

import 'package:database/src/message_entry.dart';
import 'package:openapi/api.dart' show AccountId, ProfileContent;
import 'package:openapi/api.dart' as api;
import 'package:utils/utils.dart';
import 'account_database.dart';

import 'package:drift/drift.dart';
import '../profile_entry.dart';
import '../utils.dart';

part 'conversations_table.g.dart';

class ConversationsBackground extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get uuidAccountId => text().map(const AccountIdConverter()).unique()();

  IntColumn get conversationUnreadMessagesCount => integer().map(UnreadMessagesCountConverter()).withDefault(const Constant(0))();
}

@DriftAccessor(tables: [ConversationsBackground])
class DaoConversationsBackground extends DatabaseAccessor<AccountBackgroundDatabase> with _$DaoConversationsBackgroundMixin {
  DaoConversationsBackground(AccountBackgroundDatabase db) : super(db);

  Future<UnreadMessagesCount?> getUnreadMessageCount(AccountId accountId) async {
    final r = await (select(conversationsBackground)
      ..where((t) => t.uuidAccountId.equals(accountId.aid))
    )
      .getSingleOrNull();

    return r?.conversationUnreadMessagesCount;
  }

  Stream<UnreadMessagesCount?> watchUnreadMessageCount(AccountId accountId) {
    return (selectOnly(conversationsBackground)
      ..addColumns([conversationsBackground.conversationUnreadMessagesCount])
      ..where(conversationsBackground.uuidAccountId.equals(accountId.aid))
    )
      .map((r) {
        final raw = r.read(conversationsBackground.conversationUnreadMessagesCount);
        if (raw == null) {
          return null;
        } else {
          return UnreadMessagesCount(raw);
        }
      })
      .watchSingleOrNull();
  }

  Future<UnreadMessagesCount> incrementUnreadMessagesCount(AccountId accountId) async {
    return await transaction(() async {
      final currentUnreadMessageCount = await db.daoConversationsBackground.getUnreadMessageCount(accountId) ?? UnreadMessagesCount(0);
      final updatedValue = UnreadMessagesCount(currentUnreadMessageCount.count + 1);
      await db.daoConversationsBackground.setUnreadMessagesCount(accountId, updatedValue);
      return updatedValue;
    });
  }

  Future<void> setUnreadMessagesCount(AccountId accountId, UnreadMessagesCount unreadMessagesCount) async {
    await into(conversationsBackground).insert(
      ConversationsBackgroundCompanion.insert(
        uuidAccountId: accountId,
        conversationUnreadMessagesCount: Value(unreadMessagesCount),
      ),
      onConflict: DoUpdate((old) => ConversationsBackgroundCompanion(
        conversationUnreadMessagesCount: Value(unreadMessagesCount),
      ),
        target: [conversationsBackground.uuidAccountId]
      ),
    );
  }
}
