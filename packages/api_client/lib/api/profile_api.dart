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
    final path = r'/yD1PtVhVvdk-usEran42JmCTFVQ';

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
    final path = r'/_lqy4YCINbw_RCxebKLGXdDq2AM';

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
    final path = r'/Oep5nM7bWqTdRfRoULt-_FTkKJQ';

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
    final path = r'/NWOWjOlm6oTYsXiPsbhBDgknan0';

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
    final path = r'/lf5KMD9dBSVuaVcwjm4TB0d7bfY';

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
    final path = r'/iu25rmmvUzADXhW5SsP_DBGY2_w';

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
  /// Response includes version UUID which can be used for caching.  # Access  ## Own profile Unrestricted access.  ## Public other profiles Normal account state required.  ## Private other profiles If the profile is a match, then the profile can be accessed if query parameter `is_match` is set to `true`.  If the profile is not a match, then capability `admin_view_all_profiles` is required.  # Microservice notes If account feature is set as external service then cached capability information from account service is used for access checks.
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
    final path = r'/5i55ZcY0jIPD7B6pyyridKY0j0Q/{aid}'
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
  /// Response includes version UUID which can be used for caching.  # Access  ## Own profile Unrestricted access.  ## Public other profiles Normal account state required.  ## Private other profiles If the profile is a match, then the profile can be accessed if query parameter `is_match` is set to `true`.  If the profile is not a match, then capability `admin_view_all_profiles` is required.  # Microservice notes If account feature is set as external service then cached capability information from account service is used for access checks.
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

  /// Get current profile attribute filter values.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getProfileAttributeFiltersWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/AL531AoIDRcTSWC-pdxcexf6tOM';

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

  /// Get current profile attribute filter values.
  Future<ProfileAttributeFilterList?> getProfileAttributeFilters() async {
    final response = await getProfileAttributeFiltersWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ProfileAttributeFilterList',) as ProfileAttributeFilterList;
    
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
    final path = r'/XDTSz35S_5tOKIsSpDITOc46MR4/{aid}'
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

  /// Get account's current search age range
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getSearchAgeRangeWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/xTy-zcnl0LQlfPKQalAEnWQQ-rw';

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
    final path = r'/p1KA-sqKKtU3FHvUqYRZnQgj7RQ';

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
    final path = r'/yD1PtVhVvdk-usEran42JmCTFVQ';

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
    final path = r'/_XRgLHtmWtbgW3ZAlgfTH5bs6bE';

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

  /// Update profile information.
  ///
  /// Writes the profile to the database only if it is changed.  WebSocket event about profile change will not be emitted. The event is emitted only from server side profile updates.  # Requirements - Profile attributes must be valid. - Profile text must be empty. - Profile name changes are only possible when initial setup is ongoing. - Profile age must match with currently valid age range. The first min   value for the age range is the age at the initial setup. The second min   and max value is calculated using the following algorithm:  - The initial age (initialAge) is paired with the year of initial    setup completed (initialSetupYear).    - Year difference (yearDifference = currentYear - initialSetupYear) is      used for changing the range min and max.      - Min value: initialAge + yearDifference - 1.      - Max value: initialAge + yearDifference + 1.  TODO: string lenght validation, limit saving new profiles TODO: return the new proifle. Edit: is this really needed?
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [ProfileUpdate] profileUpdate (required):
  Future<Response> postProfileWithHttpInfo(ProfileUpdate profileUpdate,) async {
    // ignore: prefer_const_declarations
    final path = r'/5i55ZcY0jIPD7B6pyyridKY0j0Q';

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
  /// Writes the profile to the database only if it is changed.  WebSocket event about profile change will not be emitted. The event is emitted only from server side profile updates.  # Requirements - Profile attributes must be valid. - Profile text must be empty. - Profile name changes are only possible when initial setup is ongoing. - Profile age must match with currently valid age range. The first min   value for the age range is the age at the initial setup. The second min   and max value is calculated using the following algorithm:  - The initial age (initialAge) is paired with the year of initial    setup completed (initialSetupYear).    - Year difference (yearDifference = currentYear - initialSetupYear) is      used for changing the range min and max.      - Min value: initialAge + yearDifference - 1.      - Max value: initialAge + yearDifference + 1.  TODO: string lenght validation, limit saving new profiles TODO: return the new proifle. Edit: is this really needed?
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

  /// Set profile attribute filter values.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [ProfileAttributeFilterListUpdate] profileAttributeFilterListUpdate (required):
  Future<Response> postProfileAttributeFiltersWithHttpInfo(ProfileAttributeFilterListUpdate profileAttributeFilterListUpdate,) async {
    // ignore: prefer_const_declarations
    final path = r'/AL531AoIDRcTSWC-pdxcexf6tOM';

    // ignore: prefer_final_locals
    Object? postBody = profileAttributeFilterListUpdate;

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

  /// Set profile attribute filter values.
  ///
  /// Parameters:
  ///
  /// * [ProfileAttributeFilterListUpdate] profileAttributeFilterListUpdate (required):
  Future<void> postProfileAttributeFilters(ProfileAttributeFilterListUpdate profileAttributeFilterListUpdate,) async {
    final response = await postProfileAttributeFiltersWithHttpInfo(profileAttributeFilterListUpdate,);
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
    final path = r'/XDTSz35S_5tOKIsSpDITOc46MR4';

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

  /// Reset profile paging.
  ///
  /// After this request getting next profiles will continue from the nearest profiles.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> postResetProfilePagingWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/uUYIl9C8DoXwTj1icArj0S4RTFI';

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
    final path = r'/xTy-zcnl0LQlfPKQalAEnWQQ-rw';

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
    final path = r'/p1KA-sqKKtU3FHvUqYRZnQgj7RQ';

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
    final path = r'/lf5KMD9dBSVuaVcwjm4TB0d7bfY';

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
