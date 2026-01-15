import 'package:database_common/src/database.dart';
import 'package:drift/drift.dart';
import 'package:database_common/src/schema.dart' as schema;

part 'general_cache.g.dart';

@DriftAccessor(tables: [schema.GeneralCache])
class DaoReadGeneralCache extends DatabaseAccessor<CommonDatabase> with _$DaoReadGeneralCacheMixin {
  DaoReadGeneralCache(super.db);

  /// Get a specific cache entry
  Future<GeneralCacheData?> getCacheEntry(String cacheKey, String entryKey) async {
    final query = select(generalCache)
      ..where((tbl) => tbl.cacheKey.equals(cacheKey) & tbl.entryKey.equals(entryKey));
    return await query.getSingleOrNull();
  }

  /// Get the count of cache entries for a specific cache key
  Future<int> getCacheEntryCount(String cacheKey) async {
    final query = selectOnly(generalCache)
      ..addColumns([generalCache.id.count()])
      ..where(generalCache.cacheKey.equals(cacheKey));
    final result = await query.getSingle();
    return result.read(generalCache.id.count()) ?? 0;
  }
}
