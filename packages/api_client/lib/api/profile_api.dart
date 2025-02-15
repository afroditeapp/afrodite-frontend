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

  /// Get info what profile attributes server supports.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getAvailableProfileAttributesWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/profile_api/available_profile_attributes';

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

  /// Get info what profile attributes server supports.
  Future<AvailableProfileAttributes?> getAvailableProfileAttributes() async {
    final response = await getAvailableProfileAttributesWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'AvailableProfileAttributes',) as AvailableProfileAttributes;
    
    }
    return null;
  }

  /// Get list of all favorite profiles.
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

  /// Get initial profile age information which can be used for calculating current accepted profile ages.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getInitialProfileAgeInfoWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/profile_api/initial_profile_age_info';

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

  /// Get initial profile age information which can be used for calculating current accepted profile ages.
  Future<GetInitialProfileAgeInfoResult?> getInitialProfileAgeInfo() async {
    final response = await getInitialProfileAgeInfoWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'GetInitialProfileAgeInfoResult',) as GetInitialProfileAgeInfoResult;
    
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
  /// Response includes version UUID which can be used for caching.  # Access  ## Own profile Unrestricted access.  ## Public other profiles Normal account state required.  ## Private other profiles If the profile is a match, then the profile can be accessed if query parameter `is_match` is set to `true`.  If the profile is not a match, then permission `admin_view_all_profiles` is required.  # Microservice notes If account feature is set as external service then cached permission information from account service is used for access checks.
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
  /// Response includes version UUID which can be used for caching.  # Access  ## Own profile Unrestricted access.  ## Public other profiles Normal account state required.  ## Private other profiles If the profile is a match, then the profile can be accessed if query parameter `is_match` is set to `true`.  If the profile is not a match, then permission `admin_view_all_profiles` is required.  # Microservice notes If account feature is set as external service then cached permission information from account service is used for access checks.
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

  /// Get current profile filtering settings.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getProfileFilteringSettingsWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/profile_api/profile_filtering_settings';

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

  /// Get current profile filtering settings.
  Future<GetProfileFilteringSettings?> getProfileFilteringSettings() async {
    final response = await getProfileFilteringSettingsWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'GetProfileFilteringSettings',) as GetProfileFilteringSettings;
    
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
  Future<ProfileSearchAgeRange?> getSearchAgeRange() async {
    final response = await getSearchAgeRangeWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ProfileSearchAgeRange',) as ProfileSearchAgeRange;
    
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

  /// Query profile attributes using attribute ID list.
  ///
  /// The HTTP method is POST because HTTP GET does not allow request body.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [ProfileAttributeQuery] profileAttributeQuery (required):
  Future<Response> postGetQueryAvailableProfileAttributesWithHttpInfo(ProfileAttributeQuery profileAttributeQuery,) async {
    // ignore: prefer_const_declarations
    final path = r'/profile_api/query_available_profile_attributes';

    // ignore: prefer_final_locals
    Object? postBody = profileAttributeQuery;

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

  /// Query profile attributes using attribute ID list.
  ///
  /// The HTTP method is POST because HTTP GET does not allow request body.
  ///
  /// Parameters:
  ///
  /// * [ProfileAttributeQuery] profileAttributeQuery (required):
  Future<ProfileAttributeQueryResult?> postGetQueryAvailableProfileAttributes(ProfileAttributeQuery profileAttributeQuery,) async {
    final response = await postGetQueryAvailableProfileAttributesWithHttpInfo(profileAttributeQuery,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ProfileAttributeQueryResult',) as ProfileAttributeQueryResult;
    
    }
    return null;
  }

  /// Update profile information.
  ///
  /// Writes the profile to the database only if it is changed.  WebSocket event about profile change will not be emitted. The event is emitted only from server side profile updates.  # Requirements - Profile attributes must be valid. - Profile text must be 2000 bytes or less. - Profile text must be trimmed. - Profile name changes are only possible when initial setup is ongoing. - Profile name must be trimmed and not empty. - Profile name must be 100 bytes or less. - Profile age must match with currently valid age range. The first min   value for the age range is the age at the initial setup. The second min   and max value is calculated using the following algorithm:  - The initial age (initialAge) is paired with the year of initial    setup completed (initialSetupYear).    - Year difference (yearDifference = currentYear - initialSetupYear) is      used for changing the range min and max.      - Min value: initialAge + yearDifference - 1.      - Max value: initialAge + yearDifference + 1.  TODO: string lenght validation, limit saving new profiles TODO: return the new proifle. Edit: is this really needed?
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
  /// Writes the profile to the database only if it is changed.  WebSocket event about profile change will not be emitted. The event is emitted only from server side profile updates.  # Requirements - Profile attributes must be valid. - Profile text must be 2000 bytes or less. - Profile text must be trimmed. - Profile name changes are only possible when initial setup is ongoing. - Profile name must be trimmed and not empty. - Profile name must be 100 bytes or less. - Profile age must match with currently valid age range. The first min   value for the age range is the age at the initial setup. The second min   and max value is calculated using the following algorithm:  - The initial age (initialAge) is paired with the year of initial    setup completed (initialSetupYear).    - Year difference (yearDifference = currentYear - initialSetupYear) is      used for changing the range min and max.      - Min value: initialAge + yearDifference - 1.      - Max value: initialAge + yearDifference + 1.  TODO: string lenght validation, limit saving new profiles TODO: return the new proifle. Edit: is this really needed?
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

  /// Set profile filtering settings.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [ProfileFilteringSettingsUpdate] profileFilteringSettingsUpdate (required):
  Future<Response> postProfileFilteringSettingsWithHttpInfo(ProfileFilteringSettingsUpdate profileFilteringSettingsUpdate,) async {
    // ignore: prefer_const_declarations
    final path = r'/profile_api/profile_filtering_settings';

    // ignore: prefer_final_locals
    Object? postBody = profileFilteringSettingsUpdate;

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

  /// Set profile filtering settings.
  ///
  /// Parameters:
  ///
  /// * [ProfileFilteringSettingsUpdate] profileFilteringSettingsUpdate (required):
  Future<void> postProfileFilteringSettings(ProfileFilteringSettingsUpdate profileFilteringSettingsUpdate,) async {
    final response = await postProfileFilteringSettingsWithHttpInfo(profileFilteringSettingsUpdate,);
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
  /// If profile text is reported and it is bot moderated, the text's moderation state changes to [model_profile::ProfileTextModerationState::WaitingHumanModeration].
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
  /// If profile text is reported and it is bot moderated, the text's moderation state changes to [model_profile::ProfileTextModerationState::WaitingHumanModeration].
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
  /// * [ProfileSearchAgeRange] profileSearchAgeRange (required):
  Future<Response> postSearchAgeRangeWithHttpInfo(ProfileSearchAgeRange profileSearchAgeRange,) async {
    // ignore: prefer_const_declarations
    final path = r'/profile_api/search_age_range';

    // ignore: prefer_final_locals
    Object? postBody = profileSearchAgeRange;

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
  /// * [ProfileSearchAgeRange] profileSearchAgeRange (required):
  Future<void> postSearchAgeRange(ProfileSearchAgeRange profileSearchAgeRange,) async {
    final response = await postSearchAgeRangeWithHttpInfo(profileSearchAgeRange,);
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
