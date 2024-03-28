
import 'dart:async';
import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:http/http.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/api/api_manager.dart';
import 'package:pihka_frontend/data/account/initial_setup.dart';
import 'package:pihka_frontend/data/chat_repository.dart';
import 'package:pihka_frontend/data/profile_repository.dart';
import 'package:pihka_frontend/data/utils.dart';
import 'package:pihka_frontend/logic/account/initial_setup.dart';
import 'package:pihka_frontend/storage/kv.dart';
import 'package:pihka_frontend/utils.dart';
import 'package:pihka_frontend/utils/result.dart';
import 'package:rxdart/rxdart.dart';

var log = Logger("AccountRepository");

enum AccountRepositoryState {
  initRequired,
  initComplete,
}

class AccountRepository extends DataRepository {
  AccountRepository._private();
  static final _instance = AccountRepository._private();
  factory AccountRepository.getInstance() {
    return _instance;
  }

  final _api = ApiManager.getInstance();

  final BehaviorSubject<AccountRepositoryState> _internalState =
    BehaviorSubject.seeded(AccountRepositoryState.initRequired);

  Stream<AccountState?> get accountState =>  KvStringManager.getInstance()
    .getUpdatesForWithConversion(
      KvString.accountState,
      (value) => AccountState.fromJson(value) ?? AccountState.initialSetup,
    );
  Stream<Capabilities> get capabilities => KvStringManager.getInstance()
    .getUpdatesForWithConversionAndDefaultIfNull(
      KvString.accountCapabilities,
      (value) {
        final map = jsonDecode(value);
        if (map != null) {
          final capabilities = Capabilities.fromJson(map);
          if (capabilities != null) {
            return capabilities;
          } else {
            log.error("Capabilities fromJson failed");
            return Capabilities();
          }
        } else {
          log.error("Capabilities jsonDecode failed");
          return Capabilities();
        }
      },
      Capabilities(),
    );
  Stream<ProfileVisibility> get profileVisibility => KvStringManager.getInstance()
    .getUpdatesForWithConversionAndDefaultIfNull(
      KvString.profileVisibility,
      (value) => ProfileVisibility.fromJson(value) ?? ProfileVisibility.pendingPrivate,
      ProfileVisibility.pendingPrivate,
    );

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

  Future<void> _saveAccountState(AccountState state) async {
    await KvStringManager.getInstance().setValue(KvString.accountState, state.toString());
  }

  Future<void> _saveAndUpdateCapabilities(Capabilities capabilities) async {
    final jsonString = jsonEncode(capabilities.toJson());
    await KvStringManager.getInstance().setValue(KvString.accountCapabilities, jsonString);
  }

  Future<void> _saveAndUpdateProfileVisibility(ProfileVisibility profileVisibility) async {
    await KvStringManager.getInstance().setValue(KvString.profileVisibility, profileVisibility.toString());
  }

  // TODO: Background futures might cause issues
  // for example if logout is made while in background.
  // (account specific databases solves this?)

  void handleEventToClient(EventToClient event) {
    log.finer("Event from server: $event");

    final accountState = event.accountState;
    final capabilities = event.capabilities;
    final visibility = event.visibility;
    final latestViewedMessageChanged = event.latestViewedMessageChanged;
    final contentProcessingEvent = event.contentProcessingStateChanged;
    if (event.event == EventType.accountStateChanged && accountState != null) {
      _saveAccountState(accountState);
    } else if (event.event == EventType.accountCapabilitiesChanged && capabilities != null) {
      _saveAndUpdateCapabilities(capabilities);
    } else if (event.event == EventType.profileVisibilityChanged && visibility != null) {
      _saveAndUpdateProfileVisibility(visibility);
    } else if (event.event == EventType.latestViewedMessageChanged && latestViewedMessageChanged != null) {
      // TODO
      log.warning("Unhandled event");
    } else if (event.event == EventType.contentProcessingStateChanged && contentProcessingEvent != null) {
      _contentProcessingStateChanges.add(contentProcessingEvent);
    } else if (event.event == EventType.receivedLikesChanged) {
      ChatRepository.getInstance().receivedLikesRefresh();
    } else if (event.event == EventType.receivedBlocksChanged) {
      ChatRepository.getInstance().receivedBlocksRefresh();
    } else if (event.event == EventType.newMessageReceived) {
      ChatRepository.getInstance().receiveNewMessages();
    } else if (event.event == EventType.availableProfileAttributesChanged) {
      ProfileRepository.getInstance().receiveProfileAttributes();
    } else {
      log.error("Unknown EventToClient");
    }
  }

  @override
  Future<void> onLogout() async {
    await KvStringManager.getInstance().setValue(KvString.profileVisibility, null);
    await KvStringManager.getInstance().setValue(KvString.accountCapabilities, null);
    await KvStringManager.getInstance().setValue(KvString.accountState, null);
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
    return await InitialSetupUtils().doDeveloperInitialSetup(
      email,
      name,
      securitySelfieFile,
      profileImageFile
    );
  }

  Future<Result<(), ()>> doInitialSetup(
    InitialSetupData data,
  ) async {
    return await InitialSetupUtils().doInitialSetup(data);
  }

  /// Returns true if successful.
  Future<bool> doProfileVisibilityChange(bool profileVisiblity) async {
    final result = await ApiManager.getInstance().accountAction((api) =>
      api.putSettingProfileVisiblity(BooleanSetting(value: profileVisiblity))
    );

    return result.isOk();
  }
}
