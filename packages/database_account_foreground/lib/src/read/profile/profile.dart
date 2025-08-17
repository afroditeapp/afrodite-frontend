
import 'package:async/async.dart';
import 'package:database_account_foreground/src/database.dart';
import 'package:database_converter/database_converter.dart';
import 'package:database_model/database_model.dart';
import 'package:drift/drift.dart';
import 'package:openapi/api.dart' as api;
import 'package:rxdart/rxdart.dart';
import 'package:utils/utils.dart';

import '../../schema.dart' as schema;

part 'profile.g.dart';

@DriftAccessor(
  tables: [
    schema.Profile,
    schema.ProfileStates,
    schema.FavoriteProfiles,
  ]
)
class DaoReadProfile extends DatabaseAccessor<AccountForegroundDatabase> with _$DaoReadProfileMixin {
  DaoReadProfile(super.db);


  Future<ProfileEntry?> getProfileEntry(api.AccountId accountId) async {
    final r = await (select(profile)
      ..where((t) => t.accountId.equals(accountId.aid))
    )
      .getSingleOrNull();

    final content = await db.read.media.watchAllProfileContent(accountId).firstOrNull ?? [];

    return _rowToProfileEntry(r, content);
  }

  Stream<ProfileEntry?> watchProfileEntry(api.AccountId accountId) =>
    Rx.combineLatest2(
      (select(profile)
        ..where((t) => t.accountId.equals(accountId.aid))
      )
        .watchSingleOrNull(),
      db.read.media.watchAllProfileContent(accountId),
      (r, content) => _rowToProfileEntry(r, content),
    );

  Stream<ProfileThumbnail?> watchProfileThumbnail(api.AccountId accountId) =>
    Rx.combineLatest3(
      (select(profile)
        ..where((t) => t.accountId.equals(accountId.aid))
      )
        .watchSingleOrNull(),
      db.read.media.watchAllProfileContent(accountId),
      watchFavoriteProfileStatus(accountId),
      (r, content, isFavorite) {
        final entry = _rowToProfileEntry(r, content);
        if (entry == null) {
          return null;
        } else {
          return ProfileThumbnail(entry: entry, isFavorite: isFavorite);
        }
      }
    );

  ProfileEntry? _rowToProfileEntry(ProfileData? r, List<ContentIdAndAccepted> content) {
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
    final profileAttributes = r.jsonProfileAttributes?.value.toProfileAttributesMap();
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
        accountId: r.accountId,
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

  Future<List<ProfileEntry>> convertToProfileEntries(List<api.AccountId> accounts) async {
    final data = <ProfileEntry>[];
    for (final a in accounts) {
      final entry = await getProfileEntry(a);
      if (entry != null) {
        data.add(entry);
      }
    }
    return data;
  }

  Future<UtcDateTime?> getProfileDataRefreshTime(api.AccountId accountId) async {
    final r = await (select(profile)
      ..where((t) => t.accountId.equals(accountId.aid))
    )
      .getSingleOrNull();

    if (r == null) {
      return null;
    }

    return r.profileDataRefreshTime;
  }

  Future<bool> isInFavorites(api.AccountId accountId) async {
    return await (select(favoriteProfiles)
      ..where((t) => t.accountId.equals(accountId.aid))
    ).getSingleOrNull() != null;
  }

  Future<bool> isInReceivedLikes(api.AccountId accountId) =>
    _existenceCheck(accountId, (t) => t.isInReceivedLikes.isNotNull());

  Future<bool> isInSentLikes(api.AccountId accountId) =>
    _existenceCheck(accountId, (t) => t.isInSentLikes.isNotNull());

  Future<bool> isInMatches(api.AccountId accountId) =>
    _existenceCheck(accountId, (t) => t.isInMatches.isNotNull());

  Future<bool> isInProfileGrid(api.AccountId accountId) =>
    _existenceCheck(accountId, (t) => t.isInProfileGrid.isNotNull());

  Future<bool> isInReceivedLikesGrid(api.AccountId accountId) =>
    _existenceCheck(accountId, (t) => t.isInReceivedLikesGrid.isNotNull());

  Future<bool> isInMatchesGrid(api.AccountId accountId) =>
    _existenceCheck(accountId, (t) => t.isInMatchesGrid.isNotNull());

  Future<List<api.AccountId>> getFavoritesList(int startIndex, int limit) =>
    (select(favoriteProfiles)
      ..orderBy([
        (t) => OrderingTerm(expression: t.addedToFavoritesUnixTime, mode: OrderingMode.desc),
        (t) => OrderingTerm(expression: t.accountId),
      ])
      ..limit(limit, offset: startIndex)
    )
      .map((t) => t.accountId)
      .get();

  Future<List<api.AccountId>> getReceivedLikesList(int startIndex, int limit) =>
    _getProfilesList(startIndex, limit, (t) => t.isInReceivedLikes);

  Future<List<api.AccountId>> getSentLikesList(int startIndex, int limit) =>
    _getProfilesList(startIndex, limit, (t) => t.isInSentLikes);

  Future<List<api.AccountId>> getProfileGridList(int startIndex, int limit) =>
    _getProfilesList(startIndex, limit, (t) => t.isInProfileGrid);

  Future<List<api.AccountId>> getAutomaticProfileSearchGridList(int startIndex, int limit) =>
    _getProfilesList(startIndex, limit, (t) => t.isInAutomaticProfileSearchGrid);

  Future<List<api.AccountId>> getReceivedLikesGridList(int startIndex, int limit) =>
    _getProfilesList(startIndex, limit, (t) => t.isInReceivedLikesGrid);

  Future<List<api.AccountId>> getMatchesGridList(int startIndex, int limit) =>
    _getProfilesList(startIndex, limit, (t) => t.isInMatchesGrid);

  Future<List<api.AccountId>> _getProfilesList(
    int? startIndex,
    int limit,
    GeneratedColumnWithTypeConverter<UtcDateTime?, int> Function($ProfileStatesTable) getter,
    {
      OrderingMode mode = OrderingMode.asc,
    }
  ) => (select(profileStates)
    ..where((t) => getter(t).isNotNull())
    ..orderBy([
      (t) => OrderingTerm(expression: getter(t), mode: mode),
      // If list is added, the time values can have same value, so
      // order by AccountId to make the order deterministic.
      (t) => OrderingTerm(expression: t.accountId),
    ])
    ..limit(limit, offset: startIndex)
  )
    .map((t) => t.accountId)
    .get();

  Future<bool> _existenceCheck(api.AccountId accountId, Expression<bool> Function($ProfileStatesTable) additionalCheck) async {
    final r = await (select(profileStates)
      ..where((t) => Expression.and([
        t.accountId.equals(accountId.aid),
        additionalCheck(t),
       ]))
    ).getSingleOrNull();
    return r != null;
  }

  Stream<bool> watchFavoriteProfileStatus(api.AccountId accountId) {
    return (select(favoriteProfiles)
      ..where((t) => t.accountId.equals(accountId.aid))
    )
      .watchSingleOrNull()
      .map((r) => r != null);
  }
}
