
import 'dart:async';
import 'dart:ffi';
import 'dart:io';

import 'package:english_words/english_words.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/api/api_provider.dart';
import 'package:pihka_frontend/api/api_wrapper.dart';
import 'package:pihka_frontend/api/server_connection.dart';
import 'package:pihka_frontend/config.dart';
import 'package:pihka_frontend/logic/app/main_state.dart';
import 'package:pihka_frontend/storage/kv.dart';
import 'package:pihka_frontend/ui/utils.dart';
import 'package:pihka_frontend/utils.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

final log = Logger("ApiManager");

enum Server {
  account,
  media,
  profile,
}

enum ApiManagerState {
  /// Run init mehod.
  initRequired,
  /// No valid refresh token available. UI should display login view.
  waitingRefreshToken,
  /// Reconnecting will happen in few seconds.
  reconnectWaitTime,
  /// Making connections to servers.
  connecting,
  /// Connection to servers established.
  connected,
}

sealed class ApiManagerEvent {}
//class DoConnect implements ApiManagerEvent {}
// class EventFromConnection implements ApiManagerEvent {
//   final ServerSlot server;
//   final ServerConnectionEvent event;
//   EventFromConnection(this.server, this.event);
// }

enum ServerWsEvent {
  todo,
}


class ApiManager extends AppSingleton {
  ApiManager._private();
  static final _instance = ApiManager._private();
  factory ApiManager.getInstance() {
    return _instance;
  }

  final ApiProvider _account =
    ApiProvider(KvStringWithDefault.accountServerAddress.defaultValue());
  final ApiProvider _media =
    ApiProvider(KvStringWithDefault.mediaServerAddress.defaultValue());
  final ApiProvider _profile =
    ApiProvider(KvStringWithDefault.profileServerAddress.defaultValue());

  final BehaviorSubject<ApiManagerState> _state =
    BehaviorSubject.seeded(ApiManagerState.initRequired);
  final PublishSubject<ApiManagerEvent> _events =
    PublishSubject();
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

  Stream<ApiManagerState> get state => _state.distinct();
  Stream<ServerWsEvent> get serverEvents => _serverEvents;

  @override
  Future<void> init() async {
    if (_state.value != ApiManagerState.initRequired) {
      return;
    }
    await _account.init();
    await _profile.init();
    await _media.init();

    _connectEvents();
    await _loadAddressesFromConfig();
    await _connect();
  }

  void _connectEvents() {
    _events
      .stream
      .asyncMap((event) {
        switch (event) {
          case _: return;
        }
      })
      .listen((event) { });

      accountConnection.serverEvents.listen((event) {
        _serverEvents.add(event);
      });
      profileConnection.serverEvents.listen((event) {
        _serverEvents.add(event);
      });
      mediaConnection.serverEvents.listen((event) {
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
            }
          }
          // Ongoing connection states
          case Connecting():
            _state.add(ApiManagerState.connecting);
          case Ready(): {
            setupTokens();
            _state.add(ApiManagerState.connected);
          }
        }
      });
      // TODO: handle media and proifle
  }

  Future<void> _loadAddressesFromConfig() async {
    final storage = KvStorageManager.getInstance();

    final accountAddress =
      await storage.getStringOrDefault(KvStringWithDefault.accountServerAddress);
    _account.updateServerAddress(accountAddress);
    accountConnection.setAddress(toWebSocketUri(accountAddress));

    final profileAddress =
      await storage.getStringOrDefault(KvStringWithDefault.profileServerAddress);
    _profile.updateServerAddress(profileAddress);
    profileConnection.setAddress(toWebSocketUri(profileAddress));

    final mediaAddress =
      await storage.getStringOrDefault(KvStringWithDefault.mediaServerAddress);
    _media.updateServerAddress(mediaAddress);
    mediaConnection.setAddress(toWebSocketUri(mediaAddress));
  }

  Future<void> _connect() async {
    _state.add(ApiManagerState.connecting);

    final storage = KvStorageManager.getInstance();
    final accountRefreshToken =
      await storage.getString(KvString.accountRefreshToken);
    final accountAccessToken =
      await storage.getString(KvString.accountAccessToken);

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
    await accountConnection.close();
    _state.add(ApiManagerState.waitingRefreshToken);
  }

  // Future<void> _handleEventFromConnection(EventFromConnection e) async {
  //   final s = KvStorageManager.getInstance();
  //   switch (e.event) {
  //     case NewRefreshToken token:
  //       await s.setString(e.server.toRefreshTokenKey(), token.newRefreshToken);
  //     case NewAccessToken token:
  //       await s.setString(e.server.toAccessTokenKey(), token.newAccessToken);

  //     // TODO: support multiple servers
  //     case Ready():
  //       _state.add(ApiManagerState.connected);
  //     // TODO: support multiple servers
  //     case Closed(): {
  //       _state.add(ApiManagerState.connecting);
  //     }
  //       _serverEvents.add(ServerWsEvent.todo);

  //     case EventFromServerTodo():
  //       _serverEvents.add(ServerWsEvent.todo);
  //   }
  // }


  Future<void> setupTokens() async {
    final storage = KvStorageManager.getInstance();

    final accountToken = await storage.getString(KvString.accountAccessToken);
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

  ApiWrapper<AccountApi> _accountWrapper() {
    return ApiWrapper(_account.account);
  }

  ApiWrapper<ProfileApi> _profileWrapper() {
    return ApiWrapper(_profileApiProvider().profile);
  }

  ApiWrapper<MediaApi> _mediaWrapper() {
    return ApiWrapper(_mediaApiProvider().media);
  }

  ApiWrapper<MediaAdminApi> _mediaAdminWrapper() {
    return ApiWrapper(_mediaApiProvider().mediaAdmin);
  }

  Future<R?> common<R extends Object>(Server server, Future<R?> Function(CommonApi) action) async {
    switch (server) {
      case Server.account:
        return accountCommon(action);
      case Server.media:
        return mediaCommon(action);
      case Server.profile:
        return profileCommon(action);
    }
  }

  Future<R?> commonAdmin<R extends Object>(Server server, Future<R?> Function(CommonAdminApi) action) async {
    switch (server) {
      case Server.account:
        return accountCommonAdmin(action);
      case Server.media:
        return mediaCommonAdmin(action);
      case Server.profile:
        return profileCommonAdmin(action);
    }
  }

  Future<R?> account<R extends Object>(Future<R?> Function(AccountApi) action) async {
    return await _accountWrapper().request(action);
  }

  Future<R?> accountCommon<R extends Object>(Future<R?> Function(CommonApi) action) async {
    return await ApiWrapper(_account.common).request(action);
  }

  Future<R?> accountCommonAdmin<R extends Object>(Future<R?> Function(CommonAdminApi) action) async {
    return await ApiWrapper(_account.commonAdmin).request(action);
  }

  Future<R?> media<R extends Object>(Future<R?> Function(MediaApi) action) async {
    return await _mediaWrapper().request(action);
  }

  Future<R?> mediaAdmin<R extends Object>(Future<R?> Function(MediaAdminApi) action) async {
    return await _mediaAdminWrapper().request(action);
  }

  Future<R?> mediaCommon<R extends Object>(Future<R?> Function(CommonApi) action) async {
    return await ApiWrapper(_mediaApiProvider().common).request(action);
  }

  Future<R?> mediaCommonAdmin<R extends Object>(Future<R?> Function(CommonAdminApi) action) async {
    return await ApiWrapper(_mediaApiProvider().commonAdmin).request(action);
  }

  Future<R?> profile<R extends Object>(Future<R?> Function(ProfileApi) action) async {
    return await _profileWrapper().request(action);
  }

  Future<R?> profileCommon<R extends Object>(Future<R?> Function(CommonApi) action) async {
    return await ApiWrapper(_profileApiProvider().common).request(action);
  }

  Future<R?> profileCommonAdmin<R extends Object>(Future<R?> Function(CommonAdminApi) action) async {
    return await ApiWrapper(_mediaApiProvider().commonAdmin).request(action);
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
