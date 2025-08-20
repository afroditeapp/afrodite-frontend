import 'package:database_account_background/database_account_background.dart';
import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';
import 'package:openapi/api.dart' as api;

import '../schema.dart' as schema;

part 'new_received_likes_count.g.dart';

@DriftAccessor(tables: [schema.NewReceivedLikesCount])
class DaoReadNewReceivedLikesCount extends DatabaseAccessor<AccountBackgroundDatabase>
    with _$DaoReadNewReceivedLikesCountMixin {
  DaoReadNewReceivedLikesCount(super.db);

  Stream<int?> watchSyncVersionReceivedLikes() {
    return (select(newReceivedLikesCount)..where((t) => t.id.equals(SingleRowTable.ID.value)))
        .map((r) => r.syncVersionReceivedLikes)
        .watchSingleOrNull();
  }

  Stream<api.NewReceivedLikesCount?> watchReceivedLikesCount() {
    return (select(newReceivedLikesCount)..where((t) => t.id.equals(SingleRowTable.ID.value))).map((
      value,
    ) {
      return value.newReceivedLikesCount;
    }).watchSingleOrNull();
  }

  Stream<api.NewReceivedLikesCount?> watchReceivedLikesCountNotViewed() {
    return (select(newReceivedLikesCount)..where((t) => t.id.equals(SingleRowTable.ID.value))).map((
      value,
    ) {
      return value.newReceivedLikesCountNotViewed;
    }).watchSingleOrNull();
  }
}
