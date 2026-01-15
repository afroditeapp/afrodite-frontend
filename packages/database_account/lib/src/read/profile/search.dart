import 'package:database_account/src/database.dart';
import 'package:database_model/database_model.dart';
import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';
import 'package:openapi/api.dart' as api;

import '../../schema.dart' as schema;

part 'search.g.dart';

@DriftAccessor(
  tables: [
    schema.ProfileFilters,
    schema.ProfileSearchAgeRange,
    schema.ProfileSearchGroups,
    schema.AutomaticProfileSearchSettings,
    schema.AutomaticProfileSearchBadgeState,
  ],
)
class DaoReadSearch extends DatabaseAccessor<AccountDatabase> with _$DaoReadSearchMixin {
  DaoReadSearch(super.db);

  Stream<api.GetProfileFilters?> watchProfileFilters() =>
      _watchColumnFilters((r) => r.jsonProfileFilters?.value);

  Stream<T?> _watchColumnFilters<T extends Object>(T? Function(ProfileFilter) extractColumn) {
    return (select(
      profileFilters,
    )..where((t) => t.id.equals(SingleRowTable.ID.value))).map(extractColumn).watchSingleOrNull();
  }

  Stream<int?> watchProfileSearchAgeRangeMin() => _watchColumnAgeRange((r) => r.minAge);

  Stream<int?> watchProfileSearchAgeRangeMax() => _watchColumnAgeRange((r) => r.maxAge);

  Stream<T?> _watchColumnAgeRange<T extends Object>(
    T? Function(ProfileSearchAgeRangeData) extractColumn,
  ) {
    return (select(
      profileSearchAgeRange,
    )..where((t) => t.id.equals(SingleRowTable.ID.value))).map(extractColumn).watchSingleOrNull();
  }

  Stream<api.SearchGroups?> watchSearchGroups() =>
      _watchColumnGroups((r) => r.jsonProfileSearchGroups?.value);

  Stream<T?> _watchColumnGroups<T extends Object>(T? Function(ProfileSearchGroup) extractColumn) {
    return (select(
      profileSearchGroups,
    )..where((t) => t.id.equals(SingleRowTable.ID.value))).map(extractColumn).watchSingleOrNull();
  }

  Stream<api.AutomaticProfileSearchSettings?> watchAutomaticProfileSearchSettings() =>
      _watchColumnAutomaticProfileSearchSettings(
        (r) => r.jsonAutomaticProfileSearchSettings?.value,
      );

  Stream<T?> _watchColumnAutomaticProfileSearchSettings<T extends Object>(
    T? Function(AutomaticProfileSearchSetting) extractColumn,
  ) {
    return (select(
      automaticProfileSearchSettings,
    )..where((t) => t.id.equals(SingleRowTable.ID.value))).map(extractColumn).watchSingleOrNull();
  }

  Stream<AutomaticProfileSearchBadgeState?> watchAutomaticProfileSearchUiState() {
    return (select(
      automaticProfileSearchBadgeState,
    )..where((t) => t.id.equals(SingleRowTable.ID.value))).watchSingleOrNull().map((r) {
      if (r == null) {
        return null;
      }
      return AutomaticProfileSearchBadgeState(r.profileCount, r.showBadge);
    });
  }
}
