
import 'package:openapi/api.dart' as api;

import 'package:database/src/background/account_database.dart';

import 'package:drift/drift.dart';

part 'automatic_profile_search_completed_notification_table.g.dart';

class AutomaticProfileSearchCompletedNotificationTable extends Table {
  // Only one row exists with ID ACCOUNT_DB_DATA_ID.
  IntColumn get id => integer().autoIncrement()();
  IntColumn get profilesFound => integer().withDefault(const Constant(0))();
  IntColumn get profilesFoundViewed => integer().withDefault(const Constant(0))();
}

@DriftAccessor(tables: [AutomaticProfileSearchCompletedNotificationTable])
class DaoAutomaticProfileSearchCompletedNotificationTable extends DatabaseAccessor<AccountBackgroundDatabase> with _$DaoAutomaticProfileSearchCompletedNotificationTableMixin {
  DaoAutomaticProfileSearchCompletedNotificationTable(super.db);

  /// Returns true when notification must be shown
  Future<bool> shouldProfilesFoundNotificationBeShown(int profilesFoundNotificationId, int viewedId) async {
    final (current, currentViewed) = await (select(automaticProfileSearchCompletedNotificationTable)
      ..where((t) => t.id.equals(ACCOUNT_DB_DATA_ID.value))
    )
      .map((r) => (r.profilesFound, r.profilesFoundViewed))
      .getSingleOrNull() ?? (null, null);

    await into(automaticProfileSearchCompletedNotificationTable).insertOnConflictUpdate(
      AutomaticProfileSearchCompletedNotificationTableCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        profilesFound: Value(profilesFoundNotificationId),
        profilesFoundViewed: Value(viewedId),
      ),
    );

    return profilesFoundNotificationId != current || currentViewed != viewedId;
  }

  Future<void> updateProfilesFoundViewed(api.AutomaticProfileSearchCompletedNotificationViewed viewed) async {
    await into(automaticProfileSearchCompletedNotificationTable).insertOnConflictUpdate(
      AutomaticProfileSearchCompletedNotificationTableCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        profilesFoundViewed: Value(viewed.profilesFound),
      ),
    );
  }
}
