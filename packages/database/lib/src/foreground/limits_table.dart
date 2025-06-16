
import 'package:openapi/api.dart';

import 'account_database.dart';

import 'package:drift/drift.dart';

part 'limits_table.g.dart';

class Limits extends Table {
  // Only one row exists with ID ACCOUNT_DB_DATA_ID.
  IntColumn get id => integer().autoIncrement()();
  IntColumn get dailyLikesLeft => integer().nullable()();
  IntColumn get dailyLikesLeftSyncVersion => integer().nullable()();
}

@DriftAccessor(tables: [Limits])
class DaoLimits extends DatabaseAccessor<AccountDatabase> with _$DaoLimitsMixin {
  DaoLimits(super.db);

  Future<void> updateDailyLikesLeft(DailyLikesLeft value) async {
    await into(limits).insertOnConflictUpdate(
      LimitsCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        dailyLikesLeft: Value(value.likes),
        dailyLikesLeftSyncVersion: Value(value.version.version)
      ),
    );
  }

  Future<void> resetSyncVersion() async {
    await into(limits).insertOnConflictUpdate(
      LimitsCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        dailyLikesLeftSyncVersion: Value(null),
      ),
    );
  }

  Stream<int?> watchDailyLikesLeft() {
    return (select(limits)
      ..where((t) => t.id.equals(ACCOUNT_DB_DATA_ID.value))
    )
      .watchSingleOrNull()
      .map((r) {
        return r?.dailyLikesLeft;
      });
  }

  Stream<int?> watchDailyLikesLeftSyncVersion() {
    return (select(limits)
      ..where((t) => t.id.equals(ACCOUNT_DB_DATA_ID.value))
    )
      .watchSingleOrNull()
      .map((r) {
        return r?.dailyLikesLeftSyncVersion;
      });
  }
}
