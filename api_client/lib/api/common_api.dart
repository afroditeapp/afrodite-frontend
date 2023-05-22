//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class CommonApi {
  CommonApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Connect to server using WebSocket after getting refresh and access tokens.
  ///
  /// Connect to server using WebSocket after getting refresh and access tokens. Connection is required as API access is allowed for connected clients.  Send the current refersh token as Binary. The server will send the next refresh token (Binary) and after that the new access token (Text). After that API can be used.  The access token is valid until this WebSocket is closed. Server might send events as Text which is JSON. 
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getConnectWebsocketWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/common_api/connect';

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

  /// Connect to server using WebSocket after getting refresh and access tokens.
  ///
  /// Connect to server using WebSocket after getting refresh and access tokens. Connection is required as API access is allowed for connected clients.  Send the current refersh token as Binary. The server will send the next refresh token (Binary) and after that the new access token (Text). After that API can be used.  The access token is valid until this WebSocket is closed. Server might send events as Text which is JSON. 
  Future<void> getConnectWebsocket() async {
    final response = await getConnectWebsocketWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}
