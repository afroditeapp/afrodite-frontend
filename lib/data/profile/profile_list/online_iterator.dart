import 'dart:async';
import 'dart:convert';

import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/api/api_manager.dart';
import 'package:pihka_frontend/data/profile/profile_iterator.dart';
import 'package:pihka_frontend/data/profile/profile_list/database_iterator.dart';
import 'package:pihka_frontend/data/utils.dart';
import 'package:pihka_frontend/database/favorite_profiles_database.dart';
import 'package:pihka_frontend/database/profile_database.dart';
import 'package:pihka_frontend/database/profile_list_database.dart';
import 'package:pihka_frontend/storage/kv.dart';
import 'package:pihka_frontend/utils.dart';


class OnlineIterator extends IteratorType {
  int currentIndex = 0;
  DatabaseIterator? databaseIterator;
  bool firstIterationAfterLogin;
  final ApiManager api = ApiManager.getInstance();
  final downloader = ProfileEntryDownloader();

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
  Future<List<ProfileEntry>> nextList() async {
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

    final List<ProfileEntry> list = List.empty(growable: true);
    while (true) {
      final profiles = await api.profile((api) => api.postGetNextProfilePage());
      if (profiles != null) {
        if (profiles.profiles.isEmpty) {
          return [];
        }

        for (final p in profiles.profiles) {
          final entry = await downloader.download(p.id);
          if (entry == null) {
            continue;
          }

          final listEntry = ProfileListEntry(p.id.accountId);
          await ProfileListDatabase.getInstance().insertProfile(listEntry);

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

class ProfileEntryDownloader {
  final ApiManager api = ApiManager.getInstance();

  /// Download profile entry, save to databases and return it.
  Future<ProfileEntry?> download(AccountId accountId, {bool isMatch = false}) async {
    final primaryImageInfo = await api.media((api) => api.getPrimaryImageInfo(accountId.accountId, isMatch));
    final imageUuid = primaryImageInfo?.contentId?.contentId;
    if (imageUuid == null) {
      return null;
    }

    // Prevent displaying error when profile is made private while iterating
    final (_, profileDetails) = await api
      .profileWrapper()
      .requestWithHttpStatus(logError: false, (api) => api.getProfile(accountId.accountId));
    if (profileDetails == null) {
      return null;
    }
    // TODO: Compare cached profile data with the one from the server.
    //       Update: perhaps another database for profiles? With current
    //       implementation there is no cached data. Or should
    //       new profile request be made every time profile is opened and
    //       use the cache check there?

    final dataEntry = ProfileEntry(accountId.accountId, imageUuid, profileDetails.name, profileDetails.profileText);
    await ProfileDatabase.getInstance().insertProfile(dataEntry);

    return dataEntry;
  }
}
