import 'dart:async';
import 'dart:typed_data';

import 'package:app/data/general/notification/state/automatic_profile_search.dart';
import 'package:app/data/general/notification/state/media_content_moderation_completed.dart';
import 'package:app/data/general/notification/state/news_item_available.dart';
import 'package:app/data/general/notification/state/like_received.dart';
import 'package:app/data/general/notification/state/profile_string_moderation_completed.dart';
import 'package:app/data/event/event_router.dart';
import 'package:app/data/utils/repository_instances.dart';
import 'package:app/database/common_database_manager.dart';
import 'package:database/database.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:app/api/server_connection_manager.dart';
import 'package:app/api/server_connection_protocol/server.dart';
import 'package:app/data/account/initial_setup.dart';
import 'package:app/data/utils.dart';
import 'package:app/database/account_database_manager.dart';
import 'package:app/model/freezed/logic/account/initial_setup.dart';
import 'package:app/utils/api.dart';
import 'package:app/utils/result.dart';
import 'package:rxdart/rxdart.dart';

final _log = Logger("AccountRepository");

enum AccountRepositoryState { initRequired, initComplete }

const ProfileVisibility PROFILE_VISIBILITY_DEFAULT = ProfileVisibility.pendingPrivate;

class AccountRepository extends DataRepositoryWithLifecycle {
  final ConnectedActionScheduler _syncHandler;
  final ServerConnectionManager connectionManager;
  final ApiManager api;
  final AccountDatabaseManager db;
  final AccountId currentUser;

  late final RepositoryInstances repositories;
  AccountRepository({
    required this.db,
    required this.connectionManager,
    required bool rememberToInitRepositoriesLateFinal,
    required this.currentUser,
  }) : _syncHandler = ConnectedActionScheduler(connectionManager),
       api = connectionManager;

  final BehaviorSubject<AccountRepositoryState> _internalState = BehaviorSubject.seeded(
    AccountRepositoryState.initRequired,
  );

  final CachedValues _cachedValues = CachedValues();

  Stream<AccountState?> get accountState =>
      db.accountStream((db) => db.account.watchAccountState());
  Stream<String?> get emailAddress => _cachedValues._cachedEmailAddress;
  Stream<Permissions> get permissions =>
      db.accountStreamOrDefault((db) => db.account.watchPermissions(), Permissions());
  Stream<ProfileVisibility> get profileVisibility => _cachedValues._cachedProfileVisibility;
  Stream<ClientFeaturesConfig> get clientFeaturesConfig =>
      _cachedValues._cachedClientFeaturesConfig;
  Stream<DynamicClientFeaturesConfig> get dynamicClientFeaturesConfig =>
      _cachedValues._cachedDynamicClientFeaturesConfig;
  Stream<Map<String, InfoBannerDismissState>> get infoBannerDismissStates =>
      _cachedValues._cachedInfoBannerDismissStates;

  ProfileVisibility get profileVisibilityValue => _cachedValues._cachedProfileVisibility.value;
  String? get emailAddressValue => _cachedValues._cachedEmailAddress.value;
  AccountState? get accountStateValue => _cachedValues._cachedAccountState.value;
  ClientFeaturesConfig get clientFeaturesConfigValue =>
      _cachedValues._cachedClientFeaturesConfig.value;
  DynamicClientFeaturesConfig get dynamicClientFeaturesConfigValue =>
      _cachedValues._cachedDynamicClientFeaturesConfig.value;
  Map<String, InfoBannerDismissState> get infoBannerDismissStatesValue =>
      _cachedValues._cachedInfoBannerDismissStates.value;

  // WebSocket related event streams
  final _contentProcessingStateChanges = PublishSubject<ContentProcessingStateChanged>();
  Stream<ContentProcessingStateChanged> get contentProcessingStateChanges =>
      _contentProcessingStateChanges.stream;
  StreamSubscription<ServerWsEvent>? _serverEvents;
  EventRouter? _eventRouter;

  @override
  Future<void> init() async {
    if (_internalState.value != AccountRepositoryState.initRequired) {
      return;
    }
    _internalState.add(AccountRepositoryState.initComplete);

    _cachedValues._subscribe(db);
    _eventRouter ??= EventRouter(repositories: repositories);
    _serverEvents = connectionManager.serverEvents.listen((event) {
      switch (event) {
        case ServerMessageContainer m:
          _eventRouter?.route(m.message);
      }
    });
  }

  @override
  Future<void> dispose() async {
    await _cachedValues._dispose();
    await _syncHandler.dispose();
    await _serverEvents?.cancel();
    await _eventRouter?.close();
    await _contentProcessingStateChanges.close();
    await _internalState.close();
  }

  @override
  Future<void> onLogin() async {
    await db.accountAction((db) => db.common.resetSyncVersions());
    await db.accountAction((db) => db.common.resetReceivedLikesSyncVersion());
    await db.accountAction((db) => db.app.resetNewsSyncVersion());
    await db.accountAction((db) => db.app.resetPushNotificationSyncVersion());
    await db.accountAction((db) => db.app.updateAccountSyncDone(false));
    await db.accountAction((db) => db.common.updateClientLanguageOnServer(null));
  }

  @override
  Future<Result<(), ()>> onLoginDataSync() async {
    return await _reloadAccountNotificationSettings()
        .andThen((_) => _reloadClientLanguageOnServer())
        .andThenEmptyErr((_) => db.accountAction((db) => db.app.updateAccountSyncDone(true)));
  }

  @override
  Future<void> onResumeAppUsage() async {
    _syncHandler.onResumeAppUsageSync(() async {
      await _updateClientLanguageIfNeeded();
    });
  }

  Future<void> receiveAccountState() async {
    final result = await api.account((api) => api.getAccountState()).ok();
    if (result != null) {
      await db.accountAction((db) => db.account.updateAccountState(result));
    }
  }

  void emitContentProcessingStateChanged(ContentProcessingStateChanged event) {
    _contentProcessingStateChanges.add(event);
  }

  /// Do quick initial setup with some predefined values.
  ///
  /// Return null on success. Return String if error.
  Future<String?> doDeveloperInitialSetup(
    String email,
    String name,
    Uint8List securitySelfieBytes,
    Uint8List profileImageBytes,
  ) async {
    final resultString = await InitialSetupUtils(
      api,
    ).doDeveloperInitialSetup(email, name, securitySelfieBytes, profileImageBytes);

    if (resultString == null) {
      // Success
      await repositories.onInitialSetupComplete();
    }
    return resultString;
  }

  Future<Result<(), ()>> doInitialSetup(InitialSetupData data) async {
    final result = await InitialSetupUtils(api).doInitialSetup(data);
    if (result.isOk()) {
      await repositories.onInitialSetupComplete();
    }
    return result;
  }

  /// Returns true if successful.
  Future<bool> doProfileVisibilityChange(bool profileVisiblity) async {
    final result = await api.accountAction(
      (api) => api.putSettingProfileVisiblity(BooleanSetting(value: profileVisiblity)),
    );

    return result.isOk();
  }

  /// Returns true if successful.
  Future<bool> updateUnlimitedLikesWithoutReloadingProfile(bool unlimitedLikes) async {
    final result = await api.accountAction(
      (api) => api.putSettingUnlimitedLikes(BooleanSetting(value: unlimitedLikes)),
    );
    return result.isOk();
  }

  Future<Result<AccountSetup, ()>> downloadAccountSetup() async {
    return await api.account((api) => api.getAccountSetup()).mapErr((_) => ());
  }

  Future<Result<EmailAddressState, ()>> downloadEmailAddressState() async {
    return await api.account((api) => api.getEmailAddressState()).mapErr((_) => ());
  }

  Future<Result<(), ()>> moveAccountToPendingDeletionState() async {
    return await api
        .accountAction(
          (api) =>
              api.postSetAccountDeletionRequestState(currentUser.aid, BooleanSetting(value: true)),
        )
        .mapErr((_) => ())
        .mapOk((_) => ());
  }

  Future<Result<SendVerifyEmailMessageResult, ()>> sendVerificationEmail() async {
    return await api.account((api) => api.postSendVerifyEmailMessage()).mapErr((_) => ());
  }

  Future<Result<(), ()>> receiveNewsCount() async {
    final r = await api.account((api) => api.postGetUnreadNewsCount()).ok();
    if (r != null) {
      return await db
          .accountAction((db) => db.app.setUnreadNewsCount(unreadNewsCount: r.c, version: r.v))
          .emptyErr();
    }
    return const Err(());
  }

  Future<Result<(), ()>> handlePendingAppNotificationsChangedEvent() async {
    final notifications = await api.common((api) => api.getPendingAppNotifications()).ok();
    if (notifications == null) {
      return const Err(());
    }

    if (notifications.isEmpty) {
      return const Ok(());
    }

    for (final notification in notifications) {
      await _handlePendingAppNotification(notification);
    }

    final handled = notifications
        .map(
          (v) => PendingAppNotificationToDelete(
            notificationType: v.notificationType,
            dataInteger: v.dataInteger,
          ),
        )
        .toList();

    return await api
        .commonAction((api) => api.postDeletePendingAppNotifications(handled))
        .emptyErr();
  }

  Future<void> _handlePendingAppNotification(PendingAppNotification notification) async {
    if (notification.notificationType ==
        PendingAppNotificationType.automaticProfileSearchCompleted) {
      final profileCount = notification.dataInteger ?? 0;
      if (profileCount <= 0) {
        await db.accountAction((db) => db.search.hideAutomaticProfileSearchBadge());
      } else {
        await db.accountAction((db) => db.search.showAutomaticProfileSearchBadge(profileCount));
      }
    }

    if (notification.pushNotificationSent) {
      return;
    }

    switch (notification.notificationType) {
      case PendingAppNotificationType.adminNotification:
        final flags = notification.dataInteger;
        if (flags == null) {
          _log.warning("Missing dataInteger for ${notification.notificationType}");
          return;
        }
        final adminNotification = _adminNotificationFromPendingData(flags);
        await NotificationNewsItemAvailable.getInstance().showAdminNotification(
          adminNotification,
          db,
        );
      case PendingAppNotificationType.newsChanged:
        final currentCount = notification.dataInteger;
        if (currentCount == null) {
          _log.warning("Missing dataInteger for ${notification.notificationType}");
          return;
        }
        await NotificationNewsItemAvailable.getInstance().handleNewsCountUpdate(currentCount, db);
      case PendingAppNotificationType.mediaContentModerationAccepted:
        await NotificationMediaContentModerationCompleted.handleAccepted(db);
      case PendingAppNotificationType.mediaContentModerationRejected:
        await NotificationMediaContentModerationCompleted.handleRejected(db);
      case PendingAppNotificationType.mediaContentModerationDeleted:
        await NotificationMediaContentModerationCompleted.handleDeleted(db);
      case PendingAppNotificationType.profileNameModerationCompleted:
        if (notification.dataInteger == 0) {
          await NotificationProfileStringModerationCompleted.handleNameRejected(db);
        } else if (notification.dataInteger == 1) {
          await NotificationProfileStringModerationCompleted.handleNameAccepted(db);
        } else {
          _log.warning("Unknown dataInteger for ${notification.notificationType}");
        }
      case PendingAppNotificationType.profileTextModerationCompleted:
        if (notification.dataInteger == 0) {
          await NotificationProfileStringModerationCompleted.handleTextRejected(db);
        } else if (notification.dataInteger == 1) {
          await NotificationProfileStringModerationCompleted.handleTextAccepted(db);
        } else {
          _log.warning("Unknown dataInteger for ${notification.notificationType}");
        }
      case PendingAppNotificationType.automaticProfileSearchCompleted:
        final profileCount = notification.dataInteger;
        if (profileCount == null) {
          _log.warning("Missing dataInteger for ${notification.notificationType}");
          return;
        }
        await NotificationAutomaticProfileSearch.handleAutomaticProfileSearchCompleted(
          profileCount,
          db,
        );
      case PendingAppNotificationType.receivedLikesChanged:
        final currentCount = notification.dataInteger;
        if (currentCount == null) {
          _log.warning("Missing dataInteger for ${notification.notificationType}");
          return;
        }
        await NotificationLikeReceived.getInstance().handleNewReceivedLikesCount(currentCount, db);
      default:
        _log.warning("Notification type is not supported: ${notification.notificationType}");
    }
  }

  AdminNotification _adminNotificationFromPendingData(int flags) {
    return AdminNotification(
      moderateInitialMediaContentBot: _isFlagSet(flags, 1 << 0),
      moderateInitialMediaContentHuman: _isFlagSet(flags, 1 << 1),
      moderateMediaContentBot: _isFlagSet(flags, 1 << 2),
      moderateMediaContentHuman: _isFlagSet(flags, 1 << 3),
      moderateProfileTextsBot: _isFlagSet(flags, 1 << 4),
      moderateProfileTextsHuman: _isFlagSet(flags, 1 << 5),
      moderateProfileNamesBot: _isFlagSet(flags, 1 << 6),
      moderateProfileNamesHuman: _isFlagSet(flags, 1 << 7),
      processReports: _isFlagSet(flags, 1 << 8),
    );
  }

  bool _isFlagSet(int value, int flag) {
    return (value & flag) != 0;
  }

  Future<Result<(), ()>> handleServerMaintenanceStatusEvent(ScheduledMaintenanceStatus event) {
    return db
        .accountAction(
          (db) => db.common.setMaintenanceTime(
            start: event.start?.toUtcDateTime(),
            end: event.end?.toUtcDateTime(),
            adminBotOffline: event.adminBotOffline,
          ),
        )
        .emptyErr();
  }

  Future<Result<(), ()>> dismissInfoBanner({
    required String bannerKey,
    required int bannerVersion,
  }) {
    return db
        .accountAction(
          (db) => db.config.upsertInfoBannerDismissState(
            bannerKey: bannerKey,
            bannerVersion: bannerVersion,
            dismissed: true,
          ),
        )
        .emptyErr();
  }

  Future<Result<(), ()>> _reloadAccountNotificationSettings() async {
    return await api
        .account((api) => api.getAccountAppNotificationSettings())
        .andThenEmptyErr(
          (v) => db.accountAction(
            (db) => db.appNotificationSettings.updateAccountNotificationSettings(v),
          ),
        );
  }

  Future<Result<(), ()>> _reloadClientLanguageOnServer() async {
    return await api
        .common((api) => api.getClientLanguage())
        .andThenEmptyErr(
          (v) => db.accountAction((db) => db.common.updateClientLanguageOnServer(v.l)),
        );
  }

  Future<void> _updateClientLanguageIfNeeded() async {
    final clientLanguageOnServer = await db
        .accountStreamSingle((db) => db.common.watchClientLanguageOnServer())
        .ok();
    final clientLocale = await CommonDatabaseManager.getInstance().commonStreamSingle(
      (db) => db.app.watchCurrentLocale(),
    );

    if (clientLanguageOnServer == null || clientLocale == null) {
      return;
    }

    if (clientLanguageOnServer.l != clientLocale) {
      final r = await api.commonAction(
        (db) => db.postClientLanguage(ClientLanguage(l: clientLocale)),
      );
      if (r.isOk()) {
        await _reloadClientLanguageOnServer();
      }
    }
  }
}

ClientFeaturesConfig emptyClientFeaturesConfig() {
  return ClientFeaturesConfig();
}

DynamicClientFeaturesConfig emptyDynamicClientFeaturesConfig() {
  return DynamicClientFeaturesConfig();
}

class CachedValues {
  final BehaviorSubject<String?> _cachedEmailAddress = BehaviorSubject.seeded(null);
  StreamSubscription<String?>? _cachedEmailSubscription;
  final BehaviorSubject<ProfileVisibility> _cachedProfileVisibility = BehaviorSubject.seeded(
    PROFILE_VISIBILITY_DEFAULT,
  );
  StreamSubscription<ProfileVisibility>? _cachedProfileVisibilitySubscription;
  final BehaviorSubject<AccountState?> _cachedAccountState = BehaviorSubject.seeded(null);
  StreamSubscription<AccountState?>? _cachedAccountStateSubscription;
  final BehaviorSubject<ClientFeaturesConfig> _cachedClientFeaturesConfig = BehaviorSubject.seeded(
    emptyClientFeaturesConfig(),
  );
  StreamSubscription<ClientFeaturesConfig?>? _cachedClientFeaturesConfigSubscription;
  final BehaviorSubject<DynamicClientFeaturesConfig> _cachedDynamicClientFeaturesConfig =
      BehaviorSubject.seeded(emptyDynamicClientFeaturesConfig());
  StreamSubscription<DynamicClientFeaturesConfig?>? _cachedDynamicClientFeaturesConfigSubscription;
  final BehaviorSubject<Map<String, InfoBannerDismissState>> _cachedInfoBannerDismissStates =
      BehaviorSubject.seeded(const <String, InfoBannerDismissState>{});
  StreamSubscription<List<InfoBannerDismissState>>? _cachedInfoBannerDismissStatesSubscription;

  void _subscribe(AccountDatabaseManager db) {
    _cachedEmailSubscription = db.accountStream((db) => db.account.watchEmailAddress()).listen((v) {
      _cachedEmailAddress.add(v);
    });

    _cachedProfileVisibilitySubscription = db
        .accountStreamOrDefault(
          (db) => db.account.watchProfileVisibility(),
          PROFILE_VISIBILITY_DEFAULT,
        )
        .listen((v) {
          _cachedProfileVisibility.add(v);
        });

    _cachedAccountStateSubscription = db
        .accountStream((db) => db.account.watchAccountState())
        .listen((v) {
          _cachedAccountState.add(v);
        });

    _cachedClientFeaturesConfigSubscription = db
        .accountStreamOrDefault(
          (db) => db.config.watchClientFeaturesConfig(),
          emptyClientFeaturesConfig(),
        )
        .listen((v) {
          _cachedClientFeaturesConfig.add(v);
        });

    _cachedDynamicClientFeaturesConfigSubscription = db
        .accountStreamOrDefault(
          (db) => db.config.watchDynamicClientFeaturesConfig(),
          emptyDynamicClientFeaturesConfig(),
        )
        .listen((v) {
          _cachedDynamicClientFeaturesConfig.add(v);
        });

    _cachedInfoBannerDismissStatesSubscription = db
        .accountStreamOrDefault(
          (db) => db.config.watchInfoBannerDismissStates(),
          const <InfoBannerDismissState>[],
        )
        .listen((v) {
          _cachedInfoBannerDismissStates.add({for (final item in v) item.bannerKey: item});
        });
  }

  Future<void> _dispose() async {
    await _cachedEmailSubscription?.cancel();
    await _cachedProfileVisibilitySubscription?.cancel();
    await _cachedAccountStateSubscription?.cancel();
    await _cachedClientFeaturesConfigSubscription?.cancel();
    await _cachedDynamicClientFeaturesConfigSubscription?.cancel();
    await _cachedInfoBannerDismissStatesSubscription?.cancel();
    await _cachedEmailAddress.close();
    await _cachedProfileVisibility.close();
    await _cachedAccountState.close();
    await _cachedClientFeaturesConfig.close();
    await _cachedDynamicClientFeaturesConfig.close();
    await _cachedInfoBannerDismissStates.close();
  }
}
