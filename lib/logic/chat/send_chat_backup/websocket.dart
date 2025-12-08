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

final _log = Logger("SendChatBackupWebSocket");

// TODO: Remove
const String HARDCODED_PASSWORD = "backup123";
const int MAX_CHUNK_SIZE = 64 * 1024; // 64 KiB

sealed class SendChatBackupWebSocketEvent {}

class WebSocketConnectionClosed extends SendChatBackupWebSocketEvent {
  final int? closeCode;
  WebSocketConnectionClosed(this.closeCode);
}

class WebSocketConnectionError extends SendChatBackupWebSocketEvent {
  WebSocketConnectionError();
}

class SendChatBackupWebSocket {
  ws.WebSocket? _webSocket;
  StreamSubscription<void>? _connectionSubscription;
  final PublishSubject<SendChatBackupWebSocketEvent> _eventController =
      PublishSubject<SendChatBackupWebSocketEvent>();

  Stream<SendChatBackupWebSocketEvent> get events => _eventController.stream;

  Future<bool> connect(String accountId) async {
    final serverAddress = defaultServerUrl();
    final websocketAddress = _addWebSocketRoutePathToAddress(serverAddress);

    try {
      final webSocket = await WebSocketBuilder.connect(websocketAddress, ["v1"]);
      if (webSocket == null) {
        _eventController.add(WebSocketConnectionError());
        return false;
      }

      _webSocket = webSocket;

      // Send initial message for source client
      final initialMessage = DataTransferInitialMessage(
        role: ClientRole.source_,
        accountId: accountId,
        password: HARDCODED_PASSWORD,
      );
      webSocket.sendText(jsonEncode(initialMessage.toJson()));

      // Wait for 1 second delay (per protocol)
      await Future<void>.delayed(const Duration(seconds: 1));

      // Handle incoming messages
      _connectionSubscription = webSocket.events.listen(
        (message) {
          if (message is ws.CloseReceived) {
            _eventController.add(WebSocketConnectionClosed(message.code));
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

  Future<void> sendData(Uint8List data) async {
    final webSocket = _webSocket;
    if (webSocket == null) {
      _eventController.add(WebSocketConnectionError());
      return;
    }

    try {
      // Send byte count
      final byteCountMessage = DataTransferByteCount(byteCount: data.length);
      webSocket.sendText(jsonEncode(byteCountMessage.toJson()));

      // Send data in chunks
      int offset = 0;
      while (offset < data.length) {
        final remainingBytes = data.length - offset;
        final chunkSize = remainingBytes > MAX_CHUNK_SIZE ? MAX_CHUNK_SIZE : remainingBytes;
        final chunk = data.sublist(offset, offset + chunkSize);

        webSocket.sendBytes(chunk);
        offset += chunkSize;
      }
    } catch (e) {
      _log.error("Failed to send data: $e");
      _eventController.add(WebSocketConnectionError());
    }
  }

  String _addWebSocketRoutePathToAddress(String baseUrl) {
    final base = Uri.parse(baseUrl);
    return Uri(
      scheme: base.scheme,
      host: base.host,
      port: base.port,
      path: "/chat_api/transfer_data",
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
