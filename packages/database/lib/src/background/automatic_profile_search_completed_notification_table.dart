
import 'package:database/src/background/account_database.dart';

import 'package:drift/drift.dart';

part 'automatic_profile_search_completed_notification_table.g.dart';

class AutomaticProfileSearchCompletedNotificationTable extends Table {
  // Only one row exists with ID ACCOUNT_DB_DATA_ID.
  IntColumn get id => integer().autoIncrement()();
  IntColumn get profilesFoundViewed => integer().withDefault(const Constant(0))();
}

@DriftAccessor(tables: [AutomaticProfileSearchCompletedNotificationTable])
class DaoAutomaticProfileSearchCompletedNotificationTable extends DatabaseAccessor<AccountBackgroundDatabase> with _$DaoAutomaticProfileSearchCompletedNotificationTableMixin {
  DaoAutomaticProfileSearchCompletedNotificationTable(AccountBackgroundDatabase db) : super(db);

  /// Returns true when notification must be shown
  Future<bool> shouldProfilesFoundNotificationBeShown(int profilesFoundNotificationId) async {
    final current = await (select(automaticProfileSearchCompletedNotificationTable)
      ..where((t) => t.id.equals(ACCOUNT_DB_DATA_ID.value))
    )
      .map((r) => r.profilesFoundViewed)
      .getSingleOrNull();

    await into(automaticProfileSearchCompletedNotificationTable).insertOnConflictUpdate(
      AutomaticProfileSearchCompletedNotificationTableCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        profilesFoundViewed: Value(profilesFoundNotificationId),
      ),
    );

    return profilesFoundNotificationId != current;
  }
}
