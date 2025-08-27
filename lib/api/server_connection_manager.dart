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

final log = Logger("ApiManager");

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

class ServerConnectionManager implements LifecycleMethods, ServerConnectionInterface {
  final String address;
  late final ApiManager _account;
  final AccountDatabaseManager accountDb;
  final AccountBackgroundDatabaseManager accountBackgroundDb;
  final AccountId currentUser;
  final ServerConnection _serverConnection;

  ServerConnectionManager(this.address, this.accountDb, this.accountBackgroundDb, this.currentUser)
    : _serverConnection = ServerConnection(address, accountDb, accountBackgroundDb);

  final BehaviorSubject<ServerConnectionState> _state = BehaviorSubject.seeded(
    ServerConnectionState.connecting,
  );

  StreamSubscription<void>? _serverConnectionEventsSubscription;

  ServerConnectionState get currentState => _state.value;
  Stream<ServerWsEvent> get serverEvents => _serverConnection.serverEvents;
  ApiManager get api => _account;

  @override
  Stream<ServerConnectionState> get state => _state.distinct();

  bool _reconnectInProgress = false;

  @override
  Future<void> init() async {
    _account = await ApiManager.create(address, this);
    _serverConnectionEventsSubscription = _listenServerConnectionEvents(accountDb);
  }

  @override
  Future<void> dispose() async {
    await _serverConnectionEventsSubscription?.cancel();
    await _serverConnection.dispose();
  }

  StreamSubscription<void> _listenServerConnectionEvents(AccountDatabaseManager accountDb) {
    return _serverConnection.state
        .distinct()
        .asyncMap((event) async {
          log.info(event);
          switch (event) {
            // No connection states.
            case ReadyToConnect():
              _state.add(ServerConnectionState.noConnection);
            case Error e:
              {
                switch (e.error) {
                  case ServerConnectionError.connectionFailure:
                    {
                      _state.add(ServerConnectionState.reconnectWaitTime);
                      _reconnectInProgress = true;
                      showSnackBar(R.strings.snackbar_reconnecting_in_5_seconds);
                      // TODO(prod): check that internet connectivity exists?
                      unawaited(
                        Future.delayed(const Duration(seconds: 5), () async {
                          final currentState = await _serverConnection.state.first;

                          if (currentState is Error &&
                              currentState.error == ServerConnectionError.connectionFailure) {
                            await restart();
                          }
                        }),
                      );
                    }
                  case ServerConnectionError.invalidToken:
                    {
                      _state.add(ServerConnectionState.waitingRefreshToken);
                    }
                  case ServerConnectionError.unsupportedClientVersion:
                    {
                      _state.add(ServerConnectionState.unsupportedClientVersion);
                    }
                }
              }
            // Ongoing connection states
            case Connecting():
              _state.add(ServerConnectionState.connecting);
            case Ready(:final token):
              {
                if (_reconnectInProgress) {
                  showSnackBar(R.strings.snackbar_connected);
                  _reconnectInProgress = false;
                }
                await _account.setupAccessToken(token);
                _state.add(ServerConnectionState.connected);
              }
          }
        })
        .listen((_) {});
  }

  Future<void> _connect() async {
    _state.add(ServerConnectionState.connecting);

    final accountRefreshToken = await accountDb
        .accountStreamSingle((db) => db.loginSession.watchRefreshToken())
        .ok();
    final accountAccessToken = await accountDb
        .accountStreamSingle((db) => db.loginSession.watchAccessToken())
        .ok();

    if (accountRefreshToken == null || accountAccessToken == null) {
      _state.add(ServerConnectionState.waitingRefreshToken);
      return;
    }

    await _serverConnection.start();
  }

  @override
  Future<void> restart() async {
    await _serverConnection.close();
    await _connect();
  }

  Future<void> close() async {
    _reconnectInProgress = false;
    await _serverConnection.close();
    _state.add(ServerConnectionState.noConnection);
  }

  Future<void> closeAndLogout() async {
    _reconnectInProgress = false;
    await _serverConnection.close(logoutClose: true);
    _state.add(ServerConnectionState.waitingRefreshToken);
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
      log.error("Account changed when waiting connected state");
      return const Err(());
    }

    return const Ok(());
  }
}

class ApiManager {
  final ApiProvider _account;
  final ServerConnectionInterface _connection;

  String get serverAddress => _account.serverAddress;

  ApiManager._(String address, ServerConnectionInterface connection)
    : _account = ApiProvider(address),
      _connection = connection;

  static Future<ApiManager> createNoConnection(String address) async {
    final api = ApiManager._(address, NoConnection());
    await api._account.init();
    return api;
  }

  static Future<ApiManager> create(String address, ServerConnectionInterface connection) async {
    final api = ApiManager._(address, NoConnection());
    await api._account.init();
    return api;
  }

  Future<void> setupAccessToken(AccessToken token) async {
    _account.setAccessToken(token);
  }

  /// Provider for media and media admin API
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
