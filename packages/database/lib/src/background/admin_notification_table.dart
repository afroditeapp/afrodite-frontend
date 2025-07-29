
import 'package:database/src/converter/json/string.dart';
import 'package:openapi/api.dart' as api;

import 'package:database/src/background/account_database.dart';

import 'package:drift/drift.dart';

part 'admin_notification_table.g.dart';

class AdminNotificationTable extends Table {
  // Only one row exists with ID ACCOUNT_DB_DATA_ID.
  IntColumn get id => integer().autoIncrement()();
  TextColumn get jsonViewedNotification => text().map(NullAwareTypeConverter.wrap(JsonString.driftConverter)).nullable()();
}

@DriftAccessor(tables: [AdminNotificationTable])
class DaoAdminNotificationTable extends DatabaseAccessor<AccountBackgroundDatabase> with _$DaoAdminNotificationTableMixin {
  DaoAdminNotificationTable(super.db);

  Future<api.AdminNotification?> getNotification() async {
    return await (select(adminNotificationTable)
      ..where((t) => t.id.equals(ACCOUNT_DB_DATA_ID.value))
    )
      .map((r) => r.jsonViewedNotification?.toAdminNotification())
      .getSingleOrNull();
  }

  Future<void> updateNotification(api.AdminNotification notification) async {
    await into(adminNotificationTable).insertOnConflictUpdate(
      AdminNotificationTableCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        jsonViewedNotification: Value(notification.toJsonString()),
      ),
    );
  }

  Future<void> removeNotification() async {
    await into(adminNotificationTable).insertOnConflictUpdate(
      AdminNotificationTableCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        jsonViewedNotification: Value(null),
      ),
    );
  }
}
