import 'dart:async';

import 'package:openapi/api.dart';
import 'package:pihka_frontend/api/api_manager.dart';
import 'package:pihka_frontend/data/chat/matches_database_iterator.dart';
import 'package:pihka_frontend/data/chat_repository.dart';
import 'package:pihka_frontend/data/media_repository.dart';
import 'package:pihka_frontend/data/general/iterator/profile_iterator.dart';
import 'package:pihka_frontend/data/general/iterator/online_iterator.dart';
import 'package:database/database.dart';
import 'package:pihka_frontend/database/account_background_database_manager.dart';
import 'package:pihka_frontend/database/account_database_manager.dart';
import 'package:pihka_frontend/utils/result.dart';
import 'package:rxdart/rxdart.dart';

class MatchesIteratorManager {
  final AccountDatabaseManager db;
  final ChatRepository chat;
  final MediaRepository media;
  final AccountBackgroundDatabaseManager accountBackgroundDb;
  final ServerConnectionManager connectionManager;

  final AccountId currentUser;

  MatchesIteratorManager(this.chat, this.media, this.accountBackgroundDb, this.db, this.connectionManager, this.currentUser) :
    _currentIterator = MatchesDatabaseIterator(db: db);

  IteratorType _currentIterator;

  BehaviorSubject<bool> loadingInProgress = BehaviorSubject.seeded(false);

  void reset(bool clearDatabase) async {
    if (clearDatabase) {
      _currentIterator = OnlineIterator(
        resetServerIterator: true,
        media: media,
        io: MatchesOnlineIteratorIo(db, connectionManager.api),
        accountBackgroundDb: accountBackgroundDb,
        db: db,
        connectionManager: connectionManager,
      );
    } else {
      _currentIterator.reset();
    }
  }

  void resetToBeginning() {
    _currentIterator.reset();
  }

  void refresh() async {
    reset(true);
  }

  Future<Result<List<ProfileEntry>, void>> _nextListRaw() async {
    final List<ProfileEntry> nextList;
    switch (await _currentIterator.nextList()) {
      case Ok(:final value): {
        nextList = value;
        break;
      }
      case Err(): {
        return const Err(null);
      }
    }

    if (nextList.isEmpty && _currentIterator is OnlineIterator) {
      _currentIterator = MatchesDatabaseIterator(
        db: db,
      );
    }
    return Ok(nextList);
  }

  Future<Result<List<ProfileEntry>, void>> _nextListImpl() async {
    // TODO: Perhaps move to iterator when filters are implemented?
    while (true) {
      final List<ProfileEntry> list;
      switch (await _nextListRaw()) {
        case Ok(value: final profiles):
          list = profiles;
          break;
        case Err():
          return const Err(null);
      }

      if (list.isEmpty) {
        return const Ok([]);
      }
      final toBeRemoved = <ProfileEntry>[];
      for (final p in list) {
        final isBlocked = await chat.isInSentBlocks(p.uuid);

        if (isBlocked || p.uuid == currentUser) {
          toBeRemoved.add(p);
        }
      }
      list.removeWhere((element) => toBeRemoved.contains(element));
      if (list.isEmpty) {
        continue;
      }
      return Ok(list);
    }
  }

  Future<Result<List<ProfileEntry>, void>> nextList() async {
    await loadingInProgress.firstWhere((e) => e == false);

    loadingInProgress.add(true);
    final result = await _nextListImpl();
    loadingInProgress.add(false);
    return result;
  }
}
