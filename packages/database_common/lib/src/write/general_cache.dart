import 'package:database_common/src/database.dart';
import 'package:drift/drift.dart';
import 'package:database_common/src/schema.dart' as schema;

part 'general_cache.g.dart';

@DriftAccessor(tables: [schema.GeneralCache])
class DaoWriteGeneralCache extends DatabaseAccessor<CommonDatabase>
    with _$DaoWriteGeneralCacheMixin {
  DaoWriteGeneralCache(super.db);

  /// Insert or update a cache entry, returns the row id
  Future<int> upsertCacheEntry({
    required String cacheKey,
    required String entryKey,
    required DateTime lastAccessed,
  }) async {
    return await into(generalCache).insertOnConflictUpdate(
      GeneralCacheCompanion.insert(
        cacheKey: cacheKey,
        entryKey: entryKey,
        lastAccessed: lastAccessed,
      ),
    );
  }

  /// Mark a cache entry as successfully saved to disk
  Future<void> markSavedSuccessfully(int id) async {
    await (update(generalCache)..where((tbl) => tbl.id.equals(id))).write(
      const GeneralCacheCompanion(savedSuccessfully: Value(true)),
    );
  }

  /// Update last accessed time
  Future<void> updateLastAccessed(String cacheKey, String entryKey, DateTime lastAccessed) async {
    await (update(generalCache)
          ..where((tbl) => tbl.cacheKey.equals(cacheKey) & tbl.entryKey.equals(entryKey)))
        .write(GeneralCacheCompanion(lastAccessed: Value(lastAccessed)));
  }

  /// Delete a specific cache entry
  Future<void> deleteCacheEntry(String cacheKey, String entryKey) async {
    await (delete(
      generalCache,
    )..where((tbl) => tbl.cacheKey.equals(cacheKey) & tbl.entryKey.equals(entryKey))).go();
  }

  /// Delete entries by IDs
  Future<void> deleteIds(List<int> ids) async {
    if (ids.isEmpty) return;
    await (delete(generalCache)..where((tbl) => tbl.id.isIn(ids))).go();
  }
}
