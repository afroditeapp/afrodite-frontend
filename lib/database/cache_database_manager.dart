import 'dart:async';

import 'package:database_cache/database_cache.dart';
import 'package:drift/drift.dart';
import 'package:drift/isolate.dart';
import 'package:logging/logging.dart';
import 'package:app/database/db_reference_manager.dart';
import 'package:app/utils/app_error.dart';
import 'package:app/utils/result.dart';

final _log = Logger("CacheDatabaseManager");

class CacheDatabaseManager {
  final CacheDbReference _dbReference;
  CacheDatabaseManager(CacheDbReference dbReference) : _dbReference = dbReference;

  CacheDatabase get _db => _dbReference.db;

  Future<Result<T, DatabaseError>> cacheData<T extends Object?>(
    Future<T> Function(CacheDatabaseRead) action,
  ) async {
    try {
      return Ok(await action(_db.read));
    } on CouldNotRollBackException catch (e, stackTrace) {
      return _handleDbException(e, stackTrace);
    } on DriftWrappedException catch (e, stackTrace) {
      return _handleDbException(e, stackTrace);
    } on InvalidDataException catch (e, stackTrace) {
      return _handleDbException(e, stackTrace);
    } on DriftRemoteException catch (e, stackTrace) {
      return _handleDbException(e, stackTrace);
    }
  }

  Future<Result<(), DatabaseError>> cacheAction(
    Future<void> Function(CacheDatabaseWrite) action,
  ) async {
    try {
      await action(_db.write);
      return const Ok(());
    } on CouldNotRollBackException catch (e, stackTrace) {
      return _handleDbException(e, stackTrace);
    } on DriftWrappedException catch (e, stackTrace) {
      return _handleDbException(e, stackTrace);
    } on InvalidDataException catch (e, stackTrace) {
      return _handleDbException(e, stackTrace);
    } on DriftRemoteException catch (e, stackTrace) {
      return _handleDbException(e, stackTrace);
    }
  }

  Future<Result<T, DatabaseError>> cacheDataWrite<T extends Object?>(
    Future<T> Function(CacheDatabaseWrite) action,
  ) async {
    try {
      return Ok(await action(_db.write));
    } on CouldNotRollBackException catch (e, stackTrace) {
      return _handleDbException(e, stackTrace);
    } on DriftWrappedException catch (e, stackTrace) {
      return _handleDbException(e, stackTrace);
    } on InvalidDataException catch (e, stackTrace) {
      return _handleDbException(e, stackTrace);
    } on DriftRemoteException catch (e, stackTrace) {
      return _handleDbException(e, stackTrace);
    }
  }

  /// Databases are kept open for the whole app lifetime to workaround
  /// database open/close reliability bugs. Close is a no-op.
  Future<void> close() async {
    // empty
  }
}

Result<Success, DatabaseException> _handleDbException<Success>(
  Exception e,
  StackTrace? stackTrace,
) {
  final dbException = DatabaseException(e, stackTrace: stackTrace);
  dbException.logError(_log);
  return Err(dbException);
}
