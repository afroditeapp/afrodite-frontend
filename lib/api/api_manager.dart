
import 'dart:async';

import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/api/api_provider.dart';
import 'package:pihka_frontend/api/api_wrapper.dart';
import 'package:pihka_frontend/api/server_connection.dart';
import 'package:pihka_frontend/config.dart';
import 'package:pihka_frontend/data/notification_manager.dart';
import 'package:pihka_frontend/data/utils.dart';
import 'package:pihka_frontend/database/account_database_manager.dart';
import 'package:pihka_frontend/database/background_database_manager.dart';
import 'package:pihka_frontend/ui_utils/snack_bar.dart';
import 'package:utils/utils.dart';
import 'package:pihka_frontend/utils/app_error.dart';
import 'package:pihka_frontend/utils/result.dart';
import 'package:rxdart/rxdart.dart';

final log = Logger("ApiManager");

enum Server {
  account,
  media,
  profile,
}

// TODO(prod): Localize connection snackbar texts

enum ApiManagerState {
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
  final ApiManager _account = ApiManager.withDefaultAddress(rememberToInitializeConnectionLateFinalField: true);
  final AccountDatabaseManager accountDb;
  ServerConnection accountConnection;

  ServerConnectionManager(this.accountDb) :
    accountConnection =  ServerConnection(
      ServerSlot.account,
      "",
      accountDb,
    );

  final BehaviorSubject<ApiManagerState> _state =
    BehaviorSubject.seeded(ApiManagerState.connecting);

  final PublishSubject<ServerWsEvent> _serverEvents =
    PublishSubject();
  StreamSubscription<ServerWsEvent>? _serverEventsSubscription;

  StreamSubscription<void>? _serverConnectionEventsSubscription;

  ApiManagerState get currentState => _state.value;
  Stream<ServerWsEvent> get serverEvents => _serverEvents;
  ApiManager get api => _account;

  @override
  Stream<ApiManagerState> get state => _state.distinct();

  bool _reconnectInProgress = false;

  @override
  Future<void> init() async {
    _account.connection = this;
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
    return accountConnection
      .state
      .distinct()
      .asyncMap((event) async {
        log.info(event);
        switch (event) {
          // No connection states.
          case ReadyToConnect():
            _state.add(ApiManagerState.noConnection);
          case Error e: {
            switch (e.error) {
              case ServerConnectionError.connectionFailure: {
                _state.add(ApiManagerState.reconnectWaitTime);
                _reconnectInProgress = true;
                showSnackBar("Connection error - reconnecting in 5 seconds");
                // TODO: check that internet connectivity exists?
                unawaited(Future.delayed(const Duration(seconds: 5), () async {
                  final currentState = await accountConnection.state.first;

                  if (currentState is Error && currentState.error == ServerConnectionError.connectionFailure) {
                    await restart();
                  }
                }));
              }
              case ServerConnectionError.invalidToken: {
                _state.add(ApiManagerState.waitingRefreshToken);
              }
              case ServerConnectionError.unsupportedClientVersion: {
                _state.add(ApiManagerState.unsupportedClientVersion);
              }
            }
          }
          // Ongoing connection states
          case Connecting():
            _state.add(ApiManagerState.connecting);
          case Ready(): {
            if (_reconnectInProgress) {
              showSnackBar("Connected");
              _reconnectInProgress = false;
            }
            await _account.setupTokensFromDb(accountDb);
            _state.add(ApiManagerState.connected);
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
    _state.add(ApiManagerState.connecting);

    final accountRefreshToken =
      await accountDb.accountStreamSingle((db) => db.daoTokens.watchRefreshTokenAccount()).ok();
    final accountAccessToken =
      await accountDb.accountStreamSingle((db) => db.daoTokens.watchAccessTokenAccount()).ok();

    if (accountRefreshToken == null || accountAccessToken == null) {
      _state.add(ApiManagerState.waitingRefreshToken);
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
    _state.add(ApiManagerState.noConnection);
  }

  Future<void> closeAndLogout() async {
    _reconnectInProgress = false;
    await accountConnection.close(logoutClose: true);
    _state.add(ApiManagerState.waitingRefreshToken);
  }

  Future<void> closeAndRefreshServerAddressAndLogout() async {
    _reconnectInProgress = false;
    await accountConnection.close(logoutClose: true);
    await _loadAddressesFromConfig();
    _state.add(ApiManagerState.waitingRefreshToken);
  }

  /// Returns true if connected, false if not connected within the timeout.
  Future<bool> tryWaitUntilConnected({required int waitTimeoutSeconds}) async {
    return await Future.any([
      Future.delayed(Duration(seconds: waitTimeoutSeconds), () => false),
      state
        .firstWhere((element) => element == ApiManagerState.connected)
        .then((value) => true),
    ]);
  }

  /// Wait untill current login session connects to server.
  ///
  /// If notification session ID changes then error is returned.
  Future<Result<void, void>> waitUntilCurrentSessionConnects() async {
    final initialNotificationSessionId = await NotificationManager.getInstance().getSessionId();

    await state
        .firstWhere((element) => element == ApiManagerState.connected);

    final notificationSessionIdChanged = await Future.any([
      NotificationManager.getInstance().getSessionIdStream()
        .firstWhere((element) => element.id != initialNotificationSessionId.id)
        .then((value) => true),
      state
        .firstWhere((element) => element == ApiManagerState.connected)
        .then((value) => false),
    ]);

    if (notificationSessionIdChanged) {
      log.error("Notification session ID changed when waiting connected state");
      return const Err(null);
    }

    final currentNotificationSessionId = await NotificationManager.getInstance().getSessionId();

    if (initialNotificationSessionId.id == currentNotificationSessionId.id) {
      return const Ok(null);
    } else {
      log.error("Notification session ID changed");
      return const Err(null);
    }
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
  final ApiProvider _account = ApiProvider(defaultServerUrlAccount());

  ApiManager.withDefaultAddress({required rememberToInitializeConnectionLateFinalField});
  ApiManager.withDefaultAddressAndNoConnection() : connection = NoConnection();

  late final ServerConnectionInterface connection;

  @override
  Future<void> init() async {
    await _account.init();
  }

  @override
  Future<void> dispose() async {}

  Future<String> updateAddressFromConfigAndReturnIt() async {
    final backgroundDb = BackgroundDatabaseManager.getInstance();

    // TODO(prod): hardcode address for production release?
    final accountAddress = await backgroundDb.commonStreamSingleOrDefault(
      (db) => db.watchServerUrlAccount(),
      defaultServerUrlAccount(),
    );
    _account.updateServerAddress(accountAddress);

    return accountAddress;
  }

  Future<void> setupTokensFromDb(AccountDatabaseManager accountDb) async {
    final accessTokenAccount = await accountDb.accountStreamSingle((db) => db.daoTokens.watchAccessTokenAccount()).ok();
    if (accessTokenAccount != null) {
      _account.setAccessToken(AccessToken(accessToken: accessTokenAccount));
    }
  }

  bool inMicroserviceMode() {
    return mediaInMicroserviceMode() || profileInMicroserviceMode();
  }

  bool mediaInMicroserviceMode() {
    return false;
  }

  bool profileInMicroserviceMode() {
    return false;
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

  ApiWrapper<AccountApi> _accountWrapper() {
    return ApiWrapper(_account.account, connection);
  }

  /// This is only useful if server has debugging enabled.
  ApiWrapper<AccountInternalApi> _accountInternalWrapper() {
    return ApiWrapper(_account.accountInternal, connection);
  }

  ApiWrapper<ProfileApi> profileWrapper() {
    return ApiWrapper(_profileApiProvider().profile, connection);
  }

  ApiWrapper<ChatApi> chatWrapper() {
    return ApiWrapper(_chatApiProvider().chat, connection);
  }

  ApiWrapper<MediaApi> mediaWrapper() {
    return ApiWrapper(_mediaApiProvider().media, connection);
  }

  ApiWrapper<MediaAdminApi> _mediaAdminWrapper() {
    return ApiWrapper(_mediaApiProvider().mediaAdmin, connection);
  }

  // TODO(microservice): Chat server missing from common, commonAdmin
  // commmonAction, commonAdminAction

  Future<Result<R, ValueApiError>> common<R extends Object>(Server server, Future<R?> Function(CommonApi) action) async {
    switch (server) {
      case Server.account:
        return accountCommon(action);
      case Server.media:
        return mediaCommon(action);
      case Server.profile:
        return profileCommon(action);
    }
  }

  Future<Result<R, ValueApiError>> commonAdmin<R extends Object>(Server server, Future<R?> Function(CommonAdminApi) action) async {
    switch (server) {
      case Server.account:
        return accountCommonAdmin(action);
      case Server.media:
        return mediaCommonAdmin(action);
      case Server.profile:
        return profileCommonAdmin(action);
    }
  }


  Future<Result<R, ValueApiError>> account<R extends Object>(Future<R?> Function(AccountApi) action) async {
    return await _accountWrapper().requestValue(action);
  }

  Future<Result<R, ValueApiError>> accountInternal<R extends Object>(Future<R?> Function(AccountInternalApi) action) async {
    return await _accountInternalWrapper().requestValue(action);
  }

  Future<Result<R, ValueApiError>> accountCommon<R extends Object>(Future<R?> Function(CommonApi) action) async {
    return await ApiWrapper(_account.common, connection).requestValue(action);
  }

  Future<Result<R, ValueApiError>> accountCommonAdmin<R extends Object>(Future<R?> Function(CommonAdminApi) action) async {
    return await ApiWrapper(_account.commonAdmin, connection).requestValue(action);
  }

  Future<Result<R, ValueApiError>> media<R extends Object>(Future<R?> Function(MediaApi) action) async {
    return await mediaWrapper().requestValue(action);
  }

  Future<Result<R, ValueApiError>> mediaAdmin<R extends Object>(Future<R?> Function(MediaAdminApi) action) async {
    return await _mediaAdminWrapper().requestValue(action);
  }

  Future<Result<R, ValueApiError>> mediaCommon<R extends Object>(Future<R?> Function(CommonApi) action) async {
    return await ApiWrapper(_mediaApiProvider().common, connection).requestValue(action);
  }

  Future<Result<R, ValueApiError>> mediaCommonAdmin<R extends Object>(Future<R?> Function(CommonAdminApi) action) async {
    return await ApiWrapper(_mediaApiProvider().commonAdmin, connection).requestValue(action);
  }

  Future<Result<R, ValueApiError>> profile<R extends Object>(Future<R?> Function(ProfileApi) action) async {
    return await profileWrapper().requestValue(action);
  }

  Future<Result<R, ValueApiError>> chat<R extends Object>(Future<R?> Function(ChatApi) action) async {
    return await chatWrapper().requestValue(action);
  }

  Future<Result<R, ValueApiError>> profileCommon<R extends Object>(Future<R?> Function(CommonApi) action) async {
    return await ApiWrapper(_profileApiProvider().common, connection).requestValue(action);
  }

  Future<Result<R, ValueApiError>> profileCommonAdmin<R extends Object>(Future<R?> Function(CommonAdminApi) action) async {
    return await ApiWrapper(_mediaApiProvider().commonAdmin, connection).requestValue(action);
  }

  // Actions

  Future<Result<void, ActionApiError>> commonAction(Server server, Future<void> Function(CommonApi) action) async {
    switch (server) {
      case Server.account:
        return accountCommonAction(action);
      case Server.media:
        return mediaCommonAction(action);
      case Server.profile:
        return profileCommonAction(action);
    }
  }

  Future<Result<void, ActionApiError>> commonAdminAction(Server server, Future<void> Function(CommonAdminApi) action) async {
    switch (server) {
      case Server.account:
        return accountCommonAdminAction(action);
      case Server.media:
        return mediaCommonAdminAction(action);
      case Server.profile:
        return profileCommonAdminAction(action);
    }
  }


  Future<Result<void, ActionApiError>> accountAction(Future<void> Function(AccountApi) action) async {
    return await _accountWrapper().requestAction(action);
  }

  Future<Result<void, ActionApiError>> accountInternalAction(Future<void> Function(AccountInternalApi) action) async {
    return await _accountInternalWrapper().requestAction(action);
  }

  Future<Result<void, ActionApiError>> accountCommonAction(Future<void> Function(CommonApi) action) async {
    return await ApiWrapper(_account.common, connection).requestAction(action);
  }

  Future<Result<void, ActionApiError>> accountCommonAdminAction(Future<void> Function(CommonAdminApi) action) async {
    return await ApiWrapper(_account.commonAdmin, connection).requestAction(action);
  }

  Future<Result<void, ActionApiError>> mediaAction(Future<void> Function(MediaApi) action) async {
    return await mediaWrapper().requestAction(action);
  }

  Future<Result<void, ActionApiError>> mediaAdminAction(Future<void> Function(MediaAdminApi) action) async {
    return await _mediaAdminWrapper().requestAction(action);
  }

  Future<Result<void, ActionApiError>> mediaCommonAction(Future<void> Function(CommonApi) action) async {
    return await ApiWrapper(_mediaApiProvider().common, connection).requestAction(action);
  }

  Future<Result<void, ActionApiError>> mediaCommonAdminAction(Future<void> Function(CommonAdminApi) action) async {
    return await ApiWrapper(_mediaApiProvider().commonAdmin, connection).requestAction(action);
  }

  Future<Result<void, ActionApiError>> profileAction(Future<void> Function(ProfileApi) action) async {
    return await profileWrapper().requestAction(action);
  }

  Future<Result<void, ActionApiError>> chatAction(Future<void> Function(ChatApi) action) async {
    return await chatWrapper().requestAction(action);
  }

  Future<Result<void, ActionApiError>> profileCommonAction(Future<void> Function(CommonApi) action) async {
    return await ApiWrapper(_profileApiProvider().common, connection).requestAction(action);
  }

  Future<Result<void, ActionApiError>> profileCommonAdminAction(Future<void> Function(CommonAdminApi) action) async {
    return await ApiWrapper(_mediaApiProvider().commonAdmin, connection).requestAction(action);
  }
}
