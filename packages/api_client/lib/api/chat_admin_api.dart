//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class ChatAdminApi {
  ChatAdminApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Set max public key count
  ///
  /// # Access * Permission [model::Permissions::admin_edit_max_public_key_count]
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [SetMaxPublicKeyCount] setMaxPublicKeyCount (required):
  Future<Response> postSetMaxPublicKeyCountWithHttpInfo(SetMaxPublicKeyCount setMaxPublicKeyCount,) async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/set_max_public_key_count';

    // ignore: prefer_final_locals
    Object? postBody = setMaxPublicKeyCount;

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

  /// Set max public key count
  ///
  /// # Access * Permission [model::Permissions::admin_edit_max_public_key_count]
  ///
  /// Parameters:
  ///
  /// * [SetMaxPublicKeyCount] setMaxPublicKeyCount (required):
  Future<void> postSetMaxPublicKeyCount(SetMaxPublicKeyCount setMaxPublicKeyCount,) async {
    final response = await postSetMaxPublicKeyCountWithHttpInfo(setMaxPublicKeyCount,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}
