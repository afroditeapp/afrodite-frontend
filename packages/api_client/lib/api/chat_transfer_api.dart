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

  /// Transfer chat backup between clients using WebSocket.
  ///
  /// This WebSocket connection facilitates secure backup transfer between two clients: a target client (receiving data) and a source client (sending data).  Header `Sec-WebSocket-Protocol` must have `v1` as the first value.  ## Target Client Flow: 1. Connect and send initial JSON message [BackupTransferInitialMessage] with [ClientRole::Target] 2. Wait for source to connect (timeout: 1 hour). Sending empty    binary messages is possible to test connectivity. 3. Receive byte count JSON message [model_chat::BackupTransferByteCount] 4. Receive binary messages until all bytes transferred  ## Source Client Flow: 1. Connect and send initial JSON message [BackupTransferInitialMessage] with    [ClientRole::Source] (must connect after target).    Note: Response has constant 1-second delay.    Connection closes if [BackupTransferInitialMessage::data_sha256] is invalid    or target is not connected. 2. Receive data JSON message [BackupTransferData] 3. Send byte count JSON message [model_chat::BackupTransferByteCount] 4. Send binary messages containing the data until all bytes transferred.    Max size for a binary message is 64 KiB. Server will stop the data    transfer if binary message size is larger than the max size.  ## WebSocket Close Status Codes: - 1000 (Normal Closure): Transfer completed successfully - 1008 (Policy Violation): Yearly transfer budget exceeded - No close status code: Other error
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getBackupTransferWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/backup_transfer';

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

  /// Transfer chat backup between clients using WebSocket.
  ///
  /// This WebSocket connection facilitates secure backup transfer between two clients: a target client (receiving data) and a source client (sending data).  Header `Sec-WebSocket-Protocol` must have `v1` as the first value.  ## Target Client Flow: 1. Connect and send initial JSON message [BackupTransferInitialMessage] with [ClientRole::Target] 2. Wait for source to connect (timeout: 1 hour). Sending empty    binary messages is possible to test connectivity. 3. Receive byte count JSON message [model_chat::BackupTransferByteCount] 4. Receive binary messages until all bytes transferred  ## Source Client Flow: 1. Connect and send initial JSON message [BackupTransferInitialMessage] with    [ClientRole::Source] (must connect after target).    Note: Response has constant 1-second delay.    Connection closes if [BackupTransferInitialMessage::data_sha256] is invalid    or target is not connected. 2. Receive data JSON message [BackupTransferData] 3. Send byte count JSON message [model_chat::BackupTransferByteCount] 4. Send binary messages containing the data until all bytes transferred.    Max size for a binary message is 64 KiB. Server will stop the data    transfer if binary message size is larger than the max size.  ## WebSocket Close Status Codes: - 1000 (Normal Closure): Transfer completed successfully - 1008 (Policy Violation): Yearly transfer budget exceeded - No close status code: Other error
  Future<void> getBackupTransfer() async {
    final response = await getBackupTransferWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}
