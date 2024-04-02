

import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:pihka_frontend/storage/encryption.dart';
import 'package:pihka_frontend/utils/tmp_dir.dart';
import 'package:sqlite3/open.dart';
import 'package:sqlcipher_flutter_libs/sqlcipher_flutter_libs.dart';
import 'package:pihka_frontend/utils/db_dir.dart';
import 'package:sqlite3/sqlite3.dart';

final log = Logger("DatabaseUtils");

sealed class DbFile {
  Future<File> getFile();
}
class CommonDbFile extends DbFile {
  @override
  Future<File> getFile() async {
    final dbLocation = await DbDirUtils.commonDbPath();
    return File(dbLocation);
  }
}
class AccountDbFile extends DbFile {
  final String account;
  AccountDbFile(this.account);

  @override
  Future<File> getFile() async {
    final dbLocation = await DbDirUtils.accountDbPath(account);
    return File(dbLocation);
  }
}

LazyDatabase openDbConnection(DbFile db, {bool doInit = false}) {
  return LazyDatabase(() async {
    final dbFile = await db.getFile();
    final encryptionKey = await databaseEncryptionKey();
    final isolateToken = RootIsolateToken.instance!;
    return NativeDatabase.createInBackground(
      dbFile,
      isolateSetup: () async {
        BackgroundIsolateBinaryMessenger.ensureInitialized(isolateToken);
        if (doInit) {
          log.info("Initializing database library");
          await applyWorkaroundToOpenSqlCipherOnOldAndroidVersions();
          open.overrideFor(OperatingSystem.android, openCipherOnAndroid);

          sqlite3.tempDirectory = await TmpDirUtils.sqliteTmpDir();
        } else {
          // Second database might be in different isolate?
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
      }
    );
  });
}
