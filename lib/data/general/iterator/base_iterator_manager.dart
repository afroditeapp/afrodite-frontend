import 'dart:async';

import 'package:openapi/api.dart';
import 'package:app/data/chat/matches_database_iterator.dart';
import 'package:app/data/chat_repository.dart';
import 'package:app/data/general/iterator/profile_iterator.dart';
import 'package:app/data/general/iterator/online_iterator.dart';
import 'package:database/database.dart';
import 'package:app/database/account_database_manager.dart';
import 'package:app/utils/result.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseIteratorManager {
  final ChatRepository _chat;
  final AccountDatabaseManager _db;
  final AccountId _currentUser;
  BaseIteratorManager(this._chat, this._db, this._currentUser, {required IteratorType initialIterator}) :
    _currentIterator = initialIterator;

  IteratorType _currentIterator;

  final BehaviorSubject<bool> _loadingInProgress = BehaviorSubject.seeded(false);
  Stream<bool> get loadingInProgress => _loadingInProgress;

  OnlineIterator createOnlineIterator();

  void reset(bool clearDatabase) async {
    if (clearDatabase) {
      _currentIterator = createOnlineIterator();
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
        db: _db,
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
        final isBlocked = await _chat.isInSentBlocks(p.uuid);

        if (isBlocked || p.uuid == _currentUser) {
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
    await _loadingInProgress.firstWhere((e) => e == false);

    _loadingInProgress.add(true);
    final result = await _nextListImpl();
    _loadingInProgress.add(false);
    return result;
  }
}
