import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';
import 'package:encryption_common/encryption_common.dart';

class DbProvider implements QueryExcecutorProvider {
  DbProvider(DbFile db, {required bool backgroundDb});

  @override
  QueryExecutor getQueryExcecutor() => throw UnsupportedError("Unsupported platform");
}

class DatabaseRemoverImpl extends DatabaseRemover {
  @override
  Future<void> recreateDatabasesDir({required bool backgroundDb}) async {
    throw UnsupportedError("Unsupported platform");
  }

  @override
  Future<void> deleteAllDatabases() async {
    throw UnsupportedError("Unsupported platform");
  }
}
