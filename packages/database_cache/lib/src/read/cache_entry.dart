import 'package:database_cache/src/database.dart';
import 'package:drift/drift.dart';
import 'package:database_cache/src/schema.dart' as schema;

part 'cache_entry.g.dart';

@DriftAccessor(tables: [schema.CacheEntry])
class DaoReadCacheEntry extends DatabaseAccessor<CacheDatabase> with _$DaoReadCacheEntryMixin {
  DaoReadCacheEntry(super.db);

  /// Get a cache entry by key
  Future<CacheEntryData?> getCacheEntry(String entryKey) async {
    final query = select(cacheEntry)..where((tbl) => tbl.entryKey.equals(entryKey));
    return await query.getSingleOrNull();
  }

  /// Get the count of cache entries
  Future<int> getCacheEntryCount() async {
    final query = selectOnly(cacheEntry)..addColumns([cacheEntry.id.count()]);
    final result = await query.getSingle();
    return result.read(cacheEntry.id.count()) ?? 0;
  }

  /// Get oldest entry IDs by expireAt (for eviction)
  Future<List<int>> getOldestEntryIds(int count) async {
    final query = select(cacheEntry)
      ..orderBy([(tbl) => OrderingTerm.asc(tbl.expireAt)])
      ..limit(count);
    final entries = await query.get();
    return entries.map((e) => e.id).toList();
  }
}
