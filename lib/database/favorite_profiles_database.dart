


import 'package:openapi/api.dart';
import 'package:pihka_frontend/database/base_database.dart';
import 'package:sqflite/utils/utils.dart';
import 'package:sqflite/sqflite.dart';

class FavoriteProfilesDatabase extends BaseDatabase {
  FavoriteProfilesDatabase._private();
  static final _instance = FavoriteProfilesDatabase._private();
  factory FavoriteProfilesDatabase.getInstance() {
    return _instance;
  }

  static const String favoriteProfilesTableName = "favorite_profiles";

  @override
  DatabaseType get databaseType => DatabaseType.favoriteProfiles;

  @override
  Future<void> onCreate(Database db, int version) async {
    await db.execute("""
      CREATE TABLE favorite_profiles(
        id INTEGER PRIMARY KEY,
        uuid TEXT NOT NULL
      )
    """);
  }

  @override
  Future<void> init() async {
    // Create database or run migrations
    await getOrOpenDatabase(deleteBeforeOpenForDevelopment: false);

    // await clearProfiles();
    // final count = await profileCount();
    // if (count == null || count == 0) {
    //   await insertProfile(ProfileListEntry("default1", "default"));
    //   await insertProfile(ProfileListEntry("default2", "default"));
    //   await insertProfile(ProfileListEntry("default3", "default"));
    // }

    // final count2 = await profileCount();
    // final profiles = await getProfileList(1, count2!);
    // print(profiles);
  }

  Future<void> clearFavoriteProfiles() async {
    await runAction((db) async {
      return await db.delete(favoriteProfilesTableName);
    });
  }

  Future<int?> profileCount() async {
    return await runAction((db) async {
      return firstIntValue(
        await db.query(
          favoriteProfilesTableName,
          columns: ["COUNT(id)"]),
        );
    });
  }

  Future<void> insertProfile(AccountId accountId) async {
    await runAction((db) async {
      return await db.insert(
        favoriteProfilesTableName,
        FavoriteProfileEntry(accountId.accountId).toMap()
      );
    });
  }

  Future<void> removeFromFavorites(AccountId accountId) async {
    await runAction((db) async {
      return await db.delete(
        favoriteProfilesTableName,
        where: "uuid = ?",
        whereArgs: [accountId.accountId],
      );
    });
  }

  Future<bool> isInFavorites(AccountId accountId) async {
    return await runAction((db) async {
      final data = await db.query(
        favoriteProfilesTableName,
        where: "uuid = ?",
        whereArgs: [accountId.accountId],
      );
      return data.isNotEmpty;
    }) ?? false;
  }

  Future<List<FavoriteProfileEntry>?> getFavoriteProfilesList(int startIndex, int limit) async {
    return await runAction((db) async {
      final result = await db.query(
        favoriteProfilesTableName,
        columns: ["uuid"],
        orderBy: "id",
        limit: limit,
        offset: startIndex,
      );
      return result.map((e) => FavoriteProfileEntry.fromMap(e)).toList();
    });
  }
}

class FavoriteProfileEntry {
  final String uuid;
  FavoriteProfileEntry(this.uuid);

  Map<String, Object?> toMap() {
    return {
      "uuid": uuid,
    };
  }

  FavoriteProfileEntry.fromMap(Map<String, Object?> map):
    uuid = map["uuid"] as String;

  @override
  String toString() {
    return "FavoriteProfileEntry(uuid: $uuid)";
  }
}
