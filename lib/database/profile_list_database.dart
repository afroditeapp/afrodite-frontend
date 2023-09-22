


import 'package:pihka_frontend/database/base_database.dart';
import 'package:sqflite/utils/utils.dart';
import 'package:sqflite/sqflite.dart';

class ProfileListDatabase extends BaseDatabase {
  ProfileListDatabase._private();
  static final _instance = ProfileListDatabase._private();
  factory ProfileListDatabase.getInstance() {
    return _instance;
  }

  @override
  DatabaseType get databaseType => DatabaseType.profileList;

  @override
  Future<void> onCreate(Database db, int version) async {
    await db.execute("""
      CREATE TABLE profile_list(
        id INTEGER PRIMARY KEY,
        uuid TEXT NOT NULL,
        image_uuid TEXT NOT NULL
      )
    """);
  }

  @override
  Future<void> init() async {
    // Create database or run migrations
    await getOrOpenDatabase();

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
      return await db.delete("profile_list");
    });
  }

  Future<int?> profileCount() async {
    return await runAction((db) async {
      return firstIntValue(await db.query("profile_list", columns: ["COUNT(id)"]));
    });
  }

  Future<int?> insertProfile(ProfileListEntry entry) async {
    return await runAction((db) async {
      return await db.insert("profile_list", entry.toMap());
    });
  }

  Future<List<ProfileListEntry>?> getProfileList(int startIndex, int limit) async {
    return await runAction((db) async {
      final result = await db.query(
        "profile_list",
        columns: ["uuid", "image_uuid"],
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
  final String imageUuid;
  ProfileListEntry(this.uuid, this.imageUuid);

  Map<String, Object?> toMap() {
    return {
      "uuid": uuid,
      "image_uuid": imageUuid,
    };
  }

  ProfileListEntry.fromMap(Map<String, Object?> map):
    uuid = map["uuid"] as String,
    imageUuid = map["image_uuid"] as String;

  @override
  String toString() {
    return "ProfileListEntry(uuid: $uuid, imageUuid: $imageUuid)";
  }
}
