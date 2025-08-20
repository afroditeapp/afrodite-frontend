import 'dart:async';

import 'package:app/localizations.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:app/api/api_provider.dart';
import 'package:app/api/api_wrapper.dart';
import 'package:app/api/server_connection.dart';
import 'package:app/config.dart';
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
  final ApiManager _account = ApiManager.withDefaultAddress();
  final AccountDatabaseManager accountDb;
  final AccountBackgroundDatabaseManager accountBackgroundDb;
  final AccountId currentUser;
  ServerConnection accountConnection;

  ServerConnectionManager(this.accountDb, this.accountBackgroundDb, this.currentUser)
    : accountConnection = ServerConnection("", accountDb, accountBackgroundDb);

  final BehaviorSubject<ServerConnectionState> _state = BehaviorSubject.seeded(
    ServerConnectionState.connecting,
  );

  final PublishSubject<ServerWsEvent> _serverEvents = PublishSubject();
  StreamSubscription<ServerWsEvent>? _serverEventsSubscription;

  StreamSubscription<void>? _serverConnectionEventsSubscription;

  ServerConnectionState get currentState => _state.value;
  Stream<ServerWsEvent> get serverEvents => _serverEvents;
  ApiManager get api => _account;

  @override
  Stream<ServerConnectionState> get state => _state.distinct();

  bool _reconnectInProgress = false;

  @override
  Future<void> init() async {
    _account.initConnection(this);
    await _account.init();

    _serverEventsSubscription = accountConnection.serverEvents.listen((event) {
      _serverEvents.add(event);
    });
    _serverConnectionEventsSubscription = _listenAccountConnectionEvents(accountDb);

    await _loadAddressesFromConfig();
  }

  @override
  Future<void> dispose() async {
    await _serverEventsSubscription?.cancel();
    await _serverConnectionEventsSubscription?.cancel();
    await accountConnection.dispose();
  }

  StreamSubscription<void> _listenAccountConnectionEvents(AccountDatabaseManager accountDb) {
    return accountConnection.state
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
                          final currentState = await accountConnection.state.first;

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

  Future<void> _loadAddressesFromConfig() async {
    final accountAddress = await _account.updateAddressFromConfigAndReturnIt();
    accountConnection.setAddress(addWebSocketRoutePathToAddress(accountAddress));
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

    await accountConnection.start();
  }

  @override
  Future<void> restart() async {
    await accountConnection.close();
    await _loadAddressesFromConfig();
    await _connect();
  }

  Future<void> close() async {
    _reconnectInProgress = false;
    await accountConnection.close();
    _state.add(ServerConnectionState.noConnection);
  }

  Future<void> closeAndLogout() async {
    _reconnectInProgress = false;
    await accountConnection.close(logoutClose: true);
    _state.add(ServerConnectionState.waitingRefreshToken);
  }

  Future<void> closeAndRefreshServerAddressAndLogout() async {
    _reconnectInProgress = false;
    await accountConnection.close(logoutClose: true);
    await _loadAddressesFromConfig();
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

String addWebSocketRoutePathToAddress(String baseUrl) {
  final base = Uri.parse(baseUrl);

  final newAddress = Uri(
    scheme: base.scheme,
    host: base.host,
    port: base.port,
    path: "/common_api/connect",
  ).toString();

  return newAddress;
}

class ApiManager implements LifecycleMethods {
  final ApiProvider _account = ApiProvider(defaultServerUrl());

  /// If object is created with this constructor, call [initConnection] before
  /// calling [init].
  ApiManager.withDefaultAddress();
  ApiManager.withDefaultAddressAndNoConnection() : _connection = NoConnection();

  late final ServerConnectionInterface _connection;
  ServerConnectionInterface get connection => _connection;

  // Can be called only once.
  void initConnection(ServerConnectionInterface newConnection) {
    _connection = newConnection;
  }

  @override
  Future<void> init() async {
    await _account.init();
    await updateAddressFromConfigAndReturnIt();
  }

  @override
  Future<void> dispose() async {}

  String currentServerAddress() => _account.serverAddress;

  Future<String> updateAddressFromConfigAndReturnIt() async {
    final backgroundDb = BackgroundDatabaseManager.getInstance();

    final accountAddress = await backgroundDb.commonStreamSingleOrDefault(
      (db) => db.app.watchServerUrl(),
      defaultServerUrl(),
    );
    _account.updateServerAddress(accountAddress);

    return accountAddress;
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
    return ApiWrapper(_account.common, connection);
  }

  ApiWrapper<AccountApi> accountWrapper() {
    return ApiWrapper(_account.account, connection);
  }

  ApiWrapper<AccountAdminApi> _accountAdminWrapper() {
    return ApiWrapper(_account.accountAdmin, connection);
  }

  ApiWrapper<ProfileApi> profileWrapper() {
    return ApiWrapper(_profileApiProvider().profile, connection);
  }

  ApiWrapper<ProfileAdminApi> _profileAdminWrapper() {
    return ApiWrapper(_profileApiProvider().profileAdmin, connection);
  }

  ApiWrapper<ChatApi> _chatWrapper() {
    return ApiWrapper(_chatApiProvider().chat, connection);
  }

  ApiWrapper<MediaApi> mediaWrapper() {
    return ApiWrapper(_mediaApiProvider().media, connection);
  }

  ApiWrapper<MediaAdminApi> _mediaAdminWrapper() {
    return ApiWrapper(_mediaApiProvider().mediaAdmin, connection);
  }

  Future<Result<R, ValueApiError>> account<R extends Object>(
    Future<R?> Function(AccountApi) action,
  ) async {
    return await accountWrapper().requestValue(action);
  }

  Future<Result<R, ValueApiError>> accountAdmin<R extends Object>(
    Future<R?> Function(AccountAdminApi) action,
  ) async {
    return await _accountAdminWrapper().requestValue(action);
  }

  Future<Result<R, ValueApiError>> common<R extends Object>(
    Future<R?> Function(CommonApi) action,
  ) async {
    return await ApiWrapper(_account.common, connection).requestValue(action);
  }

  Future<Result<R, ValueApiError>> commonAdmin<R extends Object>(
    Future<R?> Function(CommonAdminApi) action,
  ) async {
    return await ApiWrapper(_account.commonAdmin, connection).requestValue(action);
  }

  Future<Result<R, ValueApiError>> media<R extends Object>(
    Future<R?> Function(MediaApi) action,
  ) async {
    return await mediaWrapper().requestValue(action);
  }

  Future<Result<R, ValueApiError>> mediaAdmin<R extends Object>(
    Future<R?> Function(MediaAdminApi) action,
  ) async {
    return await _mediaAdminWrapper().requestValue(action);
  }

  Future<Result<R, ValueApiError>> profile<R extends Object>(
    Future<R?> Function(ProfileApi) action,
  ) async {
    return await profileWrapper().requestValue(action);
  }

  Future<Result<R, ValueApiError>> profileAdmin<R extends Object>(
    Future<R?> Function(ProfileAdminApi) action,
  ) async {
    return await _profileAdminWrapper().requestValue(action);
  }

  Future<Result<R, ValueApiError>> chat<R extends Object>(
    Future<R?> Function(ChatApi) action,
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
    return await ApiWrapper(_account.common, connection).requestAction(action);
  }

  Future<Result<(), ActionApiError>> commonAdminAction(
    Future<void> Function(CommonAdminApi) action,
  ) async {
    return await ApiWrapper(_account.commonAdmin, connection).requestAction(action);
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
