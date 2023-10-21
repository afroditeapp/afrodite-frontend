


import 'package:openapi/api.dart';
import 'package:pihka_frontend/database/base_database.dart';
import 'package:sqflite/utils/utils.dart';
import 'package:sqflite/sqflite.dart';

class ProfileListDatabase extends BaseDatabase {
  ProfileListDatabase._private();
  static final _instance = ProfileListDatabase._private();
  factory ProfileListDatabase.getInstance() {
    return _instance;
  }

  static const profileListTableName = "profile_list";

  @override
  DatabaseType get databaseType => DatabaseType.profileList;

  @override
  Future<void> onCreate(Database db, int version) async {
    await db.execute("""
      CREATE TABLE profile_list(
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

  Future<void> clearProfiles() async {
    await runAction((db) async {
      return await db.delete(profileListTableName);
    });
  }

  Future<int?> profileCount() async {
    return await runAction((db) async {
      return firstIntValue(await db.query(profileListTableName, columns: ["COUNT(id)"]));
    });
  }

  Future<int?> insertProfile(ProfileListEntry entry) async {
    return await runAction((db) async {
      return await db.insert(profileListTableName, entry.toMap());
    });
  }

  Future<void> removeProfile(AccountId accountId) async {
    await runAction((db) async {
      return await db.delete(
        profileListTableName,
        where: "uuid = ?",
        whereArgs: [accountId.accountId],
      );
    });
  }

  Future<List<ProfileListEntry>?> getProfileList(int startIndex, int limit) async {
    return await runAction((db) async {
      final result = await db.query(
        profileListTableName,
        columns: ["uuid"],
        orderBy: "id",
        limit: limit,
        offset: startIndex,
      );
      return result.map((e) => ProfileListEntry.fromMap(e)).toList();
    });
  }
}

class ProfileListEntry {
  final String uuid;
  ProfileListEntry(this.uuid);

  Map<String, Object?> toMap() {
    return {
      "uuid": uuid
    };
  }

  ProfileListEntry.fromMap(Map<String, Object?> map):
    uuid = map["uuid"] as String;

  @override
  String toString() {
    return "ProfileListEntry(uuid: $uuid)";
  }
}
