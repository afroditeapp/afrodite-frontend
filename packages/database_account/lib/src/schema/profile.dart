import 'package:database_converter/database_converter.dart';
import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';

class MyProfile extends SingleRowTable {
  TextColumn get profileName => text().nullable()();
  BoolColumn get profileNameAccepted => boolean().nullable()();
  TextColumn get profileNameModerationState => text()
      .map(NullAwareTypeConverter.wrap(const ProfileStringModerationStateConverter()))
      .nullable()();
  IntColumn get profileNameModerationRejectedCategory => integer()
      .map(
        const NullAwareTypeConverter.wrap(ProfileStringModerationRejectedReasonCategoryConverter()),
      )
      .nullable()();
  TextColumn get profileNameModerationRejectedDetails => text()
      .map(
        const NullAwareTypeConverter.wrap(ProfileStringModerationRejectedReasonDetailsConverter()),
      )
      .nullable()();
  TextColumn get profileText => text().nullable()();
  BoolColumn get profileTextAccepted => boolean().nullable()();
  TextColumn get profileTextModerationState => text()
      .map(NullAwareTypeConverter.wrap(const ProfileStringModerationStateConverter()))
      .nullable()();
  IntColumn get profileTextModerationRejectedCategory => integer()
      .map(
        const NullAwareTypeConverter.wrap(ProfileStringModerationRejectedReasonCategoryConverter()),
      )
      .nullable()();
  TextColumn get profileTextModerationRejectedDetails => text()
      .map(
        const NullAwareTypeConverter.wrap(ProfileStringModerationRejectedReasonDetailsConverter()),
      )
      .nullable()();
  IntColumn get profileAge => integer().nullable()();
  BoolColumn get profileUnlimitedLikes => boolean().nullable()();
  IntColumn get profileVerificationStatus => integer().nullable()();
  TextColumn get profileVersion =>
      text().map(const NullAwareTypeConverter.wrap(ProfileVersionConverter())).nullable()();
  TextColumn get jsonProfileAttributes =>
      text().map(NullAwareTypeConverter.wrap(const ProfileAttributeValueConverter())).nullable()();

  // Profile content
  IntColumn get mediaVerificationStatus => integer().nullable()();
  RealColumn get primaryContentGridCropSize => real().nullable()();
  RealColumn get primaryContentGridCropX => real().nullable()();
  RealColumn get primaryContentGridCropY => real().nullable()();
  TextColumn get profileContentVersion =>
      text().map(const NullAwareTypeConverter.wrap(ProfileContentVersionConverter())).nullable()();
}

class ProfileLocation extends SingleRowTable {
  RealColumn get latitude => real().nullable()();
  RealColumn get longitude => real().nullable()();
}

class ProfileSearchGroups extends SingleRowTable {
  TextColumn get jsonProfileSearchGroups =>
      text().map(NullAwareTypeConverter.wrap(const SearchGroupsConverter())).nullable()();
}

class ProfileFilters extends SingleRowTable {
  TextColumn get jsonProfileFilters =>
      text().map(NullAwareTypeConverter.wrap(const GetProfileFiltersConverter())).nullable()();
}

class ProfileSearchAgeRange extends SingleRowTable {
  IntColumn get minAge => integer().nullable()();
  IntColumn get maxAge => integer().nullable()();
}

class InitialProfileAge extends SingleRowTable {
  IntColumn get initialProfileAgeSetUnixTime =>
      integer().map(const NullAwareTypeConverter.wrap(UtcDateTimeConverter())).nullable()();
  IntColumn get initialProfileAge => integer().nullable()();
}

class Profile extends Table {
  TextColumn get accountId => text().map(const AccountIdConverter())();

  TextColumn get profileName => text().nullable()();
  BoolColumn get profileNameAccepted => boolean().nullable()();
  TextColumn get profileText => text().nullable()();
  BoolColumn get profileTextAccepted => boolean().nullable()();
  TextColumn get profileVersion =>
      text().map(const NullAwareTypeConverter.wrap(ProfileVersionConverter())).nullable()();
  IntColumn get profileAge => integer().nullable()();
  IntColumn get profileLastSeenTimeValue => integer().nullable()();
  BoolColumn get profileUnlimitedLikes => boolean().nullable()();
  IntColumn get profileVerificationStatus => integer().nullable()();
  TextColumn get jsonProfileAttributes =>
      text().map(NullAwareTypeConverter.wrap(const ProfileAttributeValueConverter())).nullable()();

  // Profile content
  IntColumn get mediaVerificationStatus => integer().nullable()();
  RealColumn get primaryContentGridCropSize => real().nullable()();
  RealColumn get primaryContentGridCropX => real().nullable()();
  RealColumn get primaryContentGridCropY => real().nullable()();
  TextColumn get profileContentVersion =>
      text().map(const NullAwareTypeConverter.wrap(ProfileContentVersionConverter())).nullable()();

  IntColumn get newLikeInfoReceivedTime =>
      integer().map(const NullAwareTypeConverter.wrap(UtcDateTimeConverter())).nullable()();

  @override
  Set<Column<Object>> get primaryKey => {accountId};
}

/// Data related to user profiles which does not affect
/// Drift's watch performance that much.
class ProfileExtra extends Table {
  TextColumn get accountId => text().map(const AccountIdConverter())();

  IntColumn get profileDataRefreshTime =>
      integer().map(const NullAwareTypeConverter.wrap(UtcDateTimeConverter())).nullable()();
  IntColumn get privateProfileErrorTime =>
      integer().map(const NullAwareTypeConverter.wrap(UtcDateTimeConverter())).nullable()();

  // If column is not null, then it is in the specific group.
  // The time is the time when the profile was added to the group.
  IntColumn get isInReceivedLikes =>
      integer().map(const NullAwareTypeConverter.wrap(UtcDateTimeConverter())).nullable()();
  IntColumn get isInSentLikes =>
      integer().map(const NullAwareTypeConverter.wrap(UtcDateTimeConverter())).nullable()();
  IntColumn get isInMatches =>
      integer().map(const NullAwareTypeConverter.wrap(UtcDateTimeConverter())).nullable()();

  IntColumn get isInProfileGrid =>
      integer().map(const NullAwareTypeConverter.wrap(UtcDateTimeConverter())).nullable()();
  IntColumn get isInAutomaticProfileSearchGrid =>
      integer().map(const NullAwareTypeConverter.wrap(UtcDateTimeConverter())).nullable()();
  IntColumn get isInReceivedLikesGrid =>
      integer().map(const NullAwareTypeConverter.wrap(UtcDateTimeConverter())).nullable()();
  IntColumn get isInMatchesGrid =>
      integer().map(const NullAwareTypeConverter.wrap(UtcDateTimeConverter())).nullable()();

  @override
  Set<Column<Object>> get primaryKey => {accountId};
}

class FavoriteProfiles extends Table {
  TextColumn get accountId => text().map(const AccountIdConverter())();
  IntColumn get addedToFavoritesUnixTime => integer().map(UtcDateTimeConverter())();

  @override
  Set<Column<Object>> get primaryKey => {accountId};
}

class AutomaticProfileSearchSettings extends SingleRowTable {
  TextColumn get jsonAutomaticProfileSearchSettings => text()
      .map(NullAwareTypeConverter.wrap(const AutomaticProfileSearchSettingsConverter()))
      .nullable()();
}

class ProfilePrivacySettings extends SingleRowTable {
  BoolColumn get lastSeenTime => boolean().clientDefault(() => false)();
  BoolColumn get onlineStatus => boolean().clientDefault(() => false)();
}

class AutomaticProfileSearchBadgeState extends SingleRowTable {
  IntColumn get profileCount => integer().clientDefault(() => 0)();
  BoolColumn get showBadge => boolean().clientDefault(() => false)();
}
