import 'dart:async';

import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/api/api_manager.dart';
import 'package:pihka_frontend/data/image_cache.dart';
import 'package:pihka_frontend/data/media_repository.dart';
import 'package:pihka_frontend/data/profile/profile_iterator.dart';
import 'package:pihka_frontend/data/profile/profile_list/database_iterator.dart';
import 'package:database/database.dart';
import 'package:pihka_frontend/database/account_background_database_manager.dart';
import 'package:pihka_frontend/database/account_database_manager.dart';
import 'package:pihka_frontend/utils.dart';
import 'package:pihka_frontend/utils/result.dart';

final log = Logger("OnlineIterator");

class OnlineIterator extends IteratorType {
  int currentIndex = 0;
  DatabaseIterator? databaseIterator;
  bool resetServerIterator;
  final ServerConnectionManager connectionManager;
  final ApiManager api;
  final AccountDatabaseManager db;
  final ProfileEntryDownloader downloader;

  /// If [resetServerIterator] is true, the iterator will reset the
  /// server iterator to the beginning.
  OnlineIterator({
    this.resetServerIterator = false,
    required MediaRepository media,
    required AccountBackgroundDatabaseManager accountBackgroundDb,
    required this.db,
    required this.connectionManager,
  }) :
    downloader = ProfileEntryDownloader(media, accountBackgroundDb, db, connectionManager.api),
    api = connectionManager.api;

  @override
  void reset() {
    if (!resetServerIterator) {
      /// Reset to use database iterator and then continue online profile
      /// iterating.
      databaseIterator = DatabaseIterator(db: db);
    }
  }

  @override
  Future<Result<List<ProfileEntry>, void>> nextList() async {
    if (resetServerIterator) {
      if (await connectionManager.waitUntilCurrentSessionConnects().isErr()) {
        log.error("Connection waiting failed");
        return const Err(null);
      }

      switch (await api.profile((api) => api.postResetProfilePaging())) {
        case Ok(:final v):
          resetServerIterator = false;
          await db.accountAction((db) => db.updateProfileIteratorSessionId(v));
          await db.accountAction((db) => db.daoProfileStates.setProfileGridStatusList(null, false, clear: true));
        case Err():
          log.error("Profile paging reset failed");
          return const Err(null);
      }
    }

    // Handle case where iterator has been reseted in the middle
    // of online iteration. Get the beginning from the database.
    final iterator = databaseIterator;
    if (iterator != null) {
      switch (await iterator.nextList()) {
        case Ok(value: final list):
          if (list.isNotEmpty) {
            return Ok(list);
          } else {
            databaseIterator = null;
          }
        case Err():
          log.error("Database iterator failed");
          return const Err(null);
      }
    }

    final iteratorSessionId = await db.accountStreamSingle((db) => db.watchProfileSessionId()).ok();
    if (iteratorSessionId == null) {
      log.error("No iterator session ID in database");
      return const Err(null);
    }

    final List<ProfileEntry> list = List.empty(growable: true);
    while (true) {
      if (await connectionManager.waitUntilCurrentSessionConnects().isErr()) {
        log.error("Connection waiting failed");
        return const Err(null);
      }
      switch (await api.profile((api) => api.postGetNextProfilePage(iteratorSessionId))) {
        case Ok(value: final profiles):
          if (profiles.errorInvalidIteratorSessionId) {
            log.error("Current iterator session ID is invalid");
            return const Err(null);
          }

          if (profiles.profiles.isEmpty) {
            return const Ok([]);
          }

          for (final p in profiles.profiles) {
            var entry = await db.profileData((db) => db.getProfileEntry(p.id)).ok();
            final currentVersion = entry?.version;
            final currentContentVersion = entry?.contentVersion;

            if (currentVersion == p.version && p.contentVersion != null && currentContentVersion == p.contentVersion) {
              // No data changes, download can be skipped, but
              // update last seen time.
              await db.profileAction((db) => db.updateProfileLastSeenTime(p.id, p.lastSeenTime));
            } else {
              entry = await downloader.download(p.id).ok();
            }

            final gridEntry = entry;
            if (gridEntry == null) {
              continue;
            }

            await db.accountAction((db) => db.daoProfileStates.setProfileGridStatus(p.id, true));
            list.add(gridEntry);
          }

          if (list.isEmpty) {
            // Handle case where server returned some profiles
            // but additional info fetching failed, so get next list of profiles.
            continue;
          }
        case Err():
          log.error("Profile page fetching failed");
          return const Err(null);
      }

      return Ok(list);
    }
  }
}

class ProfileEntryDownloader {
  final ApiManager api;
  final AccountDatabaseManager db;
  final MediaRepository media;
  final AccountBackgroundDatabaseManager accountBackgroundDb;
  ProfileEntryDownloader(this.media, this.accountBackgroundDb, this.db, this.api);

  /// Download profile entry, save to databases and return it.
  Future<Result<ProfileEntry, ProfileDownloadError>> download(AccountId accountId, {bool isMatch = false}) async {
    final currentData = await db.profileData((db) => db.getProfileEntry(accountId)).ok();
    final currentVersion = currentData?.version;
    final currentContentVersion = currentData?.contentVersion;

    final contentInfoResult = await api.media((api) => api.getProfileContentInfo(accountId.accountId, isMatch: isMatch, version: currentContentVersion?.version));
    switch (contentInfoResult) {
      case Ok(:final v):
        final contentVersion = v.version;
        if (contentVersion == null) {
          // Profile private (or account state might not be Normal)
          return Err(PrivateProfile());
        }
        final contentInfo = v.content;
        if (contentInfo != null) {
          await db.profileAction((db) => db.updateProfileContent(accountId, contentInfo, contentVersion));

          final primaryContentId = contentInfo.contentId0?.id;
          if (primaryContentId == null) {
            log.warning("Profile content info is missing");
            return Err(OtherProfileDownloadError());
          }

          final bytes = await ImageCacheData.getInstance().getImage(accountId, primaryContentId, isMatch: isMatch, media: media);
          if (bytes == null) {
            log.warning("Skipping one profile because image loading failed");
            return Err(OtherProfileDownloadError());
          }
        }
      case Err():
        return Err(OtherProfileDownloadError());
    }

    // Prevent displaying error when profile is made private while iterating
    final profileDetailsResult = await api
      .profileWrapper()
      .requestValue(logError: false, (api) => api.getProfile(accountId.accountId, isMatch: isMatch, version: currentVersion?.version));

    switch (profileDetailsResult) {
      case Ok(:final v):
        final version = v.version;
        if (version == null) {
          // Profile not accessible (or account state might not be Normal)
          return Err(PrivateProfile());
        }

        final profile = v.profile;
        if (profile != null) {
          // Sent profile version didn't match the latest profile version, so
          // server sent the latest profile.
          await accountBackgroundDb.profileAction((db) => db.updateProfileData(accountId, profile));
          await db.profileAction((db) => db.updateProfileData(accountId, profile, version, v.lastSeenTime));
        } else {
          // Current profile version is the latest.
          // Only updating last seen time to database is latest.
          await db.profileAction((db) => db.updateProfileLastSeenTime(accountId, v.lastSeenTime));
        }
      case Err(:final e):
        e.logError(log);
        return Err(OtherProfileDownloadError());
    }

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
