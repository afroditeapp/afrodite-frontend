import 'package:database_common/src/database.dart';
import 'package:drift/drift.dart';
import 'package:database_common/src/schema.dart' as schema;

part 'general_cache.g.dart';

@DriftAccessor(tables: [schema.GeneralCache])
class DaoWriteGeneralCache extends DatabaseAccessor<CommonDatabase>
    with _$DaoWriteGeneralCacheMixin {
  DaoWriteGeneralCache(super.db);

  /// Insert or update a cache entry
  Future<void> upsertCacheEntry({
    required String cacheKey,
    required String entryKey,
    required Uint8List data,
    required DateTime lastAccessed,
  }) async {
    await into(generalCache).insertOnConflictUpdate(
      GeneralCacheCompanion.insert(
        cacheKey: cacheKey,
        entryKey: entryKey,
        data: data,
        lastAccessed: lastAccessed,
      ),
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

  /// Delete all cache entries for a specific cache key
  Future<void> deleteAllForCacheKey(String cacheKey) async {
    await (delete(generalCache)..where((tbl) => tbl.cacheKey.equals(cacheKey))).go();
  }

  /// Delete oldest entries for a specific cache key
  Future<void> deleteOldestEntries(String cacheKey, int count) async {
    if (count <= 0) return;

    // Get IDs of oldest entries
    final oldestQuery = select(generalCache)
      ..where((tbl) => tbl.cacheKey.equals(cacheKey))
      ..orderBy([(tbl) => OrderingTerm.asc(tbl.lastAccessed)])
      ..limit(count);

    final oldestEntries = await oldestQuery.get();
    final idsToDelete = oldestEntries.map((e) => e.id).toList();

    if (idsToDelete.isNotEmpty) {
      await (delete(generalCache)..where((tbl) => tbl.id.isIn(idsToDelete))).go();
    }
  }
}
