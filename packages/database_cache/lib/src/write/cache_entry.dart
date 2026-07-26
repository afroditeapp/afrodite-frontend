import 'package:database_cache/src/database.dart';
import 'package:drift/drift.dart';
import 'package:database_cache/src/schema.dart' as schema;

part 'cache_entry.g.dart';

@DriftAccessor(tables: [schema.CacheEntry])
class DaoWriteCacheEntry extends DatabaseAccessor<CacheDatabase> with _$DaoWriteCacheEntryMixin {
  DaoWriteCacheEntry(super.db);

  /// Insert or update a cache entry, returns the row id
  Future<int> upsertCacheEntry({
    required String entryKey,
    required DateTime staleAt,
    required DateTime expireAt,
    String? etag,
  }) async {
    return await into(cacheEntry).insertOnConflictUpdate(
      CacheEntryCompanion.insert(
        entryKey: entryKey,
        staleAt: staleAt,
        expireAt: expireAt,
        etag: Value(etag),
      ),
    );
  }

  /// Mark a cache entry as successfully saved to disk
  Future<void> markSavedSuccessfully(int id) async {
    await (update(cacheEntry)..where((tbl) => tbl.id.equals(id))).write(
      const CacheEntryCompanion(savedSuccessfully: Value(true)),
    );
  }

  /// Update timestamps after 304 (conditional revalidation)
  Future<void> updateTimestamps({
    required String entryKey,
    required DateTime staleAt,
    required DateTime expireAt,
  }) async {
    await (update(cacheEntry)..where((tbl) => tbl.entryKey.equals(entryKey))).write(
      CacheEntryCompanion(staleAt: Value(staleAt), expireAt: Value(expireAt)),
    );
  }

  /// Delete a specific cache entry
  Future<void> deleteCacheEntry(String entryKey) async {
    await (delete(cacheEntry)..where((tbl) => tbl.entryKey.equals(entryKey))).go();
  }

  /// Delete entries by IDs
  Future<void> deleteIds(List<int> ids) async {
    if (ids.isEmpty) return;
    await (delete(cacheEntry)..where((tbl) => tbl.id.isIn(ids))).go();
  }
}
