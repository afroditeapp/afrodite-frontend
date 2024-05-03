
import 'dart:async';

import 'package:drift/drift.dart';
import 'package:drift/isolate.dart';
import 'package:database/database.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/api/error_manager.dart';
import 'package:pihka_frontend/database/utils.dart';
import 'package:pihka_frontend/utils.dart';
import 'package:pihka_frontend/utils/app_error.dart';
import 'package:pihka_frontend/utils/result.dart';
import 'package:rxdart/rxdart.dart';

final log = Logger("DatabaseManager");

// TODO: It is fine that wal file is not closed properly, so consider enabling
// WAL mode.

// TODO: If Android back button is pressed main isolate closes but database
// isolate does not close. Perhaps this is not an issue as the isolates are
// not used after the main isolate is closed. Android home button does not
// close the main isolate. Did this behavor start after Navigator 2.0
// support was added?

class DatabaseManager extends AppSingleton {
  DatabaseManager._private();
  static final _instance = DatabaseManager._private();
  factory DatabaseManager.getInstance() {
    return _instance;
  }

  bool initDone = false;
  late final LazyDatabase commonLazyDatabase;
  late final CommonDatabase commonDatabase;
  final accountDatabases = <AccountId, (LazyDatabase, AccountDatabase)>{};

  @override
  Future<void> init() async {
    if (initDone) {
      return;
    }
    initDone = true;

    // DatabaseManager handles one instance per database file, so disable
    // warning. This should be safe to do as told by
    // in: https://github.com/simolus3/drift/discussions/2596
    driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;

    commonLazyDatabase = openDbConnection(CommonDbFile(), doSqlchipherInit: true);
    commonDatabase = CommonDatabase(DbProvider(commonLazyDatabase));
    // Make sure that the database libraries are initialized
    await commonStream((db) => db.watchDemoAccountUserId()).first;
  }

  // Common database

  Stream<T> commonStream<T>(Stream<T> Function(CommonDatabase) mapper) async* {
    final stream = mapper(commonDatabase);
    yield* stream
    // try-catch does not work with *yield, so await for would be required, but
    // events seem not to flow properly with that.
    .doOnError((e, _) {
      if (e is DriftWrappedException) {
        handleDbException<void>(e);
      }
    });
  }

  Stream<T> commonStreamOrDefault<T extends Object>(Stream<T?> Function(CommonDatabase) mapper, T defaultValue) async* {
    final stream = commonStream(mapper);
    yield* stream.map((event) {
      if (event == null) {
        return defaultValue;
      } else {
        return event;
      }
    });
  }

  Future<T> commonStreamSingle<T>(Stream<T> Function(CommonDatabase) mapper) async {
    final stream = commonStream(mapper);
    return await stream.first;
  }

  Future<T> commonStreamSingleOrDefault<T extends Object>(Stream<T?> Function(CommonDatabase) mapper, T defaultValue) async {
    final first = await commonStreamSingle(mapper);
    return first ?? defaultValue;
  }

  Future<Result<void, DatabaseError>> commonAction(Future<void> Function(CommonDatabase) action) async {
    try {
      await action(commonDatabase);
      return const Ok(null);
    } on CouldNotRollBackException catch (e) {
      return handleDbException(e);
    } on DriftWrappedException catch (e) {
      return handleDbException(e);
    } on InvalidDataException catch (e) {
      return handleDbException(e);
    } on DriftRemoteException catch (e) {
      return handleDbException(e);
    }
  }

  // Access current account database

  Stream<T?> accountStream<T extends Object>(Stream<T?> Function(AccountDatabase) mapper) async* {
    yield* _accountSwitchMapStream((value) {
      if (value == null) {
        return oneValueAndWaitForever(null);
      } else {
        final accountDatabase = _getAccountDatabaseUsingAccount(value);
        return mapper(accountDatabase);
      }
    })
    // try-catch does not work with *yield, so await for would be required, but
    // events seem not to flow properly with that.
    .doOnError((e, _) {
      if (e is DriftWrappedException) {
        handleDbException<void>(e);
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
    final accountId = await commonStream((db) => db.watchAccountId()).first;
    if (accountId == null) {
      log.warning("No AccountId found, data query skipped");
      return const Err(MissingAccountId());
    }

    try {
      final db = _getAccountDatabaseUsingAccount(accountId);
      return Ok(await action(db));
    } on CouldNotRollBackException catch (e) {
      return Err(DatabaseException(e));
    } on DriftWrappedException catch (e) {
      return handleDbException(e);
    } on InvalidDataException catch (e) {
      return handleDbException(e);
    } on DriftRemoteException catch (e) {
      return handleDbException(e);
    }
  }

  Future<Result<void, DatabaseError>> accountAction(Future<void> Function(AccountDatabase) action) async {
    final accountId = await commonStream((db) => db.watchAccountId()).first;
    if (accountId == null) {
      log.warning("No AccountId found, action skipped");
      return const Err(MissingAccountId());
    }

    try {
      final db = _getAccountDatabaseUsingAccount(accountId);
      await action(db);
      return const Ok(null);
    } on CouldNotRollBackException catch (e) {
      return handleDbException(e);
    } on DriftWrappedException catch (e) {
      return handleDbException(e);
    } on InvalidDataException catch (e) {
      return handleDbException(e);
    } on DriftRemoteException catch (e) {
      return handleDbException(e);
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

  Stream<T?> _accountSwitchMapStream<T extends Object>(Stream<T?> Function(AccountId? accountId) mapper) async* {
    yield* commonStream((db) => db.watchAccountId())
      .switchMap(mapper);
  }

  AccountDatabase _getAccountDatabaseUsingAccount(AccountId accountId) {
    final db = accountDatabases[accountId];
    if (db != null) {
      return db.$2;
    } else {
      final lazyDb = openDbConnection(AccountDbFile(accountId.accountId));
      final newDb = AccountDatabase(DbProvider(lazyDb));
      accountDatabases[accountId] = (lazyDb, newDb);
      return newDb;
    }
  }

  Future<Result<void, AppError>> setAccountId(AccountId accountId) =>
    commonAction((db) => db.updateAccountIdUseOnlyFromDatabaseManager(accountId))
      .andThen((_) => accountAction((db) => db.setAccountIdIfNull(accountId)));

  // TODO: Currently there is no location where this could be handled
  Future<void> dispose() async {
    await commonDatabase.close();
    await commonLazyDatabase.close();
    for (final db in accountDatabases.values) {
      await db.$2.close();
      await db.$1.close();
    }
  }
}

Stream<T?> oneValueAndWaitForever<T>(T? value) async* {
  final completer = Completer<void>();
  yield value;
  await completer.future;
}

Result<Success, DatabaseException> handleDbException<Success>(Exception e) {
  final dbException = DatabaseException(e);
  dbException.logError(log);
  return Err(dbException);
}
