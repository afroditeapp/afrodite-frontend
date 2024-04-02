

import 'package:drift/drift.dart';
import 'package:pihka_frontend/database/utils.dart';

part 'common_database.g.dart';

const COMMON_DB_DATA_ID = Value(0);

class Common extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get demoAccountUserId => text().nullable()();
  TextColumn get demoAccountPassword => text().nullable()();
  TextColumn get demoAccountToken => text().nullable()();
}

@DriftDatabase(tables: [Common])
class CommonDatabase extends _$CommonDatabase {
  CommonDatabase({required bool doInit}) :
    super(openDbConnection(CommonDbFile(), doInit: doInit));

  @override
  int get schemaVersion => 1;

  Future<void> updateDemoAccountUserId(String? userId) async {
    await into(common).insertOnConflictUpdate(
      CommonCompanion.insert(
        id: COMMON_DB_DATA_ID,
        demoAccountUserId: Value(userId),
      ),
    );
  }

  Future<void> updateDemoAccountPassword(String? password) async {
    await into(common).insertOnConflictUpdate(
      CommonCompanion.insert(
        id: COMMON_DB_DATA_ID,
        demoAccountPassword: Value(password),
      ),
    );
  }

  Future<void> updateDemoAccountToken(String? token) async {
    await into(common).insertOnConflictUpdate(
      CommonCompanion.insert(
        id: COMMON_DB_DATA_ID,
        demoAccountToken: Value(token),
      ),
    );
  }

  Stream<String?> watchDemoAccountUserId() =>
    watchStringColumn((r) => r.demoAccountUserId);

  Stream<String?> watchDemoAccountPassword() =>
    watchStringColumn((r) => r.demoAccountPassword);

  Stream<String?> watchDemoAccountToken() =>
    watchStringColumn((r) => r.demoAccountToken);

  SimpleSelectStatement<$CommonTable, CommonData> _selectFromDataId() {
    return select(common)
      ..where((t) => t.id.equals(COMMON_DB_DATA_ID.value));
  }

  Stream<String?> watchStringColumn(String? Function(CommonData) extractColumn) {
    return _selectFromDataId()
      .map(extractColumn)
      .watchSingleOrNull();
  }
}
