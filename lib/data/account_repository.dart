


import 'dart:async';
import 'dart:convert';

import 'package:async/async.dart';
import 'package:camera/camera.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/api/api_manager.dart';
import 'package:pihka_frontend/api/api_provider.dart';
import 'package:pihka_frontend/config.dart';
import 'package:pihka_frontend/logic/app/main_state.dart';
import 'package:pihka_frontend/storage/kv.dart';
import 'package:pihka_frontend/utils.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

var log = Logger("AccountRepository");

enum AccountRepositoryState {
  initRequired,
  waitConnection,
  watchConnection,
}

class AccountRepository extends AppSingleton {
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

  final PublishSubject<void> _hintAccountStateUpdated = PublishSubject();

  final _accountServerAddress = KvStorageManager.getInstance()
    .getUpdatesForWithConversionAndDefaultIfNull(
      KvString.accountServerAddress,
      (value) => value,
      defaultAccountServerAddress(),
    );

  final _accountState = KvStorageManager.getInstance()
    .getUpdatesForWithConversionAndDefaultIfNull(
      KvString.accountState,
      (value) => AccountState.fromJson(value) ?? AccountState.initialSetup,
      AccountState.initialSetup,
    );
  final _capablities = KvStorageManager.getInstance()
    .getUpdatesForWithConversionAndDefaultIfNull(
      KvString.accountCapabilities,
      (value) {
        final map = jsonDecode(value);
        if (map != null) {
          return Capabilities.fromJson(map) ?? Capabilities();
        } else {
          return Capabilities();
        }
      },
      Capabilities(),
    );
  final _accountId = KvStorageManager.getInstance()
    .getUpdatesForWithConversion(
      KvString.accountId,
      (value) => AccountId(accountId: value)
    );
  final _accountAccessToken = KvStorageManager.getInstance()
    .getUpdatesForWithConversion(
      KvString.accountAccessToken,
      (value) => AccessToken(accessToken: value)
    );

  // Main app state streams
  Stream<MainState> get mainState => _mainState.distinct();
  Stream<String> get accountServerAddress => _accountServerAddress.distinct();

  // Account state streams
  Stream<AccountState> get accountState => _accountState.distinct();
  Stream<Capabilities> get capabilities => _capablities.distinct();
  Stream<AccountId?> get accountId => _accountId.distinct();
  Stream<AccessToken?> get accountAccessToken => _accountAccessToken.distinct();

  AccountRepository();

  @override
  Future<void> init() async {
    if (_internalState.value != AccountRepositoryState.initRequired) {
      return;
    }
    _internalState.add(AccountRepositoryState.waitConnection);

    // Restore previous state
    final previousState = await KvStorageManager.getInstance().getString(KvString.accountState);
    if (previousState != null) {
      final state = AccountState.fromJson(previousState);
      if (state != null) {
        emitStateUpdates(state);
      }
    }

    _api.state.listen((event) {
      log.finer(event);
      switch (event) {
        case ApiManagerState.initRequired: {}
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
      }
    });

    // Poll account state when there is connection to server
    _internalState
      .switchMap((value) {
        if (value == AccountRepositoryState.watchConnection) {
          return _pollNotificationStream()
            .switchMap((value) => Stream.fromFuture(_downloadAccountState()).whereNotNull());
        } else {
          return const Stream<Account>.empty();
        }
      })
      .listen((newAccountState) async {
          if (await capabilities.first != newAccountState.capablities) {
            await KvStorageManager.getInstance().setString(KvString.accountCapabilities, jsonEncode(newAccountState.capablities.toJson()));
          }

          if (await accountState.first != newAccountState.state) {
            await KvStorageManager.getInstance().setString(KvString.accountState, newAccountState.toString());
          }
          emitStateUpdates(newAccountState.state);
      });
  }

  Stream<void> _pollNotificationStream() async* {
    yield null;

    while (true) {
      await Future.any([
        Future.delayed(const Duration(seconds: 5), () {}),
        _hintAccountStateUpdated.stream.first
      ]);
      yield null;
    }
  }

  Future<Account?> _downloadAccountState() async {
    Account? data = await _api.account((api) => api.getAccountState());
    if (data == null) {
      log.error("error: data == null");
    } else {
      log.finer(data.state);
    }
    return data;
  }

  void emitStateUpdates(AccountState state) {
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

  Future<AccountId?> register() async {
    var id = await _api.account((api) => api.postRegister());
    if (id != null) {
      await KvStorageManager.getInstance().setString(KvString.accountId, id.accountId);
    }
    return id;
  }

  Future<AccessToken?> login() async {
    final accountIdValue = await accountId.first;
    if (accountIdValue == null) {
      return null;
    }
    final loginResult = await _api.account((api) => api.postLogin(accountIdValue));
    if (loginResult != null) {
      await handleLoginResult(loginResult);
    }
    await _api.restart();
    return loginResult?.account.access;
  }

  Future<void> handleLoginResult(LoginResult loginResult) async {
    await KvStorageManager.getInstance().setString(KvString.accountRefreshToken, loginResult.account.refresh.token);
    await KvStorageManager.getInstance().setString(KvString.accountAccessToken, loginResult.account.access.accessToken);
    // TODO: microservice support
  }

  Future<void> logout() async {
    await KvStorageManager.getInstance().setString(KvString.accountCapabilities, null);
    await KvStorageManager.getInstance().setString(KvString.accountState, null);

    await KvStorageManager.getInstance().setString(KvString.accountRefreshToken, null);
    await KvStorageManager.getInstance().setString(KvString.accountAccessToken, null);
    // TODO: microservice support

    await _api.close();
  }

  /// Return null on success. Return String if error.
  Future<String?> doInitialSetup(String email, String name, XFile securitySelfieFile, XFile profileImageFile) async {
    final String securitySelfiePath = securitySelfieFile.path;
    final String profileImagePath = profileImageFile.path;

    await _api.account((api) => api.postAccountSetup(AccountSetup(email: email, name: name)));
    final securitySelfie = await MultipartFile.fromPath("", securitySelfiePath);
    final contentId1 = await _api.media((api) => api.putImageToModerationSlot(0, securitySelfie));
    if (contentId1 == null) {
      return "Server did not return content ID";
    }
    final profileImage = await MultipartFile.fromPath("", profileImagePath);
    final contentId2 = await _api.media((api) => api.putImageToModerationSlot(1, profileImage));
    if (contentId2 == null) {
      return "Server did not return content ID";
    }
    await _api.media((api) => api.putModerationRequest(ModerationRequestContent(cameraImage: true, image1: contentId1, image2: contentId2)));
    await _api.account((api) => api.postCompleteSetup());
    _hintAccountStateUpdated.add(null);

    final state = await _api.account((api) => api.getAccountState());
    if (state == null || state.state != AccountState.normal) {
      return "Error";
    }

    _hintAccountStateUpdated.add(null);

    return null;
  }

  Future<void> setCurrentServerAddress(String serverAddress) async {
    await KvStorageManager.getInstance().setString(
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
          await handleLoginResult(login);
        }
        await _api.restart();
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
}
