import 'package:database_account/src/database.dart';
import 'package:database_converter/database_converter.dart';
import 'package:database_model/database_model.dart';
import 'package:drift/drift.dart';
import 'package:openapi/api.dart' as api;
import 'package:utils/utils.dart';

import '../../schema.dart' as schema;

part 'profile.g.dart';

@DriftAccessor(
  tables: [schema.Profile, schema.ProfileExtra, schema.FavoriteProfiles, schema.ReceivedLikesGrid],
)
class DaoWriteProfile extends DatabaseAccessor<AccountDatabase> with _$DaoWriteProfileMixin {
  DaoWriteProfile(super.db);

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
        profileVerificationStatus: Value(p.verificationStatus.v),
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
      for (final (i, c) in content.content.indexed) {
        await db.write.media.updateProfileContent(
          accountId,
          i,
          c.cid,
          c.accepted,
          c.faceDetected,
          c.faceVerified,
        );
      }

      await db.write.media.removeContentStartingFrom(accountId, content.content.length);

      await into(profile).insertOnConflictUpdate(
        ProfileCompanion.insert(
          accountId: accountId,
          primaryContentGridCropSize: Value(content.gridCropSize),
          primaryContentGridCropX: Value(content.gridCropX),
          primaryContentGridCropY: Value(content.gridCropY),
          mediaVerificationStatus: Value(content.verificationStatus.v),
          profileContentVersion: Value(contentVersion),
        ),
      );
    });
  }

  Future<void> updateProfileDataRefreshTimeToCurrentTime(api.AccountId accountId) async {
    final currentTime = UtcDateTime.now();
    await into(profileExtra).insertOnConflictUpdate(
      ProfileExtraCompanion.insert(
        accountId: accountId,
        profileDataRefreshTime: Value(currentTime),
      ),
    );
  }

  Future<void> updatePrivateProfileErrorTimeToCurrentTime(api.AccountId accountId) async {
    final currentTime = UtcDateTime.now();
    await into(profileExtra).insertOnConflictUpdate(
      ProfileExtraCompanion.insert(
        accountId: accountId,
        privateProfileErrorTime: Value(currentTime),
      ),
    );
  }

  Future<void> clearPrivateProfileErrorTime(api.AccountId accountId) async {
    await into(profileExtra).insertOnConflictUpdate(
      ProfileExtraCompanion.insert(
        accountId: accountId,
        privateProfileErrorTime: const Value(null),
      ),
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
    await setLocalAccountInteractionState(
      accountId,
      value ? LocalAccountInteractionState.receivedLike : null,
    );
  }

  Future<void> setSentLikeStatus(api.AccountId accountId, bool value) async {
    await setLocalAccountInteractionState(
      accountId,
      value ? LocalAccountInteractionState.sentLike : null,
    );
  }

  Future<void> setMatchStatus(api.AccountId accountId, bool value) async {
    await setLocalAccountInteractionState(
      accountId,
      value ? LocalAccountInteractionState.match : null,
    );
  }

  Future<void> setLocalAccountInteractionState(
    api.AccountId accountId,
    LocalAccountInteractionState? value,
  ) async {
    await into(profileExtra).insertOnConflictUpdate(
      ProfileExtraCompanion.insert(
        accountId: accountId,
        localAccountInteractionState: Value(value),
      ),
    );
  }

  Future<void> setProfileGridStatus(api.AccountId accountId, bool value) async {
    await into(profileExtra).insertOnConflictUpdate(
      ProfileExtraCompanion.insert(accountId: accountId, isInProfileGrid: _toGroupValue(value)),
    );
  }

  Future<void> addToReceivedLikesGrid(api.AccountId accountId) async {
    await transaction(() async {
      final lowestUnusedId = await _nextReceivedLikesGridId();
      await into(
        receivedLikesGrid,
      ).insert(ReceivedLikesGridCompanion.insert(id: Value(lowestUnusedId), accountId: accountId));
    });
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

  Future<void> clearReceivedLikesGrid() async {
    await delete(receivedLikesGrid).go();
  }

  Future<int> _nextReceivedLikesGridId() async {
    final maxIdExpression = receivedLikesGrid.id.max();
    final maxId = await (selectOnly(
      receivedLikesGrid,
    )..addColumns([maxIdExpression])).map((row) => row.read(maxIdExpression)).getSingle();

    if (maxId == null || maxId < 0) {
      return 0;
    }

    return maxId + 1;
  }

  Future<void> setProfileGridStatusList(
    List<api.AccountId>? accounts,
    bool value, {
    bool clear = false,
  }) async {
    await transaction(() async {
      if (clear) {
        await update(profileExtra).write(const ProfileExtraCompanion(isInProfileGrid: Value(null)));
      }
      for (final a in accounts ?? <api.AccountId>[]) {
        await setProfileGridStatus(a, value);
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
