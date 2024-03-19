
import 'dart:async';

import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/api/api_provider.dart';
import 'package:pihka_frontend/api/api_wrapper.dart';
import 'package:pihka_frontend/api/server_connection.dart';
import 'package:pihka_frontend/config.dart';
import 'package:pihka_frontend/storage/kv.dart';
import 'package:pihka_frontend/ui_utils/snack_bar.dart';
import 'package:pihka_frontend/utils.dart';
import 'package:pihka_frontend/utils/result.dart';
import 'package:rxdart/rxdart.dart';

final log = Logger("ApiManager");

enum Server {
  account,
  media,
  profile,
}

enum ApiManagerState {
  /// No valid refresh token available. UI should display login view.
  waitingRefreshToken,
  /// Reconnecting will happen in few seconds.
  reconnectWaitTime,
  /// Making connections to servers.
  connecting,
  /// Connection to servers established.
  connected,
  /// Server does not support this client version.
  unsupportedClientVersion,
}

// sealed class ApiManagerEvent {}

sealed class ServerWsEvent {}
class EventToClientContainer implements ServerWsEvent {
  final EventToClient event;
  EventToClientContainer(this.event);
}


class ApiManager extends AppSingleton {
  ApiManager._private();
  static final _instance = ApiManager._private();
  static bool _initialized = false;
  factory ApiManager.getInstance() {
    return _instance;
  }

  final ApiProvider _account =
    ApiProvider(KvStringWithDefault.accountServerAddress.getDefault());
  final ApiProvider _media =
    ApiProvider(KvStringWithDefault.mediaServerAddress.getDefault());
  final ApiProvider _profile =
    ApiProvider(KvStringWithDefault.profileServerAddress.getDefault());
  final ApiProvider _chat =
    ApiProvider(KvStringWithDefault.chatServerAddress.getDefault());

  final BehaviorSubject<ApiManagerState> _state =
    BehaviorSubject.seeded(ApiManagerState.connecting);
  // final PublishSubject<ApiManagerEvent> _events =
  //   PublishSubject();
  final PublishSubject<ServerWsEvent> _serverEvents =
    PublishSubject();

  ServerConnection accountConnection =
    ServerConnection(
      ServerSlot.account,
      "",
    );
  ServerConnection mediaConnection =
   ServerConnection(
      ServerSlot.media,
      "",
    );
  ServerConnection profileConnection =
    ServerConnection(
      ServerSlot.profile,
      "",
    );
  ServerConnection chatConnection =
    ServerConnection(
      ServerSlot.profile,
      "",
    );

  ApiManagerState get currentState => _state.value;
  Stream<ApiManagerState> get state => _state.distinct();
  Stream<ServerWsEvent> get serverEvents => _serverEvents;

  bool _reconnectInProgress = false;

  @override
  Future<void> init() async {
    if (_initialized) {
      throw Exception("ApiManager already initialized");
    }
    _initialized = true;

    await _account.init();
    await _profile.init();
    await _media.init();
    await _chat.init();

    _connectEvents();
    await _loadAddressesFromConfig();
    await _connect();
  }

  void _connectEvents() {
    // _events
    //   .stream
    //   .asyncMap((event) {
    //     switch (event) {
    //       case _: return;
    //     }
    //   })
    //   .listen((event) { });

      accountConnection.serverEvents.listen((event) {
        _serverEvents.add(event);
      });
      profileConnection.serverEvents.listen((event) {
        _serverEvents.add(event);
      });
      mediaConnection.serverEvents.listen((event) {
        _serverEvents.add(event);
      });
      chatConnection.serverEvents.listen((event) {
        _serverEvents.add(event);
      });

      accountConnection.state.listen((event) {
        log.info(event);
        switch (event) {
          // No connection states.
          case ReadyToConnect():
            _state.add(ApiManagerState.connecting); // TODO: try again at some point
          case Error e: {
            switch (e.error) {
              case ServerConnectionError.connectionFailure: {
                _state.add(ApiManagerState.reconnectWaitTime);
                _reconnectInProgress = true;
                showSnackBar("Connection error - reconnecting in 5 seconds");
                // TODO: check that internet connectivity exists?
                Future.delayed(const Duration(seconds: 5), () async {
                  final currentState = await accountConnection.state.first;

                  if (currentState is Error && currentState.error == ServerConnectionError.connectionFailure) {
                    await restart();
                  }
                })
                  .then((value) => null);
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
            setupTokens();
            _state.add(ApiManagerState.connected);
          }
        }
      });
      // TODO: handle media, proifle and chat
  }

  Future<void> _loadAddressesFromConfig() async {
    final storage = KvStringManager.getInstance();

    final accountAddress =
      await storage.getValueOrDefault(KvStringWithDefault.accountServerAddress);
    _account.updateServerAddress(accountAddress);
    accountConnection.setAddress(toWebSocketUri(accountAddress));

    final profileAddress =
      await storage.getValueOrDefault(KvStringWithDefault.profileServerAddress);
    _profile.updateServerAddress(profileAddress);
    profileConnection.setAddress(toWebSocketUri(profileAddress));

    final mediaAddress =
      await storage.getValueOrDefault(KvStringWithDefault.mediaServerAddress);
    _media.updateServerAddress(mediaAddress);
    mediaConnection.setAddress(toWebSocketUri(mediaAddress));

    final chatAddress =
      await storage.getValueOrDefault(KvStringWithDefault.chatServerAddress);
    _chat.updateServerAddress(chatAddress);
    chatConnection.setAddress(toWebSocketUri(chatAddress));
  }

  Future<void> _connect() async {
    _state.add(ApiManagerState.connecting);

    final storage = KvStringManager.getInstance();
    final accountRefreshToken =
      await storage.getValue(KvString.accountRefreshToken);
    final accountAccessToken =
      await storage.getValue(KvString.accountAccessToken);

    if (accountRefreshToken == null || accountAccessToken == null) {
      _state.add(ApiManagerState.waitingRefreshToken);
      return;
    }

    // TODO: start other connections if needed.
    await accountConnection.start();
  }

  Future<void> restart() async {
    await accountConnection.close();
    await _loadAddressesFromConfig();
    await _connect();
  }

  Future<void> close() async {
    _reconnectInProgress = false;
    await accountConnection.close(logoutClose: true);
    _state.add(ApiManagerState.waitingRefreshToken);
  }

  Future<void> closeAndRefreshServerAddress() async {
    await accountConnection.close(logoutClose: true);
    await _loadAddressesFromConfig();
    _state.add(ApiManagerState.waitingRefreshToken);
  }

  Future<void> setupTokens() async {
    final storage = KvStringManager.getInstance();

    final accountToken = await storage.getValue(KvString.accountAccessToken);
    if (accountToken != null) {
      _account.setAccessToken(AccessToken(accessToken: accountToken));
    }
  }

  bool inMicroserviceMode() {
    return mediaConnection.inUse();
  }

  bool mediaInMicroserviceMode() {
    return mediaConnection.inUse();
  }

  bool profileInMicroserviceMode() {
    return profileConnection.inUse();
  }

  /// Provider for media and media admin API
  ApiProvider _mediaApiProvider() {
    if (mediaConnection.inUse()) {
      return _media;
    } else {
      return _account;
    }
  }

  ApiProvider _profileApiProvider() {
    if (profileConnection.inUse()) {
      return _profile;
    } else {
      return _account;
    }
  }

  ApiProvider _chatApiProvider() {
    if (chatConnection.inUse()) {
      return _chat;
    } else {
      return _account;
    }
  }

  ApiWrapper<AccountApi> _accountWrapper() {
    return ApiWrapper(_account.account);
  }

  ApiWrapper<ProfileApi> profileWrapper() {
    return ApiWrapper(_profileApiProvider().profile);
  }

  ApiWrapper<ChatApi> chatWrapper() {
    return ApiWrapper(_chatApiProvider().chat);
  }

  ApiWrapper<MediaApi> mediaWrapper() {
    return ApiWrapper(_mediaApiProvider().media);
  }

  ApiWrapper<MediaAdminApi> _mediaAdminWrapper() {
    return ApiWrapper(_mediaApiProvider().mediaAdmin);
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

  Future<Result<R, ValueApiError>> accountCommon<R extends Object>(Future<R?> Function(CommonApi) action) async {
    return await ApiWrapper(_account.common).requestValue(action);
  }

  Future<Result<R, ValueApiError>> accountCommonAdmin<R extends Object>(Future<R?> Function(CommonAdminApi) action) async {
    return await ApiWrapper(_account.commonAdmin).requestValue(action);
  }

  Future<Result<R, ValueApiError>> media<R extends Object>(Future<R?> Function(MediaApi) action) async {
    return await mediaWrapper().requestValue(action);
  }

  Future<Result<R, ValueApiError>> mediaAdmin<R extends Object>(Future<R?> Function(MediaAdminApi) action) async {
    return await _mediaAdminWrapper().requestValue(action);
  }

  Future<Result<R, ValueApiError>> mediaCommon<R extends Object>(Future<R?> Function(CommonApi) action) async {
    return await ApiWrapper(_mediaApiProvider().common).requestValue(action);
  }

  Future<Result<R, ValueApiError>> mediaCommonAdmin<R extends Object>(Future<R?> Function(CommonAdminApi) action) async {
    return await ApiWrapper(_mediaApiProvider().commonAdmin).requestValue(action);
  }

  Future<Result<R, ValueApiError>> profile<R extends Object>(Future<R?> Function(ProfileApi) action) async {
    return await profileWrapper().requestValue(action);
  }

  Future<Result<R, ValueApiError>> chat<R extends Object>(Future<R?> Function(ChatApi) action) async {
    return await chatWrapper().requestValue(action);
  }

  Future<Result<R, ValueApiError>> profileCommon<R extends Object>(Future<R?> Function(CommonApi) action) async {
    return await ApiWrapper(_profileApiProvider().common).requestValue(action);
  }

  Future<Result<R, ValueApiError>> profileCommonAdmin<R extends Object>(Future<R?> Function(CommonAdminApi) action) async {
    return await ApiWrapper(_mediaApiProvider().commonAdmin).requestValue(action);
  }

  // Actions

  Future<Result<void, ValueApiError>> commonAction(Server server, Future<void> Function(CommonApi) action) async {
    switch (server) {
      case Server.account:
        return accountCommon(action);
      case Server.media:
        return mediaCommon(action);
      case Server.profile:
        return profileCommon(action);
    }
  }

  Future<Result<void, ValueApiError>> commonAdminAction(Server server, Future<void> Function(CommonAdminApi) action) async {
    switch (server) {
      case Server.account:
        return accountCommonAdmin(action);
      case Server.media:
        return mediaCommonAdmin(action);
      case Server.profile:
        return profileCommonAdmin(action);
    }
  }


  Future<Result<void, ActionApiError>> accountAction(Future<void> Function(AccountApi) action) async {
    return await _accountWrapper().requestAction(action);
  }

  Future<Result<void, ActionApiError>> accountCommonAction(Future<void> Function(CommonApi) action) async {
    return await ApiWrapper(_account.common).requestAction(action);
  }

  Future<Result<void, ActionApiError>> accountCommonAdminAction(Future<void> Function(CommonAdminApi) action) async {
    return await ApiWrapper(_account.commonAdmin).requestAction(action);
  }

  Future<Result<void, ActionApiError>> mediaAction(Future<void> Function(MediaApi) action) async {
    return await mediaWrapper().requestAction(action);
  }

  Future<Result<void, ActionApiError>> mediaAdminAction(Future<void> Function(MediaAdminApi) action) async {
    return await _mediaAdminWrapper().requestAction(action);
  }

  Future<Result<void, ActionApiError>> mediaCommonAction(Future<void> Function(CommonApi) action) async {
    return await ApiWrapper(_mediaApiProvider().common).requestAction(action);
  }

  Future<Result<void, ActionApiError>> mediaCommonAdminAction(Future<void> Function(CommonAdminApi) action) async {
    return await ApiWrapper(_mediaApiProvider().commonAdmin).requestAction(action);
  }

  Future<Result<void, ActionApiError>> profileAction(Future<void> Function(ProfileApi) action) async {
    return await profileWrapper().requestAction(action);
  }

  Future<Result<void, ActionApiError>> chatAction(Future<void> Function(ChatApi) action) async {
    return await chatWrapper().requestAction(action);
  }

  Future<Result<void, ActionApiError>> profileCommonAction(Future<void> Function(CommonApi) action) async {
    return await ApiWrapper(_profileApiProvider().common).requestAction(action);
  }

  Future<Result<void, ActionApiError>> profileCommonAdminAction(Future<void> Function(CommonAdminApi) action) async {
    return await ApiWrapper(_mediaApiProvider().commonAdmin).requestAction(action);
  }

}

String toWebSocketUri(String baseUrl) {
  final base = Uri.parse(baseUrl);

  // final String newScheme;
  // switch (base.scheme) {
  //   case "http": newScheme = "ws";
  //   case "https": newScheme = "wss";
  //   case _: throw Exception(); // TODO: better error handling
  // }

  final newAddress = Uri(
    scheme: base.scheme,
    host: base.host,
    port: base.port,
    path: "/common_api/connect",
  ).toString();

  return newAddress;
}


// class ApiCall<I, O> {
//   final BehaviorSubject<ApiRequestState> state = BehaviorSubject();
//   final StreamController<ApiRegisterResult> allRequests;
//   I? input;

//   ApiCall(Future<ApiCallResult> Function(I) apiCall, this.allRequests) {
//     state.distinct().listen((value) {
//       if (value == ApiRequestState.inFlight) {
//         if (input != null) {
//           await apiCall(input);
//         }
//       }
//     });
//   }

//   Future<O> requestCall(I input) {
//     var first = false;
//     allRequests.stream.listen((event) {
//       if !first {
//         allRequests
//       }
//     })
//     state.add(ApiRequestState.inFlight);
//   }
// }
