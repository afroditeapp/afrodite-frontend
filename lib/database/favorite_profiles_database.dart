


import 'package:openapi/api.dart';
import 'package:pihka_frontend/database/account_database.dart';

import 'package:drift/drift.dart';
import 'package:pihka_frontend/utils/date.dart';

part 'favorite_profiles_database.g.dart';

class Profiles extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get uuidAccountId => text().map(const AccountIdConverter()).unique()();

  TextColumn get uuidPrimaryImage => text().map(const NullAwareTypeConverter.wrap(ContentIdConverter())).nullable()();
  TextColumn get profileName => text().map(const NullAwareTypeConverter.wrap(ContentIdConverter())).nullable()();
  TextColumn get profileText => text().map(const NullAwareTypeConverter.wrap(ContentIdConverter())).nullable()();

  // If column is not null, then it is in the specific group.
  // The time is the time when the profile was added to the group.
  IntColumn get isInFavorites => integer().map(const NullAwareTypeConverter.wrap(UtcDateTimeConverter())).nullable()();
  IntColumn get isInMatches => integer().map(const NullAwareTypeConverter.wrap(UtcDateTimeConverter())).nullable()();
  IntColumn get isInReceivedBlocks => integer().map(const NullAwareTypeConverter.wrap(UtcDateTimeConverter())).nullable()();
  IntColumn get isInReceivedLikes => integer().map(const NullAwareTypeConverter.wrap(UtcDateTimeConverter())).nullable()();
  IntColumn get isInSentBlocks => integer().map(const NullAwareTypeConverter.wrap(UtcDateTimeConverter())).nullable()();
  IntColumn get isInSentLikes => integer().map(const NullAwareTypeConverter.wrap(UtcDateTimeConverter())).nullable()();
}

@DriftAccessor(tables: [Profiles])
class DaoProfiles extends DatabaseAccessor<AccountDatabase> with _$DaoProfilesMixin {
  DaoProfiles(AccountDatabase db) : super(db);

  Future<void> setFavoriteStatus(
    AccountId accountId,
    bool value,
  ) async {
    await into(profiles).insertOnConflictUpdate(
      ProfilesCompanion.insert(
        uuidAccountId: accountId,
        isInFavorites: toGroupValue(value),
      ),
    );
  }

  Future<void> setMatchStatus(
    AccountId accountId,
    bool value,
  ) async {
    await into(profiles).insertOnConflictUpdate(
      ProfilesCompanion.insert(
        uuidAccountId: accountId,
        isInMatches: toGroupValue(value),
      ),
    );
  }

  Future<void> setReceivedBlockStatus(
    AccountId accountId,
    bool value,
  ) async {
    await into(profiles).insertOnConflictUpdate(
      ProfilesCompanion.insert(
        uuidAccountId: accountId,
        isInReceivedBlocks: toGroupValue(value),
      ),
    );
  }

  Future<void> setReceivedLikeStatus(
    AccountId accountId,
    bool value,
  ) async {
    await into(profiles).insertOnConflictUpdate(
      ProfilesCompanion.insert(
        uuidAccountId: accountId,
        isInReceivedLikes: toGroupValue(value),
      ),
    );
  }

  Future<void> setSentBlockStatus(
    AccountId accountId,
    bool value,
  ) async {
    await into(profiles).insertOnConflictUpdate(
      ProfilesCompanion.insert(
        uuidAccountId: accountId,
        isInSentBlocks: toGroupValue(value),
      ),
    );
  }

  Future<void> setSentLikeStatus(
    AccountId accountId,
    bool value,
  ) async {
    await into(profiles).insertOnConflictUpdate(
      ProfilesCompanion.insert(
        uuidAccountId: accountId,
        isInSentLikes: toGroupValue(value),
      ),
    );
  }

  Future<void> setFavoriteStatusList(List<AccountId>? accounts, bool value, {bool clear = false}) async {
    await transaction(() async {
      if (clear) {
        await update(profiles)
          .write(const ProfilesCompanion(isInFavorites: Value(null)));
      }
      for (final a in accounts ?? <AccountId>[]) {
        await setFavoriteStatus(a, value);
      }
    });
  }

  Future<void> setMatchStatusList(List<AccountId>? accounts, bool value, {bool clear = false}) async {
    await transaction(() async {
      if (clear) {
        await update(profiles)
          .write(const ProfilesCompanion(isInMatches: Value(null)));
      }
      for (final a in accounts ?? <AccountId>[]) {
        await setMatchStatus(a, value);
      }
    });
  }

  Future<void> setReceivedBlockStatusList(List<AccountId>? accounts, bool value, {bool clear = false}) async {
    await transaction(() async {
      if (clear) {
        await update(profiles)
          .write(const ProfilesCompanion(isInReceivedBlocks: Value(null)));
      }
      for (final a in accounts ?? <AccountId>[]) {
        await setReceivedBlockStatus(a, value);
      }
    });
  }

  Future<void> setReceivedLikeStatusList(List<AccountId>? accounts, bool value, {bool clear = false}) async {
    await transaction(() async {
      if (clear) {
        await update(profiles)
          .write(const ProfilesCompanion(isInReceivedLikes: Value(null)));
      }
      for (final a in accounts ?? <AccountId>[]) {
        await setReceivedLikeStatus(a, value);
      }
    });
  }

  Future<void> setSentBlockStatusList(List<AccountId>? accounts, bool value, {bool clear = false}) async {
    await transaction(() async {
      if (clear) {
        await update(profiles)
          .write(const ProfilesCompanion(isInSentBlocks: Value(null)));
      }
      for (final a in accounts ?? <AccountId>[]) {
        await setSentBlockStatus(a, value);
      }
    });
  }

  Future<void> setSentLikeStatusList(List<AccountId>? accounts, bool value, {bool clear = false}) async {
    await transaction(() async {
      if (clear) {
        await update(profiles)
          .write(const ProfilesCompanion(isInSentLikes: Value(null)));
      }
      for (final a in accounts ?? <AccountId>[]) {
        await setSentLikeStatus(a, value);
      }
    });
  }

  Future<bool> isInFavorites(AccountId accountId) =>
    _existenceCheck(accountId, (t) => t.isInFavorites.isNotNull());

  Future<bool> isInMatches(AccountId accountId) =>
    _existenceCheck(accountId, (t) => t.isInMatches.isNotNull());

  Future<bool> isInReceivedBlocks(AccountId accountId) =>
    _existenceCheck(accountId, (t) => t.isInReceivedBlocks.isNotNull());

  Future<bool> isInReceivedLikes(AccountId accountId) =>
    _existenceCheck(accountId, (t) => t.isInReceivedLikes.isNotNull());

  Future<bool> isInSentBlocks(AccountId accountId) =>
    _existenceCheck(accountId, (t) => t.isInSentBlocks.isNotNull());

  Future<bool> isInSentLikes(AccountId accountId) =>
    _existenceCheck(accountId, (t) => t.isInSentLikes.isNotNull());

  Future<List<AccountId>> getFavoritesList(int startIndex, int limit) =>
    _getProfilesList(startIndex, limit, (t) => t.isInFavorites);

  Future<List<AccountId>> getMatchesList(int startIndex, int limit) =>
    _getProfilesList(startIndex, limit, (t) => t.isInMatches);

  Future<List<AccountId>> getReceivedBlocksList(int startIndex, int limit) =>
    _getProfilesList(startIndex, limit, (t) => t.isInReceivedBlocks);

  Future<List<AccountId>> getReceivedLikesList(int startIndex, int limit) =>
    _getProfilesList(startIndex, limit, (t) => t.isInReceivedLikes);

  Future<List<AccountId>> getSentBlocksList(int startIndex, int limit) =>
    _getProfilesList(startIndex, limit, (t) => t.isInSentBlocks);

  Future<List<AccountId>> getSentLikesList(int startIndex, int limit) =>
    _getProfilesList(startIndex, limit, (t) => t.isInSentLikes);

  Future<List<AccountId>> getReceivedBlocksListAll() =>
    _getProfilesList(null, null, (t) => t.isInReceivedBlocks);

  Future<List<AccountId>> _getProfilesList(int? startIndex, int? limit, GeneratedColumnWithTypeConverter<UtcDateTime?, int> Function($ProfilesTable) getter) async {
    final q = select(profiles)
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

  Future<bool> _existenceCheck(AccountId accountId, Expression<bool> Function($ProfilesTable) additionalCheck) async {
    final r = await (select(profiles)
      ..where((t) => Expression.and([
        t.uuidAccountId.equals(accountId.accountId),
        additionalCheck(t),
       ]))
    ).getSingleOrNull();
    return r != null;
  }

  Value<UtcDateTime?> toGroupValue(bool value) {
    if (value) {
      return Value(UtcDateTime.now());
    } else {
      return const Value(null);
    }
  }
}

class AccountIdConverter extends TypeConverter<AccountId, String> {
  const AccountIdConverter();

  @override
  AccountId fromSql(fromDb) {
    return AccountId(accountId: fromDb);
  }

  @override
  String toSql(value) {
    return value.accountId;
  }
}

class ContentIdConverter extends TypeConverter<ContentId, String> {
  const ContentIdConverter();

  @override
  ContentId fromSql(fromDb) {
    return ContentId(contentId: fromDb);
  }

  @override
  String toSql(value) {
    return value.contentId;
  }
}

class UtcDateTimeConverter extends TypeConverter<UtcDateTime, int> {
  const UtcDateTimeConverter();

  @override
  UtcDateTime fromSql(fromDb) {
    return UtcDateTime.fromUnixEpochMilliseconds(fromDb);
  }

  @override
  int toSql(value) {
    return value.toUnixEpochMilliseconds();
  }
}
