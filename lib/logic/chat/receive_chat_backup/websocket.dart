import "dart:async";
import "dart:convert";
import "dart:typed_data";

import "package:app/api/websocket_builder.dart";
import "package:app/config.dart";
import "package:logging/logging.dart";
import "package:openapi/api.dart";
import "package:rxdart/rxdart.dart";
import "package:utils/utils.dart";
import "package:web_socket/web_socket.dart" as ws;

final _log = Logger("ReceiveChatBackupWebSocket");

sealed class ReceiveChatBackupWebSocketEvent {}

class ByteCountReceived extends ReceiveChatBackupWebSocketEvent {
  final int byteCount;
  ByteCountReceived(this.byteCount);
}

class BinaryDataReceived extends ReceiveChatBackupWebSocketEvent {
  final Uint8List data;
  BinaryDataReceived(this.data);
}

class WebSocketConnectionClosed extends ReceiveChatBackupWebSocketEvent {
  final int? closeCode;
  WebSocketConnectionClosed(this.closeCode);
}

class WebSocketConnectionError extends ReceiveChatBackupWebSocketEvent {
  WebSocketConnectionError();
}

class ReceiveChatBackupWebSocket {
  ws.WebSocket? _webSocket;
  StreamSubscription<void>? _connectionSubscription;
  final PublishSubject<ReceiveChatBackupWebSocketEvent> _eventController =
      PublishSubject<ReceiveChatBackupWebSocketEvent>();

  Stream<ReceiveChatBackupWebSocketEvent> get events => _eventController.stream;

  Future<bool> connect(AccessToken accessToken, String targetData) async {
    final serverAddress = defaultServerUrl();
    final websocketAddress = _addWebSocketRoutePathToAddress(serverAddress);

    try {
      final webSocket = await WebSocketBuilder.connect(websocketAddress, ["v1"]);
      if (webSocket == null) {
        _eventController.add(WebSocketConnectionError());
        return false;
      }

      _webSocket = webSocket;

      // Send initial message for target client
      final initialMessage = BackupTransferInitialMessage(
        role: BackupTransferClientRole.target,
        accessToken: accessToken.token,
        targetData: targetData,
      );
      webSocket.sendText(jsonEncode(initialMessage.toJson()));

      // Handle incoming messages
      _connectionSubscription = webSocket.events.listen(
        (message) {
          if (message is ws.CloseReceived) {
            _eventController.add(WebSocketConnectionClosed(message.code));
          } else if (message is ws.TextDataReceived) {
            try {
              final data = jsonDecode(message.text);
              final byteCountMessage = BackupTransferByteCount.fromJson(data);
              if (byteCountMessage != null) {
                _eventController.add(ByteCountReceived(byteCountMessage.byteCount));
              }
            } catch (e) {
              _log.warning("Failed to parse text message: $e");
            }
          } else if (message is ws.BinaryDataReceived) {
            _eventController.add(BinaryDataReceived(message.data));
          }
        },
        onError: (Object error) {
          _log.error("Connection error: $error");
          _eventController.add(WebSocketConnectionError());
        },
        cancelOnError: true,
      );

      return true;
    } catch (e) {
      _log.error("Failed to connect: $e");
      _eventController.add(WebSocketConnectionError());
      return false;
    }
  }

  String _addWebSocketRoutePathToAddress(String baseUrl) {
    final base = Uri.parse(baseUrl);
    return Uri(
      scheme: base.scheme,
      host: base.host,
      port: base.port,
      path: "/chat_api/backup_transfer",
    ).toString();
  }

  Future<void> close() async {
    await _connectionSubscription?.cancel();
    _connectionSubscription = null;
    try {
      await _webSocket?.close();
    } catch (_) {}
    _webSocket = null;
    await _eventController.close();
  }
}
