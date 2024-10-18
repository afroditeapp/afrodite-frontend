//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class AccountInternalApi {
  AccountInternalApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Get new AccessToken for a bot account. If the account is not registered as a bot account, then the request will fail.
  ///
  /// Available only if server internal API is enabled with bot_login from config file.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [AccountId] accountId (required):
  Future<Response> postLoginWithHttpInfo(AccountId accountId,) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/login';

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

  /// Get new AccessToken for a bot account. If the account is not registered as a bot account, then the request will fail.
  ///
  /// Available only if server internal API is enabled with bot_login from config file.
  ///
  /// Parameters:
  ///
  /// * [AccountId] accountId (required):
  Future<LoginResult?> postLogin(AccountId accountId,) async {
    final response = await postLoginWithHttpInfo(accountId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'LoginResult',) as LoginResult;
    
    }
    return null;
  }

  /// Register a new bot account. Returns new account ID which is UUID.
  ///
  /// Available only if server internal API is enabled with bot_login from config file.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> postRegisterWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/register';

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

  /// Register a new bot account. Returns new account ID which is UUID.
  ///
  /// Available only if server internal API is enabled with bot_login from config file.
  Future<AccountId?> postRegister() async {
    final response = await postRegisterWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'AccountId',) as AccountId;
    
    }
    return null;
  }
}
