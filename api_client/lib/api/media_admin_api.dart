//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class MediaAdminApi {
  MediaAdminApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Get current list of moderation requests in my moderation queue.
  ///
  /// Get current list of moderation requests in my moderation queue. Additional requests will be added to my queue if necessary.  ## Access  Account with `admin_moderate_images` capability is required to access this route. 
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [ModerationQueueType] queue (required):
  Future<Response> patchModerationRequestListWithHttpInfo(ModerationQueueType queue,) async {
    // ignore: prefer_const_declarations
    final path = r'/media_api/admin/moderation/page/next';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'queue', queue));

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'PATCH',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Get current list of moderation requests in my moderation queue.
  ///
  /// Get current list of moderation requests in my moderation queue. Additional requests will be added to my queue if necessary.  ## Access  Account with `admin_moderate_images` capability is required to access this route. 
  ///
  /// Parameters:
  ///
  /// * [ModerationQueueType] queue (required):
  Future<ModerationList?> patchModerationRequestList(ModerationQueueType queue,) async {
    final response = await patchModerationRequestListWithHttpInfo(queue,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ModerationList',) as ModerationList;
    
    }
    return null;
  }

  /// Handle moderation request of some account.
  ///
  /// Handle moderation request of some account.  ## Access  Account with `admin_moderate_images` capability is required to access this route. 
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] accountId (required):
  ///
  /// * [HandleModerationRequest] handleModerationRequest (required):
  Future<Response> postHandleModerationRequestWithHttpInfo(String accountId, HandleModerationRequest handleModerationRequest,) async {
    // ignore: prefer_const_declarations
    final path = r'/media_api/admin/moderation/handle_request/{account_id}'
      .replaceAll('{account_id}', accountId);

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

  /// Handle moderation request of some account.
  ///
  /// Handle moderation request of some account.  ## Access  Account with `admin_moderate_images` capability is required to access this route. 
  ///
  /// Parameters:
  ///
  /// * [String] accountId (required):
  ///
  /// * [HandleModerationRequest] handleModerationRequest (required):
  Future<void> postHandleModerationRequest(String accountId, HandleModerationRequest handleModerationRequest,) async {
    final response = await postHandleModerationRequestWithHttpInfo(accountId, handleModerationRequest,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}
