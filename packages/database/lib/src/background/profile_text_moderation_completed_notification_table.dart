
import 'package:database/src/background/account_database.dart';

import 'package:drift/drift.dart';

part 'profile_text_moderation_completed_notification_table.g.dart';

class ProfileTextModerationCompletedNotificationTable extends Table {
  // Only one row exists with ID ACCOUNT_DB_DATA_ID.
  IntColumn get id => integer().autoIncrement()();
  IntColumn get acceptedViewed => integer().withDefault(const Constant(0))();
  IntColumn get rejectedViewed => integer().withDefault(const Constant(0))();
}

@DriftAccessor(tables: [ProfileTextModerationCompletedNotificationTable])
class DaoProfileTextModerationCompletedNotificationTable extends DatabaseAccessor<AccountBackgroundDatabase> with _$DaoProfileTextModerationCompletedNotificationTableMixin {
  DaoProfileTextModerationCompletedNotificationTable(AccountBackgroundDatabase db) : super(db);

  /// Returns true when notification must be shown
  Future<bool> shouldAcceptedNotificationBeShown(int acceptedNotificationId) async {
    final current = await (select(profileTextModerationCompletedNotificationTable)
      ..where((t) => t.id.equals(ACCOUNT_DB_DATA_ID.value))
    )
      .map((r) => r.acceptedViewed)
      .getSingleOrNull();

    await into(profileTextModerationCompletedNotificationTable).insertOnConflictUpdate(
      ProfileTextModerationCompletedNotificationTableCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        acceptedViewed: Value(acceptedNotificationId),
      ),
    );

    return acceptedNotificationId != current;
  }

  /// Returns true when notification must be shown
  Future<bool> shouldRejectedNotificationBeShown(int rejectedNotificationId) async {
    final current = await (select(profileTextModerationCompletedNotificationTable)
      ..where((t) => t.id.equals(ACCOUNT_DB_DATA_ID.value))
    )
      .map((r) => r.rejectedViewed)
      .getSingleOrNull();

    await into(profileTextModerationCompletedNotificationTable).insertOnConflictUpdate(
      ProfileTextModerationCompletedNotificationTableCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        rejectedViewed: Value(rejectedNotificationId),
      ),
    );

    return rejectedNotificationId != current;
  }
}
