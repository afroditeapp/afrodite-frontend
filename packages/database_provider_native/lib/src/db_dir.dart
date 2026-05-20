import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

/// TODO(quality): Error handling
class DbDirUtils {
  static Future<String> _dbDirPath() async {
    const dbDirName = "databases";

    final supportDir = await getApplicationSupportDirectory();
    final dbDirPath = p.join(supportDir.path, dbDirName);
    final dir = Directory(dbDirPath);
    if (!await dir.exists()) {
      await dir.create();
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
}
