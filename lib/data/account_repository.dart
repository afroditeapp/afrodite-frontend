
import 'dart:async';

import 'package:async/async.dart' show StreamExtensions;
import 'package:camera/camera.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/api/api_manager.dart';
import 'package:pihka_frontend/data/account/initial_setup.dart';
import 'package:pihka_frontend/data/chat/message_extensions.dart';
import 'package:pihka_frontend/data/chat_repository.dart';
import 'package:pihka_frontend/data/general/notification/state/moderation_request_status.dart';
import 'package:pihka_frontend/data/login_repository.dart';
import 'package:pihka_frontend/data/media_repository.dart';
import 'package:pihka_frontend/data/profile_repository.dart';
import 'package:pihka_frontend/data/utils.dart';
import 'package:pihka_frontend/database/database_manager.dart';
import 'package:pihka_frontend/model/freezed/logic/account/initial_setup.dart';
import 'package:pihka_frontend/utils.dart';
import 'package:pihka_frontend/utils/api.dart';
import 'package:pihka_frontend/utils/result.dart';
import 'package:rxdart/rxdart.dart';

var log = Logger("AccountRepository");

enum AccountRepositoryState {
  initRequired,
  initComplete,
}

// TODO: Add automatic sync version incrementing to
// sentLikesChanged and sentBlocksChanged as only client
// makes operations to those lists.

class AccountRepository extends DataRepository {
  AccountRepository._private();
  static final _instance = AccountRepository._private();
  factory AccountRepository.getInstance() {
    return _instance;
  }

  final api = ApiManager.getInstance();
  final db = DatabaseManager.getInstance();

  final BehaviorSubject<AccountRepositoryState> _internalState =
    BehaviorSubject.seeded(AccountRepositoryState.initRequired);

  Stream<AccountState?> get accountState => db
    .accountStream((db) => db.watchAccountState());
  Stream<Capabilities> get capabilities => db
    .accountStreamOrDefault(
      (db) => db.watchCapabilities(),
      Capabilities(),
    );
  Stream<ProfileVisibility> get profileVisibility => db
    .accountStreamOrDefault((db) => db.daoProfileSettings.watchProfileVisibility(), ProfileVisibility.pendingPrivate);

  // WebSocket related event streams
  final _contentProcessingStateChanges = PublishSubject<ContentProcessingStateChanged>();
  Stream<ContentProcessingStateChanged> get contentProcessingStateChanges => _contentProcessingStateChanges.stream;

  @override
  Future<void> init() async {
    if (_internalState.value != AccountRepositoryState.initRequired) {
      return;
    }
    _internalState.add(AccountRepositoryState.initComplete);
  }

  // TODO(prod): Run onLogout when server connection has authentication failure

  Future<void> _saveAccountState(AccountState state) async {
    await db.accountAction((db) => db.updateAccountState(state));
  }

  Future<void> _saveCapabilities(Capabilities capabilities) async {
    await db.accountAction((db) => db.updateCapabilities(capabilities));
  }

  Future<void> _saveProfileVisibility(ProfileVisibility newProfileVisibility) async {
    // TODO(prod): Remove notification logic once there is proper events for content
    // moderation request status updates.
    final currentProfileVisibility = await profileVisibility.firstOrNull;
    if ((currentProfileVisibility == ProfileVisibility.pendingPrivate &&
      newProfileVisibility == ProfileVisibility.private) ||
        (currentProfileVisibility == ProfileVisibility.pendingPublic &&
      newProfileVisibility == ProfileVisibility.public)) {
        await NotificationModerationRequestStatus.getInstance().show(ModerationRequestStateSimple.accepted);
    }
    await db.accountAction((db) => db.daoProfileSettings.updateProfileVisibility(newProfileVisibility));
  }

  Future<void> _saveAccountSyncVersion(AccountSyncVersion version) async {
    await db.accountAction((db) => db.daoSyncVersions.updateSyncVersionAccount(version));
  }

  // TODO: Background futures might cause issues
  // for example if logout is made while in background.
  // (account specific databases solves this?)

  void handleEventToClient(EventToClient event) {
    log.finer("Event from server: $event");

    final chat = ChatRepository.getInstance();
    final profile = ProfileRepository.getInstance();

    final accountState = event.accountState;
    final capabilities = event.capabilities;
    final visibility = event.visibility;
    final accountSyncVersion = event.accountSyncVersion;
    final latestViewedMessageChanged = event.latestViewedMessageChanged;
    final contentProcessingEvent = event.contentProcessingStateChanged;
    if (event.event == EventType.accountStateChanged && accountState != null) {
      _saveAccountState(accountState);
    } else if (event.event == EventType.accountCapabilitiesChanged && capabilities != null) {
      _saveCapabilities(capabilities);
    } else if (event.event == EventType.profileVisibilityChanged && visibility != null) {
      _saveProfileVisibility(visibility);
    } else if (event.event == EventType.accountSyncVersionChanged && accountSyncVersion != null) {
      _saveAccountSyncVersion(accountSyncVersion);
    } else if (event.event == EventType.latestViewedMessageChanged && latestViewedMessageChanged != null) {
      // TODO
      log.warning("Unhandled event");
    } else if (event.event == EventType.contentProcessingStateChanged && contentProcessingEvent != null) {
      _contentProcessingStateChanges.add(contentProcessingEvent);
    } else if (event.event == EventType.receivedLikesChanged) {
      chat.receivedLikesRefresh();
    } else if (event.event == EventType.receivedBlocksChanged) {
      chat.receivedBlocksRefresh();
    } else if (event.event == EventType.sentLikesChanged) {
      chat.sentLikesRefresh();
    } else if (event.event == EventType.sentBlocksChanged) {
      chat.sentBlocksRefresh();
    } else if (event.event == EventType.matchesChanged) {
      chat.receivedMatchesRefresh();
    } else if (event.event == EventType.newMessageReceived) {
      chat.receiveNewMessages();
    } else if (event.event == EventType.availableProfileAttributesChanged) {
      profile.receiveProfileAttributes();
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
    XFile securitySelfieFile,
    XFile profileImageFile
  ) async {
    final resultString = await InitialSetupUtils().doDeveloperInitialSetup(
      email,
      name,
      securitySelfieFile,
      profileImageFile
    );

    if (resultString == null) {
      // Success
      await LoginRepository.getInstance().onInitialSetupComplete();
      await AccountRepository.getInstance().onInitialSetupComplete();
      await MediaRepository.getInstance().onInitialSetupComplete();
      await ProfileRepository.getInstance().onInitialSetupComplete();
      await ChatRepository.getInstance().onInitialSetupComplete();
    }
    return resultString;
  }

  Future<Result<void, void>> doInitialSetup(
    InitialSetupData data,
  ) async {
    final result = await InitialSetupUtils().doInitialSetup(data);
    if (result.isOk()) {
      await LoginRepository.getInstance().onInitialSetupComplete();
      await AccountRepository.getInstance().onInitialSetupComplete();
      await MediaRepository.getInstance().onInitialSetupComplete();
      await ProfileRepository.getInstance().onInitialSetupComplete();
      await ChatRepository.getInstance().onInitialSetupComplete();
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
    return await api.accountAction((api) => api.postDelete())
      .mapErr((_) => ())
      .mapOk((_) => ());
  }

  Future<Result<LatestBirthdate, ()>> downloadLatestBirthdate() async {
    return await api.account((api) => api.getLatestBirthdate())
      .mapErr((_) => ());
  }
}
