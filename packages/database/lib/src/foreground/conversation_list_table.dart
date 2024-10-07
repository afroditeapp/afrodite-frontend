


import 'package:database/src/message_entry.dart';
import 'package:openapi/api.dart' show AccountId, ProfileContent;
import 'package:openapi/api.dart' as api;
import 'package:utils/utils.dart';
import 'account_database.dart';

import 'package:drift/drift.dart';
import '../profile_entry.dart';
import '../utils.dart';

part 'conversation_list_table.g.dart';

/// Data for conversation list. This was previously in Profile table and
/// Drift watch feature caused too many emits from stream, so this data
/// is now in a separate table.
class ConversationList extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get uuidAccountId => text().map(const AccountIdConverter()).unique()();

  IntColumn get conversationLastChangedTime => integer().map(const NullAwareTypeConverter.wrap(UtcDateTimeConverter())).nullable()();

  // If column is not null, then it is in the specific group.
  // The time is the time when the profile was added to the group.
  IntColumn get isInConversationList => integer().map(const NullAwareTypeConverter.wrap(UtcDateTimeConverter())).nullable()();
  // Sent blocks is here to make conversation list updates faster.
  IntColumn get isInSentBlocks => integer().map(const NullAwareTypeConverter.wrap(UtcDateTimeConverter())).nullable()();
}

@DriftAccessor(tables: [ConversationList])
class DaoConversationList extends DatabaseAccessor<AccountDatabase> with _$DaoConversationListMixin {
  DaoConversationList(AccountDatabase db) : super(db);

  Future<void> setConversationListVisibility(
    AccountId accountId,
    bool value,
  ) async {
    await into(conversationList).insert(
      ConversationListCompanion.insert(
        uuidAccountId: accountId,
        isInConversationList: _toGroupValue(value),
      ),
      onConflict: DoUpdate((old) => ConversationListCompanion(
        isInConversationList: _toGroupValue(value),
      ),
        target: [conversationList.uuidAccountId]
      ),
    );
  }

  Future<void> setSentBlockStatus(
    AccountId accountId,
    bool value,
  ) async {
    await into(conversationList).insert(
      ConversationListCompanion.insert(
        uuidAccountId: accountId,
        isInSentBlocks: _toGroupValue(value),
      ),
      onConflict: DoUpdate((old) => ConversationListCompanion(
        isInSentBlocks: _toGroupValue(value),
      ),
        target: [conversationList.uuidAccountId]
      ),
    );
  }

  Future<void> setSentBlockStatusList(api.SentBlocksPage sentBlocks) async {
    await transaction(() async {
      // Clear
      await update(conversationList)
        .write(const ConversationListCompanion(isInSentBlocks: Value(null)));

      for (final a in sentBlocks.profiles) {
        await setSentBlockStatus(a, true);
      }
    });
  }

  Future<bool> isInConversationList(AccountId accountId) =>
    _existenceCheck(accountId, (t) => t.isInConversationList.isNotNull());

  Future<bool> isInSentBlocks(AccountId accountId) =>
    _existenceCheck(accountId, (t) => t.isInSentBlocks.isNotNull());

  Future<bool> _existenceCheck(AccountId accountId, Expression<bool> Function($ConversationListTable) additionalCheck) async {
    final r = await (select(conversationList)
      ..where((t) => Expression.and([
        t.uuidAccountId.equals(accountId.aid),
        additionalCheck(t),
       ]))
    ).getSingleOrNull();
    return r != null;
  }

  Value<UtcDateTime?> _toGroupValue(bool value) {
    if (value) {
      return Value(UtcDateTime.now());
    } else {
      return const Value(null);
    }
  }

  Future<List<AccountId>> getConversationListNoBlocked(int? startIndex, int? limit) async {
    final q = select(conversationList)
      ..where((t) => t.isInConversationList.isNotNull() & t.isInSentBlocks.isNull())
      ..orderBy([
        (t) => OrderingTerm(expression: t.isInConversationList),
        // If list is added, the time values can have same value, so
        // order by id to make the order deterministic.
        (t) => OrderingTerm(expression: t.id),
      ]);

    if (limit != null) {
      q.limit(limit, offset: startIndex);
    }

    final r = await q
      .map((t) => t.uuidAccountId)
      .get();

    return r;
  }

  Future<List<AccountId>> getSentBlocksList(int startIndex, int limit) =>
    _getProfilesList(startIndex, limit, (t) => t.isInSentBlocks);

  Future<List<AccountId>> _getProfilesList(int? startIndex, int? limit, GeneratedColumnWithTypeConverter<UtcDateTime?, int> Function($ConversationListTable) getter) async {
    final q = select(conversationList)
      ..where((t) => getter(t).isNotNull())
      ..orderBy([
        (t) => OrderingTerm(expression: getter(t)),
        // If list is added, the time values can have same value, so
        // order by id to make the order deterministic.
        (t) => OrderingTerm(expression: t.id),
      ]);

    if (limit != null) {
      q.limit(limit, offset: startIndex);
    }

    final r = await q
      .map((t) => t.uuidAccountId)
      .get();

    return r;
  }

  Future<UtcDateTime?> getConversationLastChanged(AccountId accountId) async {
    final r = await (select(conversationList)
      ..where((t) => t.uuidAccountId.equals(accountId.aid))
    )
      .getSingleOrNull();

    return r?.conversationLastChangedTime;
  }

  Future<void> setCurrentTimeToConversationLastChanged(AccountId accountId) async {
    final currentTime = UtcDateTime.now();
    await into(conversationList).insert(
      ConversationListCompanion.insert(
        uuidAccountId: accountId,
        conversationLastChangedTime: Value(currentTime),
      ),
      onConflict: DoUpdate((old) => ConversationListCompanion(
        conversationLastChangedTime: Value(currentTime),
      ),
        target: [conversationList.uuidAccountId]
      ),
    );
  }

  // Latest conversation is the first one in the emitted list
  Stream<List<AccountId>> watchConversationList() {
    return (selectOnly(conversationList)
      ..addColumns([conversationList.uuidAccountId])
      ..where(conversationList.isInConversationList.isNotNull() & conversationList.isInSentBlocks.isNull())
      ..orderBy([
        OrderingTerm(
          expression: conversationList.conversationLastChangedTime,
          mode: OrderingMode.desc,
        ),
        // Use ID ordering if there is same time values
        OrderingTerm(
          expression: conversationList.id,
          mode: OrderingMode.desc,
        ),
      ])
    )
      .map((r) {
        final raw = r.read(conversationList.uuidAccountId)!;
        return AccountId(aid: raw);
      })
      .watch();
  }
}
