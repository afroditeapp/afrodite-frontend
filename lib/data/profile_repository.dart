import 'dart:async';

import 'package:async/async.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/api/api_manager.dart';
import 'package:pihka_frontend/data/chat_repository.dart';
import 'package:pihka_frontend/data/login_repository.dart';
import 'package:pihka_frontend/data/profile/profile_iterator_manager.dart';
import 'package:pihka_frontend/data/profile/profile_list/online_iterator.dart';
import 'package:pihka_frontend/data/utils.dart';
import 'package:pihka_frontend/database/account_database.dart';
import 'package:pihka_frontend/database/database_manager.dart';
import 'package:pihka_frontend/database/profile_entry.dart';
import 'package:pihka_frontend/utils/result.dart';
import 'package:rxdart/rxdart.dart';

var log = Logger("ProfileRepository");

class ProfileRepository extends DataRepository {
  ProfileRepository._private();
  static final _instance = ProfileRepository._private();
  factory ProfileRepository.getInstance() {
    return _instance;
  }

  final DatabaseManager db = DatabaseManager.getInstance();
  final ApiManager _api = ApiManager.getInstance();
  final ProfileIteratorManager mainProfilesViewIterator = ProfileIteratorManager();

  final PublishSubject<ProfileChange> _profileChangesRelay = PublishSubject();
  void sendProfileChange(ProfileChange change) {
    _profileChangesRelay.add(change);
  }
  Stream<ProfileChange> get profileChanges => _profileChangesRelay;

  Stream<Location> get location => db
    .accountStreamOrDefault(
      (db) => db.watchProfileLocation(),
      Location(latitude: 0.0, longitude: 0.0),
    );

  Stream<AvailableProfileAttributes?> get profileAttributes => db
    .accountStream(
      (db) => db.watchAvailableProfileAttributes(),
    );

  @override
  Future<void> init() async {
    final showOnlyFavorites = await getFilterFavoriteProfilesValue();
    await changeProfileFilteringSettings(showOnlyFavorites);
  }

  @override
  Future<void> onLogin() async {
    // Reset profile iterator
    await mainProfilesViewIterator.reset(ModePublicProfiles(
      clearDatabase: true
    ));

    _api.state
      .firstWhere((element) => element == ApiManagerState.connected)
      .then((value) async {
        // TODO: Perhps client should track these operations and retry
        // these if needed.

        // Download current location, so map will be positioned correctly.
        final location = await _api.profile((api) => api.getLocation()).ok();
        if (location != null) {
          await db.accountAction(
            (db) => db.updateProfileLocation(
              latitude: location.latitude,
              longitude: location.longitude,
            ),
          );
        }

        // Download current favorites.
        final favorites = await _api.profile((api) => api.getFavoriteProfiles()).ok();
        if (favorites != null) {
          for (final profile in favorites.profiles) {
            await db.profileAction((db) => db.setFavoriteStatus(profile, true));
          }
        }
      })
      .ignore();
  }

  @override
  Future<void> onLogout() async {
    // await ProfileListDatabase.getInstance().clearProfiles();
    // await db.accountAction((db) => db.daoFavoriteProfiles.clear());
    // await ProfileDatabase.getInstance().clearProfiles();
    await mainProfilesViewIterator.reset(ModePublicProfiles(
      clearDatabase: true
    ));
    await db.accountAction(
      (db) => db.updateProfileFilterFavorites(false),
    );
  }

  Future<bool> updateLocation(Location location) async {
    final requestSuccessful = await _api.profileAction((api) => api.putLocation(location)).isOk();
    if (requestSuccessful) {
      await db.accountAction(
        (db) => db.updateProfileLocation(
          latitude: location.latitude,
          longitude: location.longitude,
        ),
      );
      mainProfilesViewIterator.resetServerSideIteratorWhenItIsNeededNextTime();
    }
    return requestSuccessful;
  }

  Future<ProfileEntry?> getProfile(AccountId id, {bool cache = false}) async {
    // TODO: perhaps more detailed error message, so that changes from public to
    // private profile can be handled.

    if (cache) {
      final profile = await db.profileData((db) => db.getProfileEntry(id));
      if (profile != null) {
        return profile;
      }
    }

    final entry = await ProfileEntryDownloader().download(id).ok();
    return entry;
  }

  /// Get cached (if available) and then latest profile (if available).
  Stream<GetProfileResult> getProfileStream(AccountId id) async* {
    // TODO: perhaps more detailed error message, so that changes from public to
    // private profile can be handled.

    final profile = await db.profileData((db) => db.getProfileEntry(id));
    if (profile != null) {
      yield GetProfileSuccess(profile);
    }


    final result = await ProfileEntryDownloader().download(id);
    switch (result) {
      case Ok(:final v):
        yield GetProfileSuccess(v);
      case Err(:final e):
        switch (e) {
          case PrivateProfile():
            // Accessing profile failed (not public or something else)
            await db.profileAction((db) => db.removeProfileData(id));
            await db.profileAction((db) => db.setProfileGridStatus(id, false));
            // Favorites are not changed even if profile will become private
            yield GetProfileDoesNotExist();
            _profileChangesRelay.add(
              ProfileNowPrivate(id)
            );
          case OtherProfileDownloadError():
            yield GetProfileFailed();
        }
    }
  }

  /// Returns true if profile update was successful
  Future<bool> updateProfile(ProfileUpdate profileUpdate) async {
    final result = await _api.profileAction((api) => api.postProfile(profileUpdate));
    return result.isOk();
  }

  Future<void> refreshProfileIterator() async {
    await mainProfilesViewIterator.refresh();
  }

  void resetIteratorToBeginning() {
    mainProfilesViewIterator.resetToBeginning();
  }

  Future<List<ProfileEntry>> nextList() async {
    // TODO: cache this somewhere?
    final ownAccountId = await LoginRepository.getInstance().accountId.firstOrNull;

    // TODO: Perhaps move to iterator when filters are implemented?
    while (true) {
      final list = await mainProfilesViewIterator.nextList();
      if (list.isEmpty) {
        return [];
      }
      final toBeRemoved = <ProfileEntry>[];
      for (final p in list) {
        final isBlocked = await ChatRepository.getInstance().isInReceivedBlocks(p.uuid) ||
          await ChatRepository.getInstance().isInSentBlocks(p.uuid);

        if (isBlocked || p.uuid == ownAccountId) {
          toBeRemoved.add(p);
        }
      }
      list.removeWhere((element) => toBeRemoved.contains(element));
      if (list.isEmpty) {
        continue;
      }
      return list;
    }
  }

  Future<bool> isInFavorites(AccountId accountId) async {
    return await db.profileData((db) => db.isInFavorites(accountId)) ?? false;
  }

  Stream<bool> addToFavorites(AccountId accountId) async* {
    if (await isInFavorites(accountId)) {
      // In favorites already
      return;
    }

    await db.profileAction((db) => db.setFavoriteStatus(accountId, true));
    yield true;

    final status = await _api.profileAction((api) => api.postFavoriteProfile(accountId));

    if (status.isErr()) {
      // Revert local change
      yield false;
      await db.profileAction((db) => db.setFavoriteStatus(accountId, false));
    } else {
      _profileChangesRelay.add(
        ProfileFavoriteStatusChange(accountId, true)
      );
    }

    // TODO: Save change to db only when server has accepted it?
  }

  /// Returns new isFavorite status for AccountId.
  Stream<bool> removeFromFavorites(AccountId accountId) async* {
    if (!await isInFavorites(accountId)) {
      // Not in favorites already
      return;
    }

    await db.profileAction((db) => db.setFavoriteStatus(accountId, false));
    yield false;

    final status = await _api.profileAction((api) => api.deleteFavoriteProfile(accountId));

    if (status.isErr()) {
      // Revert local change
      yield true;
      await db.profileAction((db) => db.setFavoriteStatus(accountId, true));
    } else {
      _profileChangesRelay.add(
        ProfileFavoriteStatusChange(accountId, false)
      );
    }
  }

  Future<void> changeProfileFilteringSettings(bool showOnlyFavorites) async {
    await db.accountAction(
      (db) => db.updateProfileFilterFavorites(showOnlyFavorites),
    );
    if (showOnlyFavorites) {
      await mainProfilesViewIterator.reset(ModeFavorites());
    } else {
      await mainProfilesViewIterator.reset(ModePublicProfiles(
        clearDatabase: false
      ));
    }
  }

  Future<bool> getFilterFavoriteProfilesValue() async {
    return await db.accountStreamSingleOrDefault(
      (db) => db.watchProfileFilterFavorites(),
      PROFILE_FILTER_FAVORITES_DEFAULT,
    );
  }

  /// Save profile attributes from server to local storage and return them.
  Future<AvailableProfileAttributes?> receiveProfileAttributes() async {
    final profileAttributes = await _api.profile((api) => api.getAvailableProfileAttributes()).ok();
    if (profileAttributes != null) {
      await db.accountAction(
        (db) => db.updateAvailableProfileAttributes(profileAttributes),
      );
    }
    return profileAttributes;
  }
}

sealed class GetProfileResult {}
class GetProfileSuccess extends GetProfileResult {
  final ProfileEntry profile;
  GetProfileSuccess(this.profile);
}
/// Navigate out from view profile and reload profile list
class GetProfileDoesNotExist extends GetProfileResult {
  GetProfileDoesNotExist();
}
/// Show error message
class GetProfileFailed extends GetProfileResult {
  GetProfileFailed();
}

sealed class ProfileChange {}
class ProfileNowPrivate extends ProfileChange {
  final AccountId profile;
  ProfileNowPrivate(this.profile);
}
class ProfileBlocked extends ProfileChange {
  final AccountId profile;
  ProfileBlocked(this.profile);
}
class ProfileUnblocked extends ProfileChange {
  final AccountId profile;
  ProfileUnblocked(this.profile);
}
class ConversationChanged extends ProfileChange {
  final AccountId conversationWith;
  final ConversationChangeType change;
  ConversationChanged(this.conversationWith, this.change);
}
class LikesChanged extends ProfileChange {}
class MatchesChanged extends ProfileChange {}
class ProfileFavoriteStatusChange extends ProfileChange {
  final AccountId profile;
  final bool isFavorite;
  ProfileFavoriteStatusChange(this.profile, this.isFavorite);
}

enum ConversationChangeType {
  messageSent,
  messageReceived,
}
