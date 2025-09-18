import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';

class DbProvider implements QueryExcecutorProvider {
  DbProvider(DbFile db, {required bool backgroundDb});

  @override
  QueryExecutor getQueryExcecutor() => throw UnsupportedError("Unsupported platform");
}
