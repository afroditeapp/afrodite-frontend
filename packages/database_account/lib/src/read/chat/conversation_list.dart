import 'package:database_account/src/database.dart';
import 'package:drift/drift.dart';
import 'package:openapi/api.dart' as api;
import 'package:utils/utils.dart';

import '../../schema.dart' as schema;

part 'conversation_list.g.dart';

@DriftAccessor(tables: [schema.ConversationList])
class DaoReadConversationList extends DatabaseAccessor<AccountDatabase>
    with _$DaoReadConversationListMixin {
  DaoReadConversationList(super.db);

  Future<bool> isInSentBlocks(api.AccountId accountId) =>
      _existenceCheck(accountId, (t) => t.isInSentBlocks.isNotNull());

  Future<bool> _existenceCheck(
    api.AccountId accountId,
    Expression<bool> Function($ConversationListTable) additionalCheck,
  ) async {
    final r =
        await (select(conversationList)..where(
              (t) => Expression.and([t.accountId.equals(accountId.aid), additionalCheck(t)]),
            ))
            .getSingleOrNull();
    return r != null;
  }

  Future<List<api.AccountId>> getConversationListNoBlocked(int? startIndex, int? limit) async {
    final q = select(conversationList)
      ..where((t) => t.conversationLastChangedTime.isNotNull() & t.isInSentBlocks.isNull())
      ..orderBy([
        (t) => OrderingTerm(expression: t.conversationLastChangedTime),
        // If list is added, the time values can have same value, so
        // order by AccountId to make the order deterministic.
        (t) => OrderingTerm(expression: t.accountId),
      ]);

    if (limit != null) {
      q.limit(limit, offset: startIndex);
    }

    final r = await q.map((t) => t.accountId).get();

    return r;
  }

  Future<List<api.AccountId>> getSentBlocksList(int startIndex, int limit) =>
      _getProfilesList(startIndex, limit, (t) => t.isInSentBlocks);

  Future<List<api.AccountId>> _getProfilesList(
    int? startIndex,
    int? limit,
    GeneratedColumnWithTypeConverter<UtcDateTime?, int> Function($ConversationListTable) getter,
  ) async {
    final q = select(conversationList)
      ..where((t) => getter(t).isNotNull())
      ..orderBy([
        (t) => OrderingTerm(expression: getter(t)),
        // If list is added, the time values can have same value, so
        // order by AccountId to make the order deterministic.
        (t) => OrderingTerm(expression: t.accountId),
      ]);

    if (limit != null) {
      q.limit(limit, offset: startIndex);
    }

    final r = await q.map((t) => t.accountId).get();

    return r;
  }

  Future<UtcDateTime?> getConversationLastChanged(api.AccountId accountId) async {
    final r = await (select(
      conversationList,
    )..where((t) => t.accountId.equals(accountId.aid))).getSingleOrNull();

    return r?.conversationLastChangedTime;
  }

  // Latest conversation is the first one in the emitted list
  Stream<List<api.AccountId>> watchConversationList() {
    return (selectOnly(conversationList)
          ..addColumns([conversationList.accountId])
          ..where(
            conversationList.conversationLastChangedTime.isNotNull() &
                conversationList.isInSentBlocks.isNull(),
          )
          ..orderBy([
            OrderingTerm(
              expression: conversationList.conversationLastChangedTime,
              mode: OrderingMode.desc,
            ),
            // Use AccountId ordering if there is same time values
            OrderingTerm(expression: conversationList.accountId, mode: OrderingMode.desc),
          ]))
        .map((r) {
          final raw = r.read(conversationList.accountId)!;
          return api.AccountId(aid: raw);
        })
        .watch();
  }
}
