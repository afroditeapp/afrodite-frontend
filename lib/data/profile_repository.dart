import 'dart:async';

import 'package:async/async.dart' show StreamExtensions;
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/api/api_manager.dart';
import 'package:pihka_frontend/api/api_wrapper.dart';
import 'package:pihka_frontend/data/chat_repository.dart';
import 'package:pihka_frontend/data/login_repository.dart';
import 'package:pihka_frontend/data/profile/profile_iterator_manager.dart';
import 'package:pihka_frontend/data/profile/profile_list/online_iterator.dart';
import 'package:pihka_frontend/data/utils.dart';
import 'package:database/database.dart';
import 'package:pihka_frontend/database/database_manager.dart';
import 'package:pihka_frontend/utils/result.dart';
import 'package:rxdart/rxdart.dart';

var log = Logger("ProfileRepository");

class ProfileRepository extends DataRepository {
  ProfileRepository._private();
  static final _instance = ProfileRepository._private();
  factory ProfileRepository.getInstance() {
    return _instance;
  }

  final syncHandler = ConnectedActionScheduler();

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
      (db) => db.daoProfileSettings.watchProfileLocation(),
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

    // TODO(prod): reset sync versions to "force sync"

    syncHandler.onLoginSync(() async {
      // No Result checking needed for these calls as db null value is checked
      // onResumeAppUsage.
      await reloadLocation();
      await reloadMyProfile();
      await reloadAttributeFilters();
      final result = await reloadFavoriteProfiles();
      if (result.isOk()) {
        await db.accountAction((db) => db.daoInitialSync.updateProfileSyncDone(true));
      }
    });
  }

  @override
  Future<void> onResumeAppUsage() async {
    syncHandler.onResumeAppUsageSync(() async {
      final result = await db.accountStreamSingle((db) => db.daoProfileSettings.watchProfileLocation()).ok();
      if (result == null) {
        await reloadLocation();
      }

      final attributes = await db.accountStreamSingle((db) => db.daoMyProfile.watchProfileAttributes()).ok();
      if (attributes == null) {
        await reloadMyProfile();
      }

      final attributeFilters = await db.accountStreamSingle((db) => db.daoProfileSettings.watchProfileAttributeFilters()).ok();
      if (attributeFilters == null) {
        await reloadAttributeFilters();
      }

      final syncDone = await db.accountStreamSingle((db) => db.daoInitialSync.watchProfileSyncDone()).ok() ?? false;
      if (!syncDone) {
        await reloadFavoriteProfiles();
        await db.accountAction((db) => db.daoInitialSync.updateProfileSyncDone(true));
      }
    });
  }

  @override
  Future<void> onInitialSetupComplete() async {
    await reloadLocation();
    await reloadMyProfile();
    await reloadAttributeFilters();
  }

  @override
  Future<void> onLogout() async {
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
        (db) => db.daoProfileSettings.updateProfileLocation(
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
      final profile = await db.profileData((db) => db.getProfileEntry(id)).ok();
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

    final profile = await db.profileData((db) => db.getProfileEntry(id)).ok();
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
    if (result.isOk()) {
      await reloadMyProfile();
      return true;
    }

    return false;
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
    return await db.profileData((db) => db.isInFavorites(accountId)).ok() ?? false;
  }

  // Returns new isFavorite status for account. The status might not change
  // if the operation fails.
  Future<bool> toggleFavoriteStatus(AccountId accountId) async {
    final currentValue = await isInFavorites(accountId);

    final Result<void, ActionApiError> status;
    if (currentValue) {
      status = await _api.profileAction((api) => api.postFavoriteProfile(accountId));
    } else {
      status = await _api.profileAction((api) => api.deleteFavoriteProfile(accountId));
    }

    if (status.isErr()) {
      return currentValue;
    } else {
      final newValue = !currentValue;
      await db.profileAction((db) => db.setFavoriteStatus(accountId, newValue));
      _profileChangesRelay.add(
        ProfileFavoriteStatusChange(accountId, newValue)
      );
      return newValue;
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

  Future<Result<(), ()>> reloadMyProfile() async {
    final ownAccountId = await LoginRepository.getInstance().accountId.firstOrNull;
    if (ownAccountId == null) {
      log.warning("reloadMyProfile: accountId is null");
      return Err(());
    }

    final profile = await _api.profile((api) => api.getProfile(ownAccountId.accountId)).ok();
    if (profile != null) {
      return await db.accountAction((db) => db.daoMyProfile.setApiProfile(profile: profile));
    } else {
      return Err(());
    }
  }

  Future<Result<(), ()>> reloadFavoriteProfiles() async {
    final favorites = await _api.profile((api) => api.getFavoriteProfiles()).ok();
    if (favorites != null) {
      return await db.profileAction((db) => db.setFavoriteStatusList(favorites.profiles, true, clear: true));
    } else {
      return Err(());
    }
  }

  Future<Result<(), ()>> reloadLocation() async {
    final location = await _api.profile((api) => api.getLocation()).ok();
    if (location != null) {
      return await db.accountAction(
        (db) => db.daoProfileSettings.updateProfileLocation(
          latitude: location.latitude,
          longitude: location.longitude,
        ),
      );
    } else {
      return Err(());
    }
  }

  Future<Result<(), ()>> reloadAttributeFilters() async {
    final value = await _api.profile((api) => api.getProfileAttributeFilters()).ok();
    if (value != null) {
      return await db.accountAction(
        (db) => db.daoProfileSettings.updateProfileAttributeFilters(value),
      );
    } else {
      return Err(());
    }
  }

  Future<Result<(), ()>> updateAttributeFilters(List<ProfileAttributeFilterValueUpdate> newValues) async {
    if (newValues.isEmpty) {
      return Ok(());
    }

    final update = ProfileAttributeFilterListUpdate(filters: newValues);
    switch (await _api.profileAction((api) => api.postProfileAttributeFilters(update))) {
      case Ok():
        await reloadAttributeFilters();
        return Ok(());
      case Err():
        return Err(());
    }
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
