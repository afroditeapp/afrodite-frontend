
import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';

class DbProvider implements QueryExcecutorProvider {
  DbProvider(
    DbFile db,
    {
      required bool doSqlchipherInit,
      required bool backgroundDb,
    }
  );

  @override
  QueryExecutor getQueryExcecutor() =>
    throw UnsupportedError("Unsupported platform");

  Future<void> close() async =>
    throw UnsupportedError("Unsupported platform");
}
