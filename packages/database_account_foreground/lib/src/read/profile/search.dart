
import 'package:database_account_foreground/src/database.dart';
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
  ]
)
class DaoReadSearch extends DatabaseAccessor<AccountForegroundDatabase> with _$DaoReadSearchMixin {
  DaoReadSearch(super.db);

  Stream<api.GetProfileFilteringSettings?> watchProfileFilteringSettings() =>
    _watchColumnFilters((r) => r.jsonProfileFilters?.toProfileAttributeFilterList());

  Stream<T?> _watchColumnFilters<T extends Object>(T? Function(ProfileFilter) extractColumn) {
    return (select(profileFilters)..where((t) => t.id.equals(SingleRowTable.ID.value)))
      .map(extractColumn)
      .watchSingleOrNull();
  }

  Stream<int?> watchProfileSearchAgeRangeMin() =>
    _watchColumnAgeRange((r) => r.minAge);

  Stream<int?> watchProfileSearchAgeRangeMax() =>
    _watchColumnAgeRange((r) => r.maxAge);

  Stream<T?> _watchColumnAgeRange<T extends Object>(T? Function(ProfileSearchAgeRangeData) extractColumn) {
    return (select(profileSearchAgeRange)..where((t) => t.id.equals(SingleRowTable.ID.value)))
      .map(extractColumn)
      .watchSingleOrNull();
  }

  Stream<api.SearchGroups?> watchSearchGroups() =>
    _watchColumnGroups((r) => r.jsonProfileSearchGroups?.toSearchGroups());

  Stream<T?> _watchColumnGroups<T extends Object>(T? Function(ProfileSearchGroup) extractColumn) {
    return (select(profileSearchGroups)..where((t) => t.id.equals(SingleRowTable.ID.value)))
      .map(extractColumn)
      .watchSingleOrNull();
  }
}
