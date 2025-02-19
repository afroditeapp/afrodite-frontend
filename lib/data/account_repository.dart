
import 'dart:async';
import 'dart:typed_data';

import 'package:app/data/general/notification/state/news_item_available.dart';
import 'package:app/database/account_background_database_manager.dart';
import 'package:async/async.dart' show StreamExtensions;
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

  final BehaviorSubject<String?> _cachedEmailAddress =
    BehaviorSubject.seeded(null);
  StreamSubscription<String?>? _cachedEmailSubscription;
  final BehaviorSubject<ProfileVisibility> _cachedProfileVisibility =
    BehaviorSubject.seeded(PROFILE_VISIBILITY_DEFAULT);
  StreamSubscription<ProfileVisibility>? _cachedProfileVisibilitySubscription;

  Stream<AccountState?> get accountState => db
    .accountStream((db) => db.watchAccountState());
  Stream<String?> get emailAddress => _cachedEmailAddress;
  Stream<Permissions> get permissions => db
    .accountStreamOrDefault(
      (db) => db.watchPermissions(),
      Permissions(),
    );
  Stream<ProfileVisibility> get profileVisibility => _cachedProfileVisibility;

  ProfileVisibility get profileVisibilityValue => _cachedProfileVisibility.value;
  String? get emailAddressValue => _cachedEmailAddress.value;

  // WebSocket related event streams
  final _contentProcessingStateChanges = PublishSubject<ContentProcessingStateChanged>();
  Stream<ContentProcessingStateChanged> get contentProcessingStateChanges => _contentProcessingStateChanges.stream;

  @override
  Future<void> init() async {
    if (_internalState.value != AccountRepositoryState.initRequired) {
      return;
    }
    _internalState.add(AccountRepositoryState.initComplete);

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
  }

  @override
  Future<void> dispose() async {
    await _cachedEmailSubscription?.cancel();
    await _cachedProfileVisibilitySubscription?.cancel();
    await _syncHandler.dispose();
  }

  @override
  Future<void> onLogin() async {
    await db.accountAction((db) => db.daoSyncVersions.resetSyncVersions());
    await accountBackgroundDb.accountAction((db) => db.resetSyncVersions());
  }

  @override
  Future<Result<void, void>> onLoginDataSync() async {
    return await clientIdManager.getClientId();
  }

  @override
  Future<void> onResumeAppUsage() async {
    _syncHandler.onResumeAppUsageSync(() async {
      await clientIdManager.getClientId();
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

    final latestViewedMessageChanged = event.latestViewedMessageChanged;
    final contentProcessingEvent = event.contentProcessingStateChanged;
    final maintenanceEvent = event.scheduledMaintenanceStatus;
    if (event.event == EventType.accountStateChanged) {
      await _receiveAccountState();
    } else if (event.event == EventType.latestViewedMessageChanged && latestViewedMessageChanged != null) {
      log.finest("Ignoring latest viewed message changed event");
    } else if (event.event == EventType.contentProcessingStateChanged && contentProcessingEvent != null) {
      _contentProcessingStateChanges.add(contentProcessingEvent);
    } else if (event.event == EventType.scheduledMaintenanceStatus && maintenanceEvent != null ) {
      await handleServerMaintenanceStatusEvent(maintenanceEvent);
    } else if (event.event == EventType.receivedLikesChanged) {
      await chat.receivedLikesCountRefresh();
    } else if (event.event == EventType.receivedBlocksChanged) {
      log.finest("Ignoring received blocks changed event");
    } else if (event.event == EventType.sentLikesChanged) {
      log.finest("Ignoring sent likes changed event");
    } else if (event.event == EventType.sentBlocksChanged) {
      log.finest("Ignoring sent blocks changed event");
    } else if (event.event == EventType.matchesChanged) {
      log.finest("Ignoring matches changed event");
    } else if (event.event == EventType.newMessageReceived) {
      await chat.receiveNewMessages();
    } else if (event.event == EventType.availableProfileAttributesChanged) {
      await profile.receiveProfileAttributes();
    } else if (event.event == EventType.profileChanged) {
      await profile.reloadMyProfile();
    } else if (event.event == EventType.newsCountChanged) {
      await receiveNewsCount();
    } else if (event.event == EventType.initialContentModerationCompleted) {
      await media.handleInitialModerationCompletedEvent();
    } else if (event.event == EventType.mediaContentChanged) {
      await media.reloadMyMediaContent();
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
}
