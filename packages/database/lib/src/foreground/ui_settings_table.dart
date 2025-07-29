
import 'package:database_model/database_model.dart';

import 'account_database.dart';

import 'package:drift/drift.dart';

part 'ui_settings_table.g.dart';

class UiSettings extends Table {
  // Only one row exists with ID ACCOUNT_DB_DATA_ID.
  IntColumn get id => integer().autoIncrement()();
  BoolColumn get advancedFilters => boolean().withDefault(const Constant(false))();
  RealColumn get gridHorizontalPadding => real().nullable()();
  RealColumn get gridInternalPadding => real().nullable()();
  RealColumn get gridProfileThumbnailBorderRadius => real().nullable()();
  IntColumn get gridRowProfileCount => integer().nullable()();
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

  Future<void> updateGridSettings(GridSettings value) async {
    await into(uiSettings).insertOnConflictUpdate(
      UiSettingsCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        gridHorizontalPadding: Value(value.horizontalPadding),
        gridInternalPadding: Value(value.internalPadding),
        gridProfileThumbnailBorderRadius: Value(value.profileThumbnailBorderRadius),
        gridRowProfileCount: Value(value.rowProfileCount),
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

  Stream<GridSettings> watchGridSettings() {
    return (select(uiSettings)
      ..where((t) => t.id.equals(ACCOUNT_DB_DATA_ID.value))
    )
      .watchSingleOrNull()
      .map((r) {
        return GridSettings(
          horizontalPadding: r?.gridHorizontalPadding,
          internalPadding: r?.gridInternalPadding,
          profileThumbnailBorderRadius: r?.gridProfileThumbnailBorderRadius,
          rowProfileCount: r?.gridRowProfileCount,
        );
      });
  }
}
