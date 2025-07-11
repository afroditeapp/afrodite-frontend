
import 'package:openapi/api.dart' show Location, GetProfileFilteringSettings, SearchGroups, ProfileSearchAgeRange;
import 'package:drift/drift.dart';

import 'package:database/src/utils.dart';
import '../account_database.dart';

part 'dao_profile_settings.g.dart';

@DriftAccessor(tables: [Account])
class DaoProfileSettings extends DatabaseAccessor<AccountDatabase> with _$DaoProfileSettingsMixin, AccountTools {
  DaoProfileSettings(super.db);


  Future<void> updateProfileLocation({required double latitude, required double longitude}) async {
    await into(account).insertOnConflictUpdate(
      AccountCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        profileLocationLatitude: Value(latitude),
        profileLocationLongitude: Value(longitude),
      ),
    );
  }

  Future<void> updateProfileFilteringSettings(GetProfileFilteringSettings? value) async {
    await into(account).insertOnConflictUpdate(
      AccountCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        jsonProfileFilteringSettings: Value(value?.toJsonString()),
      ),
    );
  }

  Future<void> updateProfileSearchAgeRange(ProfileSearchAgeRange? value) async {
    await into(account).insertOnConflictUpdate(
      AccountCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        profileSearchAgeRangeMin: Value(value?.min),
        profileSearchAgeRangeMax: Value(value?.max),
      ),
    );
  }

  Future<void> updateSearchGroups(SearchGroups? value) async {
    await into(account).insertOnConflictUpdate(
      AccountCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        jsonSearchGroups: Value(value?.toJsonString()),
      ),
    );
  }

  Stream<Location?> watchProfileLocation() =>
    selectFromDataId()
      .map((r) {
        final latitude = r.profileLocationLatitude;
        final longitude = r.profileLocationLongitude;
        if (latitude != null && longitude != null) {
          return Location(latitude: latitude, longitude: longitude);
        } else {
          return null;
        }
      })
      .watchSingleOrNull();

  Stream<GetProfileFilteringSettings?> watchProfileFilteringSettings() =>
    watchColumn((r) => r.jsonProfileFilteringSettings?.toProfileAttributeFilterList());

  Stream<int?> watchProfileSearchAgeRangeMin() =>
    watchColumn((r) => r.profileSearchAgeRangeMin);

  Stream<int?> watchProfileSearchAgeRangeMax() =>
    watchColumn((r) => r.profileSearchAgeRangeMax);

  Stream<SearchGroups?> watchSearchGroups() =>
    watchColumn((r) => r.jsonSearchGroups?.toSearchGroups());
}
