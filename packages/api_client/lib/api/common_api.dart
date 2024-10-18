//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class CommonApi {
  CommonApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Connect to server using WebSocket after getting refresh and access tokens. Connection is required as API access is allowed for connected clients.
  ///
  /// Protocol: 1. Client sends version information as Binary message, where    - u8: Client WebSocket protocol version (currently 0).    - u8: Client type number. (0 = Android, 1 = iOS, 2 = Web, 255 = Test mode bot)    - u16: Client Major version.    - u16: Client Minor version.    - u16: Client Patch version.     The u16 values are in little endian byte order. 2. Client sends current refresh token as Binary message. 3. If server supports the client, the server sends next refresh token    as Binary message.    If server does not support the client, the server sends Text message    and closes the connection. 4. Server sends new access token as Binary message. The client must    convert the token to base64url encoding without padding.    (At this point API can be used.) 5. Client sends list of current data sync versions as Binary message, where    items are [u8; 2] and the first u8 of an item is the data type number    and the second u8 of an item is the sync version number for that data.    If client does not have any version of the data, the client should    send 255 as the version number.     Available data types:    - 0: Account 6. Server starts to send JSON events as Text messages and empty binary    messages to test connection to the client. Client can ignore the empty    binary messages. 7. If needed, the client sends empty binary messages to test connection to    the server.  The new access token is valid until this WebSocket is closed or the server detects a timeout. To prevent the timeout the client must send a WebScoket ping message before 6 minutes elapses from connection establishment or previous ping message.  `Sec-WebSocket-Protocol` header must have 2 protocols/values. The first is \"0\" and that protocol is accepted. The second is access token of currently logged in account. The token is base64url encoded without padding.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getConnectWebsocketWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/6qQZ2jQO5exMKFI2jCzGAdMysxE';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Connect to server using WebSocket after getting refresh and access tokens. Connection is required as API access is allowed for connected clients.
  ///
  /// Protocol: 1. Client sends version information as Binary message, where    - u8: Client WebSocket protocol version (currently 0).    - u8: Client type number. (0 = Android, 1 = iOS, 2 = Web, 255 = Test mode bot)    - u16: Client Major version.    - u16: Client Minor version.    - u16: Client Patch version.     The u16 values are in little endian byte order. 2. Client sends current refresh token as Binary message. 3. If server supports the client, the server sends next refresh token    as Binary message.    If server does not support the client, the server sends Text message    and closes the connection. 4. Server sends new access token as Binary message. The client must    convert the token to base64url encoding without padding.    (At this point API can be used.) 5. Client sends list of current data sync versions as Binary message, where    items are [u8; 2] and the first u8 of an item is the data type number    and the second u8 of an item is the sync version number for that data.    If client does not have any version of the data, the client should    send 255 as the version number.     Available data types:    - 0: Account 6. Server starts to send JSON events as Text messages and empty binary    messages to test connection to the client. Client can ignore the empty    binary messages. 7. If needed, the client sends empty binary messages to test connection to    the server.  The new access token is valid until this WebSocket is closed or the server detects a timeout. To prevent the timeout the client must send a WebScoket ping message before 6 minutes elapses from connection establishment or previous ping message.  `Sec-WebSocket-Protocol` header must have 2 protocols/values. The first is \"0\" and that protocol is accepted. The second is access token of currently logged in account. The token is base64url encoded without padding.
  Future<void> getConnectWebsocket() async {
    final response = await getConnectWebsocketWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Get backend version.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getVersionWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/0E_N3KS0gI2PPBujveMhHLv292Y';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Get backend version.
  Future<BackendVersion?> getVersion() async {
    final response = await getVersionWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'BackendVersion',) as BackendVersion;
    
    }
    return null;
  }
}
