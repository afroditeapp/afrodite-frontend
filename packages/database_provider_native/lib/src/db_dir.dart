import 'dart:io';

import 'package:encryption/encryption.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

final _log = Logger("DbDirUtils");

/// TODO(quality): Error handling
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
      await dir.create();
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
      _log.info("Databases directory recreated");
    }
  }

  @override
  Future<void> deleteAllDatabases() async {
    try {
      // Delete foreground databases
      await recreateDatabasesDir(backgroundDb: false);
      _log.info("Deleted foreground databases");

      // Delete background databases
      await recreateDatabasesDir(backgroundDb: true);
      _log.info("Deleted background databases");
    } catch (e, stackTrace) {
      _log.severe("Error deleting all databases", e, stackTrace);
      rethrow;
    }
  }
}
