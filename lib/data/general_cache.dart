import 'dart:async';
import 'dart:io';

import 'package:app/database/common_database_manager.dart';
import 'package:app/utils/result.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

/// A cache manager that stores cache entries on disk.
class GeneralCacheManager {
  final CommonDatabaseManager _dbManager;
  final String _key;
  final Duration _stalePeriod;
  final int _maxNrOfCacheObjects;
  late final Directory _cacheDir;

  GeneralCacheManager({
    required this._key,
    this._stalePeriod = const Duration(days: 90),
    this._maxNrOfCacheObjects = 10000,
  }) : _dbManager = CommonDatabaseManager.getInstance();

  /// Must be called before using this cache manager.
  Future<void> init() async {
    if (kIsWeb) {
      return;
    }
    final appCacheDir = await getApplicationCacheDirectory();
    final dir = Directory(p.join(appCacheDir.path, 'general_cache'));
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    _cacheDir = dir;
  }

  /// Get a cache entry by key. Returns null if not cached, stale, or file missing.
  Future<GeneralCacheFileInfo?> getFileFromCache(String key) async {
    try {
      final entry = await _dbManager
          .commonData((db) => db.generalCache.getCacheEntry(_key, key))
          .ok();

      if (entry == null) {
        return null;
      }

      // Check that file was saved successfully
      if (!entry.savedSuccessfully) {
        await _deleteEntryAndFile(entry.id, key);
        return null;
      }

      // Check if entry is stale
      final now = DateTime.now();
      if (now.difference(entry.lastAccessed).compareTo(_stalePeriod) > 0) {
        await _deleteEntryAndFile(entry.id, key);
        return null;
      }

      // Read file from disk
      final file = File(p.join(_cacheDir.path, entry.id.toString()));
      if (!await file.exists()) {
        await _dbManager.commonAction((db) => db.generalCache.deleteCacheEntry(_key, key));
        return null;
      }

      // Update last accessed time
      await _dbManager.commonAction((db) => db.generalCache.updateLastAccessed(_key, key, now));

      return GeneralCacheFileInfo(
        key: key,
        data: await file.readAsBytes(),
        lastAccessed: entry.lastAccessed,
      );
    } catch (e) {
      // Return null on error
      return null;
    }
  }

  /// Put a file into the cache
  Future<void> putFile(Uint8List fileBytes, {required String key}) async {
    try {
      // Check current cache size and remove oldest entries if needed
      await _enforceMaxCacheSize();

      // Insert DB entry first to get the row id
      final idResult = await _dbManager.commonActionReturn(
        (db) => db.generalCache.upsertCacheEntry(
          cacheKey: _key,
          entryKey: key,
          lastAccessed: DateTime.now(),
        ),
      );
      final id = idResult.ok();
      if (id == null) return;

      // Write file to disk using the DB row id as filename
      final file = File(p.join(_cacheDir.path, id.toString()));
      await file.writeAsBytes(fileBytes);

      // Mark as successfully saved
      await _dbManager.commonAction((db) => db.generalCache.markSavedSuccessfully(id));
    } catch (e) {
      // Ignore errors
    }
  }

  /// Enforce maximum cache size by removing oldest entries
  Future<void> _enforceMaxCacheSize() async {
    try {
      final count =
          await _dbManager.commonData((db) => db.generalCache.getCacheEntryCount(_key)).ok() ?? 0;
      if (count >= _maxNrOfCacheObjects) {
        final toRemove = count - _maxNrOfCacheObjects + 1;
        final ids = await _dbManager
            .commonData((db) => db.generalCache.getOldestEntryIds(_key, toRemove))
            .ok();
        if (ids != null && ids.isNotEmpty) {
          await _deleteFiles(ids);
          await _dbManager.commonAction((db) => db.generalCache.deleteIds(ids));
        }
      }
    } catch (e) {
      // Ignore errors
    }
  }

  Future<void> _deleteEntryAndFile(int id, String key) async {
    await _deleteFile(id);
    await _dbManager.commonAction((db) => db.generalCache.deleteCacheEntry(_key, key));
  }

  Future<void> _deleteFile(int id) async {
    try {
      final file = File(p.join(_cacheDir.path, id.toString()));
      if (await file.exists()) {
        await file.delete();
      }
    } catch (_) {}
  }

  Future<void> _deleteFiles(List<int> ids) async {
    for (final id in ids) {
      await _deleteFile(id);
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
