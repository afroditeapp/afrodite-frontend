import 'dart:async';

import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/api/api_manager.dart';
import 'package:pihka_frontend/data/image_cache.dart';
import 'package:pihka_frontend/data/media_repository.dart';
import 'package:database/database.dart';
import 'package:pihka_frontend/database/account_background_database_manager.dart';
import 'package:pihka_frontend/database/account_database_manager.dart';
import 'package:utils/utils.dart';
import 'package:pihka_frontend/utils/result.dart';

final log = Logger("ProfileEntryDownloader");

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

    final contentInfoResult = await api.media((api) => api.getProfileContentInfo(accountId.aid, isMatch: isMatch, version: currentContentVersion?.v));
    switch (contentInfoResult) {
      case Ok(:final v):
        final contentVersion = v.v;
        if (contentVersion == null) {
          // Profile private (or account state might not be Normal)
          return Err(PrivateProfile());
        }
        final contentInfo = v.c;
        if (contentInfo != null) {
          await db.profileAction((db) => db.updateProfileContent(accountId, contentInfo, contentVersion));

          final primaryContentId = contentInfo.c0?.cid;
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
      .requestValue(logError: false, (api) => api.getProfile(accountId.aid, isMatch: isMatch, v: currentVersion?.v));

    switch (profileDetailsResult) {
      case Ok(:final v):
        final version = v.v;
        if (version == null) {
          // Profile not accessible (or account state might not be Normal)
          return Err(PrivateProfile());
        }

        final profile = v.p;
        if (profile != null) {
          // Sent profile version didn't match the latest profile version, so
          // server sent the latest profile.
          await accountBackgroundDb.profileAction((db) => db.updateProfileData(accountId, profile));
          await db.profileAction((db) => db.updateProfileData(accountId, profile, version, v.lst));
        } else {
          // Current profile version is the latest.
          // Only updating last seen time to database is latest.
          await db.profileAction((db) => db.updateProfileLastSeenTime(accountId, v.lst));
        }
      case Err(:final e):
        e.logError(log);
        return Err(OtherProfileDownloadError());
    }

    final refreshTimeUpdateResult = await db.profileAction((db) => db.updateProfileDataRefreshTimeToCurrentTime(accountId));
    if (refreshTimeUpdateResult.isErr()) {
      log.error("Refresh time update failed");
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
