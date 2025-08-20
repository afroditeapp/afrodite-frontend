import 'package:database_account_background/database_account_background.dart';
import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';
import 'package:openapi/api.dart' as api;

import '../schema.dart' as schema;

part 'news.g.dart';

@DriftAccessor(tables: [schema.News])
class DaoWriteNews extends DatabaseAccessor<AccountBackgroundDatabase> with _$DaoWriteNewsMixin {
  DaoWriteNews(super.db);

  Future<void> setUnreadNewsCount({
    required api.NewsSyncVersion version,
    required api.UnreadNewsCount unreadNewsCount,
  }) async {
    await transaction(() async {
      await into(news).insertOnConflictUpdate(
        NewsCompanion.insert(
          id: SingleRowTable.ID,
          newsCount: Value(unreadNewsCount),
          syncVersionNews: Value(version.version),
        ),
      );
    });
  }

  Future<void> resetSyncVersion() async {
    await into(news).insertOnConflictUpdate(
      NewsCompanion.insert(id: SingleRowTable.ID, syncVersionNews: Value(null)),
    );
  }
}
