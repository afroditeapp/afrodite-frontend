import 'package:database_account_foreground/src/database.dart';
import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';
import 'package:openapi/api.dart' as api;

import '../../schema.dart' as schema;

part 'privacy.g.dart';

@DriftAccessor(tables: [schema.ProfilePrivacySettings])
class DaoReadProfilePrivacy extends DatabaseAccessor<AccountForegroundDatabase>
    with _$DaoReadProfilePrivacyMixin {
  DaoReadProfilePrivacy(super.db);

  Stream<api.ProfilePrivacySettings?> watchProfilePrivacySettings() {
    return (select(
      profilePrivacySettings,
    )..where((t) => t.id.equals(SingleRowTable.ID.value))).watchSingleOrNull().map((r) {
      if (r == null) {
        return null;
      }
      return api.ProfilePrivacySettings(lastSeenTime: r.lastSeenTime, onlineStatus: r.onlineStatus);
    });
  }

  Future<api.ProfilePrivacySettings?> getProfilePrivacySettings() async {
    final r = await (select(
      profilePrivacySettings,
    )..where((t) => t.id.equals(SingleRowTable.ID.value))).getSingleOrNull();
    if (r == null) {
      return null;
    }
    return api.ProfilePrivacySettings(lastSeenTime: r.lastSeenTime, onlineStatus: r.onlineStatus);
  }
}
