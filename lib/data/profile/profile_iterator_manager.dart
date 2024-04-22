import 'dart:async';

import 'package:pihka_frontend/api/api_manager.dart';
import 'package:pihka_frontend/data/profile/profile_iterator.dart';
import 'package:pihka_frontend/data/profile/profile_list/database_iterator.dart';
import 'package:pihka_frontend/data/profile/profile_list/online_iterator.dart';
import 'package:database/database.dart';
import 'package:pihka_frontend/database/database_manager.dart';

sealed class ProfileIteratorMode {}
class ModeFavorites extends ProfileIteratorMode {}
class ModePublicProfiles extends ProfileIteratorMode {
  final bool clearDatabase;
  final bool waitConnection;
  ModePublicProfiles({required this.clearDatabase, this.waitConnection = false});
}

class ProfileIteratorManager {
  final ApiManager _api = ApiManager.getInstance();
  final DatabaseManager db = DatabaseManager.getInstance();

  ProfileIteratorMode _currentMode =
    ModePublicProfiles(clearDatabase: false);
  IteratorType _currentIterator = DatabaseIterator();
  bool _pendingServerSideIteratorReset = false;

  void resetServerSideIteratorWhenItIsNeededNextTime() {
    if (_currentIterator is OnlineIterator) {
      _pendingServerSideIteratorReset = false;
      _currentIterator = OnlineIterator(resetServerIterator: true);
    } else {
      _pendingServerSideIteratorReset = true;
    }
  }

  Future<void> reset(ProfileIteratorMode mode) async {
    switch (mode) {
      case ModeFavorites(): {
        _currentIterator = DatabaseIterator(iterateFavorites: true);
      }
      case ModePublicProfiles(): {
        if (_pendingServerSideIteratorReset) {
          await db.profileAction((db) => db.setProfileGridStatusList(null, false, clear: true));
          _currentIterator = OnlineIterator(
            resetServerIterator: true,
            waitConnectionOnce: mode.waitConnection,
          );
          _pendingServerSideIteratorReset = false;
        } else if (mode.clearDatabase) {
          await db.profileAction((db) => db.setProfileGridStatusList(null, false, clear: true));
          _currentIterator = OnlineIterator(
            resetServerIterator: true,
            waitConnectionOnce: mode.waitConnection,
          );
        } else {
          if (_currentMode is ModeFavorites) {
            _currentIterator = OnlineIterator(
              waitConnectionOnce: mode.waitConnection,
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

  Future<void> refresh() async {
    switch (_currentMode) {
      case ModeFavorites(): {
        await reset(ModeFavorites());
      }
      case ModePublicProfiles(): {
        await reset(ModePublicProfiles(clearDatabase: true));
      }
    }
  }

  Future<List<ProfileEntry>> nextList() async {
    switch (_currentMode) {
      case ModeFavorites(): {
        return await _currentIterator.nextList();
      }
      case ModePublicProfiles(): {
        final nextList = await _currentIterator.nextList();

        if (nextList.isEmpty && _currentIterator is OnlineIterator) {
          _currentIterator = DatabaseIterator();
        }
        return nextList;
      }
    }
  }
}
