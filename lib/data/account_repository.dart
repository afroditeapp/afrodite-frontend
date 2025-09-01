import 'dart:async';
import 'dart:typed_data';

import 'package:app/data/general/notification/state/news_item_available.dart';
import 'package:app/data/utils/repository_instances.dart';
import 'package:app/database/account_background_database_manager.dart';
import 'package:app/database/background_database_manager.dart';
import 'package:database/database.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:app/api/server_connection_manager.dart';
import 'package:app/data/account/client_id_manager.dart';
import 'package:app/data/account/initial_setup.dart';
import 'package:app/data/utils.dart';
import 'package:app/database/account_database_manager.dart';
import 'package:app/model/freezed/logic/account/initial_setup.dart';
import 'package:app/utils/api.dart';
import 'package:app/utils/result.dart';
import 'package:rxdart/rxdart.dart';
import 'package:utils/utils.dart';

final _log = Logger("AccountRepository");

enum AccountRepositoryState { initRequired, initComplete }

const ProfileVisibility PROFILE_VISIBILITY_DEFAULT = ProfileVisibility.pendingPrivate;

class AccountRepository extends DataRepositoryWithLifecycle {
  final ConnectedActionScheduler _syncHandler;
  final ServerConnectionManager connectionManager;
  final ClientIdManager clientIdManager;
  final ApiManager api;
  final AccountDatabaseManager db;
  final AccountBackgroundDatabaseManager accountBackgroundDb;
  final AccountId currentUser;

  late final RepositoryInstances repositories;
  AccountRepository({
    required this.db,
    required this.accountBackgroundDb,
    required this.connectionManager,
    required this.clientIdManager,
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

  ProfileVisibility get profileVisibilityValue => _cachedValues._cachedProfileVisibility.value;
  String? get emailAddressValue => _cachedValues._cachedEmailAddress.value;
  AccountState? get accountStateValue => _cachedValues._cachedAccountState.value;

  // WebSocket related event streams
  final _contentProcessingStateChanges = PublishSubject<ContentProcessingStateChanged>();
  Stream<ContentProcessingStateChanged> get contentProcessingStateChanges =>
      _contentProcessingStateChanges.stream;
  StreamSubscription<ServerWsEvent>? _serverEvents;

  @override
  Future<void> init() async {
    if (_internalState.value != AccountRepositoryState.initRequired) {
      return;
    }
    _internalState.add(AccountRepositoryState.initComplete);

    _cachedValues._subscribe(db);
    _serverEvents = connectionManager.serverEvents
        .asyncMap((event) async {
          switch (event) {
            case EventToClientContainer e:
              await handleEventToClient(e.event);
          }
          return event;
        })
        .listen((_) {});
  }

  @override
  Future<void> dispose() async {
    await _cachedValues._dispose();
    await _syncHandler.dispose();
    await _serverEvents?.cancel();
    await _contentProcessingStateChanges.close();
    await _internalState.close();
  }

  @override
  Future<void> onLogin() async {
    await db.accountAction((db) => db.common.resetSyncVersions());
    await accountBackgroundDb.accountAction((db) => db.resetSyncVersions());
    await db.accountAction((db) => db.app.updateAccountSyncDone(false));
    await db.accountAction((db) => db.common.updateClientLanguageOnServer(null));
  }

  @override
  Future<Result<(), ()>> onLoginDataSync() async {
    return await clientIdManager
        .getClientId()
        .andThen((_) => _reloadAccountNotificationSettings())
        .andThen((_) => _reloadClientLanguageOnServer())
        .andThenEmptyErr((_) => db.accountAction((db) => db.app.updateAccountSyncDone(true)));
  }

  @override
  Future<void> onResumeAppUsage() async {
    _syncHandler.onResumeAppUsageSync(() async {
      await clientIdManager.getClientId();
      await _updateClientLanguageIfNeeded();

      final syncDone =
          await db.accountStreamSingle((db) => db.app.watchAccountSyncDone()).ok() ?? false;
      if (!syncDone) {
        await _reloadAccountNotificationSettings()
            .andThen((_) => _reloadClientLanguageOnServer())
            .andThenEmptyErr((_) => db.accountAction((db) => db.app.updateAccountSyncDone(true)));
      }
    });
  }

  Future<void> _receiveAccountState() async {
    final result = await api.account((api) => api.getAccountState()).ok();
    if (result != null) {
      await db.accountAction((db) => db.account.updateAccountState(result));
    }
  }

  Future<void> handleEventToClient(EventToClient event) async {
    _log.finer("Event from server: $event");

    final chat = repositories.chat;
    final profile = repositories.profile;
    final media = repositories.media;

    final contentProcessingEvent = event.contentProcessingStateChanged;
    final maintenanceEvent = event.scheduledMaintenanceStatus;
    if (event.event == EventType.accountStateChanged) {
      await _receiveAccountState();
    } else if (event.event == EventType.contentProcessingStateChanged &&
        contentProcessingEvent != null) {
      _contentProcessingStateChanges.add(contentProcessingEvent);
    } else if (event.event == EventType.scheduledMaintenanceStatus && maintenanceEvent != null) {
      await handleServerMaintenanceStatusEvent(maintenanceEvent);
    } else if (event.event == EventType.receivedLikesChanged) {
      await chat.receivedLikesCountRefresh();
    } else if (event.event == EventType.newMessageReceived) {
      await chat.receiveNewMessages();
    } else if (event.event == EventType.clientConfigChanged) {
      await profile.receiveClientConfig();
    } else if (event.event == EventType.profileChanged) {
      await profile.reloadMyProfile();
    } else if (event.event == EventType.newsCountChanged) {
      await receiveNewsCount();
    } else if (event.event == EventType.mediaContentModerationCompleted) {
      await media.handleMediaContentModerationCompletedEvent();
    } else if (event.event == EventType.profileStringModerationCompleted) {
      await profile.handleProfileStringModerationCompletedEvent();
    } else if (event.event == EventType.automaticProfileSearchCompleted) {
      await profile.handleAutomaticProfileSearchCompletedEvent();
    } else if (event.event == EventType.mediaContentChanged) {
      await media.reloadMyMediaContent();
    } else if (event.event == EventType.dailyLikesLeftChanged) {
      await chat.reloadDailyLikesLimit();
    } else if (event.event == EventType.adminNotification) {
      await receiveAdminNotification();
    } else {
      _log.error("Unknown EventToClient");
    }
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

  Future<bool> isInitialModerationOngoing() async {
    final visibility = await profileVisibility.first;
    return visibility.isInitialModerationOngoing();
  }

  Future<Result<AccountSetup, ()>> downloadAccountSetup() async {
    return await api.account((api) => api.getAccountSetup()).mapErr((_) => ());
  }

  Future<Result<AccountData, ()>> downloadAccountData() async {
    return await api.account((api) => api.getAccountData()).mapErr((_) => ());
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

  Future<Result<(), ()>> receiveNewsCount() async {
    final r = await api.account((api) => api.postGetUnreadNewsCount()).ok();
    if (r != null) {
      return await NotificationNewsItemAvailable.getInstance().handleNewsCountUpdate(
        r,
        accountBackgroundDb,
      );
    }
    return const Err(());
  }

  Future<Result<(), ()>> receiveAdminNotification() async {
    final r = await api.commonAdmin((api) => api.postGetAdminNotification()).ok();
    if (r != null) {
      final viewedNotification = await accountBackgroundDb
          .accountData((db) => db.notification.getAdminNotification())
          .ok();
      if (viewedNotification != null && r == viewedNotification) {
        // Prevent showing the same notification again when the notification
        // is already received as push notification.
      } else {
        await NotificationNewsItemAvailable.getInstance().showAdminNotification(
          r,
          accountBackgroundDb,
        );
      }
      return await accountBackgroundDb
          .accountAction((db) => db.notification.removeAdminNotification())
          .emptyErr();
    }
    return const Err(());
  }

  Future<Result<(), ()>> handleServerMaintenanceStatusEvent(ScheduledMaintenanceStatus event) {
    // Workaroud OpenAPI generator bug
    final UnixTime? time;
    final timeRaw = event.scheduledMaintenance?.ut;
    if (timeRaw != null) {
      time = UnixTime(ut: timeRaw);
    } else {
      time = null;
    }
    return db
        .accountAction((db) => db.common.setMaintenanceTime(time: time?.toUtcDateTime()))
        .emptyErr();
  }

  Future<Result<(), ()>> _reloadAccountNotificationSettings() async {
    return await api
        .account((api) => api.getAccountAppNotificationSettings())
        .andThenEmptyErr(
          (v) => accountBackgroundDb.accountAction(
            (db) => db.appNotificationSettings.updateAccountNotificationSettings(v),
          ),
        );
  }

  Future<Result<(), ()>> _reloadClientLanguageOnServer() async {
    return await api
        .common((api) => api.getClientLanguage())
        .andThenEmptyErr(
          (v) => db.accountAction((db) => db.common.updateClientLanguageOnServer(v)),
        );
  }

  Future<void> _updateClientLanguageIfNeeded() async {
    final clientLanguageOnServer = await db
        .accountStreamSingle((db) => db.common.watchClientLanguageOnServer())
        .ok();
    final clientLocale = await BackgroundDatabaseManager.getInstance().commonStreamSingle(
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

class CachedValues {
  final BehaviorSubject<String?> _cachedEmailAddress = BehaviorSubject.seeded(null);
  StreamSubscription<String?>? _cachedEmailSubscription;
  final BehaviorSubject<ProfileVisibility> _cachedProfileVisibility = BehaviorSubject.seeded(
    PROFILE_VISIBILITY_DEFAULT,
  );
  StreamSubscription<ProfileVisibility>? _cachedProfileVisibilitySubscription;
  final BehaviorSubject<AccountState?> _cachedAccountState = BehaviorSubject.seeded(null);
  StreamSubscription<AccountState?>? _cachedAccountStateSubscription;

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
  }

  Future<void> _dispose() async {
    await _cachedEmailSubscription?.cancel();
    await _cachedProfileVisibilitySubscription?.cancel();
    await _cachedAccountStateSubscription?.cancel();
    await _cachedEmailAddress.close();
    await _cachedProfileVisibility.close();
    await _cachedAccountState.close();
  }
}
