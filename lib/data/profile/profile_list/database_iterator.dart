import 'dart:async';

import 'package:pihka_frontend/database/favorite_profiles_database.dart';
import 'package:pihka_frontend/database/profile_database.dart';
import 'package:pihka_frontend/database/profile_list_database.dart';
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
    final profiles = await ProfileListDatabase.getInstance().getProfileList(currentIndex, queryCount);
    if (profiles != null) {
      currentIndex += queryCount;
      return await ProfileDatabase.getInstance().convertList(profiles);
    } else {
      return [];
    }
  }

  Future<List<ProfileEntry>> nextListFromFavorites() async {
    const queryCount = 10;
    final profiles = await FavoriteProfilesDatabase.getInstance().getFavoriteProfilesList(currentIndex, queryCount);
    if (profiles != null) {
      currentIndex += queryCount;
      return await ProfileDatabase.getInstance().convertListOfFavoriteProfiles(profiles);
    } else {
      return [];
    }
  }
}
