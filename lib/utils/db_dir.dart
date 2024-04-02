

import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class DbDirUtils {
  static Future<String> _dbPath(String fileName) async {
    final supportDir = await getApplicationSupportDirectory();
    final dbDirPath = p.join(supportDir.path, "databases");
    final dir = Directory(dbDirPath);
    if (!await dir.exists()) {
      await dir.create(); // TODO: Error handling
    }
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
