import 'package:database_cache/src/read/cache_entry.dart';
import 'package:database_cache/src/write/cache_entry.dart';
import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';

import 'schema.dart' as schema;

part 'database.g.dart';

/// Cache database for storing image cache metadata in system cache directory.
@DriftDatabase(tables: [schema.CacheEntry], daos: [DaoReadCacheEntry, DaoWriteCacheEntry])
class CacheDatabase extends _$CacheDatabase {
  CacheDatabase(QueryExecutorProvider dbProvider) : super(dbProvider.getQueryExecutor());

  CacheDatabaseRead get read => CacheDatabaseRead(this);
  CacheDatabaseWrite get write => CacheDatabaseWrite(this);

  @override
  int get schemaVersion => 1;
}

class CacheDatabaseRead {
  final CacheDatabase db;
  CacheDatabaseRead(this.db);

  DaoReadCacheEntry get cacheEntry => db.daoReadCacheEntry;
}

class CacheDatabaseWrite {
  final CacheDatabase db;
  CacheDatabaseWrite(this.db);

  DaoWriteCacheEntry get cacheEntry => db.daoWriteCacheEntry;
}
