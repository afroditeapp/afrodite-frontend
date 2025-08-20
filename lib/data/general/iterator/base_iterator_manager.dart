import 'dart:async';

import 'package:openapi/api.dart';
import 'package:app/data/chat_repository.dart';
import 'package:app/data/general/iterator/profile_iterator.dart';
import 'package:database/database.dart';
import 'package:app/utils/result.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseIteratorManager implements UiProfileIterator {
  final ChatRepository _chat;
  final AccountId _currentUser;
  BaseIteratorManager(this._chat, this._currentUser, {required IteratorType initialIterator})
    : _currentIterator = initialIterator;

  IteratorType _currentIterator;

  final BehaviorSubject<bool> _loadingInProgress = BehaviorSubject.seeded(false);
  @override
  Stream<bool> get loadingInProgress => _loadingInProgress;

  IteratorType createClearDatabaseIterator();
  IteratorType createDatabaseIterator();

  @override
  void reset(bool clearDatabase) async {
    if (clearDatabase) {
      _currentIterator = createClearDatabaseIterator();
    } else {
      _currentIterator.reset();
    }
  }

  @override
  void resetToBeginning() {
    _currentIterator.reset();
  }

  Future<Result<List<ProfileEntry>, ()>> _nextListRaw() async {
    final List<ProfileEntry> nextList;
    switch (await _currentIterator.nextList()) {
      case Ok(:final value):
        {
          nextList = value;
          break;
        }
      case Err():
        {
          return const Err(());
        }
    }

    if (nextList.isEmpty && _currentIterator.clearsDatabase) {
      _currentIterator = createDatabaseIterator();
    }
    return Ok(nextList);
  }

  Future<Result<List<ProfileEntry>, ()>> _nextListImpl() async {
    while (true) {
      final List<ProfileEntry> list;
      switch (await _nextListRaw()) {
        case Ok(value: final profiles):
          list = profiles;
        case Err():
          return const Err(());
      }

      if (list.isEmpty) {
        return const Ok([]);
      }
      final toBeRemoved = <ProfileEntry>[];
      for (final p in list) {
        final isBlocked = await _chat.isInSentBlocks(p.accountId);

        if (isBlocked || p.accountId == _currentUser) {
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

  @override
  Future<Result<List<ProfileEntry>, ()>> nextList() async {
    await _loadingInProgress.firstWhere((e) => e == false);

    _loadingInProgress.add(true);
    final result = await _nextListImpl();
    _loadingInProgress.add(false);
    return result;
  }
}

abstract class UiProfileIterator {
  Stream<bool> get loadingInProgress;
  void reset(bool clearDatabase);
  void resetToBeginning();
  Future<Result<List<ProfileEntry>, ()>> nextList();
}
