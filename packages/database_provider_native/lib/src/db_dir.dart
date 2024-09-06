

import 'dart:io';

import 'package:encryption/encryption.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

final log = Logger("DbDirUtils");

class DbDirUtils {
  static Future<String> _dbDirPath({bool backgroundDb = false}) async {
    final String dbDirName;
    if (backgroundDb) {
      dbDirName = "background_databases";
    } else {
      dbDirName = "databases";
    }

    final supportDir = await getApplicationSupportDirectory();
    final dbDirPath = p.join(supportDir.path, dbDirName);
    final dir = Directory(dbDirPath);
    if (!await dir.exists()) {
      await dir.create(); // TODO: Error handling
    }
    return dbDirPath;
  }

  static Future<String> _dbPath(String fileName, {bool backgroundDb = false}) async {
    final dbDirPath = await _dbDirPath(backgroundDb: backgroundDb);
    final filePath = p.join(dbDirPath, fileName);
    return filePath;
  }

  static Future<String> commonDbPath() async {
    return _dbPath("common.db");
  }

  static Future<String> commonBackgroundDbPath() async {
    return _dbPath("background_common.db", backgroundDb: true);
  }

  static Future<String> accountDbPath(String account) async {
    final dbName = "$account.account.db";
    return await _dbPath(dbName);
  }

  static Future<String> accountBackgroundDbPath(String account) async {
    final dbName = "$account.background_account.db";
    return await _dbPath(dbName, backgroundDb: true);
  }
}

class DatabaseRemoverImpl extends DatabaseRemover {
  @override
  Future<void> recreateDatabasesDir({required bool backgroundDb}) async {
    final dbDirPath = await DbDirUtils._dbDirPath(backgroundDb: backgroundDb);
    final dir = Directory(dbDirPath);
    if (await dir.exists()) {
      await dir.delete(recursive: true);
      await DbDirUtils._dbDirPath(); // Recreate the directory
      log.info("Databases directory recreated");
    }
  }
}
