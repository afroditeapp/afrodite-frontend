import 'dart:async';

import 'package:database/database.dart';
import 'package:pihka_frontend/database/account_database_manager.dart';
import 'package:pihka_frontend/data/profile/profile_iterator.dart';
import 'package:pihka_frontend/utils/result.dart';

class DatabaseIterator extends IteratorType {
  int currentIndex;
  final bool iterateFavorites;
  final AccountDatabaseManager db;
  DatabaseIterator({this.currentIndex = 0, this.iterateFavorites = false, required this.db});

  @override
  void reset() {
    currentIndex = 0;
  }

  @override
  Future<Result<List<ProfileEntry>, void>> nextList() async {
    if (iterateFavorites) {
      return await nextListFromFavorites();
    } else {
      return await nextListFromPublicProfiles();
    }
  }

  Future<Result<List<ProfileEntry>, void>> nextListFromPublicProfiles() async {
    const queryCount = 10;
    final profiles = await db.profileData((db) => db.getProfileGridList(currentIndex, queryCount)).ok();
    if (profiles != null) {
      currentIndex += queryCount;
      return Ok(await db.profileData((db) => db.convertToProfileEntries(profiles)).ok() ?? []);
    } else {
      return const Ok([]);
    }
  }

  Future<Result<List<ProfileEntry>, void>> nextListFromFavorites() async {
    const queryCount = 10;
    final profiles = await db.profileData((db) => db.getFavoritesList(currentIndex, queryCount)).ok();
    if (profiles != null) {
      currentIndex += queryCount;
      return Ok(await db.profileData((db) => db.convertToProfileEntries(profiles)).ok() ?? []);
    } else {
      return const Ok([]);
    }
  }
}
