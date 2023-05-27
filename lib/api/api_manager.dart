
import 'dart:async';
import 'dart:io';

import 'package:english_words/english_words.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/api/api_provider.dart';
import 'package:pihka_frontend/api/api_wrapper.dart';
import 'package:pihka_frontend/api/server_connection.dart';
import 'package:pihka_frontend/config.dart';
import 'package:pihka_frontend/logic/app/main_state.dart';
import 'package:pihka_frontend/storage/kv.dart';
import 'package:pihka_frontend/utils.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

enum ApiManagerState {
  /// Run init mehod.
  initRequired,
  /// No valid refresh token available. UI should display login view.
  waitingRefreshToken,
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
    ApiProvider(ConfigStringKey.accountServerAddress.defaultValue());
  final ApiProvider _media =
    ApiProvider(ConfigStringKey.mediaServerAddress.defaultValue());
  final ApiProvider _profile =
    ApiProvider(ConfigStringKey.profileServerAddress.defaultValue());

  final BehaviorSubject<ApiManagerState> _state =
    BehaviorSubject.seeded(ApiManagerState.initRequired);
  final PublishSubject<ApiManagerEvent> _events =
    PublishSubject();
  final PublishSubject<ServerWsEvent> _serverEvents =
    PublishSubject();

  ServerConnection accountConnection =
    ServerConnection(
      ServerSlot.account,
      ConfigStringKey.accountServerAddress.defaultValue(),
    );
  ServerConnection mediaConnection =
   ServerConnection(
      ServerSlot.media,
      ConfigStringKey.mediaServerAddress.defaultValue(),
    );
  ServerConnection profileConnection =
    ServerConnection(
      ServerSlot.profile,
      ConfigStringKey.profileServerAddress.defaultValue(),
    );

  Stream<ApiManagerState> get state => _state.distinct();
  Stream<ServerWsEvent> get serverEvents => _serverEvents;

  @override
  Future<void> init() async {
    if (_state.value != ApiManagerState.initRequired) {
      return;
    }
    _connectEvents();
    await loadAddressesFromConfig();
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
  }

  Future<void> loadAddressesFromConfig() async {
    final config = ConfigManager.getInstance();

    final accountAddress =
      await config.getString(ConfigStringKey.accountServerAddress);
    _account.updateServerAddress(accountAddress);
    accountConnection.setAddress(toWebSocketUri(accountAddress));

    final profileAddress =
      await config.getString(ConfigStringKey.profileServerAddress);
    _profile.updateServerAddress(profileAddress);
    profileConnection.setAddress(toWebSocketUri(profileAddress));

    final mediaAddress =
      await config.getString(ConfigStringKey.mediaServerAddress);
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
    accountConnection.start();
  }

  Future<void> restart() async {
    await accountConnection.close();
    await loadAddressesFromConfig();
    await _connect();
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


  // Future<void> setupTokens() async {
  //   final storage = KvStorageManager.getInstance();

  //   if (storage.getString(KvString.ac))
  //   _account.updateServerAddress(
  //     await config.getString(ConfigStringKey.accountServerAddress)
  //   );
  //   _profile.updateServerAddress(
  //     await config.getString(ConfigStringKey.profileServerAddress)
  //   );
  //   _media.updateServerAddress(
  //     await config.getString(ConfigStringKey.mediaServerAddress)
  //   );
  // }

  ApiWrapper<AccountApi> accountWrapper() {
    return ApiWrapper(_account.account);
  }

  ApiWrapper<MediaApi> mediaWrapper() {
    if (mediaConnection.inUse()) {
      return ApiWrapper(_media.media);
    } else {
      return ApiWrapper(_account.media);
    }
  }

  ApiWrapper<ProfileApi> profileWrapper() {
    if (profileConnection.inUse()) {
      return ApiWrapper(_profile.profile);
    } else {
      return ApiWrapper(_account.profile);
    }
  }

  Future<R?> account<R extends Object>(Future<R?> Function(AccountApi) action) async {
    return await accountWrapper().request(action);
  }

  Future<R?> media<R extends Object>(Future<R?> Function(MediaApi) action) async {
    return await mediaWrapper().request(action);
  }

  Future<R?> profile<R extends Object>(Future<R?> Function(ProfileApi) action) async {
    return await profileWrapper().request(action);
  }
}

String toWebSocketUri(String baseUrl) {
  final base = Uri.parse(baseUrl);

  final String newScheme;
  switch (base.scheme) {
    case "http": newScheme = "ws";
    case "https": newScheme = "wss";
    case _: throw Exception(); // TODO: better error handling
  }

  return Uri(
    scheme: newScheme,
    host: base.host,
    port: base.port,
    path: "/common_api/connect",
  ).toString();
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
