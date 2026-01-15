import 'package:database_account/src/database.dart';
import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';

import '../../schema.dart' as schema;

part 'like.g.dart';

@DriftAccessor(tables: [schema.DailyLikesLeft])
class DaoReadLike extends DatabaseAccessor<AccountDatabase> with _$DaoReadLikeMixin {
  DaoReadLike(super.db);

  Stream<int?> watchDailyLikesLeft() {
    return (select(
      dailyLikesLeft,
    )..where((t) => t.id.equals(SingleRowTable.ID.value))).watchSingleOrNull().map((r) {
      return r?.dailyLikesLeft;
    });
  }

  Stream<int?> watchDailyLikesLeftSyncVersion() {
    return (select(
      dailyLikesLeft,
    )..where((t) => t.id.equals(SingleRowTable.ID.value))).watchSingleOrNull().map((r) {
      return r?.dailyLikesLeftSyncVersion;
    });
  }
}
