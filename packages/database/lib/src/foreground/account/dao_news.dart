
import 'package:openapi/api.dart' as api;
import '../account_database.dart';

import 'package:drift/drift.dart';

part 'dao_news.g.dart';

@DriftAccessor(tables: [Account])
class DaoNews extends DatabaseAccessor<AccountDatabase> with _$DaoNewsMixin, AccountTools {
  DaoNews(AccountDatabase db) : super(db);

  Future<void> setNewsCount({
    required api.NewsCountResult info,
  }) async {
    await transaction(() async {
      await into(account).insertOnConflictUpdate(
        AccountCompanion.insert(
          id: ACCOUNT_DB_DATA_ID,
          newsCount: Value(info.c),
        ),
      );
      await db.daoSyncVersions.updateSyncVersionNews(info.v);
    });
  }

  Future<void> setNewsCountUserViewed({
    required api.NewsCount count,
  }) async {
    await into(account).insertOnConflictUpdate(
      AccountCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        newsCountUserViewed: Value(count),
      ),
    );
  }

  Stream<api.NewsCount?> watchNewsCount() {
    return (select(account)
      ..where((t) => t.id.equals(ACCOUNT_DB_DATA_ID.value))
    )
      .map((r) {
        return r.newsCount;
      })
      .watchSingleOrNull();
  }

  Stream<api.NewsCount?> watchNewsCountUserViewed() {
    return (select(account)
      ..where((t) => t.id.equals(ACCOUNT_DB_DATA_ID.value))
    )
      .map((r) {
        return r.newsCountUserViewed;
      })
      .watchSingleOrNull();
  }
}
