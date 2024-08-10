import 'dart:async';

import 'package:async/async.dart' show StreamExtensions;
import 'package:pihka_frontend/data/chat_repository.dart';
import 'package:pihka_frontend/data/login_repository.dart';
import 'package:pihka_frontend/data/media_repository.dart';
import 'package:pihka_frontend/data/profile/profile_iterator.dart';
import 'package:pihka_frontend/data/profile/profile_list/database_iterator.dart';
import 'package:pihka_frontend/data/profile/profile_list/online_iterator.dart';
import 'package:database/database.dart';
import 'package:pihka_frontend/database/database_manager.dart';
import 'package:pihka_frontend/utils/result.dart';
import 'package:rxdart/rxdart.dart';

sealed class ProfileIteratorMode {}
class ModeFavorites extends ProfileIteratorMode {}
class ModePublicProfiles extends ProfileIteratorMode {
  final bool clearDatabase;
  ModePublicProfiles({required this.clearDatabase});
}

class ProfileIteratorManager {
  final DatabaseManager db = DatabaseManager.getInstance();
  final ChatRepository chat;
  final MediaRepository media;

  ProfileIteratorManager(this.chat, this.media);

  ProfileIteratorMode _currentMode =
    ModePublicProfiles(clearDatabase: false);
  IteratorType _currentIterator = DatabaseIterator();

  BehaviorSubject<bool> loadingInProgress = BehaviorSubject.seeded(false);

  void reset(ProfileIteratorMode mode) async {
    switch (mode) {
      case ModeFavorites(): {
        _currentIterator = DatabaseIterator(iterateFavorites: true);
      }
      case ModePublicProfiles(): {
        if (mode.clearDatabase) {

          _currentIterator = OnlineIterator(
            resetServerIterator: true,
            media: media,
          );
        } else {
          if (_currentMode is ModeFavorites) {
            _currentIterator = OnlineIterator(
              media: media,
            );
          } else {
            _currentIterator.reset();
          }
        }
      }
    }
    _currentMode = mode;
  }

  void resetToBeginning() {
    _currentIterator.reset();
  }

  void refresh() async {
    switch (_currentMode) {
      case ModeFavorites(): {
        reset(ModeFavorites());
      }
      case ModePublicProfiles(): {
        reset(ModePublicProfiles(clearDatabase: true));
      }
    }
  }

  Future<Result<List<ProfileEntry>, void>> _nextListRaw() async {
    switch (_currentMode) {
      case ModeFavorites(): {
        return await _currentIterator.nextList();
      }
      case ModePublicProfiles(): {
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
          _currentIterator = DatabaseIterator();
        }
        return Ok(nextList);
      }
    }
  }

  Future<Result<List<ProfileEntry>, void>> _nextListImpl() async {
    // TODO: cache this somewhere?
    final ownAccountId = await LoginRepository.getInstance().accountId.firstOrNull;

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
        final isBlocked = await chat.isInReceivedBlocks(p.uuid) ||
          await chat.isInSentBlocks(p.uuid);

        if (isBlocked || p.uuid == ownAccountId) {
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
