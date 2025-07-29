
import 'package:database/src/converter/json/string.dart';
import 'package:openapi/api.dart' as api;

import '../account_database.dart';

import 'package:drift/drift.dart';

part 'dao_custom_reports.g.dart';

@DriftAccessor(tables: [Account])
class DaoCustomReports extends DatabaseAccessor<AccountDatabase> with _$DaoCustomReportsMixin, AccountTools {
  DaoCustomReports(super.db);

  Future<void> updateCustomReportsConfig(
    api.CustomReportsFileHash? fileHash,
    api.CustomReportsConfig? config,
  ) async {
    await into(account).insertOnConflictUpdate(
      AccountCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        customReportsFileHash: Value(fileHash),
        customReportsConfig: Value(config?.toJsonString()),
      ),
    );
  }

  Stream<api.CustomReportsFileHash?> watchCustomReportsFileHash() =>
    watchColumn((r) => r.customReportsFileHash);
  Stream<api.CustomReportsConfig?> watchCustomReportsConfig() =>
    watchColumn((r) => r.customReportsConfig?.toCustomReportsConfig());
}
