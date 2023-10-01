import 'dart:async';
import 'dart:convert';

import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/api/api_manager.dart';
import 'package:pihka_frontend/data/utils.dart';
import 'package:pihka_frontend/database/profile_list_database.dart';
import 'package:pihka_frontend/storage/kv.dart';
import 'package:pihka_frontend/utils.dart';

var log = Logger("ProfileRepository");

class ProfileRepository extends DataRepository {
  ProfileRepository._private();
  static final _instance = ProfileRepository._private();
  factory ProfileRepository.getInstance() {
    return _instance;
  }

  final ApiManager _api = ApiManager.getInstance();
  IteratorType _currentIterator = DatabaseIterator();

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
    // nothing to do
  }

  @override
  Future<void> onLogin() async {
    _currentIterator = OnlineIterator(firstIterationAfterLogin: true);

    _api.state
      .firstWhere((element) => element == ApiManagerState.connected)
      .then((value) async {
        final location = await _api.profile((api) => api.getLocation());
        if (location != null) {
          await KvStringManager.getInstance().setValue(KvString.profileLocation, jsonEncode(location.toJson()));
        }
      })
      .ignore();
  }

  @override
  Future<void> onLogout() async {
    await ProfileListDatabase.getInstance().clearProfiles();
    _currentIterator = OnlineIterator(firstIterationAfterLogin: true);
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
      _currentIterator = OnlineIterator(firstIterationAfterLogin: true);
    }
    return requestSuccessful;
  }

  Future<Profile?> getProfile(AccountId id, {bool cache = false}) async {
    // TODO: perhaps more detailed error message, so that changes from public to
    // private profile can be handled.

    if (cache) {
      final profile = await ProfileListDatabase.getInstance().getProfile(id);
      if (profile != null) {
        return profile;
      }
    }

    final profile = await _api.profile((api) => api.getProfile(id.accountId));
    if (profile != null) {
      await ProfileListDatabase.getInstance().updateProfile(id, profile);
    }
    return profile;
  }

  /// Get cached (if available) and then latest profile (if available).
  Stream<GetProfileResult> getProfileStream(AccountId id) async* {
    // TODO: perhaps more detailed error message, so that changes from public to
    // private profile can be handled.

    final profile = await ProfileListDatabase.getInstance().getProfile(id);
    if (profile != null) {
      yield GetProfileSuccess(profile);
    }

    final (status, latestProfile) = await _api.profileWrapper().requestWithHttpStatus(false, (api) => api.getProfile(id.accountId));

    if (status == 200 && latestProfile != null) {
      await ProfileListDatabase.getInstance().updateProfile(id, latestProfile);
      yield GetProfileSuccess(latestProfile);
    } else if (status == 500 && latestProfile == null) {
      await ProfileListDatabase.getInstance().removeProfile(id);
      yield GetProfileDoesNotExist();
    } else {
      yield GetProfileFailed();
    }
  }

  /// Returns true if profile update was successful
  Future<bool> updateProfile(ProfileUpdate profileUpdate) async {
    final result = await _api.profile((api) async { await api.postProfile(profileUpdate); return true; });
    return result ?? false;
  }

  Future<void> resetProfileIterator(bool clearDatabase) async {
    if (clearDatabase) {
      await _api.profile((api) => api.postResetProfilePaging());
      await ProfileListDatabase.getInstance().clearProfiles();
      _currentIterator = OnlineIterator();
    } else {
      _currentIterator.reset();
    }
  }

  Future<List<ProfileListEntry>> nextList() async {
    final nextList = await _currentIterator.nextList();

    if (nextList.isEmpty && _currentIterator is OnlineIterator) {
      _currentIterator = DatabaseIterator();
    }
    return nextList;
  }
}

sealed class IteratorType {
  /// Resets the iterator to the beginning
  void reset() {}
  /// Returns the next list of profiles
  Future<List<ProfileListEntry>> nextList() async {
    return [];
  }
}
class OnlineIterator extends IteratorType {
  int currentIndex = 0;
  DatabaseIterator? databaseIterator;
  bool firstIterationAfterLogin;
  final ApiManager api = ApiManager.getInstance();

  /// If [firstIterationAfterLogin] is true, the iterator will reset the
  /// server iterator to the beginning.
  OnlineIterator({this.firstIterationAfterLogin = false});

  @override
  void reset() {
    if (!firstIterationAfterLogin) {
      /// Reset to use database iterator and then continue online profile
      /// iterating.
      databaseIterator = DatabaseIterator();
    }
  }

  @override
  Future<List<ProfileListEntry>> nextList() async {
    if (firstIterationAfterLogin) {
      await ApiManager.getInstance().profile((api) => api.postResetProfilePaging());
      firstIterationAfterLogin = false;
    }

    // Handle case where iterator has been reseted in the middle
    // of online iteration. Get the beginning from the database.
    final iterator = databaseIterator;
    if (iterator != null) {
      final list = await iterator.nextList();
      if (list.isNotEmpty) {
        return list;
      } else {
        databaseIterator = null;
      }
    }

    // TODO: What if server restarts? The client thinks that it is
    // in the middle of the list, but the server has reseted the iterator.
    // Add some uuid to the iterator to check if the server has restarted?

    final List<ProfileListEntry> list = List.empty(growable: true);
    while (true) {
      final profiles = await api.profile((api) => api.postGetNextProfilePage());
      if (profiles != null) {
        if (profiles.profiles.isEmpty) {
          return [];
        }

        for (final p in profiles.profiles) {
          final profile = p;
          final primaryImageInfo = await api.media((api) => api.getPrimaryImageInfo(profile.id.accountId, false));
          final imageUuid = primaryImageInfo?.contentId?.contentId;
          if (imageUuid == null) {
            continue;
          }

          // Prevent displaying error when profile is made private while iterating
          final (_, profileDetails) = await api
            .profileWrapper()
            .requestWithHttpStatus(false, (api) => api.getProfile(profile.id.accountId));
          if (profileDetails == null) {
            continue;
          }
          // TODO: Compare cached profile data with the one from the server.
          //       Update: perhaps another database for profiles? With current
          //       implementation there is no cached data. Or should
          //       new profile request be made every time profile is opened and
          //       use the cache check there?

          final entry = ProfileListEntry(profile.id.accountId, imageUuid, profileDetails.name, profileDetails.profileText);
          await ProfileListDatabase.getInstance().insertProfile(entry);
          list.add(entry);
        }

        if (list.isEmpty) {
          // Handle case where server returned some profiles
          // but additional info fetching failed, so get next list of profiles.
          continue;
        }
      }

      return list;
    }
  }
}

class DatabaseIterator extends IteratorType {
  int currentIndex;
  DatabaseIterator({this.currentIndex = 0});

  @override
  void reset() {
    currentIndex = 0;
  }

  @override
  Future<List<ProfileListEntry>> nextList() async {
    const queryCount = 10;
    final profiles = await ProfileListDatabase.getInstance().getProfileList(currentIndex, queryCount);
    if (profiles != null) {
      currentIndex += queryCount;
      return profiles;
    } else {
      return [];
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
