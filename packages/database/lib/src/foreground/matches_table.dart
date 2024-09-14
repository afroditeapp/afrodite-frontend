


import 'package:database/src/message_entry.dart';
import 'package:openapi/api.dart' show AccountId, ProfileContent;
import 'package:openapi/api.dart' as api;
import 'package:utils/utils.dart';
import 'account_database.dart';

import 'package:drift/drift.dart';
import '../profile_entry.dart';
import '../utils.dart';

part 'matches_table.g.dart';

/// Data for conversation list. This was previously in Profile table and
/// Drift watch feature caused too many emits from stream, so this data
/// is now in a separate table.
class Matches extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get uuidAccountId => text().map(const AccountIdConverter()).unique()();

  IntColumn get conversationLastChangedTime => integer().map(const NullAwareTypeConverter.wrap(UtcDateTimeConverter())).nullable()();

  // If column is not null, then it is in the specific group.
  // The time is the time when the profile was added to the group.
  IntColumn get isInMatches => integer().map(const NullAwareTypeConverter.wrap(UtcDateTimeConverter())).nullable()();
}

@DriftAccessor(tables: [Matches])
class DaoMatches extends DatabaseAccessor<AccountDatabase> with _$DaoMatchesMixin {
  DaoMatches(AccountDatabase db) : super(db);

  Future<void> setMatchStatus(
    AccountId accountId,
    bool value,
  ) async {
    await into(matches).insert(
      MatchesCompanion.insert(
        uuidAccountId: accountId,
        isInMatches: _toGroupValue(value),
      ),
      onConflict: DoUpdate((old) => MatchesCompanion(
        isInMatches: _toGroupValue(value),
      ),
        target: [matches.uuidAccountId]
      ),
    );
  }

  Future<void> setMatchStatusList(api.MatchesPage matchesPage) async {
    await transaction(() async {
      // Clear
      await update(matches)
        .write(const MatchesCompanion(isInMatches: Value(null)));

      for (final a in matchesPage.profiles) {
        await setMatchStatus(a, true);
      }

      await db.daoSyncVersions.updateSyncVersionMatches(matchesPage.version);
    });
  }

  Future<bool> isInMatches(AccountId accountId) =>
    _existenceCheck(accountId, (t) => t.isInMatches.isNotNull());

  Future<bool> _existenceCheck(AccountId accountId, Expression<bool> Function($MatchesTable) additionalCheck) async {
    final r = await (select(matches)
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

  Future<List<AccountId>> getMatchesList(int startIndex, int limit) =>
    _getProfilesList(startIndex, limit, (t) => t.isInMatches);

  Future<List<AccountId>> _getProfilesList(int? startIndex, int? limit, GeneratedColumnWithTypeConverter<UtcDateTime?, int> Function($MatchesTable) getter) async {
    final q = select(matches)
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
    final r = await (select(matches)
      ..where((t) => t.uuidAccountId.equals(accountId.aid))
    )
      .getSingleOrNull();

    return r?.conversationLastChangedTime;
  }

  Future<void> setCurrentTimeToConversationLastChanged(AccountId accountId) async {
    final currentTime = UtcDateTime.now();
    await into(matches).insert(
      MatchesCompanion.insert(
        uuidAccountId: accountId,
        conversationLastChangedTime: Value(currentTime),
      ),
      onConflict: DoUpdate((old) => MatchesCompanion(
        conversationLastChangedTime: Value(currentTime),
      ),
        target: [matches.uuidAccountId]
      ),
    );
  }

  // Latest conversation is the first one in the emitted list
  Stream<List<AccountId>> watchConversationList() {
    return (selectOnly(matches)
      ..addColumns([matches.uuidAccountId])
      ..where(matches.isInMatches.isNotNull())
      ..orderBy([
        OrderingTerm(
          expression: matches.conversationLastChangedTime,
          mode: OrderingMode.desc,
        ),
        // Use ID ordering if there is same time values
        OrderingTerm(
          expression: matches.id,
          mode: OrderingMode.desc,
        ),
      ])
    )
      .map((r) {
        final raw = r.read(matches.uuidAccountId)!;
        return AccountId(aid: raw);
      })
      .watch();
  }
}
