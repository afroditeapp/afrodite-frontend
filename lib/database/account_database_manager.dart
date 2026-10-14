import 'dart:async';

import 'package:drift/drift.dart';
import 'package:drift/isolate.dart';
import 'package:database/database.dart';
import 'package:logging/logging.dart';
import 'package:app/database/db_reference_manager.dart';
import 'package:app/utils/app_error.dart';
import 'package:app/utils/result.dart';
import 'package:rxdart/rxdart.dart';

final _log = Logger("AccountDatabaseManager");

class AccountDatabaseManager {
  final AccountDbReference _dbReference;
  AccountDatabaseManager(AccountDbReference dbReference) : _dbReference = dbReference;

  AccountDatabase get _db => _dbReference.db;

  // Access current account database

  Stream<T?> accountStream<T extends Object>(
    Stream<T?> Function(AccountDatabaseRead) mapper,
  ) async* {
    final accountDatabase = _db;
    yield* mapper(accountDatabase.read)
    // try-catch does not work with *yield, so await for would be required, but
    // events seem not to flow properly with that.
    .doOnError((e, stackTrace) {
      if (e is DriftWrappedException) {
        _handleDbException<void>(e, stackTrace);
      }
    });
  }

  Stream<T> accountStreamOrDefault<T extends Object>(
    Stream<T?> Function(AccountDatabaseRead) mapper,
    T defaultValue,
  ) async* {
    yield* accountStream(mapper).map((event) {
      if (event == null) {
        return defaultValue;
      } else {
        return event;
      }
    });
  }

  Future<Result<T, DatabaseError>> accountStreamSingle<T extends Object>(
    Stream<T?> Function(AccountDatabaseRead) mapper,
  ) async {
    final stream = accountStream(mapper);
    final value = await stream.first;
    if (value == null) {
      return const Err(MissingRequiredValue());
    } else {
      return Ok(value);
    }
  }

  Future<T> accountStreamSingleOrDefault<T extends Object>(
    Stream<T?> Function(AccountDatabaseRead) mapper,
    T defaultValue,
  ) async {
    final value = await accountStreamSingle(mapper);
    return value.ok() ?? defaultValue;
  }

  Future<Result<T, DatabaseError>> accountData<T extends Object?>(
    Future<T> Function(AccountDatabaseRead) action,
  ) async {
    try {
      return Ok(await action(_db.read));
    } on CouldNotRollBackException catch (e, stackTrace) {
      return Err(DatabaseException(e, stackTrace: stackTrace));
    } on DriftWrappedException catch (e, stackTrace) {
      return _handleDbException(e, stackTrace);
    } on InvalidDataException catch (e, stackTrace) {
      return _handleDbException(e, stackTrace);
    } on DriftRemoteException catch (e, stackTrace) {
      return _handleDbException(e, stackTrace);
    }
  }

  Future<Result<T, DatabaseError>> accountDataWrite<T extends Object?>(
    Future<T> Function(AccountDatabaseWrite) action,
  ) async {
    try {
      return Ok(await action(_db.write));
    } on CouldNotRollBackException catch (e, stackTrace) {
      return Err(DatabaseException(e, stackTrace: stackTrace));
    } on DriftWrappedException catch (e, stackTrace) {
      return _handleDbException(e, stackTrace);
    } on InvalidDataException catch (e, stackTrace) {
      return _handleDbException(e, stackTrace);
    } on DriftRemoteException catch (e, stackTrace) {
      return _handleDbException(e, stackTrace);
    }
  }

  Future<Result<(), DatabaseError>> accountAction(
    Future<void> Function(AccountDatabaseWrite) action,
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
