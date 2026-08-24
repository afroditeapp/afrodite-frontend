import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';

class DbProvider implements QueryExecutorProvider {
  DbProvider(DbFile db);

  @override
  QueryExecutor getQueryExecutor() => throw UnsupportedError("Unsupported platform");
}

Future<bool> databaseExists(DbFile db) async {
  throw UnsupportedError("Unsupported platform");
}
