
import 'dart:async';

import 'package:drift/drift.dart';
import 'package:logging/logging.dart';
import 'package:pihka_frontend/api/error_manager.dart';
import 'package:pihka_frontend/database/account_database.dart';
import 'package:pihka_frontend/database/common_database.dart';
import 'package:pihka_frontend/database/utils.dart';
import 'package:pihka_frontend/utils.dart';
import 'package:rxdart/rxdart.dart';

final log = Logger("DatabaseManager");

class DatabaseManager extends AppSingleton {
  DatabaseManager._private();
  static final _instance = DatabaseManager._private();
  factory DatabaseManager.getInstance() {
    return _instance;
  }

  bool initDone = false;
  late final CommonDatabase commonDatabase;
  /// Key is AccountId
  final accountDatabases = <String, AccountDatabase>{};

  @override
  Future<void> init() async {
    if (initDone) {
      return;
    }
    initDone = true;

    commonDatabase = CommonDatabase(doInit: true);
    // Make sure that the database libraries are initialized
    await commonDataStream((db) => db.watchDemoAccountUserId()).first;
  }

  // Common database

  Stream<T> commonDataStream<T>(Stream<T> Function(CommonDatabase) mapper) async* {
    final stream = mapper(commonDatabase);
    yield* stream
    // try-catch does not work with *yield, so await for would be required, but
    // events seem not to flow properly with that.
    .doOnError((e, _) {
      if (e is DriftWrappedException) {
        handleDatabaseException(e);
      }
    });
  }

  Stream<T> commonDataStreamOrDefault<T extends Object>(Stream<T?> Function(CommonDatabase) mapper, T defaultValue) async* {
    final stream = commonDataStream(mapper);
    yield* stream.map((event) {
      if (event == null) {
        return defaultValue;
      } else {
        return event;
      }
    });
  }

  Future<T> commonData<T>(Stream<T> Function(CommonDatabase) mapper) async {
    final stream = commonDataStream(mapper);
    return await stream.first;
  }

  Future<T> commonDataOrDefault<T extends Object>(Stream<T?> Function(CommonDatabase) mapper, T defaultValue) async {
    final first = await commonData(mapper);
    return first ?? defaultValue;
  }

  Future<void> commonAction(Future<void> Function(CommonDatabase) action) async {
    try {
      await action(commonDatabase);
    } on CouldNotRollBackException catch (e) {
      handleDatabaseException(e);
    } on DriftWrappedException catch (e) {
      handleDatabaseException(e);
    } on InvalidDataException catch (e) {
      handleDatabaseException(e);
    }
  }

  // Access current account database

  Stream<T?> accountDataStream<T extends Object>(Stream<T?> Function(AccountDatabase) mapper) async* {
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
        handleDatabaseException(e);
      }
    });
  }

  Stream<T> accountDataStreamOrDefault<T extends Object>(Stream<T?> Function(AccountDatabase) mapper, T defaultValue) async* {
    yield* accountDataStream(mapper)
      .map((event) {
        if (event == null) {
          return defaultValue;
        } else {
          return event;
        }
      });
  }

  Future<T?> accountData<T extends Object>(Stream<T?> Function(AccountDatabase) mapper) async {
    final stream = accountDataStream(mapper);
    return await stream.first;
  }

  Future<T> accountDataOrDefault<T extends Object>(Stream<T?> Function(AccountDatabase) mapper, T defaultValue) async {
    final value = await accountData(mapper);
    return value ?? defaultValue;
  }

  Future<void> accountAction(Future<void> Function(AccountDatabase) action) async {
    final accountId = await commonDataStream((db) => db.watchAccountId()).first;
    if (accountId == null) {
      log.warning("No AccountId found, action skipped");
      return;
    }

    try {
      final db = _getAccountDatabaseUsingAccount(accountId);
      await action(db);
    } on CouldNotRollBackException catch (e) {
      handleDatabaseException(e);
    } on DriftWrappedException catch (e) {
      handleDatabaseException(e);
    } on InvalidDataException catch (e) {
      handleDatabaseException(e);
    }
  }

  Stream<T?> _accountSwitchMapStream<T extends Object>(Stream<T?> Function(String? accountId) mapper) async* {
    yield* commonDataStream((db) => db.watchAccountId())
      .switchMap(mapper);
  }

  AccountDatabase _getAccountDatabaseUsingAccount(String accountId) {
    final db = accountDatabases[accountId];
    if (db != null) {
      return db;
    } else {
      final newDb = AccountDatabase(AccountDbFile(accountId));
      accountDatabases[accountId] = newDb;
      return newDb;
    }
  }
}

Stream<T?> oneValueAndWaitForever<T>(T? value) async* {
  final completer = Completer<void>();
  yield value;
  await completer.future;
}

void handleDatabaseException(Exception e) {
  // TODO(prod): remove exception printing for production?
  log.error(e);
  // TODO(prod): remove stack trace for production?
  log.error(StackTrace.current);
  ErrorManager.getInstance().send(DatabaseError());
}
