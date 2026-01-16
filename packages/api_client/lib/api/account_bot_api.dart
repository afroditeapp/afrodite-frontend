//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class AccountBotApi {
  AccountBotApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Get new AccessToken for a bot account. If the account is not registered as a bot account, then the request will fail.
  ///
  /// Available only from local bot API port.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [AccountId] accountId (required):
  Future<Response> postBotLoginWithHttpInfo(AccountId accountId,) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/bot_login';

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
  /// Available only from local bot API port.
  ///
  /// Parameters:
  ///
  /// * [AccountId] accountId (required):
  Future<LoginResult?> postBotLogin(AccountId accountId,) async {
    final response = await postBotLoginWithHttpInfo(accountId,);
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
  /// Available only from local bot API port.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> postBotRegisterWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/bot_register';

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
  /// Available only from local bot API port.
  Future<AccountId?> postBotRegister() async {
    final response = await postBotRegisterWithHttpInfo();
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

  /// Get admin and user bot accounts by email pattern. Admin bot is admin@example.com, user bots are bot1@example.com, bot2@example.com, etc. Creates accounts if they don't exist.
  ///
  /// Available only from local bot API port.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> postGetBotsWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/get_bots';

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

  /// Get admin and user bot accounts by email pattern. Admin bot is admin@example.com, user bots are bot1@example.com, bot2@example.com, etc. Creates accounts if they don't exist.
  ///
  /// Available only from local bot API port.
  Future<GetBotsResult?> postGetBots() async {
    final response = await postGetBotsWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'GetBotsResult',) as GetBotsResult;
    
    }
    return null;
  }

  /// Login for remote bots.
  ///
  /// Available only from public and local bot API ports.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [RemoteBotLogin] remoteBotLogin (required):
  Future<Response> postRemoteBotLoginWithHttpInfo(RemoteBotLogin remoteBotLogin,) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/remote_bot_login';

    // ignore: prefer_final_locals
    Object? postBody = remoteBotLogin;

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

  /// Login for remote bots.
  ///
  /// Available only from public and local bot API ports.
  ///
  /// Parameters:
  ///
  /// * [RemoteBotLogin] remoteBotLogin (required):
  Future<LoginResult?> postRemoteBotLogin(RemoteBotLogin remoteBotLogin,) async {
    final response = await postRemoteBotLoginWithHttpInfo(remoteBotLogin,);
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

  /// Get admin and user bot accounts by email pattern. Admin bot is admin@example.com, user bots are bot1@example.com, bot2@example.com, etc. Creates accounts if they don't exist.
  ///
  /// Available only from public and local bot API ports.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [RemoteBotPassword] remoteBotPassword (required):
  Future<Response> postRemoteGetBotsWithHttpInfo(RemoteBotPassword remoteBotPassword,) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/remote_get_bots';

    // ignore: prefer_final_locals
    Object? postBody = remoteBotPassword;

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

  /// Get admin and user bot accounts by email pattern. Admin bot is admin@example.com, user bots are bot1@example.com, bot2@example.com, etc. Creates accounts if they don't exist.
  ///
  /// Available only from public and local bot API ports.
  ///
  /// Parameters:
  ///
  /// * [RemoteBotPassword] remoteBotPassword (required):
  Future<GetBotsResult?> postRemoteGetBots(RemoteBotPassword remoteBotPassword,) async {
    final response = await postRemoteGetBotsWithHttpInfo(remoteBotPassword,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'GetBotsResult',) as GetBotsResult;
    
    }
    return null;
  }
}
