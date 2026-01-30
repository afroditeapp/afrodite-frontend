import 'package:database_utils/database_utils.dart';
import 'package:database_converter/database_converter.dart';
import 'package:drift/drift.dart';

/// Stores initial setup progress so it persists across app restarts.
/// This prevents users from losing all their progress if they quit the app.
class InitialSetupProgress extends SingleRowTable {
  /// Current UI page/step in the initial setup flow.
  TextColumn get currentPage => text().nullable()();

  // Basic profile info
  TextColumn get email => text().nullable()();
  BoolColumn get isAdult => boolean().nullable()();
  TextColumn get profileName => text().nullable()();
  IntColumn get profileAge => integer().nullable()();

  // Security selfie - stored as ContentId from server (slot is always 0)
  TextColumn get securitySelfieContentId => text().nullable()();
  BoolColumn get securitySelfieFaceDetected => boolean().nullable()();

  // Profile images - stored as JSON list of ProfilePictureEntry (up to 4 images with crop info)
  TextColumn get jsonProfileImages => text()
      .map(NullAwareTypeConverter.wrap(const ProfilePictureEntryListConverter()))
      .nullable()();

  // Gender and search settings
  /// Gender: 'man', 'woman', 'nonBinary'
  TextColumn get gender => text().nullable()();
  BoolColumn get searchSettingMen => boolean().nullable()();
  BoolColumn get searchSettingWomen => boolean().nullable()();
  BoolColumn get searchSettingNonBinary => boolean().nullable()();

  // Search age range
  BoolColumn get searchAgeRangeInitDone => boolean().nullable()();
  IntColumn get searchAgeRangeMin => integer().nullable()();
  IntColumn get searchAgeRangeMax => integer().nullable()();

  // Location
  RealColumn get latitude => real().nullable()();
  RealColumn get longitude => real().nullable()();

  // Profile attributes stored as JSON list of ProfileAttributeValueUpdate objects
  TextColumn get jsonProfileAttributes => text()
      .map(NullAwareTypeConverter.wrap(const ProfileAttributeValueUpdateListConverter()))
      .nullable()();

  // Chat info
  BoolColumn get chatInfoUnderstood => boolean().nullable()();
}

class EditProfileProgress extends SingleRowTable {
  IntColumn get age => integer().nullable()();
  TextColumn get name => text().nullable()();
  TextColumn get profileText => text().nullable()();
  TextColumn get jsonProfileAttributes => text()
      .map(NullAwareTypeConverter.wrap(const ProfileAttributeValueUpdateListConverter()))
      .nullable()();
  BoolColumn get unlimitedLikes => boolean().nullable()();
  TextColumn get jsonProfileImages => text()
      .map(NullAwareTypeConverter.wrap(const ProfilePictureEntryListConverter()))
      .nullable()();
  BoolColumn get editingInProgress => boolean().withDefault(const Constant(false))();
  BoolColumn get selectingImage => boolean().withDefault(const Constant(false))();
}

class DraftMessage extends Table {
  TextColumn get accountId => text().map(const AccountIdConverter())();
  TextColumn get message => text()();

  @override
  Set<Column<Object>> get primaryKey => {accountId};
}
