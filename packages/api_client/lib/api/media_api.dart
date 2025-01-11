//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class MediaApi {
  MediaApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Delete content data.
  ///
  /// # Own account Content can be deleted after specific time has passed since removing all usage of it (content is not assigned as security or profile content).  # Admin Admin can remove content without restrictions with permission `admin_delete_media_content`.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  ///
  /// * [String] cid (required):
  Future<Response> deleteContentWithHttpInfo(String aid, String cid,) async {
    // ignore: prefer_const_declarations
    final path = r'/9ztWJZUmcnzICLL2gJ8qV8gVoR8/{aid}/{cid}'
      .replaceAll('{aid}', aid)
      .replaceAll('{cid}', cid);

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

  /// Delete content data.
  ///
  /// # Own account Content can be deleted after specific time has passed since removing all usage of it (content is not assigned as security or profile content).  # Admin Admin can remove content without restrictions with permission `admin_delete_media_content`.
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  ///
  /// * [String] cid (required):
  Future<void> deleteContent(String aid, String cid,) async {
    final response = await deleteContentWithHttpInfo(aid, cid,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Get list of all media content on the server for one account.
  ///
  /// # Access  - Own account - Permission [model::Permissions::admin_moderate_media_content]
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  Future<Response> getAllAccountMediaContentWithHttpInfo(String aid,) async {
    // ignore: prefer_const_declarations
    final path = r'/RzBkQfHdmWHdL0L1Uq-DVE6kiVY/{aid}'
      .replaceAll('{aid}', aid);

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

  /// Get list of all media content on the server for one account.
  ///
  /// # Access  - Own account - Permission [model::Permissions::admin_moderate_media_content]
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  Future<AccountContent?> getAllAccountMediaContent(String aid,) async {
    final response = await getAllAccountMediaContentWithHttpInfo(aid,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'AccountContent',) as AccountContent;
    
    }
    return null;
  }

  /// Get content data
  ///
  /// # Access  ## Own content Unrestricted access.  ## Public other content Normal account state required.  ## Private other content If owner of the requested content is a match and the requested content is in current profile content, then the requested content can be accessed if query parameter `is_match` is set to `true`.  If the previous is not true, then permission `admin_view_all_profiles` or `admin_moderate_media_content` is required.  
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  ///
  /// * [String] cid (required):
  ///
  /// * [bool] isMatch:
  ///   If false media content access is allowed when profile is set as public. If true media content access is allowed when users are a match.
  Future<Response> getContentWithHttpInfo(String aid, String cid, { bool? isMatch, }) async {
    // ignore: prefer_const_declarations
    final path = r'/9ztWJZUmcnzICLL2gJ8qV8gVoR8/{aid}/{cid}'
      .replaceAll('{aid}', aid)
      .replaceAll('{cid}', cid);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (isMatch != null) {
      queryParams.addAll(_queryParams('', 'is_match', isMatch));
    }

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

  /// Get content data
  ///
  /// # Access  ## Own content Unrestricted access.  ## Public other content Normal account state required.  ## Private other content If owner of the requested content is a match and the requested content is in current profile content, then the requested content can be accessed if query parameter `is_match` is set to `true`.  If the previous is not true, then permission `admin_view_all_profiles` or `admin_moderate_media_content` is required.  
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  ///
  /// * [String] cid (required):
  ///
  /// * [bool] isMatch:
  ///   If false media content access is allowed when profile is set as public. If true media content access is allowed when users are a match.
  Future<MultipartFile?> getContent(String aid, String cid, { bool? isMatch, }) async {
    final response = await getContentWithHttpInfo(aid, cid,  isMatch: isMatch, );
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

  /// Get state of content slot.
  ///
  /// Slots from 0 to 6 are available.  
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] slotId (required):
  Future<Response> getContentSlotStateWithHttpInfo(int slotId,) async {
    // ignore: prefer_const_declarations
    final path = r'/y5DgJJAaDZF89y6X4ge84klpBq0/{slot_id}'
      .replaceAll('{slot_id}', slotId.toString());

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

  /// Get state of content slot.
  ///
  /// Slots from 0 to 6 are available.  
  ///
  /// Parameters:
  ///
  /// * [int] slotId (required):
  Future<ContentProcessingState?> getContentSlotState(int slotId,) async {
    final response = await getContentSlotStateWithHttpInfo(slotId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ContentProcessingState',) as ContentProcessingState;
    
    }
    return null;
  }

  /// Get map tile PNG file.
  ///
  /// Returns a .png even if the URL does not have it.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] z (required):
  ///
  /// * [int] x (required):
  ///
  /// * [String] y (required):
  Future<Response> getMapTileWithHttpInfo(int z, int x, String y,) async {
    // ignore: prefer_const_declarations
    final path = r'/BoFh54UgWwlQvwJfb0TpJqd4gaM/{z}/{x}/{y}'
      .replaceAll('{z}', z.toString())
      .replaceAll('{x}', x.toString())
      .replaceAll('{y}', y);

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

  /// Get map tile PNG file.
  ///
  /// Returns a .png even if the URL does not have it.
  ///
  /// Parameters:
  ///
  /// * [int] z (required):
  ///
  /// * [int] x (required):
  ///
  /// * [String] y (required):
  Future<MultipartFile?> getMapTile(int z, int x, String y,) async {
    final response = await getMapTileWithHttpInfo(z, x, y,);
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

  /// Get my profile and security content
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getMediaContentInfoWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/IVQB_zKtVtalr-77q1-670RgOpg';

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

  /// Get my profile and security content
  Future<GetMediaContentResult?> getMediaContentInfo() async {
    final response = await getMediaContentInfoWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'GetMediaContentResult',) as GetMediaContentResult;
    
    }
    return null;
  }

  /// Get current profile content for selected profile.
  ///
  /// # Access  ## Own profile Unrestricted access.  ## Other profiles Normal account state required.  ## Private other profiles If the profile is a match, then the profile can be accessed if query parameter `is_match` is set to `true`.  If the profile is not a match, then permission `admin_view_all_profiles` is required.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  ///
  /// * [String] version:
  ///
  /// * [bool] isMatch:
  ///   If false profile content access is allowed when profile is set as public. If true profile content access is allowed when users are a match.
  Future<Response> getProfileContentInfoWithHttpInfo(String aid, { String? version, bool? isMatch, }) async {
    // ignore: prefer_const_declarations
    final path = r'/ZYlzEPvPMBx2V1S6Ee-kIhp2_rg/{aid}'
      .replaceAll('{aid}', aid);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (version != null) {
      queryParams.addAll(_queryParams('', 'version', version));
    }
    if (isMatch != null) {
      queryParams.addAll(_queryParams('', 'is_match', isMatch));
    }

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

  /// Get current profile content for selected profile.
  ///
  /// # Access  ## Own profile Unrestricted access.  ## Other profiles Normal account state required.  ## Private other profiles If the profile is a match, then the profile can be accessed if query parameter `is_match` is set to `true`.  If the profile is not a match, then permission `admin_view_all_profiles` is required.
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  ///
  /// * [String] version:
  ///
  /// * [bool] isMatch:
  ///   If false profile content access is allowed when profile is set as public. If true profile content access is allowed when users are a match.
  Future<GetProfileContentResult?> getProfileContentInfo(String aid, { String? version, bool? isMatch, }) async {
    final response = await getProfileContentInfoWithHttpInfo(aid,  version: version, isMatch: isMatch, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'GetProfileContentResult',) as GetProfileContentResult;
    
    }
    return null;
  }

  /// Get current security content for selected profile.
  ///
  /// # Access  - Own account - Permission [model::Permissions::admin_moderate_media_content]
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  Future<Response> getSecurityContentInfoWithHttpInfo(String aid,) async {
    // ignore: prefer_const_declarations
    final path = r'/6lWoyl4YuurCAEnkJbnSy1wP22M/{aid}'
      .replaceAll('{aid}', aid);

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

  /// Get current security content for selected profile.
  ///
  /// # Access  - Own account - Permission [model::Permissions::admin_moderate_media_content]
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  Future<SecurityContent?> getSecurityContentInfo(String aid,) async {
    final response = await getSecurityContentInfoWithHttpInfo(aid,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'SecurityContent',) as SecurityContent;
    
    }
    return null;
  }

  /// Get initial content moderation completed result.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> postGetInitialContentModerationCompletedWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/F6vxr3u-OBwaCkVm_bzTaM4NmRc';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


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

  /// Get initial content moderation completed result.
  Future<InitialContentModerationCompletedResult?> postGetInitialContentModerationCompleted() async {
    final response = await postGetInitialContentModerationCompletedWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'InitialContentModerationCompletedResult',) as InitialContentModerationCompletedResult;
    
    }
    return null;
  }

  /// Upload content to server. The content is saved to content processing slot when account state is [model::AccountState::InitialSetup]. In other states the slot number is ignored and content goes directly to moderation.
  ///
  /// Processing ID will be returned and processing of the content will begin. Events about the content processing will be sent to the client.  The state of the processing can be also queired. The querying is required to receive the content ID.  Slots from 0 to 6 are available.  One account can only have one content in upload or processing state. New upload might potentially delete the previous if processing of it is not complete.  Content processing will fail if image content resolution width or height value is less than 512.  
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] slotId (required):
  ///
  /// * [bool] secureCapture (required):
  ///   Client captured this content.
  ///
  /// * [MediaContentType] contentType (required):
  ///
  /// * [MultipartFile] body (required):
  Future<Response> putContentToContentSlotWithHttpInfo(int slotId, bool secureCapture, MediaContentType contentType, MultipartFile body,) async {
    // ignore: prefer_const_declarations
    final path = r'/y5DgJJAaDZF89y6X4ge84klpBq0/{slot_id}'
      .replaceAll('{slot_id}', slotId.toString());

    // ignore: prefer_final_locals
    Object? postBody = body;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'secure_capture', secureCapture));
      queryParams.addAll(_queryParams('', 'content_type', contentType));

    const contentTypes = <String>['application/octet-stream'];


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

  /// Upload content to server. The content is saved to content processing slot when account state is [model::AccountState::InitialSetup]. In other states the slot number is ignored and content goes directly to moderation.
  ///
  /// Processing ID will be returned and processing of the content will begin. Events about the content processing will be sent to the client.  The state of the processing can be also queired. The querying is required to receive the content ID.  Slots from 0 to 6 are available.  One account can only have one content in upload or processing state. New upload might potentially delete the previous if processing of it is not complete.  Content processing will fail if image content resolution width or height value is less than 512.  
  ///
  /// Parameters:
  ///
  /// * [int] slotId (required):
  ///
  /// * [bool] secureCapture (required):
  ///   Client captured this content.
  ///
  /// * [MediaContentType] contentType (required):
  ///
  /// * [MultipartFile] body (required):
  Future<ContentProcessingId?> putContentToContentSlot(int slotId, bool secureCapture, MediaContentType contentType, MultipartFile body,) async {
    final response = await putContentToContentSlotWithHttpInfo(slotId, secureCapture, contentType, body,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ContentProcessingId',) as ContentProcessingId;
    
    }
    return null;
  }

  /// Set new profile content for current account.
  ///
  /// This also moves the content to moderation if it is not already in moderation or moderated.  Also profile visibility moves from pending to normal when all profile content is moderated as accepted.  # Restrictions - All content must be owned by the account. - All content must be images. - First content must have face detected.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [SetProfileContent] setProfileContent (required):
  Future<Response> putProfileContentWithHttpInfo(SetProfileContent setProfileContent,) async {
    // ignore: prefer_const_declarations
    final path = r'/_rsyG4gpvDy3O3Aj5hpLp3-8oPE';

    // ignore: prefer_final_locals
    Object? postBody = setProfileContent;

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

  /// Set new profile content for current account.
  ///
  /// This also moves the content to moderation if it is not already in moderation or moderated.  Also profile visibility moves from pending to normal when all profile content is moderated as accepted.  # Restrictions - All content must be owned by the account. - All content must be images. - First content must have face detected.
  ///
  /// Parameters:
  ///
  /// * [SetProfileContent] setProfileContent (required):
  Future<void> putProfileContent(SetProfileContent setProfileContent,) async {
    final response = await putProfileContentWithHttpInfo(setProfileContent,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Set current security content for current account.
  ///
  /// This also moves the content to moderation if it is not already in moderation or moderated.  # Restrictions - The content must be owned by the account. - The content must be an image. - The content must be captured by client. - The content must have face detected.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [ContentId] contentId (required):
  Future<Response> putSecurityContentInfoWithHttpInfo(ContentId contentId,) async {
    // ignore: prefer_const_declarations
    final path = r'/6lWoyl4YuurCAEnkJbnSy1wP22M';

    // ignore: prefer_final_locals
    Object? postBody = contentId;

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

  /// Set current security content for current account.
  ///
  /// This also moves the content to moderation if it is not already in moderation or moderated.  # Restrictions - The content must be owned by the account. - The content must be an image. - The content must be captured by client. - The content must have face detected.
  ///
  /// Parameters:
  ///
  /// * [ContentId] contentId (required):
  Future<void> putSecurityContentInfo(ContentId contentId,) async {
    final response = await putSecurityContentInfoWithHttpInfo(contentId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}
