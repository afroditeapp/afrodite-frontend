import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:app/data/app_version.dart';
import 'package:app/data/utils/sign_in_with_apple.dart';
import 'package:app/data/utils/sign_in_with_google.dart';
import 'package:crypto/crypto.dart';
import 'package:database/database.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:app/api/api_manager.dart';
import 'package:app/config.dart';
import 'package:app/data/account/client_id_manager.dart';
import 'package:app/data/account_repository.dart';
import 'package:app/data/chat/message_key_generator.dart';
import 'package:app/data/chat_repository.dart';
import 'package:app/data/common_repository.dart';
import 'package:app/data/media_repository.dart';
import 'package:app/data/profile_repository.dart';
import 'package:app/data/utils.dart';
import 'package:app/database/account_background_database_manager.dart';
import 'package:app/database/account_database_manager.dart';
import 'package:app/database/background_database_manager.dart';
import 'package:app/database/database_manager.dart';
import 'package:app/localizations.dart';
import 'package:app/service_config.dart';
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

enum LoginRepositoryState { initRequired, initComplete }

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

  late final SignInWithGoogleManager _google;

  final RepositoryStateStreams _repositoryStateStreams = RepositoryStateStreams();
  Stream<AccountStateStreamValue> get accountState => _repositoryStateStreams.accountState;
  Stream<bool> get initialSetupSkipped => _repositoryStateStreams.initialSetupSkipped;

  final BehaviorSubject<LoginState> _loginState = BehaviorSubject.seeded(LoginState.splashScreen);
  final BehaviorSubject<LoginRepositoryState> _internalState = BehaviorSubject.seeded(
    LoginRepositoryState.initRequired,
  );
  final BehaviorSubject<bool> _demoAccountLoginProgress = BehaviorSubject.seeded(false);
  final BehaviorSubject<bool> _loginInProgress = BehaviorSubject.seeded(false);

  StreamSubscription<ServerConnectionState>? _repositorySpecificAutomaticLogoutSubscription;

  // Main app state streams
  Stream<LoginState> get loginState => _loginState.distinct();
  Stream<String> get accountServerAddress => BackgroundDatabaseManager.getInstance()
      .commonStreamOrDefault((db) => db.app.watchServerUrl(), defaultServerUrl())
      .distinct(); // Avoid loop in ServerAddressBloc

  // Demo account
  Stream<String?> get demoAccountUsername =>
      DatabaseManager.getInstance().commonStream((db) => db.demoAccount.watchDemoAccountUsername());

  Stream<String?> get demoAccountPassword =>
      DatabaseManager.getInstance().commonStream((db) => db.demoAccount.watchDemoAccountPassword());

  Stream<String?> get demoAccountToken =>
      DatabaseManager.getInstance().commonStream((db) => db.demoAccount.watchDemoAccountToken());
  Stream<bool> get demoAccountLoginProgress => _demoAccountLoginProgress;

  // Account
  Stream<AccountId?> get accountId => BackgroundDatabaseManager.getInstance().commonStream(
    (db) => db.loginSession.watchAccountId(),
  );

  @override
  Future<void> init() async {
    if (_internalState.value != LoginRepositoryState.initRequired) {
      return;
    }
    _internalState.add(LoginRepositoryState.initComplete);

    _google = SignInWithGoogleManager();
    await _google.init();

    await _apiNoConnection.init();

    final currentAccountId = await accountId.first;
    if (currentAccountId != null) {
      await _createRepositories(currentAccountId);

      // Restore previous state
      final previousState = await repositories.accountDb
          .accountStreamSingle((db) => db.account.watchAccountState())
          .ok();
      if (previousState != null) {
        _loginState.add(LoginState.viewAccountStateOnceItExists);
        await onResumeAppUsage();
        await _repositories?.onResumeAppUsage();
      }
    }

    Rx.combineLatest3(
      _repositoryStateStreams._serverConnectionManagerStateEvents,
      demoAccountToken,
      _loginInProgress,
      (a, b, c) => (a, b, c),
    ).listen((event) {
      final (serverConnectionState, demoAccountToken, loginInProgress) = event;
      log.finer(
        "state changed. serverConnectionState: $serverConnectionState, demoAccountToken: ${demoAccountToken != null}, loginInProgress: $loginInProgress",
      );
      if (loginInProgress) {
        if (demoAccountToken != null) {
          _loginState.add(LoginState.demoAccount);
        } else {
          _loginState.add(LoginState.loginRequired);
        }
        return;
      }

      switch (serverConnectionState) {
        case ServerConnectionState.waitingRefreshToken:
          if (demoAccountToken != null) {
            _loginState.add(LoginState.demoAccount);
          } else {
            _loginState.add(LoginState.loginRequired);
          }
        case ServerConnectionState.connecting ||
            ServerConnectionState.reconnectWaitTime ||
            ServerConnectionState.noConnection:
          {}
        case ServerConnectionState.connected:
          _loginState.add(LoginState.viewAccountStateOnceItExists);
        case ServerConnectionState.unsupportedClientVersion:
          _loginState.add(LoginState.unsupportedClientVersion);
      }
    });

    if (currentAccountId == null) {
      // ServerConnectionManager is not yet created so init
      // _serverConnectionManagerStateEvents manually so that previous
      // combineLatest3 starts working.
      _repositoryStateStreams._handleAppStartWithoutLoggedInAccount();
    }
  }

  Future<RepositoryInstances> _createRepositories(
    AccountId accountId, {
    bool accountLoginHappened = false,
  }) async {
    final currentRepositories = _repositories;
    await currentRepositories?.dispose();

    final accountBackgroundDb = BackgroundDatabaseManager.getInstance()
        .getAccountBackgroundDatabaseManager(accountId);
    final accountDb = DatabaseManager.getInstance().getAccountDatabaseManager(accountId);

    final connectionManager = ServerConnectionManager(accountDb, accountBackgroundDb, accountId);
    final clientIdManager = ClientIdManager(accountDb, connectionManager.api);

    final account = AccountRepository(
      db: accountDb,
      accountBackgroundDb: accountBackgroundDb,
      connectionManager: connectionManager,
      clientIdManager: clientIdManager,
      rememberToInitRepositoriesLateFinal: true,
      currentUser: accountId,
    );
    final media = MediaRepository(
      account,
      accountDb,
      accountBackgroundDb,
      connectionManager,
      accountId,
    );
    final profile = ProfileRepository(
      media,
      account,
      accountDb,
      accountBackgroundDb,
      connectionManager,
      accountId,
    );
    final common = CommonRepository(connectionManager, profile);
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
      accountBackgroundDb: accountBackgroundDb,
      accountDb: accountDb,
      connectionManager: connectionManager,
    );
    account.repositories = newRepositories;
    await newRepositories.init();

    await _repositoryStateStreams._subscribe(account, accountDb, connectionManager);

    await _repositorySpecificAutomaticLogoutSubscription?.cancel();
    _repositorySpecificAutomaticLogoutSubscription = connectionManager.state.listen((v) {
      if (v == ServerConnectionState.waitingRefreshToken && !newRepositories.logoutStarted) {
        // Tokens are invalid. Logout is required.
        newRepositories.logoutStarted = true;
        log.info("Automatic logout");
        _logoutWithRepository(newRepositories);
      }
    });

    _repositories = newRepositories;

    return newRepositories;
  }

  Stream<SignInWithEvent> signInWithGoogle() async* {
    final info = await _google.login().ok();
    if (info == null) {
      yield SignInWithEvent.getTokenFailed;
      return;
    }

    yield SignInWithEvent.getTokenCompleted;

    switch (await handleSignInWithLoginInfo(info)) {
      case Ok():
        ();
      case Err(:final e):
        yield e;
    }
  }

  ClientInfo clientInfo() {
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
    return ClientInfo(
      clientType: clientType,
      clientVersion: AppVersionManager.getInstance().clientVersion,
    );
  }

  Future<Result<(), SignInWithEvent>> handleSignInWithLoginInfo(SignInWithLoginInfo info) async {
    final login = await _apiNoConnection.account((api) => api.postSignInWithLogin(info)).ok();
    if (login == null) {
      return const Err(SignInWithEvent.serverRequestFailed);
    }

    return await _handleLoginResult(login).mapErr((e) {
      switch (e) {
        case CommonSignInError.unsupportedClient:
          return SignInWithEvent.unsupportedClient;
        case CommonSignInError.otherError:
          return SignInWithEvent.otherError;
      }
    });
  }

  Future<Result<(), CommonSignInError>> _handleLoginResult(LoginResult loginResult) async {
    if (loginResult.errorUnsupportedClient) {
      return const Err(CommonSignInError.unsupportedClient);
    }
    final aid = loginResult.aid;
    final authPair = loginResult.account;
    if (aid == null || authPair == null) {
      return const Err(CommonSignInError.otherError);
    }
    final accountDb = DatabaseManager.getInstance().getAccountDatabaseManager(aid);
    final r = await DatabaseManager.getInstance()
        .setAccountId(aid)
        .andThen(
          (_) => accountDb.accountAction((db) => db.account.updateEmailAddress(loginResult.email)),
        );
    if (r.isErr()) {
      return const Err(CommonSignInError.otherError);
    }

    // Login repository
    await accountDb.accountAction((db) => db.loginSession.updateRefreshToken(authPair.refresh));
    await accountDb.accountAction((db) => db.loginSession.updateAccessToken(authPair.access));
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
    return const Ok(());
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
    await repository.accountDb.accountAction((db) => db.loginSession.updateRefreshToken(null));
    await repository.accountDb.accountAction((db) => db.loginSession.updateAccessToken(null));
    // await onLogout(); // Not used currently

    // Other repositories
    await repository.onLogout();

    await _google.logout();

    log.info("Logout completed");
  }

  /// On Android this might not never complete
  Stream<SignInWithEvent> signInWithApple() async* {
    final Uri serverUrl;
    try {
      serverUrl = Uri.parse(_apiNoConnection.currentServerAddress());
    } catch (_) {
      yield SignInWithEvent.otherError;
      return;
    }

    final nonce = generateNonceBytes().toList();
    final nonceBase64Url = base64UrlEncode(nonce);
    final hashedNonceBase64Url = base64UrlEncode(sha256.convert(nonce).bytes);

    AuthorizationCredentialAppleID signedIn;
    try {
      // On Android this might not never complete
      signedIn = await SignInWithApple.getAppleIDCredential(
        scopes: [AppleIDAuthorizationScopes.email],
        webAuthenticationOptions: WebAuthenticationOptions(
          clientId: signInWithAppleServiceIdForAndroidAndWebLogin(),
          redirectUri: kIsWeb
              ? signInWithAppleRedirectUrlForWeb()
              : serverUrl.replace(path: "account_api/sign_in_with_apple_redirect_to_app"),
        ),
        nonce: hashedNonceBase64Url,
      );
    } on SignInWithAppleException catch (_) {
      yield SignInWithEvent.getTokenFailed;
      return;
    }

    final token = signedIn.identityToken;
    if (token == null) {
      yield SignInWithEvent.getTokenFailed;
      return;
    }

    yield SignInWithEvent.getTokenCompleted;

    final info = SignInWithLoginInfo(
      apple: SignInWithAppleInfo(nonce: nonceBase64Url, token: token),
      clientInfo: clientInfo(),
    );
    switch (await handleSignInWithLoginInfo(info)) {
      case Ok():
        ();
      case Err(:final e):
        yield e;
    }
  }

  Future<void> setCurrentServerAddress(String serverAddress) async {
    await BackgroundDatabaseManager.getInstance().commonAction(
      (db) => db.app.updateServerUrl(serverAddress),
    );
    await _apiNoConnection.updateAddressFromConfigAndReturnIt();
    await _repositories?.connectionManager.closeAndRefreshServerAddressAndLogout();
  }

  Future<Result<(), DemoAccountLoginError>> demoAccountLogin(
    DemoAccountCredentials credentials,
  ) async {
    _demoAccountLoginProgress.add(true);
    final loginResult = await _apiNoConnection
        .account(
          (api) => api.postDemoAccountLogin(
            DemoAccountLoginCredentials(
              username: credentials.username,
              password: credentials.password,
            ),
          ),
        )
        .ok();
    _demoAccountLoginProgress.add(false);

    if (loginResult == null) {
      return const Err(DemoAccountLoginError.otherError);
    }

    if (loginResult.locked) {
      return const Err(DemoAccountLoginError.accountLocked);
    }

    final demoAccountToken = loginResult.token?.token;
    if (demoAccountToken == null) {
      return const Err(DemoAccountLoginError.otherError);
    }

    await DatabaseManager.getInstance().commonAction(
      (db) => db.demoAccount.updateDemoAccountUsername(credentials.username),
    );
    await DatabaseManager.getInstance().commonAction(
      (db) => db.demoAccount.updateDemoAccountPassword(credentials.password),
    );
    await DatabaseManager.getInstance().commonAction(
      (db) => db.demoAccount.updateDemoAccountToken(demoAccountToken),
    );

    return const Ok(());
  }

  Future<void> demoAccountLogout() async {
    log.info("demo account logout");

    final token = await demoAccountToken.first;
    if (token != null) {
      final r = await _apiNoConnection.accountAction(
        (api) => api.postDemoAccountLogout(DemoAccountToken(token: token)),
      );
      if (r.isErr()) {
        showSnackBar(R.strings.generic_logout_failed);
      }
    }

    await DatabaseManager.getInstance().commonAction(
      (db) => db.demoAccount.updateDemoAccountToken(null),
    );

    log.info("demo account logout completed");
  }

  Future<Result<List<AccessibleAccount>, SessionOrOtherError>> demoAccountGetAccounts() async {
    final token = await demoAccountToken.first;
    if (token == null) {
      return Err(OtherError());
    }
    final accounts = await _apiNoConnection.accountWrapper().requestValue(
      (api) => api.postDemoAccountAccessibleAccounts(DemoAccountToken(token: token)),
    );
    switch (accounts) {
      case Ok(:final v):
        return Ok(v);
      case Err(:final e):
        if (e.isUnauthorized()) {
          await demoAccountLogout();
          return Err(SessionExpired());
        } else {
          return Err(OtherError());
        }
    }
  }

  Future<Result<(), SessionOrOtherError>> demoAccountRegisterAndLogin() async {
    final token = await demoAccountToken.first;
    if (token == null) {
      return Err(OtherError());
    }
    final demoToken = DemoAccountToken(token: token);
    final id = await _apiNoConnection.accountWrapper().requestValue(
      (api) => api.postDemoAccountRegisterAccount(demoToken),
    );
    switch (id) {
      case Ok(:final v):
        return await demoAccountLoginToAccount(v);
      case Err(:final e):
        if (e.isUnauthorized()) {
          await demoAccountLogout();
          return Err(SessionExpired());
        } else {
          return Err(OtherError());
        }
    }
  }

  Future<Result<(), SessionOrOtherError>> demoAccountLoginToAccount(AccountId id) async {
    final token = await demoAccountToken.first;
    if (token == null) {
      return Err(OtherError());
    }
    final demoToken = DemoAccountToken(token: token);
    final loginResult = await _apiNoConnection.accountWrapper().requestValue(
      (api) => api.postDemoAccountLoginToAccount(
        DemoAccountLoginToAccount(aid: id, token: demoToken, clientInfo: clientInfo()),
      ),
    );
    switch (loginResult) {
      case Ok(:final v):
        switch (await _handleLoginResult(v)) {
          case Err(:final e):
            switch (e) {
              case CommonSignInError.unsupportedClient:
                return Err(UnsupportedClient());
              case CommonSignInError.otherError:
                return Err(OtherError());
            }
          case Ok():
            return const Ok(());
        }
      case Err(:final e):
        if (e.isUnauthorized()) {
          await demoAccountLogout();
          return Err(SessionExpired());
        } else {
          return Err(OtherError());
        }
    }
  }
}

class DemoAccountCredentials {
  final String username;
  final String password;
  DemoAccountCredentials(this.username, this.password);
}

enum DemoAccountLoginError { accountLocked, otherError }

sealed class SessionOrOtherError {}

class SessionExpired extends SessionOrOtherError {}

class UnsupportedClient extends SessionOrOtherError {}

class OtherError extends SessionOrOtherError {}

enum SignInWithEvent {
  getTokenCompleted,
  getTokenFailed,
  serverRequestFailed,
  unsupportedClient,
  otherError,
}

enum CommonSignInError { unsupportedClient, otherError }

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
  }

  Future<void> dispose() async {
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
  Future<Result<(), ()>> onLoginDataSync() async {
    return await common
        .onLoginDataSync()
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

class RepositoryStateStreams {
  final BehaviorSubject<AccountStateStreamValue> _accountState = BehaviorSubject.seeded(
    AccountStateLoading(),
  );
  StreamSubscription<AccountState?>? _accountStateSubscription;
  Stream<AccountStateStreamValue> get accountState => _accountState;

  final BehaviorSubject<bool> _initialSetupSkipped = BehaviorSubject.seeded(false);
  StreamSubscription<bool>? _initialSetupSkippedSubscription;
  Stream<bool> get initialSetupSkipped => _initialSetupSkipped;

  final PublishSubject<ServerConnectionState> _serverConnectionManagerStateEvents =
      PublishSubject();
  StreamSubscription<ServerConnectionState>? _serverConnectionManagerStateEventsSubscription;
  Stream<ServerConnectionState> get serverConnectionState => _serverConnectionManagerStateEvents;

  Future<void> _subscribe(
    AccountRepository account,
    AccountDatabaseManager accountDb,
    ServerConnectionManager connectionManager,
  ) async {
    await _accountStateSubscription?.cancel();
    _accountState.add(AccountStateLoading());
    _accountStateSubscription = account.accountState.listen((v) {
      if (v == null) {
        _accountState.add(AccountStateEmpty());
      } else {
        _accountState.add(AccountStateExists(v));
      }
    });

    await _initialSetupSkippedSubscription?.cancel();
    _initialSetupSkippedSubscription = accountDb
        .accountStream((db) => db.app.watchInitialSetupSkipped())
        .map((v) => v ?? false)
        .listen((v) {
          _initialSetupSkipped.add(v);
        });

    await _serverConnectionManagerStateEventsSubscription?.cancel();
    _serverConnectionManagerStateEventsSubscription = connectionManager.state.listen((v) {
      _serverConnectionManagerStateEvents.add(v);
    });
  }

  void _handleAppStartWithoutLoggedInAccount() {
    _serverConnectionManagerStateEvents.add(ServerConnectionState.waitingRefreshToken);
  }
}

sealed class AccountStateStreamValue {}

class AccountStateLoading extends AccountStateStreamValue {}

class AccountStateEmpty extends AccountStateStreamValue {}

class AccountStateExists extends AccountStateStreamValue {
  final AccountState state;
  AccountStateExists(this.state);

  @override
  String toString() {
    return "AccountStateExists($state)";
  }
}
