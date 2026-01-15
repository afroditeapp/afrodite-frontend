import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';

class DbProvider implements QueryExcecutorProvider {
  DbProvider(DbFile db);

  @override
  QueryExecutor getQueryExcecutor() => throw UnsupportedError("Unsupported platform");
}

Future<bool> databaseExists(DbFile db) async {
  throw UnsupportedError("Unsupported platform");
}

class DatabaseRemoverImpl extends DatabaseRemover {
  @override
  Future<void> recreateDatabasesDir() async {
    throw UnsupportedError("Unsupported platform");
  }

  @override
  Future<void> deleteAllDatabases() async {
    throw UnsupportedError("Unsupported platform");
  }
}
