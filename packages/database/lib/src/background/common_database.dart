
import 'package:drift/drift.dart';
import 'package:openapi/api.dart';
import '../utils.dart';

part 'common_database.g.dart';

const COMMON_BACKGROUND_DB_DATA_ID = Value(0);

/// Common app data which can be accessed when app is in background
class CommonBackground extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get serverUrlAccount => text().nullable()();
  TextColumn get serverUrlMedia => text().nullable()();
  TextColumn get serverUrlProfile => text().nullable()();
  TextColumn get serverUrlChat => text().nullable()();
  TextColumn get uuidAccountId => text().map(const NullAwareTypeConverter.wrap(AccountIdConverter())).nullable()();
}

@DriftDatabase(tables: [CommonBackground])
class CommonBackgroundDatabase extends _$CommonBackgroundDatabase {
  CommonBackgroundDatabase(QueryExcecutorProvider dbProvider) :
    super(dbProvider.getQueryExcecutor());

  @override
  int get schemaVersion => 1;

  Future<void> updateServerUrlAccount(String? url) async {
    await into(commonBackground).insertOnConflictUpdate(
      CommonBackgroundCompanion.insert(
        id: COMMON_BACKGROUND_DB_DATA_ID,
        serverUrlAccount: Value(url),
      ),
    );
  }

  Future<void> updateAccountIdUseOnlyFromDatabaseManager(AccountId? id) async {
    await transaction(() async {
      await into(commonBackground).insertOnConflictUpdate(
        CommonBackgroundCompanion.insert(
          id: COMMON_BACKGROUND_DB_DATA_ID,
          uuidAccountId: Value(id),
        ),
      );
    });
  }

  Stream<String?> watchServerUrlAccount() =>
    watchColumn((r) => r.serverUrlAccount);

  Stream<String?> watchServerUrlMedia() =>
    watchColumn((r) => r.serverUrlMedia);

  Stream<String?> watchServerUrlProfile() =>
    watchColumn((r) => r.serverUrlProfile);

  Stream<String?> watchServerUrlChat() =>
    watchColumn((r) => r.serverUrlChat);

  Stream<AccountId?> watchAccountId() =>
    watchColumn((r) => r.uuidAccountId);

  SimpleSelectStatement<$CommonBackgroundTable, CommonBackgroundData> _selectFromDataId() {
    return select(commonBackground)
      ..where((t) => t.id.equals(COMMON_BACKGROUND_DB_DATA_ID.value));
  }

  Stream<T?> watchColumn<T extends Object>(T? Function(CommonBackgroundData) extractColumn) {
    return _selectFromDataId()
      .map(extractColumn)
      .watchSingleOrNull();
  }
}
