import 'dart:async';
import 'dart:convert';

import 'package:async/async.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/api/api_manager.dart';
import 'package:pihka_frontend/data/chat_repository.dart';
import 'package:pihka_frontend/data/login_repository.dart';
import 'package:pihka_frontend/data/profile/profile_iterator_manager.dart';
import 'package:pihka_frontend/data/utils.dart';
import 'package:pihka_frontend/database/account_database.dart';
import 'package:pihka_frontend/database/database_manager.dart';
import 'package:pihka_frontend/database/favorite_profiles_database.dart';
import 'package:pihka_frontend/database/profile_database.dart';
import 'package:pihka_frontend/database/profile_list_database.dart';
import 'package:pihka_frontend/storage/kv.dart';
import 'package:pihka_frontend/utils.dart';
import 'package:pihka_frontend/utils/result.dart';
import 'package:rxdart/rxdart.dart';

var log = Logger("ProfileRepository");

class ProfileRepository extends DataRepository {
  ProfileRepository._private();
  static final _instance = ProfileRepository._private();
  factory ProfileRepository.getInstance() {
    return _instance;
  }

  final ApiManager _api = ApiManager.getInstance();
  final ProfileIteratorManager mainProfilesViewIterator = ProfileIteratorManager();

  final PublishSubject<ProfileChange> _profileChangesRelay = PublishSubject();
  void sendProfileChange(ProfileChange change) {
    _profileChangesRelay.add(change);
  }
  Stream<ProfileChange> get profileChanges => _profileChangesRelay;

  Stream<Location> get location => KvStringManager.getInstance()
    .getUpdatesForWithConversionAndDefaultIfNull(
      KvString.profileLocation,
      (value) {
        final map = jsonDecode(value);
        if (map != null) {
          final location = Location.fromJson(map);
          if (location != null) {
            return location;
          } else {
            log.error("Location fromJson failed");
            return Location(latitude: 0.0, longitude: 0.0);
          }
        } else {
          log.error("Location jsonDecode failed");
          return Location(latitude: 0.0, longitude: 0.0);
        }
      },
      Location(latitude: 0.0, longitude: 0.0),
    );

  Stream<AvailableProfileAttributes?> get profileAttributes => KvStringManager.getInstance()
    .getUpdatesForWithConversionFailurePossible(
      KvString.profileAttributes,
      (value) {
        final attributes = jsonDecode(value);
        if (attributes == null) {
          return null;
        }
        final parsedAttributes = AvailableProfileAttributes.fromJson(attributes);
        return parsedAttributes;
      },
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
          await KvStringManager.getInstance()
            .setValue(KvString.profileLocation, jsonEncode(location.toJson()));
        }

        // Download current favorites.
        final favorites = await _api.profile((api) => api.getFavoriteProfiles()).ok();
        if (favorites != null) {
          for (final profile in favorites.profiles) {
            await FavoriteProfilesDatabase.getInstance()
              .insertProfile(profile);
          }
        }
      })
      .ignore();
  }

  @override
  Future<void> onLogout() async {
    await ProfileListDatabase.getInstance().clearProfiles();
    await FavoriteProfilesDatabase.getInstance().clearFavoriteProfiles();
    await ProfileDatabase.getInstance().clearProfiles();
    await mainProfilesViewIterator.reset(ModePublicProfiles(
      clearDatabase: true
    ));
    await DatabaseManager.getInstance().accountAction(
      (db) => db.updateProfileFilterFavorites(false),
    );
  }

  Future<bool> updateLocation(Location location) async {
    final requestSuccessful = await _api.profileAction((api) => api.putLocation(location)).isOk();
    if (requestSuccessful) {
      await KvStringManager.getInstance().setValue(
        KvString.profileLocation,
        jsonEncode(location.toJson())
      );
      mainProfilesViewIterator.resetServerSideIteratorWhenItIsNeededNextTime();
    }
    return requestSuccessful;
  }

  Future<ProfileEntry?> getProfile(AccountId id, {bool cache = false}) async {
    // TODO: perhaps more detailed error message, so that changes from public to
    // private profile can be handled.

    if (cache) {
      final profile = await ProfileDatabase.getInstance().getProfileEntry(id);
      if (profile != null) {
        return profile;
      }
    }

    final profile = await _api.profile((api) => api.getProfile(id.accountId)).ok();
    if (profile != null) {
      await ProfileDatabase.getInstance().updateProfile(id, profile);
      final updatedProfile = await ProfileDatabase.getInstance().getProfileEntry(id);
      return updatedProfile;
    }
    return null;
  }

  /// Get cached (if available) and then latest profile (if available).
  Stream<GetProfileResult> getProfileStream(AccountId id) async* {
    // TODO: perhaps more detailed error message, so that changes from public to
    // private profile can be handled.

    final profile = await ProfileDatabase.getInstance().getProfileEntry(id);
    if (profile != null) {
      yield GetProfileSuccess(profile);
    }

    final result = await _api.profileWrapper().requestValue(logError: false, (api) => api.getProfile(id.accountId));

    if (result case Ok(v:final latestProfile)) {
      await ProfileDatabase.getInstance().updateProfile(id, latestProfile);
      final updatedEntry = await ProfileDatabase.getInstance().getProfileEntry(id);
      if (updatedEntry != null) {
        yield GetProfileSuccess(updatedEntry);
      } else {
        yield GetProfileFailed();
      }
    } else if (result case Err(:final e) when e.isInternalServerError()) {
      // Accessing profile failed (not public or something else)
      await ProfileDatabase.getInstance().removeProfile(id);
      await ProfileListDatabase.getInstance().removeProfile(id);
      // Favorites are not changed even if profile will become private
      yield GetProfileDoesNotExist();
      _profileChangesRelay.add(
        ProfileNowPrivate(id)
      );
    } else {
      // Request failed
      yield GetProfileFailed();
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
      for (final profile in list) {
        final accountId = AccountId(accountId: profile.uuid);
        final isBlocked = await ChatRepository.getInstance().isInReceivedBlocks(accountId) ||
          await ChatRepository.getInstance().isInSentBlocks(accountId);

        if (isBlocked || accountId == ownAccountId) {
          toBeRemoved.add(profile);
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
    return await FavoriteProfilesDatabase.getInstance()
          .isInFavorites(accountId);
  }

  Stream<bool> addToFavorites(AccountId accountId) async* {
    if (await FavoriteProfilesDatabase.getInstance().isInFavorites(accountId)) {
      // In favorites already
      return;
    }

    await FavoriteProfilesDatabase.getInstance().insertProfile(accountId);
    yield true;

    final status = await _api.profileAction((api) => api.postFavoriteProfile(accountId));

    if (status.isErr()) {
      // Revert local change
      yield false;
      await FavoriteProfilesDatabase.getInstance().removeFromFavorites(accountId);
    } else {
      _profileChangesRelay.add(
        ProfileFavoriteStatusChange(accountId, true)
      );
    }
  }

  /// Returns new isFavorite status for AccountId.
  Stream<bool> removeFromFavorites(AccountId accountId) async* {
    if (!await FavoriteProfilesDatabase.getInstance().isInFavorites(accountId)) {
      // Not in favorites already
      return;
    }

    await FavoriteProfilesDatabase.getInstance().removeFromFavorites(accountId);
    yield false;

    final status = await _api.profileAction((api) => api.deleteFavoriteProfile(accountId));

    if (status.isErr()) {
      // Revert local change
      yield true;
      await FavoriteProfilesDatabase.getInstance().insertProfile(accountId);
    } else {
      _profileChangesRelay.add(
        ProfileFavoriteStatusChange(accountId, false)
      );
    }
  }

  Future<void> changeProfileFilteringSettings(bool showOnlyFavorites) async {
    await DatabaseManager.getInstance().accountAction(
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
    return await DatabaseManager.getInstance().accountDataOrDefault(
      (db) => db.watchProfileFilterFavorites(),
      PROFILE_FILTER_FAVORITES_DEFAULT,
    );
  }

  /// Save profile attributes from server to local storage and return them.
  Future<AvailableProfileAttributes?> receiveProfileAttributes() async {
    final profileAttributes = await _api.profile((api) => api.getAvailableProfileAttributes()).ok();
    if (profileAttributes != null) {
      await KvStringManager.getInstance().setValue(
        KvString.profileAttributes,
        jsonEncode(profileAttributes.toJson())
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
