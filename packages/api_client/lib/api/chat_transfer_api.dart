//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class ChatTransferApi {
  ChatTransferApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Transfer data between clients using WebSocket.
  ///
  /// This WebSocket connection facilitates secure data transfer between two clients: a target client (receiving data) and a source client (sending data).  Header `Sec-WebSocket-Protocol` must have `v1` as the first value.  ## Target Client Flow: 1. Connect and send initial message:    ```json    {        \"role\": \"target\",        \"access_token\": \"ACCESS_TOKEN\",        \"public_key\": \"PUBLIC_KEY\",        \"password\": \"PASSWORD\"    }    ``` 2. Wait for source to connect (timeout: 1 hour) 3. Receive byte count:    ```json    {        \"byte_count\": BYTE_COUNT    }    ``` 4. Receive binary messages until all bytes transferred  ## Source Client Flow: 1. Connect and send initial message (must connect after target):    ```json    {        \"role\": \"source\",        \"account_id\": \"ACCOUNT_ID\",        \"password\": \"PASSWORD\"    }    ```    Note: Response has constant 1-second delay. Connection closes if password is invalid    or target is not connected. 2. Send byte count:    ```json    {        \"byte_count\": BYTE_COUNT    }    ``` 3. Send binary messages containing the data until all bytes transferred.    Max size for a binary message is 64 KiB. Server will stop the data    transfer if binary message size is larger than the max size.  ## Transfer Budget Enforcement: When the yearly transfer budget is exceeded, both WebSockets (source and target) are closed with status code 4000.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getTransferDataWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/transfer_data';

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

  /// Transfer data between clients using WebSocket.
  ///
  /// This WebSocket connection facilitates secure data transfer between two clients: a target client (receiving data) and a source client (sending data).  Header `Sec-WebSocket-Protocol` must have `v1` as the first value.  ## Target Client Flow: 1. Connect and send initial message:    ```json    {        \"role\": \"target\",        \"access_token\": \"ACCESS_TOKEN\",        \"public_key\": \"PUBLIC_KEY\",        \"password\": \"PASSWORD\"    }    ``` 2. Wait for source to connect (timeout: 1 hour) 3. Receive byte count:    ```json    {        \"byte_count\": BYTE_COUNT    }    ``` 4. Receive binary messages until all bytes transferred  ## Source Client Flow: 1. Connect and send initial message (must connect after target):    ```json    {        \"role\": \"source\",        \"account_id\": \"ACCOUNT_ID\",        \"password\": \"PASSWORD\"    }    ```    Note: Response has constant 1-second delay. Connection closes if password is invalid    or target is not connected. 2. Send byte count:    ```json    {        \"byte_count\": BYTE_COUNT    }    ``` 3. Send binary messages containing the data until all bytes transferred.    Max size for a binary message is 64 KiB. Server will stop the data    transfer if binary message size is larger than the max size.  ## Transfer Budget Enforcement: When the yearly transfer budget is exceeded, both WebSockets (source and target) are closed with status code 4000.
  Future<void> getTransferData() async {
    final response = await getTransferDataWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}
