
import 'dart:async';

import 'package:drift/drift.dart';
import 'package:drift/isolate.dart';
import 'package:database/database.dart';
import 'package:logging/logging.dart';
import 'package:app/utils/app_error.dart';
import 'package:app/utils/result.dart';
import 'package:rxdart/rxdart.dart';

final log = Logger("AccountBackgroundDatabaseManager");

class AccountBackgroundDatabaseManager {
  final AccountBackgroundDatabase db;
  AccountBackgroundDatabaseManager(this.db);

  // Access current account database

  Stream<T?> accountStream<T extends Object>(Stream<T?> Function(AccountBackgroundDatabase) mapper) async* {
    final accountDatabase = db;
    yield* mapper(accountDatabase)
    // try-catch does not work with *yield, so await for would be required, but
    // events seem not to flow properly with that.
    .doOnError((e, _) {
      if (e is DriftWrappedException) {
        _handleDbException<void>(e);
      }
    });
  }

  Stream<T> accountStreamOrDefault<T extends Object>(Stream<T?> Function(AccountBackgroundDatabase) mapper, T defaultValue) async* {
    yield* accountStream(mapper)
      .map((event) {
        if (event == null) {
          return defaultValue;
        } else {
          return event;
        }
      });
  }

  Future<Result<T, DatabaseError>> accountStreamSingle<T extends Object>(Stream<T?> Function(AccountBackgroundDatabase) mapper) async {
    final stream = accountStream(mapper);
    final value = await stream.first;
    if (value == null) {
      return const Err(MissingRequiredValue());
    } else {
      return Ok(value);
    }
  }

  Future<T> accountStreamSingleOrDefault<T extends Object>(Stream<T?> Function(AccountBackgroundDatabase) mapper, T defaultValue) async {
    final value = await accountStreamSingle(mapper);
    return value.ok() ?? defaultValue;
  }

  Future<Result<T, DatabaseError>> accountData<T extends Object?>(Future<T> Function(AccountBackgroundDatabase) action) async {
    try {
      return Ok(await action(db));
    } on CouldNotRollBackException catch (e) {
      return Err(DatabaseException(e));
    } on DriftWrappedException catch (e) {
      return _handleDbException(e);
    } on InvalidDataException catch (e) {
      return _handleDbException(e);
    } on DriftRemoteException catch (e) {
      return _handleDbException(e);
    }
  }

  Future<Result<void, DatabaseError>> accountAction(Future<void> Function(AccountBackgroundDatabase) action) async {
    try {
      await action(db);
      return const Ok(null);
    } on CouldNotRollBackException catch (e) {
      return _handleDbException(e);
    } on DriftWrappedException catch (e) {
      return _handleDbException(e);
    } on InvalidDataException catch (e) {
      return _handleDbException(e);
    } on DriftRemoteException catch (e) {
      return _handleDbException(e);
    }
  }

  Future<Result<T, DatabaseError>> profileData<T extends Object?>(Future<T> Function(DaoProfilesBackground) action) =>
    accountData((db) => action(db.daoProfilesBackground));

  Future<Result<void, DatabaseError>> profileAction(Future<void> Function(DaoProfilesBackground) action) =>
    accountAction((db) => action(db.daoProfilesBackground));
}

Result<Success, DatabaseException> _handleDbException<Success>(Exception e) {
  final dbException = DatabaseException(e);
  dbException.logError(log);
  return Err(dbException);
}
