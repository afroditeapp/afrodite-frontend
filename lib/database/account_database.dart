
import 'package:drift/drift.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/database/account/dao_current_content.dart';
import 'package:pihka_frontend/database/account/dao_my_profile.dart';
import 'package:pihka_frontend/database/account/dao_pending_content.dart';
import 'package:pihka_frontend/database/account/dao_profile_settings.dart';
import 'package:pihka_frontend/database/account/dao_tokens.dart';
import 'package:pihka_frontend/database/message_table.dart';
import 'package:pihka_frontend/database/profile_table.dart';
import 'package:pihka_frontend/database/utils.dart';
import 'package:pihka_frontend/utils/date.dart';

part 'account_database.g.dart';

const ACCOUNT_DB_DATA_ID = Value(0);
const PROFILE_FILTER_FAVORITES_DEFAULT = false;

class Account extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get jsonAccountState => text().map(NullAwareTypeConverter.wrap(EnumString.driftConverter)).nullable()();
  TextColumn get jsonCapabilities => text().map(NullAwareTypeConverter.wrap(JsonString.driftConverter)).nullable()();
  TextColumn get jsonAvailableProfileAttributes => text().map(NullAwareTypeConverter.wrap(JsonString.driftConverter)).nullable()();

  /// If true show only favorite profiles
  BoolColumn get profileFilterFavorites => boolean()
    .withDefault(const Constant(PROFILE_FILTER_FAVORITES_DEFAULT))();

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
  IntColumn get profileSearchAgeRangeMin => integer().nullable()();
  IntColumn get profileSearchAgeRangeMax => integer().nullable()();

  // DaoTokens

  TextColumn get refreshTokenAccount => text().nullable()();
  TextColumn get refreshTokenMedia => text().nullable()();
  TextColumn get refreshTokenProfile => text().nullable()();
  TextColumn get refreshTokenChat => text().nullable()();
  TextColumn get accessTokenAccount => text().nullable()();
  TextColumn get accessTokenMedia => text().nullable()();
  TextColumn get accessTokenProfile => text().nullable()();
  TextColumn get accessTokenChat => text().nullable()();
}

@DriftDatabase(
  tables: [
    Account,
    Profiles,
    Messages
  ],
  daos: [
    // Account table
    DaoCurrentContent,
    DaoPendingContent,
    DaoMyProfile,
    DaoProfileSettings,
    DaoTokens,
    // Other tables
    DaoProfiles,
    DaoMessages,
  ],
)
class AccountDatabase extends _$AccountDatabase {
  AccountDatabase(DbFile dbFile) :
    super(openDbConnection(dbFile));

  @override
  int get schemaVersion => 1;

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

  Future<void> updateAvailableProfileAttributes(AvailableProfileAttributes? value) async {
    await into(account).insertOnConflictUpdate(
      AccountCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        jsonAvailableProfileAttributes: Value(value?.toJsonString()),
      ),
    );
  }

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
}

class JsonString {
  final Map<String, Object?> jsonMap;
  JsonString(this.jsonMap);

  Capabilities? toCapabilities() {
    return Capabilities.fromJson(jsonMap);
  }

  AvailableProfileAttributes? toAvailableProfileAttributes() {
    return AvailableProfileAttributes.fromJson(jsonMap);
  }

  static TypeConverter<JsonString, String> driftConverter = TypeConverter.json(
    fromJson: (json) => JsonString(json as Map<String, Object?>),
    toJson: (object) => object.jsonMap,
  );
}

extension CapabilitiesJson on Capabilities {
  JsonString toJsonString() {
    return JsonString(toJson());
  }
}

extension AvailableProfileAttributesJson on AvailableProfileAttributes {
  JsonString toJsonString() {
    return JsonString(toJson());
  }
}


class EnumString {
  final String enumString;
  EnumString(this.enumString);

  AccountState? toAccountState() {
    return AccountState.fromJson(enumString);
  }

  ProfileVisibility? toProfileVisibility() {
    return ProfileVisibility.fromJson(enumString);
  }

  static TypeConverter<EnumString, String> driftConverter = const EnumStringConverter();
}

extension AccountStateConverter on AccountState {
  EnumString toEnumString() {
    return EnumString(toJson());
  }
}

extension ProfileVisibilityConverter on ProfileVisibility {
  EnumString toEnumString() {
    return EnumString(toJson());
  }
}

class EnumStringConverter extends TypeConverter<EnumString, String> {
  const EnumStringConverter();

  @override
  EnumString fromSql(fromDb) {
    return EnumString(fromDb);
  }

  @override
  String toSql(value) {
    return value.enumString;
  }
}

class JsonList {
  final List<Object?> jsonList;
  JsonList(this.jsonList);

  List<ProfileAttributeValue>? toProfileAttributes() {
    return ProfileAttributeValue.listFromJson(jsonList);
  }

  static TypeConverter<JsonList, String> driftConverter = TypeConverter.json(
    fromJson: (json) => JsonList(json as List<Object?>),
    toJson: (object) => object.jsonList,
  );
}

extension ProfileAttributeValueListJson on List<ProfileAttributeValue> {
  JsonList toJsonList() {
    return JsonList(map((e) => e.toJson()).toList());
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
