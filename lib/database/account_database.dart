
import 'package:drift/drift.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/database/profile_table.dart';
import 'package:pihka_frontend/database/utils.dart';
import 'package:pihka_frontend/utils/date.dart';

part 'account_database.g.dart';

const ACCOUNT_DB_DATA_ID = Value(0);
const PROFILE_FILTER_FAVORITES_DEFAULT = false;

class Account extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get refreshTokenAccount => text().nullable()();
  TextColumn get refreshTokenMedia => text().nullable()();
  TextColumn get refreshTokenProfile => text().nullable()();
  TextColumn get refreshTokenChat => text().nullable()();
  TextColumn get accessTokenAccount => text().nullable()();
  TextColumn get accessTokenMedia => text().nullable()();
  TextColumn get accessTokenProfile => text().nullable()();
  TextColumn get accessTokenChat => text().nullable()();

  /// If true show only favorite profiles
  BoolColumn get profileFilterFavorites => boolean()
    .withDefault(const Constant(PROFILE_FILTER_FAVORITES_DEFAULT))();

  RealColumn get profileLocationLatitude => real().nullable()();
  RealColumn get profileLocationLongitude => real().nullable()();

  TextColumn get jsonAccountState => text().map(NullAwareTypeConverter.wrap(EnumString.driftConverter)).nullable()();
  TextColumn get jsonCapabilities => text().map(NullAwareTypeConverter.wrap(JsonString.driftConverter)).nullable()();
  TextColumn get jsonAvailableProfileAttributes => text().map(NullAwareTypeConverter.wrap(JsonString.driftConverter)).nullable()();
  TextColumn get jsonProfileVisibility => text().map(NullAwareTypeConverter.wrap(EnumString.driftConverter)).nullable()();
}

@DriftDatabase(tables: [Account, Profiles], daos: [DaoProfiles])
class AccountDatabase extends _$AccountDatabase {
  AccountDatabase(DbFile dbFile) :
    super(openDbConnection(dbFile));

  @override
  int get schemaVersion => 1;

  Future<void> updateRefreshTokenAccount(String? token) async {
    await into(account).insertOnConflictUpdate(
      AccountCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        refreshTokenAccount: Value(token),
      ),
    );
  }

  Future<void> updateRefreshTokenMedia(String? token) async {
    await into(account).insertOnConflictUpdate(
      AccountCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        refreshTokenMedia: Value(token),
      ),
    );
  }

  Future<void> updateRefreshTokenProfile(String? token) async {
    await into(account).insertOnConflictUpdate(
      AccountCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        refreshTokenProfile: Value(token),
      ),
    );
  }

  Future<void> updateRefreshTokenChat(String? token) async {
    await into(account).insertOnConflictUpdate(
      AccountCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        refreshTokenChat: Value(token),
      ),
    );
  }

  Future<void> updateAccessTokenAccount(String? token) async {
    await into(account).insertOnConflictUpdate(
      AccountCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        accessTokenAccount: Value(token),
      ),
    );
  }

  Future<void> updateAccessTokenMedia(String? token) async {
    await into(account).insertOnConflictUpdate(
      AccountCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        accessTokenMedia: Value(token),
      ),
    );
  }

  Future<void> updateAccessTokenProfile(String? token) async {
    await into(account).insertOnConflictUpdate(
      AccountCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        accessTokenProfile: Value(token),
      ),
    );
  }

  Future<void> updateAccessTokenChat(String? token) async {
    await into(account).insertOnConflictUpdate(
      AccountCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        accessTokenChat: Value(token),
      ),
    );
  }

  Future<void> updateProfileLocation({required double latitude, required double longitude}) async {
    await into(account).insertOnConflictUpdate(
      AccountCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        profileLocationLatitude: Value(latitude),
        profileLocationLongitude: Value(longitude),
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

  Future<void> updateProfileVisibility(ProfileVisibility? value) async {
    await into(account).insertOnConflictUpdate(
      AccountCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        jsonProfileVisibility: Value(value?.toEnumString()),
      ),
    );
  }

  Stream<String?> watchRefreshTokenAccount() =>
    watchColumn((r) => r.refreshTokenAccount);

  Stream<String?> watchRefreshTokenMedia() =>
    watchColumn((r) => r.refreshTokenMedia);

  Stream<String?> watchRefreshTokenProfile() =>
    watchColumn((r) => r.refreshTokenProfile);

  Stream<String?> watchRefreshTokenChat() =>
    watchColumn((r) => r.refreshTokenChat);

  Stream<String?> watchAccessTokenAccount() =>
    watchColumn((r) => r.accessTokenAccount);

  Stream<String?> watchAccessTokenMedia() =>
    watchColumn((r) => r.accessTokenMedia);

  Stream<String?> watchAccessTokenProfile() =>
    watchColumn((r) => r.accessTokenProfile);

  Stream<String?> watchAccessTokenChat() =>
    watchColumn((r) => r.accessTokenChat);

  Stream<bool?> watchProfileFilterFavorites() =>
    watchColumn((r) => r.profileFilterFavorites);

  Stream<AccountState?> watchAccountState() =>
    watchColumn((r) => r.jsonAccountState?.toAccountState());

  Stream<Capabilities?> watchCapabilities() =>
    watchColumn((r) => r.jsonCapabilities?.toCapabilities());

  Stream<AvailableProfileAttributes?> watchAvailableProfileAttributes() =>
    watchColumn((r) => r.jsonAvailableProfileAttributes?.toAvailableProfileAttributes());

  Stream<ProfileVisibility?> watchProfileVisibility() =>
    watchColumn((r) => r.jsonProfileVisibility?.toProfileVisibility());

  Stream<Location?> watchProfileLocation() =>
    _selectFromDataId()
      .map((r) {
        final latitude = r.profileLocationLatitude;
        final longitude = r.profileLocationLongitude;
        if (latitude != null && longitude != null) {
          return Location(latitude: latitude, longitude: longitude);
        } else {
          return null;
        }
      })
      .watchSingleOrNull();

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
