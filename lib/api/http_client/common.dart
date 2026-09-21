import 'package:http/http.dart';
import 'package:web_socket/web_socket.dart' as ws;

/// Builds a WebSocket address from the given [serverAddress]and [path].
String buildWebSocketAddress(String serverAddress, String path) {
  final base = Uri.parse(serverAddress);
  return Uri(scheme: base.scheme, host: base.host, port: base.port, path: path).toString();
}

/// Interface for managing HTTP and WebSocket clients app wide.
abstract interface class HttpClientManagerInterface {
  /// Initializes the HTTP client for the given [serverAddress].
  ///
  /// Can throw an exception if the client cannot be created.
  Future<void> init(String serverAddress);

  /// Returns the cached HTTP client for the given [serverAddress].
  ///
  /// Can throw an exception if the client cannot be created.
  Future<Client> getHttpClient(String serverAddress);

  /// Creates a WebSocket connection to the specified [serverAddress].
  ///
  /// Returns null or throws an exception if the connection fails (e.g., non-101 response status).
  Future<ws.WebSocket?> connectWebSocket(
    String serverAddress,
    List<String> protocols, {
    required String path,
  });
}
