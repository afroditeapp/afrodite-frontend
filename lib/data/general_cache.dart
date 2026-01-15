import 'dart:async';
import 'dart:typed_data';

import 'package:app/database/common_database_manager.dart';
import 'package:drift/drift.dart';

/// A cache manager that stores cache entries in the common database.
class GeneralCacheManager {
  final CommonDatabaseManager _dbManager;
  final String _key;
  final Duration _stalePeriod;
  final int _maxNrOfCacheObjects;

  GeneralCacheManager({
    required String key,
    Duration stalePeriod = const Duration(days: 90),
    int maxNrOfCacheObjects = 10000,
  }) : _key = key,
       _stalePeriod = stalePeriod,
       _maxNrOfCacheObjects = maxNrOfCacheObjects,
       _dbManager = CommonDatabaseManager.getInstance();

  /// Get a cache entry by key
  Future<GeneralCacheFileInfo?> getFileFromCache(String key) async {
    try {
      final entry = await _dbManager.commonDatabase.read.generalCache.getCacheEntry(_key, key);

      if (entry == null) {
        return null;
      }

      // Check if entry is stale
      final now = DateTime.now();
      if (now.difference(entry.lastAccessed).compareTo(_stalePeriod) > 0) {
        // Entry is stale, delete it
        await _dbManager.commonDatabase.write.generalCache.deleteCacheEntry(_key, key);
        return null;
      }

      // Update last accessed time
      await _dbManager.commonDatabase.write.generalCache.updateLastAccessed(_key, key, now);

      return GeneralCacheFileInfo(key: key, data: entry.data, lastAccessed: entry.lastAccessed);
    } catch (e) {
      // Return null on error
      return null;
    }
  }

  /// Put a file into the cache
  Future<void> putFile(String unusedUrl, Uint8List fileBytes, {required String key}) async {
    try {
      // Check current cache size and remove oldest entries if needed
      await _enforceMaxCacheSize();

      // Insert or update the cache entry
      await _dbManager.commonDatabase.write.generalCache.upsertCacheEntry(
        cacheKey: _key,
        entryKey: key,
        data: fileBytes,
        lastAccessed: DateTime.now(),
      );
    } catch (e) {
      // Ignore errors as per the original implementation
    }
  }

  /// Remove a cache entry
  Future<void> removeFile(String key) async {
    try {
      await _dbManager.commonDatabase.write.generalCache.deleteCacheEntry(_key, key);
    } catch (e) {
      // Ignore errors
    }
  }

  /// Clear all cache entries for this cache manager
  Future<void> emptyCache() async {
    try {
      await _dbManager.commonDatabase.write.generalCache.deleteAllForCacheKey(_key);
    } catch (e) {
      // Ignore errors
    }
  }

  /// Enforce maximum cache size by removing oldest entries
  Future<void> _enforceMaxCacheSize() async {
    try {
      final count = await _dbManager.commonDatabase.read.generalCache.getCacheEntryCount(_key);
      if (count >= _maxNrOfCacheObjects) {
        // Remove oldest entries
        final toRemove = count - _maxNrOfCacheObjects + 1;
        await _dbManager.commonDatabase.write.generalCache.deleteOldestEntries(_key, toRemove);
      }
    } catch (e) {
      // Ignore errors
    }
  }
}

/// Info about a cached file
class GeneralCacheFileInfo {
  final String key;
  final Uint8List data;
  final DateTime lastAccessed;

  GeneralCacheFileInfo({required this.key, required this.data, required this.lastAccessed});

  /// For compatibility with flutter_cache_manager API
  GeneralCacheFile get file => GeneralCacheFile(data);
}

/// Represents a cached file
class GeneralCacheFile {
  final Uint8List _data;

  GeneralCacheFile(this._data);

  /// Read file as bytes
  Future<Uint8List> readAsBytes() async {
    return _data;
  }
}
