import "dart:convert";
import "dart:io";

import "package:app/assets.dart";
import "package:flutter/foundation.dart";
import "package:http/http.dart";
import "package:http/io_client.dart";
import "package:utils/utils.dart";
import "package:web_socket/io_web_socket.dart";
import "package:web_socket/web_socket.dart" as ws;

class WebSocketBuilder {
  /// Creates a WebSocket connection to the specified [serverAddress] with
  /// custom [protocols].
  ///
  /// For web platforms, connects directly using ws:// or wss:// protocol.
  /// For native platforms, performs HTTP upgrade handshake with proper headers.
  ///
  /// [serverAddress] - The HTTP server base URL
  /// [path] - The WebSocket endpoint path (e.g. /common_api/connect)
  /// [protocols] - List of WebSocket sub-protocols.
  ///
  /// Returns null if the connection fails (e.g., non-101 response status).
  static Future<ws.WebSocket?> connect(
    String serverAddress,
    List<String> protocols, {
    required String path,
  }) async {
    final effectiveProtocols = protocols;
    final websocketAddress = _buildWebSocketAddress(serverAddress, path);

    if (kIsWeb) {
      if (!websocketAddress.startsWith("http")) {
        throw UnsupportedError("Unsupported URI scheme");
      }
      final wsAddress = Uri.parse(websocketAddress.replaceFirst("http", "ws"));
      return await ws.WebSocket.connect(wsAddress, protocols: effectiveProtocols);
    } else {
      final bytes = generate128BitRandomValue();
      final key = base64.encode(bytes);

      final client = IOClient(
        HttpClient(context: await createSecurityContextForBackendConnection(serverAddress)),
      );
      final headers = {
        HttpHeaders.connectionHeader: "upgrade",
        HttpHeaders.upgradeHeader: "websocket",
        "sec-websocket-version": "13",
        "sec-websocket-key": key,
        "sec-websocket-protocol": effectiveProtocols.join(","),
      };
      final request = Request("GET", Uri.parse(websocketAddress));
      request.headers.addAll(headers);

      final IOStreamedResponse response = await client.send(request);

      if (response.statusCode != HttpStatus.switchingProtocols) {
        return null;
      }

      final socket = WebSocket.fromUpgradedSocket(await response.detachSocket(), serverSide: false);
      return IOWebSocket.fromWebSocket(socket);
    }
  }

  static String _buildWebSocketAddress(String serverAddress, String path) {
    final base = Uri.parse(serverAddress);
    return Uri(scheme: base.scheme, host: base.host, port: base.port, path: path).toString();
  }
}
