import 'dart:io';

import 'package:database_provider_native/src/db_dir.dart';
import 'package:database_provider_native/src/tmp_dir.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:encryption/encryption.dart';
import 'package:flutter/services.dart';
import 'package:sqlite3/open.dart';
import 'package:sqlcipher_flutter_libs/sqlcipher_flutter_libs.dart';
import 'package:database_utils/database_utils.dart';
import 'package:sqlite3/sqlite3.dart';

class DbProvider implements QueryExcecutorProvider {
  final DbFile _db;
  final bool _backgroundDb;
  DbProvider(this._db, {required bool backgroundDb}) : _backgroundDb = backgroundDb;

  LazyDatabase? _dbConnection;

  @override
  QueryExecutor getQueryExcecutor() {
    _dbConnection ??= openDbConnection(_db, backgroundDb: _backgroundDb);
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

LazyDatabase openDbConnection(DbFile db, {required bool backgroundDb}) {
  return LazyDatabase(() async {
    final encryptionKey = await SecureStorageManager.getInstance()
        .getDbEncryptionKeyOrCreateNewKeyAndRecreateDatabasesDir(
          backgroundDb: backgroundDb,
          remover: DatabaseRemoverImpl(),
        );
    final dbFile = await dbFileToFile(db);
    final isolateToken = RootIsolateToken.instance!;
    // Log using print as Logger would need to be initialized for every
    // isolate.
    return NativeDatabase.createInBackground(
      dbFile,
      isolateSetup: () async {
        // ignore: avoid_print
        print("${db.runtimeType} isolateSetup started");

        BackgroundIsolateBinaryMessenger.ensureInitialized(isolateToken);
        open.overrideFor(OperatingSystem.android, openCipherOnAndroid);
        // This should be safe to call multiple times as the created
        // C string bytes are not deallocated.
        sqlite3.tempDirectory = await TmpDirUtils.sqliteTmpDir();

        // ignore: avoid_print
        print("${db.runtimeType} isolateSetup completed");
      },
      setup: (dbAccess) {
        // ignore: avoid_print
        print("${db.runtimeType} setup started");

        final cipherVersion = dbAccess.select('PRAGMA cipher_version;');
        if (cipherVersion.isEmpty) {
          throw Exception("SQLCipher not available");
        }

        dbAccess.execute("PRAGMA key = '$encryptionKey';");
        dbAccess.execute("PRAGMA foreign_keys = ON;");
        dbAccess.execute("PRAGMA journal_mode = WAL;");
        dbAccess.execute("PRAGMA synchronous = NORMAL;");

        // ignore: avoid_print
        print("${db.runtimeType} setup completed");
      },
    );
  });
}
