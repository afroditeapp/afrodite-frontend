import 'dart:async';

import 'package:database_cache/database_cache.dart';
import 'package:database_provider/database_provider.dart';
import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';
import 'package:drift/isolate.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:app/utils/app_error.dart';
import 'package:app/utils/result.dart';

final _log = Logger("CacheDatabaseManager");

class CacheDatabaseManager {
  CacheDatabaseManager._private();
  static final _instance = CacheDatabaseManager._private();
  factory CacheDatabaseManager.getInstance() {
    return _instance;
  }

  late final CacheDatabase _db;
  final DbProvider _dbProvider = DbProvider(CacheDbFile());

  Future<void> init() async {
    if (kIsWeb) {
      // Web browsers handle image caching automatically
      return;
    }
    _db = CacheDatabase(_dbProvider);
    final result = await _dbProvider.getQueryExcecutor().ensureOpen(_db);
    _log.info("CacheDatabase ensureOpen result: $result");

    final cleanedCount = await cacheActionReturn(
      (db) => db.contentQuality.cleanupStaleContentQualityIfNeeded(),
    ).ok();
    if (cleanedCount == null) {
      _log.warning("Content quality cleanup failed on app resume");
    } else if (cleanedCount > 0) {
      _log.fine("Content quality cleanup removed $cleanedCount quality info entries on app resume");
    }
  }

  Future<Result<T, DatabaseError>> cacheData<T extends Object?>(
    Future<T> Function(CacheDatabaseRead) action,
  ) async {
    try {
      return Ok(await action(_db.read));
    } on CouldNotRollBackException catch (e, stackTrace) {
      return Err(DatabaseException(e, stackTrace: stackTrace));
    } on DriftWrappedException catch (e, stackTrace) {
      return Err(DatabaseException(e, stackTrace: stackTrace));
    } on InvalidDataException catch (e, stackTrace) {
      return Err(DatabaseException(e, stackTrace: stackTrace));
    } on DriftRemoteException catch (e, stackTrace) {
      return Err(DatabaseException(e, stackTrace: stackTrace));
    }
  }

  Future<Result<(), DatabaseError>> cacheAction(
    Future<void> Function(CacheDatabaseWrite) action,
  ) async {
    try {
      await action(_db.write);
      return const Ok(());
    } on CouldNotRollBackException catch (e, stackTrace) {
      return Err(DatabaseException(e, stackTrace: stackTrace));
    } on DriftWrappedException catch (e, stackTrace) {
      return Err(DatabaseException(e, stackTrace: stackTrace));
    } on InvalidDataException catch (e, stackTrace) {
      return Err(DatabaseException(e, stackTrace: stackTrace));
    } on DriftRemoteException catch (e, stackTrace) {
      return Err(DatabaseException(e, stackTrace: stackTrace));
    }
  }

  Future<Result<T, DatabaseError>> cacheActionReturn<T>(
    Future<T> Function(CacheDatabaseWrite) action,
  ) async {
    try {
      return Ok(await action(_db.write));
    } on CouldNotRollBackException catch (e, stackTrace) {
      return Err(DatabaseException(e, stackTrace: stackTrace));
    } on DriftWrappedException catch (e, stackTrace) {
      return Err(DatabaseException(e, stackTrace: stackTrace));
    } on InvalidDataException catch (e, stackTrace) {
      return Err(DatabaseException(e, stackTrace: stackTrace));
    } on DriftRemoteException catch (e, stackTrace) {
      return Err(DatabaseException(e, stackTrace: stackTrace));
    }
  }
}
