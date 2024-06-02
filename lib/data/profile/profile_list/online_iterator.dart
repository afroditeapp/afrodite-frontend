import 'dart:async';

import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/api/api_manager.dart';
import 'package:pihka_frontend/data/image_cache.dart';
import 'package:pihka_frontend/data/profile/profile_iterator.dart';
import 'package:pihka_frontend/data/profile/profile_list/database_iterator.dart';
import 'package:database/database.dart';
import 'package:pihka_frontend/database/background_database_manager.dart';
import 'package:pihka_frontend/database/database_manager.dart';
import 'package:pihka_frontend/utils/result.dart';

final log = Logger("OnlineIterator");

class OnlineIterator extends IteratorType {
  int currentIndex = 0;
  DatabaseIterator? databaseIterator;
  bool resetServerIterator;
  bool waitConnectionOnce;
  final ApiManager api = ApiManager.getInstance();
  final DatabaseManager db = DatabaseManager.getInstance();
  final downloader = ProfileEntryDownloader();

  /// If [resetServerIterator] is true, the iterator will reset the
  /// server iterator to the beginning.
  OnlineIterator({this.resetServerIterator = false, this.waitConnectionOnce = false});

  @override
  void reset() {
    if (!resetServerIterator) {
      /// Reset to use database iterator and then continue online profile
      /// iterating.
      databaseIterator = DatabaseIterator();
    }
  }

  @override
  Future<List<ProfileEntry>> nextList() async {
    if (resetServerIterator) {
      if (waitConnectionOnce) {
        if (!await api.tryWaitUntilConnected(waitTimeoutSeconds: 5)) {
          log.warning("Connection waiting timeout");
        }
      }
      await ApiManager.getInstance().profileAction((api) => api.postResetProfilePaging());
      waitConnectionOnce = false;
      resetServerIterator = false;
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
      final profiles = await api.profile((api) => api.postGetNextProfilePage()).ok();
      if (profiles != null) {
        if (profiles.profiles.isEmpty) {
          return [];
        }

        for (final p in profiles.profiles) {
          final entry = await downloader.download(p.id).ok();
          if (entry == null) {
            continue;
          }
          await db.profileAction((db) => db.setProfileGridStatus(p.id, true));
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
  final DatabaseManager db = DatabaseManager.getInstance();

  /// Download profile entry, save to databases and return it.
  Future<Result<ProfileEntry, ProfileDownloadError>> download(AccountId accountId, {bool isMatch = false}) async {
    final contentInfoResult = await api.media((api) => api.getProfileContentInfo(accountId.accountId, isMatch));
    final ProfileContent contentInfo;
    switch (contentInfoResult) {
      case Ok(:final v):
        contentInfo = v;
      // case Err(:final e):
        // TODO: Test private profile error once the server supports it.
      case Err():
        return Err(OtherProfileDownloadError());
    }

    final primaryContentId = contentInfo.contentId0?.id;
    if (primaryContentId == null) {
      log.warning("Profile content info is missing");
      return Err(OtherProfileDownloadError());
    }

    final bytes = await ImageCacheData.getInstance().getImage(accountId, primaryContentId);
    if (bytes == null) {
      log.warning("Skipping one profile because image loading failed");
      return Err(OtherProfileDownloadError());
    }

    // Prevent displaying error when profile is made private while iterating
    final profileDetailsResult = await api
      .profileWrapper()
      .requestValue(logError: false, (api) => api.getProfile(accountId.accountId));

    final Profile profileDetails;
    switch (profileDetailsResult) {
      case Ok(:final v):
        profileDetails = v;
      case Err(:final e) when e.isInternalServerError():
        return Err(PrivateProfile());
      case Err(:final e):
        e.logError(log);
        return Err(OtherProfileDownloadError());
    }
    // TODO: Compare cached profile data with the one from the server.
    //       Update: perhaps another database for profiles? With current
    //       implementation there is no cached data. Or should
    //       new profile request be made every time profile is opened and
    //       use the cache check there?

    await BackgroundDatabaseManager.getInstance().profileAction((db) => db.updateProfileData(accountId, profileDetails));
    await db.profileAction((db) => db.updateProfileData(accountId, profileDetails));
    await db.profileAction((db) => db.updateProfileContent(accountId, contentInfo));
    final dataEntry = await db.profileData((db) => db.getProfileEntry(accountId)).ok();

    if (dataEntry == null) {
      log.warning("Storing profile data to database failed");
      return Err(OtherProfileDownloadError());
    }

    return Ok(dataEntry);
  }
}

sealed class ProfileDownloadError {}
class PrivateProfile extends ProfileDownloadError {}
class OtherProfileDownloadError extends ProfileDownloadError {}
