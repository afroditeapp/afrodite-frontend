import 'package:database_account_background/database_account_background.dart';
import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';
import 'package:openapi/api.dart' as api;

import '../schema.dart' as schema;

part 'profile.g.dart';

@DriftAccessor(tables: [schema.Profile, schema.AutomaticProfileSearchBadgeState])
class DaoWriteProfile extends DatabaseAccessor<AccountBackgroundDatabase>
    with _$DaoWriteProfileMixin {
  DaoWriteProfile(super.db);

  /// NOTE: Currently unused
  Future<void> removeProfileData(api.AccountId accountId) async {
    await (update(profile)..where((t) => t.accountId.equals(accountId.aid))).write(
      const ProfileCompanion(profileName: Value(null), profileNameAccepted: Value(null)),
    );
  }

  Future<void> updateProfileData(api.AccountId idValue, api.Profile profileValue) async {
    await into(profile).insertOnConflictUpdate(
      ProfileCompanion.insert(
        accountId: idValue,
        profileName: Value(profileValue.name),
        profileNameAccepted: Value(profileValue.nameAccepted),
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
