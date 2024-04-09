
import 'package:openapi/api.dart' show AccountId, ProfileContent, ProfileVisibility, Location;
import 'package:openapi/api.dart' as api;
import 'package:pihka_frontend/database/account_database.dart';

import 'package:drift/drift.dart';
import 'package:pihka_frontend/database/profile_entry.dart';
import 'package:pihka_frontend/database/utils.dart';
import 'package:pihka_frontend/utils/date.dart';


part 'dao_my_profile.g.dart';

@DriftAccessor(tables: [Account])
class DaoMyProfile extends DatabaseAccessor<AccountDatabase> with _$DaoMyProfileMixin, AccountTools {
  DaoMyProfile(AccountDatabase db) : super(db);

  Future<void> setApiProfile({
    required api.Profile profile,
  }) async {
    await into(account).insertOnConflictUpdate(
      AccountCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        profileName: Value(profile.name),
        profileText: Value(profile.profileText),
        profileAge: Value(profile.age),
        jsonProfileAttributes: Value(profile.attributes.toJsonList()),
      ),
    );
  }

  Stream<List<api.ProfileAttributeValue>?> watchProfileAttributes() =>
    watchColumn((r) => r.jsonProfileAttributes?.toProfileAttributes());
}
