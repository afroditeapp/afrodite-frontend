
import 'package:database/database.dart';
import 'package:drift/backends.dart';

class DbProvider implements QueryExcecutorProvider {
  DbProvider(
    DbFile db,
    {
      required bool doSqlchipherInit,
      required bool backgroundDb,
    }
  );

  @override
  QueryExecutor getQueryExcecutor() {
    throw UnimplementedError();
  }

  Future<void> close() async =>
    throw UnimplementedError();
}
