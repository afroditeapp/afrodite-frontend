import 'dart:async';

import 'package:pihka_frontend/api/api_manager.dart';
import 'package:pihka_frontend/data/profile/profile_iterator.dart';
import 'package:pihka_frontend/data/profile/profile_list/database_iterator.dart';
import 'package:pihka_frontend/data/profile/profile_list/online_iterator.dart';
import 'package:database/database.dart';
import 'package:pihka_frontend/database/database_manager.dart';
import 'package:pihka_frontend/utils/result.dart';

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

  void reset(ProfileIteratorMode mode) async {
    switch (mode) {
      case ModeFavorites(): {
        _currentIterator = DatabaseIterator(iterateFavorites: true);
      }
      case ModePublicProfiles(): {
        if (mode.clearDatabase) {

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

  Future<Result<List<ProfileEntry>, void>> nextList() async {
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
}
