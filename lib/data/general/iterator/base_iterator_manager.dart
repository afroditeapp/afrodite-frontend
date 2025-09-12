import 'dart:async';

import 'package:app/data/general/iterator/online_iterator.dart';
import 'package:openapi/api.dart';
import 'package:app/data/chat_repository.dart';
import 'package:database/database.dart';
import 'package:app/utils/result.dart';
import 'package:rxdart/rxdart.dart';

sealed class BaseIteratorManagerCmd<T> {
  final BehaviorSubject<T?> completed = BehaviorSubject.seeded(null);

  /// Can be called only once
  Future<T> waitCompletionAndDispose() async {
    final value = await completed.whereType<T>().first;
    await completed.close();
    return value;
  }
}

class Reset extends BaseIteratorManagerCmd<()> {
  final bool clearDatabase;
  Reset(this.clearDatabase);
}

class NextList extends BaseIteratorManagerCmd<Result<List<ProfileEntry>, ()>> {}

abstract class BaseIteratorManager implements UiProfileIterator {
  final ChatRepository _chat;
  final AccountId _currentUser;
  BaseIteratorManager(this._chat, this._currentUser, {required bool clearDatabase}) {
    _currentIterator = createNewIterator(clearDatabase);
  }

  final PublishSubject<BaseIteratorManagerCmd<Object>> _cmds = PublishSubject();
  StreamSubscription<void>? _cmdsSubscription;
  late OnlineIterator _currentIterator;

  OnlineIterator createNewIterator(bool clearDatabase);

  @override
  void init() {
    _cmdsSubscription = _listenCmds();
  }

  @override
  void dispose() async {
    await _cmdsSubscription?.cancel();
    await _cmds.close();
  }

  StreamSubscription<void> _listenCmds() {
    return _cmds
        .asyncMap((cmd) async {
          switch (cmd) {
            case Reset():
              if (cmd.clearDatabase) {
                _currentIterator = createNewIterator(cmd.clearDatabase);
              } else {
                _currentIterator.reset();
              }
              cmd.completed.add(());
            case NextList():
              cmd.completed.add(await _nextListImpl());
          }
        })
        .listen(null);
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
  void reset(bool clearDatabase) async {
    final cmd = Reset(clearDatabase);
    _cmds.add(cmd);
    await cmd.waitCompletionAndDispose();
  }

  @override
  Future<Result<List<ProfileEntry>, ()>> nextList() async {
    final cmd = NextList();
    _cmds.add(cmd);
    return await cmd.waitCompletionAndDispose();
  }
}

abstract class UiProfileIterator {
  void init();
  void dispose();
  void reset(bool clearDatabase);
  Future<Result<List<ProfileEntry>, ()>> nextList();
}
