import 'package:database_account/src/database.dart';
import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';
import 'package:openapi/api.dart' as api;

import '../../schema.dart' as schema;

part 'like.g.dart';

@DriftAccessor(tables: [schema.DailyLikesLeft])
class DaoWriteLike extends DatabaseAccessor<AccountDatabase> with _$DaoWriteLikeMixin {
  DaoWriteLike(super.db);

  Future<void> updateDailyLikesLeft(api.DailyLikesLeft value) async {
    await into(dailyLikesLeft).insertOnConflictUpdate(
      DailyLikesLeftCompanion.insert(
        id: SingleRowTable.ID,
        dailyLikesLeft: Value(value.likes),
        dailyLikesLeftSyncVersion: Value(value.version.version),
      ),
    );
  }

  Future<void> resetDailyLikesSyncVersion() async {
    await into(dailyLikesLeft).insertOnConflictUpdate(
      DailyLikesLeftCompanion.insert(id: SingleRowTable.ID, dailyLikesLeftSyncVersion: Value(null)),
    );
  }
}
