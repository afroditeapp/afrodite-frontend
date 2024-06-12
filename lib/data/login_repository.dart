
import 'dart:io';

import 'package:async/async.dart' show StreamExtensions;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/api/api_manager.dart';
import 'package:pihka_frontend/config.dart';
import 'package:pihka_frontend/data/account_repository.dart';
import 'package:pihka_frontend/data/chat_repository.dart';
import 'package:pihka_frontend/data/common_repository.dart';
import 'package:pihka_frontend/data/media_repository.dart';
import 'package:pihka_frontend/data/profile_repository.dart';
import 'package:pihka_frontend/data/utils.dart';
import 'package:pihka_frontend/database/background_database_manager.dart';
import 'package:pihka_frontend/database/database_manager.dart';
import 'package:pihka_frontend/logic/app/app_visibility_provider.dart';
import 'package:pihka_frontend/main.dart';
import 'package:pihka_frontend/secrets.dart';
import 'package:pihka_frontend/utils.dart';
import 'package:pihka_frontend/utils/result.dart';
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

// TODO: Check didRequestAppExit, onDetach and end of main function. Could
// any be used to quit connection to server and close databases.

class LoginRepository extends DataRepository {
  LoginRepository._private();
  static final _instance = LoginRepository._private();
  factory LoginRepository.getInstance() {
    return _instance;
  }

  final _api = ApiManager.getInstance();

  GoogleSignIn google = createSignInWithGoogle();

  final BehaviorSubject<LoginState> _loginState =
    BehaviorSubject.seeded(LoginState.splashScreen);
  final BehaviorSubject<LoginRepositoryState> _internalState =
    BehaviorSubject.seeded(LoginRepositoryState.initRequired);
  final BehaviorSubject<bool> _demoAccountLoginInProgress =
    BehaviorSubject.seeded(false);

  // Main app state streams
  Stream<LoginState> get loginState => _loginState.distinct();
  Stream<String> get accountServerAddress => BackgroundDatabaseManager.getInstance()
    .commonStreamOrDefault(
      (db) => db.watchServerUrlAccount(),
      defaultServerUrlAccount(),
    )
    .distinct(); // Avoid loop in ServerAddressBloc

  // Demo account
  Stream<String?> get demoAccountUserId => DatabaseManager.getInstance()
    .commonStream((db) => db.watchDemoAccountUserId());

  Stream<String?> get demoAccountPassword => DatabaseManager.getInstance()
    .commonStream((db) => db.watchDemoAccountPassword());

  Stream<String?> get demoAccountToken => DatabaseManager.getInstance()
    .commonStream((db) => db.watchDemoAccountToken());
  Stream<bool> get demoAccountLoginInProgress => _demoAccountLoginInProgress;

  // Account
  Stream<AccountId?> get accountId => BackgroundDatabaseManager.getInstance()
    .commonStream((db) => db.watchAccountId());

  @override
  Future<void> init() async {
    if (_internalState.value != LoginRepositoryState.initRequired) {
      return;
    }
    _internalState.add(LoginRepositoryState.initComplete);

    // Restore previous state
    final previousState = await DatabaseManager.getInstance().accountStreamSingle((db) => db.watchAccountState()).ok();
    if (previousState != null) {
      _loginState.add(LoginState.viewAccountStateOnceItExists);
      await onResumeAppUsage();
      await CommonRepository.getInstance().onResumeAppUsage();
      await AccountRepository.getInstance().onResumeAppUsage();
      await ProfileRepository.getInstance().onResumeAppUsage();
      await MediaRepository.getInstance().onResumeAppUsage();
      await ChatRepository.getInstance().onResumeAppUsage();
    }

    Rx.combineLatest2(
      _api.state,
      demoAccountToken,
      (a, b) => (a, b),
    ).listen((event) {
      final (apiState, demoAccountToken) = event;
      log.finer("state changed. apiState: $apiState, demoAccountToken: ${demoAccountToken != null}");
      switch (apiState) {
        case ApiManagerState.waitingRefreshToken:
          if (demoAccountToken != null) {
            _loginState.add(LoginState.demoAccount);
          } else {
            _loginState.add(LoginState.loginRequired);
          }
        case ApiManagerState.connecting ||
          ApiManagerState.reconnectWaitTime ||
          ApiManagerState.noConnection: {}
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

    // Automatic connect based on app visibility
    AppVisibilityProvider.getInstance()
      .isForegroundStream
      .asyncMap((isForeground) async {
        await GlobalInitManager.getInstance()
          .globalInitCompletedStream
          .firstWhere((initCompleted) => initCompleted);

        if (!isForeground) {
          return;
        }
        if (await accountId.firstOrNull == null) {
          // Not logged in
          return;
        }
        final state = await ApiManager.getInstance().state.firstOrNull;
        if (state == ApiManagerState.noConnection) {
          await ApiManager.getInstance().restart();
        }
      })
      .listen(null);

    // Automatic disconnect based on app visibility
    AppVisibilityProvider.getInstance()
      .isForegroundStream
      .debounceTime(const Duration(seconds: 10))
      .asyncMap((isForeground) async {
        await GlobalInitManager.getInstance()
          .globalInitCompletedStream
          .firstWhere((initCompleted) => initCompleted);

        if (isForeground) {
          return;
        }
        if (await accountId.firstOrNull == null) {
          // Not logged in
          return;
        }
        await ApiManager.getInstance().close();
      })
      .listen(null);
  }

  Future<Result<void, SignInWithGoogleError>> signInWithGoogle() async {
    final GoogleSignInAccount? signedIn;
    try {
      signedIn = await google.signIn();
    } catch (e) { // No documentation, just catch everything
      // TODO(prod): Remove
      log.error(e);
      return const Err(SignInWithGoogleError.signInWithGoogleFailed);
    }

    if (signedIn == null) {
      return const Err(SignInWithGoogleError.signInWithGoogleFailed);
    }

    log.fine("$signedIn, ${signedIn.email}");

    var token = await signedIn.authentication;
    log.fine("${token.accessToken}, ${token.idToken}");

    final login = await _api.account((api) => api.postSignInWithLogin(SignInWithLoginInfo(googleToken: token.idToken))).ok();
    if (login == null) {
      return const Err(SignInWithGoogleError.serverRequestFailed);
    }

    return await _handleLoginResult(login)
      .mapErr((_) => SignInWithGoogleError.otherError);
  }

  Future<Result<void, void>> _handleLoginResult(LoginResult loginResult) async {
    final r = await DatabaseManager.getInstance().setAccountId(loginResult.accountId)
      .andThen(
        (_) => DatabaseManager.getInstance().accountAction(
          (db) => db.daoAccountSettings.updateEmailAddress(loginResult.email)
        )
      );
    if (r.isErr()) {
      return const Err(null);
    }

    // Login repository
    await DatabaseManager.getInstance().accountAction((db) => db.daoTokens.updateRefreshTokenAccount(loginResult.account.refresh.token));
    await DatabaseManager.getInstance().accountAction((db) => db.daoTokens.updateAccessTokenAccount(loginResult.account.access.accessToken));
    // TODO(microservice): microservice support
    await onLogin();
    // Other repostories
    await CommonRepository.getInstance().onLogin();
    await AccountRepository.getInstance().onLogin();
    await ProfileRepository.getInstance().onLogin();
    await MediaRepository.getInstance().onLogin();
    await ChatRepository.getInstance().onLogin();

    await _api.restart();

    return const Ok(null);
  }

  /// Logout back to login or demo account screen
  Future<void> logout() async {
    log.info("Logout started");
    // Disconnect, so that server does not send events to client
    await _api.closeAndLogout();

    // Login repository
    await DatabaseManager.getInstance().accountAction((db) => db.daoTokens.updateRefreshTokenAccount(null));
    await DatabaseManager.getInstance().accountAction((db) => db.daoTokens.updateAccessTokenAccount(null));
    await onLogout();
    // TODO(microservice): microservice support

    // Other repositories
    await CommonRepository.getInstance().onLogout();
    await AccountRepository.getInstance().onLogout();
    await ProfileRepository.getInstance().onLogout();
    await MediaRepository.getInstance().onLogout();
    await ChatRepository.getInstance().onLogout();

    try {
      // TODO(prod): There is also google.disconnect(). Should that used instead?
      await google.signOut();
    } catch (e) { // No documentation, just catch everything
      log.error("Sign in with Google error: sign out failed");
    }

    log.info("Logout completed");
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

  // TODO(prod): Remove runtime server address changing?
  Future<void> setCurrentServerAddress(String serverAddress) async {
    await BackgroundDatabaseManager.getInstance().commonAction(
      (db) => db.updateServerUrlAccount(serverAddress),
    );
    await _api.closeAndRefreshServerAddressAndLogout();
  }

  Future<Result<void, void>> demoAccountLogin(DemoAccountCredentials credentials) async {
    _demoAccountLoginInProgress.add(true);
    final loginResult = await _api.account((api) => api.postDemoModeLogin(DemoModePassword(password: credentials.id))).ok();
    _demoAccountLoginInProgress.add(false);

    final loginToken = loginResult?.token;
    if (loginToken == null) {
      return const Err(null);
    }

    final loginResult2 = await _api.account((api) => api.postDemoModeConfirmLogin(
      DemoModeConfirmLogin(
        password: DemoModePassword(password: credentials.password),
        token: loginToken
      )
    )).ok();
    final demoAccountToken = loginResult2?.token?.token;
    if (demoAccountToken == null) {
      return const Err(null);
    }

    await DatabaseManager.getInstance().commonAction((db) => db.updateDemoAccountUserId(credentials.id));
    await DatabaseManager.getInstance().commonAction((db) => db.updateDemoAccountPassword(credentials.password));
    await DatabaseManager.getInstance().commonAction((db) => db.updateDemoAccountToken(demoAccountToken));

    return const Ok(null);
  }

  Future<void> demoAccountLogout() async {
    log.info("demo account logout");

    // TODO(prod): Uncomment
    // await KvStringManager.getInstance().setValue(KvString.demoAccountPassword, null);
    // await KvStringManager.getInstance().setValue(KvString.demoAccountUserId, null);
    await DatabaseManager.getInstance().commonAction((db) => db.updateDemoAccountToken(null));

    log.info("demo account logout completed");
  }

  Future<Result<List<AccessibleAccount>, SessionOrOtherError>> demoAccountGetAccounts() async {
    final token = await demoAccountToken.first;
    if (token == null) {
      return Err(OtherError());
    }
    final accounts = await _api.account((api) => api.postDemoModeAccessibleAccounts(DemoModeToken(token: token))).ok();
    if (accounts != null) {
      return Ok(accounts);
    } else {
      // TODO: Better error handling
      // Assume session expiration every time for now.
      await demoAccountLogout();
      return Err(SessionExpired());
    }
  }

  Future<Result<void, SessionOrOtherError>> demoAccountRegisterAndLogin() async {
    final token = await demoAccountToken.first;
    if (token == null) {
      return Err(OtherError());
    }
    final demoToken = DemoModeToken(token: token);
    final id = await _api.account((api) => api.postDemoModeRegisterAccount(demoToken)).ok();
    if (id != null) {
      return await demoAccountLoginToAccount(id);
    } else {
      // TODO: Better error handling
      // Assume session expiration every time for now.
      await demoAccountLogout();
      return Err(SessionExpired());
    }
  }

  Future<Result<void, SessionOrOtherError>> demoAccountLoginToAccount(AccountId id) async {
    final token = await demoAccountToken.first;
    if (token == null) {
      return Err(OtherError());
    }
    final demoToken = DemoModeToken(token: token);
    final loginResult = await _api.account((api) => api.postDemoModeLoginToAccount(DemoModeLoginToAccount(accountId: id, token: demoToken))).ok();
    if (loginResult != null) {
      switch (await _handleLoginResult(loginResult)) {
        case Err():
          return Err(OtherError());
        case Ok():
          return const Ok(null);
      }
    } else {
      // TODO: Better error handling
      // Assume session expiration every time for now.
      await demoAccountLogout();
      return Err(SessionExpired());
    }
  }
}

class DemoAccountCredentials {
  final String id;
  final String password;
  DemoAccountCredentials(this.id, this.password);
}

sealed class SessionOrOtherError {}
class SessionExpired extends SessionOrOtherError {}
class OtherError extends SessionOrOtherError {}

enum SignInWithGoogleError {
  signInWithGoogleFailed,
  serverRequestFailed,
  otherError,
}

// TODO: make sure that iOS client id does not end in Android apk.

const String emailScope = "https://www.googleapis.com/auth/userinfo.email";

GoogleSignIn createSignInWithGoogle() {
  if (Platform.isAndroid) {
    return GoogleSignIn(
      serverClientId: signInWithGoogleBackendClientId(),
      scopes: [emailScope],
    );
  } else if (Platform.isIOS) {
    return GoogleSignIn(
      clientId: signInWithGoogleIosClientId(),
      serverClientId: signInWithGoogleBackendClientId(),
      scopes: [emailScope],
    );
  } else {
    throw UnsupportedError("Unsupported platform");
  }
}
