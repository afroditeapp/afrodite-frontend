
import 'dart:async';

import 'package:drift/drift.dart';
import 'package:drift/isolate.dart';
import 'package:database/database.dart';
import 'package:logging/logging.dart';
import 'package:pihka_frontend/utils/app_error.dart';
import 'package:pihka_frontend/utils/result.dart';
import 'package:rxdart/rxdart.dart';

final log = Logger("AccountDatabaseManager");

class AccountDatabaseManager {
  final AccountDatabase db;
  AccountDatabaseManager(this.db);

  // Access current account database

  Stream<T?> accountStream<T extends Object>(Stream<T?> Function(AccountDatabase) mapper) async* {
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

  Stream<T> accountStreamOrDefault<T extends Object>(Stream<T?> Function(AccountDatabase) mapper, T defaultValue) async* {
    yield* accountStream(mapper)
      .map((event) {
        if (event == null) {
          return defaultValue;
        } else {
          return event;
        }
      });
  }

  Future<Result<T, DatabaseError>> accountStreamSingle<T extends Object>(Stream<T?> Function(AccountDatabase) mapper) async {
    final stream = accountStream(mapper);
    final value = await stream.first;
    if (value == null) {
      return const Err(MissingRequiredValue());
    } else {
      return Ok(value);
    }
  }

  Future<T> accountStreamSingleOrDefault<T extends Object>(Stream<T?> Function(AccountDatabase) mapper, T defaultValue) async {
    final value = await accountStreamSingle(mapper);
    return value.ok() ?? defaultValue;
  }

  Future<Result<T, DatabaseError>> accountData<T extends Object?>(Future<T> Function(AccountDatabase) action) async {
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

  Future<Result<void, DatabaseError>> accountAction(Future<void> Function(AccountDatabase) action) async {
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

  Future<Result<T, DatabaseError>> profileData<T extends Object?>(Future<T> Function(DaoProfiles) action) =>
    accountData((db) => action(db.daoProfiles));

  Future<Result<void, DatabaseError>> profileAction(Future<void> Function(DaoProfiles) action) =>
    accountAction((db) => action(db.daoProfiles));

  Future<Result<T, DatabaseError>> messageData<T extends Object?>(Future<T> Function(DaoMessages) action) =>
    accountData((db) => action(db.daoMessages));

  Future<Result<void, DatabaseError>> messageAction(Future<void> Function(DaoMessages) action) =>
    accountAction((db) => action(db.daoMessages));
}

Result<Success, DatabaseException> _handleDbException<Success>(Exception e) {
  final dbException = DatabaseException(e);
  dbException.logError(log);
  return Err(dbException);
}
