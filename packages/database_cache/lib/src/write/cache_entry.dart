import 'package:database_cache/src/database.dart';
import 'package:drift/drift.dart';
import 'package:database_cache/src/schema.dart' as schema;

part 'cache_entry.g.dart';

@DriftAccessor(tables: [schema.CacheEntry])
class DaoWriteCacheEntry extends DatabaseAccessor<CacheDatabase> with _$DaoWriteCacheEntryMixin {
  DaoWriteCacheEntry(super.db);

  /// Insert or update a cache entry, returns the row id
  Future<int> upsertCacheEntry({required String entryKey, required DateTime lastAccessed}) async {
    return await into(cacheEntry).insertOnConflictUpdate(
      CacheEntryCompanion.insert(entryKey: entryKey, lastAccessed: lastAccessed),
    );
  }

  /// Mark a cache entry as successfully saved to disk
  Future<void> markSavedSuccessfully(int id) async {
    await (update(cacheEntry)..where((tbl) => tbl.id.equals(id))).write(
      const CacheEntryCompanion(savedSuccessfully: Value(true)),
    );
  }

  /// Update last accessed time
  Future<void> updateLastAccessed(String entryKey, DateTime lastAccessed) async {
    await (update(cacheEntry)..where((tbl) => tbl.entryKey.equals(entryKey))).write(
      CacheEntryCompanion(lastAccessed: Value(lastAccessed)),
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
