


import 'package:database/src/message_entry.dart';
import 'package:openapi/api.dart' show AccountId, ProfileContent;
import 'package:openapi/api.dart' as api;
import 'package:utils/utils.dart';
import 'account_database.dart';

import 'package:drift/drift.dart';
import '../profile_entry.dart';
import '../utils.dart';

part 'profile_states_table.g.dart';

/// Moved from Profile table to avoid unnecessary emissions from
/// Stream<ProfileEntry>.
class ProfileStates extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get uuidAccountId => text().map(const AccountIdConverter()).unique()();

  // If column is not null, then it is in the specific group.
  // The time is the time when the profile was added to the group.
  IntColumn get isInFavorites => integer().map(const NullAwareTypeConverter.wrap(UtcDateTimeConverter())).nullable()();
  IntColumn get isInReceivedBlocks => integer().map(const NullAwareTypeConverter.wrap(UtcDateTimeConverter())).nullable()();
  IntColumn get isInReceivedLikes => integer().map(const NullAwareTypeConverter.wrap(UtcDateTimeConverter())).nullable()();
  IntColumn get isInSentBlocks => integer().map(const NullAwareTypeConverter.wrap(UtcDateTimeConverter())).nullable()();
  IntColumn get isInSentLikes => integer().map(const NullAwareTypeConverter.wrap(UtcDateTimeConverter())).nullable()();
  IntColumn get isInProfileGrid => integer().map(const NullAwareTypeConverter.wrap(UtcDateTimeConverter())).nullable()();
}

@DriftAccessor(tables: [ProfileStates])
class DaoProfileStates extends DatabaseAccessor<AccountDatabase> with _$DaoProfileStatesMixin {
  DaoProfileStates(AccountDatabase db) : super(db);

  Future<void> setFavoriteStatus(
    AccountId accountId,
    bool value,
  ) async {
    await into(profileStates).insert(
      ProfileStatesCompanion.insert(
        uuidAccountId: accountId,
        isInFavorites: _toGroupValue(value),
      ),
      onConflict: DoUpdate((old) => ProfileStatesCompanion(
        isInFavorites: _toGroupValue(value),
      ),
        target: [profileStates.uuidAccountId]
      ),
    );
  }

  Future<void> setReceivedBlockStatus(
    AccountId accountId,
    bool value,
  ) async {
    await into(profileStates).insert(
      ProfileStatesCompanion.insert(
        uuidAccountId: accountId,
        isInReceivedBlocks: _toGroupValue(value),
      ),
      onConflict: DoUpdate((old) => ProfileStatesCompanion(
        isInReceivedBlocks: _toGroupValue(value),
      ),
        target: [profileStates.uuidAccountId]
      ),
    );
  }

  Future<void> setReceivedLikeStatus(
    AccountId accountId,
    bool value,
  ) async {
    await into(profileStates).insert(
      ProfileStatesCompanion.insert(
        uuidAccountId: accountId,
        isInReceivedLikes: _toGroupValue(value),
      ),
      onConflict: DoUpdate((old) => ProfileStatesCompanion(
        isInReceivedLikes: _toGroupValue(value),
      ),
        target: [profileStates.uuidAccountId]
      ),
    );
  }

  Future<void> setSentBlockStatus(
    AccountId accountId,
    bool value,
  ) async {
    await into(profileStates).insert(
      ProfileStatesCompanion.insert(
        uuidAccountId: accountId,
        isInSentBlocks: _toGroupValue(value),
      ),
      onConflict: DoUpdate((old) => ProfileStatesCompanion(
        isInSentBlocks: _toGroupValue(value),
      ),
        target: [profileStates.uuidAccountId]
      ),
    );
  }

  Future<void> setSentLikeStatus(
    AccountId accountId,
    bool value,
  ) async {
    await into(profileStates).insert(
      ProfileStatesCompanion.insert(
        uuidAccountId: accountId,
        isInSentLikes: _toGroupValue(value),
      ),
      onConflict: DoUpdate((old) => ProfileStatesCompanion(
        isInSentLikes: _toGroupValue(value),
      ),
        target: [profileStates.uuidAccountId]
      ),
    );
  }

  Future<void> setProfileGridStatus(
    AccountId accountId,
    bool value,
  ) async {
    await into(profileStates).insert(
      ProfileStatesCompanion.insert(
        uuidAccountId: accountId,
        isInProfileGrid: _toGroupValue(value),
      ),
      onConflict: DoUpdate((old) => ProfileStatesCompanion(
        isInProfileGrid: _toGroupValue(value),
      ),
        target: [profileStates.uuidAccountId]
      ),
    );
  }

  Future<void> setFavoriteStatusList(List<AccountId>? accounts, bool value, {bool clear = false}) async {
    await transaction(() async {
      if (clear) {
        await update(profileStates)
          .write(const ProfileStatesCompanion(isInFavorites: Value(null)));
      }
      for (final a in accounts ?? <AccountId>[]) {
        await setFavoriteStatus(a, value);
      }
    });
  }


  Future<void> setReceivedBlockStatusList(api.ReceivedBlocksPage receivedBlocs) async {
    await transaction(() async {
      // Clear
      await update(profileStates)
        .write(const ProfileStatesCompanion(isInReceivedBlocks: Value(null)));

      for (final a in receivedBlocs.profiles) {
        await setReceivedBlockStatus(a, true);
      }

      await db.daoSyncVersions.updateSyncVersionReceivedBlocks(receivedBlocs.version);
    });
  }

  Future<void> setReceivedLikeStatusList(api.ReceivedLikesPage receivedLikes) async {
    await transaction(() async {
      // Clear
      await update(profileStates)
        .write(const ProfileStatesCompanion(isInReceivedLikes: Value(null)));

      for (final a in receivedLikes.profiles) {
        await setReceivedLikeStatus(a, true);
      }

      await db.daoSyncVersions.updateSyncVersionReceivedLikes(receivedLikes.version);
    });
  }

  Future<void> setSentBlockStatusList(api.SentBlocksPage sentBlocks) async {
    await transaction(() async {
      // Clear
      await update(profileStates)
        .write(const ProfileStatesCompanion(isInSentBlocks: Value(null)));

      for (final a in sentBlocks.profiles) {
        await setSentBlockStatus(a, true);
      }

      await db.daoSyncVersions.updateSyncVersionSentBlocks(sentBlocks.version);
    });
  }

  Future<void> setSentLikeStatusList(api.SentLikesPage sentLikes) async {
    await transaction(() async {
      // Clear
      await update(profileStates)
        .write(const ProfileStatesCompanion(isInSentLikes: Value(null)));

      for (final a in sentLikes.profiles) {
        await setSentLikeStatus(a, true);
      }

      await db.daoSyncVersions.updateSyncVersionSentLikes(sentLikes.version);
    });
  }

  Future<void> setProfileGridStatusList(List<AccountId>? accounts, bool value, {bool clear = false}) async {
    await transaction(() async {
      if (clear) {
        await update(profileStates)
          .write(const ProfileStatesCompanion(isInProfileGrid: Value(null)));
      }
      for (final a in accounts ?? <AccountId>[]) {
        await setProfileGridStatus(a, value);
      }
    });
  }

  Future<bool> isInFavorites(AccountId accountId) =>
    _existenceCheck(accountId, (t) => t.isInFavorites.isNotNull());


  Future<bool> isInReceivedBlocks(AccountId accountId) =>
    _existenceCheck(accountId, (t) => t.isInReceivedBlocks.isNotNull());

  Future<bool> isInReceivedLikes(AccountId accountId) =>
    _existenceCheck(accountId, (t) => t.isInReceivedLikes.isNotNull());

  Future<bool> isInSentBlocks(AccountId accountId) =>
    _existenceCheck(accountId, (t) => t.isInSentBlocks.isNotNull());

  Future<bool> isInSentLikes(AccountId accountId) =>
    _existenceCheck(accountId, (t) => t.isInSentLikes.isNotNull());

  Future<bool> isInProfileGrid(AccountId accountId) =>
    _existenceCheck(accountId, (t) => t.isInProfileGrid.isNotNull());

  Future<List<AccountId>> getFavoritesList(int startIndex, int limit) =>
    _getProfilesList(startIndex, limit, (t) => t.isInFavorites);

  Future<List<AccountId>> getReceivedBlocksList(int startIndex, int limit) =>
    _getProfilesList(startIndex, limit, (t) => t.isInReceivedBlocks);

  Future<List<AccountId>> getReceivedLikesList(int startIndex, int limit) =>
    _getProfilesList(startIndex, limit, (t) => t.isInReceivedLikes);

  Future<List<AccountId>> getSentBlocksList(int startIndex, int limit) =>
    _getProfilesList(startIndex, limit, (t) => t.isInSentBlocks);

  Future<List<AccountId>> getSentLikesList(int startIndex, int limit) =>
    _getProfilesList(startIndex, limit, (t) => t.isInSentLikes);

  Future<List<AccountId>> getProfileGridList(int startIndex, int limit) =>
    _getProfilesList(startIndex, limit, (t) => t.isInProfileGrid);

  Future<List<AccountId>> getReceivedBlocksListAll() =>
    _getProfilesList(null, null, (t) => t.isInReceivedBlocks);

  Future<List<AccountId>> _getProfilesList(int? startIndex, int? limit, GeneratedColumnWithTypeConverter<UtcDateTime?, int> Function($ProfileStatesTable) getter) async {
    final q = select(profileStates)
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

  Future<bool> _existenceCheck(AccountId accountId, Expression<bool> Function($ProfileStatesTable) additionalCheck) async {
    final r = await (select(profileStates)
      ..where((t) => Expression.and([
        t.uuidAccountId.equals(accountId.accountId),
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
}
