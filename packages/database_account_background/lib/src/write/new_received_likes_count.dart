
import 'package:database_account_background/database_account_background.dart';
import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';
import 'package:openapi/api.dart' as api;

import '../schema.dart' as schema;

part 'new_received_likes_count.g.dart';

@DriftAccessor(
  tables: [
    schema.NewReceivedLikesCount,
  ]
)
class DaoWriteNewReceivedLikesCount extends DatabaseAccessor<AccountBackgroundDatabase> with _$DaoWriteNewReceivedLikesCountMixin {
  DaoWriteNewReceivedLikesCount(super.db);

  Future<void> updateSyncVersionReceivedLikes(
    api.ReceivedLikesSyncVersion value,
    api.NewReceivedLikesCount count,
  ) async {
    await into(newReceivedLikesCount).insertOnConflictUpdate(
      NewReceivedLikesCountCompanion.insert(
        id: SingleRowTable.ID,
        syncVersionReceivedLikes: Value(value.version),
        newReceivedLikesCount: Value(count),
      ),
    );
  }

  Future<void> updateReceivedLikesCountNotViewed(
    api.NewReceivedLikesCount count,
  ) async {
    await into(newReceivedLikesCount).insertOnConflictUpdate(
      NewReceivedLikesCountCompanion.insert(
        id: SingleRowTable.ID,
        newReceivedLikesCountNotViewed: Value(count),
      ),
    );
  }

  Future<void> resetReceivedLikesSyncVersion() async {
    await into(newReceivedLikesCount).insertOnConflictUpdate(
      NewReceivedLikesCountCompanion.insert(
        id: SingleRowTable.ID,
        syncVersionReceivedLikes: Value(null),
      ),
    );
  }
}
