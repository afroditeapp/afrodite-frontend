import 'dart:async';

import 'package:app/data/profile/automatic_profile_search/automatic_profile_search_database_iterator.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:app/api/api_manager.dart';
import 'package:app/data/chat/matches_database_iterator.dart';
import 'package:app/data/chat/received_likes_database_iterator.dart';
import 'package:app/data/media_repository.dart';
import 'package:app/data/profile/profile_downloader.dart';
import 'package:app/data/general/iterator/profile_iterator.dart';
import 'package:app/data/profile/profile_list/profiles_database_iterator.dart';
import 'package:database/database.dart';
import 'package:app/database/account_background_database_manager.dart';
import 'package:app/database/account_database_manager.dart';
import 'package:utils/utils.dart';
import 'package:app/utils/result.dart';

final log = Logger("OnlineIterator");

class OnlineIterator extends IteratorType {
  int currentIndex = 0;
  final OnlineIteratorIo io;
  bool _resetServerIterator;
  final ServerConnectionManager connectionManager;
  final ApiManager api;
  final AccountDatabaseManager db;
  final ProfileEntryDownloader downloader;

  /// If [resetServerIterator] is true, the iterator will reset the
  /// server iterator to the beginning.
  OnlineIterator({
    bool resetServerIterator = false,
    required MediaRepository media,
    required this.io,
    required AccountBackgroundDatabaseManager accountBackgroundDb,
    required this.db,
    required this.connectionManager,
  }) : _resetServerIterator = resetServerIterator,
    downloader = ProfileEntryDownloader(media, accountBackgroundDb, db, connectionManager.api),
    api = connectionManager.api,
    super(true);

  @override
  void reset() {
    if (!_resetServerIterator) {
      /// Reset to use database iterator and then continue online profile
      /// iterating.
      io.resetDatabaseIterator();
    }
  }

  @override
  Future<Result<List<ProfileEntry>, void>> nextList() async {
    if (_resetServerIterator) {
      if (await connectionManager.waitUntilCurrentSessionConnects().isErr()) {
        log.error("Connection waiting failed");
        return const Err(null);
      }

      switch (await io.resetServerPaging()) {
        case Ok():
          _resetServerIterator = false;
        case Err():
          log.error("Profile paging reset failed");
          return const Err(null);
      }
    }

    // Handle case where iterator has been reseted in the middle
    // of online iteration. Get the beginning from the database.
    final iterator = io.databaseIterator;
    if (iterator != null) {
      switch (await iterator.nextList()) {
        case Ok(value: final list):
          if (list.isNotEmpty) {
            return Ok(list);
          } else {
            io.setDatabaseIteratorToNull();
          }
        case Err():
          log.error("Database iterator failed");
          return const Err(null);
      }
    }

    if (!await io.loadIteratorSessionIdFromDbAndReturnTrueIfItExists()) {
      log.error("No iterator session ID in database");
      return const Err(null);
    }

    final List<ProfileEntry> list = List.empty(growable: true);
    while (true) {
      if (await connectionManager.waitUntilCurrentSessionConnects().isErr()) {
        log.error("Connection waiting failed");
        return const Err(null);
      }
      switch (await io.nextServerPage()) {
        case Ok(value: final profiles):
          if (profiles.errorInvalidIteratorSessionId) {
            log.error("Current iterator session ID is invalid");
            return const Err(null);
          }

          if (profiles.profiles.isEmpty && profiles.basicProfiles.isEmpty) {
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

            await io.setDbVisibility(p.id, true);
            list.add(gridEntry);
          }

          for (final (i, p) in profiles.basicProfiles.indexed) {
            if (i + 1 <= profiles.basicProfilesNewLikesCount) {
              await db.profileData((db) => db.updateNewLikeInfoReceivedTimeToCurrentTime(p));
            }

            var entry = await db.profileData((db) => db.getProfileEntry(p)).ok();
            entry ??= await downloader.download(p).ok();

            final gridEntry = entry;
            if (gridEntry == null) {
              continue;
            }

            await io.setDbVisibility(p, true);
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

/// Interface for different server side iterators
abstract class OnlineIteratorIo {
  IteratorType? get databaseIterator;
  void resetDatabaseIterator();
  void setDatabaseIteratorToNull();

  Future<Result<void, void>> resetServerPaging();
  Future<bool> loadIteratorSessionIdFromDbAndReturnTrueIfItExists();
  /// Await loadIteratorSessionIdFromDbAndReturnTrueIfItExists before awaiting
  /// Future returned from this method.
  Future<Result<IteratorPage, void>> nextServerPage();
  Future<void> setDbVisibility(AccountId id, bool visibility);
}

class ProfileListOnlineIteratorIo extends OnlineIteratorIo {
  final AccountDatabaseManager db;
  final ApiManager api;
  IteratorType? iteratorValue;
  ProfileIteratorSessionId? currentSessionId;

  ProfileListOnlineIteratorIo(this.db, this.api);

  @override
  IteratorType? get databaseIterator => iteratorValue;

  @override
  void resetDatabaseIterator() {
    iteratorValue = ProfileListDatabaseIterator(db: db);
  }

  @override
  void setDatabaseIteratorToNull() {
    iteratorValue = null;
  }

  @override
  Future<Result<void, void>> resetServerPaging() async {
    switch (await api.profile((api) => api.postResetProfilePaging())) {
      case Ok(:final v):
        await db.accountAction((db) => db.updateProfileIteratorSessionId(v));
        await db.accountAction((db) => db.daoProfileStates.setProfileGridStatusList(null, false, clear: true));
        return const Ok(null);
      case Err():
        return const Err(null);
    }
  }

  @override
  Future<bool> loadIteratorSessionIdFromDbAndReturnTrueIfItExists() async {
    currentSessionId = await db.accountStreamSingle((db) => db.watchProfileSessionId()).ok();
    if (currentSessionId == null) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Future<Result<IteratorPage, void>> nextServerPage() async {
    final sessionId = currentSessionId;
    if (sessionId == null) {
      return const Err(null);
    }
    return await api.profile((api) => api.postGetNextProfilePage(sessionId))
      .mapOk((value) => IteratorPage(
        value.profiles,
        [],
        errorInvalidIteratorSessionId: value.errorInvalidIteratorSessionId
      ));
  }

  @override
  Future<void> setDbVisibility(AccountId id, bool visibility) async {
    await db.accountAction((db) => db.daoProfileStates.setProfileGridStatus(id, true));
  }
}

class IteratorPage {
  final bool errorInvalidIteratorSessionId;
  List<ProfileLink> profiles;
  List<AccountId> basicProfiles;
  final int basicProfilesNewLikesCount;

  IteratorPage(this.profiles, this.basicProfiles, {this.errorInvalidIteratorSessionId = false, this.basicProfilesNewLikesCount = 0});
}

class ReceivedLikesOnlineIteratorIo extends OnlineIteratorIo {
  final AccountDatabaseManager db;
  final AccountBackgroundDatabaseManager accountBackgroundDb;
  final ApiManager api;
  IteratorType? iteratorValue;
  ReceivedLikesIteratorSessionId? currentSessionId;

  ReceivedLikesOnlineIteratorIo(this.db, this.accountBackgroundDb, this.api);

  @override
  IteratorType? get databaseIterator => iteratorValue;

  @override
  void resetDatabaseIterator() {
    iteratorValue = ReceivedLikesDatabaseIterator(db: db);
  }

  @override
  void setDatabaseIteratorToNull() {
    iteratorValue = null;
  }

  @override
  Future<Result<void, void>> resetServerPaging() async {
    switch (await api.chat((api) => api.postResetReceivedLikesPaging())) {
      case Ok(:final v):
        await accountBackgroundDb.accountAction((db) => db.daoNewReceivedLikesAvailable.updateSyncVersionReceivedLikes(v.v, v.c));
        await db.accountAction((db) => db.daoProfileStates.setReceivedLikeGridStatusList(null, false, clear: true));
        await db.accountAction((db) => db.updateReceivedLikesIteratorSessionId(v.s));
        return const Ok(null);
      case Err():
        return const Err(null);
    }
  }

  @override
  Future<bool> loadIteratorSessionIdFromDbAndReturnTrueIfItExists() async {
    currentSessionId = await db.accountStreamSingle((db) => db.watchReceivedLikesSessionId()).ok();
    if (currentSessionId == null) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Future<Result<IteratorPage, void>> nextServerPage() async {
    final sessionId = currentSessionId;
    if (sessionId == null) {
      return const Err(null);
    }
    return await api.chat((api) => api.postGetNextReceivedLikesPage(sessionId))
      .mapOk((value) => IteratorPage(
        [],
        value.p,
        errorInvalidIteratorSessionId: value.errorInvalidIteratorSessionId,
        basicProfilesNewLikesCount: value.n.c,
      ));
  }

  @override
  Future<void> setDbVisibility(AccountId id, bool visibility) async {
    await db.accountAction((db) => db.daoProfileStates.setReceivedLikeStatus(id, true));
    await db.accountAction((db) => db.daoProfileStates.setReceivedLikeGridStatus(id, true));
  }
}


class MatchesOnlineIteratorIo extends OnlineIteratorIo {
  final AccountDatabaseManager db;
  final ApiManager api;
  IteratorType? iteratorValue;
  MatchesIteratorSessionId? currentSessionId;

  MatchesOnlineIteratorIo(this.db, this.api);

  @override
  IteratorType? get databaseIterator => iteratorValue;

  @override
  void resetDatabaseIterator() {
    iteratorValue = MatchesDatabaseIterator(db: db);
  }

  @override
  void setDatabaseIteratorToNull() {
    iteratorValue = null;
  }

  @override
  Future<Result<void, void>> resetServerPaging() async {
    switch (await api.chat((api) => api.postResetMatchesPaging())) {
      case Ok(:final v):
        await db.accountAction((db) => db.daoProfileStates.setMatchesGridStatusList(null, false, clear: true));
        await db.accountAction((db) => db.updateMatchesIteratorSessionId(v.s));
        return const Ok(null);
      case Err():
        return const Err(null);
    }
  }

  @override
  Future<bool> loadIteratorSessionIdFromDbAndReturnTrueIfItExists() async {
    currentSessionId = await db.accountStreamSingle((db) => db.watchMatchesSessionId()).ok();
    if (currentSessionId == null) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Future<Result<IteratorPage, void>> nextServerPage() async {
    final sessionId = currentSessionId;
    if (sessionId == null) {
      return const Err(null);
    }
    return await api.chat((api) => api.postGetNextMatchesPage(sessionId))
      .mapOk((value) => IteratorPage(
        [],
        value.p,
        errorInvalidIteratorSessionId: value.errorInvalidIteratorSessionId,
      ));
  }

  @override
  Future<void> setDbVisibility(AccountId id, bool visibility) async {
    await db.accountAction((db) => db.daoProfileStates.setMatchStatus(id, true));
    await db.accountAction((db) => db.daoProfileStates.setMatchesGridStatus(id, true));
  }
}

class AutomaticProfileSearchOnlineIteratorIo extends OnlineIteratorIo {
  final AccountDatabaseManager db;
  final ApiManager api;
  IteratorType? iteratorValue;
  AutomaticProfileSearchIteratorSessionId? currentSessionId;

  AutomaticProfileSearchOnlineIteratorIo(this.db, this.api);

  @override
  IteratorType? get databaseIterator => iteratorValue;

  @override
  void resetDatabaseIterator() {
    iteratorValue = AutomaticProfileSearchDatabaseIterator(db: db);
  }

  @override
  void setDatabaseIteratorToNull() {
    iteratorValue = null;
  }

  @override
  Future<Result<void, void>> resetServerPaging() async {
    switch (await api.profile((api) => api.postAutomaticProfileSearchResetProfilePaging())) {
      case Ok(:final v):
        await db.accountAction((db) => db.daoProfileStates.setAutomaticProfileSearchGridStatusList(null, false, clear: true));
        await db.accountAction((db) => db.updateAutomaticProfileSearchIteratorSessionId(v));
        return const Ok(null);
      case Err():
        return const Err(null);
    }
  }

  @override
  Future<bool> loadIteratorSessionIdFromDbAndReturnTrueIfItExists() async {
    currentSessionId = await db.accountStreamSingle((db) => db.watchAutomaticProfileSearchSessionId()).ok();
    if (currentSessionId == null) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Future<Result<IteratorPage, void>> nextServerPage() async {
    final sessionId = currentSessionId;
    if (sessionId == null) {
      return const Err(null);
    }
    return await api.profile((api) => api.postAutomaticProfileSearchGetNextProfilePage(sessionId))
      .mapOk((value) => IteratorPage(
        value.profiles,
        [],
        errorInvalidIteratorSessionId: value.errorInvalidIteratorSessionId,
      ));
  }

  @override
  Future<void> setDbVisibility(AccountId id, bool visibility) async {
    await db.accountAction((db) => db.daoProfileStates.setAutomaticProfileSearchGridStatus(id, true));
  }
}
