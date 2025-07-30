
import 'package:database_account_background/database_account_background.dart';
import 'package:drift/drift.dart';
import 'package:openapi/api.dart' as api;

import '../schema.dart' as schema;

part 'profile.g.dart';

@DriftAccessor(
  tables: [
    schema.Profile,
  ]
)
class DaoWriteProfile extends DatabaseAccessor<AccountBackgroundDatabase> with _$DaoWriteProfileMixin {
  DaoWriteProfile(super.db);

  Future<void> removeProfileData(api.AccountId accountId) async {
    await (update(profile)..where((t) => t.uuidAccountId.equals(accountId.aid)))
      .write(const ProfileCompanion(
        profileName: Value(null),
        profileNameAccepted: Value(null),
      ));
  }

  Future<void> updateProfileData(api.AccountId idValue, api.Profile profileValue) async {
    await into(profile).insertOnConflictUpdate(
      ProfileCompanion.insert(
        uuidAccountId: idValue,
        profileName: Value(profileValue.name),
        profileNameAccepted: Value(profileValue.nameAccepted),
      ),
    );
  }
}
