
import 'dart:async';

import 'package:drift/drift.dart';
import 'package:logging/logging.dart';
import 'package:pihka_frontend/api/error_manager.dart';
import 'package:pihka_frontend/database/account_database.dart';
import 'package:pihka_frontend/database/common_database.dart';
import 'package:pihka_frontend/database/favorite_profiles_database.dart';
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
        handleDatabaseException(e);
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
        handleDatabaseException(e);
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

  Future<T?> accountStreamSingle<T extends Object>(Stream<T?> Function(AccountDatabase) mapper) async {
    final stream = accountStream(mapper);
    return await stream.first;
  }

  Future<T> accountStreamSingleOrDefault<T extends Object>(Stream<T?> Function(AccountDatabase) mapper, T defaultValue) async {
    final value = await accountStreamSingle(mapper);
    return value ?? defaultValue;
  }

  Future<T?> accountData<T extends Object>(Future<T> Function(AccountDatabase) action) async {
    final accountId = await commonStream((db) => db.watchAccountId()).first;
    if (accountId == null) {
      log.warning("No AccountId found, data query skipped");
      return null;
    }

    try {
      final db = _getAccountDatabaseUsingAccount(accountId);
      return await action(db);
    } on CouldNotRollBackException catch (e) {
      handleDatabaseException(e);
    } on DriftWrappedException catch (e) {
      handleDatabaseException(e);
    } on InvalidDataException catch (e) {
      handleDatabaseException(e);
    }

    return null;
  }

  Future<void> accountAction(Future<void> Function(AccountDatabase) action) async {
    final accountId = await commonStream((db) => db.watchAccountId()).first;
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

  Future<T?> profileData<T extends Object>(Future<T> Function(DaoProfiles) action) =>
    accountData((db) => action(db.daoProfiles));

  Future<void> profileAction(Future<void> Function(DaoProfiles) action) =>
    accountAction((db) => action(db.daoProfiles));

  Stream<T?> _accountSwitchMapStream<T extends Object>(Stream<T?> Function(String? accountId) mapper) async* {
    yield* commonStream((db) => db.watchAccountId())
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
