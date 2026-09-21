import "package:app/api/http_client/http_client.dart";
import "package:web_socket/web_socket.dart" as ws;

class WebSocketBuilder {
  /// Creates a WebSocket connection to the specified [serverAddress] with
  /// custom [protocols].
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
  }) {
    return HttpClientManager.getInstance().connectWebSocket(serverAddress, protocols, path: path);
  }
}
