import 'dart:async';
import 'dart:convert';

import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/api/api_manager.dart';
import 'package:pihka_frontend/data/profile/profile_iterator.dart';
import 'package:pihka_frontend/data/profile/profile_list/database_iterator.dart';
import 'package:pihka_frontend/data/profile/profile_list/online_iterator.dart';
import 'package:pihka_frontend/data/utils.dart';
import 'package:pihka_frontend/database/favorite_profiles_database.dart';
import 'package:pihka_frontend/database/profile_database.dart';
import 'package:pihka_frontend/database/profile_list_database.dart';
import 'package:pihka_frontend/storage/kv.dart';
import 'package:pihka_frontend/utils.dart';


sealed class ProfileIteratorMode {}
class ModeFavorites extends ProfileIteratorMode {}
class ModePublicProfiles extends ProfileIteratorMode {
  final bool clearDatabase;
  ModePublicProfiles({required this.clearDatabase});
}

class ProfileIteratorManager {
  final ApiManager _api = ApiManager.getInstance();

  ProfileIteratorMode _currentMode =
    ModePublicProfiles(clearDatabase: false);
  IteratorType _currentIterator = DatabaseIterator();
  bool _pendingServerSideIteratorReset = false;

  void resetServerSideIteratorWhenItIsNeededNextTime() {
    if (_currentIterator is OnlineIterator) {
      _pendingServerSideIteratorReset = false;
      _currentIterator = OnlineIterator(firstIterationAfterLogin: true);
    } else {
      _pendingServerSideIteratorReset = true;
    }
  }

  Future<void> reset(ProfileIteratorMode mode) async {
    switch (mode) {
      case ModeFavorites(): {
        // TODO
      }
      case ModePublicProfiles(): {
        if (_pendingServerSideIteratorReset) {
          await ProfileListDatabase.getInstance().clearProfiles();
          _currentIterator = OnlineIterator(firstIterationAfterLogin: true);
          _pendingServerSideIteratorReset = false;
        } else if (mode.clearDatabase) {
          await ProfileListDatabase.getInstance().clearProfiles();
          _currentIterator = OnlineIterator(firstIterationAfterLogin: mode.clearDatabase);
        } else {
          _currentIterator.reset();
        }
      }
    }
    _currentMode = mode;
  }

  void resetToBeginning() {
    _currentIterator.reset();
  }

  Future<List<ProfileEntry>> nextList() async {
    switch (_currentMode) {
      case ModeFavorites(): {
        return [];
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
