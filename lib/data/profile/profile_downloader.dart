import 'dart:async';

import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:app/api/server_connection_manager.dart';
import 'package:app/data/image_cache.dart';
import 'package:app/data/media_repository.dart';
import 'package:database/database.dart';
import 'package:app/database/account_background_database_manager.dart';
import 'package:app/database/account_database_manager.dart';
import 'package:utils/utils.dart';
import 'package:app/utils/result.dart';

final _log = Logger("ProfileEntryDownloader");

// TODO(prod): Save info is profile private and limit profile
//             downloads to once per day for private proifles.

class ProfileEntryDownloader {
  final ApiManager api;
  final AccountDatabaseManager db;
  final MediaRepository media;
  final AccountBackgroundDatabaseManager accountBackgroundDb;
  ProfileEntryDownloader(this.media, this.accountBackgroundDb, this.db, this.api);

  /// Download profile entry, save to databases and return it.
  Future<Result<ProfileEntry, ProfileDownloadError>> download(
    AccountId accountId, {
    bool isMatch = false,
  }) async {
    final currentData = await db.accountData((db) => db.profile.getProfileEntry(accountId)).ok();
    final currentVersion = currentData?.version;
    final currentContentVersion = currentData?.contentVersion;

    final contentInfoResult = await api.media(
      (api) => api.getProfileContentInfo(
        accountId.aid,
        isMatch: isMatch,
        version: currentContentVersion?.v,
      ),
    );
    switch (contentInfoResult) {
      case Ok(:final v):
        final contentVersion = v.v;
        if (contentVersion == null) {
          // Profile private (or account state might not be Normal)
          return Err(PrivateProfile());
        }
        final contentInfo = v.c;
        if (contentInfo != null) {
          await db.accountAction(
            (db) => db.profile.updateProfileContent(accountId, contentInfo, contentVersion),
          );

          final primaryContentId = contentInfo.c.firstOrNull?.cid;
          if (primaryContentId == null) {
            _log.warning("Profile content info is missing");
            return Err(OtherProfileDownloadError());
          }

          final bytes = await ImageCacheData.getInstance().getImage(
            accountId,
            primaryContentId,
            isMatch: isMatch,
            media: media,
          );
          if (bytes == null) {
            _log.warning("Skipping one profile because image loading failed");
            return Err(OtherProfileDownloadError());
          }
        }
      case Err():
        return Err(OtherProfileDownloadError());
    }

    // Prevent displaying error when profile is made private while iterating
    final profileDetailsResult = await api.profileWrapper().requestValue(
      logError: false,
      (api) => api.getProfile(accountId.aid, isMatch: isMatch, v: currentVersion?.v),
    );

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
          await accountBackgroundDb.accountAction(
            (db) => db.profile.updateProfileData(accountId, profile),
          );
          await db.accountAction(
            (db) => db.profile.updateProfileData(accountId, profile, version, v.lst),
          );
        } else {
          // Current profile version is the latest.
          // Only updating last seen time to database is latest.
          await db.accountAction(
            (db) => db.profile.updateProfileLastSeenTimeIfNeeded(accountId, v.lst),
          );
        }
      case Err(:final e):
        e.logError(_log);
        return Err(OtherProfileDownloadError());
    }

    final refreshTimeUpdateResult = await db.accountAction(
      (db) => db.profile.updateProfileDataRefreshTimeToCurrentTime(accountId),
    );
    if (refreshTimeUpdateResult.isErr()) {
      _log.error("Refresh time update failed");
      return Err(OtherProfileDownloadError());
    }

    final dataEntry = await db.accountData((db) => db.profile.getProfileEntry(accountId)).ok();

    if (dataEntry == null) {
      _log.warning("Storing profile data to database failed");
      return Err(OtherProfileDownloadError());
    }

    return Ok(dataEntry);
  }
}

sealed class ProfileDownloadError {}

class PrivateProfile extends ProfileDownloadError {}

class OtherProfileDownloadError extends ProfileDownloadError {}
