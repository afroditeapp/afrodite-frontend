import 'dart:async';

import 'package:database/database.dart';
import 'package:database_cache/database_cache.dart';
import 'package:database_provider/database_provider.dart';
import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:app/utils/result.dart';
import 'package:rxdart/rxdart.dart';
import 'package:utils/utils.dart';

final _log = Logger("DbReferenceManager");

sealed class DbReferenceManagerCmd<T> {
  final BehaviorSubject<Result<T, Object>?> completed = BehaviorSubject.seeded(null);

  /// Can be called only once
  Future<Result<T, Object>> waitCompletionAndDispose() async {
    try {
      return await completed.whereType<Result<T, Object>>().first;
    } finally {
      await completed.close();
    }
  }
}

class GetAccountDbReference extends DbReferenceManagerCmd<AccountDbReference> {
  final AccountId accountId;
  GetAccountDbReference(this.accountId);

  @override
  String toString() {
    return "GetAccountDbReference";
  }
}

class GetCacheDbReference extends DbReferenceManagerCmd<CacheDbReference> {
  final AccountId accountId;
  GetCacheDbReference(this.accountId);

  @override
  String toString() {
    return "GetCacheDbReference";
  }
}

/// Holds a reference to an open database. Databases are opened once and kept
/// open for the whole app lifetime to workaround database open/close
/// reliability issues (at least on Android).
sealed class DbReference {}

class CommonDbReference extends DbReference {
  final CommonDatabase db;
  CommonDbReference(this.db);
}

class AccountDbReference extends DbReference {
  final AccountDatabase db;
  AccountDbReference(this.db);
}

class CacheDbReference extends DbReference {
  final CacheDatabase db;
  CacheDbReference(this.db);
}

/// Holds references to all databases and opens them only once per database.
class DbReferenceManager extends AppSingleton {
  DbReferenceManager._private();
  static final _instance = DbReferenceManager._private();
  factory DbReferenceManager.getInstance() {
    return _instance;
  }

  bool _initDone = false;

  final PublishSubject<DbReferenceManagerCmd<Object>> _cmds = PublishSubject();
  StreamSubscription<void>? _cmdsSubscription;

  late final CommonDbReference _commonDbReference;
  final Map<String, AccountDbReference> _accountDbReferences = {};
  final Map<String, CacheDbReference> _cacheDbReferences = {};

  CommonDbReference get commonDbReference => _commonDbReference;

  @override
  Future<void> init() async {
    if (_initDone) {
      return;
    }
    _initDone = true;

    _log.info("Init started");

    // DbReferenceManager handles one instance per database file, so disable
    // warning. This should be safe to do as told by
    // in: https://github.com/simolus3/drift/discussions/2596
    driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;

    final dbProvider = DbProvider(CommonDbFile());
    final db = CommonDatabase(dbProvider);
    final ensureOpenResult = await dbProvider.getQueryExecutor().ensureOpen(db);
    _log.info("CommonDatabase ensureOpen result: $ensureOpenResult");
    _commonDbReference = CommonDbReference(db);

    _cmdsSubscription = _listenDbReferenceManagerCmds();

    _log.info("Init completed");
  }

  Future<void> dispose() async {
    await _cmdsSubscription?.cancel();
    await _cmds.close();
  }

  StreamSubscription<void> _listenDbReferenceManagerCmds() {
    return _cmds
        .asyncMap((cmd) async {
          _log.info("cmd: $cmd");
          try {
            switch (cmd) {
              case GetAccountDbReference():
                final existingReference = _accountDbReferences[cmd.accountId.aid];
                if (existingReference != null) {
                  cmd.completed.add(Ok(existingReference));
                  return;
                }
                final dbProvider = DbProvider(AccountDbFile(cmd.accountId.aid));
                final db = AccountDatabase(dbProvider);
                final ensureOpenResult = await dbProvider.getQueryExecutor().ensureOpen(db);
                _log.info("AccountDatabase ensureOpen result: $ensureOpenResult");
                final newReference = AccountDbReference(db);
                _accountDbReferences[cmd.accountId.aid] = newReference;
                cmd.completed.add(Ok(newReference));
                return;
              case GetCacheDbReference():
                final existingReference = _cacheDbReferences[cmd.accountId.aid];
                if (existingReference != null) {
                  cmd.completed.add(Ok(existingReference));
                  return;
                }
                final dbProvider = DbProvider(CacheDbFile(cmd.accountId.aid));
                final db = CacheDatabase(dbProvider);
                final ensureOpenResult = await dbProvider.getQueryExecutor().ensureOpen(db);
                _log.info("CacheDatabase ensureOpen result: $ensureOpenResult");
                final newReference = CacheDbReference(db);
                _cacheDbReferences[cmd.accountId.aid] = newReference;
                cmd.completed.add(Ok(newReference));
                return;
            }
          } catch (e, stackTrace) {
            _log.error("DB reference cmd failed: ${e.runtimeType}");
            _log.fine("DB reference cmd failed: $e", null, stackTrace);
            cmd.completed.add(Err(e));
          }
        })
        .listen(null);
  }

  Future<AccountDbReference> getAccountDbReference(AccountId accountId) async {
    final event = GetAccountDbReference(accountId);
    _cmds.add(event);
    final result = await event.waitCompletionAndDispose();
    return switch (result) {
      Ok(:final v) => v,
      Err(:final e) => throw e,
    };
  }

  Future<CacheDbReference> getCacheDbReference(AccountId accountId) async {
    final event = GetCacheDbReference(accountId);
    _cmds.add(event);
    final result = await event.waitCompletionAndDispose();
    return switch (result) {
      Ok(:final v) => v,
      Err(:final e) => throw e,
    };
  }
}
