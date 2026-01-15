import 'package:database_common/src/database.dart';
import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';

import '../schema.dart' as schema;

part 'app.g.dart';

@DriftAccessor(tables: [schema.NotificationPermissionAsked, schema.ServerUrl, schema.CurrentLocale])
class DaoReadApp extends DatabaseAccessor<CommonDatabase> with _$DaoReadAppMixin {
  DaoReadApp(super.db);

  Stream<bool?> watchNotificationPermissionAsked() =>
      _watchNotificationPermissionAskedColumn((r) => r.notificationPermissionAsked);

  Stream<String?> watchCurrentLocale() => _watchCurrentLocaleColumn((r) => r.currentLocale);

  Stream<String?> watchServerUrl() => watchServerUrlColumn((r) => r.serverUrl);

  Stream<T?> _watchNotificationPermissionAskedColumn<T extends Object>(
    T? Function(NotificationPermissionAskedData) extractColumn,
  ) {
    return (select(
      notificationPermissionAsked,
    )..where((t) => t.id.equals(SingleRowTable.ID.value))).map(extractColumn).watchSingleOrNull();
  }

  Stream<T?> _watchCurrentLocaleColumn<T extends Object>(
    T? Function(CurrentLocaleData) extractColumn,
  ) {
    return (select(
      currentLocale,
    )..where((t) => t.id.equals(SingleRowTable.ID.value))).map(extractColumn).watchSingleOrNull();
  }

  Stream<T?> watchServerUrlColumn<T extends Object>(T? Function(ServerUrlData) extractColumn) {
    return (select(
      serverUrl,
    )..where((t) => t.id.equals(SingleRowTable.ID.value))).map(extractColumn).watchSingleOrNull();
  }
}
