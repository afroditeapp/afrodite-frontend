import 'dart:async';

import 'package:app/data/profile/automatic_profile_search/automatic_profile_search_database_iterator.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:app/api/server_connection_manager.dart';
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

final _log = Logger("OnlineIterator");

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
       downloader = ProfileEntryDownloader(media, accountBackgroundDb, db, connectionManager),
       api = connectionManager;

  @override
  void reset() {
    if (!_resetServerIterator) {
      /// Reset to use database iterator and then continue online profile
      /// iterating.
      io.resetDatabaseIterator();
    }
  }

  @override
  Future<Result<List<ProfileEntry>, ()>> nextList() async {
    if (_resetServerIterator) {
      if (await connectionManager.waitUntilCurrentSessionConnects().isErr()) {
        _log.error("Connection waiting failed");
        return const Err(());
      }

      switch (await io.resetServerPaging()) {
        case Ok():
          _resetServerIterator = false;
        case Err():
          _log.error("Profile paging reset failed");
          return const Err(());
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
          _log.error("Database iterator failed");
          return const Err(());
      }
    }

    if (!await io.loadIteratorSessionIdFromDbAndReturnTrueIfItExists()) {
      _log.error("No iterator session ID in database");
      return const Err(());
    }

    final List<ProfileEntry> list = List.empty(growable: true);
    while (true) {
      if (await connectionManager.waitUntilCurrentSessionConnects().isErr()) {
        _log.error("Connection waiting failed");
        return const Err(());
      }
      switch (await io.nextServerPage()) {
        case Ok(value: final profiles):
          if (profiles.errorInvalidIteratorSessionId) {
            _log.error("Current iterator session ID is invalid");
            return const Err(());
          }

          if (profiles.profiles.isEmpty) {
            return const Ok([]);
          }

          for (final p in profiles.profiles) {
            var entry = await db.accountData((db) => db.profile.getProfileEntry(p.a)).ok();
            final currentVersion = entry?.version;
            final currentContentVersion = entry?.contentVersion;

            if (currentVersion == p.p && currentContentVersion == p.c) {
              // No data changes, download can be skipped, but
              // update last seen time.
              await db.accountAction(
                (db) => db.profile.updateProfileLastSeenTimeIfNeeded(p.a, p.l),
              );
            } else {
              entry = await downloader.download(p.a).ok();
            }

            final gridEntry = entry;
            if (gridEntry == null) {
              continue;
            }

            await io.setDbVisibility(p.a, true);
            list.add(gridEntry);
          }

          if (list.isEmpty) {
            // Handle case where server returned some profiles
            // but additional info fetching failed, so get next list of profiles.
            continue;
          }
        case Err():
          _log.error("Profile page fetching failed");
          return const Err(());
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

  Future<Result<(), ()>> resetServerPaging();
  Future<bool> loadIteratorSessionIdFromDbAndReturnTrueIfItExists();

  /// Await loadIteratorSessionIdFromDbAndReturnTrueIfItExists before awaiting
  /// Future returned from this method.
  Future<Result<IteratorPage, ()>> nextServerPage();
  Future<void> setDbVisibility(AccountId id, bool visibility);
}

/// Saving iterator session ID to database is not needed the as profiles
/// are loaded from server every time when matches screen opens.
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
  Future<Result<(), ()>> resetServerPaging() async {
    switch (await api.profile((api) => api.postResetProfilePaging())) {
      case Ok(:final v):
        await db.accountAction(
          (db) => db.profile.setProfileGridStatusList(null, false, clear: true),
        );
        currentSessionId = v;
        return const Ok(());
      case Err():
        return const Err(());
    }
  }

  @override
  Future<bool> loadIteratorSessionIdFromDbAndReturnTrueIfItExists() async {
    return currentSessionId != null;
  }

  @override
  Future<Result<IteratorPage, ()>> nextServerPage() async {
    final sessionId = currentSessionId;
    if (sessionId == null) {
      return const Err(());
    }
    return await api
        .profile((api) => api.postGetNextProfilePage(sessionId))
        .mapOk(
          (value) => IteratorPage(
            value.profiles.map((v) => ProfileLink(a: v.a, p: v.p, c: v.c, l: v.l)),
            errorInvalidIteratorSessionId: value.errorInvalidIteratorSessionId,
          ),
        )
        .emptyErr();
  }

  @override
  Future<void> setDbVisibility(AccountId id, bool visibility) async {
    await db.accountAction((db) => db.profile.setProfileGridStatus(id, true));
  }
}

class IteratorPage {
  final bool errorInvalidIteratorSessionId;
  final Iterable<ProfileLink> profiles;

  IteratorPage(this.profiles, {this.errorInvalidIteratorSessionId = false});
}

class ReceivedLikesOnlineIteratorIo extends OnlineIteratorIo {
  final AccountDatabaseManager db;
  final AccountBackgroundDatabaseManager accountBackgroundDb;
  final ApiManager api;
  IteratorType? iteratorValue;
  ReceivedLikesIteratorState? currentState;

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
  Future<Result<(), ()>> resetServerPaging() async {
    switch (await api.chat((api) => api.postResetReceivedLikesPaging())) {
      case Ok(:final v):
        await db.accountAction(
          (db) => db.profile.setReceivedLikeGridStatusList(null, false, clear: true),
        );
        await db.accountAction((db) => db.common.updateReceivedLikesIteratorState(v.s));
        return const Ok(());
      case Err():
        return const Err(());
    }
  }

  @override
  Future<bool> loadIteratorSessionIdFromDbAndReturnTrueIfItExists() async {
    currentState = await db
        .accountStreamSingle((db) => db.common.watchReceivedLikesIteratorState())
        .ok();
    if (currentState == null) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Future<Result<IteratorPage, ()>> nextServerPage() async {
    final state = currentState;
    if (state == null) {
      return const Err(());
    }
    if (state.page == -1) {
      return Ok(IteratorPage([]));
    }
    final r = await api.chat((api) => api.postGetReceivedLikesPage(state)).emptyErr();

    switch (r) {
      case Ok():
        final List<(AccountId, ReceivedLikeId)> newLikes = [];
        for (final l in r.v.l) {
          final receivedLikeId = l.notViewed;
          if (receivedLikeId != null) {
            newLikes.add((l.p.a, receivedLikeId));
          }
        }
        if (newLikes.isNotEmpty) {
          await db
              .accountDataWrite(
                (db) => db.profile.updateNewLikeInfoReceivedTimeToCurrentTime(
                  newLikes.map((v) => v.$1),
                ),
              )
              .andThen(
                (_) => api.chatAction(
                  (api) => api.postMarkReceivedLikesViewed(
                    MarkReceivedLikesViewed(v: newLikes.map((v) => v.$2).toList()),
                  ),
                ),
              );
        }

        if (r.v.l.isEmpty) {
          state.page = -1;
        } else {
          state.page += 1;
        }
        await db.accountAction(
          (db) => db.common.updateReceivedLikesIteratorStatePageValue(state.page),
        );

        return Ok(IteratorPage(r.v.l.map((v) => v.p)));
      case Err():
        return Err(());
    }
  }

  @override
  Future<void> setDbVisibility(AccountId id, bool visibility) async {
    await db.accountAction((db) => db.profile.setReceivedLikeStatus(id, true));
    await db.accountAction((db) => db.profile.setReceivedLikeGridStatus(id, true));
  }
}

/// Saving iterator state to database is not needed the as matches
/// are loaded from server every time when matches screen opens.
class MatchesOnlineIteratorIo extends OnlineIteratorIo {
  final AccountDatabaseManager db;
  final ApiManager api;
  IteratorType? iteratorValue;
  MatchesIteratorState? currentState;

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
  Future<Result<(), ()>> resetServerPaging() async {
    switch (await api.chat((api) => api.getInitialMatchesIteratorState())) {
      case Ok(:final v):
        await db.accountAction(
          (db) => db.profile.setMatchesGridStatusList(null, false, clear: true),
        );
        currentState = v;
        return const Ok(());
      case Err():
        return const Err(());
    }
  }

  @override
  Future<bool> loadIteratorSessionIdFromDbAndReturnTrueIfItExists() async {
    return currentState != null;
  }

  @override
  Future<Result<IteratorPage, ()>> nextServerPage() async {
    final state = currentState;
    if (state == null) {
      return const Err(());
    }
    final r = await api
        .chat((api) => api.postGetMatchesIteratorPage(state))
        .mapOk((value) => IteratorPage(value.p))
        .emptyErr();
    if (r.isOk()) {
      state.page += 1;
    }
    return r;
  }

  @override
  Future<void> setDbVisibility(AccountId id, bool visibility) async {
    await db.accountAction((db) => db.profile.setMatchStatus(id, true));
    await db.accountAction((db) => db.profile.setMatchesGridStatus(id, true));
  }
}

/// Saving iterator session ID to database is not needed the as profiles
/// are loaded from server every time when matches screen opens.
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
  Future<Result<(), ()>> resetServerPaging() async {
    switch (await api.profile((api) => api.postAutomaticProfileSearchResetProfilePaging())) {
      case Ok(:final v):
        await db.accountAction(
          (db) => db.profile.setAutomaticProfileSearchGridStatusList(null, false, clear: true),
        );
        currentSessionId = v;
        return const Ok(());
      case Err():
        return const Err(());
    }
  }

  @override
  Future<bool> loadIteratorSessionIdFromDbAndReturnTrueIfItExists() async {
    return currentSessionId != null;
  }

  @override
  Future<Result<IteratorPage, ()>> nextServerPage() async {
    final sessionId = currentSessionId;
    if (sessionId == null) {
      return const Err(());
    }
    return await api
        .profile((api) => api.postAutomaticProfileSearchGetNextProfilePage(sessionId))
        .mapOk(
          (value) => IteratorPage(
            value.profiles.map((v) => ProfileLink(a: v.a, p: v.p, c: v.c, l: v.l)),
            errorInvalidIteratorSessionId: value.errorInvalidIteratorSessionId,
          ),
        )
        .emptyErr();
  }

  @override
  Future<void> setDbVisibility(AccountId id, bool visibility) async {
    await db.accountAction((db) => db.profile.setAutomaticProfileSearchGridStatus(id, true));
  }
}
