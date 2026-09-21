import 'package:http/http.dart';
import 'package:web_socket/web_socket.dart' as ws;

import 'common.dart';

/// Manages HTTP and WebSocket clients app wide.
///
/// Web browsers do not support TLS configuration so a single HTTP client is
/// shared across all server addresses.
class HttpClientManager implements HttpClientManagerInterface {
  static final _instance = HttpClientManager._();
  HttpClientManager._();
  factory HttpClientManager.getInstance() {
    return _instance;
  }

  Client? _httpClient;

  @override
  Future<void> init(String serverAddress) async {
    _httpClient = Client();
  }

  @override
  Future<Client> getHttpClient(String serverAddress) async {
    final client = _httpClient;
    if (client == null) {
      throw StateError("HttpClientManager has not been initialized");
    }
    return client;
  }

  @override
  Future<ws.WebSocket?> connectWebSocket(
    String serverAddress,
    List<String> protocols, {
    required String path,
  }) async {
    final websocketAddress = buildWebSocketAddress(serverAddress, path);
    if (!websocketAddress.startsWith("http")) {
      throw UnsupportedError("Unsupported URI scheme");
    }
    final wsAddress = Uri.parse(websocketAddress.replaceFirst("http", "ws"));
    return await ws.WebSocket.connect(wsAddress, protocols: protocols);
  }
}
