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
class DaoReadUnreadMessagesCount extends DatabaseAccessor<AccountBackgroundDatabase> with _$DaoReadUnreadMessagesCountMixin {
  DaoReadUnreadMessagesCount(super.db);

  Future<UnreadMessagesCount?> getUnreadMessageCount(api.AccountId accountId) async {
    final r = await (select(unreadMessagesCount)
      ..where((t) => t.uuidAccountId.equals(accountId.aid))
    )
      .getSingleOrNull();

    return r?.unreadMessagesCount;
  }

  Stream<UnreadMessagesCount?> watchUnreadMessageCount(api.AccountId accountId) {
    return (selectOnly(unreadMessagesCount)
      ..addColumns([unreadMessagesCount.unreadMessagesCount])
      ..where(unreadMessagesCount.uuidAccountId.equals(accountId.aid))
    )
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
    final countExpression = countAll(filter: unreadMessagesCount.unreadMessagesCount.isBiggerThanValue(0));
    return (selectOnly(unreadMessagesCount)
      ..addColumns([countExpression])
    )
      .map((r) {
        return r.read(countExpression);
      })
      .watchSingleOrNull();
  }

}
