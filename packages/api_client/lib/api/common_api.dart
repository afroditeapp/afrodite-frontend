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

  /// Delete current data export
  ///
  /// Data export state will move from [DataExportStateType::Done] or [DataExportStateType::Error] to [DataExportStateType::Empty].
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> deleteDataExportWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/common_api/delete_data_export';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'DELETE',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Delete current data export
  ///
  /// Data export state will move from [DataExportStateType::Done] or [DataExportStateType::Error] to [DataExportStateType::Empty].
  Future<void> deleteDataExport() async {
    final response = await deleteDataExportWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'GET /common_api/client_config' operation and returns the [Response].
  Future<Response> getClientConfigWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/common_api/client_config';

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

  Future<ClientConfig?> getClientConfig() async {
    final response = await getClientConfigWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ClientConfig',) as ClientConfig;
    
    }
    return null;
  }

  /// Performs an HTTP 'GET /common_api/client_language' operation and returns the [Response].
  Future<Response> getClientLanguageWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/common_api/client_language';

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

  Future<ClientLanguage?> getClientLanguage() async {
    final response = await getClientLanguageWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ClientLanguage',) as ClientLanguage;
    
    }
    return null;
  }

  /// Connect to server using WebSocket after getting refresh and access tokens. Connection is required as API access is allowed for connected clients.
  ///
  /// Protocol: 1. Server sends one of these byte values as Binary message:    - 0, continue to data sync, move to step 5, at this point API can be used.    - 1, access token and refresh token refresh is needed, move to step 2.    - 2, unsupported client version, server closes the connection      without sending WebSocket Close message.    - 3, invalid access token, server closes the connection      without sending WebSocket Close message. 2. Client sends current refresh token as Binary message. 3. Server sends new refresh token as Binary message. 4. Server sends new access token as Binary message. The client must    convert the token to base64url encoding without padding.    (At this point API can be used.) 5. Client sends list of current data sync versions as Binary message, where    items are [u8; 2] and the first u8 of an item is the data type number    and the second u8 of an item is the sync version number for that data.    If client does not have any version of the data, the client should    send 255 as the version number.     Available data types:    - 0: Account 6. Server starts to send JSON events as Text messages and empty binary    messages to test connection to the client. Client can ignore the empty    binary messages. 7. If needed, the client sends empty binary messages to test connection to    the server.  The new access token is valid until this WebSocket is closed or the server detects a timeout. To prevent the timeout the client must send a WebScoket ping message before 6 minutes elapses from connection establishment or previous ping message.  `Sec-WebSocket-Protocol` header must have the following values:   - Client WebSocket protocol version string (currently \"v1\").   - Client access token string (prefix 't' and base64url encoded token     without base64url padding).   - Client info string (prefix 'c' and values separated with '_' character)     - Client type number (0 = Android, 1 = iOS, 2 = Web, 255 = Test mode bot).     - Client major version number.     - Client minor version number.     - Client patch version number.
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

  /// Connect to server using WebSocket after getting refresh and access tokens. Connection is required as API access is allowed for connected clients.
  ///
  /// Protocol: 1. Server sends one of these byte values as Binary message:    - 0, continue to data sync, move to step 5, at this point API can be used.    - 1, access token and refresh token refresh is needed, move to step 2.    - 2, unsupported client version, server closes the connection      without sending WebSocket Close message.    - 3, invalid access token, server closes the connection      without sending WebSocket Close message. 2. Client sends current refresh token as Binary message. 3. Server sends new refresh token as Binary message. 4. Server sends new access token as Binary message. The client must    convert the token to base64url encoding without padding.    (At this point API can be used.) 5. Client sends list of current data sync versions as Binary message, where    items are [u8; 2] and the first u8 of an item is the data type number    and the second u8 of an item is the sync version number for that data.    If client does not have any version of the data, the client should    send 255 as the version number.     Available data types:    - 0: Account 6. Server starts to send JSON events as Text messages and empty binary    messages to test connection to the client. Client can ignore the empty    binary messages. 7. If needed, the client sends empty binary messages to test connection to    the server.  The new access token is valid until this WebSocket is closed or the server detects a timeout. To prevent the timeout the client must send a WebScoket ping message before 6 minutes elapses from connection establishment or previous ping message.  `Sec-WebSocket-Protocol` header must have the following values:   - Client WebSocket protocol version string (currently \"v1\").   - Client access token string (prefix 't' and base64url encoded token     without base64url padding).   - Client info string (prefix 'c' and values separated with '_' character)     - Client type number (0 = Android, 1 = iOS, 2 = Web, 255 = Test mode bot).     - Client major version number.     - Client minor version number.     - Client patch version number.
  Future<void> getConnectWebsocket() async {
    final response = await getConnectWebsocketWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Download current data export archive
  ///
  /// Requires data export state [DataExportStateType::Done].
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] name (required):
  Future<Response> getDataExportArchiveWithHttpInfo(String name,) async {
    // ignore: prefer_const_declarations
    final path = r'/common_api/data_export_archive';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'name', name));

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

  /// Download current data export archive
  ///
  /// Requires data export state [DataExportStateType::Done].
  ///
  /// Parameters:
  ///
  /// * [String] name (required):
  Future<MultipartFile?> getDataExportArchive(String name,) async {
    final response = await getDataExportArchiveWithHttpInfo(name,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'MultipartFile',) as MultipartFile;
    
    }
    return null;
  }

  /// Performs an HTTP 'GET /common_api/data_export_state' operation and returns the [Response].
  Future<Response> getDataExportStateWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/common_api/data_export_state';

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

  Future<DataExportState?> getDataExportState() async {
    final response = await getDataExportStateWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'DataExportState',) as DataExportState;
    
    }
    return null;
  }

  /// Get backend version.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getVersionWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/common_api/version';

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

  /// Performs an HTTP 'POST /common_api/client_language' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ClientLanguage] clientLanguage (required):
  Future<Response> postClientLanguageWithHttpInfo(ClientLanguage clientLanguage,) async {
    // ignore: prefer_const_declarations
    final path = r'/common_api/client_language';

    // ignore: prefer_final_locals
    Object? postBody = clientLanguage;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [ClientLanguage] clientLanguage (required):
  Future<void> postClientLanguage(ClientLanguage clientLanguage,) async {
    final response = await postClientLanguageWithHttpInfo(clientLanguage,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Get pending notification and reset pending notification.
  ///
  /// When client receives a FCM data notification use this API route to download the notification.  Requesting this route is always valid to avoid figuring out device token values more easily.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [PendingNotificationToken] pendingNotificationToken (required):
  Future<Response> postGetPendingNotificationWithHttpInfo(PendingNotificationToken pendingNotificationToken,) async {
    // ignore: prefer_const_declarations
    final path = r'/common_api/get_pending_notification';

    // ignore: prefer_final_locals
    Object? postBody = pendingNotificationToken;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Get pending notification and reset pending notification.
  ///
  /// When client receives a FCM data notification use this API route to download the notification.  Requesting this route is always valid to avoid figuring out device token values more easily.
  ///
  /// Parameters:
  ///
  /// * [PendingNotificationToken] pendingNotificationToken (required):
  Future<PendingNotificationWithData?> postGetPendingNotification(PendingNotificationToken pendingNotificationToken,) async {
    final response = await postGetPendingNotificationWithHttpInfo(pendingNotificationToken,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'PendingNotificationWithData',) as PendingNotificationWithData;
    
    }
    return null;
  }

  /// Performs an HTTP 'POST /common_api/set_device_token' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [FcmDeviceToken] fcmDeviceToken (required):
  Future<Response> postSetDeviceTokenWithHttpInfo(FcmDeviceToken fcmDeviceToken,) async {
    // ignore: prefer_const_declarations
    final path = r'/common_api/set_device_token';

    // ignore: prefer_final_locals
    Object? postBody = fcmDeviceToken;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [FcmDeviceToken] fcmDeviceToken (required):
  Future<PendingNotificationToken?> postSetDeviceToken(FcmDeviceToken fcmDeviceToken,) async {
    final response = await postSetDeviceTokenWithHttpInfo(fcmDeviceToken,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'PendingNotificationToken',) as PendingNotificationToken;
    
    }
    return null;
  }

  /// Start data export
  ///
  /// Data export state will move from [DataExportStateType::Empty] to [DataExportStateType::InProgress].  # Access  * Without admin permission, own account can exported once per 24 hours.   The export command sending time is stored only in RAM, so the limit   resets when backend restarts. Only allowed data export type is   [DataExportType::User]. * With [Permissions::admin_export_data] all accounts can be exported   without limits.  
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [PostStartDataExport] postStartDataExport (required):
  Future<Response> postStartDataExportWithHttpInfo(PostStartDataExport postStartDataExport,) async {
    // ignore: prefer_const_declarations
    final path = r'/common_api/start_data_export';

    // ignore: prefer_final_locals
    Object? postBody = postStartDataExport;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Start data export
  ///
  /// Data export state will move from [DataExportStateType::Empty] to [DataExportStateType::InProgress].  # Access  * Without admin permission, own account can exported once per 24 hours.   The export command sending time is stored only in RAM, so the limit   resets when backend restarts. Only allowed data export type is   [DataExportType::User]. * With [Permissions::admin_export_data] all accounts can be exported   without limits.  
  ///
  /// Parameters:
  ///
  /// * [PostStartDataExport] postStartDataExport (required):
  Future<void> postStartDataExport(PostStartDataExport postStartDataExport,) async {
    final response = await postStartDataExportWithHttpInfo(postStartDataExport,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}
