import 'dart:async';

import 'package:app/data/app_version.dart';
import 'package:app/data/utils/demo_account_manager.dart';
import 'package:app/data/utils/repository_instances.dart';
import 'package:app/data/utils/sign_in_with_apple.dart';
import 'package:app/data/utils/sign_in_with_google.dart';
import 'package:database/database.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:app/api/server_connection_manager.dart';
import 'package:app/config.dart';
import 'package:app/data/account_repository.dart';
import 'package:app/data/utils.dart';
import 'package:app/database/account_database_manager.dart';
import 'package:app/database/background_database_manager.dart';
import 'package:app/database/database_manager.dart';
import 'package:app/localizations.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:app/utils/result.dart';
import 'package:rxdart/rxdart.dart';

var log = Logger("LoginRepository");

enum LoginState {
  splashScreen,
  loginRequired,
  unsupportedClientVersion,
  demoAccount,
  viewAccountStateOnceItExists,
}

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

class Logout extends LoginRepositoryCmd<()> {}

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
    extends LoginRepositoryCmd<Result<List<AccessibleAccount>, SessionOrOtherError>> {}

class DemoAccountRegisterIfNeededAndLoginToAccount
    extends LoginRepositoryCmd<Result<(), SessionOrOtherError>> {
  final AccountId? id;
  DemoAccountRegisterIfNeededAndLoginToAccount(this.id);
}

class LoginRepository extends DataRepository {
  LoginRepository._private();
  static final _instance = LoginRepository._private();
  factory LoginRepository.getInstance() {
    return _instance;
  }

  bool _initDone = false;

  RepositoryInstances? _repositories;
  RepositoryInstances get repositories => _repositories!;
  RepositoryInstances? get repositoriesOrNull => _repositories;

  final ApiManager _apiNoConnection = ApiManager.withDefaultAddressAndNoConnection();

  final SignInWithGoogleManager _google = SignInWithGoogleManager();

  final RepositoryStateStreams _repositoryStateStreams = RepositoryStateStreams();
  Stream<AccountStateStreamValue> get accountState => _repositoryStateStreams.accountState;
  Stream<bool> get initialSetupSkipped => _repositoryStateStreams.initialSetupSkipped;

  final BehaviorSubject<LoginState> _loginState = BehaviorSubject.seeded(LoginState.splashScreen);
  final BehaviorSubject<bool> _loginInProgress = BehaviorSubject.seeded(false);

  final PublishSubject<LoginRepositoryCmd<Object>> _cmds = PublishSubject();
  StreamSubscription<ServerConnectionState>? _repositorySpecificAutomaticLogoutSubscription;

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
      _demoAccountManager.demoAccountToken,
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

    _cmds
        .asyncMap((cmd) async {
          log.info(cmd.runtimeType);
          switch (cmd) {
            case LogoutAndSignInWithLogin():
              await _logoutInternal();
              cmd.completed.add(await _handleSignInWithLoginInfoInternal(cmd.info));
            case Logout():
              await _logoutInternal();
              cmd.completed.add(());
            case GetServerAddress():
              cmd.completed.add(_apiNoConnection.currentServerAddress());
            case ChangeServerAddress():
              final Result<(), ()> result;
              if (_repositories != null) {
                result = Err(());
              } else {
                result = await BackgroundDatabaseManager.getInstance()
                    .commonAction((db) => db.app.updateServerUrl(cmd.address))
                    .emptyErr()
                    .andThen((_) async {
                      await _apiNoConnection.updateAddressFromConfigAndReturnIt();
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
              await _logoutInternal();
              final Result<(), SessionOrOtherError> r;
              final result = await _demoAccountManager.demoAccountRegisterIfNeededAndLogin(
                id: cmd.id,
                apiNoConnection: _apiNoConnection,
              );
              switch (result) {
                case Ok():
                  switch (await _handleLoginResultInternal(result.v)) {
                    case Ok():
                      r = Ok(());
                    case Err(e: CommonSignInError.unsupportedClient):
                      r = Err(UnsupportedClient());
                    case Err(e: CommonSignInError.otherError):
                      r = Err(OtherError());
                  }
                case Err():
                  r = Err(result.e);
              }
              cmd.completed.add(r);
          }
        })
        .listen(null);
  }

  Future<RepositoryInstances> _createRepositories(
    AccountId accountId, {
    bool accountLoginHappened = false,
  }) async {
    final currentRepositories = _repositories;
    await currentRepositories?.dispose();

    final newRepositories = await RepositoryInstances.createAndInit(
      accountId,
      accountLoginHappened: accountLoginHappened,
    );

    await _repositoryStateStreams._subscribe(
      newRepositories.account,
      newRepositories.accountDb,
      newRepositories.connectionManager,
    );

    await _repositorySpecificAutomaticLogoutSubscription?.cancel();
    _repositorySpecificAutomaticLogoutSubscription = newRepositories.connectionManager.state.listen(
      (v) {
        if (v == ServerConnectionState.waitingRefreshToken) {
          // Tokens are invalid. Logout is required.
          log.info("Automatic logout");
          logout();
        }
      },
    );

    _repositories = newRepositories;

    return newRepositories;
  }

  Future<Result<(), SignInWithEvent>> _handleSignInWithLoginInfoInternal(
    SignInWithLoginInfo info,
  ) async {
    final login = await _apiNoConnection.account((api) => api.postSignInWithLogin(info)).ok();
    if (login == null) {
      return const Err(SignInWithEvent.serverRequestFailed);
    }
    return await _handleLoginResultInternal(login).mapErr((e) {
      switch (e) {
        case CommonSignInError.unsupportedClient:
          return SignInWithEvent.unsupportedClient;
        case CommonSignInError.otherError:
          return SignInWithEvent.otherError;
      }
    });
  }

  Future<Result<(), CommonSignInError>> _handleLoginResultInternal(LoginResult loginResult) async {
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

  Future<void> _logoutInternal() async {
    final currentRepositories = _repositories;
    if (currentRepositories != null) {
      _repositories = null;
      log.info("Logout started");
      await currentRepositories.onLogout();
      await _google.logout();
      log.info("Logout completed");
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
      yield SignInWithEvent.getTokenFailed;
      return;
    }

    yield SignInWithEvent.getTokenCompleted;

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
        yield SignInWithEvent.getTokenCompleted;
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
  Future<void> logout() async {
    final event = Logout();
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

  Future<Result<List<AccessibleAccount>, SessionOrOtherError>> demoAccountGetAccounts() async {
    final event = DemoAccountGetAccounts();
    _cmds.add(event);
    return await event.waitCompletion();
  }

  Future<Result<(), SessionOrOtherError>> demoAccountRegisterIfNeededAndLogin(AccountId? id) async {
    final event = DemoAccountRegisterIfNeededAndLoginToAccount(id);
    _cmds.add(event);
    return await event.waitCompletion();
  }
}

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
