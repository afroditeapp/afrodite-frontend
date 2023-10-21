import 'dart:async';
import 'dart:convert';

import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/api/api_manager.dart';
import 'package:pihka_frontend/data/profile/profile_iterator.dart';
import 'package:pihka_frontend/data/profile/profile_list/database_iterator.dart';
import 'package:pihka_frontend/data/utils.dart';
import 'package:pihka_frontend/database/favorite_profiles_database.dart';
import 'package:pihka_frontend/database/profile_list_database.dart';
import 'package:pihka_frontend/storage/kv.dart';
import 'package:pihka_frontend/utils.dart';


class OnlineIterator extends IteratorType {
  int currentIndex = 0;
  DatabaseIterator? databaseIterator;
  bool firstIterationAfterLogin;
  final ApiManager api = ApiManager.getInstance();

  /// If [firstIterationAfterLogin] is true, the iterator will reset the
  /// server iterator to the beginning.
  OnlineIterator({this.firstIterationAfterLogin = false});

  @override
  void reset() {
    if (!firstIterationAfterLogin) {
      /// Reset to use database iterator and then continue online profile
      /// iterating.
      databaseIterator = DatabaseIterator();
    }
  }

  @override
  Future<List<ProfileListEntry>> nextList() async {
    if (firstIterationAfterLogin) {
      await ApiManager.getInstance().profile((api) => api.postResetProfilePaging());
      firstIterationAfterLogin = false;
    }

    // Handle case where iterator has been reseted in the middle
    // of online iteration. Get the beginning from the database.
    final iterator = databaseIterator;
    if (iterator != null) {
      final list = await iterator.nextList();
      if (list.isNotEmpty) {
        return list;
      } else {
        databaseIterator = null;
      }
    }

    // TODO: What if server restarts? The client thinks that it is
    // in the middle of the list, but the server has reseted the iterator.
    // Add some uuid to the iterator to check if the server has restarted?

    final List<ProfileListEntry> list = List.empty(growable: true);
    while (true) {
      final profiles = await api.profile((api) => api.postGetNextProfilePage());
      if (profiles != null) {
        if (profiles.profiles.isEmpty) {
          return [];
        }

        for (final p in profiles.profiles) {
          final profile = p;
          final primaryImageInfo = await api.media((api) => api.getPrimaryImageInfo(profile.id.accountId, false));
          final imageUuid = primaryImageInfo?.contentId?.contentId;
          if (imageUuid == null) {
            continue;
          }

          // Prevent displaying error when profile is made private while iterating
          final (_, profileDetails) = await api
            .profileWrapper()
            .requestWithHttpStatus(false, (api) => api.getProfile(profile.id.accountId));
          if (profileDetails == null) {
            continue;
          }
          // TODO: Compare cached profile data with the one from the server.
          //       Update: perhaps another database for profiles? With current
          //       implementation there is no cached data. Or should
          //       new profile request be made every time profile is opened and
          //       use the cache check there?

          final entry = ProfileListEntry(profile.id.accountId, imageUuid, profileDetails.name, profileDetails.profileText);
          await ProfileListDatabase.getInstance().insertProfile(entry);
          list.add(entry);
        }

        if (list.isEmpty) {
          // Handle case where server returned some profiles
          // but additional info fetching failed, so get next list of profiles.
          continue;
        }
      }

      return list;
    }
  }
}
