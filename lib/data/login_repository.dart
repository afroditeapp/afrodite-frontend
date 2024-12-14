
import 'dart:async';
import 'dart:io';

import 'package:async/async.dart' show StreamExtensions;
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:app/api/api_manager.dart';
import 'package:app/config.dart';
import 'package:app/data/account/client_id_manager.dart';
import 'package:app/data/account_repository.dart';
import 'package:app/data/chat/message_key_generator.dart';
import 'package:app/data/chat_repository.dart';
import 'package:app/data/common_repository.dart';
import 'package:app/data/general/image_cache_settings.dart';
import 'package:app/data/media_repository.dart';
import 'package:app/data/profile_repository.dart';
import 'package:app/data/utils.dart';
import 'package:app/database/account_background_database_manager.dart';
import 'package:app/database/account_database_manager.dart';
import 'package:app/database/background_database_manager.dart';
import 'package:app/database/database_manager.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/app/app_visibility_provider.dart';
import 'package:app/logic/sign_in_with.dart';
import 'package:app/main.dart';
import 'package:app/sign_in_with_google_ids.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:utils/utils.dart';
import 'package:app/utils/result.dart';
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

  final ApiManager _apiNoConnection = ApiManager.withDefaultAddressAndNoConnection();

  late final GoogleSignIn _google;

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
  final BehaviorSubject<bool> _loginInProgress =
    BehaviorSubject.seeded(false);

  final PublishSubject<ServerWsEvent> _serverEvents =
    PublishSubject();
  StreamSubscription<ServerWsEvent>? _serverEventsSubscription;

  final PublishSubject<ApiManagerState> _serverConnectionManagerStateEvents =
    PublishSubject();
  StreamSubscription<ApiManagerState>? _serverConnectionManagerStateEventsSubscription;

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

    _google = createSignInWithGoogle();
    if (kIsWeb) {
      _google.onCurrentUserChanged
      .asyncMap((signedIn) async {
        if (signedIn == null) {
          return;
        }

        switch (await _handleSignInWithGoogleAccountInfo(signedIn)) {
          case Ok():
            ();
          case Err(:final e):
            showSnackBarTextsForSignInWithGoogle(e);
        }
      }).listen((_) {});
    }

    await _apiNoConnection.init();

    final currentAccountId = await accountId.first;
    if (currentAccountId != null) {
      await _createRepositories(currentAccountId);

      // Restore previous state
      final previousState = await repositories.accountDb.accountStreamSingle((db) => db.watchAccountState()).ok();
      if (previousState != null) {
        _loginState.add(LoginState.viewAccountStateOnceItExists);
        await onResumeAppUsage();
        await _repositories?.onResumeAppUsage();
      }
    }

    Rx.combineLatest3(
      _serverConnectionManagerStateEvents,
      demoAccountToken,
      _loginInProgress,
      (a, b, c) => (a, b, c),
    ).listen((event) {
      final (apiState, demoAccountToken, loginInProgress) = event;
      log.finer("state changed. apiState: $apiState, demoAccountToken: ${demoAccountToken != null}, loginInProgress: $loginInProgress");
      if (loginInProgress) {
        if (demoAccountToken != null) {
          _loginState.add(LoginState.demoAccount);
        } else {
          _loginState.add(LoginState.loginRequired);
        }
        return;
      }

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

    if (currentAccountId == null) {
      // ServerConnectionManager is not yet created so init
      // _serverConnectionManagerStateEvents manually so that previous
      // combineLatest2 starts working.
      _serverConnectionManagerStateEvents.add(ApiManagerState.waitingRefreshToken);
    }

    _serverEvents
      .asyncMap((event) async {
        switch (event) {
          case EventToClientContainer e: {
            await repositories.account.handleEventToClient(e.event);
          }
        }
        return;
      })
      .listen((_) {});

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

        final connectionManager = repositoriesOrNull?.connectionManager;
        final state = await connectionManager?.state.firstOrNull;
        if (state == ApiManagerState.noConnection) {
          await connectionManager?.restart();
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
        final connectionManager = repositoriesOrNull?.connectionManager;
        await connectionManager?.close();
        _backgroundedAt = DateTime.now();
      })
      .listen(null);
  }

  Future<RepositoryInstances> _createRepositories(AccountId accountId, {bool accountLoginHappened = false}) async {
    final currentRepositories = _repositories;
    await currentRepositories?.dispose();

    final accountBackgroundDb = BackgroundDatabaseManager.getInstance().getAccountBackgroundDatabaseManager(accountId);
    final accountDb = DatabaseManager.getInstance().getAccountDatabaseManager(accountId);

    final connectionManager = ServerConnectionManager(accountDb, accountBackgroundDb);
    final clientIdManager = ClientIdManager(accountDb, connectionManager.api);

    final imageCacheSettings = ImageCacheSettings(accountDb);

    final account = AccountRepository(
      db: accountDb,
      accountBackgroundDb: accountBackgroundDb,
      api: connectionManager.api,
      connectionManager: connectionManager,
      clientIdManager: clientIdManager,
      rememberToInitRepositoriesLateFinal: true,
    );
    final common = CommonRepository(connectionManager);
    final media = MediaRepository(account, accountDb, accountBackgroundDb, connectionManager, accountId);
    final profile = ProfileRepository(media, account, accountDb, accountBackgroundDb, connectionManager, accountId);
    final chat = ChatRepository(
      media: media,
      profile: profile,
      accountBackgroundDb: accountBackgroundDb,
      db: accountDb,
      connectionManager: connectionManager,
      clientIdManager: clientIdManager,
      messageKeyManager: MessageKeyManager(accountDb, connectionManager.api, accountId),
      currentUser: accountId,
    );
    final newRepositories = RepositoryInstances(
      accountId: accountId,
      accountLoginHappened: accountLoginHappened,
      common: common,
      chat: chat,
      media: media,
      profile: profile,
      account: account,
      imageCacheSettings: imageCacheSettings,
      accountBackgroundDb: accountBackgroundDb,
      accountDb: accountDb,
      connectionManager: connectionManager,
    );
    account.repositories = newRepositories;
    await newRepositories.init();

    await _accountStateSubscription?.cancel();
    _accountStateSubscription = account.accountState.listen((v) {
      _accountState.add(v);
    });

    await _serverEventsSubscription?.cancel();
    _serverEventsSubscription = connectionManager.serverEvents.listen((v) {
      _serverEvents.add(v);
    });

    await _serverConnectionManagerStateEventsSubscription?.cancel();
    _serverConnectionManagerStateEventsSubscription = connectionManager.state.listen((v) {
      _serverConnectionManagerStateEvents.add(v);
      if (v == ApiManagerState.waitingRefreshToken && !newRepositories.logoutStarted) {
        // Tokens are invalid. Logout is required.
        newRepositories.logoutStarted = true;
        log.info("Automatic logout");
        _logoutWithRepository(newRepositories);
      }
    });

    _repositories = newRepositories;

    return newRepositories;
  }

  Stream<SignInWithGoogleEvent> signInWithGoogle() async* {
    final GoogleSignInAccount? signedIn;
    try {
      signedIn = await _google.signIn();
    } catch (e) { // No documentation, just catch everything
      yield SignInWithGoogleEvent.signInWithGoogleFailed;
      return;
    }

    if (signedIn == null) {
      yield SignInWithGoogleEvent.signInWithGoogleFailed;
      return;
    }

    yield SignInWithGoogleEvent.getGoogleAccountTokenCompleted;

    switch (await _handleSignInWithGoogleAccountInfo(signedIn)) {
      case Ok():
        ();
      case Err(:final e):
        yield e;
    }
  }

  ClientInfo _clientInfo() {
    final ClientType clientType;
    if (kIsWeb) {
      clientType = ClientType.web;
    } else if (Platform.isAndroid) {
      clientType = ClientType.android;
    } else if (Platform.isIOS) {
      clientType = ClientType.ios;
    } else {
      throw UnsupportedError("Unsupported platform");
    }
    // TODO(prod): Send proper version number. Check also websocket code version
    // number.
    return ClientInfo(
      clientType: clientType, majorVersion: 0, minorVersion: 0, patchVersion: 0);
  }

  Future<Result<void, SignInWithGoogleEvent>> _handleSignInWithGoogleAccountInfo(GoogleSignInAccount signedIn) async {
    final token = await signedIn.authentication;
    final info = SignInWithLoginInfo(googleToken: token.idToken, clientInfo: _clientInfo());
    final login = await _apiNoConnection.account((api) => api.postSignInWithLogin(info)).ok();
    if (login == null) {
      return const Err(SignInWithGoogleEvent.serverRequestFailed);
    }

    return await _handleLoginResult(login)
      .mapErr((e) {
        switch (e) {
          case CommonSignInError.unsupportedClient:
            return SignInWithGoogleEvent.unsupportedClient;
          case CommonSignInError.otherError:
            return SignInWithGoogleEvent.otherError;
        }
      });
  }

  Future<Result<void, CommonSignInError>> _handleLoginResult(LoginResult loginResult) async {
    if (loginResult.errorUnsupportedClient) {
      // TODO(prod): Add proper error type and show error in bloc
      return const Err(CommonSignInError.unsupportedClient);
    }
    final aid = loginResult.aid;
    final authPair = loginResult.account;
    if (aid == null || authPair == null) {
      return const Err(CommonSignInError.otherError);
    }
    final accountDb = DatabaseManager.getInstance().getAccountDatabaseManager(aid);
    final r = await DatabaseManager.getInstance().setAccountId(aid)
      .andThen(
        (_) => accountDb.accountAction(
          (db) => db.daoAccountSettings.updateEmailAddress(loginResult.email)
        )
      );
    if (r.isErr()) {
      return const Err(CommonSignInError.otherError);
    }

    // Login repository
    await accountDb.accountAction((db) => db.daoTokens.updateRefreshTokenAccount(authPair.refresh.token));
    await accountDb.accountAction((db) => db.daoTokens.updateAccessTokenAccount(authPair.access.accessToken));
    // TODO(microservice): microservice support
    await onLogin();

    final theNewRepositories = await _createRepositories(aid, accountLoginHappened: true);

    // Other repostories
    await theNewRepositories.onLogin();

    // The loginInProgress keeps the UI in login screen even if app
    // connects to server.
    _loginInProgress.add(true);
    await theNewRepositories.connectionManager.restart();
    if (await theNewRepositories.connectionManager.tryWaitUntilConnected(waitTimeoutSeconds: 7)) {
      final r = await theNewRepositories.onLoginDataSync();
      if (r.isErr()) {
        showSnackBar(R.strings.generic_data_sync_failed);
      }
    } else {
      showSnackBar(R.strings.generic_data_sync_failed);
    }
    _loginInProgress.add(false);
    return const Ok(null);
  }

  /// Logout back to login or demo account screen
  Future<void> logout() async {
    final repository = _repositories;

    if (repository != null && !repository.logoutStarted) {
      repository.logoutStarted = true;

      final r = await repository.api.accountAction((api) => api.postLogout());
      if (r.isErr()) {
        showSnackBar(R.strings.generic_logout_failed);
      }

      await _logoutWithRepository(repository);
    }
  }

  Future<void> _logoutWithRepository(RepositoryInstances repository) async {
    log.info("Logout started");
    // Disconnect, so that server does not send events to client
    await repository.connectionManager.closeAndLogout();

    // Login repository
    await repository.accountDb.accountAction((db) => db.daoTokens.updateRefreshTokenAccount(null));
    await repository.accountDb.accountAction((db) => db.daoTokens.updateAccessTokenAccount(null));
    // await onLogout(); // Not used currently
    // TODO(microservice): microservice support

    // Other repositories
    await repository.onLogout();

    try {
      // TODO(prod): There is also google.disconnect(). Should that used instead?
      await _google.signOut();
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
      await _apiNoConnection.account((api) => api.postSignInWithLogin(SignInWithLoginInfo(appleToken: signedIn.identityToken, clientInfo: _clientInfo())));
    } on SignInWithAppleException catch (_) {
      log.error("Sign in with Apple failed");
    }
  }

  // TODO(prod): Remove runtime server address changing?
  Future<void> setCurrentServerAddress(String serverAddress) async {
    await BackgroundDatabaseManager.getInstance().commonAction(
      (db) => db.updateServerUrlAccount(serverAddress),
    );
    await _apiNoConnection.updateAddressFromConfigAndReturnIt();
    await _repositories?.connectionManager.closeAndRefreshServerAddressAndLogout();
  }

  Future<Result<void, void>> demoAccountLogin(DemoAccountCredentials credentials) async {
    _demoAccountLoginInProgress.add(true);
    final loginResult = await _apiNoConnection.account((api) => api.postDemoModeLogin(DemoModePassword(password: credentials.id))).ok();
    _demoAccountLoginInProgress.add(false);

    final loginToken = loginResult?.token;
    if (loginToken == null) {
      return const Err(null);
    }

    final loginResult2 = await _apiNoConnection.account((api) => api.postDemoModeConfirmLogin(
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

    final token = await demoAccountToken.first;
    if (token != null) {
      final r = await _apiNoConnection.accountAction((api) => api.postDemoModeLogout(DemoModeToken(token: token)));
      if (r.isErr()) {
        showSnackBar(R.strings.generic_logout_failed);
      }
    }

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
    final accounts = await _apiNoConnection.account((api) => api.postDemoModeAccessibleAccounts(DemoModeToken(token: token))).ok();
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
    final id = await _apiNoConnection.account((api) => api.postDemoModeRegisterAccount(demoToken)).ok();
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
    final loginResult = await _apiNoConnection.account((api) => api.postDemoModeLoginToAccount(DemoModeLoginToAccount(aid: id, token: demoToken))).ok();
    if (loginResult != null) {
      switch (await _handleLoginResult(loginResult)) {
        case Err(:final e):
          switch (e) {
            case CommonSignInError.unsupportedClient:
              return Err(UnsupportedClient());
            case CommonSignInError.otherError:
              return Err(OtherError());
          }
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
class UnsupportedClient extends SessionOrOtherError {}
class OtherError extends SessionOrOtherError {}

enum SignInWithGoogleEvent {
  getGoogleAccountTokenCompleted,
  signInWithGoogleFailed,
  serverRequestFailed,
  unsupportedClient,
  otherError,
}

enum CommonSignInError {
  unsupportedClient,
  otherError,
}

const String emailScope = "https://www.googleapis.com/auth/userinfo.email";

GoogleSignIn createSignInWithGoogle() {
  if (kIsWeb || Platform.isAndroid) {
    return GoogleSignIn(
      scopes: [emailScope],
    );
  } else if (Platform.isIOS) {
    return GoogleSignIn(
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
  final UtcDateTime creationTime = UtcDateTime.now();
  /// True only if repository was created because of manual login action.
  /// Usually this is false as usually the account is logged in when app starts.
  final bool accountLoginHappened;
  final CommonRepository common;
  final ChatRepository chat;
  final MediaRepository media;
  final ProfileRepository profile;
  final AccountRepository account;

  // Only lifecycle methods
  final ImageCacheSettings imageCacheSettings;

  // No lifecycle or other methods
  final AccountBackgroundDatabaseManager accountBackgroundDb;
  final AccountDatabaseManager accountDb;
  final ServerConnectionManager connectionManager;

  bool logoutStarted = false;

  ApiManager get api => connectionManager.api;

  RepositoryInstances({
    required this.accountId,
    required this.accountLoginHappened,
    required this.common,
    required this.chat,
    required this.media,
    required this.profile,
    required this.account,
    required this.imageCacheSettings,
    required this.accountBackgroundDb,
    required this.accountDb,
    required this.connectionManager,
  });

  Future<void> init() async {
    await connectionManager.init();
    await common.init();
    await chat.init();
    await media.init();
    await profile.init();
    await account.init();
    await imageCacheSettings.init();
  }

  Future<void> dispose() async {
    await imageCacheSettings.dispose();
    await account.dispose();
    await profile.dispose();
    await media.dispose();
    await chat.dispose();
    await common.dispose();
    await connectionManager.dispose();
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
  Future<Result<void, void>> onLoginDataSync() async {
    return await common.onLoginDataSync()
      .andThen((_) => chat.onLoginDataSync())
      .andThen((_) => media.onLoginDataSync())
      .andThen((_) => profile.onLoginDataSync())
      .andThen((_) => account.onLoginDataSync());
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
