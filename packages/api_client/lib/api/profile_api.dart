//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class ProfileApi {
  ProfileApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Delete favorite profile
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [AccountId] accountId (required):
  Future<Response> deleteFavoriteProfileWithHttpInfo(AccountId accountId,) async {
    // ignore: prefer_const_declarations
    final path = r'/profile_api/favorite_profile';

    // ignore: prefer_final_locals
    Object? postBody = accountId;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


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

  /// Delete favorite profile
  ///
  /// Parameters:
  ///
  /// * [AccountId] accountId (required):
  Future<void> deleteFavoriteProfile(AccountId accountId,) async {
    final response = await deleteFavoriteProfileWithHttpInfo(accountId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'GET /profile_api/automatic_profile_search_settings' operation and returns the [Response].
  Future<Response> getAutomaticProfileSearchSettingsWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/profile_api/automatic_profile_search_settings';

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

  Future<AutomaticProfileSearchSettings?> getAutomaticProfileSearchSettings() async {
    final response = await getAutomaticProfileSearchSettingsWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'AutomaticProfileSearchSettings',) as AutomaticProfileSearchSettings;
    
    }
    return null;
  }

  /// Get list of all favorite profiles.
  ///
  /// First item is the oldest favorite (ordered using UnixTime and account ID).
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getFavoriteProfilesWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/profile_api/favorite_profiles';

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

  /// Get list of all favorite profiles.
  ///
  /// First item is the oldest favorite (ordered using UnixTime and account ID).
  Future<FavoriteProfilesPage?> getFavoriteProfiles() async {
    final response = await getFavoriteProfilesWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'FavoriteProfilesPage',) as FavoriteProfilesPage;
    
    }
    return null;
  }

  /// Get initial profile age which can be used for calculating current accepted profile ages.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getInitialProfileAgeWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/profile_api/initial_profile_age';

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

  /// Get initial profile age which can be used for calculating current accepted profile ages.
  Future<GetInitialProfileAgeResult?> getInitialProfileAge() async {
    final response = await getInitialProfileAgeWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'GetInitialProfileAgeResult',) as GetInitialProfileAgeResult;
    
    }
    return null;
  }

  /// Get location for account which makes this request.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getLocationWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/profile_api/location';

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

  /// Get location for account which makes this request.
  Future<Location?> getLocation() async {
    final response = await getLocationWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Location',) as Location;
    
    }
    return null;
  }

  /// Get my profile
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getMyProfileWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/profile_api/my_profile';

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

  /// Get my profile
  Future<GetMyProfileResult?> getMyProfile() async {
    final response = await getMyProfileWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'GetMyProfileResult',) as GetMyProfileResult;
    
    }
    return null;
  }

  /// Get account's current profile.
  ///
  /// Response includes version UUID which can be used for caching.  # Access  ## Own profile Unrestricted access.  ## Public other profiles Normal account state required.  ## Private other profiles If the profile is a match, then the profile can be accessed if query parameter `is_match` is set to `true`.  If the profile is not a match, then permission `admin_view_all_profiles` is required.  
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  ///
  /// * [String] v:
  ///   Profile version UUID
  ///
  /// * [bool] isMatch:
  ///   If requested profile is not public, allow getting the profile data if the requested profile is a match.
  Future<Response> getProfileWithHttpInfo(String aid, { String? v, bool? isMatch, }) async {
    // ignore: prefer_const_declarations
    final path = r'/profile_api/profile/{aid}'
      .replaceAll('{aid}', aid);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (v != null) {
      queryParams.addAll(_queryParams('', 'v', v));
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

  /// Get account's current profile.
  ///
  /// Response includes version UUID which can be used for caching.  # Access  ## Own profile Unrestricted access.  ## Public other profiles Normal account state required.  ## Private other profiles If the profile is a match, then the profile can be accessed if query parameter `is_match` is set to `true`.  If the profile is not a match, then permission `admin_view_all_profiles` is required.  
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  ///
  /// * [String] v:
  ///   Profile version UUID
  ///
  /// * [bool] isMatch:
  ///   If requested profile is not public, allow getting the profile data if the requested profile is a match.
  Future<GetProfileResult?> getProfile(String aid, { String? v, bool? isMatch, }) async {
    final response = await getProfileWithHttpInfo(aid,  v: v, isMatch: isMatch, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'GetProfileResult',) as GetProfileResult;
    
    }
    return null;
  }

  /// Performs an HTTP 'GET /profile_api/get_profile_app_notification_settings' operation and returns the [Response].
  Future<Response> getProfileAppNotificationSettingsWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/profile_api/get_profile_app_notification_settings';

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

  Future<ProfileAppNotificationSettings?> getProfileAppNotificationSettings() async {
    final response = await getProfileAppNotificationSettingsWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ProfileAppNotificationSettings',) as ProfileAppNotificationSettings;
    
    }
    return null;
  }

  /// Get current profile filters.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getProfileFiltersWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/profile_api/profile_filters';

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

  /// Get current profile filters.
  Future<GetProfileFilters?> getProfileFilters() async {
    final response = await getProfileFiltersWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'GetProfileFilters',) as GetProfileFilters;
    
    }
    return null;
  }

  /// Get account's current profile from database. Debug mode must be enabled that route can be used.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  Future<Response> getProfileFromDatabaseDebugModeBenchmarkWithHttpInfo(String aid,) async {
    // ignore: prefer_const_declarations
    final path = r'/profile_api/benchmark/profile/{aid}'
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

  /// Get account's current profile from database. Debug mode must be enabled that route can be used.
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  Future<Profile?> getProfileFromDatabaseDebugModeBenchmark(String aid,) async {
    final response = await getProfileFromDatabaseDebugModeBenchmarkWithHttpInfo(aid,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Profile',) as Profile;
    
    }
    return null;
  }

  /// Non default values for [model::GetProfileStatisticsParams] requires [model::Permissions::admin_profile_statistics].
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [StatisticsProfileVisibility] profileVisibility:
  ///   Control which profiles are included in [GetProfileStatisticsResult::age_counts] by profile visibility.  Non default value is only for admins.
  ///
  /// * [bool] generateNewStatistics:
  ///   Non default value is only for admins.
  Future<Response> getProfileStatisticsWithHttpInfo({ StatisticsProfileVisibility? profileVisibility, bool? generateNewStatistics, }) async {
    // ignore: prefer_const_declarations
    final path = r'/profile_api/profile_statistics';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (profileVisibility != null) {
      queryParams.addAll(_queryParams('', 'profile_visibility', profileVisibility));
    }
    if (generateNewStatistics != null) {
      queryParams.addAll(_queryParams('', 'generate_new_statistics', generateNewStatistics));
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

  /// Non default values for [model::GetProfileStatisticsParams] requires [model::Permissions::admin_profile_statistics].
  ///
  /// Parameters:
  ///
  /// * [StatisticsProfileVisibility] profileVisibility:
  ///   Control which profiles are included in [GetProfileStatisticsResult::age_counts] by profile visibility.  Non default value is only for admins.
  ///
  /// * [bool] generateNewStatistics:
  ///   Non default value is only for admins.
  Future<GetProfileStatisticsResult?> getProfileStatistics({ StatisticsProfileVisibility? profileVisibility, bool? generateNewStatistics, }) async {
    final response = await getProfileStatisticsWithHttpInfo( profileVisibility: profileVisibility, generateNewStatistics: generateNewStatistics, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'GetProfileStatisticsResult',) as GetProfileStatisticsResult;
    
    }
    return null;
  }

  /// Get account's current search age range
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getSearchAgeRangeWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/profile_api/search_age_range';

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

  /// Get account's current search age range
  Future<SearchAgeRange?> getSearchAgeRange() async {
    final response = await getSearchAgeRangeWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'SearchAgeRange',) as SearchAgeRange;
    
    }
    return null;
  }

  /// Get account's current search groups (gender and what gender user is looking for)
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getSearchGroupsWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/profile_api/search_groups';

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

  /// Get account's current search groups (gender and what gender user is looking for)
  Future<SearchGroups?> getSearchGroups() async {
    final response = await getSearchGroupsWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'SearchGroups',) as SearchGroups;
    
    }
    return null;
  }

  /// Post (updates iterator) to get next page of automatic profile search profile list.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [AutomaticProfileSearchIteratorSessionId] automaticProfileSearchIteratorSessionId (required):
  Future<Response> postAutomaticProfileSearchGetNextProfilePageWithHttpInfo(AutomaticProfileSearchIteratorSessionId automaticProfileSearchIteratorSessionId,) async {
    // ignore: prefer_const_declarations
    final path = r'/profile_api/automatic_profile_search/next';

    // ignore: prefer_final_locals
    Object? postBody = automaticProfileSearchIteratorSessionId;

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

  /// Post (updates iterator) to get next page of automatic profile search profile list.
  ///
  /// Parameters:
  ///
  /// * [AutomaticProfileSearchIteratorSessionId] automaticProfileSearchIteratorSessionId (required):
  Future<ProfilePage?> postAutomaticProfileSearchGetNextProfilePage(AutomaticProfileSearchIteratorSessionId automaticProfileSearchIteratorSessionId,) async {
    final response = await postAutomaticProfileSearchGetNextProfilePageWithHttpInfo(automaticProfileSearchIteratorSessionId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ProfilePage',) as ProfilePage;
    
    }
    return null;
  }

  /// Reset automatic profile search profile paging.
  ///
  /// After this request getting next profiles will continue from the nearest profiles.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> postAutomaticProfileSearchResetProfilePagingWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/profile_api/automatic_profile_search/reset';

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

  /// Reset automatic profile search profile paging.
  ///
  /// After this request getting next profiles will continue from the nearest profiles.
  Future<AutomaticProfileSearchIteratorSessionId?> postAutomaticProfileSearchResetProfilePaging() async {
    final response = await postAutomaticProfileSearchResetProfilePagingWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'AutomaticProfileSearchIteratorSessionId',) as AutomaticProfileSearchIteratorSessionId;
    
    }
    return null;
  }

  /// Performs an HTTP 'POST /profile_api/automatic_profile_search_settings' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [AutomaticProfileSearchSettings] automaticProfileSearchSettings (required):
  Future<Response> postAutomaticProfileSearchSettingsWithHttpInfo(AutomaticProfileSearchSettings automaticProfileSearchSettings,) async {
    // ignore: prefer_const_declarations
    final path = r'/profile_api/automatic_profile_search_settings';

    // ignore: prefer_final_locals
    Object? postBody = automaticProfileSearchSettings;

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
  /// * [AutomaticProfileSearchSettings] automaticProfileSearchSettings (required):
  Future<void> postAutomaticProfileSearchSettings(AutomaticProfileSearchSettings automaticProfileSearchSettings,) async {
    final response = await postAutomaticProfileSearchSettingsWithHttpInfo(automaticProfileSearchSettings,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Add new favorite profile
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [AccountId] accountId (required):
  Future<Response> postFavoriteProfileWithHttpInfo(AccountId accountId,) async {
    // ignore: prefer_const_declarations
    final path = r'/profile_api/favorite_profile';

    // ignore: prefer_final_locals
    Object? postBody = accountId;

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

  /// Add new favorite profile
  ///
  /// Parameters:
  ///
  /// * [AccountId] accountId (required):
  Future<void> postFavoriteProfile(AccountId accountId,) async {
    final response = await postFavoriteProfileWithHttpInfo(accountId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /profile_api/automatic_profile_search_completed_notification' operation and returns the [Response].
  Future<Response> postGetAutomaticProfileSearchCompletedNotificationWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/profile_api/automatic_profile_search_completed_notification';

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

  Future<AutomaticProfileSearchCompletedNotification?> postGetAutomaticProfileSearchCompletedNotification() async {
    final response = await postGetAutomaticProfileSearchCompletedNotificationWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'AutomaticProfileSearchCompletedNotification',) as AutomaticProfileSearchCompletedNotification;
    
    }
    return null;
  }

  /// Post (updates iterator) to get next page of profile list.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [ProfileIteratorSessionId] profileIteratorSessionId (required):
  Future<Response> postGetNextProfilePageWithHttpInfo(ProfileIteratorSessionId profileIteratorSessionId,) async {
    // ignore: prefer_const_declarations
    final path = r'/profile_api/page/next';

    // ignore: prefer_final_locals
    Object? postBody = profileIteratorSessionId;

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

  /// Post (updates iterator) to get next page of profile list.
  ///
  /// Parameters:
  ///
  /// * [ProfileIteratorSessionId] profileIteratorSessionId (required):
  Future<ProfilePage?> postGetNextProfilePage(ProfileIteratorSessionId profileIteratorSessionId,) async {
    final response = await postGetNextProfilePageWithHttpInfo(profileIteratorSessionId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ProfilePage',) as ProfilePage;
    
    }
    return null;
  }

  /// Get profile string moderation completed notification.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> postGetProfileStringModerationCompletedNotificationWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/profile_api/profile_string_moderation_completed_notification';

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

  /// Get profile string moderation completed notification.
  Future<ProfileStringModerationCompletedNotification?> postGetProfileStringModerationCompletedNotification() async {
    final response = await postGetProfileStringModerationCompletedNotificationWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ProfileStringModerationCompletedNotification',) as ProfileStringModerationCompletedNotification;
    
    }
    return null;
  }

  /// Query profile attributes from profile attributes config using profile attribute ID list.
  ///
  /// The HTTP method is POST because HTTP GET does not allow request body.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [ProfileAttributesConfigQuery] profileAttributesConfigQuery (required):
  Future<Response> postGetQueryProfileAttributesConfigWithHttpInfo(ProfileAttributesConfigQuery profileAttributesConfigQuery,) async {
    // ignore: prefer_const_declarations
    final path = r'/profile_api/query_profile_attributes_config';

    // ignore: prefer_final_locals
    Object? postBody = profileAttributesConfigQuery;

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

  /// Query profile attributes from profile attributes config using profile attribute ID list.
  ///
  /// The HTTP method is POST because HTTP GET does not allow request body.
  ///
  /// Parameters:
  ///
  /// * [ProfileAttributesConfigQuery] profileAttributesConfigQuery (required):
  Future<ProfileAttributesConfigQueryResult?> postGetQueryProfileAttributesConfig(ProfileAttributesConfigQuery profileAttributesConfigQuery,) async {
    final response = await postGetQueryProfileAttributesConfigWithHttpInfo(profileAttributesConfigQuery,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ProfileAttributesConfigQueryResult',) as ProfileAttributesConfigQueryResult;
    
    }
    return null;
  }

  /// The viewed values must be updated to prevent WebSocket code from sending unnecessary event about new notification.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [AutomaticProfileSearchCompletedNotificationViewed] automaticProfileSearchCompletedNotificationViewed (required):
  Future<Response> postMarkAutomaticProfileSearchCompletedNotificationViewedWithHttpInfo(AutomaticProfileSearchCompletedNotificationViewed automaticProfileSearchCompletedNotificationViewed,) async {
    // ignore: prefer_const_declarations
    final path = r'/profile_api/mark_automatic_profile_search_completed_notification_viewed';

    // ignore: prefer_final_locals
    Object? postBody = automaticProfileSearchCompletedNotificationViewed;

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

  /// The viewed values must be updated to prevent WebSocket code from sending unnecessary event about new notification.
  ///
  /// Parameters:
  ///
  /// * [AutomaticProfileSearchCompletedNotificationViewed] automaticProfileSearchCompletedNotificationViewed (required):
  Future<void> postMarkAutomaticProfileSearchCompletedNotificationViewed(AutomaticProfileSearchCompletedNotificationViewed automaticProfileSearchCompletedNotificationViewed,) async {
    final response = await postMarkAutomaticProfileSearchCompletedNotificationViewedWithHttpInfo(automaticProfileSearchCompletedNotificationViewed,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// The viewed values must be updated to prevent WebSocket code from sending unnecessary event about new notification.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [ProfileStringModerationCompletedNotificationViewed] profileStringModerationCompletedNotificationViewed (required):
  Future<Response> postMarkProfileStringModerationCompletedNotificationViewedWithHttpInfo(ProfileStringModerationCompletedNotificationViewed profileStringModerationCompletedNotificationViewed,) async {
    // ignore: prefer_const_declarations
    final path = r'/profile_api/mark_profile_string_moderation_completed_notification_viewed';

    // ignore: prefer_final_locals
    Object? postBody = profileStringModerationCompletedNotificationViewed;

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

  /// The viewed values must be updated to prevent WebSocket code from sending unnecessary event about new notification.
  ///
  /// Parameters:
  ///
  /// * [ProfileStringModerationCompletedNotificationViewed] profileStringModerationCompletedNotificationViewed (required):
  Future<void> postMarkProfileStringModerationCompletedNotificationViewed(ProfileStringModerationCompletedNotificationViewed profileStringModerationCompletedNotificationViewed,) async {
    final response = await postMarkProfileStringModerationCompletedNotificationViewedWithHttpInfo(profileStringModerationCompletedNotificationViewed,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Update profile information.
  ///
  /// Writes the profile to the database only if it is changed.  WebSocket event about profile change will not be emitted. The event is emitted only from server side profile updates.  # Requirements - Profile attributes must be valid. - Profile text must be 2000 bytes or less. - Profile text must be trimmed. - Profile name changes are only possible when initial setup is ongoing   or current profile name is not accepted. - Profile name must be trimmed and not empty. - Profile name must be 100 bytes or less. - Profile name must start with uppercase letter. - Profile name must match with profile name regex if it is enabled and   related account is not a bot account. - Profile age must match with currently valid age range. The first min   value for the age range is the age at the initial setup. The second min   and max value is calculated using the following algorithm:  - The initial age (initialAge) is paired with the year of initial    setup completed (initialSetupYear).    - Year difference (yearDifference = currentYear - initialSetupYear) is      used for changing the range min and max.      - Min value: initialAge + yearDifference - 1.      - Max value: initialAge + yearDifference + 1.  
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [ProfileUpdate] profileUpdate (required):
  Future<Response> postProfileWithHttpInfo(ProfileUpdate profileUpdate,) async {
    // ignore: prefer_const_declarations
    final path = r'/profile_api/profile';

    // ignore: prefer_final_locals
    Object? postBody = profileUpdate;

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

  /// Update profile information.
  ///
  /// Writes the profile to the database only if it is changed.  WebSocket event about profile change will not be emitted. The event is emitted only from server side profile updates.  # Requirements - Profile attributes must be valid. - Profile text must be 2000 bytes or less. - Profile text must be trimmed. - Profile name changes are only possible when initial setup is ongoing   or current profile name is not accepted. - Profile name must be trimmed and not empty. - Profile name must be 100 bytes or less. - Profile name must start with uppercase letter. - Profile name must match with profile name regex if it is enabled and   related account is not a bot account. - Profile age must match with currently valid age range. The first min   value for the age range is the age at the initial setup. The second min   and max value is calculated using the following algorithm:  - The initial age (initialAge) is paired with the year of initial    setup completed (initialSetupYear).    - Year difference (yearDifference = currentYear - initialSetupYear) is      used for changing the range min and max.      - Min value: initialAge + yearDifference - 1.      - Max value: initialAge + yearDifference + 1.  
  ///
  /// Parameters:
  ///
  /// * [ProfileUpdate] profileUpdate (required):
  Future<void> postProfile(ProfileUpdate profileUpdate,) async {
    final response = await postProfileWithHttpInfo(profileUpdate,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /profile_api/post_profile_app_notification_settings' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ProfileAppNotificationSettings] profileAppNotificationSettings (required):
  Future<Response> postProfileAppNotificationSettingsWithHttpInfo(ProfileAppNotificationSettings profileAppNotificationSettings,) async {
    // ignore: prefer_const_declarations
    final path = r'/profile_api/post_profile_app_notification_settings';

    // ignore: prefer_final_locals
    Object? postBody = profileAppNotificationSettings;

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
  /// * [ProfileAppNotificationSettings] profileAppNotificationSettings (required):
  Future<void> postProfileAppNotificationSettings(ProfileAppNotificationSettings profileAppNotificationSettings,) async {
    final response = await postProfileAppNotificationSettingsWithHttpInfo(profileAppNotificationSettings,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Set profile filters.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [ProfileFiltersUpdate] profileFiltersUpdate (required):
  Future<Response> postProfileFiltersWithHttpInfo(ProfileFiltersUpdate profileFiltersUpdate,) async {
    // ignore: prefer_const_declarations
    final path = r'/profile_api/profile_filters';

    // ignore: prefer_final_locals
    Object? postBody = profileFiltersUpdate;

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

  /// Set profile filters.
  ///
  /// Parameters:
  ///
  /// * [ProfileFiltersUpdate] profileFiltersUpdate (required):
  Future<void> postProfileFilters(ProfileFiltersUpdate profileFiltersUpdate,) async {
    final response = await postProfileFiltersWithHttpInfo(profileFiltersUpdate,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Post account's current profile directly to database. Debug mode must be enabled that route can be used.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [ProfileUpdate] profileUpdate (required):
  Future<Response> postProfileToDatabaseDebugModeBenchmarkWithHttpInfo(ProfileUpdate profileUpdate,) async {
    // ignore: prefer_const_declarations
    final path = r'/profile_api/benchmark/profile';

    // ignore: prefer_final_locals
    Object? postBody = profileUpdate;

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

  /// Post account's current profile directly to database. Debug mode must be enabled that route can be used.
  ///
  /// Parameters:
  ///
  /// * [ProfileUpdate] profileUpdate (required):
  Future<void> postProfileToDatabaseDebugModeBenchmark(ProfileUpdate profileUpdate,) async {
    final response = await postProfileToDatabaseDebugModeBenchmarkWithHttpInfo(profileUpdate,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Report profile name
  ///
  /// If profile name is reported and it is bot moderated, the name's moderation state changes to [model_profile::ProfileStringModerationState::WaitingHumanModeration].
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [UpdateProfileNameReport] updateProfileNameReport (required):
  Future<Response> postReportProfileNameWithHttpInfo(UpdateProfileNameReport updateProfileNameReport,) async {
    // ignore: prefer_const_declarations
    final path = r'/profile_api/report_profile_name';

    // ignore: prefer_final_locals
    Object? postBody = updateProfileNameReport;

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

  /// Report profile name
  ///
  /// If profile name is reported and it is bot moderated, the name's moderation state changes to [model_profile::ProfileStringModerationState::WaitingHumanModeration].
  ///
  /// Parameters:
  ///
  /// * [UpdateProfileNameReport] updateProfileNameReport (required):
  Future<UpdateReportResult?> postReportProfileName(UpdateProfileNameReport updateProfileNameReport,) async {
    final response = await postReportProfileNameWithHttpInfo(updateProfileNameReport,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'UpdateReportResult',) as UpdateReportResult;
    
    }
    return null;
  }

  /// Report profile text
  ///
  /// If profile text is reported and it is bot moderated, the text's moderation state changes to [model_profile::ProfileStringModerationState::WaitingHumanModeration].
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [UpdateProfileTextReport] updateProfileTextReport (required):
  Future<Response> postReportProfileTextWithHttpInfo(UpdateProfileTextReport updateProfileTextReport,) async {
    // ignore: prefer_const_declarations
    final path = r'/profile_api/report_profile_text';

    // ignore: prefer_final_locals
    Object? postBody = updateProfileTextReport;

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

  /// Report profile text
  ///
  /// If profile text is reported and it is bot moderated, the text's moderation state changes to [model_profile::ProfileStringModerationState::WaitingHumanModeration].
  ///
  /// Parameters:
  ///
  /// * [UpdateProfileTextReport] updateProfileTextReport (required):
  Future<UpdateReportResult?> postReportProfileText(UpdateProfileTextReport updateProfileTextReport,) async {
    final response = await postReportProfileTextWithHttpInfo(updateProfileTextReport,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'UpdateReportResult',) as UpdateReportResult;
    
    }
    return null;
  }

  /// Reset profile paging.
  ///
  /// After this request getting next profiles will continue from the nearest profiles.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> postResetProfilePagingWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/profile_api/page/reset';

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

  /// Reset profile paging.
  ///
  /// After this request getting next profiles will continue from the nearest profiles.
  Future<ProfileIteratorSessionId?> postResetProfilePaging() async {
    final response = await postResetProfilePagingWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ProfileIteratorSessionId',) as ProfileIteratorSessionId;
    
    }
    return null;
  }

  /// Set account's current search age range
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [SearchAgeRange] searchAgeRange (required):
  Future<Response> postSearchAgeRangeWithHttpInfo(SearchAgeRange searchAgeRange,) async {
    // ignore: prefer_const_declarations
    final path = r'/profile_api/search_age_range';

    // ignore: prefer_final_locals
    Object? postBody = searchAgeRange;

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

  /// Set account's current search age range
  ///
  /// Parameters:
  ///
  /// * [SearchAgeRange] searchAgeRange (required):
  Future<void> postSearchAgeRange(SearchAgeRange searchAgeRange,) async {
    final response = await postSearchAgeRangeWithHttpInfo(searchAgeRange,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Set account's current search groups (gender and what gender user is looking for)
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [SearchGroups] searchGroups (required):
  Future<Response> postSearchGroupsWithHttpInfo(SearchGroups searchGroups,) async {
    // ignore: prefer_const_declarations
    final path = r'/profile_api/search_groups';

    // ignore: prefer_final_locals
    Object? postBody = searchGroups;

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

  /// Set account's current search groups (gender and what gender user is looking for)
  ///
  /// Parameters:
  ///
  /// * [SearchGroups] searchGroups (required):
  Future<void> postSearchGroups(SearchGroups searchGroups,) async {
    final response = await postSearchGroupsWithHttpInfo(searchGroups,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Update location for account which makes this request.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [Location] location (required):
  Future<Response> putLocationWithHttpInfo(Location location,) async {
    // ignore: prefer_const_declarations
    final path = r'/profile_api/location';

    // ignore: prefer_final_locals
    Object? postBody = location;

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

  /// Update location for account which makes this request.
  ///
  /// Parameters:
  ///
  /// * [Location] location (required):
  Future<void> putLocation(Location location,) async {
    final response = await putLocationWithHttpInfo(location,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}
