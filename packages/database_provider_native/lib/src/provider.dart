import 'dart:io';

import 'package:database_provider_native/src/db_dir.dart';
import 'package:database_provider_native/src/tmp_dir.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:encryption/encryption.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:sqlite3/open.dart';
import 'package:sqlcipher_flutter_libs/sqlcipher_flutter_libs.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:database_utils/database_utils.dart';

final _log = Logger("DbProviderNative");

class DbProvider implements QueryExcecutorProvider {
  final DbFile _db;
  final bool _doSqlchipherInit;
  final bool _backgroundDb;
  DbProvider(this._db, {required bool doSqlchipherInit, required bool backgroundDb})
    : _backgroundDb = backgroundDb,
      _doSqlchipherInit = doSqlchipherInit;

  LazyDatabase? _dbConnection;

  @override
  QueryExecutor getQueryExcecutor() {
    _dbConnection ??= openDbConnection(
      _db,
      doSqlchipherInit: _doSqlchipherInit,
      backgroundDb: _backgroundDb,
    );
    return _dbConnection!;
  }
}

Future<File> dbFileToFile(DbFile dbFile) async {
  switch (dbFile) {
    case CommonDbFile():
      return File(await DbDirUtils.commonDbPath());
    case CommonBackgroundDbFile():
      return File(await DbDirUtils.commonBackgroundDbPath());
    case AccountDbFile():
      return File(await DbDirUtils.accountDbPath(dbFile.accountId));
    case AccountBackgroundDbFile():
      return File(await DbDirUtils.accountBackgroundDbPath(dbFile.accountId));
  }
}

LazyDatabase openDbConnection(
  DbFile db, {
  bool doSqlchipherInit = false,
  bool backgroundDb = false,
}) {
  return LazyDatabase(() async {
    final encryptionKey = await SecureStorageManager.getInstance()
        .getDbEncryptionKeyOrCreateNewKeyAndRecreateDatabasesDir(
          backgroundDb: backgroundDb,
          remover: DatabaseRemoverImpl(),
        );
    final dbFile = await dbFileToFile(db);
    final isolateToken = RootIsolateToken.instance!;
    return NativeDatabase.createInBackground(
      dbFile,
      isolateSetup: () async {
        BackgroundIsolateBinaryMessenger.ensureInitialized(isolateToken);
        if (doSqlchipherInit) {
          // Sqlchipher related init needs to be done only once per app process.
          // It seems to be possible that this runs multiple times as the same
          // process can have main isolate started several times. That happens
          // with Android back button. That behavior is however currently prevented
          // by calling exit in AppLifecycleHandler class.
          _log.info("Initializing database library");
          await applyWorkaroundToOpenSqlCipherOnOldAndroidVersions();
          open.overrideFor(OperatingSystem.android, openCipherOnAndroid);

          sqlite3.tempDirectory = await TmpDirUtils.sqliteTmpDir();
        } else {
          // Every isolate needs this to be set
          open.overrideFor(OperatingSystem.android, openCipherOnAndroid);
        }
      },
      setup: (dbAccess) {
        final cipherVersion = dbAccess.select('PRAGMA cipher_version;');
        if (cipherVersion.isEmpty) {
          throw Exception("SQLChipher not available");
        }

        dbAccess.execute("PRAGMA key = '$encryptionKey';");
        dbAccess.execute("PRAGMA foreign_keys = ON;");
        dbAccess.execute("PRAGMA journal_mode = WAL;");
        dbAccess.execute("PRAGMA synchronous = NORMAL;");
      },
    );
  });
}
