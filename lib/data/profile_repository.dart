import 'dart:async';

import 'package:app/data/chat_repository.dart';
import 'package:app/data/general/notification/state/automatic_profile_search.dart';
import 'package:app/data/general/notification/state/profile_string_moderation_completed.dart';
import 'package:app/logic/profile/profile_filters.dart';
import 'package:app/utils/api.dart';
import 'package:app/utils/stream.dart';
import 'package:async/async.dart' show StreamExtensions;
import 'package:openapi/api.dart';
import 'package:app/api/server_connection_manager.dart';
import 'package:app/data/account_repository.dart';
import 'package:app/data/general/notification/state/message_received.dart';
import 'package:app/data/media_repository.dart';
import 'package:app/data/profile/profile_downloader.dart';
import 'package:app/data/utils.dart';
import 'package:database/database.dart';
import 'package:app/database/account_database_manager.dart';
import 'package:app/utils/app_error.dart';
import 'package:app/utils/result.dart';
import 'package:rxdart/rxdart.dart';
import 'package:utils/utils.dart';

class ProfileRepository extends DataRepositoryWithLifecycle {
  final AccountDatabaseManager db;
  final ApiManager _api;
  final ServerConnectionManager connectionManager;

  final MediaRepository media;
  final AccountRepository account;

  final AccountId currentUser;

  ProfileRepository(this.media, this.account, this.db, this.connectionManager, this.currentUser)
    : _api = connectionManager;

  final PublishSubject<ProfileChange> _profileChangesRelay = PublishSubject();
  void sendProfileChange(ProfileChange change) {
    _profileChangesRelay.add(change);
  }

  Stream<ProfileChange> get profileChanges => _profileChangesRelay;

  Stream<Location> get location => db.accountStreamOrDefault(
    (db) => db.myProfile.watchProfileLocation(),
    Location(latitude: 0.0, longitude: 0.0),
  );

  Stream<ProfileAttributes?> get profileAttributes =>
      db.accountStream((db) => db.config.watchAvailableProfileAttributes());

  @override
  Future<void> init() async {
    // empty
  }

  @override
  Future<void> dispose() async {
    await _profileChangesRelay.close();
  }

  @override
  Future<void> onLogin() async {
    await db.accountAction((db) => db.app.updateProfileSyncDone(false));
  }

  @override
  Future<Result<(), ()>> onLoginDataSync() async {
    return await reloadLocation()
        .andThen((_) => reloadProfileFilters())
        .andThen((_) => reloadSearchAgeRange())
        .andThen((_) => reloadSearchGroups())
        .andThen((_) => reloadAutomaticProfileSearchSettings())
        .andThen((_) async {
          await downloadInitialSetupAgeInfoIfNull(skipIfAccountStateIsInitialSetup: true);
          return const Ok(());
        })
        .andThen((_) => reloadFavoriteProfiles())
        .andThen((_) => _reloadProfileNotificationSettings())
        .andThen((_) => reloadProfilePrivacySettings())
        .andThenEmptyErr((_) => db.accountAction((db) => db.app.updateProfileSyncDone(true)));
  }

  @override
  Future<void> onInitialSetupComplete() async {
    await reloadLocation();
    await reloadMyProfile();
    await reloadProfileFilters();
    await reloadSearchAgeRange();
    await reloadSearchGroups();
    await reloadAutomaticProfileSearchSettings();
    // The account state might still be InitialSetup as events from server
    // updates the state, so skip account state check.
    await downloadInitialSetupAgeInfoIfNull(skipIfAccountStateIsInitialSetup: true);
  }

  @override
  Future<void> onLogout() async {
    await db.accountAction((db) => db.app.updateProfileFilterFavorites(false));
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
  Future<ProfileEntry?> downloadProfile(AccountId id) async {
    await connectionManager.tryWaitUntilConnected(waitTimeoutSeconds: 5);
    final entry = await ProfileEntryDownloader(media, db, _api).download(id).ok();
    return entry;
  }

  /// Get cached (if available), latest profile if needed
  /// and future profile updates.
  Stream<ProfileEntry?> getProfileStream(
    ChatRepository chat,
    AccountId id,
    ProfileRefreshPriority priority,
  ) async* {
    final dbProfileIteator = StreamIterator(
      db.accountStream((db) => db.profile.watchProfileEntry(id)),
    );

    final profile = await dbProfileIteator.next();
    yield profile;

    bool download = true;

    final lastRefreshTime = await db
        .accountData((db) => db.profile.getProfileDataRefreshTime(id))
        .ok();
    if (profile != null && lastRefreshTime != null) {
      final currentTime = UtcDateTime.now();
      final difference = currentTime.dateTime.difference(lastRefreshTime.dateTime);
      final int timePassedAtLeastSeconds = switch (priority) {
        ProfileRefreshPriority.low => 60 * 15,
      };
      if (difference.inSeconds < timePassedAtLeastSeconds) {
        download = false;
      }
    }

    if (download) {
      download = await connectionManager.tryWaitUntilConnected(waitTimeoutSeconds: 10);
    }

    if (download) {
      final isMatch = await chat.isInMatches(id);
      await ProfileEntryDownloader(media, db, _api).download(id, isMatch: isMatch);
    }

    while (true) {
      final profile = await dbProfileIteator.next();
      if (profile != null) {
        yield profile;
      } else {
        return;
      }
    }
  }

  Future<void> downloadProfileToDatabase(ChatRepository chat, AccountId id) async {
    final isMatch = await chat.isInMatches(id);
    await ProfileEntryDownloader(media, db, _api).download(id, isMatch: isMatch);
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

    final Result<(), ActionApiError> status;
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
      _profileChangesRelay.add(ProfileFavoriteStatusChange(accountId, newValue));
      return newValue;
    }
  }

  Future<void> changeProfileFilterFavorites(bool showOnlyFavorites) async {
    await db.accountAction((db) => db.app.updateProfileFilterFavorites(showOnlyFavorites));
  }

  Future<bool> getFilterFavoriteProfilesValue() async {
    return await db.accountStreamSingleOrDefault(
      (db) => db.app.watchProfileFilterFavorites(),
      false,
    );
  }

  /// Save client config from server to local database and return them.
  Future<Result<ClientConfig, ()>> receiveClientConfig() async {
    final config = await _api.common((api) => api.getClientConfig()).ok();
    if (config == null) {
      return const Err(());
    }
    final latestAttributes = config.profileAttributes?.attributes ?? [];
    final attributeOrder = config.profileAttributes?.attributeOrder;

    final attributeRefreshList = await db
        .accountData((db) => db.config.getAttributeRefreshList(latestAttributes))
        .ok();
    if (attributeRefreshList == null) {
      return const Err(());
    }

    final List<ProfileAttributesConfigQueryItem> updatedAttributes;
    if (attributeRefreshList.isEmpty) {
      updatedAttributes = [];
    } else {
      final r = await _api
          .profile(
            (api) => api.postGetQueryProfileAttributesConfig(
              ProfileAttributesConfigQuery(values: attributeRefreshList),
            ),
          )
          .ok();
      if (r == null) {
        return const Err(());
      }
      updatedAttributes = r.values;
    }

    final CustomReportsConfigHash? customReportsConfigHash;
    final CustomReportsConfig? customReportsConfig;
    switch (await _downloadCustomReportsIfNeeded(config.customReports)) {
      case Err():
        return const Err(());
      case Ok(v: (final hash, final config)):
        customReportsConfigHash = hash;
        customReportsConfig = config;
    }

    final ClientFeaturesConfigHash? clientFeaturesConfigHash;
    final ClientFeaturesConfig? clientFeaturesConfig;
    switch (await _downloadClientFeaturesIfNeeded(config.clientFeatures)) {
      case Err():
        return const Err(());
      case Ok(v: (final hash, final config)):
        clientFeaturesConfigHash = hash;
        clientFeaturesConfig = config;
    }

    await db.accountAction(
      (db) => db.config.updateClientConfig(
        attributeOrder,
        config.syncVersion,
        latestAttributes,
        updatedAttributes,
        customReportsConfigHash,
        customReportsConfig,
        clientFeaturesConfigHash,
        clientFeaturesConfig,
      ),
    );
    return Ok(config);
  }

  Future<Result<(CustomReportsConfigHash?, CustomReportsConfig?), ()>>
  _downloadCustomReportsIfNeeded(CustomReportsConfigHash? latestHash) async {
    final currentHash = await db
        .accountStream((db) => db.config.watchCustomReportsConfigHash())
        .firstOrNull;
    final currentConfig = await db
        .accountStream((db) => db.config.watchCustomReportsConfig())
        .firstOrNull;

    final CustomReportsConfigHash? hash;
    final CustomReportsConfig? config;
    if (latestHash != null) {
      if (currentHash == latestHash && currentConfig != null) {
        // Latest config already downloaded
        hash = currentHash;
        config = currentConfig;
      } else {
        final latestConfig = await _api
            .account((api) => api.postGetCustomReportsConfig(latestHash))
            .ok();
        if (latestConfig == null) {
          return const Err(());
        }
        hash = latestHash;
        config = latestConfig.config;
      }
    } else {
      // Custom reports disabled
      hash = null;
      config = null;
    }

    return Ok((hash, config));
  }

  Future<Result<(ClientFeaturesConfigHash?, ClientFeaturesConfig?), ()>>
  _downloadClientFeaturesIfNeeded(ClientFeaturesConfigHash? latestHash) async {
    final currentHash = await db
        .accountStream((db) => db.config.watchClientFeaturesConfigHash())
        .firstOrNull;
    final currentConfig = await db
        .accountStream((db) => db.config.watchClientFeaturesConfig())
        .firstOrNull;

    final ClientFeaturesConfigHash? hash;
    final ClientFeaturesConfig? config;
    if (latestHash != null) {
      if (currentHash == latestHash && currentConfig != null) {
        // Latest config already downloaded
        hash = currentHash;
        config = currentConfig;
      } else {
        final latestConfig = await _api
            .account((api) => api.postGetClientFeaturesConfig(latestHash))
            .ok();
        if (latestConfig == null) {
          return const Err(());
        }
        hash = latestHash;
        config = latestConfig.config;
      }
    } else {
      // Client features disabled
      hash = null;
      config = null;
    }

    return Ok((hash, config));
  }

  Future<Result<(), ()>> reloadMyProfile() async {
    return await _api.profile((api) => api.getMyProfile()).andThenEmptyErr((info) {
      return db
          .accountAction((db) => db.myProfile.setApiProfile(result: info))
          .andThenEmptyErr(
            (_) => db.accountAction((db) => db.common.updateSyncVersionProfile(info.sv)),
          );
    });
  }

  Future<Result<(), ()>> reloadFavoriteProfiles() async {
    return await _api
        .profile((api) => api.getFavoriteProfiles())
        .andThenEmptyErr((f) => db.accountAction((db) => db.profile.replaceFavorites(f.profiles)));
  }

  Future<Result<(), ()>> reloadLocation() async {
    return await _api
        .profile((api) => api.getLocation())
        .andThenEmptyErr(
          (l) => db.accountAction(
            (db) =>
                db.myProfile.updateProfileLocation(latitude: l.latitude, longitude: l.longitude),
          ),
        );
  }

  Future<Result<(), ()>> reloadProfilePrivacySettings() async {
    final settings = await _api.profile((api) => api.getProfilePrivacySettings()).ok();
    if (settings == null) {
      return const Err(());
    }
    return await db
        .accountAction((db) => db.profilePrivacy.updateProfilePrivacySettings(settings))
        .emptyErr();
  }

  Future<Result<(), ()>> reloadProfileFilters() async {
    return await _api
        .profile((api) => api.getProfileFilters())
        .andThenEmptyErr((f) => db.accountAction((db) => db.search.updateProfileFilters(f)));
  }

  Future<Result<(), ()>> updateProfileFilters(
    Map<int, ProfileAttributeFilterValueUpdate> attributeIdAndAttributeFilterMap,
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
    final update = ProfileFiltersUpdate(
      attributeFilters: attributeIdAndAttributeFilterMap.values.toList(),
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
    return await _api
        .profileAction((api) => api.postProfileFilters(update))
        .onOk(() => reloadProfileFilters())
        .empty();
  }

  Future<void> resetMainProfileIterator({EventHandlingTracker? eventHandlingTracking}) async {
    final showOnlyFavorites = await getFilterFavoriteProfilesValue();
    sendProfileChange(
      ReloadMainProfileView.withEventHandlingTracking(
        showOnlyFavorites: showOnlyFavorites,
        eventHandlingTracker: eventHandlingTracking,
      ),
    );
  }

  // Search settings

  Future<Result<(), ()>> reloadSearchAgeRange() async {
    return await _api
        .profile((api) => api.getSearchAgeRange())
        .andThenEmptyErr((r) => db.accountAction((db) => db.search.updateSearchAgeRange(r)));
  }

  Future<Result<(), ()>> reloadSearchGroups() async {
    return await _api
        .profile((api) => api.getSearchGroups())
        .andThenEmptyErr((v) => db.accountAction((db) => db.search.updateSearchGroups(v)));
  }

  Future<Result<(), ()>> reloadAutomaticProfileSearchSettings() async {
    return await _api
        .profile((api) => api.getAutomaticProfileSearchSettings())
        .andThenEmptyErr(
          (v) => db.accountAction((db) => db.search.updateAutomaticProfileSearchSettings(v)),
        );
  }

  Future<Result<(), ()>> updateSearchAgeRange(int minAge, int maxAge) async {
    final update = SearchAgeRange(min: minAge, max: maxAge);
    return await _api
        .profileAction((api) => api.postSearchAgeRange(update))
        .onOk(() => reloadSearchAgeRange())
        .emptyErr();
  }

  Future<Result<(), ()>> updateSearchGroups(SearchGroups groups) async {
    return await _api
        .profileAction((api) => api.postSearchGroups(groups))
        .onOk(() => reloadSearchGroups())
        .emptyErr();
  }

  Future<Result<(), ()>> updateAutomaticProfileSearchSettings(
    AutomaticProfileSearchSettings settings,
  ) async {
    return await _api
        .profileAction((api) => api.postAutomaticProfileSearchSettings(settings))
        .onOk(() => reloadAutomaticProfileSearchSettings())
        .emptyErr();
  }

  Future<Result<(), ()>> resetUnreadMessagesCount(AccountId accountId) async {
    // Hide notification
    await NotificationMessageReceived.getInstance().updateMessageReceivedCount(
      accountId,
      0,
      null,
      db,
    );
    return db
        .accountAction(
          (db) => db.chatUnreadMessagesCount.setUnreadMessagesCount(
            accountId,
            const UnreadMessagesCount(0),
          ),
        )
        .emptyErr();
  }

  /// Latest conversation is the first conversation in every emitted list
  Stream<List<AccountId>> getConversationListUpdates() {
    return db.accountStreamOrDefault(
      (db) => db.conversationList.watchConversationList(),
      <AccountId>[],
    );
  }

  Stream<UnreadMessagesCount?> getUnreadMessagesCountStream(AccountId accountId) {
    return db.accountStream((db) => db.chatUnreadMessagesCount.watchUnreadMessageCount(accountId));
  }

  Future<void> downloadInitialSetupAgeInfoIfNull({
    required bool skipIfAccountStateIsInitialSetup,
  }) async {
    if (skipIfAccountStateIsInitialSetup) {
      final state = await account.accountState.firstOrNull;
      if (state == AccountState.initialSetup) {
        // It is not possible to download the info when
        // the state is initial setup.
        return;
      }
    }

    final value = await db.accountStreamSingle((db) => db.myProfile.watchInitialAgeInfo()).ok();
    if (value != null) {
      // Already downloaded
      return;
    }

    final apiResult = await _api.profile((api) => api.getInitialProfileAge());
    switch (apiResult) {
      case Err():
        return;
      case Ok(:final v):
        final info = v.value;
        if (info == null) {
          // Initial setup is ongoing. This might happen at least for
          // new accounts as onLogin runs for those and client might not
          // received the state yet. That could be perhaps avoided by
          // skipping null values from the skipIfAccountStateIsInitialSetup
          // related account state stream, but extra API call does not matter
          // that much.
        } else {
          await db.accountAction((db) => db.myProfile.setInitialAgeInfo(info: info));
        }
    }
  }

  Future<Result<(), ()>> _reloadProfileNotificationSettings() async {
    return await _api
        .profile((api) => api.getProfileAppNotificationSettings())
        .andThenEmptyErr(
          (v) => db.accountAction(
            (db) => db.appNotificationSettings.updateProfileNotificationSettings(v),
          ),
        );
  }

  Future<void> handleProfileStringModerationCompletedEvent() async {
    final notification = await _api
        .profile((api) => api.postGetProfileStringModerationCompletedNotification())
        .ok();

    if (notification == null) {
      return;
    }

    await NotificationProfileStringModerationCompleted.handleNameAccepted(
      notification.nameAccepted,
      db,
      onlyDbUpdate: notification.hidden,
    );
    await NotificationProfileStringModerationCompleted.handleNameRejected(
      notification.nameRejected,
      db,
      onlyDbUpdate: notification.hidden,
    );
    await NotificationProfileStringModerationCompleted.handleTextAccepted(
      notification.textAccepted,
      db,
      onlyDbUpdate: notification.hidden,
    );
    await NotificationProfileStringModerationCompleted.handleTextRejected(
      notification.textRejected,
      db,
      onlyDbUpdate: notification.hidden,
    );

    final viewed = ProfileStringModerationCompletedNotificationViewed(
      nameAccepted: notification.nameAccepted.id.toViewed(),
      nameRejected: notification.nameRejected.id.toViewed(),
      textAccepted: notification.textAccepted.id.toViewed(),
      textRejected: notification.textRejected.id.toViewed(),
    );
    await _api
        .profileAction(
          (api) => api.postMarkProfileStringModerationCompletedNotificationViewed(viewed),
        )
        .andThen(
          (_) => db.accountAction(
            (db) => db.app.profileTextAccepted.updateViewedId(viewed.textAccepted),
          ),
        )
        .andThen(
          (_) => db.accountAction(
            (db) => db.app.profileTextRejected.updateViewedId(viewed.textRejected),
          ),
        );
  }

  Future<void> handleAutomaticProfileSearchCompletedEvent() async {
    final notification = await _api
        .profile((api) => api.postGetAutomaticProfileSearchCompletedNotification())
        .ok();

    if (notification == null) {
      return;
    }

    await NotificationAutomaticProfileSearch.handleAutomaticProfileSearchCompleted(
      notification,
      db,
      onlyDbUpdate: notification.hidden,
    );

    final viewed = AutomaticProfileSearchCompletedNotificationViewed(
      profilesFound: notification.profilesFound.id.toViewed(),
    );
    await _api
        .profileAction(
          (api) => api.postMarkAutomaticProfileSearchCompletedNotificationViewed(viewed),
        )
        .andThen(
          (_) =>
              db.accountAction((db) => db.app.profilesFound.updateViewedId(viewed.profilesFound)),
        );
  }
}

sealed class ProfileChange {}

/// NOTE: Currently unused
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
  final EventHandlingTracker? eventHandlingTracker;
  final bool showOnlyFavorites;
  ReloadMainProfileView({required this.showOnlyFavorites}) : eventHandlingTracker = null;
  ReloadMainProfileView.withEventHandlingTracking({
    required this.showOnlyFavorites,
    required this.eventHandlingTracker,
  });
}

enum ConversationChangeType { messageSent, messageReceived, messageRemoved, messageResent }

enum ProfileRefreshPriority {
  /// Refresh if 15 minutes have passed since last refresh
  low,
}
