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
  /// Creates a WebSocket connection to the specified URL with custom protocols.
  ///
  /// For web platforms, connects directly using ws:// or wss:// protocol.
  /// For native platforms, performs HTTP upgrade handshake with proper headers.
  ///
  /// [websocketAddress] - The WebSocket URL to connect to
  /// [protocols] - List of WebSocket sub-protocols.
  ///
  /// Returns null if the connection fails (e.g., non-101 response status).
  static Future<ws.WebSocket?> connect(String websocketAddress, List<String> protocols) async {
    final effectiveProtocols = protocols;

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
        HttpClient(context: await createSecurityContextForBackendConnection()),
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
}
