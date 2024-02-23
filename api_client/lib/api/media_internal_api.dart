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

  /// Check that media server has correct state for completing initial setup.
  ///
  /// Check that media server has correct state for completing initial setup. 
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

  /// Check that media server has correct state for completing initial setup.
  ///
  /// Check that media server has correct state for completing initial setup. 
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
}
