
import 'package:openapi/api.dart' as api;

import 'package:database/src/background/account_database.dart';

import 'package:drift/drift.dart';

part 'media_content_moderation_completed_notification_table.g.dart';

class MediaContentModerationCompletedNotificationTable extends Table {
  // Only one row exists with ID ACCOUNT_DB_DATA_ID.
  IntColumn get id => integer().autoIncrement()();
  IntColumn get accepted => integer().withDefault(const Constant(0))();
  IntColumn get acceptedViewed => integer().withDefault(const Constant(0))();
  IntColumn get rejected => integer().withDefault(const Constant(0))();
  IntColumn get rejectedViewed => integer().withDefault(const Constant(0))();
}

@DriftAccessor(tables: [MediaContentModerationCompletedNotificationTable])
class DaoMediaContentModerationCompletedNotificationTable extends DatabaseAccessor<AccountBackgroundDatabase> with _$DaoMediaContentModerationCompletedNotificationTableMixin {
  DaoMediaContentModerationCompletedNotificationTable(super.db);

  /// Returns true when notification must be shown
  Future<bool> shouldAcceptedNotificationBeShown(int acceptedNotificationId, int viewedId) async {
    final (current, currentViewed) = await (select(mediaContentModerationCompletedNotificationTable)
      ..where((t) => t.id.equals(ACCOUNT_DB_DATA_ID.value))
    )
      .map((r) => (r.accepted, r.acceptedViewed))
      .getSingleOrNull() ?? (null, null);

    await into(mediaContentModerationCompletedNotificationTable).insertOnConflictUpdate(
      MediaContentModerationCompletedNotificationTableCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        accepted: Value(acceptedNotificationId),
        acceptedViewed: Value(viewedId),
      ),
    );

    return acceptedNotificationId != current || viewedId != currentViewed;
  }

  /// Returns true when notification must be shown
  Future<bool> shouldRejectedNotificationBeShown(int rejectedNotificationId, int viewedId) async {
    final (current, currentViewed) = await (select(mediaContentModerationCompletedNotificationTable)
      ..where((t) => t.id.equals(ACCOUNT_DB_DATA_ID.value))
    )
      .map((r) => (r.rejected, r.rejectedViewed))
      .getSingleOrNull() ?? (null, null);

    await into(mediaContentModerationCompletedNotificationTable).insertOnConflictUpdate(
      MediaContentModerationCompletedNotificationTableCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        rejected: Value(rejectedNotificationId),
        rejectedViewed: Value(viewedId),
      ),
    );

    return rejectedNotificationId != current || viewedId != currentViewed;
  }

  Future<void> updateViewedValues(api.MediaContentModerationCompletedNotificationViewed viewed) async {
    await into(mediaContentModerationCompletedNotificationTable).insertOnConflictUpdate(
      MediaContentModerationCompletedNotificationTableCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        acceptedViewed: Value(viewed.accepted),
        rejectedViewed: Value(viewed.rejected),
      ),
    );
  }
}
