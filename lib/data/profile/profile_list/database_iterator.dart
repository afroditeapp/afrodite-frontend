import 'dart:async';

import 'package:database/database.dart';
import 'package:pihka_frontend/database/database_manager.dart';
import 'package:pihka_frontend/data/profile/profile_iterator.dart';
import 'package:pihka_frontend/utils/result.dart';

class DatabaseIterator extends IteratorType {
  int currentIndex;
  final bool iterateFavorites;
  DatabaseIterator({this.currentIndex = 0, this.iterateFavorites = false});

  @override
  void reset() {
    currentIndex = 0;
  }

  @override
  Future<List<ProfileEntry>> nextList() async {
    if (iterateFavorites) {
      return await nextListFromFavorites();
    } else {
      return await nextListFromPublicProfiles();
    }
  }

  Future<List<ProfileEntry>> nextListFromPublicProfiles() async {
    const queryCount = 10;
    final profiles = await DatabaseManager.getInstance().profileData((db) => db.getProfileGridList(currentIndex, queryCount)).ok();
    if (profiles != null) {
      currentIndex += queryCount;
      return await DatabaseManager.getInstance().profileData((db) => db.convertToProfileEntries(profiles)).ok() ?? [];
    } else {
      return [];
    }
  }

  Future<List<ProfileEntry>> nextListFromFavorites() async {
    const queryCount = 10;
    final profiles = await DatabaseManager.getInstance().profileData((db) => db.getFavoritesList(currentIndex, queryCount)).ok();
    if (profiles != null) {
      currentIndex += queryCount;
      return await DatabaseManager.getInstance().profileData((db) => db.convertToProfileEntries(profiles)).ok() ?? [];
    } else {
      return [];
    }
  }
}
