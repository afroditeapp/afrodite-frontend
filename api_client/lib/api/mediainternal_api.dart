//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class MediainternalApi {
  MediainternalApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Performs an HTTP 'POST /internal/image/{account_id}/{image_file}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] accountId (required):
  ///
  /// * [String] imageFile (required):
  ///
  /// * [ImageFile] imageFile2 (required):
  ///   Upload new image
  Future<Response> postImageWithHttpInfo(String accountId, String imageFile, ImageFile imageFile2,) async {
    // ignore: prefer_const_declarations
    final path = r'/internal/image/{account_id}/{image_file}'
      .replaceAll('{account_id}', accountId)
      .replaceAll('{image_file}', imageFile);

    // ignore: prefer_final_locals
    Object? postBody = imageFile2;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['image/jpeg'];


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
  /// * [String] imageFile (required):
  ///
  /// * [ImageFile] imageFile2 (required):
  ///   Upload new image
  Future<void> postImage(String accountId, String imageFile, ImageFile imageFile2,) async {
    final response = await postImageWithHttpInfo(accountId, imageFile, imageFile2,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}
