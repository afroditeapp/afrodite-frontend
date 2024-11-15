
import 'package:database/src/background/account_database.dart';
import 'package:openapi/api.dart' as api;

import 'package:drift/drift.dart';
import '../utils.dart';

part 'news_table.g.dart';

class News extends Table {
  // Only ACCOUNT_DB_DATA_ID is available
  IntColumn get id => integer().autoIncrement()();

  IntColumn get newsCount => integer().map(const NullAwareTypeConverter.wrap(UnreadNewsCountConverter())).nullable()();
  IntColumn get syncVersionNews => integer().nullable()();
}

@DriftAccessor(tables: [News])
class DaoNews extends DatabaseAccessor<AccountBackgroundDatabase> with _$DaoNewsMixin {
  DaoNews(AccountBackgroundDatabase db) : super(db);

  Future<void> setUnreadNewsCount({
    required api.NewsSyncVersion version,
    required api.UnreadNewsCount unreadNewsCount,
  }) async {
    await transaction(() async {
      await into(news).insertOnConflictUpdate(
        NewsCompanion.insert(
          id: ACCOUNT_DB_DATA_ID,
          newsCount: Value(unreadNewsCount),
          syncVersionNews: Value(version.version)
        ),
      );
    });
  }

  Future<void> resetSyncVersion() async {
    await into(news).insertOnConflictUpdate(
      NewsCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        syncVersionNews: Value(null)
      ),
    );
  }

  Stream<api.UnreadNewsCount?> watchUnreadNewsCount() {
    return (select(news)
      ..where((t) => t.id.equals(ACCOUNT_DB_DATA_ID.value))
    )
      .map((r) {
        return r.newsCount;
      })
      .watchSingleOrNull();
  }

  Stream<int?> watchSyncVersionNews() {
    return (select(news)
      ..where((t) => t.id.equals(ACCOUNT_DB_DATA_ID.value))
    )
      .map((r) {
        return r.syncVersionNews;
      })
      .watchSingleOrNull();
  }
}
