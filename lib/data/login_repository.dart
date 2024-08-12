
import 'dart:async';
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
import 'package:pihka_frontend/data/general/image_cache_settings.dart';
import 'package:pihka_frontend/data/media_repository.dart';
import 'package:pihka_frontend/data/profile_repository.dart';
import 'package:pihka_frontend/data/utils.dart';
import 'package:pihka_frontend/database/account_background_database_manager.dart';
import 'package:pihka_frontend/database/account_database_manager.dart';
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

  RepositoryInstances? _repositories;
  RepositoryInstances get repositories => _repositories!;
  RepositoryInstances? get repositoriesOrNull => _repositories;

  final _api = ApiManager.getInstance();

  GoogleSignIn google = createSignInWithGoogle();

  final BehaviorSubject<AccountState?> _accountState =
    BehaviorSubject.seeded(null);
  StreamSubscription<AccountState?>? _accountStateSubscription;
  Stream<AccountState?> get accountState => _accountState;

  final BehaviorSubject<LoginState> _loginState =
    BehaviorSubject.seeded(LoginState.splashScreen);
  final BehaviorSubject<LoginRepositoryState> _internalState =
    BehaviorSubject.seeded(LoginRepositoryState.initRequired);
  final BehaviorSubject<bool> _demoAccountLoginInProgress =
    BehaviorSubject.seeded(false);

  DateTime? _backgroundedAt;

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

    final currentAccountId = await accountId.first;
    if (currentAccountId != null) {
      await createRepositories(currentAccountId);

      // Restore previous state
      final previousState = await repositories.accountDb.accountStreamSingle((db) => db.watchAccountState()).ok();
      if (previousState != null) {
        _loginState.add(LoginState.viewAccountStateOnceItExists);
        await onResumeAppUsage();
        await _repositories?.onResumeAppUsage();
      }
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
          repositories.account.handleEventToClient(e.event);
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
          _backgroundedAt = null;
          return;
        }

        final backgroundedAt = _backgroundedAt;
        if (backgroundedAt != null) {
          final now = DateTime.now();
          if (now.difference(backgroundedAt) > const Duration(days: 1)) {
            log.info("Refreshing profile grid automatically");
            await repositories.profile.resetMainProfileIterator();
          }
        }
        _backgroundedAt = null;

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
          _backgroundedAt = null;
          return;
        }
        await ApiManager.getInstance().close();
        _backgroundedAt = DateTime.now();
      })
      .listen(null);
  }

  Future<void> createRepositories(AccountId accountId) async {
    final currentRepositories = _repositories;
    await currentRepositories?.dispose();

    final accountBackgroundDb = BackgroundDatabaseManager.getInstance().getAccountBackgroundDatabaseManager(accountId);
    final accountDb = DatabaseManager.getInstance().getAccountDatabaseManager(accountId);

    final imageCacheSettings = ImageCacheSettings(accountDb);

    final account = AccountRepository(
      db: accountDb,
      rememberToInitRepositoriesLateFinal: true,
    );
    final common = CommonRepository();
    final media = MediaRepository(account, accountDb);
    final profile = ProfileRepository(media, accountDb, accountBackgroundDb);
    final chat = ChatRepository(media: media, profile: profile, accountBackgroundDb: accountBackgroundDb, db: accountDb);
    final newRepositories = RepositoryInstances(
      accountId: accountId,
      common: common,
      chat: chat,
      media: media,
      profile: profile,
      account: account,
      imageCacheSettings: imageCacheSettings,
      accountBackgroundDb: accountBackgroundDb,
      accountDb: accountDb,
    );
    account.repositories = newRepositories;
    await newRepositories.init();

    await _accountStateSubscription?.cancel();
    _accountStateSubscription = account.accountState.listen((v) {
      _accountState.add(v);
    });

    _repositories = newRepositories;
  }

  Stream<SignInWithGoogleEvent> signInWithGoogle() async* {
    final GoogleSignInAccount? signedIn;
    try {
      signedIn = await google.signIn();
    } catch (e) { // No documentation, just catch everything
      yield SignInWithGoogleEvent.signInWithGoogleFailed;
      return;
    }

    if (signedIn == null) {
      yield SignInWithGoogleEvent.signInWithGoogleFailed;
      return;
    }

    yield SignInWithGoogleEvent.getGoogleAccountTokenCompleted;

    var token = await signedIn.authentication;
    final login = await _api.account((api) => api.postSignInWithLogin(SignInWithLoginInfo(googleToken: token.idToken))).ok();
    if (login == null) {
      yield SignInWithGoogleEvent.serverRequestFailed;
      return;
    }

    final result = await _handleLoginResult(login)
      .mapErr((_) => SignInWithGoogleEvent.otherError);

    switch (result) {
      case Ok():
        ();
      case Err(:final e):
        yield e;
    }
  }

  Future<Result<void, void>> _handleLoginResult(LoginResult loginResult) async {
    final accountDb = DatabaseManager.getInstance().getAccountDatabaseManager(loginResult.accountId);
    final r = await DatabaseManager.getInstance().setAccountId(loginResult.accountId)
      .andThen(
        (_) => accountDb.accountAction(
          (db) => db.daoAccountSettings.updateEmailAddress(loginResult.email)
        )
      );
    if (r.isErr()) {
      return const Err(null);
    }

    // Login repository
    await accountDb.accountAction((db) => db.daoTokens.updateRefreshTokenAccount(loginResult.account.refresh.token));
    await accountDb.accountAction((db) => db.daoTokens.updateAccessTokenAccount(loginResult.account.access.accessToken));
    // TODO(microservice): microservice support
    await onLogin();

    await createRepositories(loginResult.accountId);

    // Other repostories
    await _repositories?.onLogin();

    await _api.restart();

    return const Ok(null);
  }

  /// Logout back to login or demo account screen
  Future<void> logout() async {
    log.info("Logout started");
    // Disconnect, so that server does not send events to client
    await _api.closeAndLogout();

    // Login repository
    await repositories.accountDb.accountAction((db) => db.daoTokens.updateRefreshTokenAccount(null));
    await repositories.accountDb.accountAction((db) => db.daoTokens.updateAccessTokenAccount(null));
    await onLogout();
    // TODO(microservice): microservice support

    // Other repositories
    await _repositories?.onLogout();

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
      await _api.account((api) => api.postSignInWithLogin(SignInWithLoginInfo(appleToken: signedIn.identityToken)));
    } on SignInWithAppleException catch (_) {
      log.error("Sign in with Apple failed");
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

enum SignInWithGoogleEvent {
  getGoogleAccountTokenCompleted,
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

/// This should contain account specific logic so it is not possible
/// the logic will touch another account's data if there is long running
/// operations for example. When user logs in using an account the blocs will
/// be created and the required repository instances will be get from this
/// class.
class RepositoryInstances implements DataRepositoryMethods {
  final AccountId accountId;
  final CommonRepository common;
  final ChatRepository chat;
  final MediaRepository media;
  final ProfileRepository profile;
  final AccountRepository account;

  // Only lifecycle methods
  final ImageCacheSettings imageCacheSettings;

  final AccountBackgroundDatabaseManager accountBackgroundDb;
  final AccountDatabaseManager accountDb;

  const RepositoryInstances({
    required this.accountId,
    required this.common,
    required this.chat,
    required this.media,
    required this.profile,
    required this.account,
    required this.imageCacheSettings,
    required this.accountBackgroundDb,
    required this.accountDb,
  });

  Future<void> init() async {
    await common.init();
    await chat.init();
    await media.init();
    await profile.init();
    await account.init();
    await imageCacheSettings.init();
  }

  Future<void> dispose() async {
    await common.dispose();
    await chat.dispose();
    await media.dispose();
    await profile.dispose();
    await account.dispose();
    await imageCacheSettings.dispose();
  }

  @override
  Future<void> onInitialSetupComplete() async {
    await common.onInitialSetupComplete();
    await chat.onInitialSetupComplete();
    await media.onInitialSetupComplete();
    await profile.onInitialSetupComplete();
    await account.onInitialSetupComplete();
  }

  @override
  Future<void> onLogin() async {
    await common.onLogin();
    await chat.onLogin();
    await media.onLogin();
    await profile.onLogin();
    await account.onLogin();
  }

  @override
  Future<void> onLogout() async {
    await common.onLogout();
    await chat.onLogout();
    await media.onLogout();
    await profile.onLogout();
    await account.onLogout();
  }

  @override
  Future<void> onResumeAppUsage() async {
    await common.onResumeAppUsage();
    await chat.onResumeAppUsage();
    await media.onResumeAppUsage();
    await profile.onResumeAppUsage();
    await account.onResumeAppUsage();
  }
}
