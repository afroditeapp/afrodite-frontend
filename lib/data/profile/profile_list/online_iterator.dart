import 'dart:async';

import 'package:logging/logging.dart';
import 'package:pihka_frontend/api/api_manager.dart';
import 'package:pihka_frontend/data/media_repository.dart';
import 'package:pihka_frontend/data/profile/profile_downloader.dart';
import 'package:pihka_frontend/data/profile/profile_iterator.dart';
import 'package:pihka_frontend/data/profile/profile_list/database_iterator.dart';
import 'package:database/database.dart';
import 'package:pihka_frontend/database/account_background_database_manager.dart';
import 'package:pihka_frontend/database/account_database_manager.dart';
import 'package:utils/utils.dart';
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
