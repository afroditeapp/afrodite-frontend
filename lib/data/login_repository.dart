
import 'dart:async';
import 'dart:convert';

import 'package:async/async.dart';
import 'package:camera/camera.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/api/api_manager.dart';
import 'package:pihka_frontend/config.dart';
import 'package:pihka_frontend/data/account_repository.dart';
import 'package:pihka_frontend/data/chat_repository.dart';
import 'package:pihka_frontend/data/media_repository.dart';
import 'package:pihka_frontend/data/profile_repository.dart';
import 'package:pihka_frontend/data/utils.dart';
import 'package:pihka_frontend/logic/app/main_state.dart';
import 'package:pihka_frontend/storage/kv.dart';
import 'package:pihka_frontend/utils.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

var log = Logger("LoginRepository");

enum LoginState {
  splashScreen,
  loginRequired,
  unsupportedClientVersion,
  demoAccount,
  viewAccountStateOnceItExists,
}

enum LoginRepositoryState {
  initRequired,
  initComplete,
}

class LoginRepository extends DataRepository {
  LoginRepository._private();
  static final _instance = LoginRepository._private();
  factory LoginRepository.getInstance() {
    return _instance;
  }

  final _api = ApiManager.getInstance();

  final BehaviorSubject<LoginState> _loginState =
    BehaviorSubject.seeded(LoginState.splashScreen);
  final BehaviorSubject<LoginRepositoryState> _internalState =
    BehaviorSubject.seeded(LoginRepositoryState.initRequired);

  // Main app state streams
  Stream<LoginState> get loginState => _loginState.distinct();
  Stream<String> get accountServerAddress => KvStringManager.getInstance()
    .getUpdatesForWithConversionAndDefaultIfNull(
      KvString.accountServerAddress,
      (value) => value,
      defaultAccountServerAddress(),
    );

  // Demo account
  Stream<String?> get demoAccountUserId => KvStringManager.getInstance()
    .getUpdatesForWithConversion(
      KvString.demoAccountUserId,
      (value) => value,
    );
  Stream<String?> get demoAccountPassword => KvStringManager.getInstance()
    .getUpdatesForWithConversion(
      KvString.demoAccountPassword,
      (value) => value,
    );

  // Account
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
    if (_internalState.value != LoginRepositoryState.initRequired) {
      return;
    }
    _internalState.add(LoginRepositoryState.initComplete);

    // Restore previous state
    final previousState = await KvStringManager.getInstance().getValue(KvString.accountState);
    if (previousState != null) {
      _loginState.add(LoginState.viewAccountStateOnceItExists);
      await onResumeAppUsage();
      await AccountRepository.getInstance().onResumeAppUsage();
      await ProfileRepository.getInstance().onResumeAppUsage();
      await MediaRepository.getInstance().onResumeAppUsage();
      await ChatRepository.getInstance().onResumeAppUsage();
    }

    _api.state.listen((event) {
      log.finer(event);
      switch (event) {
        case ApiManagerState.waitingRefreshToken:
          _loginState.add(LoginState.loginRequired);
        case ApiManagerState.connecting || ApiManagerState.reconnectWaitTime: {}
        case ApiManagerState.connected:
          _loginState.add(LoginState.viewAccountStateOnceItExists);
        case ApiManagerState.unsupportedClientVersion:
          _loginState.add(LoginState.unsupportedClientVersion);
      }
    });

    _api.serverEvents.listen((event) {
      switch (event) {
          case EventToClientContainer e: {
            AccountRepository.getInstance().handleEventToClient(e.event);
          }
        }
    });
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

  Future<void> demoAccountLogout() async {
    log.info("logout started");
    // Disconnect, so that server does not send events to client
    await _api.close();

    // Account
    await KvStringManager.getInstance().setValue(KvString.demoAccountPassword, null);
    await KvStringManager.getInstance().setValue(KvString.demoAccountUserId, null);
    await onLogout();

    log.info("logout completed");
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

  Future<void> _handleLoginResult(LoginResult loginResult) async {
    // Account
    await KvStringManager.getInstance().setValue(KvString.accountRefreshToken, loginResult.account.refresh.token);
    await KvStringManager.getInstance().setValue(KvString.accountAccessToken, loginResult.account.access.accessToken);
    // TODO: microservice support
    await onLogin();
    // Other repostories
    await AccountRepository.getInstance().onLogout();
    await ProfileRepository.getInstance().onLogin();
    await MediaRepository.getInstance().onLogin();
    await ChatRepository.getInstance().onLogin();

    await _api.restart();
  }

  /// Logout back to login or demo account screen
  Future<void> logout() async {
    log.info("logout started");
    // Disconnect, so that server does not send events to client
    await _api.close();

    // Account
    await KvStringManager.getInstance().setValue(KvString.accountRefreshToken, null);
    await KvStringManager.getInstance().setValue(KvString.accountAccessToken, null);
    await onLogout();
    // TODO: microservice support

    // Other repositories
    await AccountRepository.getInstance().onLogout();
    await ProfileRepository.getInstance().onLogout();
    await MediaRepository.getInstance().onLogout();
    await ChatRepository.getInstance().onLogout();

    log.info("logout completed");
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

    Future<void> setCurrentServerAddress(String serverAddress) async {
    await KvStringManager.getInstance().setValue(
      KvString.accountServerAddress, serverAddress
    );
    await _api.closeAndRefreshServerAddress();
  }

}
