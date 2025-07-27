
import 'package:openapi/api.dart' as api;

import 'package:database/src/background/account_database.dart';

import 'package:drift/drift.dart';

part 'profile_text_moderation_completed_notification_table.g.dart';

class ProfileTextModerationCompletedNotificationTable extends Table {
  // Only one row exists with ID ACCOUNT_DB_DATA_ID.
  IntColumn get id => integer().autoIncrement()();
  IntColumn get accepted => integer().withDefault(const Constant(0))();
  IntColumn get acceptedViewed => integer().withDefault(const Constant(0))();
  IntColumn get rejected => integer().withDefault(const Constant(0))();
  IntColumn get rejectedViewed => integer().withDefault(const Constant(0))();
}

@DriftAccessor(tables: [ProfileTextModerationCompletedNotificationTable])
class DaoProfileTextModerationCompletedNotificationTable extends DatabaseAccessor<AccountBackgroundDatabase> with _$DaoProfileTextModerationCompletedNotificationTableMixin {
  DaoProfileTextModerationCompletedNotificationTable(super.db);

  /// Returns true when notification must be shown
  Future<bool> shouldAcceptedNotificationBeShown(api.NotificationStatus accepted) async {
    final (current, currentViewed) = await (select(profileTextModerationCompletedNotificationTable)
      ..where((t) => t.id.equals(ACCOUNT_DB_DATA_ID.value))
    )
      .map((r) => (r.accepted, r.acceptedViewed))
      .getSingleOrNull() ?? (null, null);

    await into(profileTextModerationCompletedNotificationTable).insertOnConflictUpdate(
      ProfileTextModerationCompletedNotificationTableCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        accepted: Value(accepted.id.id),
        acceptedViewed: Value(accepted.viewed.id),
      ),
    );

    return accepted.id.id != current || accepted.viewed.id != currentViewed;
  }

  /// Returns true when notification must be shown
  Future<bool> shouldRejectedNotificationBeShown(api.NotificationStatus rejected) async {
    final (current, currentViewed) = await (select(profileTextModerationCompletedNotificationTable)
      ..where((t) => t.id.equals(ACCOUNT_DB_DATA_ID.value))
    )
      .map((r) => (r.rejected, r.rejectedViewed))
      .getSingleOrNull() ?? (null, null);

    await into(profileTextModerationCompletedNotificationTable).insertOnConflictUpdate(
      ProfileTextModerationCompletedNotificationTableCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        rejected: Value(rejected.id.id),
        rejectedViewed: Value(rejected.viewed.id),
      ),
    );

    return rejected.id.id != current || rejected.viewed.id != currentViewed;
  }

  Future<void> updateViewedValues(api.ProfileStringModerationCompletedNotificationViewed viewed) async {
    await into(profileTextModerationCompletedNotificationTable).insertOnConflictUpdate(
      ProfileTextModerationCompletedNotificationTableCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        acceptedViewed: Value(viewed.textAccepted.id),
        rejectedViewed: Value(viewed.textRejected.id),
      ),
    );
  }
}
