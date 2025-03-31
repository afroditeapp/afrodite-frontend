

import 'package:async/async.dart';
import 'package:database/src/foreground/account/dao_account_settings.dart';
import 'package:database/src/foreground/account/dao_available_profile_attributes.dart';
import 'package:database/src/foreground/account/dao_client_features.dart';
import 'package:database/src/foreground/account/dao_custom_reports.dart';
import 'package:database/src/foreground/account/dao_initial_setup.dart';
import 'package:database/src/foreground/account/dao_local_image_settings.dart';
import 'package:database/src/foreground/account/dao_message_keys.dart';
import 'package:database/src/foreground/account/dao_profile_initial_age_info.dart';
import 'package:database/src/foreground/account/dao_server_maintenance.dart';
import 'package:database/src/foreground/account/dao_sync_versions.dart';
import 'package:database/src/foreground/available_profile_attributes_table.dart';
import 'package:database/src/foreground/conversations_table.dart';
import 'package:database/src/foreground/conversation_list_table.dart';
import 'package:database/src/foreground/my_media_content_table.dart';
import 'package:database/src/foreground/profile_states_table.dart';
import 'package:database/src/foreground/profile_table.dart';
import 'package:database/src/foreground/public_profile_content_table.dart';
import 'package:drift/drift.dart';
import 'package:openapi/api.dart';
import 'package:openapi/api.dart' as api;
import 'package:rxdart/rxdart.dart';
import 'package:utils/utils.dart';
import 'account/dao_current_content.dart';
import 'account/dao_initial_sync.dart';
import 'account/dao_my_profile.dart';
import 'account/dao_profile_settings.dart';
import 'account/dao_tokens.dart';
import 'message_table.dart';
import '../profile_entry.dart';
import '../private_key_data.dart';
import '../utils.dart';

part 'account_database.g.dart';

// TODO(prod): Split Account table to multiple tables.
//             That might improve app performance because
//             watch streams emit from all table changes.

const ACCOUNT_DB_DATA_ID = Value(0);
const PROFILE_FILTER_FAVORITES_DEFAULT = false;

class Account extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get uuidAccountId => text().map(const NullAwareTypeConverter.wrap(AccountIdConverter())).nullable()();
  TextColumn get jsonAccountState => text().map(NullAwareTypeConverter.wrap(JsonString.driftConverter)).nullable()();
  TextColumn get jsonPermissions => text().map(NullAwareTypeConverter.wrap(JsonString.driftConverter)).nullable()();
  TextColumn get jsonProfileVisibility => text().map(NullAwareTypeConverter.wrap(EnumString.driftConverter)).nullable()();

  /// If true show only favorite profiles
  BoolColumn get profileFilterFavorites => boolean()
    .withDefault(const Constant(PROFILE_FILTER_FAVORITES_DEFAULT))();

  IntColumn get profileIteratorSessionId => integer()
    .map(const NullAwareTypeConverter.wrap(ProfileIteratorSessionIdConverter())).nullable()();
  IntColumn get receivedLikesIteratorSessionId => integer()
    .map(const NullAwareTypeConverter.wrap(ReceivedLikesIteratorSessionIdConverter())).nullable()();
  IntColumn get matchesIteratorSessionId => integer()
    .map(const NullAwareTypeConverter.wrap(MatchesIteratorSessionIdConverter())).nullable()();

  IntColumn get clientId => integer().map(const NullAwareTypeConverter.wrap(ClientIdConverter())).nullable()();

  // DaoAvailableProfileAttributes

  TextColumn get jsonAvailableProfileAttributesOrderMode => text().map(NullAwareTypeConverter.wrap(EnumString.driftConverter)).nullable()();

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
  IntColumn get syncVersionProfile => integer().nullable()();
  IntColumn get syncVersionMediaContent => integer().nullable()();
  IntColumn get syncVersionClientConfig => integer().nullable()();

  // DaoCurrentContent

  RealColumn get primaryContentGridCropSize => real().nullable()();
  RealColumn get primaryContentGridCropX => real().nullable()();
  RealColumn get primaryContentGridCropY => real().nullable()();
  TextColumn get profileContentVersion => text().map(const NullAwareTypeConverter.wrap(ProfileContentVersionConverter())).nullable()();

  // DaoMyProfile

  TextColumn get profileName => text().nullable()();
  BoolColumn get profileNameAccepted => boolean().nullable()();
  TextColumn get profileNameModerationState => text().map(NullAwareTypeConverter.wrap(EnumString.driftConverter)).nullable()();
  TextColumn get profileText => text().nullable()();
  BoolColumn get profileTextAccepted => boolean().nullable()();
  TextColumn get profileTextModerationState => text().map(NullAwareTypeConverter.wrap(EnumString.driftConverter)).nullable()();
  IntColumn get profileTextModerationRejectedCategory => integer().map(const NullAwareTypeConverter.wrap(ProfileTextModerationRejectedReasonCategoryConverter())).nullable()();
  TextColumn get profileTextModerationRejectedDetails => text().map(const NullAwareTypeConverter.wrap(ProfileTextModerationRejectedReasonDetailsConverter())).nullable()();
  IntColumn get profileAge => integer().nullable()();
  BoolColumn get profileUnlimitedLikes => boolean().nullable()();
  TextColumn get profileVersion => text().map(const NullAwareTypeConverter.wrap(ProfileVersionConverter())).nullable()();
  TextColumn get jsonProfileAttributes => text().map(NullAwareTypeConverter.wrap(JsonList.driftConverter)).nullable()();

  // DaoProfileSettings

  RealColumn get profileLocationLatitude => real().nullable()();
  RealColumn get profileLocationLongitude => real().nullable()();
  TextColumn get jsonSearchGroups => text().map(NullAwareTypeConverter.wrap(JsonString.driftConverter)).nullable()();
  TextColumn get jsonProfileFilteringSettings => text().map(NullAwareTypeConverter.wrap(JsonString.driftConverter)).nullable()();
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

  // DaoMessageKeys

  TextColumn get privateKeyData => text().map(const NullAwareTypeConverter.wrap(PrivateKeyDataConverter())).nullable()();
  TextColumn get publicKeyData => text().map(const NullAwareTypeConverter.wrap(PublicKeyDataConverter())).nullable()();
  IntColumn get publicKeyId => integer().map(const NullAwareTypeConverter.wrap(PublicKeyIdConverter())).nullable()();
  IntColumn get publicKeyVersion => integer().map(const NullAwareTypeConverter.wrap(PublicKeyVersionConverter())).nullable()();

  // DaoProfileInitialAgeInfo

  IntColumn get profileInitialAgeSetUnixTime => integer().map(const NullAwareTypeConverter.wrap(UtcDateTimeConverter())).nullable()();
  IntColumn get profileInitialAge => integer().nullable()();

  // DaoServerMaintenance

  IntColumn get serverMaintenanceUnixTime => integer().map(const NullAwareTypeConverter.wrap(UtcDateTimeConverter())).nullable()();
  IntColumn get serverMaintenanceUnixTimeViewed => integer().map(const NullAwareTypeConverter.wrap(UtcDateTimeConverter())).nullable()();

  // DaoCustomReports

  TextColumn get customReportsFileHash => text().map(const NullAwareTypeConverter.wrap(CustomReportsFileHashConverter())).nullable()();
  TextColumn get customReportsConfig => text().map(NullAwareTypeConverter.wrap(JsonString.driftConverter)).nullable()();

  // DaoClientFeatures

  TextColumn get clientFeaturesFileHash => text().map(const NullAwareTypeConverter.wrap(ClientFeaturesFileHashConverter())).nullable()();
  TextColumn get clientFeaturesConfig => text().map(NullAwareTypeConverter.wrap(JsonString.driftConverter)).nullable()();

  // DaoInitialSetup

  BoolColumn get initialSetupSkipped => boolean()
    .withDefault(const Constant(false))();
}

@DriftDatabase(
  tables: [
    Account,
    Profiles,
    PublicProfileContent,
    MyMediaContent,
    ProfileStates,
    ConversationList,
    Messages,
    Conversations,
    AvailableProfileAttributesTable,
  ],
  daos: [
    // Account table
    DaoCurrentContent,
    DaoMyProfile,
    DaoProfileSettings,
    DaoAccountSettings,
    DaoTokens,
    DaoInitialSync,
    DaoSyncVersions,
    DaoLocalImageSettings,
    DaoMessageKeys,
    DaoProfileInitialAgeInfo,
    DaoAvailableProfileAttributes,
    DaoServerMaintenance,
    DaoCustomReports,
    DaoClientFeatures,
    DaoInitialSetup,
    // Other tables
    DaoMessages,
    DaoConversationList,
    DaoProfiles,
    DaoPublicProfileContent,
    DaoMyMediaContent,
    DaoProfileStates,
    DaoConversations,
    DaoAvailableProfileAttributesTable,
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

  Future<void> updateProfileIteratorSessionId(ProfileIteratorSessionId value) async {
    await into(account).insertOnConflictUpdate(
      AccountCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        profileIteratorSessionId: Value(value),
      ),
    );
  }

  Future<void> updateReceivedLikesIteratorSessionId(ReceivedLikesIteratorSessionId value) async {
    await into(account).insertOnConflictUpdate(
      AccountCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        receivedLikesIteratorSessionId: Value(value),
      ),
    );
  }

  Future<void> updateMatchesIteratorSessionId(MatchesIteratorSessionId value) async {
    await into(account).insertOnConflictUpdate(
      AccountCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        matchesIteratorSessionId: Value(value),
      ),
    );
  }

  Future<void> updateProfileFilterFavorites(bool value) async {
    await into(account).insertOnConflictUpdate(
      AccountCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        profileFilterFavorites: Value(value),
      ),
    );
  }

  Future<void> updateAccountState(api.Account value) async {
    await transaction(() async {
      await into(account).insertOnConflictUpdate(
        AccountCompanion.insert(
          id: ACCOUNT_DB_DATA_ID,
          jsonAccountState: Value(value.state.toJsonString()),
          jsonPermissions: Value(value.permissions.toJsonString()),
          jsonProfileVisibility: Value(value.visibility.toEnumString()),
        ),
      );
      await daoSyncVersions.updateSyncVersionAccount(value.syncVersion);
    });
  }

  Future<void> updateClientIdIfNull(ClientId value) async {
    await transaction(() async {
      final currentClientId = await watchClientId().firstOrNull;
      if (currentClientId == null) {
        await into(account).insertOnConflictUpdate(
          AccountCompanion.insert(
            id: ACCOUNT_DB_DATA_ID,
            clientId: Value(value),
          ),
        );
      }
    });
  }

  Stream<AccountId?> watchAccountId() =>
    watchColumn((r) => r.uuidAccountId);

  Stream<bool?> watchProfileFilterFavorites() =>
    watchColumn((r) => r.profileFilterFavorites);

  Stream<ProfileIteratorSessionId?> watchProfileSessionId() =>
    watchColumn((r) => r.profileIteratorSessionId);

  Stream<ReceivedLikesIteratorSessionId?> watchReceivedLikesSessionId() =>
    watchColumn((r) => r.receivedLikesIteratorSessionId);

  Stream<MatchesIteratorSessionId?> watchMatchesSessionId() =>
    watchColumn((r) => r.matchesIteratorSessionId);

  Stream<AccountState?> watchAccountState() =>
    watchColumn((r) => r.jsonAccountState?.toAccountStateContainer()?.toAccountState());

  Stream<ProfileVisibility?> watchProfileVisibility() =>
    watchColumn((r) => r.jsonProfileVisibility?.toProfileVisibility());

  Stream<Permissions?> watchPermissions() =>
    watchColumn((r) => r.jsonPermissions?.toPermissions());

  Stream<ClientId?> watchClientId() =>
    watchColumn((r) => r.clientId);

  SimpleSelectStatement<$AccountTable, AccountData> _selectFromDataId() {
    return select(account)
      ..where((t) => t.id.equals(ACCOUNT_DB_DATA_ID.value));
  }

  Stream<T?> watchColumn<T extends Object>(T? Function(AccountData) extractColumn) {
    return _selectFromDataId()
      .map(extractColumn)
      .watchSingleOrNull();
  }

  /// Get ProileEntry for my profile
  Stream<MyProfileEntry?> getProfileEntryForMyProfile() =>
    Rx.combineLatest2(
      watchColumn((r) => r),
      daoMyMediaContent.watchAllProfileContent(),
      (r, content) => toMyProfileEntry(r, content),
    );

  MyProfileEntry? toMyProfileEntry(AccountData? r, List<MyContent> content) {
    if (r == null) {
      return null;
    }

    final id = r.uuidAccountId;
    final profileName = r.profileName;
    final profileNameAccepted = r.profileNameAccepted;
    final profileNameModerationState = r.profileNameModerationState?.toProfileNameModerationState();
    final profileText = r.profileText;
    final profileTextAccepted = r.profileTextAccepted;
    final profileTextModerationState = r.profileTextModerationState?.toProfileTextModerationState();
    final profileTextModerationRejectedCategory = r.profileTextModerationRejectedCategory;
    final profileTextModerationRejectedDetails = r.profileTextModerationRejectedDetails;
    final profileAge = r.profileAge;
    final profileAttributes = r.jsonProfileAttributes?.toProfileAttributes();
    final profileVersion = r.profileVersion;
    final profileContentVersion = r.profileContentVersion;
    final profileUnlimitedLikes = r.profileUnlimitedLikes;

    final gridCropSize = r.primaryContentGridCropSize ?? 1.0;
    final gridCropX = r.primaryContentGridCropX ?? 0.0;
    final gridCropY = r.primaryContentGridCropY ?? 0.0;

    if (
      id != null &&
      profileName != null &&
      profileNameAccepted != null &&
      profileNameModerationState != null &&
      profileText != null &&
      profileTextAccepted != null &&
      profileTextModerationState != null &&
      profileAge != null &&
      profileAttributes != null &&
      profileVersion != null &&
      profileContentVersion != null &&
      profileUnlimitedLikes != null
    ) {
      return MyProfileEntry(
        uuid: id,
        myContent: content,
        primaryContentGridCropSize: gridCropSize,
        primaryContentGridCropX: gridCropX,
        primaryContentGridCropY: gridCropY,
        name: profileName,
        nameAccepted: profileNameAccepted,
        profileNameModerationState: profileNameModerationState,
        profileText: profileText,
        profileTextAccepted: profileTextAccepted,
        profileTextModerationState: profileTextModerationState,
        profileTextModerationRejectedCategory: profileTextModerationRejectedCategory,
        profileTextModerationRejectedDetails: profileTextModerationRejectedDetails,
        age: profileAge,
        unlimitedLikes: profileUnlimitedLikes,
        attributes: profileAttributes,
        version: profileVersion,
        contentVersion: profileContentVersion,
      );
    } else {
      return null;
    }
  }
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
