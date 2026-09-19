import 'dart:async';
import 'dart:io';

import 'package:app/database/cache_database_manager.dart';
import 'package:app/utils/result.dart';
import 'package:flutter/foundation.dart';
import 'package:openapi/api.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

/// Extra time beyond staleAt before entry is deleted unconditionally.
const _expireExtraDuration = Duration(days: 90);

/// A cache manager that stores cache entries on disk with ETag support.
class GeneralCacheManager {
  final int _maxNrOfCacheObjects;
  final AccountId accountId;
  final CacheDatabaseManager _cacheDb;
  late final Directory _cacheDir;

  GeneralCacheManager(this.accountId, this._cacheDb, {this._maxNrOfCacheObjects = 10000});

  /// Must be called before using this cache manager.
  Future<void> init() async {
    if (kIsWeb) {
      return;
    }
    final appCacheDir = await getApplicationCacheDirectory();
    final dir = Directory(p.join(appCacheDir.path, 'general_cache', accountId.aid));
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    _cacheDir = dir;
  }

  /// Get a cache entry by key. Returns null if not cached, expired, or file missing.
  Future<GeneralCacheFileInfo?> getFileFromCache(String key) async {
    try {
      final entry = await _cacheDb.cacheData((db) => db.cacheEntry.getCacheEntry(key)).ok();

      if (entry == null) {
        return null;
      }

      // Check that file was saved successfully
      if (!entry.savedSuccessfully) {
        await _deleteEntryAndFile(entry.id, key);
        return null;
      }

      final now = DateTime.now();

      // If entry is past expireAt, delete it unconditionally
      if (now.isAfter(entry.expireAt)) {
        await _deleteEntryAndFile(entry.id, key);
        return null;
      }

      // Read file from disk
      final file = File(p.join(_cacheDir.path, entry.id.toString()));
      if (!await file.exists()) {
        await _cacheDb.cacheAction((db) => db.cacheEntry.deleteCacheEntry(key));
        return null;
      }

      return GeneralCacheFileInfo(
        key: key,
        data: await file.readAsBytes(),
        etag: entry.etag,
        staleAt: entry.staleAt,
        expireAt: entry.expireAt,
      );
    } catch (e) {
      return null;
    }
  }

  /// Put a file into the cache.
  /// [etag] is the server ETag for conditional revalidation.
  /// [cacheControlMaxAge] max-age from Cache-Control header, or null for default.
  Future<void> putFile(
    Uint8List fileBytes, {
    required String key,
    required String etag,
    required Duration cacheControlMaxAge,
  }) async {
    try {
      await _enforceMaxCacheSize();

      final now = DateTime.now();
      final staleAt = now.add(cacheControlMaxAge);
      final expireAt = staleAt.add(_expireExtraDuration);

      final idResult = await _cacheDb.cacheDataWrite(
        (db) => db.cacheEntry.upsertCacheEntry(
          entryKey: key,
          staleAt: staleAt,
          expireAt: expireAt,
          etag: etag,
        ),
      );
      final id = idResult.ok();
      if (id == null) return;

      final file = File(p.join(_cacheDir.path, id.toString()));
      await file.writeAsBytes(fileBytes);

      await _cacheDb.cacheAction((db) => db.cacheEntry.markSavedSuccessfully(id));
    } catch (e) {
      // Ignore errors
    }
  }

  /// Renew timestamps after a 304 (conditional revalidation) response.
  /// [cacheControlMaxAge] max-age from Cache-Control header, or null for default.
  Future<void> renewTimestamps(String key, {required Duration cacheControlMaxAge}) async {
    try {
      final now = DateTime.now();
      final staleAt = now.add(cacheControlMaxAge);
      final expireAt = staleAt.add(_expireExtraDuration);

      await _cacheDb.cacheAction(
        (db) => db.cacheEntry.updateTimestamps(entryKey: key, staleAt: staleAt, expireAt: expireAt),
      );
    } catch (e) {
      // Ignore errors
    }
  }

  /// Enforce maximum cache size by removing oldest entries
  Future<void> _enforceMaxCacheSize() async {
    try {
      final count = await _cacheDb.cacheData((db) => db.cacheEntry.getCacheEntryCount()).ok() ?? 0;
      if (count >= _maxNrOfCacheObjects) {
        final toRemove = count - _maxNrOfCacheObjects + 1;
        final ids = await _cacheDb
            .cacheData((db) => db.cacheEntry.getOldestEntryIds(toRemove))
            .ok();
        if (ids != null && ids.isNotEmpty) {
          await _deleteFiles(ids);
          await _cacheDb.cacheAction((db) => db.cacheEntry.deleteIds(ids));
        }
      }
    } catch (e) {
      // Ignore errors
    }
  }

  Future<void> _deleteEntryAndFile(int id, String key) async {
    await _deleteFile(id);
    await _cacheDb.cacheAction((db) => db.cacheEntry.deleteCacheEntry(key));
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
  final String? etag;
  final DateTime staleAt;
  final DateTime expireAt;

  GeneralCacheFileInfo({
    required this.key,
    required this.data,
    this.etag,
    required this.staleAt,
    required this.expireAt,
  });

  /// Whether the cached data is still fresh (no revalidation needed).
  bool get isFresh => DateTime.now().isBefore(staleAt);

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
