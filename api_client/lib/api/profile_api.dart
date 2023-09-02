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
  /// Update profile information.  Writes the profile to the database only if it is changed.  TODO: string lenght validation, limit saving new profiles
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
  /// Update profile information.  Writes the profile to the database only if it is changed.  TODO: string lenght validation, limit saving new profiles
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

  /// Update location
  ///
  /// Update location
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

  /// Update location
  ///
  /// Update location
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
