import 'package:database_converter/database_converter.dart';
import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';

class MyProfile extends SingleRowTable {
  TextColumn get profileName => text().nullable()();
  BoolColumn get profileNameAccepted => boolean().nullable()();
  TextColumn get profileNameModerationState => text().map(NullAwareTypeConverter.wrap(const ProfileStringModerationStateConverter())).nullable()();
  TextColumn get profileText => text().nullable()();
  BoolColumn get profileTextAccepted => boolean().nullable()();
  TextColumn get profileTextModerationState => text().map(NullAwareTypeConverter.wrap(const ProfileStringModerationStateConverter())).nullable()();
  IntColumn get profileTextModerationRejectedCategory => integer().map(const NullAwareTypeConverter.wrap(ProfileStringModerationRejectedReasonCategoryConverter())).nullable()();
  TextColumn get profileTextModerationRejectedDetails => text().map(const NullAwareTypeConverter.wrap(ProfileTextModerationRejectedReasonDetailsConverter())).nullable()();
  IntColumn get profileAge => integer().nullable()();
  BoolColumn get profileUnlimitedLikes => boolean().nullable()();
  TextColumn get profileVersion => text().map(const NullAwareTypeConverter.wrap(ProfileVersionConverter())).nullable()();
  TextColumn get jsonProfileAttributes => text().map(NullAwareTypeConverter.wrap(const ProfileAttributeValueConverter())).nullable()();

  // Profile content
  RealColumn get primaryContentGridCropSize => real().nullable()();
  RealColumn get primaryContentGridCropX => real().nullable()();
  RealColumn get primaryContentGridCropY => real().nullable()();
  TextColumn get profileContentVersion => text().map(const NullAwareTypeConverter.wrap(ProfileContentVersionConverter())).nullable()();
}

class ProfileLocation extends SingleRowTable {
  RealColumn get latitude => real().nullable()();
  RealColumn get longitude => real().nullable()();
}

class ProfileSearchGroups extends SingleRowTable {
  TextColumn get jsonProfileSearchGroups => text().map(NullAwareTypeConverter.wrap(const SearchGroupsConverter())).nullable()();
}

class ProfileFilters extends SingleRowTable {
  TextColumn get jsonProfileFilters => text().map(NullAwareTypeConverter.wrap(const GetProfileFiltersConverter())).nullable()();
}

class ProfileSearchAgeRange extends SingleRowTable {
  IntColumn get minAge => integer().nullable()();
  IntColumn get maxAge => integer().nullable()();
}

class InitialProfileAge extends SingleRowTable {
  IntColumn get initialProfileAgeSetUnixTime => integer().map(const NullAwareTypeConverter.wrap(UtcDateTimeConverter())).nullable()();
  IntColumn get initialProfileAge => integer().nullable()();
}

class Profile extends Table {
  TextColumn get accountId => text().map(const AccountIdConverter())();

  TextColumn get profileContentVersion => text().map(const NullAwareTypeConverter.wrap(ProfileContentVersionConverter())).nullable()();

  TextColumn get profileName => text().nullable()();
  BoolColumn get profileNameAccepted => boolean().nullable()();
  TextColumn get profileText => text().nullable()();
  BoolColumn get profileTextAccepted => boolean().nullable()();
  TextColumn get profileVersion => text().map(const NullAwareTypeConverter.wrap(ProfileVersionConverter())).nullable()();
  IntColumn get profileAge => integer().nullable()();
  IntColumn get profileLastSeenTimeValue => integer().nullable()();
  BoolColumn get profileUnlimitedLikes => boolean().nullable()();
  TextColumn get jsonProfileAttributes => text().map(NullAwareTypeConverter.wrap(const ProfileAttributeValueConverter())).nullable()();

  RealColumn get primaryContentGridCropSize => real().nullable()();
  RealColumn get primaryContentGridCropX => real().nullable()();
  RealColumn get primaryContentGridCropY => real().nullable()();

  IntColumn get profileDataRefreshTime => integer().map(const NullAwareTypeConverter.wrap(UtcDateTimeConverter())).nullable()();
  IntColumn get newLikeInfoReceivedTime => integer().map(const NullAwareTypeConverter.wrap(UtcDateTimeConverter())).nullable()();

  @override
  Set<Column<Object>> get primaryKey => {accountId};
}

// TODO(prod): Consider own tables for profileDataRefreshTime and
//             newLikeInfoReceivedTime.
// TODO(prod): Consider splitting ProfileStates to multiple tables.

/// Moved from Profile table to avoid unnecessary emissions from
/// `Stream<ProfileEntry>`.
class ProfileStates extends Table {
  TextColumn get accountId => text().map(const AccountIdConverter())();

  // If column is not null, then it is in the specific group.
  // The time is the time when the profile was added to the group.
  IntColumn get isInReceivedLikes => integer().map(const NullAwareTypeConverter.wrap(UtcDateTimeConverter())).nullable()();
  IntColumn get isInSentLikes => integer().map(const NullAwareTypeConverter.wrap(UtcDateTimeConverter())).nullable()();
  IntColumn get isInMatches => integer().map(const NullAwareTypeConverter.wrap(UtcDateTimeConverter())).nullable()();

  IntColumn get isInProfileGrid => integer().map(const NullAwareTypeConverter.wrap(UtcDateTimeConverter())).nullable()();
  IntColumn get isInAutomaticProfileSearchGrid => integer().map(const NullAwareTypeConverter.wrap(UtcDateTimeConverter())).nullable()();
  IntColumn get isInReceivedLikesGrid => integer().map(const NullAwareTypeConverter.wrap(UtcDateTimeConverter())).nullable()();
  IntColumn get isInMatchesGrid => integer().map(const NullAwareTypeConverter.wrap(UtcDateTimeConverter())).nullable()();

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
  TextColumn get jsonAutomaticProfileSearchSettings => text().map(NullAwareTypeConverter.wrap(const AutomaticProfileSearchSettingsConverter())).nullable()();
}
