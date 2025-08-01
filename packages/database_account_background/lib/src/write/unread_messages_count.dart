
import 'package:database_account_background/database_account_background.dart';
import 'package:database_model/database_model.dart';
import 'package:drift/drift.dart';
import 'package:openapi/api.dart' as api;

import '../schema.dart' as schema;

part 'unread_messages_count.g.dart';

@DriftAccessor(
  tables: [
    schema.UnreadMessagesCount,
  ]
)
class DaoWriteUnreadMessagesCount extends DatabaseAccessor<AccountBackgroundDatabase> with _$DaoWriteUnreadMessagesCountMixin {
  DaoWriteUnreadMessagesCount(super.db);

  Future<UnreadMessagesCount> incrementUnreadMessagesCount(api.AccountId accountId) async {
    return await transaction(() async {
      final currentUnreadMessageCount = await db.read.unreadMessagesCount.getUnreadMessageCount(accountId) ?? UnreadMessagesCount(0);
      final updatedValue = UnreadMessagesCount(currentUnreadMessageCount.count + 1);
      await setUnreadMessagesCount(accountId, updatedValue);
      return updatedValue;
    });
  }

  Future<void> setUnreadMessagesCount(api.AccountId accountId, UnreadMessagesCount unreadMessagesCountValue) async {
    await into(unreadMessagesCount).insertOnConflictUpdate(
      UnreadMessagesCountCompanion.insert(
        accountId: accountId,
        unreadMessagesCount: Value(unreadMessagesCountValue),
      ),
    );
  }
}
