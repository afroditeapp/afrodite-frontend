
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/api/api_manager.dart';
import 'package:pihka_frontend/config.dart';
import 'package:pihka_frontend/data/chat_repository.dart';
import 'package:pihka_frontend/data/media_repository.dart';
import 'package:pihka_frontend/data/profile_repository.dart';
import 'package:pihka_frontend/data/utils.dart';
import 'package:pihka_frontend/logic/app/main_state.dart';
import 'package:pihka_frontend/storage/kv.dart';
import 'package:pihka_frontend/utils.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

var log = Logger("AccountRepository");

enum AccountRepositoryState {
  initRequired,
  waitConnection, // TODO: replace wait and watch with initComplete?
  watchConnection,
}

class AccountRepository extends DataRepository {
  AccountRepository._private();
  static final _instance = AccountRepository._private();
  factory AccountRepository.getInstance() {
    return _instance;
  }

  final _api = ApiManager.getInstance();

  final BehaviorSubject<MainState> _mainState =
    BehaviorSubject.seeded(MainState.splashScreen);
  final BehaviorSubject<AccountRepositoryState> _internalState =
    BehaviorSubject.seeded(AccountRepositoryState.initRequired);

  // Main app state streams
  Stream<MainState> get mainState => _mainState.distinct();
  Stream<String> get accountServerAddress => KvStringManager.getInstance()
    .getUpdatesForWithConversionAndDefaultIfNull(
      KvString.accountServerAddress,
      (value) => value,
      defaultAccountServerAddress(),
    );

  // Account state streams
  Stream<AccountState> get accountState =>  KvStringManager.getInstance()
    .getUpdatesForWithConversionAndDefaultIfNull(
      KvString.accountState,
      (value) => AccountState.fromJson(value) ?? AccountState.initialSetup,
      AccountState.initialSetup,
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
  Stream<AccountId?> get accountId => KvStringManager.getInstance()
    .getUpdatesForWithConversion(
      KvString.accountId,
      (value) => AccountId(accountId: value)
    );
  Stream<AccessToken?> get accountAccessToken => KvStringManager.getInstance()
    .getUpdatesForWithConversion(
      KvString.accountAccessToken,
      (value) => AccessToken(accessToken: value)
    );

  @override
  Future<void> init() async {
    if (_internalState.value != AccountRepositoryState.initRequired) {
      return;
    }
    _internalState.add(AccountRepositoryState.waitConnection);

    // Restore previous state
    final previousState = await KvStringManager.getInstance().getValue(KvString.accountState);
    if (previousState != null) {
      final state = AccountState.fromJson(previousState);
      if (state != null) {
        _emitMainStateUpdates(state);
      }
      await onResumeAppUsage();
      await ProfileRepository.getInstance().onResumeAppUsage();
      await MediaRepository.getInstance().onResumeAppUsage();
      await ChatRepository.getInstance().onResumeAppUsage();
    }

    _api.state.listen((event) {
      log.finer(event);
      switch (event) {
        case ApiManagerState.waitingRefreshToken: {
          _mainState.add(MainState.loginRequired);
          _internalState.add(AccountRepositoryState.waitConnection);
        }
        case ApiManagerState.connecting || ApiManagerState.reconnectWaitTime: {
          _internalState.add(AccountRepositoryState.waitConnection);
        }
        case ApiManagerState.connected: {
          _internalState.add(AccountRepositoryState.watchConnection);
        }
        case ApiManagerState.unsupportedClientVersion: {
          _mainState.add(MainState.unsupportedClientVersion);
          _internalState.add(AccountRepositoryState.waitConnection);
        }
      }
    });

    _api.serverEvents.listen((event) {
      switch (event) {
        case EventToClientContainer e:
          _handleEventToClient(e.event);
      }
    });
  }

  Future<void> _saveAndUpdateAccountState(AccountState state) async {
    await KvStringManager.getInstance().setValue(KvString.accountState, state.toString());
    _emitMainStateUpdates(state);
  }

  void _emitMainStateUpdates(AccountState state) {
    if (state == AccountState.initialSetup) {
      _mainState.add(MainState.initialSetup);
    } else if (state == AccountState.normal) {
      _mainState.add(MainState.initialSetupComplete);
    } else if (state == AccountState.banned) {
      _mainState.add(MainState.accountBanned);
    } else if (state == AccountState.pendingDeletion) {
      _mainState.add(MainState.pendingRemoval);
    }
  }

  Future<void> _saveAndUpdateCapabilities(Capabilities capabilities) async {
    final jsonString = jsonEncode(capabilities.toJson());
    await KvStringManager.getInstance().setValue(KvString.accountCapabilities, jsonString);
  }

  Future<void> _saveAndUpdateProfileVisibility(ProfileVisibility profileVisibility) async {
    await KvStringManager.getInstance().setValue(KvString.profileVisibility, profileVisibility.toString());
  }

  void _handleEventToClient(EventToClient event) {
    log.finer("Event from server: $event");

    final accountState = event.accountState;
    final capabilities = event.capabilities;
    final visibility = event.visibility;
    final latestViewedMessageChanged = event.latestViewedMessageChanged;
    if (event.event == EventType.accountStateChanged && accountState != null) {
      _saveAndUpdateAccountState(accountState);
    } else if (event.event == EventType.accountCapabilitiesChanged && capabilities != null) {
      _saveAndUpdateCapabilities(capabilities);
    } else if (event.event == EventType.profileVisibilityChanged && visibility != null) {
      _saveAndUpdateProfileVisibility(visibility);
    } else if (event.event == EventType.latestViewedMessageChanged && latestViewedMessageChanged != null) {
      // TODO
      log.warning("Unhandled event");
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

  Future<AccountId?> register() async {
    var id = await _api.account((api) => api.postRegister());
    if (id != null) {
      await KvStringManager.getInstance().setValue(KvString.accountId, id.accountId);
    }
    return id;
  }

  Future<void> login() async {
    final accountIdValue = await accountId.first;
    if (accountIdValue == null) {
      return;
    }
    final loginResult = await _api.account((api) => api.postLogin(accountIdValue));
    if (loginResult != null) {
      await _handleLoginResult(loginResult);
    }
  }

  Future<void> _handleLoginResult(LoginResult loginResult) async {
    // Account
    await KvStringManager.getInstance().setValue(KvString.accountRefreshToken, loginResult.account.refresh.token);
    await KvStringManager.getInstance().setValue(KvString.accountAccessToken, loginResult.account.access.accessToken);
    // TODO: microservice support
    await onLogin();
    // Other repostories
    await ProfileRepository.getInstance().onLogin();
    await MediaRepository.getInstance().onLogin();
    await ChatRepository.getInstance().onLogin();

    await _api.restart();
  }

  Future<void> logout() async {
    log.info("logout started");
    // Disconnect, so that server does not send events to client
    await _api.close();

    // Account
    await KvStringManager.getInstance().setValue(KvString.profileVisibility, null);
    await KvStringManager.getInstance().setValue(KvString.accountCapabilities, null);
    await KvStringManager.getInstance().setValue(KvString.accountState, null);
    await KvStringManager.getInstance().setValue(KvString.accountRefreshToken, null);
    await KvStringManager.getInstance().setValue(KvString.accountAccessToken, null);
    await onLogout();
    // TODO: microservice support

    // Other repositories
    await ProfileRepository.getInstance().onLogout();
    await MediaRepository.getInstance().onLogout();
    await ChatRepository.getInstance().onLogout();

    log.info("logout completed");
  }

  /// Returns null on success. Returns String if error.
  Future<WaitProcessingResult> _waitContentProcessing(int slot) async {
    while (true) {
      final state = await _api.media((api) => api.getContentSlotState(slot));
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
    if (processingId == null) {
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
    if (processingId2 == null) {
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

    final state = await _api.account((api) => api.getAccountState());
    if (state == null || state.state != AccountState.normal) {
      return "Error";
    }

    return null;
  }

  Future<void> setCurrentServerAddress(String serverAddress) async {
    await KvStringManager.getInstance().setValue(
      KvString.accountServerAddress, serverAddress
    );
    await _api.closeAndRefreshServerAddress();
  }

  Future<void> signInWithGoogle(GoogleSignIn google) async {
     final signedIn = await google.signIn();
      if (signedIn != null) {
        log.fine("$signedIn, ${signedIn.email}");

        var token = await signedIn.authentication;
        log.fine("${token.accessToken}, ${token.idToken}");

        final login = await _api.account((api) => api.postSignInWithLogin(SignInWithLoginInfo(googleToken: token.idToken)));
        if (login != null) {
          await _handleLoginResult(login);
        }
      }
  }

  Future<void> signOutFromGoogle(GoogleSignIn google) async {
    final signedIn = await google.disconnect();
    log.fine("$signedIn, ${signedIn?.email}");
  }

  Future<void> signInWithApple() async {
     AuthorizationCredentialAppleID signedIn;
    try {
      signedIn = await SignInWithApple.getAppleIDCredential(scopes: [
        AppleIDAuthorizationScopes.email,
      ]);
      log.fine(signedIn);
      await _api.account((api) => api.postSignInWithLogin(SignInWithLoginInfo(appleToken: signedIn.identityToken)));
    } on SignInWithAppleException catch (e) {
      log.error(e);
    }
  }

  /// Returns true if successful.
  Future<bool> doProfileVisibilityChange(bool profileVisiblity) async {
    final result = await ApiManager.getInstance().account((api) async {
      await api.putSettingProfileVisiblity(BooleanSetting(value: profileVisiblity)); return true;
    }) ?? false;

    return result;
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
