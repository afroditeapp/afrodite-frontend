

import 'package:database/database.dart';
import 'package:utils/utils.dart';
import '../account_database.dart';

import 'package:drift/drift.dart';

part 'dao_server_maintenance.g.dart';

@DriftAccessor(tables: [Account])
class DaoServerMaintenance extends DatabaseAccessor<AccountDatabase> with _$DaoServerMaintenanceMixin, AccountTools {
  DaoServerMaintenance(super.db);

  Future<void> setMaintenanceTime({
    required UtcDateTime? time,
  }) async {
    await into(account).insertOnConflictUpdate(
      AccountCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        serverMaintenanceUnixTime: Value(time),
      ),
    );
  }

  Future<void> setMaintenanceTimeViewed({
    required UtcDateTime time,
  }) async {
    await into(account).insertOnConflictUpdate(
      AccountCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        serverMaintenanceUnixTimeViewed: Value(time),
      ),
    );
  }

  Stream<ServerMaintenanceInfo?> watchServerMaintenanceInfo() {
    return (select(account)
      ..where((t) => t.id.equals(ACCOUNT_DB_DATA_ID.value))
    )
      .map((r) {
        return ServerMaintenanceInfo(
          maintenanceLatest: r.serverMaintenanceUnixTime,
          maintenanceViewed: r.serverMaintenanceUnixTimeViewed,
        );
      })
      .watchSingleOrNull();
  }
}
