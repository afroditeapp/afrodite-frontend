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

  /// Get first page of pending profile content moderations. Oldest item is first and count 25.
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
  Future<Response> getProfileContentPendingModerationListWithHttpInfo(MediaContentType contentType, ModerationQueueType queue, bool showContentWhichBotsCanModerate,) async {
    // ignore: prefer_const_declarations
    final path = r'/media_api/profile_content_pending_moderation';

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

  /// Get first page of pending profile content moderations. Oldest item is first and count 25.
  ///
  /// Parameters:
  ///
  /// * [MediaContentType] contentType (required):
  ///
  /// * [ModerationQueueType] queue (required):
  ///
  /// * [bool] showContentWhichBotsCanModerate (required):
  Future<GetProfileContentPendingModerationList?> getProfileContentPendingModerationList(MediaContentType contentType, ModerationQueueType queue, bool showContentWhichBotsCanModerate,) async {
    final response = await getProfileContentPendingModerationListWithHttpInfo(contentType, queue, showContentWhichBotsCanModerate,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'GetProfileContentPendingModerationList',) as GetProfileContentPendingModerationList;
    
    }
    return null;
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

  /// Rejected category and details can be set only when the content is rejected.
  ///
  /// This route will fail if the content is in slot.  Also profile visibility moves from pending to normal when all profile content is moderated as accepted.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [PostModerateProfileContent] postModerateProfileContent (required):
  Future<Response> postModerateProfileContentWithHttpInfo(PostModerateProfileContent postModerateProfileContent,) async {
    // ignore: prefer_const_declarations
    final path = r'/media_api/moderate_profile_content';

    // ignore: prefer_final_locals
    Object? postBody = postModerateProfileContent;

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
  /// * [PostModerateProfileContent] postModerateProfileContent (required):
  Future<void> postModerateProfileContent(PostModerateProfileContent postModerateProfileContent,) async {
    final response = await postModerateProfileContentWithHttpInfo(postModerateProfileContent,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}
