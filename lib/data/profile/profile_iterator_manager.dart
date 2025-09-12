import 'dart:async';

import 'package:openapi/api.dart';
import 'package:app/api/server_connection_manager.dart';
import 'package:app/data/chat_repository.dart';
import 'package:app/data/media_repository.dart';
import 'package:app/data/general/iterator/profile_iterator.dart';
import 'package:app/data/profile/profile_list/favorites_database_iterator.dart';
import 'package:app/data/profile/profile_list/profiles_database_iterator.dart';
import 'package:app/data/general/iterator/online_iterator.dart';
import 'package:database/database.dart';
import 'package:app/database/account_background_database_manager.dart';
import 'package:app/database/account_database_manager.dart';
import 'package:app/utils/result.dart';
import 'package:rxdart/rxdart.dart';

sealed class ProfileIteratorMode {}

class ModeFavorites extends ProfileIteratorMode {}

class ModePublicProfiles extends ProfileIteratorMode {
  final bool clearDatabase;
  ModePublicProfiles({required this.clearDatabase});
}

sealed class ProfileIteratorManagerCmd<T> {
  final BehaviorSubject<T?> completed = BehaviorSubject.seeded(null);

  /// Can be called only once
  Future<T> waitCompletionAndDispose() async {
    final value = await completed.whereType<T>().first;
    await completed.close();
    return value;
  }
}

class Reset extends ProfileIteratorManagerCmd<()> {
  final ProfileIteratorMode mode;
  Reset(this.mode);
}

class Refresh extends ProfileIteratorManagerCmd<()> {}

class NextList extends ProfileIteratorManagerCmd<Result<List<ProfileEntry>, ()>> {}

class ProfileIteratorManager {
  final AccountDatabaseManager db;
  final ChatRepository chat;
  final MediaRepository media;
  final AccountBackgroundDatabaseManager accountBackgroundDb;
  final ServerConnectionManager connectionManager;

  final AccountId currentUser;

  ProfileIteratorManager(
    this.chat,
    this.media,
    this.accountBackgroundDb,
    this.db,
    this.connectionManager,
    this.currentUser,
  ) : _currentIterator = ProfileListDatabaseIterator(db: db);

  ProfileIteratorMode _currentMode = ModePublicProfiles(clearDatabase: false);
  IteratorType _currentIterator;

  /// Server might return the same profile multiple times because
  /// the profile index data structure on server is not locked when modifying it
  /// or the profile iterator is waiting for next profile query and user
  /// moves profile location to a location from where the iterator can return it.
  final Set<AccountId> _duplicateAccountsPreventer = {};

  final PublishSubject<ProfileIteratorManagerCmd<Object>> _cmds = PublishSubject();
  StreamSubscription<void>? _cmdsSubscription;

  void init() {
    _cmdsSubscription = _listenCmds();
  }

  void dispose() async {
    await _cmdsSubscription?.cancel();
    await _cmds.close();
  }

  StreamSubscription<void> _listenCmds() {
    return _cmds
        .asyncMap((cmd) async {
          switch (cmd) {
            case Reset():
              _reset(cmd.mode);
              cmd.completed.add(());
            case Refresh():
              _refresh();
              cmd.completed.add(());
            case NextList():
              cmd.completed.add(await _nextListImpl());
          }
        })
        .listen(null);
  }

  void _reset(ProfileIteratorMode mode) {
    _duplicateAccountsPreventer.clear();

    switch (mode) {
      case ModeFavorites():
        {
          _currentIterator = FavoritesDatabaseIterator(db: db);
        }
      case ModePublicProfiles():
        {
          if (mode.clearDatabase) {
            _currentIterator = OnlineIterator(
              resetServerIterator: true,
              media: media,
              io: ProfileListOnlineIteratorIo(db, connectionManager),
              accountBackgroundDb: accountBackgroundDb,
              db: db,
              connectionManager: connectionManager,
            );
          } else {
            if (_currentMode is ModeFavorites) {
              _currentIterator = OnlineIterator(
                media: media,
                io: ProfileListOnlineIteratorIo(db, connectionManager),
                accountBackgroundDb: accountBackgroundDb,
                db: db,
                connectionManager: connectionManager,
              );
            } else {
              _currentIterator.reset();
            }
          }
        }
    }
    _currentMode = mode;
  }

  void _refresh() {
    switch (_currentMode) {
      case ModeFavorites():
        {
          _reset(ModeFavorites());
        }
      case ModePublicProfiles():
        {
          _reset(ModePublicProfiles(clearDatabase: true));
        }
    }
  }

  Future<Result<List<ProfileEntry>, ()>> _nextListRaw() async {
    switch (_currentMode) {
      case ModeFavorites():
        {
          return await _currentIterator.nextList();
        }
      case ModePublicProfiles():
        {
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

          if (nextList.isEmpty && _currentIterator is OnlineIterator) {
            _currentIterator = ProfileListDatabaseIterator(db: db);
          }
          return Ok(nextList);
        }
    }
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
        final isBlocked = await chat.isInSentBlocks(p.accountId);
        final alreadyReturned = _duplicateAccountsPreventer.contains(p.accountId);
        final invalidPrimaryContent =
            p.content.firstOrNull?.primary != true || p.content.firstOrNull?.accepted != true;

        if (isBlocked || alreadyReturned || p.accountId == currentUser || invalidPrimaryContent) {
          toBeRemoved.add(p);
        } else {
          _duplicateAccountsPreventer.add(p.accountId);
        }
      }
      list.removeWhere((element) => toBeRemoved.contains(element));
      if (list.isEmpty) {
        continue;
      }
      return Ok(list);
    }
  }

  void reset(ProfileIteratorMode mode) async {
    final cmd = Reset(mode);
    _cmds.add(cmd);
    await cmd.waitCompletionAndDispose();
  }

  void refresh() async {
    final cmd = Refresh();
    _cmds.add(cmd);
    await cmd.waitCompletionAndDispose();
  }

  Future<Result<List<ProfileEntry>, ()>> nextList() async {
    final cmd = NextList();
    _cmds.add(cmd);
    return await cmd.waitCompletionAndDispose();
  }
}
