import 'dart:async';

import 'package:async/async.dart' show StreamExtensions;
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/api/api_manager.dart';
import 'package:pihka_frontend/data/account_repository.dart';
import 'package:pihka_frontend/data/general/notification/state/message_received.dart';
import 'package:pihka_frontend/data/media_repository.dart';
import 'package:pihka_frontend/data/profile/profile_list/online_iterator.dart';
import 'package:pihka_frontend/data/utils.dart';
import 'package:database/database.dart';
import 'package:pihka_frontend/database/account_background_database_manager.dart';
import 'package:pihka_frontend/database/account_database_manager.dart';
import 'package:pihka_frontend/utils/app_error.dart';
import 'package:pihka_frontend/utils/result.dart';
import 'package:rxdart/rxdart.dart';
import 'package:utils/utils.dart';

var log = Logger("ProfileRepository");

class ProfileRepository extends DataRepositoryWithLifecycle {
  final ConnectedActionScheduler syncHandler;
  final AccountDatabaseManager db;
  final AccountBackgroundDatabaseManager accountBackgroundDb;
  final ApiManager _api;
  final ServerConnectionManager connectionManager;

  final MediaRepository media;
  final AccountRepository account;

  final AccountId currentUser;

  ProfileRepository(this.media, this.account, this.db, this.accountBackgroundDb, this.connectionManager, this.currentUser) :
    syncHandler = ConnectedActionScheduler(connectionManager),
    _api = connectionManager.api;

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
    // empty
  }

  @override
  Future<void> dispose() async {
    await syncHandler.dispose();
  }

  @override
  Future<void> onLogin() async {
    // TODO(prod): reset sync versions to "force sync"

    await db.accountAction((db) => db.daoInitialSync.updateProfileSyncDone(false));

    syncHandler.onLoginSync(() async {
      // No Result checking needed for these calls as db null value is checked
      // onResumeAppUsage.
      await reloadLocation();
      await reloadAttributeFilters();
      await reloadSearchAgeRange();
      await reloadSearchGroups();
      await downloadInitialSetupAgeInfoIfNull(skipIfAccountStateIsInitialSetup: true);
      final result = await reloadFavoriteProfiles();
      if (result.isOk()) {
        await db.accountAction((db) => db.daoInitialSync.updateProfileSyncDone(true));
      }
    });
  }

  @override
  Future<void> onResumeAppUsage() async {
    syncHandler.onResumeAppUsageSync(() async {
      // TODO(quality): Replace ok method with okAndNull to avoid reload when
      // database query fails.

      final result = await db.accountStreamSingle((db) => db.daoProfileSettings.watchProfileLocation()).ok();
      if (result == null) {
        await reloadLocation();
      }

      final attributeFilters = await db.accountStreamSingle((db) => db.daoProfileSettings.watchProfileAttributeFilters()).ok();
      if (attributeFilters == null) {
        await reloadAttributeFilters();
      }

      final searchAgeRangeMin = await db.accountStreamSingle((db) => db.daoProfileSettings.watchProfileSearchAgeRangeMin()).ok();
      final searchAgeRangeMax = await db.accountStreamSingle((db) => db.daoProfileSettings.watchProfileSearchAgeRangeMax()).ok();
      if (searchAgeRangeMin == null || searchAgeRangeMax == null) {
        await reloadSearchAgeRange();
      }

      final searchGroups = await db.accountStreamSingle((db) => db.daoProfileSettings.watchSearchGroups()).ok();
      if (searchGroups == null) {
        await reloadSearchGroups();
      }

      final initialAgeInfo = await db.accountStreamSingle((db) => db.daoProfileInitialAgeInfo.watchInitialAgeInfo()).ok();
      if (initialAgeInfo == null) {
        await downloadInitialSetupAgeInfoIfNull(skipIfAccountStateIsInitialSetup: false);
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
    await reloadSearchAgeRange();
    await reloadSearchGroups();
    // The account state might still be InitialSetup as events from server
    // updates the state, so skip account state check.
    await downloadInitialSetupAgeInfoIfNull(skipIfAccountStateIsInitialSetup: true);
  }

  @override
  Future<void> onLogout() async {
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
      await resetMainProfileIterator();
    }
    return requestSuccessful;
  }

  /// Waits connection before downloading starts.
  ///
  /// If `cache` is true, then getting the profile is tried from cache first.
  Future<ProfileEntry?> getProfile(AccountId id, {bool cache = false}) async {
    // TODO: perhaps more detailed error message, so that changes from public to
    // private profile can be handled.

    if (cache) {
      final profile = await db.profileData((db) => db.getProfileEntry(id)).ok();
      if (profile != null) {
        return profile;
      }
    }

    await connectionManager.state.where((e) => e == ApiManagerState.connected).firstOrNull;
    final entry = await ProfileEntryDownloader(media, accountBackgroundDb, db, _api).download(id).ok();
    return entry;
  }

  /// Get cached (if available) and then latest profile (if available and enough
  /// time has passed since last profile data refresh).
  Stream<GetProfileResultClient> getProfileStream(AccountId id, ProfileRefreshPriority priority) async* {
    // TODO: perhaps more detailed error message, so that changes from public to
    // private profile can be handled.

    final profile = await db.profileData((db) => db.getProfileEntry(id)).ok();
    if (profile != null) {
      yield GetProfileSuccess(profile);
    }

    final lastRefreshTime = await db.profileData((db) => db.getProfileDataRefreshTime(id)).ok();
    if (profile != null && lastRefreshTime != null) {
      final currentTime = UtcDateTime.now();
      final difference = currentTime.dateTime.difference(lastRefreshTime.dateTime);
      final int timePassedAtLeastSeconds = switch (priority) {
        ProfileRefreshPriority.high => 60,
        ProfileRefreshPriority.low => 60 * 5,
      };
      if (difference.inSeconds < timePassedAtLeastSeconds) {
        return;
      }
    }

    final result = await ProfileEntryDownloader(media, accountBackgroundDb, db, _api).download(id);
    switch (result) {
      case Ok(:final v):
        yield GetProfileSuccess(v);
      case Err(:final e):
        switch (e) {
          case PrivateProfile():
            // Accessing profile failed (not public or something else)
            await db.profileAction((db) => db.removeProfileData(id));
            await db.accountAction((db) => db.daoProfileStates.setProfileGridStatus(id, false));
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

  Future<bool> isInFavorites(AccountId accountId) async {
    return await db.accountData((db) => db.daoProfileStates.isInFavorites(accountId)).ok() ?? false;
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
      await db.accountAction((db) => db.daoProfileStates.setFavoriteStatus(accountId, newValue));
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

  Future<Result<void, void>> reloadMyProfile() async {
    return await _api.profile((api) => api.getMyProfile())
      .emptyErr()
      .andThen((info) {
        return db.accountAction((db) => db.daoMyProfile.setApiProfile(profile: info.p, version: info.v))
          .andThen((_) => db.accountAction((db) => db.daoSyncVersions.updateSyncVersionProfile(info.sv)));
      });
  }

  Future<Result<void, void>> reloadFavoriteProfiles() async {
    return await _api.profile((api) => api.getFavoriteProfiles())
      .emptyErr()
      .andThen((f) => db.accountAction((db) => db.daoProfileStates.setFavoriteStatusList(f.profiles, true, clear: true)));
  }

  Future<Result<void, void>> reloadLocation() async {
    return await _api.profile((api) => api.getLocation())
      .emptyErr()
      .andThen((l) => db.accountAction(
        (db) => db.daoProfileSettings.updateProfileLocation(
          latitude: l.latitude,
          longitude: l.longitude,
        )
      ));
  }

  Future<Result<void, void>> reloadAttributeFilters() async {
    return await _api.profile((api) => api.getProfileAttributeFilters())
      .emptyErr()
      .andThen((f) => db.accountAction(
        (db) => db.daoProfileSettings.updateProfileAttributeFilters(f),
      ));
  }

  Future<Result<void, void>> updateAttributeFilters(
    List<ProfileAttributeFilterValueUpdate> newValues,
    LastSeenTimeFilter? lastSeenTimeFilter,
    bool? unlimitedLikesFilter,
  ) async {
    final update = ProfileAttributeFilterListUpdate(
      filters: newValues,
      lastSeenTimeFilter: lastSeenTimeFilter,
      unlimitedLikesFilter: unlimitedLikesFilter,
    );
    return await _api.profileAction((api) => api.postProfileAttributeFilters(update))
      .onOk(() => reloadAttributeFilters())
      .empty();
  }

  Future<void> resetMainProfileIterator() async {
    final showOnlyFavorites = await getFilterFavoriteProfilesValue();
    sendProfileChange(ReloadMainProfileView(
      showOnlyFavorites: showOnlyFavorites,
    ));
  }

  // Search settings

  Future<Result<void, void>> reloadSearchAgeRange() async {
    return await _api.profile((api) => api.getSearchAgeRange())
      .emptyErr()
      .andThen((r) => db.accountAction(
        (db) => db.daoProfileSettings.updateProfileSearchAgeRange(r),
      ));
  }

  Future<Result<void, void>> reloadSearchGroups() async {
    return await _api.profile((api) => api.getSearchGroups())
      .andThen((v) => db.accountAction(
        (db) => db.daoProfileSettings.updateSearchGroups(v),
      ));
  }

  Future<Result<void, void>> updateSearchAgeRange(int minAge, int maxAge) async {
    final update = ProfileSearchAgeRange(min: minAge, max: maxAge);
    return await _api.profileAction((api) => api.postSearchAgeRange(update))
      .onOk(() => reloadSearchAgeRange());
  }

  Future<Result<void, void>> updateSearchGroups(SearchGroups groups) async {
    return await _api.profileAction((api) => api.postSearchGroups(groups))
      .onOk(() => reloadSearchGroups());
  }

  Future<Result<void, void>> resetUnreadMessagesCount(AccountId accountId) async {
    // Hide notification
    await NotificationMessageReceived.getInstance()
      .updateMessageReceivedCount(accountId, 0, accountBackgroundDb);
    return accountBackgroundDb.accountAction(
      (db) => db.daoConversationsBackground.setUnreadMessagesCount(accountId, const UnreadMessagesCount(0)),
    );
  }

  /// If profile does not exist in DB, try download it when connection exists.
  /// After that emit only DB updates.
  Stream<ProfileEntry?> getProfileEntryUpdates(AccountId accountId) async* {
    final stream = db.accountStream(
      (db) => db.daoProfiles.watchProfileEntry(accountId),
    );
    bool downloaded = false;
    await for (final p in stream) {
      if (p == null && !downloaded) {
        await connectionManager.state.where((e) => e == ApiManagerState.connected).firstOrNull;
        await ProfileEntryDownloader(media, accountBackgroundDb, db, _api).download(accountId);
        downloaded = true;
        continue;
      }
      yield p;
    }
  }

  /// Latest conversation is the first conversation in every emitted list
  Stream<List<AccountId>> getConversationListUpdates() {
    return db.accountStreamOrDefault(
      (db) => db.daoMatches.watchConversationList(),
      <AccountId>[],
    );
  }

  Stream<UnreadMessagesCount?> getUnreadMessagesCountStream(AccountId accountId) {
    return accountBackgroundDb.accountStream(
      (db) => db.daoConversationsBackground.watchUnreadMessageCount(accountId),
    );
  }

  Future<void> downloadInitialSetupAgeInfoIfNull({required bool skipIfAccountStateIsInitialSetup}) async {
    if (skipIfAccountStateIsInitialSetup) {
      final state = await account.accountState.firstOrNull;
      if (state == AccountState.initialSetup) {
        // It is not possible to download the info when
        // the state is initial setup.
        return;
      }
    }

    final value = await db.accountStreamSingle(
      (db) => db.daoProfileInitialAgeInfo.watchInitialAgeInfo(),
    ).ok();
    if (value != null) {
      // Already downloaded
      return;
    }

    final apiResult = await _api.profile((api) => api.getInitialProfileAgeInfo());
    switch (apiResult) {
      case Err():
        return;
      case Ok(:final v):
        final info = v.info;
        if (info == null) {
          // Initial setup is ongoing. This might happen at least for
          // new accounts as onLogin runs for those and client might not
          // received the state yet. That could be perhaps avoided by
          // skipping null values from the skipIfAccountStateIsInitialSetup
          // related account state stream, but extra API call does not matter
          // that much.
        } else {
          await db.accountAction(
            (db) => db.daoProfileInitialAgeInfo.setInitialAgeInfo(info: info),
          );
        }
    }
  }
}

sealed class GetProfileResultClient {}
class GetProfileSuccess extends GetProfileResultClient {
  final ProfileEntry profile;
  GetProfileSuccess(this.profile);
}
/// Navigate out from view profile and reload profile list
class GetProfileDoesNotExist extends GetProfileResultClient {
  GetProfileDoesNotExist();
}
/// Show error message
class GetProfileFailed extends GetProfileResultClient {
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
// TODO(prod): Is this needed after removing local received likes?
class LikesChanged extends ProfileChange {}
class MatchesChanged extends ProfileChange {}
class ProfileFavoriteStatusChange extends ProfileChange {
  final AccountId profile;
  final bool isFavorite;
  ProfileFavoriteStatusChange(this.profile, this.isFavorite);
}
class ReloadMainProfileView extends ProfileChange {
  final bool showOnlyFavorites;
  ReloadMainProfileView({required this.showOnlyFavorites});
}

enum ConversationChangeType {
  messageSent,
  messageReceived,
  messageRemoved,
  messageResent,
}

enum ProfileRefreshPriority {
  /// Refresh if 1 minute have passed since last refresh
  high,
  /// Refresh if 5 minutes have passed since last refresh
  low,
}
