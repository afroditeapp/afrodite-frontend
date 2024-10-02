
import 'package:database/src/background/account_database.dart';
import 'package:openapi/api.dart' show ReceivedLikesSyncVersion, NewReceivedLikesCount;

import 'package:drift/drift.dart';
import '../utils.dart';

part 'new_received_likes_available_table.g.dart';

class NewReceivedLikesAvailable extends Table {
  // Only ACCOUNT_DB_DATA_ID is available
  IntColumn get id => integer().autoIncrement()();

  IntColumn get syncVersionReceivedLikes => integer().nullable()();
  IntColumn get newReceivedLikesCount => integer().map(const NullAwareTypeConverter.wrap(NewReceivedLikesCountConverter())).nullable()();

  /// Count which will be reset once user views received likes screen
  IntColumn get newReceivedLikesCountNotViewed => integer().map(const NullAwareTypeConverter.wrap(NewReceivedLikesCountConverter())).nullable()();
}

@DriftAccessor(tables: [NewReceivedLikesAvailable])
class DaoNewReceivedLikesAvailable extends DatabaseAccessor<AccountBackgroundDatabase> with _$DaoNewReceivedLikesAvailableMixin {
  DaoNewReceivedLikesAvailable(AccountBackgroundDatabase db) : super(db);

  Future<void> updateSyncVersionReceivedLikes(
    ReceivedLikesSyncVersion value,
    NewReceivedLikesCount count,
  ) async {
    await into(newReceivedLikesAvailable).insertOnConflictUpdate(
      NewReceivedLikesAvailableCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        syncVersionReceivedLikes: Value(value.version),
        newReceivedLikesCount: Value(count),
      ),
    );
  }

  Future<void> updateReceivedLikesCountNotViewed(
    NewReceivedLikesCount count,
  ) async {
    await into(newReceivedLikesAvailable).insertOnConflictUpdate(
      NewReceivedLikesAvailableCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        newReceivedLikesCountNotViewed: Value(count),
      ),
    );
  }

  Stream<int?> watchSyncVersionReceivedLikes() {
    return (select(newReceivedLikesAvailable)
        ..where((t) => t.id.equals(ACCOUNT_DB_DATA_ID.value))
      )
        .map((r) => r.syncVersionReceivedLikes)
        .watchSingleOrNull();
  }

  Stream<NewReceivedLikesCount?> watchReceivedLikesCount() {
    return (select(newReceivedLikesAvailable)
      ..where((t) => t.id.equals(ACCOUNT_DB_DATA_ID.value))
    )
      .map((value) {
        return value.newReceivedLikesCount;
      })
      .watchSingleOrNull();
  }

  Stream<NewReceivedLikesCount?> watchReceivedLikesCountNotViewed() {
    return (select(newReceivedLikesAvailable)
      ..where((t) => t.id.equals(ACCOUNT_DB_DATA_ID.value))
    )
      .map((value) {
        return value.newReceivedLikesCountNotViewed;
      })
      .watchSingleOrNull();
  }
}
