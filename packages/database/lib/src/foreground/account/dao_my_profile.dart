

import 'package:database/src/utils.dart';
import 'package:openapi/api.dart' as api;
import '../account_database.dart';

import 'package:drift/drift.dart';



part 'dao_my_profile.g.dart';

@DriftAccessor(tables: [Account])
class DaoMyProfile extends DatabaseAccessor<AccountDatabase> with _$DaoMyProfileMixin, AccountTools {
  DaoMyProfile(AccountDatabase db) : super(db);

  Future<void> setApiProfile({
    required api.GetMyProfileResult result,
  }) async {
    final profile = result.p;
    await into(account).insertOnConflictUpdate(
      AccountCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        profileName: Value(profile.name),
        profileNameAccepted: Value(profile.nameAccepted),
        profileNameModerationState: Value(result.nameModerationState.toEnumString()),
        profileText: Value(profile.ptext),
        profileAge: Value(profile.age),
        profileVersion: Value(result.v),
        profileUnlimitedLikes: Value(profile.unlimitedLikes),
        jsonProfileAttributes: Value(profile.attributes.toJsonList()),
      ),
    );
  }

  Stream<List<api.ProfileAttributeValue>?> watchProfileAttributes() =>
    watchColumn((r) => r.jsonProfileAttributes?.toProfileAttributes());
}
