
import 'package:database_common_background/src/database.dart';
import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';

import '../schema.dart' as schema;

part 'app.g.dart';

@DriftAccessor(
  tables: [
    schema.CurrentLocale,
    schema.ServerUrl,
  ]
)
class DaoWriteApp extends DatabaseAccessor<CommonBackgroundDatabase> with _$DaoWriteAppMixin {
  DaoWriteApp(super.db);

  Future<void> updateCurrentLocale(String? value) async {
    await into(currentLocale).insertOnConflictUpdate(
      CurrentLocaleCompanion.insert(
        id: SingleRowTable.ID,
        currentLocale: Value(value),
      ),
    );
  }

  Future<void> updateServerUrlAccount(String? url) async {
    await into(serverUrl).insertOnConflictUpdate(
      ServerUrlCompanion.insert(
        id: SingleRowTable.ID,
        serverUrlAccount: Value(url),
      ),
    );
  }
}
