import 'dart:async';

import 'package:database_provider/database_provider.dart';
import 'package:drift/drift.dart';
import 'package:drift/isolate.dart';
import 'package:database/database.dart';
import 'package:database_utils/database_utils.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:app/database/account_database_manager.dart';
import 'package:app/utils/app_error.dart';
import 'package:app/utils/result.dart';
import 'package:rxdart/rxdart.dart';
import 'package:utils/utils.dart';

final _log = Logger("CommonDatabaseManager");

class CommonDatabaseManager extends AppSingleton {
  CommonDatabaseManager._private();
  static final _instance = CommonDatabaseManager._private();
  factory CommonDatabaseManager.getInstance() {
    return _instance;
  }

  bool _initDone = false;
  late final DbProvider _commonDatabaseProvider;
  late final CommonDatabase _commonDatabase;

  @override
  Future<void> init() async {
    if (_initDone) {
      return;
    }
    _initDone = true;

    _log.info("Init started");

    // CommonDatabaseManager handles one instance per database file, so disable
    // warning. This should be safe to do as told by
    // in: https://github.com/simolus3/drift/discussions/2596
    driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;

    _commonDatabaseProvider = DbProvider(CommonDbFile());
    _commonDatabase = CommonDatabase(_commonDatabaseProvider);
    final ensureOpenResult = await _commonDatabaseProvider.getQueryExcecutor().ensureOpen(
      _commonDatabase,
    );
    _log.info("CommonDatabase ensureOpen result: $ensureOpenResult");
    // Test query
    await commonStream((db) => db.loginSession.watchAccountId()).first;

    _log.info("Init completed");
  }

  // Common database

  Stream<T> commonStream<T>(Stream<T> Function(CommonDatabaseRead) mapper) async* {
    final stream = mapper(_commonDatabase.read);
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
    Stream<T?> Function(CommonDatabaseRead) mapper,
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

  Future<T> commonStreamSingle<T>(Stream<T> Function(CommonDatabaseRead) mapper) async {
    final stream = commonStream(mapper);
    return await stream.first;
  }

  Future<T> commonStreamSingleOrDefault<T extends Object>(
    Stream<T?> Function(CommonDatabaseRead) mapper,
    T defaultValue,
  ) async {
    final first = await commonStreamSingle(mapper);
    return first ?? defaultValue;
  }

  Future<Result<T, DatabaseError>> commonData<T extends Object?>(
    Future<T> Function(CommonDatabaseRead) action,
  ) async {
    try {
      return Ok(await action(_commonDatabase.read));
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

  Future<Result<(), DatabaseError>> commonAction(
    Future<void> Function(CommonDatabaseWrite) action,
  ) async {
    try {
      await action(_commonDatabase.write);
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
    _log.info("AccountDatabase init");
    final dbProvider = DbProvider(AccountDbFile(accountId.aid));
    final db = AccountDatabase(dbProvider);
    final ensureOpenResult = await dbProvider.getQueryExcecutor().ensureOpen(db);
    _log.info("AccountDatabase ensureOpen result: $ensureOpenResult");
    final manager = AccountDatabaseManager(db);
    await manager.accountAction((db) => db.loginSession.setAccountIdIfNull(accountId));
    _log.info("AccountDatabase init completed");
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
