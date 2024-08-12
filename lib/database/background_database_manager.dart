
import 'dart:async';

import 'package:drift/drift.dart';
import 'package:drift/isolate.dart';
import 'package:database/database.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/database/account_background_database_manager.dart';
import 'package:pihka_frontend/database/utils.dart';
import 'package:pihka_frontend/utils.dart';
import 'package:pihka_frontend/utils/app_error.dart';
import 'package:pihka_frontend/utils/result.dart';
import 'package:rxdart/rxdart.dart';

final log = Logger("BackgroundDatabaseManager");

// TODO: It is fine that wal file is not closed properly, so consider enabling
// WAL mode.

// TODO: If Android back button is pressed main isolate closes but database
// isolate does not close. Perhaps this is not an issue as the isolates are
// not used after the main isolate is closed. Android home button does not
// close the main isolate. Did this behavor start after Navigator 2.0
// support was added?

class BackgroundDatabaseManager extends AppSingleton {
  BackgroundDatabaseManager._private();
  static final _instance = BackgroundDatabaseManager._private();
  factory BackgroundDatabaseManager.getInstance() {
    return _instance;
  }

  bool initDone = false;
  late final LazyDatabase commonLazyDatabase;
  late final CommonBackgroundDatabase commonDatabase;
  final accountDatabases = <AccountId, (LazyDatabase, AccountBackgroundDatabase)>{};

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

    commonLazyDatabase = openDbConnection(
      CommonBackgroundDbFile(),
      doSqlchipherInit: true,
      backgroundDb: true,
    );
    commonDatabase = CommonBackgroundDatabase(DbProvider(commonLazyDatabase));
    // Make sure that the database libraries are initialized
    await commonStream((db) => db.watchAccountId()).first;
  }

  // Common database

  Stream<T> commonStream<T>(Stream<T> Function(CommonBackgroundDatabase) mapper) async* {
    final stream = mapper(commonDatabase);
    yield* stream
    // try-catch does not work with *yield, so await for would be required, but
    // events seem not to flow properly with that.
    .doOnError((e, _) {
      if (e is DriftWrappedException) {
        _handleDbException<void>(e);
      }
    });
  }

  Stream<T> commonStreamOrDefault<T extends Object>(Stream<T?> Function(CommonBackgroundDatabase) mapper, T defaultValue) async* {
    final stream = commonStream(mapper);
    yield* stream.map((event) {
      if (event == null) {
        return defaultValue;
      } else {
        return event;
      }
    });
  }

  Future<T> commonStreamSingle<T>(Stream<T> Function(CommonBackgroundDatabase) mapper) async {
    final stream = commonStream(mapper);
    return await stream.first;
  }

  Future<T> commonStreamSingleOrDefault<T extends Object>(Stream<T?> Function(CommonBackgroundDatabase) mapper, T defaultValue) async {
    final first = await commonStreamSingle(mapper);
    return first ?? defaultValue;
  }

  Future<Result<void, DatabaseError>> commonAction(Future<void> Function(CommonBackgroundDatabase) action) async {
    try {
      await action(commonDatabase);
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

  AccountBackgroundDatabaseManager getAccountBackgroundDatabaseManager(AccountId accountId) {
    final db = _getAccountDatabaseUsingAccount(accountId);
    return AccountBackgroundDatabaseManager(db);
  }

  AccountBackgroundDatabase _getAccountDatabaseUsingAccount(AccountId accountId) {
    final db = accountDatabases[accountId];
    if (db != null) {
      return db.$2;
    } else {
      final lazyDb = openDbConnection(
        AccountBackgroundDbFile(accountId.accountId),
        backgroundDb: true,
      );
      final newDb = AccountBackgroundDatabase(DbProvider(lazyDb));
      accountDatabases[accountId] = (lazyDb, newDb);
      return newDb;
    }
  }

  Future<Result<void, AppError>> setAccountId(AccountId accountId) =>
    commonAction((db) => db.updateAccountIdUseOnlyFromDatabaseManager(accountId))
      .andThen((_) =>
        getAccountBackgroundDatabaseManager(accountId)
          .accountAction((db) => db.setAccountIdIfNull(accountId))
      );

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

Result<Success, DatabaseException> _handleDbException<Success>(Exception e) {
  final dbException = DatabaseException(e);
  dbException.logError(log);
  return Err(dbException);
}
