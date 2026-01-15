import 'package:database_account/src/database.dart';
import 'package:database_converter/database_converter.dart';
import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';
import 'package:openapi/api.dart' as api;

import '../../schema.dart' as schema;

part 'search.g.dart';

@DriftAccessor(
  tables: [
    schema.ProfileFilters,
    schema.ProfileSearchGroups,
    schema.ProfileSearchAgeRange,
    schema.AutomaticProfileSearchSettings,
    schema.AutomaticProfileSearchBadgeState,
  ],
)
class DaoWriteSearch extends DatabaseAccessor<AccountForegroundDatabase>
    with _$DaoWriteSearchMixin {
  DaoWriteSearch(super.db);

  Future<void> updateProfileFilters(api.GetProfileFilters? value) async {
    await into(profileFilters).insertOnConflictUpdate(
      ProfileFiltersCompanion.insert(
        id: SingleRowTable.ID,
        jsonProfileFilters: Value(value?.toJsonObject()),
      ),
    );
  }

  Future<void> updateSearchAgeRange(api.SearchAgeRange? value) async {
    await into(profileSearchAgeRange).insertOnConflictUpdate(
      ProfileSearchAgeRangeCompanion.insert(
        id: SingleRowTable.ID,
        minAge: Value(value?.min),
        maxAge: Value(value?.max),
      ),
    );
  }

  Future<void> updateSearchGroups(api.SearchGroups? value) async {
    await into(profileSearchGroups).insertOnConflictUpdate(
      ProfileSearchGroupsCompanion.insert(
        id: SingleRowTable.ID,
        jsonProfileSearchGroups: Value(value?.toJsonObject()),
      ),
    );
  }

  Future<void> updateAutomaticProfileSearchSettings(
    api.AutomaticProfileSearchSettings? value,
  ) async {
    await into(automaticProfileSearchSettings).insertOnConflictUpdate(
      AutomaticProfileSearchSettingsCompanion.insert(
        id: SingleRowTable.ID,
        jsonAutomaticProfileSearchSettings: Value(value?.toJsonObject()),
      ),
    );
  }

  Future<void> showAutomaticProfileSearchBadge(int profileCount) async {
    await into(automaticProfileSearchBadgeState).insertOnConflictUpdate(
      AutomaticProfileSearchBadgeStateCompanion.insert(
        id: SingleRowTable.ID,
        profileCount: Value(profileCount),
        showBadge: Value(true),
      ),
    );
  }

  Future<void> hideAutomaticProfileSearchBadge() async {
    await into(automaticProfileSearchBadgeState).insertOnConflictUpdate(
      AutomaticProfileSearchBadgeStateCompanion.insert(
        id: SingleRowTable.ID,
        showBadge: Value(false),
      ),
    );
  }
}
