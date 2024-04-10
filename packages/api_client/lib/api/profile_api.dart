//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

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
  ///
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
  ///
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

  /// Get location for account which makes this request.
  ///
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
  ///
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

  /// Get account's current profile.
  ///
  /// Get account's current profile.  Profile can include version UUID which can be used for caching.  # Access Public profile access requires `view_public_profiles` capability. Public and private profile access requires `admin_view_all_profiles` capablility.  # Microservice notes If account feature is set as external service then cached capability information from account service is used for access checks.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] accountId (required):
  Future<Response> getProfileWithHttpInfo(String accountId,) async {
    // ignore: prefer_const_declarations
    final path = r'/profile_api/profile/{account_id}'
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

  /// Get account's current profile.
  ///
  /// Get account's current profile.  Profile can include version UUID which can be used for caching.  # Access Public profile access requires `view_public_profiles` capability. Public and private profile access requires `admin_view_all_profiles` capablility.  # Microservice notes If account feature is set as external service then cached capability information from account service is used for access checks.
  ///
  /// Parameters:
  ///
  /// * [String] accountId (required):
  Future<Profile?> getProfile(String accountId,) async {
    final response = await getProfileWithHttpInfo(accountId,);
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

  /// Get current profile attribute filter values.
  ///
  /// Get current profile attribute filter values.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getProfileAttributeFiltersWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/profile_api/profile_attribute_filters';

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
  ///
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

  /// Get account's current profile from database. Debug mode must be enabled
  ///
  /// Get account's current profile from database. Debug mode must be enabled that route can be used.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] accountId (required):
  Future<Response> getProfileFromDatabaseDebugModeBenchmarkWithHttpInfo(String accountId,) async {
    // ignore: prefer_const_declarations
    final path = r'/profile_api/benchmark/profile/{account_id}'
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

  /// Get account's current profile from database. Debug mode must be enabled
  ///
  /// Get account's current profile from database. Debug mode must be enabled that route can be used.
  ///
  /// Parameters:
  ///
  /// * [String] accountId (required):
  Future<Profile?> getProfileFromDatabaseDebugModeBenchmark(String accountId,) async {
    final response = await getProfileFromDatabaseDebugModeBenchmarkWithHttpInfo(accountId,);
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
  ///
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

  /// Get account's current search groups
  ///
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

  /// Get account's current search groups
  ///
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
  /// Post (updates iterator) to get next page of profile list.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> postGetNextProfilePageWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/profile_api/page/next';

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

  /// Post (updates iterator) to get next page of profile list.
  ///
  /// Post (updates iterator) to get next page of profile list.
  Future<ProfilePage?> postGetNextProfilePage() async {
    final response = await postGetNextProfilePageWithHttpInfo();
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
  /// Update profile information.  Writes the profile to the database only if it is changed.  TODO: string lenght validation, limit saving new profiles TODO: return the new proifle. Edit: is this really needed?
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
  /// Update profile information.  Writes the profile to the database only if it is changed.  TODO: string lenght validation, limit saving new profiles TODO: return the new proifle. Edit: is this really needed?
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
  /// Set profile attribute filter values.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [ProfileAttributeFilterListUpdate] profileAttributeFilterListUpdate (required):
  Future<Response> postProfileAttributeFiltersWithHttpInfo(ProfileAttributeFilterListUpdate profileAttributeFilterListUpdate,) async {
    // ignore: prefer_const_declarations
    final path = r'/profile_api/profile_attribute_filters';

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

  /// Post account's current profile directly to database. Debug mode must be enabled
  ///
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

  /// Post account's current profile directly to database. Debug mode must be enabled
  ///
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
  /// Reset profile paging.  After this request getting next profiles will continue from the nearest profiles.
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
  /// Reset profile paging.  After this request getting next profiles will continue from the nearest profiles.
  Future<void> postResetProfilePaging() async {
    final response = await postResetProfilePagingWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Set account's current search age range
  ///
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

  /// Set account's current search groups
  ///
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

  /// Set account's current search groups
  ///
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
