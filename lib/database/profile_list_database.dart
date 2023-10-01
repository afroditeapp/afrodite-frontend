


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

  @override
  DatabaseType get databaseType => DatabaseType.profileList;

  @override
  Future<void> onCreate(Database db, int version) async {
    await db.execute("""
      CREATE TABLE profile_list(
        id INTEGER PRIMARY KEY,
        uuid TEXT NOT NULL,
        image_uuid TEXT NOT NULL,
        name TEXT NOT NULL,
        profile_text TEXT NOT NULL
      )
    """);
  }

  @override
  Future<void> init() async {
    // Create database or run migrations
    await getOrOpenDatabase(deleteBeforeOpenForDevelopment: true);

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

  Future<void> updateProfile(AccountId accountId, Profile profile) async {
    await runAction((db) async {
      return await db.update(
        "profile_list",
        {"profile_text": profile.profileText},
        where: "uuid = ?",
        whereArgs: [accountId.accountId],
      );
    });
  }

  Future<Profile?> getProfile(AccountId accountId) async {
    return await runAction((db) async {
      final result = await db.query(
        "profile_list",
        columns: ["uuid", "image_uuid", "name", "profile_text"],
        where: "uuid = ?",
        whereArgs: [accountId.accountId],
      );
      final list = result.map((e) {
        final entry = ProfileListEntry.fromMap(e);
        return Profile(
          name: entry.name,
          profileText: entry.profileText,
          // TODO: save version?
          version: ProfileVersion(versionUuid: ""),
        );
      }).toList();
      return list.firstOrNull;
    });
  }

  Future<List<ProfileListEntry>?> getProfileList(int startIndex, int limit) async {
    return await runAction((db) async {
      final result = await db.query(
        "profile_list",
        columns: ["uuid", "image_uuid", "name", "profile_text"],
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
  final String name;
  final String profileText;
  ProfileListEntry(this.uuid, this.imageUuid, this.name, this.profileText);

  Map<String, Object?> toMap() {
    return {
      "uuid": uuid,
      "image_uuid": imageUuid,
      "name": name,
      "profile_text": profileText,
    };
  }

  ProfileListEntry.fromMap(Map<String, Object?> map):
    uuid = map["uuid"] as String,
    imageUuid = map["image_uuid"] as String,
    name = map["name"] as String,
    profileText = map["profile_text"] as String;

  @override
  String toString() {
    return "ProfileListEntry(uuid: $uuid, imageUuid: $imageUuid, name: $name, profileText: $profileText)";
  }
}
