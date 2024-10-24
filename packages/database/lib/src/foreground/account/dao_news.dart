
import 'package:openapi/api.dart' as api;
import '../account_database.dart';

import 'package:drift/drift.dart';

part 'dao_news.g.dart';

@DriftAccessor(tables: [Account])
class DaoNews extends DatabaseAccessor<AccountDatabase> with _$DaoNewsMixin, AccountTools {
  DaoNews(AccountDatabase db) : super(db);

  Future<void> setUnreadNewsCount({
    required api.NewsSyncVersion version,
    required api.UnreadNewsCount unreadNewsCount,
  }) async {
    await transaction(() async {
      await into(account).insertOnConflictUpdate(
        AccountCompanion.insert(
          id: ACCOUNT_DB_DATA_ID,
          newsCount: Value(unreadNewsCount),
        ),
      );
      await db.daoSyncVersions.updateSyncVersionNews(version);
    });
  }

  Stream<api.UnreadNewsCount?> watchUnreadNewsCount() {
    return (select(account)
      ..where((t) => t.id.equals(ACCOUNT_DB_DATA_ID.value))
    )
      .map((r) {
        return r.newsCount;
      })
      .watchSingleOrNull();
  }
}
