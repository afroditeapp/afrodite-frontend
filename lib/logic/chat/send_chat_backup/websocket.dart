import "dart:async";
import "dart:convert";
import "dart:typed_data";

import "package:app/api/websocket_builder.dart";
import "package:app/data/login_repository.dart";
import "package:crypto/crypto.dart";
import "package:logging/logging.dart";
import "package:openapi/api.dart";
import "package:rxdart/rxdart.dart";
import "package:utils/utils.dart";
import "package:web_socket/web_socket.dart" as ws;

final _log = Logger("SendChatBackupWebSocket");

const int MAX_CHUNK_SIZE = 64 * 1024; // 64 KiB

sealed class SendChatBackupWebSocketEvent {}

class TargetDataReceived extends SendChatBackupWebSocketEvent {
  final String targetData;
  TargetDataReceived(this.targetData);
}

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

  Future<bool> connect(String targetDataSha256) async {
    final serverAddress = await LoginRepository.getInstance().accountServerAddress.first;
    final websocketAddress = _addWebSocketRoutePathToAddress(serverAddress);

    try {
      final webSocket = await WebSocketBuilder.connect(websocketAddress, ["v1"]);
      if (webSocket == null) {
        _eventController.add(WebSocketConnectionError());
        return false;
      }

      _webSocket = webSocket;

      // Send initial message for source client
      final initialMessage = BackupTransferInitialMessage(
        role: BackupTransferClientRole.source_,
        targetDataSha256: targetDataSha256,
      );
      webSocket.sendText(jsonEncode(initialMessage.toJson()));

      // Wait for 1 second delay (per protocol)
      await Future<void>.delayed(const Duration(seconds: 1));

      // Handle incoming messages
      _connectionSubscription = webSocket.events.listen(
        (message) {
          if (message is ws.CloseReceived) {
            _eventController.add(WebSocketConnectionClosed(message.code));
          } else if (message is ws.TextDataReceived) {
            try {
              final data = jsonDecode(message.text);
              final targetDataMessage = BackupTransferTargetData.fromJson(data);
              if (targetDataMessage != null) {
                // Calculate SHA256 of received message and verify it matches expected hash
                final messageBytes = utf8.encode(targetDataMessage.targetData);
                final calculatedHash = sha256.convert(messageBytes);
                final calculatedHashHex = calculatedHash.toString();

                if (calculatedHashHex != targetDataSha256) {
                  _log.error(
                    "Target data SHA256 mismatch: expected $targetDataSha256, got $calculatedHashHex",
                  );
                  _eventController.add(WebSocketConnectionError());
                  return;
                }

                _eventController.add(TargetDataReceived(targetDataMessage.targetData));
              }
            } catch (e) {
              _log.warning("Failed to parse target data message: $e");
            }
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

  Future<void> sendData(Uint8List sourcePublicKey, Uint8List encryptedData) async {
    final webSocket = _webSocket;
    if (webSocket == null) {
      _eventController.add(WebSocketConnectionError());
      return;
    }

    try {
      // Calculate total transfer size:
      // 1 byte (version) + 4 bytes (public key length) + public key + 4 bytes (encrypted data length) + encrypted data
      final totalBytes = 1 + 4 + sourcePublicKey.length + 4 + encryptedData.length;

      // Send byte count (total transfer size)
      final byteCountMessage = BackupTransferByteCount(byteCount: totalBytes);
      webSocket.sendText(jsonEncode(byteCountMessage.toJson()));

      // Send version byte (1)
      final versionByte = Uint8List.fromList([1]);
      webSocket.sendBytes(versionByte);

      // Send source public key length as 32-bit little endian unsigned integer
      final publicKeyLengthBytes = Uint8List(4);
      final publicKeyByteData = ByteData.view(publicKeyLengthBytes.buffer);
      publicKeyByteData.setUint32(0, sourcePublicKey.length, Endian.little);
      webSocket.sendBytes(publicKeyLengthBytes);

      // Send source public key
      webSocket.sendBytes(sourcePublicKey);

      // Send encrypted data length as 32-bit little endian unsigned integer
      final encryptedDataLengthBytes = Uint8List(4);
      final encryptedDataByteData = ByteData.view(encryptedDataLengthBytes.buffer);
      encryptedDataByteData.setUint32(0, encryptedData.length, Endian.little);
      webSocket.sendBytes(encryptedDataLengthBytes);

      // Send encrypted data in chunks
      int offset = 0;
      while (offset < encryptedData.length) {
        final remainingBytes = encryptedData.length - offset;
        final chunkSize = remainingBytes > MAX_CHUNK_SIZE ? MAX_CHUNK_SIZE : remainingBytes;
        final chunk = encryptedData.sublist(offset, offset + chunkSize);

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
