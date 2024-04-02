
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
import 'package:pihka_frontend/database/database_manager.dart';
import 'package:pihka_frontend/storage/kv.dart';
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
  final BehaviorSubject<bool> _demoAccountLoginInProgress =
    BehaviorSubject.seeded(false);

  // Main app state streams
  Stream<LoginState> get loginState => _loginState.distinct();
  Stream<String> get accountServerAddress => DatabaseManager.getInstance()
    .commonDataStreamOrDefault(
      (db) => db.watchServerUrlAccount(),
      defaultServerUrlAccount(),
    )
    .distinct(); // Avoid loop in ServerAddressBloc

  // Demo account
  Stream<String?> get demoAccountUserId => DatabaseManager.getInstance()
    .commonDataStream((db) => db.watchDemoAccountUserId());

  Stream<String?> get demoAccountPassword => DatabaseManager.getInstance()
    .commonDataStream((db) => db.watchDemoAccountPassword());

  Stream<String?> get demoAccountToken => DatabaseManager.getInstance()
    .commonDataStream((db) => db.watchDemoAccountToken());
  Stream<bool> get demoAccountLoginInProgress => _demoAccountLoginInProgress;

  // Account
  Stream<AccountId?> get accountId => DatabaseManager.getInstance()
    .commonDataStream(
      (db) => db.watchAccountId().map((event) {
        if (event == null) {
          return null;
        } else {
          return AccountId(accountId: event);
        }
      })
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
    var id = await _api.account((api) => api.postRegister()).ok();
    if (id != null) {
      await DatabaseManager.getInstance().commonAction((db) => db.updateAccountId(id.accountId));
    }
    return id;
  }

  Future<void> login() async {
    final accountIdValue = await accountId.first;
    if (accountIdValue == null) {
      return;
    }
    final loginResult = await _api.account((api) => api.postLogin(accountIdValue)).ok();
    if (loginResult != null) {
      await _handleLoginResult(loginResult);
    }
  }

  Future<void> signInWithGoogle(GoogleSignIn google) async {
    final signedIn = await google.signIn();
    if (signedIn != null) {
      log.fine("$signedIn, ${signedIn.email}");

      var token = await signedIn.authentication;
      log.fine("${token.accessToken}, ${token.idToken}");

      final login = await _api.account((api) => api.postSignInWithLogin(SignInWithLoginInfo(googleToken: token.idToken))).ok();
      if (login != null) {
        await _handleLoginResult(login);
      }
    }
  }

  Future<void> _handleLoginResult(LoginResult loginResult) async {
    // TODO(prod): Sign in with login does not set the account id to
    // shared preferences.

    // Login repository
    await DatabaseManager.getInstance().accountAction((db) => db.updateRefreshTokenAccount(loginResult.account.refresh.token));
    await DatabaseManager.getInstance().accountAction((db) => db.updateAccessTokenAccount(loginResult.account.access.accessToken));
    // TODO(microservice): microservice support
    await onLogin();
    // Other repostories
    await CommonRepository.getInstance().onLogin();
    await AccountRepository.getInstance().onLogin();
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

    // Login repository
    await DatabaseManager.getInstance().accountAction((db) => db.updateRefreshTokenAccount(null));
    await DatabaseManager.getInstance().accountAction((db) => db.updateAccessTokenAccount(null));
    await onLogout();
    // TODO(microservice): microservice support

    // Other repositories
    await CommonRepository.getInstance().onLogout();
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

  // TODO(prod): Remove runtime server address changing?
  Future<void> setCurrentServerAddress(String serverAddress) async {
    await DatabaseManager.getInstance().commonAction(
      (db) => db.updateServerUrlAccount(serverAddress),
    );
    await _api.closeAndRefreshServerAddress();
  }

  Future<Result<(), ()>> demoAccountLogin(DemoAccountCredentials credentials) async {
    _demoAccountLoginInProgress.add(true);
    final loginResult = await _api.account((api) => api.postDemoModeLogin(DemoModePassword(password: credentials.id))).ok();
    _demoAccountLoginInProgress.add(false);

    final loginToken = loginResult?.token;
    if (loginToken == null) {
      return Err(());
    }

    final loginResult2 = await _api.account((api) => api.postDemoModeConfirmLogin(
      DemoModeConfirmLogin(
        password: DemoModePassword(password: credentials.password),
        token: loginToken
      )
    )).ok();
    final demoAccountToken = loginResult2?.token?.token;
    if (demoAccountToken == null) {
      return Err(());
    }

    await DatabaseManager.getInstance().commonAction((db) => db.updateDemoAccountUserId(credentials.id));
    await DatabaseManager.getInstance().commonAction((db) => db.updateDemoAccountPassword(credentials.password));
    await DatabaseManager.getInstance().commonAction((db) => db.updateDemoAccountToken(demoAccountToken));

    return Ok(());
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

  Future<Result<(), SessionOrOtherError>> demoAccountRegisterAndLogin() async {
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

  Future<Result<(), SessionOrOtherError>> demoAccountLoginToAccount(AccountId id) async {
    final token = await demoAccountToken.first;
    if (token == null) {
      return Err(OtherError());
    }
    final demoToken = DemoModeToken(token: token);
    final loginResult = await _api.account((api) => api.postDemoModeLoginToAccount(DemoModeLoginToAccount(accountId: id, token: demoToken))).ok();
    if (loginResult != null) {
      await DatabaseManager.getInstance().commonAction((db) => db.updateAccountId(id.accountId));
      await _handleLoginResult(loginResult);
      return Ok(());
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
