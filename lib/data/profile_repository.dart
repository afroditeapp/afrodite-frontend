import 'dart:async';

import 'package:app/data/chat_repository.dart';
import 'package:app/data/general/notification/state/automatic_profile_search.dart';
import 'package:app/data/general/notification/state/profile_text_moderation_completed.dart';
import 'package:app/utils/api.dart';
import 'package:app/utils/stream.dart';
import 'package:async/async.dart' show StreamExtensions;
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:app/api/api_manager.dart';
import 'package:app/data/account_repository.dart';
import 'package:app/data/general/notification/state/message_received.dart';
import 'package:app/data/media_repository.dart';
import 'package:app/data/profile/profile_downloader.dart';
import 'package:app/data/utils.dart';
import 'package:database/database.dart';
import 'package:app/database/account_background_database_manager.dart';
import 'package:app/database/account_database_manager.dart';
import 'package:app/utils/app_error.dart';
import 'package:app/utils/result.dart';
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
      (db) => db.myProfile.watchProfileLocation(),
      Location(latitude: 0.0, longitude: 0.0),
    );

  Stream<ProfileAttributes?> get profileAttributes => db
    .accountStream(
      (db) => db.config.watchAvailableProfileAttributes(),
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
    await db.accountAction((db) => db.app.updateProfileSyncDone(false));
  }

  @override
  Future<Result<void, void>> onLoginDataSync() async {
    return await reloadLocation()
      .andThen((_) => reloadProfileFilteringSettings())
      .andThen((_) => reloadSearchAgeRange())
      .andThen((_) => reloadSearchGroups())
      .andThen((_) async {
        await downloadInitialSetupAgeInfoIfNull(skipIfAccountStateIsInitialSetup: true);
        return const Ok(null);
      })
      .andThen((_) => reloadFavoriteProfiles())
      .andThen((_) => _reloadProfileNotificationSettings())
      .andThen((_) => db.accountAction((db) => db.app.updateProfileSyncDone(true)));
  }

  @override
  Future<void> onResumeAppUsage() async {
    syncHandler.onResumeAppUsageSync(() async {
      final result = await db.accountStreamSingle((db) => db.myProfile.watchProfileLocation()).ok();
      if (result == null) {
        await reloadLocation();
      }

      final attributeFilters = await db.accountStreamSingle((db) => db.search.watchProfileFilteringSettings()).ok();
      if (attributeFilters == null) {
        await reloadProfileFilteringSettings();
      }

      final searchAgeRangeMin = await db.accountStreamSingle((db) => db.search.watchProfileSearchAgeRangeMin()).ok();
      final searchAgeRangeMax = await db.accountStreamSingle((db) => db.search.watchProfileSearchAgeRangeMax()).ok();
      if (searchAgeRangeMin == null || searchAgeRangeMax == null) {
        await reloadSearchAgeRange();
      }

      final searchGroups = await db.accountStreamSingle((db) => db.search.watchSearchGroups()).ok();
      if (searchGroups == null) {
        await reloadSearchGroups();
      }

      final initialAgeInfo = await db.accountStreamSingle((db) => db.myProfile.watchInitialAgeInfo()).ok();
      if (initialAgeInfo == null) {
        await downloadInitialSetupAgeInfoIfNull(skipIfAccountStateIsInitialSetup: false);
      }

      final syncDone = await db.accountStreamSingle((db) => db.app.watchProfileSyncDone()).ok() ?? false;
      if (!syncDone) {
        await reloadFavoriteProfiles()
          .andThen((_) => _reloadProfileNotificationSettings())
          .andThen((_) => db.accountAction((db) => db.app.updateProfileSyncDone(true)));
      }
    });
  }

  @override
  Future<void> onInitialSetupComplete() async {
    await reloadLocation();
    await reloadMyProfile();
    await reloadProfileFilteringSettings();
    await reloadSearchAgeRange();
    await reloadSearchGroups();
    // The account state might still be InitialSetup as events from server
    // updates the state, so skip account state check.
    await downloadInitialSetupAgeInfoIfNull(skipIfAccountStateIsInitialSetup: true);
  }

  @override
  Future<void> onLogout() async {
    await db.accountAction(
      (db) => db.app.updateProfileFilterFavorites(false),
    );
  }

  Future<bool> updateLocation(Location location) async {
    final requestSuccessful = await _api.profileAction((api) => api.putLocation(location)).isOk();
    if (requestSuccessful) {
      await db.accountAction(
        (db) => db.myProfile.updateProfileLocation(
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
    // TODO(prod): perhaps more detailed error message, so that changes from public to
    // private profile can be handled.

    if (cache) {
      final profile = await db.accountData((db) => db.profile.getProfileEntry(id)).ok();
      if (profile != null) {
        return profile;
      }
    }

    await connectionManager.state.where((e) => e == ApiManagerState.connected).firstOrNull;
    final entry = await ProfileEntryDownloader(media, accountBackgroundDb, db, _api).download(id).ok();
    return entry;
  }

  /// Get cached (if available), latest profile (if available and enough
  /// time has passed since last profile data refresh) and future profile
  /// updates.
  Stream<GetProfileResultClient> getProfileStream(ChatRepository chat, AccountId id, ProfileRefreshPriority priority) async* {
    // TODO(prod): perhaps more detailed error message, so that changes from public to
    // private profile can be handled.

    final dbProfileIteator = StreamIterator(db.accountStream((db) => db.profile.watchProfileEntry(id)));

    final profile = await dbProfileIteator.next();
    if (profile != null) {
      yield GetProfileSuccess(profile);
    }

    bool download = true;

    final lastRefreshTime = await db.accountData((db) => db.profile.getProfileDataRefreshTime(id)).ok();
    if (profile != null && lastRefreshTime != null) {
      final currentTime = UtcDateTime.now();
      final difference = currentTime.dateTime.difference(lastRefreshTime.dateTime);
      final int timePassedAtLeastSeconds = switch (priority) {
        ProfileRefreshPriority.high => 60,
        ProfileRefreshPriority.low => 60 * 5,
      };
      if (difference.inSeconds < timePassedAtLeastSeconds) {
        download = false;
      }
    }

    if (download) {
      final isMatch = await chat.isInMatches(id);
      final result = await ProfileEntryDownloader(media, accountBackgroundDb, db, _api).download(id, isMatch: isMatch);
      switch (result) {
        case Ok():
          ();
        case Err(:final e):
          switch (e) {
            case PrivateProfile():
              // Accessing profile failed (not public or something else)
              await db.accountAction((db) => db.profile.removeProfileData(id));
              await db.accountAction((db) => db.profile.setProfileGridStatus(id, false));
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

    while (true) {
      final profile = await dbProfileIteator.next();
      if (profile != null) {
        yield GetProfileSuccess(profile);
      } else {
        return;
      }
    }
  }

  Future<void> downloadProfileToDatabase(ChatRepository chat, AccountId id) async {
    final isMatch = await chat.isInMatches(id);
    await ProfileEntryDownloader(media, accountBackgroundDb, db, _api).download(id, isMatch: isMatch);
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
    return await db.accountData((db) => db.profile.isInFavorites(accountId)).ok() ?? false;
  }

  // Returns new isFavorite status for account. The status might not change
  // if the operation fails.
  Future<bool> toggleFavoriteStatus(AccountId accountId) async {
    final currentValue = await isInFavorites(accountId);

    final Result<void, ActionApiError> status;
    final bool newValue;
    if (currentValue) {
      status = await _api.profileAction((api) => api.deleteFavoriteProfile(accountId));
      newValue = false;
    } else {
      status = await _api.profileAction((api) => api.postFavoriteProfile(accountId));
      newValue = true;
    }

    if (status.isErr()) {
      return currentValue;
    } else {
      await db.accountAction((db) => db.profile.setFavoriteStatus(accountId, newValue));
      _profileChangesRelay.add(
        ProfileFavoriteStatusChange(accountId, newValue)
      );
      return newValue;
    }
  }

  Future<void> changeProfileFilteringSettings(bool showOnlyFavorites) async {
    await db.accountAction(
      (db) => db.app.updateProfileFilterFavorites(showOnlyFavorites),
    );
  }

  Future<bool> getFilterFavoriteProfilesValue() async {
    return await db.accountStreamSingleOrDefault(
      (db) => db.app.watchProfileFilterFavorites(),
      false,
    );
  }

  /// Save client config from server to local database and return them.
  Future<Result<ClientConfig, void>> receiveClientConfig() async {
    final config = await _api.common((api) => api.getClientConfig()).ok();
    if (config == null) {
      return const Err(null);
    }
    final latestAttributes = config.profileAttributes?.attributes ?? [];
    final attributeOrder = config.profileAttributes?.attributeOrder;

    final attributeRefreshList = await db.accountData(
      (db) => db.config.getAttributeRefreshList(latestAttributes),
    ).ok();
    if (attributeRefreshList == null) {
      return const Err(null);
    }

    final List<ProfileAttributeQueryItem> updatedAttributes;
    if (attributeRefreshList.isEmpty) {
      updatedAttributes = [];
    } else {
      final r = await _api.profile((api) => api.postGetQueryAvailableProfileAttributes(ProfileAttributeQuery(values: attributeRefreshList))).ok();
      if (r == null) {
        return const Err(null);
      }
      updatedAttributes = r.values;
    }

    final CustomReportsFileHash? customReportsFileHash;
    final CustomReportsConfig? customReportsConfig;
    switch (await _downloadCustomReportsIfNeeded(config.customReports)) {
      case Err():
        return const Err(null);
      case Ok(v: (final fileHash, final config)):
        customReportsFileHash = fileHash;
        customReportsConfig = config;
    }

    final ClientFeaturesFileHash? clientFeaturesFileHash;
    final ClientFeaturesConfig? clientFeaturesConfig;
    switch (await _downloadClientFeaturesIfNeeded(config.clientFeatures)) {
      case Err():
        return const Err(null);
      case Ok(v: (final fileHash, final config)):
        clientFeaturesFileHash = fileHash;
        clientFeaturesConfig = config;
    }

    await db.accountAction(
      (db) => db.config.updateClientConfig(
        attributeOrder,
        config.syncVersion,
        latestAttributes,
        updatedAttributes,
        customReportsFileHash,
        customReportsConfig,
        clientFeaturesFileHash,
        clientFeaturesConfig,
      ),
    );
    return Ok(config);
  }

  Future<Result<(CustomReportsFileHash?, CustomReportsConfig?), void>> _downloadCustomReportsIfNeeded(
    CustomReportsFileHash? latestFileHash,
  ) async {
    final currentFileHash = await db.accountStream(
      (db) => db.config.watchCustomReportsFileHash(),
    ).firstOrNull;
    final currentConfig = await db.accountStream(
      (db) => db.config.watchCustomReportsConfig(),
    ).firstOrNull;

    final CustomReportsFileHash? fileHash;
    final CustomReportsConfig? config;
    if (latestFileHash != null) {
      if (currentFileHash == latestFileHash && currentConfig != null) {
        // Latest config already downloaded
        fileHash = currentFileHash;
        config = currentConfig;
      } else {
        final latestConfig = await _api.account((api) => api.postGetCustomReportsConfig(latestFileHash)).ok();
        if (latestConfig == null) {
          return const Err(null);
        }
        fileHash = latestFileHash;
        config = latestConfig.config;
      }
    } else {
      // Custom reports disabled
      fileHash = null;
      config = null;
    }

    return Ok((fileHash, config));
  }

  Future<Result<(ClientFeaturesFileHash?, ClientFeaturesConfig?), void>> _downloadClientFeaturesIfNeeded(
    ClientFeaturesFileHash? latestFileHash,
  ) async {
    final currentFileHash = await db.accountStream(
      (db) => db.config.watchClientFeaturesFileHash(),
    ).firstOrNull;
    final currentConfig = await db.accountStream(
      (db) => db.config.watchClientFeaturesConfig(),
    ).firstOrNull;

    final ClientFeaturesFileHash? fileHash;
    final ClientFeaturesConfig? config;
    if (latestFileHash != null) {
      if (currentFileHash == latestFileHash && currentConfig != null) {
        // Latest config already downloaded
        fileHash = currentFileHash;
        config = currentConfig;
      } else {
        final latestConfig = await _api.account((api) => api.postGetClientFeaturesConfig(latestFileHash)).ok();
        if (latestConfig == null) {
          return const Err(null);
        }
        fileHash = latestFileHash;
        config = latestConfig.config;
      }
    } else {
      // Client features disabled
      fileHash = null;
      config = null;
    }

    return Ok((fileHash, config));
  }

  Future<Result<void, void>> reloadMyProfile() async {
    return await _api.profile((api) => api.getMyProfile())
      .emptyErr()
      .andThen((info) {
        return db.accountAction((db) => db.myProfile.setApiProfile(result: info))
          .andThen((_) => db.accountAction((db) => db.common.updateSyncVersionProfile(info.sv)));
      });
  }

  Future<Result<void, void>> reloadFavoriteProfiles() async {
    return await _api.profile((api) => api.getFavoriteProfiles())
      .emptyErr()
      .andThen((f) => db.accountAction((db) => db.profile.replaceFavorites(f.profiles)));
  }

  Future<Result<void, void>> reloadLocation() async {
    return await _api.profile((api) => api.getLocation())
      .emptyErr()
      .andThen((l) => db.accountAction(
        (db) => db.myProfile.updateProfileLocation(
          latitude: l.latitude,
          longitude: l.longitude,
        )
      ));
  }

  Future<Result<void, void>> reloadProfileFilteringSettings() async {
    return await _api.profile((api) => api.getProfileFilteringSettings())
      .emptyErr()
      .andThen((f) => db.accountAction(
        (db) => db.search.updateProfileFilteringSettings(f),
      ));
  }

  Future<Result<void, void>> updateProfileFilteringSettings(
    Map<int, ProfileAttributeFilterValueUpdate> attributeIdAndFilterValueMap,
    LastSeenTimeFilter? lastSeenTimeFilter,
    bool? unlimitedLikesFilter,
    MinDistanceKm? minDistanceFilter,
    MaxDistanceKm? maxDistanceFilter,
    ProfileCreatedTimeFilter? profileCreatedFilter,
    ProfileEditedTimeFilter? profileEditedFilter,
    ProfileTextMinCharactersFilter? profileTextMinCharactersFilter,
    ProfileTextMaxCharactersFilter? profileTextMaxCharactersFilter,
    bool randomProfileOrder,
  ) async {
    final update = ProfileFilteringSettingsUpdate(
      filters: attributeIdAndFilterValueMap.values.toList(),
      lastSeenTimeFilter: lastSeenTimeFilter,
      unlimitedLikesFilter: unlimitedLikesFilter,
      minDistanceKmFilter: minDistanceFilter,
      maxDistanceKmFilter: maxDistanceFilter,
      profileCreatedFilter: profileCreatedFilter,
      profileEditedFilter: profileEditedFilter,
      profileTextMinCharactersFilter: profileTextMinCharactersFilter,
      profileTextMaxCharactersFilter: profileTextMaxCharactersFilter,
      randomProfileOrder: randomProfileOrder,
    );
    return await _api.profileAction((api) => api.postProfileFilteringSettings(update))
      .onOk(() => reloadProfileFilteringSettings())
      .empty();
  }

  Future<void> resetMainProfileIterator({BehaviorSubject<bool>? eventHandlingTracking}) async {
    final showOnlyFavorites = await getFilterFavoriteProfilesValue();
    sendProfileChange(ReloadMainProfileView.withEventHandlingTracking(
      showOnlyFavorites: showOnlyFavorites,
      eventHandlingTracking: eventHandlingTracking,
    ));
  }

  // Search settings

  Future<Result<void, void>> reloadSearchAgeRange() async {
    return await _api.profile((api) => api.getSearchAgeRange())
      .emptyErr()
      .andThen((r) => db.accountAction(
        (db) => db.search.updateProfileSearchAgeRange(r),
      ));
  }

  Future<Result<void, void>> reloadSearchGroups() async {
    return await _api.profile((api) => api.getSearchGroups())
      .andThen((v) => db.accountAction(
        (db) => db.search.updateSearchGroups(v),
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
      .updateMessageReceivedCount(accountId, 0, null, accountBackgroundDb);
    return accountBackgroundDb.accountAction(
      (db) => db.unreadMessagesCount.setUnreadMessagesCount(accountId, const UnreadMessagesCount(0)),
    );
  }

  /// If profile does not exist in DB, try download it when connection exists.
  /// After that emit only DB updates.
  Stream<ProfileEntry?> getProfileEntryUpdates(AccountId accountId) async* {
    final stream = db.accountStream(
      (db) => db.profile.watchProfileEntry(accountId),
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
      (db) => db.conversationList.watchConversationList(),
      <AccountId>[],
    );
  }

  Stream<UnreadMessagesCount?> getUnreadMessagesCountStream(AccountId accountId) {
    return accountBackgroundDb.accountStream(
      (db) => db.unreadMessagesCount.watchUnreadMessageCount(accountId),
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
      (db) => db.myProfile.watchInitialAgeInfo(),
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
            (db) => db.myProfile.setInitialAgeInfo(info: info),
          );
        }
    }
  }

  Future<Result<void, void>> _reloadProfileNotificationSettings() async {
    return await _api.profile((api) => api.getProfileAppNotificationSettings())
      .andThen((v) => accountBackgroundDb.accountAction(
        (db) => db.appNotificationSettings.updateProfileNotificationSettings(v),
      ));
  }

  Future<void> handleProfileStringModerationCompletedEvent() async {
    final notification = await _api.profile((api) => api.postGetProfileStringModerationCompletedNotification()).ok();

    if (notification == null) {
      return;
    }

    await NotificationProfileStringModerationCompleted.handleProfileStringModerationCompleted(notification, accountBackgroundDb);

    final viewed = ProfileStringModerationCompletedNotificationViewed(
      nameAccepted: notification.nameAccepted.id.toViewed(),
      nameRejected: notification.nameRejected.id.toViewed(),
      textAccepted: notification.textAccepted.id.toViewed(),
      textRejected: notification.textRejected.id.toViewed(),
    );
    await _api.profileAction((api) => api.postMarkProfileStringModerationCompletedNotificationViewed(viewed))
      .andThen((_) => accountBackgroundDb.accountAction(
        (db) => db.notification.profileTextAccepted.updateViewedId(viewed.textAccepted)
      ))
      .andThen((_) => accountBackgroundDb.accountAction(
        (db) => db.notification.profileTextRejected.updateViewedId(viewed.textRejected)
      ));
  }

  Future<void> handleAutomaticProfileSearchCompletedEvent() async {
    final notification = await _api.profile((api) => api.postGetAutomaticProfileSearchCompletedNotification()).ok();

    if (notification == null) {
      return;
    }

    await NotificationAutomaticProfileSearch.handleAutomaticProfileSearchCompleted(notification, accountBackgroundDb);

    final viewed = AutomaticProfileSearchCompletedNotificationViewed(
      profilesFound: notification.profilesFound.id.toViewed(),
    );
    await _api.profileAction((api) => api.postMarkAutomaticProfileSearchCompletedNotificationViewed(viewed))
      .andThen((_) => accountBackgroundDb.accountAction(
        (db) => db.notification.profilesFound.updateViewedId(viewed.profilesFound)
      ));
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
class ProfileFavoriteStatusChange extends ProfileChange {
  final AccountId profile;
  final bool isFavorite;
  ProfileFavoriteStatusChange(this.profile, this.isFavorite);
}
class ReloadMainProfileView extends ProfileChange {
  final BehaviorSubject<bool> eventHandled;
  final bool showOnlyFavorites;
  ReloadMainProfileView({required this.showOnlyFavorites}) :
    eventHandled = BehaviorSubject.seeded(false);
  ReloadMainProfileView.withEventHandlingTracking({
    required this.showOnlyFavorites,
    BehaviorSubject<bool>? eventHandlingTracking,
  }) : eventHandled = eventHandlingTracking ?? BehaviorSubject.seeded(false);
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
