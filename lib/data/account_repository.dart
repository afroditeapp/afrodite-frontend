
import 'dart:async';
import 'dart:typed_data';

import 'package:app/data/general/notification/state/news_item_available.dart';
import 'package:app/database/account_background_database_manager.dart';
import 'package:database/database.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:app/api/api_manager.dart';
import 'package:app/data/account/client_id_manager.dart';
import 'package:app/data/account/initial_setup.dart';
import 'package:app/data/login_repository.dart';
import 'package:app/data/utils.dart';
import 'package:app/database/account_database_manager.dart';
import 'package:app/model/freezed/logic/account/initial_setup.dart';
import 'package:app/utils/api.dart';
import 'package:app/utils/result.dart';
import 'package:rxdart/rxdart.dart';
import 'package:utils/utils.dart';

var log = Logger("AccountRepository");

enum AccountRepositoryState {
  initRequired,
  initComplete,
}

const ProfileVisibility PROFILE_VISIBILITY_DEFAULT =
  ProfileVisibility.pendingPrivate;

class AccountRepository extends DataRepositoryWithLifecycle {
  final ConnectedActionScheduler _syncHandler;
  final ClientIdManager clientIdManager;
  final ApiManager api;
  final AccountDatabaseManager db;
  final AccountBackgroundDatabaseManager accountBackgroundDb;
  final AccountId currentUser;

  late final RepositoryInstances repositories;
  AccountRepository({
    required this.db,
    required this.accountBackgroundDb,
    required this.api,
    required ServerConnectionManager connectionManager,
    required this.clientIdManager,
    required bool rememberToInitRepositoriesLateFinal,
    required this.currentUser,
  }) :
    _syncHandler = ConnectedActionScheduler(connectionManager);

  final BehaviorSubject<AccountRepositoryState> _internalState =
    BehaviorSubject.seeded(AccountRepositoryState.initRequired);

  final CachedValues _cachedValues = CachedValues();

  // TODO(prod): Default value for AccountState?

  Stream<AccountState?> get accountState => db
    .accountStream((db) => db.watchAccountState());
  Stream<String?> get emailAddress => _cachedValues._cachedEmailAddress;
  Stream<Permissions> get permissions => db
    .accountStreamOrDefault(
      (db) => db.watchPermissions(),
      Permissions(),
    );
  Stream<ProfileVisibility> get profileVisibility => _cachedValues._cachedProfileVisibility;

  ProfileVisibility get profileVisibilityValue => _cachedValues._cachedProfileVisibility.value;
  String? get emailAddressValue => _cachedValues._cachedEmailAddress.value;
  AccountState? get accountStateValue => _cachedValues._cachedAccountState.value;

  // WebSocket related event streams
  final _contentProcessingStateChanges = PublishSubject<ContentProcessingStateChanged>();
  Stream<ContentProcessingStateChanged> get contentProcessingStateChanges => _contentProcessingStateChanges.stream;

  @override
  Future<void> init() async {
    if (_internalState.value != AccountRepositoryState.initRequired) {
      return;
    }
    _internalState.add(AccountRepositoryState.initComplete);

    _cachedValues._subscribe(db);
  }

  @override
  Future<void> dispose() async {
    await _cachedValues._dispose();
    await _syncHandler.dispose();
  }

  @override
  Future<void> onLogin() async {
    await db.accountAction((db) => db.daoSyncVersions.resetSyncVersions());
    await accountBackgroundDb.accountAction((db) => db.resetSyncVersions());
    await db.accountAction((db) => db.daoInitialSync.updateAccountSyncDone(false));
  }

  @override
  Future<Result<void, void>> onLoginDataSync() async {
    return await clientIdManager.getClientId()
      .andThen((_) => _reloadAccountNotificationSettings())
      .andThen((_) => db.accountAction((db) => db.daoInitialSync.updateAccountSyncDone(true)));
  }

  @override
  Future<void> onResumeAppUsage() async {
    _syncHandler.onResumeAppUsageSync(() async {
      await clientIdManager.getClientId();

      final syncDone = await db.accountStreamSingle((db) => db.daoInitialSync.watchAccountSyncDone()).ok() ?? false;
      if (!syncDone) {
        await _reloadAccountNotificationSettings()
          .andThen((_) => db.accountAction((db) => db.daoInitialSync.updateAccountSyncDone(true)));
      }
    });
  }

  Future<void> _receiveAccountState() async {
    final result = await api.account((api) =>
      api.getAccountState()
    ).ok();
    if (result != null) {
      await db.accountAction((db) => db.updateAccountState(result));
    }
  }

  // TODO: Background futures might cause issues
  // for example if logout is made while in background.
  // (account specific databases solves this?)

  Future<void> handleEventToClient(EventToClient event) async {
    log.finer("Event from server: $event");

    final chat = repositories.chat;
    final profile = repositories.profile;
    final media = repositories.media;

    final contentProcessingEvent = event.contentProcessingStateChanged;
    final maintenanceEvent = event.scheduledMaintenanceStatus;
    if (event.event == EventType.accountStateChanged) {
      await _receiveAccountState();
    } else if (event.event == EventType.contentProcessingStateChanged && contentProcessingEvent != null) {
      _contentProcessingStateChanges.add(contentProcessingEvent);
    } else if (event.event == EventType.scheduledMaintenanceStatus && maintenanceEvent != null ) {
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
    } else if (event.event == EventType.profileTextModerationCompleted) {
      await profile.handleProfileTextModerationCompletedEvent();
    } else if (event.event == EventType.automaticProfileSearchCompleted) {
      await profile.handleAutomaticProfileSearchCompletedEvent();
    } else if (event.event == EventType.mediaContentChanged) {
      await media.reloadMyMediaContent();
    } else if (event.event == EventType.dailyLikesLeftChanged) {
      await chat.reloadDailyLikesLimit();
    } else if (event.event == EventType.adminNotification) {
      await receiveAdminNotification();
    } else {
      log.error("Unknown EventToClient");
    }
  }

  /// Do quick initial setup with some predefined values.
  ///
  /// Return null on success. Return String if error.
  Future<String?> doDeveloperInitialSetup(
    String email,
    String name,
    Uint8List securitySelfieBytes,
    Uint8List profileImageBytes
  ) async {
    final resultString = await InitialSetupUtils(api).doDeveloperInitialSetup(
      email,
      name,
      securitySelfieBytes,
      profileImageBytes
    );

    if (resultString == null) {
      // Success
      await LoginRepository.getInstance().onInitialSetupComplete();
      await repositories.onInitialSetupComplete();
    }
    return resultString;
  }

  Future<Result<void, void>> doInitialSetup(
    InitialSetupData data,
  ) async {
    final result = await InitialSetupUtils(api).doInitialSetup(data);
    if (result.isOk()) {
      await LoginRepository.getInstance().onInitialSetupComplete();
      await repositories.onInitialSetupComplete();
    }
    return result;
  }

  /// Returns true if successful.
  Future<bool> doProfileVisibilityChange(bool profileVisiblity) async {
    final result = await api.accountAction((api) =>
      api.putSettingProfileVisiblity(BooleanSetting(value: profileVisiblity))
    );

    return result.isOk();
  }

  /// Returns true if successful.
  Future<bool> updateUnlimitedLikesWithoutReloadingProfile(bool unlimitedLikes) async {
    final result = await api.accountAction((api) => api.putSettingUnlimitedLikes(BooleanSetting(value: unlimitedLikes)));
    return result.isOk();
  }

  Future<bool> isInitialModerationOngoing() async {
    final visibility = await profileVisibility.first;
    return visibility.isInitialModerationOngoing();
  }

  Future<Result<AccountSetup, ()>> downloadAccountSetup() async {
    return await api.account((api) => api.getAccountSetup())
      .mapErr((_) => ());
  }

  Future<Result<AccountData, ()>> downloadAccountData() async {
    return await api.account((api) => api.getAccountData())
      .mapErr((_) => ());
  }

  Future<Result<void, void>> moveAccountToPendingDeletionState() async {
    return await api.accountAction((api) => api.postSetAccountDeletionRequestState(currentUser.aid, BooleanSetting(value: true)))
      .mapErr((_) => ())
      .mapOk((_) => ());
  }

  Future<Result<void, void>> receiveNewsCount() async {
    final r = await api.account((api) => api.postGetUnreadNewsCount()).ok();
    if (r != null) {
      return await NotificationNewsItemAvailable.getInstance().handleNewsCountUpdate(r, accountBackgroundDb);
    }
    return const Err(null);
  }

  Future<Result<void, void>> receiveAdminNotification() async {
    final r = await api.accountCommonAdmin((api) => api.postGetAdminNotification()).ok();
    if (r != null) {
      final viewedNotification = await accountBackgroundDb.accountData((db) => db.daoAdminNotificationTable.getNotification()).ok();
      if (viewedNotification != null && r == viewedNotification) {
        // Prevent showing the same notification again when the notification
        // is already received as push notification.
      } else {
        await NotificationNewsItemAvailable.getInstance().showAdminNotification(r, accountBackgroundDb);
      }
      return await accountBackgroundDb.accountData((db) => db.daoAdminNotificationTable.removeNotification());
    }
    return const Err(null);
  }

  Future<Result<void, void>> handleServerMaintenanceStatusEvent(ScheduledMaintenanceStatus event) {
    // Workaroud OpenAPI generator bug
    final UnixTime? time;
    final timeRaw = event.scheduledMaintenance?.ut;
    if (timeRaw != null) {
      time = UnixTime(ut: timeRaw);
    } else {
      time = null;
    }
    return db.accountAction((db) => db.daoServerMaintenance.setMaintenanceTime(
      time: time?.toUtcDateTime(),
    ));
  }

  Future<Result<void, void>> _reloadAccountNotificationSettings() async {
    return await api.account((api) => api.getAccountAppNotificationSettings())
      .andThen((v) => accountBackgroundDb.accountAction(
        (db) => db.daoAppNotificationSettingsTable.updateAccountNotificationSettings(v),
      ));
  }
}

class CachedValues {
  final BehaviorSubject<String?> _cachedEmailAddress =
    BehaviorSubject.seeded(null);
  StreamSubscription<String?>? _cachedEmailSubscription;
  final BehaviorSubject<ProfileVisibility> _cachedProfileVisibility =
    BehaviorSubject.seeded(PROFILE_VISIBILITY_DEFAULT);
  StreamSubscription<ProfileVisibility>? _cachedProfileVisibilitySubscription;
  final BehaviorSubject<AccountState?> _cachedAccountState =
    BehaviorSubject.seeded(null);
  StreamSubscription<AccountState?>? _cachedAccountStateSubscription;

  void _subscribe(AccountDatabaseManager db) {
    _cachedEmailSubscription = db
      .accountStream((db) => db.daoAccountSettings.watchEmailAddress())
      .listen((v) {
        _cachedEmailAddress.add(v);
      });

    _cachedProfileVisibilitySubscription = db
      .accountStreamOrDefault((db) => db.watchProfileVisibility(), PROFILE_VISIBILITY_DEFAULT)
      .listen((v) {
        _cachedProfileVisibility.add(v);
      });

    _cachedAccountStateSubscription = db
      .accountStream((db) => db.watchAccountState())
      .listen((v) {
        _cachedAccountState.add(v);
      });
  }

  Future<void> _dispose() async {
    await _cachedEmailSubscription?.cancel();
    await _cachedProfileVisibilitySubscription?.cancel();
    await _cachedAccountStateSubscription?.cancel();
  }
}
