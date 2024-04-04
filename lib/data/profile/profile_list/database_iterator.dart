import 'dart:async';

import 'package:pihka_frontend/database/database_manager.dart';
import 'package:pihka_frontend/database/profile_database.dart';
import 'package:pihka_frontend/data/profile/profile_iterator.dart';


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
    final profiles = await DatabaseManager.getInstance().profileData((db) => db.getProfileGridList(currentIndex, queryCount));
    if (profiles != null) {
      currentIndex += queryCount;
      return await DatabaseManager.getInstance().profileData((db) => db.convertToProfileEntries(profiles)) ?? [];
    } else {
      return [];
    }
  }

  Future<List<ProfileEntry>> nextListFromFavorites() async {
    const queryCount = 10;
    final profiles = await DatabaseManager.getInstance().profileData((db) => db.getFavoritesList(currentIndex, queryCount));
    if (profiles != null) {
      currentIndex += queryCount;
      return await DatabaseManager.getInstance().profileData((db) => db.convertToProfileEntries(profiles)) ?? [];
    } else {
      return [];
    }
  }
}
