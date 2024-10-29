


import 'package:openapi/api.dart' show AccountId, ProfileContent;
import 'package:openapi/api.dart' as api;
import 'package:utils/utils.dart';
import 'account_database.dart';

import 'package:drift/drift.dart';
import '../profile_entry.dart';
import '../utils.dart';

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
  TextColumn get profileContentVersion => text().map(const NullAwareTypeConverter.wrap(ProfileContentVersionConverter())).nullable()();

  TextColumn get profileName => text().nullable()();
  BoolColumn get profileNameAccepted => boolean().nullable()();
  TextColumn get profileText => text().nullable()();
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
        uuidContentId0: Value(null),
        uuidContentId1: Value(null),
        uuidContentId2: Value(null),
        uuidContentId3: Value(null),
        uuidContentId4: Value(null),
        uuidContentId5: Value(null),
        profileContentVersion: Value(null),
        profileName: Value(null),
        profileNameAccepted: Value(null),
        profileText: Value(null),
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
    api.ProfileContentVersion contentVersion
  ) async {
    await into(profiles).insert(
      ProfilesCompanion.insert(
        uuidAccountId: accountId,
        uuidContentId0: Value(content.c0?.cid),
        uuidContentId1: Value(content.c1?.cid),
        uuidContentId2: Value(content.c2?.cid),
        uuidContentId3: Value(content.c3?.cid),
        uuidContentId4: Value(content.c4?.cid),
        uuidContentId5: Value(content.c5?.cid),
        primaryContentGridCropSize: Value(content.gridCropSize),
        primaryContentGridCropX: Value(content.gridCropX),
        primaryContentGridCropY: Value(content.gridCropY),
        profileContentVersion: Value(contentVersion),
      ),
      onConflict: DoUpdate((old) => ProfilesCompanion(
        uuidContentId0: Value(content.c0?.cid),
        uuidContentId1: Value(content.c1?.cid),
        uuidContentId2: Value(content.c2?.cid),
        uuidContentId3: Value(content.c3?.cid),
        uuidContentId4: Value(content.c4?.cid),
        uuidContentId5: Value(content.c5?.cid),
        primaryContentGridCropSize: Value(content.gridCropSize),
        primaryContentGridCropX: Value(content.gridCropX),
        primaryContentGridCropY: Value(content.gridCropY),
        profileContentVersion: Value(contentVersion),
      ),
        target: [profiles.uuidAccountId]
      ),
    );
  }

  Future<ProfileEntry?> getProfileEntry(AccountId accountId) async {
    final r = await (select(profiles)
      ..where((t) => t.uuidAccountId.equals(accountId.aid))
    )
      .getSingleOrNull();

    return _rowToProfileEntry(r);
  }

  Stream<ProfileEntry?> watchProfileEntry(AccountId accountId) {
    return (select(profiles)
      ..where((t) => t.uuidAccountId.equals(accountId.aid))
    )
      .map((t) => _rowToProfileEntry(t))
      .watchSingleOrNull();
  }

  ProfileEntry? _rowToProfileEntry(Profile? r) {
    if (r == null) {
      return null;
    }

    final content0 = r.uuidContentId0;
    final gridCropSize = r.primaryContentGridCropSize ?? 1.0;
    final gridCropX = r.primaryContentGridCropX ?? 0.0;
    final gridCropY = r.primaryContentGridCropY ?? 0.0;
    final profileName = r.profileName;
    final profileNameAccepted = r.profileNameAccepted;
    final profileText = r.profileText;
    final profileAge = r.profileAge;
    final profileVersion = r.profileVersion;
    final profileAttributes = r.jsonProfileAttributes?.toProfileAttributes();
    final profileUnlimitedLikes = r.profileUnlimitedLikes;
    final contentVersion = r.profileContentVersion;

    if (
      content0 != null &&
      profileName != null &&
      profileNameAccepted != null &&
      profileText != null &&
      profileAge != null &&
      profileVersion != null &&
      profileAttributes != null &&
      profileUnlimitedLikes != null &&
      contentVersion != null
    ) {
      return ProfileEntry(
        uuid: r.uuidAccountId,
        imageUuid: content0,
        primaryContentGridCropSize: gridCropSize,
        primaryContentGridCropX: gridCropX,
        primaryContentGridCropY: gridCropY,
        name: profileName,
        nameAccepted: profileNameAccepted,
        profileText: profileText,
        version: profileVersion,
        age: profileAge,
        attributes: profileAttributes,
        unlimitedLikes: profileUnlimitedLikes,
        contentVersion: contentVersion,
        lastSeenTimeValue: r.profileLastSeenTimeValue,
        content1: r.uuidContentId1,
        content2: r.uuidContentId2,
        content3: r.uuidContentId3,
        content4: r.uuidContentId4,
        content5: r.uuidContentId5,
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

    return _rowToProfileEntry(r);
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
