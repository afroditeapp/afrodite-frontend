


import 'package:async/async.dart' show StreamExtensions;
import 'package:database/src/model/profile_thumbnail.dart';
import 'package:openapi/api.dart' show AccountId, ProfileContent;
import 'package:openapi/api.dart' as api;
import 'package:rxdart/rxdart.dart';
import 'package:utils/utils.dart';
import 'account_database.dart';

import 'package:drift/drift.dart';
import '../profile_entry.dart';
import '../utils.dart';

part 'profile_table.g.dart';

class Profiles extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get uuidAccountId => text().map(const AccountIdConverter()).unique()();

  TextColumn get profileContentVersion => text().map(const NullAwareTypeConverter.wrap(ProfileContentVersionConverter())).nullable()();

  TextColumn get profileName => text().nullable()();
  BoolColumn get profileNameAccepted => boolean().nullable()();
  TextColumn get profileText => text().nullable()();
  BoolColumn get profileTextAccepted => boolean().nullable()();
  TextColumn get profileVersion => text().map(const NullAwareTypeConverter.wrap(ProfileVersionConverter())).nullable()();
  IntColumn get profileAge => integer().nullable()();
  IntColumn get profileLastSeenTimeValue => integer().nullable()();
  BoolColumn get profileUnlimitedLikes => boolean().nullable()();
  TextColumn get jsonProfileAttributes => text().map(NullAwareTypeConverter.wrap(JsonList.driftConverter)).nullable()();

  RealColumn get primaryContentGridCropSize => real().nullable()();
  RealColumn get primaryContentGridCropX => real().nullable()();
  RealColumn get primaryContentGridCropY => real().nullable()();

  IntColumn get profileDataRefreshTime => integer().map(const NullAwareTypeConverter.wrap(UtcDateTimeConverter())).nullable()();
  IntColumn get newLikeInfoReceivedTime => integer().map(const NullAwareTypeConverter.wrap(UtcDateTimeConverter())).nullable()();
}

@DriftAccessor(tables: [Profiles])
class DaoProfiles extends DatabaseAccessor<AccountDatabase> with _$DaoProfilesMixin {
  DaoProfiles(AccountDatabase db) : super(db);

  Future<void> removeProfileData(AccountId accountId) async {
    await (update(profiles)..where((t) => t.uuidAccountId.equals(accountId.aid)))
      .write(const ProfilesCompanion(
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
      ));
  }

  /// If you call this make sure that profile data in background DB
  /// is also updated.
  Future<void> updateProfileData(AccountId accountId, api.Profile profile, api.ProfileVersion profileVersion, int? profileLastSeenTime) async {
    await into(profiles).insert(
      ProfilesCompanion.insert(
        uuidAccountId: accountId,
        profileName: Value(profile.name),
        profileNameAccepted: Value(profile.nameAccepted),
        profileText: Value(profile.ptext),
        profileTextAccepted: Value(profile.ptextAccepted),
        profileAge: Value(profile.age),
        profileVersion: Value(profileVersion),
        profileLastSeenTimeValue: Value(profileLastSeenTime),
        profileUnlimitedLikes: Value(profile.unlimitedLikes),
        jsonProfileAttributes: Value(profile.attributes.toJsonList()),
      ),
      onConflict: DoUpdate((old) => ProfilesCompanion(
        profileName: Value(profile.name),
        profileNameAccepted: Value(profile.nameAccepted),
        profileText: Value(profile.ptext),
        profileTextAccepted: Value(profile.ptextAccepted),
        profileAge: Value(profile.age),
        profileVersion: Value(profileVersion),
        profileLastSeenTimeValue: Value(profileLastSeenTime),
        profileUnlimitedLikes: Value(profile.unlimitedLikes),
        jsonProfileAttributes: Value(profile.attributes.toJsonList()),
      ),
        target: [profiles.uuidAccountId]
      ),
    );
  }

  Future<void> updateProfileLastSeenTime(AccountId accountId, int? profileLastSeenTime) async {
    await into(profiles).insert(
      ProfilesCompanion.insert(
        uuidAccountId: accountId,
        profileLastSeenTimeValue: Value(profileLastSeenTime),
      ),
      onConflict: DoUpdate((old) => ProfilesCompanion(
        profileLastSeenTimeValue: Value(profileLastSeenTime),
      ),
        target: [profiles.uuidAccountId]
      ),
    );
  }

  Future<void> updateNewLikeInfoReceivedTimeToCurrentTime(AccountId accountId) async {
    final currentTime = UtcDateTime.now();
    await into(profiles).insert(
      ProfilesCompanion.insert(
        uuidAccountId: accountId,
        newLikeInfoReceivedTime: Value(currentTime),
      ),
      onConflict: DoUpdate((old) => ProfilesCompanion(
        newLikeInfoReceivedTime: Value(currentTime),
      ),
        target: [profiles.uuidAccountId]
      ),
    );
  }

  Future<void> updateProfileContent(
    AccountId accountId,
    ProfileContent content,
    api.ProfileContentVersion contentVersion,
  ) async {
    await transaction(() async {
      for (final (i, c) in content.c.indexed) {
        await db.daoPublicProfileContent.updateProfileContent(accountId, i, c.cid, c.a, c.p);
      }

      await db.daoPublicProfileContent.removeContentStartingFrom(accountId, content.c.length);

      await into(profiles).insert(
        ProfilesCompanion.insert(
          uuidAccountId: accountId,
          primaryContentGridCropSize: Value(content.gridCropSize),
          primaryContentGridCropX: Value(content.gridCropX),
          primaryContentGridCropY: Value(content.gridCropY),
          profileContentVersion: Value(contentVersion),
        ),
        onConflict: DoUpdate((old) => ProfilesCompanion(
          primaryContentGridCropSize: Value(content.gridCropSize),
          primaryContentGridCropX: Value(content.gridCropX),
          primaryContentGridCropY: Value(content.gridCropY),
          profileContentVersion: Value(contentVersion),
        ),
          target: [profiles.uuidAccountId]
        ),
      );
    });
  }

  Future<ProfileEntry?> getProfileEntry(AccountId accountId) async {
    final r = await (select(profiles)
      ..where((t) => t.uuidAccountId.equals(accountId.aid))
    )
      .getSingleOrNull();

    final content = await db.daoPublicProfileContent.watchAllProfileContent(accountId).firstOrNull ?? [];

    return _rowToProfileEntry(r, content);
  }

  Stream<ProfileEntry?> watchProfileEntry(AccountId accountId) =>
    Rx.combineLatest2(
      (select(profiles)
        ..where((t) => t.uuidAccountId.equals(accountId.aid))
      )
        .watchSingleOrNull(),
      db.daoPublicProfileContent.watchAllProfileContent(accountId),
      (r, content) => _rowToProfileEntry(r, content),
    );

  Stream<ProfileThumbnail?> watchProfileThumbnail(AccountId accountId) =>
    Rx.combineLatest3(
      (select(profiles)
        ..where((t) => t.uuidAccountId.equals(accountId.aid))
      )
        .watchSingleOrNull(),
      db.daoPublicProfileContent.watchAllProfileContent(accountId),
      db.daoProfileStates.watchFavoriteProfileStatus(accountId),
      (r, content, isFavorite) {
        final entry = _rowToProfileEntry(r, content);
        if (entry == null) {
          return null;
        } else {
          return ProfileThumbnail(entry: entry, isFavorite: isFavorite);
        }
      }
    );

  ProfileEntry? _rowToProfileEntry(Profile? r, List<ContentIdAndAccepted> content) {
    if (r == null) {
      return null;
    }

    final gridCropSize = r.primaryContentGridCropSize ?? 1.0;
    final gridCropX = r.primaryContentGridCropX ?? 0.0;
    final gridCropY = r.primaryContentGridCropY ?? 0.0;
    final profileName = r.profileName;
    final profileNameAccepted = r.profileNameAccepted;
    final profileTextAccepted = r.profileTextAccepted;
    final profileText = r.profileText;
    final profileAge = r.profileAge;
    final profileVersion = r.profileVersion;
    final profileAttributes = r.jsonProfileAttributes?.toProfileAttributes();
    final profileUnlimitedLikes = r.profileUnlimitedLikes;
    final contentVersion = r.profileContentVersion;

    if (
      profileName != null &&
      profileNameAccepted != null &&
      profileText != null &&
      profileTextAccepted != null &&
      profileAge != null &&
      profileVersion != null &&
      profileAttributes != null &&
      profileUnlimitedLikes != null &&
      contentVersion != null
    ) {
      return ProfileEntry(
        uuid: r.uuidAccountId,
        content: content,
        primaryContentGridCropSize: gridCropSize,
        primaryContentGridCropX: gridCropX,
        primaryContentGridCropY: gridCropY,
        name: profileName,
        nameAccepted: profileNameAccepted,
        profileText: profileText,
        profileTextAccepted: profileTextAccepted,
        version: profileVersion,
        age: profileAge,
        attributeIdAndStateMap: profileAttributes,
        unlimitedLikes: profileUnlimitedLikes,
        contentVersion: contentVersion,
        lastSeenTimeValue: r.profileLastSeenTimeValue,
        newLikeInfoReceivedTime: r.newLikeInfoReceivedTime,
      );
    } else {
      return null;
    }
  }

  Future<ProfileLocalDbId?> getProfileLocalDbId(AccountId accountId) async {
    final r = await (select(profiles)
      ..where((t) => t.uuidAccountId.equals(accountId.aid))
    )
      .getSingleOrNull();

    if (r == null) {
      return null;
    }

    return ProfileLocalDbId(r.id);
  }

  Future<ProfileEntry?> getProfileEntryUsingLocalId(ProfileLocalDbId localId) async {
    final r = await (select(profiles)
      ..where((t) => t.id.equals(localId.id))
    )
      .getSingleOrNull();

    if (r == null) {
      return null;
    }

    final content = await db.daoPublicProfileContent.watchAllProfileContent(r.uuidAccountId).firstOrNull ?? [];

    return _rowToProfileEntry(r, content);
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

  Future<UtcDateTime?> getProfileDataRefreshTime(AccountId accountId) async {
    final r = await (select(profiles)
      ..where((t) => t.uuidAccountId.equals(accountId.aid))
    )
      .getSingleOrNull();

    if (r == null) {
      return null;
    }

    return r.profileDataRefreshTime;
  }

  Future<void> updateProfileDataRefreshTimeToCurrentTime(AccountId accountId) async {
    final currentTime = UtcDateTime.now();
    await into(profiles).insert(
      ProfilesCompanion.insert(
        uuidAccountId: accountId,
        profileDataRefreshTime: Value(currentTime),
      ),
      onConflict: DoUpdate((old) => ProfilesCompanion(
        profileDataRefreshTime: Value(currentTime),
      ),
        target: [profiles.uuidAccountId]
      ),
    );
  }
}
