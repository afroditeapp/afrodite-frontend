import 'dart:async';

import 'package:app/data/login_repository.dart';
import 'package:app/localizations.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:app/api/api_provider.dart';
import 'package:app/api/api_wrapper.dart';
import 'package:app/api/server_connection.dart';
import 'package:app/data/utils.dart';
import 'package:app/database/account_background_database_manager.dart';
import 'package:app/database/account_database_manager.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:utils/utils.dart';
import 'package:app/utils/app_error.dart';
import 'package:app/utils/result.dart';
import 'package:rxdart/rxdart.dart';

final _log = Logger("ServerConnectionManager");

/// Manages reconnection timing with countdown updates
class ReconnectionTimer {
  Timer? _timer;
  final void Function(int remainingSeconds) onTick;
  final void Function() onComplete;
  int _remainingSeconds = 0;

  ReconnectionTimer({required this.onTick, required this.onComplete});

  void start(int durationSeconds) {
    cancel();
    _remainingSeconds = durationSeconds;
    onTick(_remainingSeconds);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _remainingSeconds--;
      if (_remainingSeconds > 0) {
        onTick(_remainingSeconds);
      } else {
        cancel();
        onComplete();
      }
    });
  }

  void cancel() {
    _timer?.cancel();
    _timer = null;
  }

  bool get isActive => _timer?.isActive ?? false;
}

sealed class ServerConnectionManagerState {}

/// No valid refresh token available. Automatic logout should happen.
class WaitingRefreshToken extends ServerConnectionManagerState {}

/// Reconnecting will happen in few seconds.
class ReconnectWaitTime extends ServerConnectionManagerState {
  final int remainingSeconds;
  ReconnectWaitTime(this.remainingSeconds);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReconnectWaitTime &&
          runtimeType == other.runtimeType &&
          remainingSeconds == other.remainingSeconds;

  @override
  int get hashCode => remainingSeconds.hashCode;
}

/// No connection to server.
class NoServerConnection extends ServerConnectionManagerState {}

/// Making connection to server.
class ConnectingToServer extends ServerConnectionManagerState {}

/// Connection to server established.
class ConnectedToServer extends ServerConnectionManagerState {}

/// Server does not support this client version.
class UnsupportedClientVersion extends ServerConnectionManagerState {}

sealed class ServerWsEvent {}

class EventToClientContainer implements ServerWsEvent {
  final EventToClient event;
  EventToClientContainer(this.event);
}

sealed class ServerConnectionManagerCmd<T> {
  final BehaviorSubject<T?> completed = BehaviorSubject.seeded(null);

  /// Can be called only once
  Future<T> waitCompletionAndDispose() async {
    final value = await completed.whereType<T>().first;
    await completed.close();
    return value;
  }
}

class ConnectIfNotConnected extends ServerConnectionManagerCmd<()> {}

class Restart extends ServerConnectionManagerCmd<()> {}

/// Close specific or current connection
class CloseConnection extends ServerConnectionManagerCmd<()> {
  final ServerConnection? serverConnection;
  CloseConnection(this.serverConnection);
}

class SaveConnection extends ServerConnectionManagerCmd<()> {
  final ServerConnection serverConnection;
  SaveConnection(this.serverConnection);
}

class ServerConnectionManager extends ApiManager
    implements LifecycleMethods, ServerConnectionInterface {
  final AccountDatabaseManager accountDb;
  final AccountBackgroundDatabaseManager accountBackgroundDb;
  final AccountId currentUser;
  final ApiProvider _apiProvider;
  ServerConnection? _serverConnection;

  ServerConnectionManager(
    String serverAddress,
    this.accountDb,
    this.accountBackgroundDb,
    this.currentUser,
  ) : _apiProvider = ApiProvider(serverAddress);

  final PublishSubject<ServerConnectionManagerCmd<Object>> _cmds = PublishSubject();
  StreamSubscription<void>? _cmdsSubscription;

  final BehaviorSubject<ServerConnectionManagerState> _state = BehaviorSubject.seeded(
    ConnectingToServer(),
  );
  Stream<ServerConnectionManagerState> get state => _state.distinct();
  ServerConnectionManagerState get currentState => _state.value;
  @override
  bool get isConnected => currentState is ConnectedToServer;

  final PublishSubject<ServerWsEvent> _serverEvents = PublishSubject();
  Stream<ServerWsEvent> get serverEvents => _serverEvents;

  StreamSubscription<void>? _serverConnectionEventsSubscription;

  @override
  ApiProvider get _account => _apiProvider;

  @override
  ServerConnectionInterface get _connection => this;

  late final ReconnectionTimer _reconnectionTimer;

  bool _disableSnackBars = false;
  bool _restartOngoing = false;

  @override
  Future<void> init() async {
    await _apiProvider.init();
    _reconnectionTimer = ReconnectionTimer(
      onTick: (remainingSeconds) {
        _state.add(ReconnectWaitTime(remainingSeconds));
      },
      onComplete: () {
        _cmds.add(ConnectIfNotConnected());
      },
    );
    _cmdsSubscription = _listenServerConnectionCmds();
  }

  @override
  Future<void> dispose() async {
    await _cmdsSubscription?.cancel();
    await _serverConnection?.close();
    _serverConnection = null;
    await _serverConnectionEventsSubscription?.cancel();
    _reconnectionTimer.cancel();
    await _cmds.close();
    await _serverEvents.close();
    await _state.close();
  }

  StreamSubscription<void> _listenServerConnectionCmds() {
    return _cmds
        .asyncMap((cmd) async {
          _log.info("cmd: ${cmd.runtimeType}");
          try {
            switch (cmd) {
              case ConnectIfNotConnected():
                if (_serverConnection == null) {
                  await _connect();
                }
              case Restart():
                await _serverConnection?.close();
                _serverConnection = null;
                await _connect();
              case CloseConnection():
                final currentConnection = _serverConnection;
                if (currentConnection != null &&
                    (cmd.serverConnection == null || currentConnection == cmd.serverConnection)) {
                  await currentConnection.close();
                  _serverConnection = null;
                }
              case SaveConnection():
                _serverConnection = cmd.serverConnection;
            }
          } catch (_) {
            // Ignore exceptions
          }
          cmd.completed.add(());
        })
        .listen(null);
  }

  Future<Result<(), ()>> _connect() async {
    _reconnectionTimer.cancel();
    _state.add(ConnectingToServer());

    final accessToken = await accountDb
        .accountStreamSingle((db) => db.loginSession.watchAccessToken())
        .ok();
    final refreshToken = await accountDb
        .accountStreamSingle((db) => db.loginSession.watchRefreshToken())
        .ok();

    if (accessToken == null || refreshToken == null) {
      _state.add(WaitingRefreshToken());
      return const Err(());
    }

    final connectionResult = await ServerConnection.connect(
      serverAddress,
      accessToken,
      refreshToken,
      accountDb,
      accountBackgroundDb,
      _serverEvents,
    );
    final ServerConnection serverConnection;
    switch (connectionResult) {
      case Ok():
        serverConnection = connectionResult.v;
      case Err():
        await _handleConnectionError(connectionResult.e, null);
        return Err(());
    }

    _cmds.add(SaveConnection(serverConnection));
    await _serverConnectionEventsSubscription?.cancel();
    _serverConnectionEventsSubscription = serverConnection.state
        .distinct()
        .asyncMap((event) async {
          _log.info(event);
          switch (event) {
            case Connecting():
              _state.add(ConnectingToServer());
            case Closed e:
              await _handleConnectionError(e.error, serverConnection);
            case Ready(:final token):
              if (_reconnectionTimer.isActive) {
                if (!_disableSnackBars) {
                  showSnackBar(R.strings.snackbar_connected);
                }
                _reconnectionTimer.cancel();
              }
              _apiProvider.setAccessToken(token);
              _state.add(ConnectedToServer());
          }
        })
        .listen(null);

    return const Ok(());
  }

  Future<void> _handleConnectionError(
    ServerConnectionError? error,
    ServerConnection? currentConnection,
  ) async {
    if (currentConnection != null) {
      _cmds.add(CloseConnection(currentConnection));
    }
    switch (error) {
      case ServerConnectionError.connectionFailure:
        if (!_disableSnackBars) {
          showSnackBar(R.strings.snackbar_reconnecting_in_5_seconds);
        }
        // TODO(prod): check that internet connectivity exists?
        _reconnectionTimer.start(5);
      case ServerConnectionError.invalidToken:
        _state.add(WaitingRefreshToken());
      case ServerConnectionError.unsupportedClientVersion:
        _state.add(UnsupportedClientVersion());
      case null:
        _state.add(NoServerConnection());
    }
  }

  @override
  Future<void> restartIfRestartNotOngoing() async {
    if (_restartOngoing) {
      return;
    }
    _restartOngoing = true;
    final event = Restart();
    _cmds.add(event);
    await event.waitCompletionAndDispose();
    _restartOngoing = false;
  }

  Future<void> close() async {
    final event = CloseConnection(null);
    _cmds.add(event);
    await event.waitCompletionAndDispose();
  }

  void disableSnackBars() {
    _disableSnackBars = true;
  }

  /// Returns true if connected, false if not connected within the timeout.
  Future<bool> tryWaitUntilConnected({required int waitTimeoutSeconds}) async {
    return await Future.any([
      Future.delayed(Duration(seconds: waitTimeoutSeconds), () => false),
      state
          .map((v) => v is ConnectedToServer)
          .firstWhere((v) => v, orElse: () => false)
          .then((v) => v),
    ]);
  }

  /// Wait until current login session connects to server.
  ///
  /// If current login session changes to different account then error is returned.
  ///
  /// Error is also returned after calling [dispose].
  Future<Result<(), ()>> waitUntilCurrentSessionConnects() async {
    final connected = await state
        .map((v) => v is ConnectedToServer)
        .firstWhere((v) => v, orElse: () => false);

    if (!connected) {
      return Err(());
    }

    final accountAfterConnection = LoginRepository.getInstance().repositoriesOrNull?.accountId;
    if (currentUser != accountAfterConnection) {
      _log.error("Account changed when waiting connected state");
      return const Err(());
    }

    return const Ok(());
  }
}

class ApiManagerNoConnection extends ApiManager {
  final ApiProvider _apiProvider;

  ApiManagerNoConnection._(this._apiProvider);

  @override
  ApiProvider get _account => _apiProvider;

  @override
  ServerConnectionInterface get _connection => NoConnection();

  static Future<ApiManagerNoConnection> create(String serverAddress) async {
    final api = ApiProvider(serverAddress);
    await api.init();
    return ApiManagerNoConnection._(api);
  }
}

abstract class ApiManager {
  String get serverAddress => _account.serverAddress;

  ApiProvider get _account;
  ServerConnectionInterface get _connection;

  ApiProvider _mediaApiProvider() {
    return _account;
  }

  ApiProvider _profileApiProvider() {
    return _account;
  }

  ApiProvider _chatApiProvider() {
    return _account;
  }

  ApiWrapper<CommonApi> commonWrapper() {
    return ApiWrapper(_account.common, _connection);
  }

  ApiWrapper<AccountApi> accountWrapper() {
    return ApiWrapper(_account.account, _connection);
  }

  ApiWrapper<AccountAdminApi> _accountAdminWrapper() {
    return ApiWrapper(_account.accountAdmin, _connection);
  }

  ApiWrapper<ProfileApi> profileWrapper() {
    return ApiWrapper(_profileApiProvider().profile, _connection);
  }

  ApiWrapper<ProfileAdminApi> _profileAdminWrapper() {
    return ApiWrapper(_profileApiProvider().profileAdmin, _connection);
  }

  ApiWrapper<ChatApi> _chatWrapper() {
    return ApiWrapper(_chatApiProvider().chat, _connection);
  }

  ApiWrapper<MediaApi> mediaWrapper() {
    return ApiWrapper(_mediaApiProvider().media, _connection);
  }

  ApiWrapper<MediaAdminApi> _mediaAdminWrapper() {
    return ApiWrapper(_mediaApiProvider().mediaAdmin, _connection);
  }

  Future<Result<T, ValueApiError>> account<T extends Object>(
    Future<T?> Function(AccountApi) action,
  ) async {
    return await accountWrapper().requestValue(action);
  }

  Future<Result<T, ValueApiError>> accountAdmin<T extends Object>(
    Future<T?> Function(AccountAdminApi) action,
  ) async {
    return await _accountAdminWrapper().requestValue(action);
  }

  Future<Result<T, ValueApiError>> common<T extends Object>(
    Future<T?> Function(CommonApi) action,
  ) async {
    return await ApiWrapper(_account.common, _connection).requestValue(action);
  }

  Future<Result<T, ValueApiError>> commonAdmin<T extends Object>(
    Future<T?> Function(CommonAdminApi) action,
  ) async {
    return await ApiWrapper(_account.commonAdmin, _connection).requestValue(action);
  }

  Future<Result<T, ValueApiError>> media<T extends Object>(
    Future<T?> Function(MediaApi) action,
  ) async {
    return await mediaWrapper().requestValue(action);
  }

  Future<Result<T, ValueApiError>> mediaAdmin<T extends Object>(
    Future<T?> Function(MediaAdminApi) action,
  ) async {
    return await _mediaAdminWrapper().requestValue(action);
  }

  Future<Result<T, ValueApiError>> profile<T extends Object>(
    Future<T?> Function(ProfileApi) action,
  ) async {
    return await profileWrapper().requestValue(action);
  }

  Future<Result<T, ValueApiError>> profileAdmin<T extends Object>(
    Future<T?> Function(ProfileAdminApi) action,
  ) async {
    return await _profileAdminWrapper().requestValue(action);
  }

  Future<Result<T, ValueApiError>> chat<T extends Object>(
    Future<T?> Function(ChatApi) action,
  ) async {
    return await _chatWrapper().requestValue(action);
  }

  // Actions

  Future<Result<(), ActionApiError>> accountAction(Future<void> Function(AccountApi) action) async {
    return await accountWrapper().requestAction(action);
  }

  Future<Result<(), ActionApiError>> accountAdminAction(
    Future<void> Function(AccountAdminApi) action,
  ) async {
    return await _accountAdminWrapper().requestAction(action);
  }

  Future<Result<(), ActionApiError>> commonAction(Future<void> Function(CommonApi) action) async {
    return await ApiWrapper(_account.common, _connection).requestAction(action);
  }

  Future<Result<(), ActionApiError>> commonAdminAction(
    Future<void> Function(CommonAdminApi) action,
  ) async {
    return await ApiWrapper(_account.commonAdmin, _connection).requestAction(action);
  }

  Future<Result<(), ActionApiError>> mediaAction(Future<void> Function(MediaApi) action) async {
    return await mediaWrapper().requestAction(action);
  }

  Future<Result<(), ActionApiError>> mediaAdminAction(
    Future<void> Function(MediaAdminApi) action,
  ) async {
    return await _mediaAdminWrapper().requestAction(action);
  }

  Future<Result<(), ActionApiError>> profileAction(Future<void> Function(ProfileApi) action) async {
    return await profileWrapper().requestAction(action);
  }

  Future<Result<(), ActionApiError>> profileAdminAction(
    Future<void> Function(ProfileAdminApi) action,
  ) async {
    return await _profileAdminWrapper().requestAction(action);
  }

  Future<Result<(), ActionApiError>> chatAction(Future<void> Function(ChatApi) action) async {
    return await _chatWrapper().requestAction(action);
  }
}
