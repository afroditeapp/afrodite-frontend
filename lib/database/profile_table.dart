


import 'package:openapi/api.dart' show AccountId, ProfileContent;
import 'package:openapi/api.dart' as api;
import 'package:pihka_frontend/database/account_database.dart';

import 'package:drift/drift.dart';
import 'package:pihka_frontend/database/profile_entry.dart';
import 'package:pihka_frontend/database/utils.dart';
import 'package:pihka_frontend/utils/date.dart';

part 'profile_table.g.dart';

class Profiles extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get uuidAccountId => text().map(const AccountIdConverter()).unique()();

  /// Primary content ID for the profile.
  TextColumn get uuidContentId0 => text().map(const NullAwareTypeConverter.wrap(ContentIdConverter())).nullable()();
  TextColumn get uuidContentId1 => text().map(const NullAwareTypeConverter.wrap(ContentIdConverter())).nullable()();
  TextColumn get uuidContentId2 => text().map(const NullAwareTypeConverter.wrap(ContentIdConverter())).nullable()();
  TextColumn get uuidContentId3 => text().map(const NullAwareTypeConverter.wrap(ContentIdConverter())).nullable()();
  TextColumn get uuidContentId4 => text().map(const NullAwareTypeConverter.wrap(ContentIdConverter())).nullable()();
  TextColumn get uuidContentId5 => text().map(const NullAwareTypeConverter.wrap(ContentIdConverter())).nullable()();

  TextColumn get profileName => text().nullable()();
  TextColumn get profileText => text().nullable()();
  TextColumn get profileVersion => text().nullable()();
  IntColumn get profileAge => integer().nullable()();
  // TextColumn get jsonProfileAttributes => text().nullable()();

  // If column is not null, then it is in the specific group.
  // The time is the time when the profile was added to the group.
  IntColumn get isInFavorites => integer().map(const NullAwareTypeConverter.wrap(UtcDateTimeConverter())).nullable()();
  IntColumn get isInMatches => integer().map(const NullAwareTypeConverter.wrap(UtcDateTimeConverter())).nullable()();
  IntColumn get isInReceivedBlocks => integer().map(const NullAwareTypeConverter.wrap(UtcDateTimeConverter())).nullable()();
  IntColumn get isInReceivedLikes => integer().map(const NullAwareTypeConverter.wrap(UtcDateTimeConverter())).nullable()();
  IntColumn get isInSentBlocks => integer().map(const NullAwareTypeConverter.wrap(UtcDateTimeConverter())).nullable()();
  IntColumn get isInSentLikes => integer().map(const NullAwareTypeConverter.wrap(UtcDateTimeConverter())).nullable()();
  IntColumn get isInProfileGrid => integer().map(const NullAwareTypeConverter.wrap(UtcDateTimeConverter())).nullable()();
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
        isInFavorites: _toGroupValue(value),
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
        isInMatches: _toGroupValue(value),
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
        isInReceivedBlocks: _toGroupValue(value),
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
        isInReceivedLikes: _toGroupValue(value),
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
        isInSentBlocks: _toGroupValue(value),
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
        isInSentLikes: _toGroupValue(value),
      ),
    );
  }

  Future<void> setProfileGridStatus(
    AccountId accountId,
    bool value,
  ) async {
    await into(profiles).insertOnConflictUpdate(
      ProfilesCompanion.insert(
        uuidAccountId: accountId,
        isInProfileGrid: _toGroupValue(value),
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

  Future<void> setProfileGridStatusList(List<AccountId>? accounts, bool value, {bool clear = false}) async {
    await transaction(() async {
      if (clear) {
        await update(profiles)
          .write(const ProfilesCompanion(isInProfileGrid: Value(null)));
      }
      for (final a in accounts ?? <AccountId>[]) {
        await setProfileGridStatus(a, value);
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

  Future<bool> isInProfileGrid(AccountId accountId) =>
    _existenceCheck(accountId, (t) => t.isInProfileGrid.isNotNull());

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

  Future<List<AccountId>> getProfileGridList(int startIndex, int limit) =>
    _getProfilesList(startIndex, limit, (t) => t.isInProfileGrid);

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

  Value<UtcDateTime?> _toGroupValue(bool value) {
    if (value) {
      return Value(UtcDateTime.now());
    } else {
      return const Value(null);
    }
  }

  Future<void> removeProfileData(AccountId accountId) async {
    await (update(profiles)..where((t) => t.uuidAccountId.equals(accountId.accountId)))
      .write(const ProfilesCompanion(
        uuidContentId0: Value(null),
        uuidContentId1: Value(null),
        uuidContentId2: Value(null),
        uuidContentId3: Value(null),
        uuidContentId4: Value(null),
        uuidContentId5: Value(null),
        profileName: Value(null),
        profileText: Value(null),
        profileAge: Value(null),
        profileVersion: Value(null),
        // jsonProfileAttributes: Value(null),
      ));
  }

  Future<void> updateProfileData(AccountId accountId, api.Profile profile) async {
    await into(profiles).insertOnConflictUpdate(
      ProfilesCompanion.insert(
        uuidAccountId: accountId,
        profileName: Value(profile.name),
        profileText: Value(profile.profileText),
        profileAge: Value(profile.age),
        profileVersion: Value(profile.version),
      ),
    );
  }

  Future<void> updateProfileContent(AccountId accountId, ProfileContent content) async {
    await into(profiles).insertOnConflictUpdate(
      ProfilesCompanion.insert(
        uuidAccountId: accountId,
        uuidContentId0: Value(content.contentId0?.id),
        uuidContentId1: Value(content.contentId1?.id),
        uuidContentId2: Value(content.contentId2?.id),
        uuidContentId3: Value(content.contentId3?.id),
        uuidContentId4: Value(content.contentId4?.id),
        uuidContentId5: Value(content.contentId5?.id),
      ),
    );
  }

  Future<ProfileEntry?> getProfileEntry(AccountId accountId) async {
    final r = await (select(profiles)
      ..where((t) => t.uuidAccountId.equals(accountId.accountId))
    )
      .getSingleOrNull();

    if (r == null) {
      return null;
    }

    final content0 = r.uuidContentId0;
    final profileName = r.profileName;
    final profileText = r.profileText;
    final profileAge = r.profileAge;
    final profileVersion = r.profileVersion;

    if (content0 != null && profileName != null && profileText != null && profileAge != null && profileVersion != null) {
      return ProfileEntry(
        uuid: r.uuidAccountId,
        imageUuid: content0,
        name: profileName,
        profileText: profileText,
        version: profileVersion,
        age: profileAge,
        content1: r.uuidContentId1,
        content2: r.uuidContentId2,
        content3: r.uuidContentId3,
        content4: r.uuidContentId4,
        content5: r.uuidContentId5,
      );
    } else {
      return null;
    }
  }

  Future<List<ProfileEntry>> convertToProfileEntries(List<AccountId> accounts) async {
    final data = <ProfileEntry>[];
    for (final a in accounts) {
      final entry = await getProfileEntry(a);
      if (entry != null) {
        data.add(entry);
      }
    }
    return data;
  }
}
