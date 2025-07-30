import 'package:database_account_background/database_account_background.dart';
import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';
import 'package:openapi/api.dart' as api;

import '../schema.dart' as schema;

part 'news.g.dart';

@DriftAccessor(
  tables: [
    schema.News,
  ]
)
class DaoReadNews extends DatabaseAccessor<AccountBackgroundDatabase> with _$DaoReadNewsMixin {
  DaoReadNews(super.db);

  Stream<api.UnreadNewsCount?> watchUnreadNewsCount() {
    return (select(news)
      ..where((t) => t.id.equals(SingleRowTable.ID.value))
    )
      .map((r) {
        return r.newsCount;
      })
      .watchSingleOrNull();
  }

  Stream<int?> watchSyncVersionNews() {
    return (select(news)
      ..where((t) => t.id.equals(SingleRowTable.ID.value))
    )
      .map((r) {
        return r.syncVersionNews;
      })
      .watchSingleOrNull();
  }

}
