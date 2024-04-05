

import 'dart:io';

import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

final log = Logger("DbDirUtils");

class DbDirUtils {
  static Future<String> _dbDirPath() async {
    final supportDir = await getApplicationSupportDirectory();
    final dbDirPath = p.join(supportDir.path, "databases");
    final dir = Directory(dbDirPath);
    if (!await dir.exists()) {
      await dir.create(); // TODO: Error handling
    }
    return dbDirPath;
  }

  static Future<String> _dbPath(String fileName) async {
    final dbDirPath = await _dbDirPath();
    final filePath = p.join(dbDirPath, fileName);
    return filePath;
  }

  static Future<String> commonDbPath() async {
    return _dbPath("common.db");
  }

  static Future<String> accountDbPath(String account) async {
    final dbName = "$account.account.db";
    return await _dbPath(dbName);
  }

  static Future<void> recreateDatabasesDir() async {
    final dbDirPath = await _dbDirPath();
    final dir = Directory(dbDirPath);
    if (await dir.exists()) {
      await dir.delete(recursive: true);
      await _dbDirPath(); // Recreate the directory
      log.info("Databases directory recreated");
    }
  }
}
