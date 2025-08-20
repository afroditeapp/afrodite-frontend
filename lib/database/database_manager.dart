import 'dart:async';

import 'package:database_provider/database_provider.dart';
import 'package:drift/drift.dart';
import 'package:drift/isolate.dart';
import 'package:database/database.dart';
import 'package:database_utils/database_utils.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:app/database/account_database_manager.dart';
import 'package:app/database/background_database_manager.dart';
import 'package:app/utils/app_error.dart';
import 'package:app/utils/result.dart';
import 'package:rxdart/rxdart.dart';
import 'package:utils/utils.dart';

final log = Logger("DatabaseManager");

class DatabaseManager extends AppSingleton {
  DatabaseManager._private();
  static final _instance = DatabaseManager._private();
  factory DatabaseManager.getInstance() {
    return _instance;
  }

  final backgroundDbManager = BackgroundDatabaseManager.getInstance();

  bool initDone = false;
  late final DbProvider commonLazyDatabase;
  late final CommonForegroundDatabase commonDatabase;
  final accountDatabases = <AccountId, (DbProvider, AccountForegroundDatabase)>{};

  @override
  Future<void> init() async {
    if (initDone) {
      return;
    }
    initDone = true;

    // Background DB init has doSqlchipherInit: true and other init
    // related things.
    await backgroundDbManager.init();

    commonLazyDatabase = DbProvider(CommonDbFile(), doSqlchipherInit: false, backgroundDb: false);
    commonDatabase = CommonForegroundDatabase(commonLazyDatabase);
  }

  // Common database

  Stream<T> commonStream<T>(Stream<T> Function(CommonForegroundDatabaseRead) mapper) async* {
    final stream = mapper(commonDatabase.read);
    yield* stream
    // try-catch does not work with *yield, so await for would be required, but
    // events seem not to flow properly with that.
    .doOnError((e, _) {
      if (e is DriftWrappedException) {
        handleDbException<void>(e);
      }
    });
  }

  Stream<T> commonStreamOrDefault<T extends Object>(
    Stream<T?> Function(CommonForegroundDatabaseRead) mapper,
    T defaultValue,
  ) async* {
    final stream = commonStream(mapper);
    yield* stream.map((event) {
      if (event == null) {
        return defaultValue;
      } else {
        return event;
      }
    });
  }

  Future<T> commonStreamSingle<T>(Stream<T> Function(CommonForegroundDatabaseRead) mapper) async {
    final stream = commonStream(mapper);
    return await stream.first;
  }

  Future<T> commonStreamSingleOrDefault<T extends Object>(
    Stream<T?> Function(CommonForegroundDatabaseRead) mapper,
    T defaultValue,
  ) async {
    final first = await commonStreamSingle(mapper);
    return first ?? defaultValue;
  }

  Future<Result<(), DatabaseError>> commonAction(
    Future<void> Function(CommonForegroundDatabaseWrite) action,
  ) async {
    try {
      await action(commonDatabase.write);
      return const Ok(());
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

  AccountDatabaseManager getAccountDatabaseManager(AccountId accountId) {
    final db = _getAccountDatabaseUsingAccount(accountId);
    return AccountDatabaseManager(db);
  }

  AccountForegroundDatabase _getAccountDatabaseUsingAccount(AccountId accountId) {
    final db = accountDatabases[accountId];
    if (db != null) {
      return db.$2;
    } else {
      final dbProvider = DbProvider(
        AccountDbFile(accountId.aid),
        doSqlchipherInit: false,
        backgroundDb: false,
      );
      final newDb = AccountForegroundDatabase(dbProvider);
      accountDatabases[accountId] = (dbProvider, newDb);
      return newDb;
    }
  }

  Future<Result<(), AppError>> setAccountId(AccountId accountId) => backgroundDbManager
      .setAccountId(accountId)
      .andThen(
        (_) => getAccountDatabaseManager(
          accountId,
        ).accountAction((db) => db.loginSession.setAccountIdIfNull(accountId)),
      );

  // NOTE: This is not used as there is no good location for calling this
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
