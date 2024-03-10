



import 'package:pihka_frontend/api/error_manager.dart';
import 'package:pihka_frontend/utils.dart';
import 'package:sqflite/sqflite.dart';

enum DatabaseType {
  chatReceivedBlocks,
  chatReceivedLikes,
  chatSentBlocks,
  chatSentLikes,
  chatMatches,
  chatMessages,
  profile,
  favoriteProfiles,
  profileList;

  String get databaseName {
    switch (this) {
      case DatabaseType.profile:
        return "a.db";
      case DatabaseType.favoriteProfiles:
        return "b.db";
      case DatabaseType.profileList:
        return "c.db";
      case DatabaseType.chatReceivedBlocks:
        return "d.db";
      case DatabaseType.chatReceivedLikes:
        return "e.db";
      case DatabaseType.chatSentBlocks:
        return "f.db";
      case DatabaseType.chatSentLikes:
        return "g.db";
      case DatabaseType.chatMatches:
        return "h.db";
      case DatabaseType.chatMessages:
        return "i.db";
    }
  }
  String get databaseErrorTitle {
    switch (this) {
      case DatabaseType.profile:
        return "Profile database error";
      case DatabaseType.favoriteProfiles:
        return "Favorite profiles database error";
      case DatabaseType.profileList:
        return "Profile list database error";
      case DatabaseType.chatReceivedBlocks:
        return "Received blocks database error";
      case DatabaseType.chatReceivedLikes:
        return "Received likes database error";
      case DatabaseType.chatSentBlocks:
        return "Sent blocks database error";
      case DatabaseType.chatSentLikes:
        return "Sent likes database error";
      case DatabaseType.chatMatches:
        return "Matches database error";
      case DatabaseType.chatMessages:
        return "Messages database error";
    }
  }
}

abstract class BaseDatabase extends AppSingleton {

  // Implementations required
  DatabaseType get databaseType;
  /// Create database tables
  Future<void> onCreate(Database db, int version);

  // Override if needed
  /// Database version
  int get versionForMigrations => 1;
  /// Database migrations. Empty by default.
  Future<void> onUpgrade(Database db, int oldVersion, int newVersion) async {
    return;
  }

  Database? _database;
  bool _closed = false;

  /// Reset closed state. Makes opening the database possible once again.
  void resetClosedStateInfo() {
    _closed = false;
  }

  /// Opens new database if needed if not manually closed
  Future<Database?> getOrOpenDatabase({bool deleteBeforeOpenForDevelopment = false}) async {
    if (_closed) {
      return null;
    }

    if (deleteBeforeOpenForDevelopment) {
      // Exception is not handled as this should be used when developing only
      log.warning("Deleting database ${databaseType.databaseName}");
      await deleteDatabase(databaseType.databaseName);
    }

    try {
      _database ??= await openDatabase(
        databaseType.databaseName,
        version: versionForMigrations,
        onConfigure: (db) async {
          await db.rawQuery("PRAGMA journal_mode = WAL");
          await db.rawQuery("PRAGMA synchronous = NORMAL");
          await db.rawQuery("PRAGMA foreign_keys = ON");
        },
        onCreate: (db, version) async {
          await onCreate(db, version);
        },
        onUpgrade: (db, oldVersion, newVersion) async {
          await onUpgrade(db, oldVersion, newVersion);
        },
      );
    } on DatabaseException catch (e) {
      ErrorManager.getInstance().send(DatabaseOpenError(databaseType, e));
      return null;
    }

    return _database;
  }

  Future<void> close() async {
    final database = _database;
    if (database != null) {
      _database = null;
      _closed = true;
      try {
        return await database.close();
      } on DatabaseException catch (e) {
        ErrorManager.getInstance().send(DatabaseCloseError(databaseType, e));
        return;
      }
    }
  }

  Future<R?> runAction<R extends Object>(Future<R?> Function(Database) action) async {
    final database = await getOrOpenDatabase();
    if (database == null) {
      return null;
    }

    try {
      return action(database);
    } on DatabaseException catch (e) {
      ErrorManager.getInstance().send(DatabaseActionError(databaseType, e));
      return null;
    }
  }

}
