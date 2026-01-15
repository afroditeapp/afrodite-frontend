import 'dart:io';

import 'package:encryption/encryption.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

final _log = Logger("DbDirUtils");

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

class DatabaseRemoverImpl extends DatabaseRemover {
  @override
  Future<void> recreateDatabasesDir() async {
    final dbDirPath = await DbDirUtils._dbDirPath();
    final dir = Directory(dbDirPath);
    if (await dir.exists()) {
      await dir.delete(recursive: true);
      await DbDirUtils._dbDirPath(); // Recreate the directory
      _log.info("Databases directory recreated");
    }
  }

  @override
  Future<void> deleteAllDatabases() async {
    try {
      // Delete databases
      await recreateDatabasesDir();
      _log.info("Deleted all databases");
    } catch (e, stackTrace) {
      _log.severe("Error deleting all databases", e, stackTrace);
      rethrow;
    }
  }
}
