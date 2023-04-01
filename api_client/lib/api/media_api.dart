//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class MediaApi {
  MediaApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Get profile image
  ///
  /// Get profile image
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] accountId (required):
  ///
  /// * [String] imageFile (required):
  Future<Response> getImageWithHttpInfo(String accountId, String imageFile,) async {
    // ignore: prefer_const_declarations
    final path = r'/media_api/image/{account_id}/{image_file}'
      .replaceAll('{account_id}', accountId)
      .replaceAll('{image_file}', imageFile);

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

  /// Get profile image
  ///
  /// Get profile image
  ///
  /// Parameters:
  ///
  /// * [String] accountId (required):
  ///
  /// * [String] imageFile (required):
  Future<void> getImage(String accountId, String imageFile,) async {
    final response = await getImageWithHttpInfo(accountId, imageFile,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Get current moderation request.
  ///
  /// Get current moderation request. 
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getModerationRequestWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/media_api/moderation/request';

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

  /// Get current moderation request.
  ///
  /// Get current moderation request. 
  Future<ModerationRequest?> getModerationRequest() async {
    final response = await getModerationRequestWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ModerationRequest',) as ModerationRequest;
    
    }
    return null;
  }

  /// Get list of next moderation requests in moderation queue.
  ///
  /// Get list of next moderation requests in moderation queue.  ## Access  Account with `admin_moderate_images` capability is required to access this route. 
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getModerationRequestListWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/media_api/admin/moderation/page/next';

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

  /// Get list of next moderation requests in moderation queue.
  ///
  /// Get list of next moderation requests in moderation queue.  ## Access  Account with `admin_moderate_images` capability is required to access this route. 
  Future<ModerationRequestList?> getModerationRequestList() async {
    final response = await getModerationRequestListWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ModerationRequestList',) as ModerationRequestList;
    
    }
    return null;
  }

  /// Handle moderation request.
  ///
  /// Handle moderation request.  ## Access  Account with `admin_moderate_images` capability is required to access this route. 
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] requestId (required):
  ///
  /// * [HandleModerationRequest] handleModerationRequest (required):
  Future<Response> postHandleModerationRequestWithHttpInfo(String requestId, HandleModerationRequest handleModerationRequest,) async {
    // ignore: prefer_const_declarations
    final path = r'/media_api/admin/moderation/handle_request/{request_id}'
      .replaceAll('{request_id}', requestId);

    // ignore: prefer_final_locals
    Object? postBody = handleModerationRequest;

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

  /// Handle moderation request.
  ///
  /// Handle moderation request.  ## Access  Account with `admin_moderate_images` capability is required to access this route. 
  ///
  /// Parameters:
  ///
  /// * [String] requestId (required):
  ///
  /// * [HandleModerationRequest] handleModerationRequest (required):
  Future<void> postHandleModerationRequest(String requestId, HandleModerationRequest handleModerationRequest,) async {
    final response = await postHandleModerationRequestWithHttpInfo(requestId, handleModerationRequest,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Set image to moderation request slot.
  ///
  /// Set image to moderation request slot.  Slots \"camera\" and \"image1\" are available. 
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] slotId (required):
  ///
  /// * [String] body (required):
  Future<Response> putImageToModerationSlotWithHttpInfo(String slotId, String body,) async {
    // ignore: prefer_const_declarations
    final path = r'/media_api/moderation/request/slot/{slot_id}'
      .replaceAll('{slot_id}', slotId);

    // ignore: prefer_final_locals
    Object? postBody = body;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['image/jpeg'];


    return apiClient.invokeAPI(
      path,
      'PUT',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Set image to moderation request slot.
  ///
  /// Set image to moderation request slot.  Slots \"camera\" and \"image1\" are available. 
  ///
  /// Parameters:
  ///
  /// * [String] slotId (required):
  ///
  /// * [String] body (required):
  Future<void> putImageToModerationSlot(String slotId, String body,) async {
    final response = await putImageToModerationSlotWithHttpInfo(slotId, body,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Create new or override old moderation request.
  ///
  /// Create new or override old moderation request.  Set images to moderation request slots first. 
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [NewModerationRequest] newModerationRequest (required):
  Future<Response> putModerationRequestWithHttpInfo(NewModerationRequest newModerationRequest,) async {
    // ignore: prefer_const_declarations
    final path = r'/media_api/moderation/request';

    // ignore: prefer_final_locals
    Object? postBody = newModerationRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'PUT',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Create new or override old moderation request.
  ///
  /// Create new or override old moderation request.  Set images to moderation request slots first. 
  ///
  /// Parameters:
  ///
  /// * [NewModerationRequest] newModerationRequest (required):
  Future<void> putModerationRequest(NewModerationRequest newModerationRequest,) async {
    final response = await putModerationRequestWithHttpInfo(newModerationRequest,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}
