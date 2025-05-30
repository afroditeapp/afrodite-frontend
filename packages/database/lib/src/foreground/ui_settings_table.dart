
import 'account_database.dart';

import 'package:drift/drift.dart';

part 'ui_settings_table.g.dart';

class UiSettings extends Table {
  // Only one row exists with ID ACCOUNT_DB_DATA_ID.
  IntColumn get id => integer().autoIncrement()();
  BoolColumn get advancedFilters => boolean().withDefault(const Constant(false))();
}

@DriftAccessor(tables: [UiSettings])
class DaoUiSettings extends DatabaseAccessor<AccountDatabase> with _$DaoUiSettingsMixin {
  DaoUiSettings(super.db);

  Future<void> updateShowAdvancedFilters(bool value) async {
    await into(uiSettings).insertOnConflictUpdate(
      UiSettingsCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        advancedFilters: Value(value),
      ),
    );
  }

  Stream<bool?> watchShowAdvancedFilters() {
    return (select(uiSettings)
      ..where((t) => t.id.equals(ACCOUNT_DB_DATA_ID.value))
    )
      .watchSingleOrNull()
      .map((r) {
        return r?.advancedFilters;
      });
  }
}
