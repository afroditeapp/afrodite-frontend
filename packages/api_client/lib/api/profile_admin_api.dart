//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class ProfileAdminApi {
  ProfileAdminApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Get admin profile iterator page
  ///
  /// # Access - Permission [model::Permissions::admin_view_all_profiles]
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] startPosition (required):
  ///
  /// * [int] page (required):
  Future<Response> getAdminProfileIteratorPageWithHttpInfo(int startPosition, int page,) async {
    // ignore: prefer_const_declarations
    final path = r'/profile_api/get_admin_profile_iterator_page';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'start_position', startPosition));
      queryParams.addAll(_queryParams('', 'page', page));

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

  /// Get admin profile iterator page
  ///
  /// # Access - Permission [model::Permissions::admin_view_all_profiles]
  ///
  /// Parameters:
  ///
  /// * [int] startPosition (required):
  ///
  /// * [int] page (required):
  Future<ProfileIteratorPage?> getAdminProfileIteratorPage(int startPosition, int page,) async {
    final response = await getAdminProfileIteratorPageWithHttpInfo(startPosition, page,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ProfileIteratorPage',) as ProfileIteratorPage;
    
    }
    return null;
  }

  /// Get latest created account ID DB
  ///
  /// # Access - Permission [model::Permissions::admin_view_all_profiles]
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getLatestCreatedAccountIdDbWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/profile_api/get_latest_created_account_id_db';

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

  /// Get latest created account ID DB
  ///
  /// # Access - Permission [model::Permissions::admin_view_all_profiles]
  Future<AccountIdDbValue?> getLatestCreatedAccountIdDb() async {
    final response = await getLatestCreatedAccountIdDbWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'AccountIdDbValue',) as AccountIdDbValue;
    
    }
    return null;
  }

  /// Get profile age and name
  ///
  /// # Access - Permission [model::Permissions::admin_edit_profile_name] - Permission [model::Permissions::admin_find_account_by_email] - Permission [model::Permissions::admin_view_permissions] - Permission [model::Permissions::admin_moderate_media_content] - Permission [model::Permissions::admin_moderate_profile_names] - Permission [model::Permissions::admin_moderate_profile_texts]
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  Future<Response> getProfileAgeAndNameWithHttpInfo(String aid,) async {
    // ignore: prefer_const_declarations
    final path = r'/profile_api/get_profile_age_and_name/{aid}'
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

  /// Get profile age and name
  ///
  /// # Access - Permission [model::Permissions::admin_edit_profile_name] - Permission [model::Permissions::admin_find_account_by_email] - Permission [model::Permissions::admin_view_permissions] - Permission [model::Permissions::admin_moderate_media_content] - Permission [model::Permissions::admin_moderate_profile_names] - Permission [model::Permissions::admin_moderate_profile_texts]
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  Future<GetProfileAgeAndName?> getProfileAgeAndName(String aid,) async {
    final response = await getProfileAgeAndNameWithHttpInfo(aid,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'GetProfileAgeAndName',) as GetProfileAgeAndName;
    
    }
    return null;
  }

  /// Performs an HTTP 'GET /profile_api/profile_statistics_history' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ProfileStatisticsHistoryValueType] valueType (required):
  ///
  /// * [int] age:
  ///   Required only for AgeChange history
  Future<Response> getProfileStatisticsHistoryWithHttpInfo(ProfileStatisticsHistoryValueType valueType, { int? age, }) async {
    // ignore: prefer_const_declarations
    final path = r'/profile_api/profile_statistics_history';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'value_type', valueType));
    if (age != null) {
      queryParams.addAll(_queryParams('', 'age', age));
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

  /// Parameters:
  ///
  /// * [ProfileStatisticsHistoryValueType] valueType (required):
  ///
  /// * [int] age:
  ///   Required only for AgeChange history
  Future<GetProfileStatisticsHistoryResult?> getProfileStatisticsHistory(ProfileStatisticsHistoryValueType valueType, { int? age, }) async {
    final response = await getProfileStatisticsHistoryWithHttpInfo(valueType,  age: age, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'GetProfileStatisticsHistoryResult',) as GetProfileStatisticsHistoryResult;
    
    }
    return null;
  }

  /// Get first page of pending profile string moderations. Oldest item is first and count 25.
  ///
  /// # Access * [Permissions::admin_moderate_profile_names] or   [Permissions::admin_moderate_profile_texts] depending   on [GetProfilePendingModerationParams::content_type].
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [ProfileStringModerationContentType] contentType (required):
  ///
  /// * [bool] showValuesWhichBotsCanModerate (required):
  Future<Response> getProfileStringPendingModerationListWithHttpInfo(ProfileStringModerationContentType contentType, bool showValuesWhichBotsCanModerate,) async {
    // ignore: prefer_const_declarations
    final path = r'/profile_api/profile_string_pending_moderation';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'content_type', contentType));
      queryParams.addAll(_queryParams('', 'show_values_which_bots_can_moderate', showValuesWhichBotsCanModerate));

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

  /// Get first page of pending profile string moderations. Oldest item is first and count 25.
  ///
  /// # Access * [Permissions::admin_moderate_profile_names] or   [Permissions::admin_moderate_profile_texts] depending   on [GetProfilePendingModerationParams::content_type].
  ///
  /// Parameters:
  ///
  /// * [ProfileStringModerationContentType] contentType (required):
  ///
  /// * [bool] showValuesWhichBotsCanModerate (required):
  Future<GetProfileStringPendingModerationList?> getProfileStringPendingModerationList(ProfileStringModerationContentType contentType, bool showValuesWhichBotsCanModerate,) async {
    final response = await getProfileStringPendingModerationListWithHttpInfo(contentType, showValuesWhichBotsCanModerate,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'GetProfileStringPendingModerationList',) as GetProfileStringPendingModerationList;
    
    }
    return null;
  }

  /// Get profile string state
  ///
  /// # Access * [Permissions::admin_moderate_profile_names] or   [Permissions::admin_moderate_profile_texts] depending   on [GetProfileStringStateParams::content_type].
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [ProfileStringModerationContentType] contentType (required):
  ///
  /// * [String] aid (required):
  Future<Response> getProfileStringStateWithHttpInfo(ProfileStringModerationContentType contentType, String aid,) async {
    // ignore: prefer_const_declarations
    final path = r'/profile_api/get_profile_string_state/{aid}'
      .replaceAll('{aid}', aid);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'content_type', contentType));

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

  /// Get profile string state
  ///
  /// # Access * [Permissions::admin_moderate_profile_names] or   [Permissions::admin_moderate_profile_texts] depending   on [GetProfileStringStateParams::content_type].
  ///
  /// Parameters:
  ///
  /// * [ProfileStringModerationContentType] contentType (required):
  ///
  /// * [String] aid (required):
  Future<GetProfileStringState?> getProfileStringState(ProfileStringModerationContentType contentType, String aid,) async {
    final response = await getProfileStringStateWithHttpInfo(contentType, aid,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'GetProfileStringState',) as GetProfileStringState;
    
    }
    return null;
  }

  /// Rejected category and details can be set only when [PostModerateProfileString::value] is rejected.
  ///
  /// This route will fail if the users's profile name/text is empty or it is not the same name/text that was moderated.  # Access * [Permissions::admin_moderate_profile_names] or   [Permissions::admin_moderate_profile_texts] depending   on [PostModerateProfileString::content_type].
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [PostModerateProfileString] postModerateProfileString (required):
  Future<Response> postModerateProfileStringWithHttpInfo(PostModerateProfileString postModerateProfileString,) async {
    // ignore: prefer_const_declarations
    final path = r'/profile_api/moderate_profile_string';

    // ignore: prefer_final_locals
    Object? postBody = postModerateProfileString;

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

  /// Rejected category and details can be set only when [PostModerateProfileString::value] is rejected.
  ///
  /// This route will fail if the users's profile name/text is empty or it is not the same name/text that was moderated.  # Access * [Permissions::admin_moderate_profile_names] or   [Permissions::admin_moderate_profile_texts] depending   on [PostModerateProfileString::content_type].
  ///
  /// Parameters:
  ///
  /// * [PostModerateProfileString] postModerateProfileString (required):
  Future<void> postModerateProfileString(PostModerateProfileString postModerateProfileString,) async {
    final response = await postModerateProfileStringWithHttpInfo(postModerateProfileString,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Set profile name
  ///
  /// The new name has the same requirements as in [crate::profile::post_profile] route documentation.  # Access - Permission [model::Permissions::admin_edit_profile_name]
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [SetProfileName] setProfileName (required):
  Future<Response> postSetProfileNameWithHttpInfo(SetProfileName setProfileName,) async {
    // ignore: prefer_const_declarations
    final path = r'/profile_api/set_profile_name';

    // ignore: prefer_final_locals
    Object? postBody = setProfileName;

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

  /// Set profile name
  ///
  /// The new name has the same requirements as in [crate::profile::post_profile] route documentation.  # Access - Permission [model::Permissions::admin_edit_profile_name]
  ///
  /// Parameters:
  ///
  /// * [SetProfileName] setProfileName (required):
  Future<void> postSetProfileName(SetProfileName setProfileName,) async {
    final response = await postSetProfileNameWithHttpInfo(setProfileName,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}
