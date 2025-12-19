import 'package:database_account_foreground/src/database.dart';
import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';
import 'package:openapi/api.dart' as api;

import '../../schema.dart' as schema;

part 'privacy.g.dart';

@DriftAccessor(tables: [schema.ProfilePrivacySettings])
class DaoWriteProfilePrivacy extends DatabaseAccessor<AccountForegroundDatabase>
    with _$DaoWriteProfilePrivacyMixin {
  DaoWriteProfilePrivacy(super.db);

  Future<void> updateProfilePrivacySettings(api.ProfilePrivacySettings settings) async {
    await into(profilePrivacySettings).insertOnConflictUpdate(
      ProfilePrivacySettingsCompanion.insert(
        id: SingleRowTable.ID,
        lastSeenTime: Value(settings.lastSeenTime),
        onlineStatus: Value(settings.onlineStatus),
      ),
    );
  }
}
