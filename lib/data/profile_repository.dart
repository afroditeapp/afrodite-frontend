import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/api/api_manager.dart';
import 'package:pihka_frontend/data/profile/profile_iterator.dart';
import 'package:pihka_frontend/data/profile/profile_iterator_manager.dart';
import 'package:pihka_frontend/data/utils.dart';
import 'package:pihka_frontend/database/favorite_profiles_database.dart';
import 'package:pihka_frontend/database/profile_database.dart';
import 'package:pihka_frontend/database/profile_list_database.dart';
import 'package:pihka_frontend/storage/kv.dart';
import 'package:pihka_frontend/utils.dart';
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

  @override
  Future<void> init() async {
    final showOnlyFavorites = await KvBooleanManager.getInstance().getValue(
      KvBoolean.profileFilterFavorites
    );
    if (showOnlyFavorites != null) {
      await changeProfileFilteringSettings(showOnlyFavorites);
    }
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
        final location = await _api.profile((api) => api.getLocation());
        if (location != null) {
          await KvStringManager.getInstance()
            .setValue(KvString.profileLocation, jsonEncode(location.toJson()));
        }

        // Download current favorites.
        final favorites = await _api.profile((api) => api.getFavoriteProfiles());
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
    await KvBooleanManager.getInstance().setValue(
      KvBoolean.profileFilterFavorites,
      null
    );
  }

  Future<bool> updateLocation(Location location) async {
    final requestSuccessful = await ApiManager.getInstance().profile<bool>((api) async {
      await api.putLocation(location);
      return true;
    }) ?? false;
    if (requestSuccessful) {
      await KvStringManager.getInstance().setValue(
        KvString.profileLocation,
        jsonEncode(location.toJson())
      );
      mainProfilesViewIterator.resetServerSideIteratorWhenItIsNeededNextTime();
    }
    return requestSuccessful;
  }

  Future<Profile?> getProfile(AccountId id, {bool cache = false}) async {
    // TODO: perhaps more detailed error message, so that changes from public to
    // private profile can be handled.

    if (cache) {
      final profile = await ProfileDatabase.getInstance().getProfile(id);
      if (profile != null) {
        return profile;
      }
    }

    final profile = await _api.profile((api) => api.getProfile(id.accountId));
    if (profile != null) {
      await ProfileDatabase.getInstance().updateProfile(id, profile);
    }
    return profile;
  }

  /// Get cached (if available) and then latest profile (if available).
  Stream<GetProfileResult> getProfileStream(AccountId id) async* {
    // TODO: perhaps more detailed error message, so that changes from public to
    // private profile can be handled.

    final profile = await ProfileDatabase.getInstance().getProfile(id);
    if (profile != null) {
      yield GetProfileSuccess(profile);
    }

    final (status, latestProfile) = await _api.profileWrapper().requestWithHttpStatus(logError: false, (api) => api.getProfile(id.accountId));

    if (status.isSuccess() && latestProfile != null) {
      await ProfileDatabase.getInstance().updateProfile(id, latestProfile);
      yield GetProfileSuccess(latestProfile);
    } else if (status.isInternalServerError() && latestProfile == null) {
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
    final result = await _api.profile((api) async { await api.postProfile(profileUpdate); return true; });
    return result ?? false;
  }

  Future<void> refreshProfileIterator() async {
    await mainProfilesViewIterator.refresh();
  }

  void resetIteratorToBeginning() {
    mainProfilesViewIterator.resetToBeginning();
  }

  Future<List<ProfileEntry>> nextList() async {
    return await mainProfilesViewIterator.nextList();
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

    final (status, _) = await _api.profileWrapper().requestWithHttpStatus((api) => api.postFavoriteProfile(accountId));

    if (status.isFailure()) {
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

    final (status, _) = await _api.profileWrapper().requestWithHttpStatus((api) => api.deleteFavoriteProfile(accountId));

    if (status.isFailure()) {
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
    await KvBooleanManager.getInstance().setValue(
      KvBoolean.profileFilterFavorites,
      showOnlyFavorites
    );
    if (showOnlyFavorites) {
      await mainProfilesViewIterator.reset(ModeFavorites());
    } else {
      await mainProfilesViewIterator.reset(ModePublicProfiles(
        clearDatabase: false
      ));
    }
  }
}


sealed class GetProfileResult {}
class GetProfileSuccess extends GetProfileResult {
  final Profile profile;
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
class ProfileFavoriteStatusChange extends ProfileChange {
  final AccountId profile;
  final bool isFavorite;
  ProfileFavoriteStatusChange(this.profile, this.isFavorite);
}
