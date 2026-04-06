import 'dart:async';

import 'package:app/api/server_connection_manager.dart';
import 'package:app/api/server_connection_protocol/client.dart';
import 'package:app/api/server_connection_protocol/server.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:app/utils/result.dart';
import 'package:rxdart/rxdart.dart';
import 'package:utils/utils.dart';

final _log = Logger("WebSocketApiRequestManager");

sealed class WebSocketApiRequestCmd<T> {
  final BehaviorSubject<T?> completed = BehaviorSubject.seeded(null);

  /// Can be called only once
  Future<T> waitCompletionAndDispose() async {
    final value = await completed.whereType<T>().first;
    await completed.close();
    return value;
  }
}

class RequestResetProfilePaging
    extends WebSocketApiRequestCmd<Result<ProfileIteratorSessionId, ()>> {
  @override
  String toString() {
    return "RequestResetProfilePaging";
  }
}

class RequestGetNextProfilePage extends WebSocketApiRequestCmd<Result<ProfilePage, ()>> {
  final ProfileIteratorSessionId sessionId;
  RequestGetNextProfilePage(this.sessionId);

  @override
  String toString() {
    return "RequestGetNextProfilePage(${sessionId.id})";
  }
}

class RequestAutomaticProfileSearchResetProfilePaging
    extends WebSocketApiRequestCmd<Result<AutomaticProfileSearchIteratorSessionId, ()>> {
  @override
  String toString() {
    return "RequestAutomaticProfileSearchResetProfilePaging";
  }
}

class RequestAutomaticProfileSearchGetNextProfilePage
    extends WebSocketApiRequestCmd<Result<ProfilePage, ()>> {
  final AutomaticProfileSearchIteratorSessionId sessionId;
  RequestAutomaticProfileSearchGetNextProfilePage(this.sessionId);

  @override
  String toString() {
    return "RequestAutomaticProfileSearchGetNextProfilePage(${sessionId.id})";
  }
}

/// The WebSocket API seems to be good enough for profile iterators as single
/// failure requires iterator reset, so it is not possible that response of
/// previous request is used as a response for a new request.
class WebSocketApiRequestManager {
  static const Duration _connectTimeout = Duration(seconds: 3);
  static const Duration _requestTimeout = Duration(seconds: 60);
  static const int _requestIdMaxValue = 255;

  final Stream<ServerMessage> _serverMessages;
  final ValueStream<ServerConnectionManagerState> _connectionStates;
  final Future<void> Function(ClientMessage message) _sendMessageToServer;

  final PublishSubject<WebSocketApiRequestCmd<Object>> _cmds = PublishSubject();
  StreamSubscription<void>? _cmdsSubscription;
  int _nextRequestId = 0;

  bool get _isConnected => _connectionStates.value is ConnectedToServer;

  WebSocketApiRequestManager({
    required Stream<ServerMessage> serverMessages,
    required ValueStream<ServerConnectionManagerState> connectionStates,
    required Future<void> Function(ClientMessage message) sendMessageToServer,
  }) : _serverMessages = serverMessages,
       _connectionStates = connectionStates,
       _sendMessageToServer = sendMessageToServer;

  void init() {
    _cmdsSubscription = _listenCmds();
  }

  Future<void> dispose() async {
    await _cmdsSubscription?.cancel();
    await _cmds.close();
  }

  StreamSubscription<void> _listenCmds() {
    return _cmds
        .asyncMap((cmd) async {
          _log.fine("cmd: $cmd");
          try {
            switch (cmd) {
              case RequestResetProfilePaging():
                cmd.completed.add(
                  await _requestWithConnectivityTracking(
                    sendRequest: (requestId) =>
                        _sendMessageToServer(ClientMessage.requestResetProfilePaging(requestId)),
                    waitResponse: (requestId) => _waitForResponse(
                      type: ServerMessageTypeCode.responseResetProfilePaging,
                      requestId: requestId,
                      parser: (message) => _okIfNotNull(message.responseResetProfilePaging),
                    ),
                  ),
                );
              case RequestGetNextProfilePage():
                cmd.completed.add(
                  await _requestWithConnectivityTracking(
                    sendRequest: (requestId) => _sendMessageToServer(
                      ClientMessage.requestGetNextProfilePage(requestId, cmd.sessionId),
                    ),
                    waitResponse: (requestId) => _waitForResponse(
                      type: ServerMessageTypeCode.responseNextProfilePage,
                      requestId: requestId,
                      parser: (message) => _okIfNotNull(message.responseNextProfilePage),
                    ),
                  ),
                );
              case RequestAutomaticProfileSearchResetProfilePaging():
                cmd.completed.add(
                  await _requestWithConnectivityTracking(
                    sendRequest: (requestId) => _sendMessageToServer(
                      ClientMessage.requestAutomaticProfileSearchResetProfilePaging(requestId),
                    ),
                    waitResponse: (requestId) => _waitForResponse(
                      type: ServerMessageTypeCode.responseAutomaticProfileSearchResetProfilePaging,
                      requestId: requestId,
                      parser: (message) =>
                          _okIfNotNull(message.responseAutomaticProfileSearchResetProfilePaging),
                    ),
                  ),
                );
              case RequestAutomaticProfileSearchGetNextProfilePage():
                cmd.completed.add(
                  await _requestWithConnectivityTracking(
                    sendRequest: (requestId) => _sendMessageToServer(
                      ClientMessage.requestAutomaticProfileSearchGetNextProfilePage(
                        requestId,
                        cmd.sessionId,
                      ),
                    ),
                    waitResponse: (requestId) => _waitForResponse(
                      type: ServerMessageTypeCode.responseAutomaticProfileSearchNextProfilePage,
                      requestId: requestId,
                      parser: (message) =>
                          _okIfNotNull(message.responseAutomaticProfileSearchNextProfilePage),
                    ),
                  ),
                );
            }
          } catch (_) {
            switch (cmd) {
              case RequestResetProfilePaging():
                cmd.completed.add(const Err(()));
              case RequestGetNextProfilePage():
                cmd.completed.add(const Err(()));
              case RequestAutomaticProfileSearchResetProfilePaging():
                cmd.completed.add(const Err(()));
              case RequestAutomaticProfileSearchGetNextProfilePage():
                cmd.completed.add(const Err(()));
            }
          }
        })
        .listen(null);
  }

  Future<Result<ProfileIteratorSessionId, ()>> requestResetProfilePaging() async {
    final cmd = RequestResetProfilePaging();
    _cmds.add(cmd);
    return await cmd.waitCompletionAndDispose();
  }

  Future<Result<ProfilePage, ()>> requestGetNextProfilePage(
    ProfileIteratorSessionId sessionId,
  ) async {
    final cmd = RequestGetNextProfilePage(sessionId);
    _cmds.add(cmd);
    return await cmd.waitCompletionAndDispose();
  }

  Future<Result<AutomaticProfileSearchIteratorSessionId, ()>>
  requestAutomaticProfileSearchResetProfilePaging() async {
    final cmd = RequestAutomaticProfileSearchResetProfilePaging();
    _cmds.add(cmd);
    return await cmd.waitCompletionAndDispose();
  }

  Future<Result<ProfilePage, ()>> requestAutomaticProfileSearchGetNextProfilePage(
    AutomaticProfileSearchIteratorSessionId sessionId,
  ) async {
    final cmd = RequestAutomaticProfileSearchGetNextProfilePage(sessionId);
    _cmds.add(cmd);
    return await cmd.waitCompletionAndDispose();
  }

  Result<T, ()> _okIfNotNull<T>(T? value) {
    if (value == null) {
      return const Err(());
    }
    return Ok(value);
  }

  int _takeNextRequestId() {
    final requestId = _nextRequestId;
    _nextRequestId = (_nextRequestId + 1) & _requestIdMaxValue;
    return requestId;
  }

  Future<Result<T, ()>> _requestWithConnectivityTracking<T>({
    required Future<void> Function(int requestId) sendRequest,
    required Future<Result<T, ()>> Function(int requestId) waitResponse,
  }) async {
    if (!await _waitForConnected()) {
      _log.error("Connection waiting failed");
      return const Err(());
    }

    final requestId = _takeNextRequestId();

    final waitResponseOrError = Completer<_RequestOutcome<T>>();

    final outcome = await Future.any<_RequestOutcome<T>>([
      waitResponse(requestId).then((value) => _RequestResponse(value)),
      _waitForDisconnected().then((_) => _RequestConnectivityChanged()),
      Future.delayed(_requestTimeout, () => _RequestTimeout()),
      sendRequest(requestId).then((_) => waitResponseOrError.future),
    ]);

    waitResponseOrError.complete(outcome);

    switch (outcome) {
      case _RequestResponse(:final response):
        return response;
      case _RequestConnectivityChanged():
        _log.error("Connectivity changed");
        return const Err(());
      case _RequestTimeout():
        _log.error("Request timeout");
        return const Err(());
    }
  }

  Future<Result<T, ()>> _waitForResponse<T>({
    required ServerMessageTypeCode type,
    required int requestId,
    required Result<T, ()> Function(ServerMessage message) parser,
  }) async {
    final event = await _serverMessages.firstWhere((message) {
      return message.type == type && message.responseId == requestId;
    });
    return parser(event);
  }

  Future<bool> _waitForConnected() async {
    if (_isConnected) {
      return true;
    }

    try {
      await _connectionStates
          .firstWhere((state) => state is ConnectedToServer)
          .timeout(_connectTimeout);
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<void> _waitForDisconnected() async {
    if (!_isConnected) {
      return;
    }
    await _connectionStates.firstWhere((state) => state is! ConnectedToServer);
  }
}

sealed class _RequestOutcome<T> {}

class _RequestResponse<T> extends _RequestOutcome<T> {
  final Result<T, ()> response;
  _RequestResponse(this.response);
}

class _RequestConnectivityChanged<T> extends _RequestOutcome<T> {}

class _RequestTimeout<T> extends _RequestOutcome<T> {}
