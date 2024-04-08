
import 'package:openapi/api.dart' show AccountId, ProfileContent, ProfileVisibility, Location;
import 'package:openapi/api.dart' as api;
import 'package:pihka_frontend/database/account_database.dart';

import 'package:drift/drift.dart';
import 'package:pihka_frontend/database/profile_entry.dart';
import 'package:pihka_frontend/database/utils.dart';
import 'package:pihka_frontend/utils/date.dart';


part 'dao_profile_settings.g.dart';

@DriftAccessor(tables: [Account])
class DaoProfileSettings extends DatabaseAccessor<AccountDatabase> with _$DaoProfileSettingsMixin, AccountTools {
  DaoProfileSettings(AccountDatabase db) : super(db);


  Future<void> updateProfileLocation({required double latitude, required double longitude}) async {
    await into(account).insertOnConflictUpdate(
      AccountCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        profileLocationLatitude: Value(latitude),
        profileLocationLongitude: Value(longitude),
      ),
    );
  }

  Future<void> updateProfileVisibility(ProfileVisibility? value) async {
    await into(account).insertOnConflictUpdate(
      AccountCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        jsonProfileVisibility: Value(value?.toEnumString()),
      ),
    );
  }

  Stream<ProfileVisibility?> watchProfileVisibility() =>
    watchColumn((r) => r.jsonProfileVisibility?.toProfileVisibility());

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

}
