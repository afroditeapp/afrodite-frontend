import 'dart:io';

import 'package:database_provider_native/src/db_dir.dart';
import 'package:database_provider_native/src/tmp_dir.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/services.dart';
import 'package:database_utils/database_utils.dart';
import 'package:sqlite3/sqlite3.dart';

class DbProvider implements QueryExcecutorProvider {
  final DbFile _db;
  DbProvider(this._db);

  LazyDatabase? _dbConnection;

  @override
  QueryExecutor getQueryExcecutor() {
    _dbConnection ??= openDbConnection(_db);
    return _dbConnection!;
  }
}

Future<File> dbFileToFile(DbFile dbFile) async {
  switch (dbFile) {
    case CommonDbFile():
      return File(await DbDirUtils.commonDbPath());
    case AccountDbFile():
      return File(await DbDirUtils.accountDbPath(dbFile.accountId));
  }
}

Future<bool> databaseExists(DbFile db) async {
  final dbFile = await dbFileToFile(db);
  return await dbFile.exists();
}

LazyDatabase openDbConnection(DbFile db) {
  return LazyDatabase(() async {
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
        // This should be safe to call multiple times as the created
        // C string bytes are not deallocated.
        sqlite3.tempDirectory = await TmpDirUtils.sqliteTmpDir();

        // ignore: avoid_print
        print("${db.runtimeType} isolateSetup completed");
      },
      setup: (dbAccess) {
        // ignore: avoid_print
        print("${db.runtimeType} setup started");

        dbAccess.execute("PRAGMA foreign_keys = ON;");
        dbAccess.execute("PRAGMA journal_mode = WAL;");
        dbAccess.execute("PRAGMA synchronous = NORMAL;");

        // ignore: avoid_print
        print("${db.runtimeType} setup completed");
      },
    );
  });
}
