


import 'package:openapi/api.dart';
import 'package:pihka_frontend/database/base_database.dart';
import 'package:pihka_frontend/database/favorite_profiles_database.dart';
import 'package:pihka_frontend/database/profile_list_database.dart';
import 'package:sqflite/utils/utils.dart';
import 'package:sqflite/sqflite.dart';

class ProfileDatabase extends BaseDatabase {
  ProfileDatabase._private();
  static final _instance = ProfileDatabase._private();
  factory ProfileDatabase.getInstance() {
    return _instance;
  }

  static const profilesTableName = "profiles";

  @override
  DatabaseType get databaseType => DatabaseType.profile;

  @override
  Future<void> onCreate(Database db, int version) async {
    await db.execute("""
      CREATE TABLE profiles(
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
      return await db.delete(profilesTableName);
    });
  }

  Future<int?> profileCount() async {
    return await runAction((db) async {
      return firstIntValue(await db.query(profilesTableName, columns: ["COUNT(id)"]));
    });
  }

  /// Replaces the existing entry if it exists.
  /// TODO: Replace the existing entry if it exists.
  ///       Would adding UNIQUE(uuid) to the table definition work?
  Future<int?> insertProfile(ProfileEntry entry) async {
    return await runAction((db) async {
      return await db.insert(profilesTableName, entry.toMap());
    });
  }

  Future<void> removeProfile(AccountId accountId) async {
    await runAction((db) async {
      return await db.delete(
        profilesTableName,
        where: "uuid = ?",
        whereArgs: [accountId.accountId],
      );
    });
  }

  Future<void> updateProfile(AccountId accountId, Profile profile) async {
    await runAction((db) async {
      return await db.update(
        profilesTableName,
        {"profile_text": profile.profileText},
        where: "uuid = ?",
        whereArgs: [accountId.accountId],
      );
    });
  }

  Future<ProfileEntry?> getProfileEntry(AccountId accountId) async {
    return await runAction((db) async {
      final result = await db.query(
        profilesTableName,
        columns: ["uuid", "image_uuid", "name", "profile_text"],
        where: "uuid = ?",
        whereArgs: [accountId.accountId],
      );
      final list = result.map((e) {
        return ProfileEntry.fromMap(e);
      }).toList();
      return list.firstOrNull;
    });
  }

  Future<Profile?> getProfile(AccountId accountId) async {
    final entry = await getProfileEntry(accountId);
    if (entry != null) {
      return Profile(
        name: entry.name,
        profileText: entry.profileText,
        // TODO: save version?
        version: ProfileVersion(versionUuid: ""),
      );
    } else {
      return null;
    }
  }

  Future<List<ProfileEntry>> convertList(List<ProfileListEntry> profiles) async {
    final newList = List<ProfileEntry>.empty(growable: true);
    for (final profile in profiles) {
      final profileData = await getProfileEntry(AccountId(accountId: profile.uuid));
      if (profileData != null) {
        newList.add(profileData);
      }
    }
    return newList;
  }

  Future<List<ProfileEntry>> convertListOfFavoriteProfiles(List<FavoriteProfileEntry> profiles) async {
    final newList = List<ProfileEntry>.empty(growable: true);
    for (final profile in profiles) {
      final profileData = await getProfileEntry(AccountId(accountId: profile.uuid));
      if (profileData != null) {
        newList.add(profileData);
      }
    }
    return newList;
  }
}

class ProfileEntry {
  final String uuid;
  final String imageUuid;
  final String name;
  final String profileText;
  ProfileEntry(this.uuid, this.imageUuid, this.name, this.profileText);

  Map<String, Object?> toMap() {
    return {
      "uuid": uuid,
      "image_uuid": imageUuid,
      "name": name,
      "profile_text": profileText,
    };
  }

  ProfileEntry.fromMap(Map<String, Object?> map):
    uuid = map["uuid"] as String,
    imageUuid = map["image_uuid"] as String,
    name = map["name"] as String,
    profileText = map["profile_text"] as String;

  ProfileEntry copyWith(
    {
      String? uuid,
      String? imageUuid,
      String? name,
      String? profileText
    }
  ) {
    return ProfileEntry(
      uuid ?? this.uuid,
      imageUuid ?? this.imageUuid,
      name ?? this.name,
      profileText ?? this.profileText,
    );
  }

  @override
  String toString() {
    return "ProfileEntry(uuid: $uuid, imageUuid: $imageUuid, name: $name, profileText: $profileText)";
  }
}
