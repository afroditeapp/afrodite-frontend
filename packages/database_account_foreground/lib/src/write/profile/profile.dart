import 'package:database_account_foreground/src/database.dart';
import 'package:database_converter/database_converter.dart';
import 'package:drift/drift.dart';
import 'package:openapi/api.dart' as api;
import 'package:utils/utils.dart';

import '../../schema.dart' as schema;

part 'profile.g.dart';

@DriftAccessor(tables: [schema.Profile, schema.ProfileStates, schema.FavoriteProfiles])
class DaoWriteProfile extends DatabaseAccessor<AccountForegroundDatabase>
    with _$DaoWriteProfileMixin {
  DaoWriteProfile(super.db);

  Future<void> removeProfileData(api.AccountId accountId) async {
    await (update(profile)..where((t) => t.accountId.equals(accountId.aid))).write(
      const ProfileCompanion(
        profileContentVersion: Value(null),
        profileName: Value(null),
        profileNameAccepted: Value(null),
        profileText: Value(null),
        profileTextAccepted: Value(null),
        profileAge: Value(null),
        profileVersion: Value(null),
        profileLastSeenTimeValue: Value(null),
        profileUnlimitedLikes: Value(null),
        jsonProfileAttributes: Value(null),
        primaryContentGridCropSize: Value(null),
        primaryContentGridCropX: Value(null),
        primaryContentGridCropY: Value(null),
        profileDataRefreshTime: Value(null),
        newLikeInfoReceivedTime: Value(null),
      ),
    );
  }

  /// If you call this make sure that profile data in background DB
  /// is also updated.
  Future<void> updateProfileData(
    api.AccountId accountId,
    api.Profile p,
    api.ProfileVersion profileVersion,
    int? profileLastSeenTime,
  ) async {
    await into(profile).insertOnConflictUpdate(
      ProfileCompanion.insert(
        accountId: accountId,
        profileName: Value(p.name),
        profileNameAccepted: Value(p.nameAccepted),
        profileText: Value(p.ptext),
        profileTextAccepted: Value(p.ptextAccepted),
        profileAge: Value(p.age),
        profileVersion: Value(profileVersion),
        profileLastSeenTimeValue: Value(profileLastSeenTime),
        profileUnlimitedLikes: Value(p.unlimitedLikes),
        jsonProfileAttributes: Value(p.attributes.toJsonList()),
      ),
    );
  }

  Future<void> updateProfileLastSeenTimeIfNeeded(
    api.AccountId accountId,
    int? profileLastSeenTime,
  ) async {
    final currentLastSeenTime = await (select(
      profile,
    )..where((t) => t.accountId.equals(accountId.aid))).getSingleOrNull();

    if (currentLastSeenTime?.profileLastSeenTimeValue != profileLastSeenTime) {
      await into(profile).insertOnConflictUpdate(
        ProfileCompanion.insert(
          accountId: accountId,
          profileLastSeenTimeValue: Value(profileLastSeenTime),
        ),
      );
    }
  }

  Future<void> updateNewLikeInfoReceivedTimeToCurrentTime(
    Iterable<api.AccountId> accountIds,
  ) async {
    final currentTime = UtcDateTime.now();
    await transaction(() async {
      for (final a in accountIds) {
        await into(profile).insertOnConflictUpdate(
          ProfileCompanion.insert(accountId: a, newLikeInfoReceivedTime: Value(currentTime)),
        );
      }
    });
  }

  Future<void> updateProfileContent(
    api.AccountId accountId,
    api.ProfileContent content,
    api.ProfileContentVersion contentVersion,
  ) async {
    await transaction(() async {
      for (final (i, c) in content.c.indexed) {
        await db.write.media.updateProfileContent(accountId, i, c.cid, c.a, c.p);
      }

      await db.write.media.removeContentStartingFrom(accountId, content.c.length);

      await into(profile).insertOnConflictUpdate(
        ProfileCompanion.insert(
          accountId: accountId,
          primaryContentGridCropSize: Value(content.gridCropSize),
          primaryContentGridCropX: Value(content.gridCropX),
          primaryContentGridCropY: Value(content.gridCropY),
          profileContentVersion: Value(contentVersion),
        ),
      );
    });
  }

  Future<void> updateProfileDataRefreshTimeToCurrentTime(api.AccountId accountId) async {
    final currentTime = UtcDateTime.now();
    await into(profile).insertOnConflictUpdate(
      ProfileCompanion.insert(accountId: accountId, profileDataRefreshTime: Value(currentTime)),
    );
  }

  Future<void> setFavoriteStatus(api.AccountId accountId, bool value) async {
    if (value) {
      await into(favoriteProfiles).insertOnConflictUpdate(
        FavoriteProfilesCompanion.insert(
          accountId: accountId,
          addedToFavoritesUnixTime: UtcDateTime.now(),
        ),
      );
    } else {
      await (delete(favoriteProfiles)..where((t) => t.accountId.equals(accountId.aid))).go();
    }
  }

  Future<void> setFavoriteStatusWithTime(api.AccountId accountId, int unixTime) async {
    final utcTime = UtcDateTime.fromUnixEpoch(unixTime);
    await into(favoriteProfiles).insertOnConflictUpdate(
      FavoriteProfilesCompanion.insert(accountId: accountId, addedToFavoritesUnixTime: utcTime),
    );
  }

  Future<void> setReceivedLikeStatus(api.AccountId accountId, bool value) async {
    await into(profileStates).insertOnConflictUpdate(
      ProfileStatesCompanion.insert(accountId: accountId, isInReceivedLikes: _toGroupValue(value)),
    );
  }

  Future<void> setSentLikeStatus(api.AccountId accountId, bool value) async {
    await into(profileStates).insertOnConflictUpdate(
      ProfileStatesCompanion.insert(accountId: accountId, isInSentLikes: _toGroupValue(value)),
    );
  }

  Future<void> setMatchStatus(api.AccountId accountId, bool value) async {
    await into(profileStates).insertOnConflictUpdate(
      ProfileStatesCompanion.insert(accountId: accountId, isInMatches: _toGroupValue(value)),
    );
  }

  Future<void> setProfileGridStatus(api.AccountId accountId, bool value) async {
    await into(profileStates).insertOnConflictUpdate(
      ProfileStatesCompanion.insert(accountId: accountId, isInProfileGrid: _toGroupValue(value)),
    );
  }

  Future<void> setAutomaticProfileSearchGridStatus(api.AccountId accountId, bool value) async {
    await into(profileStates).insertOnConflictUpdate(
      ProfileStatesCompanion.insert(
        accountId: accountId,
        isInAutomaticProfileSearchGrid: _toGroupValue(value),
      ),
    );
  }

  Future<void> setReceivedLikeGridStatus(api.AccountId accountId, bool value) async {
    await into(profileStates).insertOnConflictUpdate(
      ProfileStatesCompanion.insert(
        accountId: accountId,
        isInReceivedLikesGrid: _toGroupValue(value),
      ),
    );
  }

  Future<void> setMatchesGridStatus(api.AccountId accountId, bool value) async {
    await into(profileStates).insertOnConflictUpdate(
      ProfileStatesCompanion.insert(accountId: accountId, isInMatchesGrid: _toGroupValue(value)),
    );
  }

  Future<void> replaceFavorites(List<api.AccountId> accounts) async {
    await transaction(() async {
      await delete(favoriteProfiles).go();
      for (final (i, a) in accounts.indexed) {
        // Order the favorites so that oldest added favorite has unix time 0.
        await setFavoriteStatusWithTime(a, i);
      }
    });
  }

  Future<void> setReceivedLikeStatusList(
    List<api.AccountId>? accounts,
    bool value, {
    bool clear = false,
  }) async {
    await transaction(() async {
      if (clear) {
        await update(
          profileStates,
        ).write(const ProfileStatesCompanion(isInReceivedLikes: Value(null)));
      }
      for (final a in accounts ?? <api.AccountId>[]) {
        await setReceivedLikeStatus(a, value);
      }
    });
  }

  Future<void> setReceivedLikeGridStatusList(
    List<api.AccountId>? accounts,
    bool value, {
    bool clear = false,
  }) async {
    await transaction(() async {
      if (clear) {
        await update(
          profileStates,
        ).write(const ProfileStatesCompanion(isInReceivedLikesGrid: Value(null)));
      }
      for (final a in accounts ?? <api.AccountId>[]) {
        await setReceivedLikeGridStatus(a, value);
      }
    });
  }

  Future<void> setMatchesGridStatusList(
    List<api.AccountId>? accounts,
    bool value, {
    bool clear = false,
  }) async {
    await transaction(() async {
      if (clear) {
        await update(
          profileStates,
        ).write(const ProfileStatesCompanion(isInMatchesGrid: Value(null)));
      }
      for (final a in accounts ?? <api.AccountId>[]) {
        await setMatchesGridStatus(a, value);
      }
    });
  }

  Future<void> setProfileGridStatusList(
    List<api.AccountId>? accounts,
    bool value, {
    bool clear = false,
  }) async {
    await transaction(() async {
      if (clear) {
        await update(
          profileStates,
        ).write(const ProfileStatesCompanion(isInProfileGrid: Value(null)));
      }
      for (final a in accounts ?? <api.AccountId>[]) {
        await setProfileGridStatus(a, value);
      }
    });
  }

  Future<void> setAutomaticProfileSearchGridStatusList(
    List<api.AccountId>? accounts,
    bool value, {
    bool clear = false,
  }) async {
    await transaction(() async {
      if (clear) {
        await update(
          profileStates,
        ).write(const ProfileStatesCompanion(isInAutomaticProfileSearchGrid: Value(null)));
      }
      for (final a in accounts ?? <api.AccountId>[]) {
        await setAutomaticProfileSearchGridStatus(a, value);
      }
    });
  }

  Value<UtcDateTime?> _toGroupValue(bool value) {
    if (value) {
      return Value(UtcDateTime.now());
    } else {
      return const Value(null);
    }
  }
}
