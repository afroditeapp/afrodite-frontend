

import 'package:async/async.dart';
import 'package:database/src/foreground/account/dao_account_settings.dart';
import 'package:database/src/foreground/account/dao_local_image_settings.dart';
import 'package:database/src/foreground/account/dao_sync_versions.dart';
import 'package:database/src/foreground/profile_table.dart';
import 'package:drift/drift.dart';
import 'package:openapi/api.dart';
import 'package:utils/utils.dart';
import 'account/dao_current_content.dart';
import 'account/dao_initial_sync.dart';
import 'account/dao_my_profile.dart';
import 'account/dao_pending_content.dart';
import 'account/dao_profile_settings.dart';
import 'account/dao_tokens.dart';
import 'message_table.dart';
import '../profile_entry.dart';
import '../utils.dart';

part 'account_database.g.dart';

const ACCOUNT_DB_DATA_ID = Value(0);
const PROFILE_FILTER_FAVORITES_DEFAULT = false;

class Account extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get uuidAccountId => text().map(const NullAwareTypeConverter.wrap(AccountIdConverter())).nullable()();
  TextColumn get jsonAccountState => text().map(NullAwareTypeConverter.wrap(EnumString.driftConverter)).nullable()();
  TextColumn get jsonCapabilities => text().map(NullAwareTypeConverter.wrap(JsonString.driftConverter)).nullable()();
  TextColumn get jsonAvailableProfileAttributes => text().map(NullAwareTypeConverter.wrap(JsonString.driftConverter)).nullable()();

  /// If true show only favorite profiles
  BoolColumn get profileFilterFavorites => boolean()
    .withDefault(const Constant(PROFILE_FILTER_FAVORITES_DEFAULT))();

  // DaoInitialSync

  BoolColumn get initialSyncDoneLoginRepository => boolean()
    .withDefault(const Constant(false))();
  BoolColumn get initialSyncDoneAccountRepository => boolean()
    .withDefault(const Constant(false))();
  BoolColumn get initialSyncDoneMediaRepository => boolean()
    .withDefault(const Constant(false))();
  BoolColumn get initialSyncDoneProfileRepository => boolean()
    .withDefault(const Constant(false))();
  BoolColumn get initialSyncDoneChatRepository => boolean()
    .withDefault(const Constant(false))();

  // DaoSyncVersions

  IntColumn get syncVersionAccount => integer().nullable()();
  IntColumn get syncVersionReceivedLikes => integer().nullable()();
  IntColumn get syncVersionReceivedBlocks => integer().nullable()();
  IntColumn get syncVersionSentLikes => integer().nullable()();
  IntColumn get syncVersionSentBlocks => integer().nullable()();
  IntColumn get syncVersionMatches => integer().nullable()();
  IntColumn get syncVersionAvailableProfileAttributes => integer().nullable()();

  // DaoPendingContent

  TextColumn get uuidPendingContentId0 => text().map(const NullAwareTypeConverter.wrap(ContentIdConverter())).nullable()();
  TextColumn get uuidPendingContentId1 => text().map(const NullAwareTypeConverter.wrap(ContentIdConverter())).nullable()();
  TextColumn get uuidPendingContentId2 => text().map(const NullAwareTypeConverter.wrap(ContentIdConverter())).nullable()();
  TextColumn get uuidPendingContentId3 => text().map(const NullAwareTypeConverter.wrap(ContentIdConverter())).nullable()();
  TextColumn get uuidPendingContentId4 => text().map(const NullAwareTypeConverter.wrap(ContentIdConverter())).nullable()();
  TextColumn get uuidPendingContentId5 => text().map(const NullAwareTypeConverter.wrap(ContentIdConverter())).nullable()();
  TextColumn get uuidPendingSecurityContentId => text().map(const NullAwareTypeConverter.wrap(ContentIdConverter())).nullable()();
  RealColumn get pendingPrimaryContentGridCropSize => real().nullable()();
  RealColumn get pendingPrimaryContentGridCropX => real().nullable()();
  RealColumn get pendingPrimaryContentGridCropY => real().nullable()();

  // DaoCurrentContent

  TextColumn get uuidContentId0 => text().map(const NullAwareTypeConverter.wrap(ContentIdConverter())).nullable()();
  TextColumn get uuidContentId1 => text().map(const NullAwareTypeConverter.wrap(ContentIdConverter())).nullable()();
  TextColumn get uuidContentId2 => text().map(const NullAwareTypeConverter.wrap(ContentIdConverter())).nullable()();
  TextColumn get uuidContentId3 => text().map(const NullAwareTypeConverter.wrap(ContentIdConverter())).nullable()();
  TextColumn get uuidContentId4 => text().map(const NullAwareTypeConverter.wrap(ContentIdConverter())).nullable()();
  TextColumn get uuidContentId5 => text().map(const NullAwareTypeConverter.wrap(ContentIdConverter())).nullable()();
  TextColumn get uuidSecurityContentId => text().map(const NullAwareTypeConverter.wrap(ContentIdConverter())).nullable()();
  RealColumn get primaryContentGridCropSize => real().nullable()();
  RealColumn get primaryContentGridCropX => real().nullable()();
  RealColumn get primaryContentGridCropY => real().nullable()();

  // DaoMyProfile

  TextColumn get profileName => text().nullable()();
  TextColumn get profileText => text().nullable()();
  IntColumn get profileAge => integer().nullable()();
  TextColumn get jsonProfileAttributes => text().map(NullAwareTypeConverter.wrap(JsonList.driftConverter)).nullable()();

  // DaoProfileSettings

  RealColumn get profileLocationLatitude => real().nullable()();
  RealColumn get profileLocationLongitude => real().nullable()();
  TextColumn get jsonProfileVisibility => text().map(NullAwareTypeConverter.wrap(EnumString.driftConverter)).nullable()();
  TextColumn get jsonSearchGroups => text().map(NullAwareTypeConverter.wrap(JsonString.driftConverter)).nullable()();
  TextColumn get jsonProfileAttributeFilters => text().map(NullAwareTypeConverter.wrap(JsonString.driftConverter)).nullable()();
  IntColumn get profileSearchAgeRangeMin => integer().nullable()();
  IntColumn get profileSearchAgeRangeMax => integer().nullable()();

  // DaoAccountSettings

  TextColumn get accountEmailAddress => text().nullable()();

  // DaoTokens

  TextColumn get refreshTokenAccount => text().nullable()();
  TextColumn get refreshTokenMedia => text().nullable()();
  TextColumn get refreshTokenProfile => text().nullable()();
  TextColumn get refreshTokenChat => text().nullable()();
  TextColumn get accessTokenAccount => text().nullable()();
  TextColumn get accessTokenMedia => text().nullable()();
  TextColumn get accessTokenProfile => text().nullable()();
  TextColumn get accessTokenChat => text().nullable()();

  // DaoLocalImageSettings

  IntColumn get localImageSettingImageCacheMaxBytes => integer().nullable()();
  BoolColumn get localImageSettingCacheFullSizedImages => boolean().nullable()();
  IntColumn get localImageSettingImageCacheDownscalingSize => integer().nullable()();
}

@DriftDatabase(
  tables: [
    Account,
    Profiles,
    Messages,
  ],
  daos: [
    // Account table
    DaoCurrentContent,
    DaoPendingContent,
    DaoMyProfile,
    DaoProfileSettings,
    DaoAccountSettings,
    DaoTokens,
    DaoInitialSync,
    DaoSyncVersions,
    DaoLocalImageSettings,
    // Other tables
    DaoMessages,
    DaoProfiles,
  ],
)
class AccountDatabase extends _$AccountDatabase {
  AccountDatabase(QueryExcecutorProvider dbProvider) :
    super(dbProvider.getQueryExcecutor());

  @override
  int get schemaVersion => 1;

  Future<void> setAccountIdIfNull(AccountId id) async {
    await transaction(() async {
      final currentAccountId = await watchAccountId().firstOrNull;
      if (currentAccountId == null) {
        await into(account).insertOnConflictUpdate(
          AccountCompanion.insert(
            id: ACCOUNT_DB_DATA_ID,
            uuidAccountId: Value(id),
          ),
        );
      }
    });
  }

  Future<void> updateProfileFilterFavorites(bool value) async {
    await into(account).insertOnConflictUpdate(
      AccountCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        profileFilterFavorites: Value(value),
      ),
    );
  }

  Future<void> updateAccountState(AccountState? value) async {
    await into(account).insertOnConflictUpdate(
      AccountCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        jsonAccountState: Value(value?.toEnumString()),
      ),
    );
  }

  Future<void> updateCapabilities(Capabilities? value) async {
    await into(account).insertOnConflictUpdate(
      AccountCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        jsonCapabilities: Value(value?.toJsonString()),
      ),
    );
  }

  Future<void> updateAvailableProfileAttributes(AvailableProfileAttributes value) async {
    await transaction(() async {
      await into(account).insertOnConflictUpdate(
        AccountCompanion.insert(
          id: ACCOUNT_DB_DATA_ID,
          jsonAvailableProfileAttributes: Value(value.toJsonString()),
        ),
      );
      await daoSyncVersions.updateSyncVersionAvailableProfileAttributes(value.syncVersion);
    });
  }

  Stream<AccountId?> watchAccountId() =>
    watchColumn((r) => r.uuidAccountId);

  Stream<bool?> watchProfileFilterFavorites() =>
    watchColumn((r) => r.profileFilterFavorites);

  Stream<AccountState?> watchAccountState() =>
    watchColumn((r) => r.jsonAccountState?.toAccountState());

  Stream<Capabilities?> watchCapabilities() =>
    watchColumn((r) => r.jsonCapabilities?.toCapabilities());

  Stream<AvailableProfileAttributes?> watchAvailableProfileAttributes() =>
    watchColumn((r) => r.jsonAvailableProfileAttributes?.toAvailableProfileAttributes());

  SimpleSelectStatement<$AccountTable, AccountData> _selectFromDataId() {
    return select(account)
      ..where((t) => t.id.equals(ACCOUNT_DB_DATA_ID.value));
  }

  Stream<T?> watchColumn<T extends Object>(T? Function(AccountData) extractColumn) {
    return _selectFromDataId()
      .map(extractColumn)
      .watchSingleOrNull();
  }

  /// Get ProileEntry for my profile (version not included)
  Stream<ProfileEntry?> getProfileEntryForMyProfile() =>
    watchColumn((r) {
      final id = r.uuidAccountId;
      final profileName = r.profileName;
      final profileText = r.profileText;
      final profileAge = r.profileAge;
      final profileAttributes = r.jsonProfileAttributes?.toProfileAttributes();

      var content0 = r.uuidContentId0;
      var content1 = r.uuidContentId1;
      var content2 = r.uuidContentId2;
      var content3 = r.uuidContentId3;
      var content4 = r.uuidContentId4;
      var content5 = r.uuidContentId5;
      var gridCropSize = r.primaryContentGridCropSize ?? 1.0;
      var gridCropX = r.primaryContentGridCropX ?? 0.0;
      var gridCropY = r.primaryContentGridCropY ?? 0.0;
      if (content0 == null) {
        // Initial moderation not done yet
        content0 = r.uuidPendingContentId0;
        content1 = r.uuidPendingContentId1;
        content2 = r.uuidPendingContentId2;
        content3 = r.uuidPendingContentId3;
        content4 = r.uuidPendingContentId4;
        content5 = r.uuidPendingContentId5;
        gridCropSize = r.pendingPrimaryContentGridCropSize ?? 1.0;
        gridCropX = r.pendingPrimaryContentGridCropX ?? 0.0;
        gridCropY = r.pendingPrimaryContentGridCropY ?? 0.0;
      }


      if (id != null && content0 != null && profileName != null && profileText != null && profileAge != null && profileAttributes != null) {
        return ProfileEntry(
          uuid: id,
          imageUuid: content0,
          primaryContentGridCropSize: gridCropSize,
          primaryContentGridCropX: gridCropX,
          primaryContentGridCropY: gridCropY,
          name: profileName,
          profileText: profileText,
          age: profileAge,
          attributes: profileAttributes,
          content1: content1,
          content2: content2,
          content3: content3,
          content4: content4,
          content5: content5,
        );
      } else {
        return null;
      }
    });
}



mixin AccountTools on DatabaseAccessor<AccountDatabase> {
  $AccountTable get _account => attachedDatabase.account;

  SimpleSelectStatement<$AccountTable, AccountData> selectFromDataId() {
    return select(_account)
      ..where((t) => t.id.equals(ACCOUNT_DB_DATA_ID.value));
  }

  Stream<T?> watchColumn<T extends Object>(T? Function(AccountData) extractColumn) {
    return selectFromDataId()
      .map(extractColumn)
      .watchSingleOrNull();
  }
}
