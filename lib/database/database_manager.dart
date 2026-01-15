import 'dart:async';

import 'package:database_provider/database_provider.dart';
import 'package:drift/drift.dart';
import 'package:drift/isolate.dart';
import 'package:database/database.dart';
import 'package:database_utils/database_utils.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:app/database/account_database_manager.dart';
import 'package:app/database/account_background_database_manager.dart';
import 'package:app/utils/app_error.dart';
import 'package:app/utils/result.dart';
import 'package:rxdart/rxdart.dart';
import 'package:utils/utils.dart';

final _log = Logger("DatabaseManager");

class DatabaseManager extends AppSingleton {
  DatabaseManager._private();
  static final _instance = DatabaseManager._private();
  factory DatabaseManager.getInstance() {
    return _instance;
  }

  bool initDone = false;
  late final DbProvider commonDatabaseProvider;
  late final CommonForegroundDatabase commonDatabase;

  @override
  Future<void> init() async {
    if (initDone) {
      return;
    }
    initDone = true;

    _log.info("Init started");

    // DatabaseManager handles one instance per database file, so disable
    // warning. This should be safe to do as told by
    // in: https://github.com/simolus3/drift/discussions/2596
    driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;

    commonDatabaseProvider = DbProvider(CommonDbFile(), backgroundDb: false);
    commonDatabase = CommonForegroundDatabase(commonDatabaseProvider);
    final ensureOpenResult = await commonDatabaseProvider.getQueryExcecutor().ensureOpen(
      commonDatabase,
    );
    _log.info("CommonForegroundDatabase ensureOpen result: $ensureOpenResult");
    // Test query
    await commonStream((db) => db.loginSession.watchAccountId()).first;

    _log.info("Init completed");
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

  Future<AccountDatabaseManager> getAccountDatabaseManager(AccountId accountId) async {
    _log.info("AccountForegroundDatabase init");
    final dbProvider = DbProvider(AccountDbFile(accountId.aid), backgroundDb: false);
    final db = AccountForegroundDatabase(dbProvider);
    final ensureOpenResult = await dbProvider.getQueryExcecutor().ensureOpen(db);
    _log.info("AccountForegroundDatabase ensureOpen result: $ensureOpenResult");
    final manager = AccountDatabaseManager(db);
    await manager.accountAction((db) => db.loginSession.setAccountIdIfNull(accountId));
    _log.info("AccountForegroundDatabase init completed");
    return manager;
  }

  Future<AccountBackgroundDatabaseManager> getAccountBackgroundDatabaseManager(
    AccountId accountId,
  ) async {
    _log.info("AccountBackgroundDatabase init started");
    final dbProvider = DbProvider(AccountBackgroundDbFile(accountId.aid), backgroundDb: true);
    final db = AccountBackgroundDatabase(dbProvider);
    final ensureOpenResult = await dbProvider.getQueryExcecutor().ensureOpen(db);
    _log.info("AccountBackgroundDatabase ensureOpen result: $ensureOpenResult");
    final manager = AccountBackgroundDatabaseManager(accountId, db);
    await manager.accountAction((db) => db.loginSession.setAccountIdIfNull(accountId));
    _log.info("AccountBackgroundDatabase init completed");
    return manager;
  }
}

Stream<T?> oneValueAndWaitForever<T>(T? value) async* {
  final completer = Completer<void>();
  yield value;
  await completer.future;
}

Result<Success, DatabaseException> handleDbException<Success>(Exception e) {
  final dbException = DatabaseException(e);
  dbException.logError(_log);
  return Err(dbException);
}
