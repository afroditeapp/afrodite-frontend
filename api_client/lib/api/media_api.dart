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

  /// Get list of all normal images on the server for one account.
  ///
  /// Get list of all normal images on the server for one account.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] accountId (required):
  Future<Response> getAllNormalImagesWithHttpInfo(String accountId,) async {
    // ignore: prefer_const_declarations
    final path = r'/media_api/all_normal_images/{account_id}'
      .replaceAll('{account_id}', accountId);

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

  /// Get list of all normal images on the server for one account.
  ///
  /// Get list of all normal images on the server for one account.
  ///
  /// Parameters:
  ///
  /// * [String] accountId (required):
  Future<NormalImages?> getAllNormalImages(String accountId,) async {
    final response = await getAllNormalImagesWithHttpInfo(accountId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'NormalImages',) as NormalImages;
    
    }
    return null;
  }

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
  /// * [String] contentId (required):
  ///
  /// * [bool] isMatch (required):
  ///   If false image access is allowed when profile is set as public. If true image access is allowed when users are a match.
  Future<Response> getImageWithHttpInfo(String accountId, String contentId, bool isMatch,) async {
    // ignore: prefer_const_declarations
    final path = r'/media_api/image/{account_id}/{content_id}'
      .replaceAll('{account_id}', accountId)
      .replaceAll('{content_id}', contentId);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'is_match', isMatch));

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
  /// * [String] contentId (required):
  ///
  /// * [bool] isMatch (required):
  ///   If false image access is allowed when profile is set as public. If true image access is allowed when users are a match.
  Future<MultipartFile?> getImage(String accountId, String contentId, bool isMatch,) async {
    final response = await getImageWithHttpInfo(accountId, contentId, isMatch,);
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

  /// Get current public image for selected profile
  ///
  /// Get current public image for selected profile
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] accountId (required):
  ///
  /// * [bool] isMatch (required):
  ///   If false image access is allowed when profile is set as public. If true image access is allowed when users are a match.
  Future<Response> getPrimaryImageInfoWithHttpInfo(String accountId, bool isMatch,) async {
    // ignore: prefer_const_declarations
    final path = r'/media_api/primary_image_info/{account_id}'
      .replaceAll('{account_id}', accountId);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'is_match', isMatch));

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

  /// Get current public image for selected profile
  ///
  /// Get current public image for selected profile
  ///
  /// Parameters:
  ///
  /// * [String] accountId (required):
  ///
  /// * [bool] isMatch (required):
  ///   If false image access is allowed when profile is set as public. If true image access is allowed when users are a match.
  Future<PrimaryImage?> getPrimaryImageInfo(String accountId, bool isMatch,) async {
    final response = await getPrimaryImageInfoWithHttpInfo(accountId, isMatch,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'PrimaryImage',) as PrimaryImage;
    
    }
    return null;
  }

  /// Get current security image for selected profile. Only for admins.
  ///
  /// Get current security image for selected profile. Only for admins.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] accountId (required):
  Future<Response> getSecurityImageInfoWithHttpInfo(String accountId,) async {
    // ignore: prefer_const_declarations
    final path = r'/media_api/security_image_info/{account_id}'
      .replaceAll('{account_id}', accountId);

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

  /// Get current security image for selected profile. Only for admins.
  ///
  /// Get current security image for selected profile. Only for admins.
  ///
  /// Parameters:
  ///
  /// * [String] accountId (required):
  Future<SecurityImage?> getSecurityImageInfo(String accountId,) async {
    final response = await getSecurityImageInfoWithHttpInfo(accountId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'SecurityImage',) as SecurityImage;
    
    }
    return null;
  }

  /// Get current list of moderation requests in my moderation queue.
  ///
  /// Get current list of moderation requests in my moderation queue. Additional requests will be added to my queue if necessary.  ## Access  Account with `admin_moderate_images` capability is required to access this route. 
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> patchModerationRequestListWithHttpInfo() async {
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
  Future<ModerationList?> patchModerationRequestList() async {
    final response = await patchModerationRequestListWithHttpInfo();
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

  /// Set image to moderation request slot.
  ///
  /// Set image to moderation request slot.  Slots from 0 to 2 are available.  TODO: resize and check images at some point 
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] slotId (required):
  ///
  /// * [MultipartFile] body (required):
  Future<Response> putImageToModerationSlotWithHttpInfo(int slotId, MultipartFile body,) async {
    // ignore: prefer_const_declarations
    final path = r'/media_api/moderation/request/slot/{slot_id}'
      .replaceAll('{slot_id}', slotId.toString());

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
  /// Set image to moderation request slot.  Slots from 0 to 2 are available.  TODO: resize and check images at some point 
  ///
  /// Parameters:
  ///
  /// * [int] slotId (required):
  ///
  /// * [MultipartFile] body (required):
  Future<ContentId?> putImageToModerationSlot(int slotId, MultipartFile body,) async {
    final response = await putImageToModerationSlotWithHttpInfo(slotId, body,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ContentId',) as ContentId;
    
    }
    return null;
  }

  /// Create new or override old moderation request.
  ///
  /// Create new or override old moderation request.  Make sure that moderation request has content IDs which points to your own image slots. 
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [ModerationRequestContent] moderationRequestContent (required):
  Future<Response> putModerationRequestWithHttpInfo(ModerationRequestContent moderationRequestContent,) async {
    // ignore: prefer_const_declarations
    final path = r'/media_api/moderation/request';

    // ignore: prefer_final_locals
    Object? postBody = moderationRequestContent;

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
  /// Create new or override old moderation request.  Make sure that moderation request has content IDs which points to your own image slots. 
  ///
  /// Parameters:
  ///
  /// * [ModerationRequestContent] moderationRequestContent (required):
  Future<void> putModerationRequest(ModerationRequestContent moderationRequestContent,) async {
    final response = await putModerationRequestWithHttpInfo(moderationRequestContent,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Set primary image for account. Image content ID can not be empty.
  ///
  /// Set primary image for account. Image content ID can not be empty.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [PrimaryImage] primaryImage (required):
  Future<Response> putPrimaryImageWithHttpInfo(PrimaryImage primaryImage,) async {
    // ignore: prefer_const_declarations
    final path = r'/media_api/primary_image';

    // ignore: prefer_final_locals
    Object? postBody = primaryImage;

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

  /// Set primary image for account. Image content ID can not be empty.
  ///
  /// Set primary image for account. Image content ID can not be empty.
  ///
  /// Parameters:
  ///
  /// * [PrimaryImage] primaryImage (required):
  Future<void> putPrimaryImage(PrimaryImage primaryImage,) async {
    final response = await putPrimaryImageWithHttpInfo(primaryImage,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}
