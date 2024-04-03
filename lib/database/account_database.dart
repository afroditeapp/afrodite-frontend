
import 'package:drift/drift.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/database/utils.dart';

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
}

@DriftDatabase(tables: [Account])
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
