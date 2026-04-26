//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class MediaAdminApi {
  MediaAdminApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Get image processing configuration
  ///
  /// # Permissions Requires admin_server_view_image_processing_config.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getImageProcessingConfigWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/media_api/image_processing_config';

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

  /// Get image processing configuration
  ///
  /// # Permissions Requires admin_server_view_image_processing_config.
  Future<ImageProcessingDynamicConfig?> getImageProcessingConfig() async {
    final response = await getImageProcessingConfigWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ImageProcessingDynamicConfig',) as ImageProcessingDynamicConfig;
    
    }
    return null;
  }

  /// Get image processing config warnings
  ///
  /// # Permissions Requires admin_server_view_image_processing_config.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getImageProcessingConfigWarningsWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/media_api/image_processing_config_warnings';

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

  /// Get image processing config warnings
  ///
  /// # Permissions Requires admin_server_view_image_processing_config.
  Future<ImageProcessingWarnings?> getImageProcessingConfigWarnings() async {
    final response = await getImageProcessingConfigWarningsWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ImageProcessingWarnings',) as ImageProcessingWarnings;
    
    }
    return null;
  }

  /// Get first page of accounts with security selfie and content where `face_verified` is NULL and `face_detected` is true or `face_detected_manual` is true. Oldest security content set time is first and count 25.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getMediaContentFaceVerifiedNullListWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/media_api/media_content_face_verified_null_list';

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

  /// Get first page of accounts with security selfie and content where `face_verified` is NULL and `face_detected` is true or `face_detected_manual` is true. Oldest security content set time is first and count 25.
  Future<GetMediaContentFaceVerifiedNullList?> getMediaContentFaceVerifiedNullList() async {
    final response = await getMediaContentFaceVerifiedNullListWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'GetMediaContentFaceVerifiedNullList',) as GetMediaContentFaceVerifiedNullList;
    
    }
    return null;
  }

  /// Get first page of pending media content moderations. Oldest item is first and count 25.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [MediaContentType] contentType (required):
  ///
  /// * [ModerationQueueType] queue (required):
  ///
  /// * [bool] showContentWhichBotsCanModerate (required):
  Future<Response> getMediaContentPendingModerationListWithHttpInfo(MediaContentType contentType, ModerationQueueType queue, bool showContentWhichBotsCanModerate,) async {
    // ignore: prefer_const_declarations
    final path = r'/media_api/media_content_pending_moderation';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'content_type', contentType));
      queryParams.addAll(_queryParams('', 'queue', queue));
      queryParams.addAll(_queryParams('', 'show_content_which_bots_can_moderate', showContentWhichBotsCanModerate));

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

  /// Get first page of pending media content moderations. Oldest item is first and count 25.
  ///
  /// Parameters:
  ///
  /// * [MediaContentType] contentType (required):
  ///
  /// * [ModerationQueueType] queue (required):
  ///
  /// * [bool] showContentWhichBotsCanModerate (required):
  Future<GetMediaContentPendingModerationList?> getMediaContentPendingModerationList(MediaContentType contentType, ModerationQueueType queue, bool showContentWhichBotsCanModerate,) async {
    final response = await getMediaContentPendingModerationListWithHttpInfo(contentType, queue, showContentWhichBotsCanModerate,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'GetMediaContentPendingModerationList',) as GetMediaContentPendingModerationList;
    
    }
    return null;
  }

  /// Get current security content for selected profile.
  ///
  /// # Access  - Permission [model::Permissions::admin_moderate_media_content] - Permission [model::Permissions::admin_edit_media_content_face_verified_value] - Permission [model::Permissions::admin_edit_security_content_verified_value]
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  Future<Response> getSecurityContentInfoWithHttpInfo(String aid,) async {
    // ignore: prefer_const_declarations
    final path = r'/media_api/security_content_info/{aid}'
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
  /// # Access  - Permission [model::Permissions::admin_moderate_media_content] - Permission [model::Permissions::admin_edit_media_content_face_verified_value] - Permission [model::Permissions::admin_edit_security_content_verified_value]
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  Future<SecurityContentAdminInfo?> getSecurityContentInfo(String aid,) async {
    final response = await getSecurityContentInfoWithHttpInfo(aid,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'SecurityContentAdminInfo',) as SecurityContentAdminInfo;
    
    }
    return null;
  }

  /// Update image processing configuration
  ///
  /// # Permissions Requires admin_server_edit_image_processing_config.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [ImageProcessingDynamicConfig] imageProcessingDynamicConfig (required):
  Future<Response> postImageProcessingConfigWithHttpInfo(ImageProcessingDynamicConfig imageProcessingDynamicConfig,) async {
    // ignore: prefer_const_declarations
    final path = r'/media_api/image_processing_config';

    // ignore: prefer_final_locals
    Object? postBody = imageProcessingDynamicConfig;

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

  /// Update image processing configuration
  ///
  /// # Permissions Requires admin_server_edit_image_processing_config.
  ///
  /// Parameters:
  ///
  /// * [ImageProcessingDynamicConfig] imageProcessingDynamicConfig (required):
  Future<void> postImageProcessingConfig(ImageProcessingDynamicConfig imageProcessingDynamicConfig,) async {
    final response = await postImageProcessingConfigWithHttpInfo(imageProcessingDynamicConfig,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Change media content face detected value
  ///
  /// # Access * Permission [model::Permissions::admin_edit_media_content_face_detected_value]
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [PostMediaContentFaceDetectedValue] postMediaContentFaceDetectedValue (required):
  Future<Response> postMediaContentFaceDetectedValueWithHttpInfo(PostMediaContentFaceDetectedValue postMediaContentFaceDetectedValue,) async {
    // ignore: prefer_const_declarations
    final path = r'/media_api/media_content_face_detected_value';

    // ignore: prefer_final_locals
    Object? postBody = postMediaContentFaceDetectedValue;

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

  /// Change media content face detected value
  ///
  /// # Access * Permission [model::Permissions::admin_edit_media_content_face_detected_value]
  ///
  /// Parameters:
  ///
  /// * [PostMediaContentFaceDetectedValue] postMediaContentFaceDetectedValue (required):
  Future<void> postMediaContentFaceDetectedValue(PostMediaContentFaceDetectedValue postMediaContentFaceDetectedValue,) async {
    final response = await postMediaContentFaceDetectedValueWithHttpInfo(postMediaContentFaceDetectedValue,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Change media content face verified value
  ///
  /// Bot account sets automatic value and human admin account sets manual override value.  # Access * Permission [model::Permissions::admin_edit_media_content_face_verified_value]
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [PostMediaContentFaceVerifiedValue] postMediaContentFaceVerifiedValue (required):
  Future<Response> postMediaContentFaceVerifiedValueWithHttpInfo(PostMediaContentFaceVerifiedValue postMediaContentFaceVerifiedValue,) async {
    // ignore: prefer_const_declarations
    final path = r'/media_api/media_content_face_verified_value';

    // ignore: prefer_final_locals
    Object? postBody = postMediaContentFaceVerifiedValue;

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

  /// Change media content face verified value
  ///
  /// Bot account sets automatic value and human admin account sets manual override value.  # Access * Permission [model::Permissions::admin_edit_media_content_face_verified_value]
  ///
  /// Parameters:
  ///
  /// * [PostMediaContentFaceVerifiedValue] postMediaContentFaceVerifiedValue (required):
  Future<void> postMediaContentFaceVerifiedValue(PostMediaContentFaceVerifiedValue postMediaContentFaceVerifiedValue,) async {
    final response = await postMediaContentFaceVerifiedValueWithHttpInfo(postMediaContentFaceVerifiedValue,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Rejected category and details can be set only when the content is rejected.
  ///
  /// This route will fail if the content is in slot.  Also profile visibility moves from pending to normal when all profile content is moderated as accepted.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [PostModerateMediaContent] postModerateMediaContent (required):
  Future<Response> postModerateMediaContentWithHttpInfo(PostModerateMediaContent postModerateMediaContent,) async {
    // ignore: prefer_const_declarations
    final path = r'/media_api/moderate_media_content';

    // ignore: prefer_final_locals
    Object? postBody = postModerateMediaContent;

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

  /// Rejected category and details can be set only when the content is rejected.
  ///
  /// This route will fail if the content is in slot.  Also profile visibility moves from pending to normal when all profile content is moderated as accepted.
  ///
  /// Parameters:
  ///
  /// * [PostModerateMediaContent] postModerateMediaContent (required):
  Future<void> postModerateMediaContent(PostModerateMediaContent postModerateMediaContent,) async {
    final response = await postModerateMediaContentWithHttpInfo(postModerateMediaContent,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Change security content verified value
  ///
  /// Bot account sets automatic value and human admin account sets manual override value.  # Access * Permission [model::Permissions::admin_edit_security_content_verified_value]
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [PostSecurityContentVerifiedValue] postSecurityContentVerifiedValue (required):
  Future<Response> postSecurityContentVerifiedValueWithHttpInfo(PostSecurityContentVerifiedValue postSecurityContentVerifiedValue,) async {
    // ignore: prefer_const_declarations
    final path = r'/media_api/security_content_verified_value';

    // ignore: prefer_final_locals
    Object? postBody = postSecurityContentVerifiedValue;

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

  /// Change security content verified value
  ///
  /// Bot account sets automatic value and human admin account sets manual override value.  # Access * Permission [model::Permissions::admin_edit_security_content_verified_value]
  ///
  /// Parameters:
  ///
  /// * [PostSecurityContentVerifiedValue] postSecurityContentVerifiedValue (required):
  Future<void> postSecurityContentVerifiedValue(PostSecurityContentVerifiedValue postSecurityContentVerifiedValue,) async {
    final response = await postSecurityContentVerifiedValueWithHttpInfo(postSecurityContentVerifiedValue,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}
