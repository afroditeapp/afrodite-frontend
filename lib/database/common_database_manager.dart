import 'dart:async';

import 'package:database/database.dart';
import 'package:drift/drift.dart';
import 'package:drift/isolate.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:app/database/account_database_manager.dart';
import 'package:app/database/cache_database_manager.dart';
import 'package:app/database/db_reference_manager.dart';
import 'package:app/data/app_version.dart';
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
  late final CommonDbReference _commonDbReference;

  CommonDatabase get _commonDatabase => _commonDbReference.db;

  @override
  Future<void> init() async {
    if (_initDone) {
      return;
    }
    _initDone = true;

    _log.info("Init started");

    final dbReferenceManager = DbReferenceManager.getInstance();
    await dbReferenceManager.init();
    _commonDbReference = dbReferenceManager.commonDbReference;
    await commonAction(
      (db) => db.app.updateClientVersionInfo(AppVersionManager.getInstance().clientVersion),
    );

    _log.info("Init completed");
  }

  // Common database

  Stream<T> commonStream<T>(Stream<T> Function(CommonDatabaseRead) mapper) async* {
    final stream = mapper(_commonDatabase.read);
    yield* stream
    // try-catch does not work with *yield, so await for would be required, but
    // events seem not to flow properly with that.
    .doOnError((e, stackTrace) {
      if (e is DriftWrappedException) {
        handleDbException<void>(e, stackTrace);
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
    } on CouldNotRollBackException catch (e, stackTrace) {
      return Err(DatabaseException(e, stackTrace: stackTrace));
    } on DriftWrappedException catch (e, stackTrace) {
      return handleDbException(e, stackTrace);
    } on InvalidDataException catch (e, stackTrace) {
      return handleDbException(e, stackTrace);
    } on DriftRemoteException catch (e, stackTrace) {
      return handleDbException(e, stackTrace);
    }
  }

  Future<Result<(), DatabaseError>> commonAction(
    Future<void> Function(CommonDatabaseWrite) action,
  ) async {
    try {
      await action(_commonDatabase.write);
      return const Ok(());
    } on CouldNotRollBackException catch (e, stackTrace) {
      return handleDbException(e, stackTrace);
    } on DriftWrappedException catch (e, stackTrace) {
      return handleDbException(e, stackTrace);
    } on InvalidDataException catch (e, stackTrace) {
      return handleDbException(e, stackTrace);
    } on DriftRemoteException catch (e, stackTrace) {
      return handleDbException(e, stackTrace);
    }
  }

  Future<Result<T, DatabaseError>> commonActionReturn<T>(
    Future<T> Function(CommonDatabaseWrite) action,
  ) async {
    try {
      return Ok(await action(_commonDatabase.write));
    } on CouldNotRollBackException catch (e, stackTrace) {
      return handleDbException(e, stackTrace);
    } on DriftWrappedException catch (e, stackTrace) {
      return handleDbException(e, stackTrace);
    } on InvalidDataException catch (e, stackTrace) {
      return handleDbException(e, stackTrace);
    } on DriftRemoteException catch (e, stackTrace) {
      return handleDbException(e, stackTrace);
    }
  }

  Future<AccountDatabaseManager> getAccountDatabaseManager(AccountId accountId) async {
    _log.info("AccountDatabase init");
    final reference = await DbReferenceManager.getInstance().getAccountDbReference(accountId);
    final manager = AccountDatabaseManager(reference);
    await manager.accountAction((db) => db.loginSession.setAccountIdIfNull(accountId));
    await manager.accountAction(
      (db) => db.app.updateClientVersionInfo(AppVersionManager.getInstance().clientVersion),
    );
    _log.info("AccountDatabase init completed");
    return manager;
  }

  Future<CacheDatabaseManager> getCacheDatabaseManager(AccountId accountId) async {
    _log.info("CacheDatabase init");
    final reference = await DbReferenceManager.getInstance().getCacheDbReference(accountId);
    final manager = CacheDatabaseManager(reference);
    _log.info("CacheDatabase init completed");
    return manager;
  }
}

Stream<T?> oneValueAndWaitForever<T>(T? value) async* {
  final completer = Completer<void>();
  yield value;
  await completer.future;
}

Result<Success, DatabaseException> handleDbException<Success>(Exception e, StackTrace? stackTrace) {
  final dbException = DatabaseException(e, stackTrace: stackTrace);
  dbException.logError(_log);
  return Err(dbException);
}
