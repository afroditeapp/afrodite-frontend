
import 'dart:async';
import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:http/http.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/api/api_manager.dart';
import 'package:pihka_frontend/data/chat_repository.dart';
import 'package:pihka_frontend/data/utils.dart';
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

  /// Returns null on success. Returns String if error.
  Future<WaitProcessingResult> _waitContentProcessing(int slot) async {
    while (true) {
      final state = await _api.media((api) => api.getContentSlotState(slot)).ok();
      if (state == null) {
        return ProcessingError("Server did not return content processing state");
      }

      switch (state.state) {
        case ContentProcessingStateType.processing || ContentProcessingStateType.inQueue: {
          await Future<void>.delayed(const Duration(seconds: 1));
        }
        case ContentProcessingStateType.failed: return ProcessingError("Security selfie processing failed");
        case ContentProcessingStateType.empty: return ProcessingError("Slot is empty");
        case ContentProcessingStateType.completed: {
          final contentId = state.contentId;
          if (contentId == null) {
            return ProcessingError("Server did not return content ID");
          } else {
            return ProcessingSuccess(contentId);
          }
        }
      }
    }
  }

  /// Return null on success. Return String if error.
  Future<String?> doInitialSetup(String email, String name, XFile securitySelfieFile, XFile profileImageFile) async {
    final String securitySelfiePath = securitySelfieFile.path;
    final String profileImagePath = profileImageFile.path;

    await _api.account((api) => api.postAccountData(AccountData(email: email)));
    await _api.account((api) => api.postAccountSetup(AccountSetup(birthdate: "123")));
    final securitySelfie = await MultipartFile.fromPath("", securitySelfiePath);
    final processingId = await _api.media((api) => api.putContentToContentSlot(0, true, MediaContentType.jpegImage, securitySelfie));
    if (processingId case Err()) {
      return "Server did not return content processing ID";
    }
    final result = await _waitContentProcessing(0);
    final ContentId contentId0;
    switch (result) {
      case ProcessingError(): return result.message;
      case ProcessingSuccess(): contentId0 = result.contentId;
    }
    await _api.media((api) => api.putPendingSecurityContentInfo(contentId0));

    final profileImage = await MultipartFile.fromPath("", profileImagePath);
    final processingId2 = await _api.media((api) => api.putContentToContentSlot(1, false, MediaContentType.jpegImage, profileImage));
    if (processingId2 case Err()) {
      return "Server did not return content processing ID";
    }
    final result2 = await _waitContentProcessing(1);
    final ContentId contentId1;
    switch (result2) {
      case ProcessingError(): return result2.message;
      case ProcessingSuccess(): contentId1 = result2.contentId;
    }
    await _api.media((api) => api.putPendingProfileContent(SetProfileContent(contentId0: contentId1)));

    await _api.media((api) => api.putModerationRequest(ModerationRequestContent(content0: contentId0, content1: contentId1)));
    await _api.account((api) => api.postCompleteSetup());

    final state = await _api.account((api) => api.getAccountState()).ok();
    if (state == null || state.state != AccountState.normal) {
      return "Error";
    }

    return null;
  }

  /// Returns true if successful.
  Future<bool> doProfileVisibilityChange(bool profileVisiblity) async {
    final result = await ApiManager.getInstance().accountAction((api) =>
      api.putSettingProfileVisiblity(BooleanSetting(value: profileVisiblity))
    );

    return result.isOk();
  }
}

sealed class WaitProcessingResult {}
class ProcessingError extends WaitProcessingResult {
  final String message;
  ProcessingError(this.message);
}
class ProcessingSuccess extends WaitProcessingResult {
  final ContentId contentId;
  ProcessingSuccess(this.contentId);
}
