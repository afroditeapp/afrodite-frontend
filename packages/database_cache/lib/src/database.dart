import 'package:database_cache/src/read/cache_entry.dart';
import 'package:database_cache/src/read/content_quality.dart';
import 'package:database_cache/src/write/cache_entry.dart';
import 'package:database_cache/src/write/content_quality.dart';
import 'package:database_converter/database_converter.dart';
import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';
import 'package:utils/utils.dart';
import 'schema.dart' as schema;

part 'database.g.dart';

/// Cache database for storing image cache metadata in system cache directory.
@DriftDatabase(
  tables: [schema.CacheEntry, schema.ContentQuality, schema.ContentQualityCleanupState],
  daos: [DaoReadCacheEntry, DaoReadContentQuality, DaoWriteCacheEntry, DaoWriteContentQuality],
)
class CacheDatabase extends _$CacheDatabase {
  CacheDatabase(QueryExcecutorProvider dbProvider) : super(dbProvider.getQueryExcecutor());

  CacheDatabaseRead get read => CacheDatabaseRead(this);
  CacheDatabaseWrite get write => CacheDatabaseWrite(this);

  @override
  int get schemaVersion => 1;
}

class CacheDatabaseRead {
  final CacheDatabase db;
  CacheDatabaseRead(this.db);

  DaoReadCacheEntry get cacheEntry => db.daoReadCacheEntry;
  DaoReadContentQuality get contentQuality => db.daoReadContentQuality;
}

class CacheDatabaseWrite {
  final CacheDatabase db;
  CacheDatabaseWrite(this.db);

  DaoWriteCacheEntry get cacheEntry => db.daoWriteCacheEntry;
  DaoWriteContentQuality get contentQuality => db.daoWriteContentQuality;
}
