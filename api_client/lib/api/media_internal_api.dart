//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class MediaInternalApi {
  MediaInternalApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Check that current moderation request for account exists. Requires also
  ///
  /// Check that current moderation request for account exists. Requires also that request contains camera image. 
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] accountId (required):
  Future<Response> internalGetCheckModerationRequestForAccountWithHttpInfo(String accountId,) async {
    // ignore: prefer_const_declarations
    final path = r'/internal/media_api/moderation/request/{account_id}'
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

  /// Check that current moderation request for account exists. Requires also
  ///
  /// Check that current moderation request for account exists. Requires also that request contains camera image. 
  ///
  /// Parameters:
  ///
  /// * [String] accountId (required):
  Future<void> internalGetCheckModerationRequestForAccount(String accountId,) async {
    final response = await internalGetCheckModerationRequestForAccountWithHttpInfo(accountId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /internal/media_api/visiblity/{account_id}/{value}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] accountId (required):
  ///
  /// * [bool] value (required):
  ///
  /// * [Profile] profile (required):
  Future<Response> internalPostUpdateProfileImageVisibilityWithHttpInfo(String accountId, bool value, Profile profile,) async {
    // ignore: prefer_const_declarations
    final path = r'/internal/media_api/visiblity/{account_id}/{value}'
      .replaceAll('{account_id}', accountId)
      .replaceAll('{value}', value.toString());

    // ignore: prefer_final_locals
    Object? postBody = profile;

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
  /// * [String] accountId (required):
  ///
  /// * [bool] value (required):
  ///
  /// * [Profile] profile (required):
  Future<void> internalPostUpdateProfileImageVisibility(String accountId, bool value, Profile profile,) async {
    final response = await internalPostUpdateProfileImageVisibilityWithHttpInfo(accountId, value, profile,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}
