import 'dart:async';

import 'package:app/data/app_version.dart';
import 'package:app/data/utils/demo_account_manager.dart';
import 'package:app/data/utils/login_repository_types.dart';
import 'package:app/data/utils/repository_instances.dart';
import 'package:app/data/utils/sign_in_with_apple.dart';
import 'package:app/data/utils/sign_in_with_google.dart';
import 'package:database/database.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:app/api/server_connection_manager.dart';
import 'package:app/config.dart';
import 'package:app/data/account_repository.dart';
import 'package:app/database/account_database_manager.dart';
import 'package:app/database/background_database_manager.dart';
import 'package:app/database/database_manager.dart';
import 'package:app/utils/result.dart';
import 'package:rxdart/rxdart.dart';
import 'package:utils/utils.dart';

final _log = Logger("LoginRepository");

sealed class LoginRepositoryCmd<T> {
  final BehaviorSubject<T?> completed = BehaviorSubject.seeded(null);

  Future<T> waitCompletion() async {
    return await completed.whereType<T>().first;
  }
}

class LogoutAndSignInWithLogin extends LoginRepositoryCmd<Result<(), SignInWithEvent>> {
  final SignInWithLoginInfo info;
  LogoutAndSignInWithLogin(this.info);
}

/// Logout from current or specific account
class Logout extends LoginRepositoryCmd<()> {
  final AccountId? id;
  Logout(this.id);
}

class GetServerAddress extends LoginRepositoryCmd<String> {}

class ChangeServerAddress extends LoginRepositoryCmd<Result<(), ()>> {
  final String address;
  ChangeServerAddress(this.address);
}

class DemoAccountLogin extends LoginRepositoryCmd<Result<(), DemoAccountLoginError>> {
  final DemoAccountCredentials credentials;
  DemoAccountLogin(this.credentials);
}

class DemoAccountLogout extends LoginRepositoryCmd<()> {}

class DemoAccountGetAccounts
    extends LoginRepositoryCmd<Result<List<AccessibleAccount>, DemoAccountError>> {}

class DemoAccountRegisterIfNeededAndLoginToAccount
    extends LoginRepositoryCmd<Result<(), DemoAccountError>> {
  final AccountId? id;
  DemoAccountRegisterIfNeededAndLoginToAccount(this.id);
}

class LoginRepository extends AppSingleton {
  LoginRepository._private();
  static final _instance = LoginRepository._private();
  factory LoginRepository.getInstance() {
    return _instance;
  }

  bool _initDone = false;

  final BehaviorSubject<RepositoriesStreamValue> _repositories = BehaviorSubject.seeded(
    RepositoriesEmpty(),
  );
  RepositoryInstances? get repositoriesOrNull => _repositories.value.repositoriesOrNull;

  late ApiManagerNoConnection _apiNoConnection;

  final SignInWithGoogleManager _google = SignInWithGoogleManager();

  final RepositoryStateStreams _repositoryStateStreams = RepositoryStateStreams();
  Stream<AccountStateStreamValue> get accountState => _repositoryStateStreams.accountState;
  Stream<bool> get initialSetupSkipped => _repositoryStateStreams.initialSetupSkipped;

  final BehaviorSubject<LoginState> _loginState = BehaviorSubject.seeded(LsSplashScreen());
  final BehaviorSubject<bool> _loginInProgress = BehaviorSubject.seeded(false);

  final PublishSubject<LoginRepositoryCmd<Object>> _cmds = PublishSubject();

  // Main app state streams
  Stream<LoginState> get loginState => _loginState.distinct();
  Stream<String> get accountServerAddress => BackgroundDatabaseManager.getInstance()
      .commonStreamOrDefault((db) => db.app.watchServerUrl(), defaultServerUrl())
      .distinct(); // Avoid loop in ServerAddressBloc

  // Demo account
  final DemoAccountManager _demoAccountManager = DemoAccountManager();
  Stream<String?> get demoAccountUsername => _demoAccountManager.demoAccountUsername;
  Stream<String?> get demoAccountPassword => _demoAccountManager.demoAccountPassword;
  Stream<bool> get demoAccountLoginProgress => _demoAccountManager.demoAccountLoginProgress;

  // Account
  Stream<AccountId?> get accountId => BackgroundDatabaseManager.getInstance().commonStream(
    (db) => db.loginSession.watchAccountId(),
  );

  @override
  Future<void> init() async {
    if (_initDone) {
      return;
    }
    _initDone = true;

    final serverAddress = await BackgroundDatabaseManager.getInstance().commonStreamSingleOrDefault(
      (db) => db.app.watchServerUrl(),
      defaultServerUrl(),
    );
    _apiNoConnection = await ApiManagerNoConnection.create(serverAddress);

    initCmdHandling();

    await _google.init();

    final currentAccountId = await accountId.first;
    if (currentAccountId != null) {
      final createdRepositories = await _createAndReplaceRepositories(currentAccountId);
      await createdRepositories.onResumeAppUsage();
      unawaited(createdRepositories.connectionManager.restart());
    } else {
      _repositories.add(RepositoriesEmpty());
      await _repositoryStateStreams._logout();
    }

    Rx.combineLatest4(
      _repositories,
      _repositoryStateStreams._serverConnectionManagerStateEvents,
      _demoAccountManager.demoAccountToken,
      _loginInProgress,
      (a, b, c, d) => (a, b, c, d),
    ).listen((event) {
      final (repositories, serverConnectionState, demoAccountToken, loginInProgress) = event;
      _log.finer(
        "$repositories, $serverConnectionState, demoAccountToken: ${demoAccountToken != null}, loginInProgress: $loginInProgress",
      );

      void handleLoginRequired() {
        if (demoAccountToken != null) {
          _loginState.add(LsDemoAccount());
        } else {
          _loginState.add(LsLoginRequired());
        }
      }

      if (loginInProgress) {
        handleLoginRequired();
        return;
      }

      switch (repositories) {
        case RepositoriesLoading():
          _loginState.add(LsSplashScreen());
        case RepositoriesEmpty():
          handleLoginRequired();
        case RepositoriesExists():
          switch (serverConnectionState) {
            case ServerConnectionStateLoading():
              _loginState.add(LsLoggedIn(repositories.repositories));
            case ServerConnectionStateExists():
              switch (serverConnectionState.state) {
                case ServerConnectionState.waitingRefreshToken ||
                    ServerConnectionState.connecting ||
                    ServerConnectionState.reconnectWaitTime ||
                    ServerConnectionState.noConnection ||
                    ServerConnectionState.connected:
                  _loginState.add(LsLoggedIn(repositories.repositories));
                case ServerConnectionState.unsupportedClientVersion:
                  _loginState.add(
                    LsLoggedIn(repositories.repositories, unsupportedClientVersion: true),
                  );
              }
          }
      }
    });
  }

  void initCmdHandling() {
    _cmds
        .asyncMap((cmd) async {
          _log.info("cmd: ${cmd.runtimeType}");
          switch (cmd) {
            case LogoutAndSignInWithLogin():
              await _logoutInternal(null);
              cmd.completed.add(await _handleSignInWithLoginInfoInternal(cmd.info));
            case Logout():
              await _logoutInternal(cmd.id);
              cmd.completed.add(());
            case GetServerAddress():
              cmd.completed.add(_apiNoConnection.serverAddress);
            case ChangeServerAddress():
              final Result<(), ()> result;
              if (repositoriesOrNull != null) {
                result = Err(());
              } else {
                result = await BackgroundDatabaseManager.getInstance()
                    .commonAction((db) => db.app.updateServerUrl(cmd.address))
                    .emptyErr()
                    .andThen((_) async {
                      _apiNoConnection = await ApiManagerNoConnection.create(cmd.address);
                      return Ok(());
                    });
              }
              cmd.completed.add(result);
            case DemoAccountLogin():
              final r = await _demoAccountManager.demoAccountLogin(
                cmd.credentials,
                apiNoConnection: _apiNoConnection,
              );
              cmd.completed.add(r);
            case DemoAccountLogout():
              await _demoAccountManager.demoAccountLogout(apiNoConnection: _apiNoConnection);
              cmd.completed.add(());
            case DemoAccountGetAccounts():
              final r = await _demoAccountManager.demoAccountGetAccounts(
                apiNoConnection: _apiNoConnection,
              );
              cmd.completed.add(r);
            case DemoAccountRegisterIfNeededAndLoginToAccount():
              await _logoutInternal(null);
              final Result<(), DemoAccountError> r;
              final result = await _demoAccountManager.demoAccountRegisterIfNeededAndLogin(
                id: cmd.id,
                apiNoConnection: _apiNoConnection,
              );
              switch (result) {
                case Ok():
                  switch (await _handleLoginResultInternal(result.v)) {
                    case Ok():
                      r = Ok(());
                    case Err(:final e):
                      r = Err(DemoAccountSignInError(e));
                  }
                case Err():
                  r = Err(result.e);
              }
              cmd.completed.add(r);
          }
        })
        .listen(null);
  }

  Future<RepositoryInstances> _createAndReplaceRepositories(
    AccountId accountId, {
    bool accountLoginHappened = false,
  }) async {
    final createdRepositories = await RepositoryInstances.createAndInit(
      accountId,
      accountLoginHappened: accountLoginHappened,
      serverAddress: _apiNoConnection.serverAddress,
    );

    await _repositoryStateStreams._subscribe(
      createdRepositories.account,
      createdRepositories.accountDb,
      createdRepositories.connectionManager,
    );

    final currentRepositories = repositoriesOrNull;
    _repositories.add(RepositoriesExists(createdRepositories));
    await currentRepositories?.logoutAndDispose();

    return createdRepositories;
  }

  Future<Result<(), SignInWithEvent>> _handleSignInWithLoginInfoInternal(
    SignInWithLoginInfo info,
  ) async {
    final login = await _apiNoConnection.account((api) => api.postSignInWithLogin(info)).ok();
    if (login == null) {
      return Err(SignInWithSignInError(CommonSignInError.loginApiRequestFailed));
    }
    return await _handleLoginResultInternal(login).mapErr((e) {
      return SignInWithSignInError(e);
    });
  }

  Future<Result<(), CommonSignInError>> _handleLoginResultInternal(LoginResult loginResult) async {
    if (loginResult.errorUnsupportedClient) {
      return const Err(CommonSignInError.unsupportedClient);
    }
    final aid = loginResult.aid;
    final authPair = loginResult.account;
    if (aid == null || authPair == null) {
      _log.error("LoginResult doesn't contain required info");
      return const Err(CommonSignInError.otherError);
    }
    final accountDb = DatabaseManager.getInstance().getAccountDatabaseManager(aid);
    final r = await DatabaseManager.getInstance()
        .setAccountId(aid)
        .andThen(
          (_) => accountDb.accountAction((db) => db.account.updateEmailAddress(loginResult.email)),
        )
        .andThen(
          (_) =>
              accountDb.accountAction((db) => db.loginSession.updateAccessToken(authPair.access)),
        )
        .andThen(
          (_) =>
              accountDb.accountAction((db) => db.loginSession.updateRefreshToken(authPair.refresh)),
        );
    if (r.isErr()) {
      _log.error("Login failed: database error");
      return const Err(CommonSignInError.otherError);
    }

    // The loginInProgress keeps the UI in login screen even if app
    // connects to server.
    _loginInProgress.add(true);

    final createdRepositories = await _createAndReplaceRepositories(
      aid,
      accountLoginHappened: true,
    );
    await createdRepositories.onLogin();
    await createdRepositories.connectionManager.restart();

    final CommonSignInError? error;
    if (await createdRepositories.connectionManager.tryWaitUntilConnected(waitTimeoutSeconds: 7)) {
      final r = await createdRepositories.onLoginDataSync();
      if (r.isErr()) {
        error = CommonSignInError.dataSyncFailed;
      } else {
        error = null;
      }
    } else {
      error = CommonSignInError.creatingConnectingWebSocketFailed;
    }

    Result<(), CommonSignInError> result;
    if (error == null) {
      result = Ok(());
    } else {
      result = Err(error);
      _log.error("Starting logout because login failed: $error");
      await _logoutInternal(createdRepositories.accountId);
    }

    _loginInProgress.add(false);

    return result;
  }

  /// Logout from current or specific account
  Future<void> _logoutInternal(AccountId? id) async {
    final currentRepositories = repositoriesOrNull;
    if (currentRepositories != null && (id == null || id == currentRepositories.accountId)) {
      _log.info("Logout started");
      await _repositoryStateStreams._logout();
      await currentRepositories.logoutAndDispose();
      await _google.logout();
      _repositories.add(RepositoriesEmpty());
      _log.info("Logout completed");
    }
  }

  Future<Result<(), SignInWithEvent>> sendSignInWithLoginCmd(SignInWithLoginInfo info) async {
    final event = LogoutAndSignInWithLogin(info);
    _cmds.add(event);
    return await event.waitCompletion();
  }

  Stream<SignInWithEvent> signInWithGoogle() async* {
    final info = await _google.login().ok();
    if (info == null) {
      yield SignInWithGetTokenFailed();
      return;
    }

    yield SignInWithGetTokenCompleted();

    switch (await sendSignInWithLoginCmd(info)) {
      case Ok():
        ();
      case Err(:final e):
        yield e;
    }
  }

  /// On Android this might not never complete
  Stream<SignInWithEvent> signInWithApple() async* {
    final event = GetServerAddress();
    _cmds.add(event);
    final r = await SignInWithAppleManager.signInWithApple(
      currentServerAddress: await event.waitCompletion(),
    );

    switch (r) {
      case Ok():
        yield SignInWithGetTokenCompleted();
        final info = SignInWithLoginInfo(
          apple: r.v,
          clientInfo: AppVersionManager.getInstance().clientInfo(),
        );
        switch (await sendSignInWithLoginCmd(info)) {
          case Ok():
            ();
          case Err(:final e):
            yield e;
        }
      case Err():
        yield r.e;
    }
  }

  /// Logout back to login or demo account screen
  Future<void> logout(AccountId? id) async {
    final event = Logout(id);
    _cmds.add(event);
    await event.waitCompletion();
  }

  Future<Result<(), ()>> setCurrentServerAddress(String serverAddress) async {
    final event = ChangeServerAddress(serverAddress);
    _cmds.add(event);
    return await event.waitCompletion();
  }

  Future<Result<(), DemoAccountLoginError>> demoAccountLogin(
    DemoAccountCredentials credentials,
  ) async {
    final event = DemoAccountLogin(credentials);
    _cmds.add(event);
    return await event.waitCompletion();
  }

  Future<void> demoAccountLogout() async {
    final event = DemoAccountLogout();
    _cmds.add(event);
    await event.waitCompletion();
  }

  Future<Result<List<AccessibleAccount>, DemoAccountError>> demoAccountGetAccounts() async {
    final event = DemoAccountGetAccounts();
    _cmds.add(event);
    return await event.waitCompletion();
  }

  Future<Result<(), DemoAccountError>> demoAccountRegisterIfNeededAndLogin(AccountId? id) async {
    final event = DemoAccountRegisterIfNeededAndLoginToAccount(id);
    _cmds.add(event);
    return await event.waitCompletion();
  }
}

sealed class DemoAccountError {}

class DemoAccountLoggedOutFromDemoAccount extends DemoAccountError {}

class DemoAccountSessionExpired extends DemoAccountError {}

class DemoAccountSignInError extends DemoAccountError {
  final CommonSignInError error;
  DemoAccountSignInError(this.error);
}

sealed class SignInWithEvent {}

class SignInWithGetTokenCompleted extends SignInWithEvent {}

class SignInWithGetTokenFailed extends SignInWithEvent {}

class SignInWithSignInError extends SignInWithEvent {
  final CommonSignInError error;
  SignInWithSignInError(this.error);
}

enum CommonSignInError {
  loginApiRequestFailed,
  unsupportedClient,
  creatingConnectingWebSocketFailed,
  dataSyncFailed,
  otherError,
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

  final BehaviorSubject<ServerConnectionStateStreamValue> _serverConnectionManagerStateEvents =
      BehaviorSubject.seeded(ServerConnectionStateLoading());
  StreamSubscription<ServerConnectionState>? _serverConnectionManagerStateEventsSubscription;
  Stream<ServerConnectionStateStreamValue> get serverConnectionState =>
      _serverConnectionManagerStateEvents;

  Future<void> _subscribe(
    AccountRepository account,
    AccountDatabaseManager accountDb,
    ServerConnectionManager connectionManager,
  ) async {
    await _accountStateSubscription?.cancel();
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
      _serverConnectionManagerStateEvents.add(ServerConnectionStateExists(v));
    });
  }

  Future<void> _logout() async {
    await _accountStateSubscription?.cancel();
    _accountState.add(AccountStateLoading());

    await _initialSetupSkippedSubscription?.cancel();
    _initialSetupSkipped.add(false);

    await _serverConnectionManagerStateEventsSubscription?.cancel();
    _serverConnectionManagerStateEvents.add(ServerConnectionStateLoading());
  }
}

sealed class AccountStateStreamValue {}

class AccountStateLoading extends AccountStateStreamValue {
  @override
  String toString() {
    return "AccountStateLoading";
  }
}

class AccountStateEmpty extends AccountStateStreamValue {
  @override
  String toString() {
    return "AccountStateEmpty";
  }
}

class AccountStateExists extends AccountStateStreamValue {
  final AccountState state;
  AccountStateExists(this.state);

  @override
  String toString() {
    return "Exists($state)";
  }
}

sealed class ServerConnectionStateStreamValue {}

class ServerConnectionStateLoading extends ServerConnectionStateStreamValue {
  @override
  String toString() {
    return "ServerConnectionStateLoading";
  }
}

class ServerConnectionStateExists extends ServerConnectionStateStreamValue {
  final ServerConnectionState state;
  ServerConnectionStateExists(this.state);

  @override
  String toString() {
    return "Exists($state)";
  }
}
