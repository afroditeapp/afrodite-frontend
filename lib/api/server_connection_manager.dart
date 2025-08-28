import 'dart:async';

import 'package:app/localizations.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:app/api/api_provider.dart';
import 'package:app/api/api_wrapper.dart';
import 'package:app/api/server_connection.dart';
import 'package:app/data/utils.dart';
import 'package:app/database/account_background_database_manager.dart';
import 'package:app/database/account_database_manager.dart';
import 'package:app/database/background_database_manager.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:utils/utils.dart';
import 'package:app/utils/app_error.dart';
import 'package:app/utils/result.dart';
import 'package:rxdart/rxdart.dart';

final _log = Logger("ServerConnectionManager");

enum ServerConnectionState {
  /// No valid refresh token available. UI should display login view.
  waitingRefreshToken,

  /// Reconnecting will happen in few seconds.
  reconnectWaitTime,

  /// No connection to server.
  noConnection,

  /// Making connections to servers.
  connecting,

  /// Connection to servers established.
  connected,

  /// Server does not support this client version.
  unsupportedClientVersion,
}

sealed class ServerWsEvent {}

class EventToClientContainer implements ServerWsEvent {
  final EventToClient event;
  EventToClientContainer(this.event);
}

sealed class ServerConnectionManagerCmd<T> {
  final BehaviorSubject<T?> completed = BehaviorSubject.seeded(null);

  Future<T> waitCompletion() async {
    return await completed.whereType<T>().first;
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

  final BehaviorSubject<ServerConnectionState> _state = BehaviorSubject.seeded(
    ServerConnectionState.connecting,
  );
  ServerConnectionState get currentState => _state.value;

  final PublishSubject<ServerWsEvent> _serverEvents = PublishSubject();
  Stream<ServerWsEvent> get serverEvents => _serverEvents;

  StreamSubscription<void>? _serverConnectionEventsSubscription;

  @override
  Stream<ServerConnectionState> get state => _state.distinct();

  @override
  ApiProvider get _account => _apiProvider;

  @override
  ServerConnectionInterface get _connection => this;

  bool _reconnectInProgress = false;
  Timer? _reconnectTimer;

  @override
  Future<void> init() async {
    await _apiProvider.init();
    _cmdsSubscription = _listenServerConnectionCmds();
  }

  @override
  Future<void> dispose() async {
    await _cmdsSubscription?.cancel();
    await _serverConnection?.close();
    _serverConnection = null;
    await _serverConnectionEventsSubscription?.cancel();
    _reconnectTimer?.cancel();
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
    _reconnectTimer?.cancel();
    _state.add(ServerConnectionState.connecting);

    final accessToken = await accountDb
        .accountStreamSingle((db) => db.loginSession.watchAccessToken())
        .ok();
    final refreshToken = await accountDb
        .accountStreamSingle((db) => db.loginSession.watchRefreshToken())
        .ok();

    if (accessToken == null || refreshToken == null) {
      _state.add(ServerConnectionState.waitingRefreshToken);
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
              _state.add(ServerConnectionState.connecting);
            case Closed e:
              await _handleConnectionError(e.error, serverConnection);
            case Ready(:final token):
              if (_reconnectInProgress) {
                showSnackBar(R.strings.snackbar_connected);
                _reconnectInProgress = false;
              }
              _apiProvider.setAccessToken(token);
              _state.add(ServerConnectionState.connected);
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
        _state.add(ServerConnectionState.reconnectWaitTime);
        showSnackBar(R.strings.snackbar_reconnecting_in_5_seconds);
        // TODO(prod): check that internet connectivity exists?
        _reconnectTimer = Timer(Duration(seconds: 5), () {
          _cmds.add(ConnectIfNotConnected());
        });
        _reconnectInProgress = true;
      case ServerConnectionError.invalidToken:
        _state.add(ServerConnectionState.waitingRefreshToken);
      case ServerConnectionError.unsupportedClientVersion:
        _state.add(ServerConnectionState.unsupportedClientVersion);
      case null:
        _state.add(ServerConnectionState.noConnection);
    }
  }

  @override
  Future<void> restart() async {
    final event = Restart();
    _cmds.add(event);
    await event.waitCompletion();
  }

  Future<void> close() async {
    final event = CloseConnection(null);
    _cmds.add(event);
    await event.waitCompletion();
  }

  /// Returns true if connected, false if not connected within the timeout.
  Future<bool> tryWaitUntilConnected({required int waitTimeoutSeconds}) async {
    return await Future.any([
      Future.delayed(Duration(seconds: waitTimeoutSeconds), () => false),
      state
          .firstWhere((element) => element == ServerConnectionState.connected)
          .then((value) => true),
    ]);
  }

  /// Wait until current login session connects to server.
  ///
  /// If current login session changes to different account then error is returned.
  Future<Result<(), ()>> waitUntilCurrentSessionConnects() async {
    await state.firstWhere((element) => element == ServerConnectionState.connected);

    final accountAfterConnection = await BackgroundDatabaseManager.getInstance().commonStreamSingle(
      (db) => db.loginSession.watchAccountId(),
    );

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
