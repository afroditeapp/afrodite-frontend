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

  /// Performs an HTTP 'GET /82woXm_Kq9yEtRHP7KAcXkgRWnU' operation and returns the [Response].
  Future<Response> getProfileNamePendingModerationListWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/82woXm_Kq9yEtRHP7KAcXkgRWnU';

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

  Future<GetProfileNamePendingModerationList?> getProfileNamePendingModerationList() async {
    final response = await getProfileNamePendingModerationListWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'GetProfileNamePendingModerationList',) as GetProfileNamePendingModerationList;
    
    }
    return null;
  }

  /// Performs an HTTP 'GET /6CGbSNdoURdJRTBxb3Hb_OGw9ME' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ProfileStatisticsHistoryValueType] valueType (required):
  ///
  /// * [int] age:
  ///   Required only for AgeChange history
  Future<Response> getProfileStatisticsHistoryWithHttpInfo(ProfileStatisticsHistoryValueType valueType, { int? age, }) async {
    // ignore: prefer_const_declarations
    final path = r'/6CGbSNdoURdJRTBxb3Hb_OGw9ME';

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

  /// Get first page of pending profile text moderations. Oldest item is first and count 25.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [bool] showTextsWhichBotsCanModerate (required):
  Future<Response> getProfileTextPendingModerationListWithHttpInfo(bool showTextsWhichBotsCanModerate,) async {
    // ignore: prefer_const_declarations
    final path = r'/pdEU3ussEDsELfe6TOtjqrDojOc';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'show_texts_which_bots_can_moderate', showTextsWhichBotsCanModerate));

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

  /// Get first page of pending profile text moderations. Oldest item is first and count 25.
  ///
  /// Parameters:
  ///
  /// * [bool] showTextsWhichBotsCanModerate (required):
  Future<GetProfileTextPendingModerationList?> getProfileTextPendingModerationList(bool showTextsWhichBotsCanModerate,) async {
    final response = await getProfileTextPendingModerationListWithHttpInfo(showTextsWhichBotsCanModerate,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'GetProfileTextPendingModerationList',) as GetProfileTextPendingModerationList;
    
    }
    return null;
  }

  /// Performs an HTTP 'POST /bnrAbC2DpwIftQouXUAVR1W6g8Y' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [PostModerateProfileName] postModerateProfileName (required):
  Future<Response> postModerateProfileNameWithHttpInfo(PostModerateProfileName postModerateProfileName,) async {
    // ignore: prefer_const_declarations
    final path = r'/bnrAbC2DpwIftQouXUAVR1W6g8Y';

    // ignore: prefer_final_locals
    Object? postBody = postModerateProfileName;

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
  /// * [PostModerateProfileName] postModerateProfileName (required):
  Future<void> postModerateProfileName(PostModerateProfileName postModerateProfileName,) async {
    final response = await postModerateProfileNameWithHttpInfo(postModerateProfileName,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /53BBFzgF9dZhb7_HvZSqLidsqbg' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [PostModerateProfileText] postModerateProfileText (required):
  Future<Response> postModerateProfileTextWithHttpInfo(PostModerateProfileText postModerateProfileText,) async {
    // ignore: prefer_const_declarations
    final path = r'/53BBFzgF9dZhb7_HvZSqLidsqbg';

    // ignore: prefer_final_locals
    Object? postBody = postModerateProfileText;

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
  /// * [PostModerateProfileText] postModerateProfileText (required):
  Future<void> postModerateProfileText(PostModerateProfileText postModerateProfileText,) async {
    final response = await postModerateProfileTextWithHttpInfo(postModerateProfileText,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}
