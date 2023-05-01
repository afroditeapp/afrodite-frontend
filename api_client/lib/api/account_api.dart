//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class AccountApi {
  AccountApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Cancel account deletion.
  ///
  /// Cancel account deletion.  Account state will move to previous state.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> deleteCancelDeletionWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/delete';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


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

  /// Cancel account deletion.
  ///
  /// Cancel account deletion.  Account state will move to previous state.
  Future<void> deleteCancelDeletion() async {
    final response = await deleteCancelDeletionWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Get current account state.
  ///
  /// Get current account state.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getAccountStateWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/state';

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

  /// Get current account state.
  ///
  /// Get current account state.
  Future<Account?> getAccountState() async {
    final response = await getAccountStateWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Account',) as Account;
    
    }
    return null;
  }

  /// Get deletion status.
  ///
  /// Get deletion status.  Get information when account will be really deleted.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getDeletionStatusWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/delete';

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

  /// Get deletion status.
  ///
  /// Get deletion status.  Get information when account will be really deleted.
  Future<DeleteStatus?> getDeletionStatus() async {
    final response = await getDeletionStatusWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'DeleteStatus',) as DeleteStatus;
    
    }
    return null;
  }

  /// Setup non-changeable user information during `initial setup` state.
  ///
  /// Setup non-changeable user information during `initial setup` state.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [AccountSetup] accountSetup (required):
  Future<Response> postAccountSetupWithHttpInfo(AccountSetup accountSetup,) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/setup';

    // ignore: prefer_final_locals
    Object? postBody = accountSetup;

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

  /// Setup non-changeable user information during `initial setup` state.
  ///
  /// Setup non-changeable user information during `initial setup` state.
  ///
  /// Parameters:
  ///
  /// * [AccountSetup] accountSetup (required):
  Future<void> postAccountSetup(AccountSetup accountSetup,) async {
    final response = await postAccountSetupWithHttpInfo(accountSetup,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Complete initial setup.
  ///
  /// Complete initial setup.  Request to this handler will complete if client is in `initial setup`, setup information is set and image moderation request has been made. 
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> postCompleteSetupWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/complete_setup';

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

  /// Complete initial setup.
  ///
  /// Complete initial setup.  Request to this handler will complete if client is in `initial setup`, setup information is set and image moderation request has been made. 
  Future<void> postCompleteSetup() async {
    final response = await postCompleteSetupWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Delete account.
  ///
  /// Delete account.  Changes account state to `pending deletion` from all possible states. Previous state will be saved, so it will be possible to stop automatic deletion process.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> postDeleteWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/delete';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


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

  /// Delete account.
  ///
  /// Delete account.  Changes account state to `pending deletion` from all possible states. Previous state will be saved, so it will be possible to stop automatic deletion process.
  Future<void> postDelete() async {
    final response = await postDeleteWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Get new ApiKey.
  ///
  /// Get new ApiKey.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [AccountIdLight] accountIdLight (required):
  Future<Response> postLoginWithHttpInfo(AccountIdLight accountIdLight,) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/login';

    // ignore: prefer_final_locals
    Object? postBody = accountIdLight;

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

  /// Get new ApiKey.
  ///
  /// Get new ApiKey.
  ///
  /// Parameters:
  ///
  /// * [AccountIdLight] accountIdLight (required):
  Future<ApiKey?> postLogin(AccountIdLight accountIdLight,) async {
    final response = await postLoginWithHttpInfo(accountIdLight,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ApiKey',) as ApiKey;
    
    }
    return null;
  }

  /// Register new account. Returns new account ID which is UUID.
  ///
  /// Register new account. Returns new account ID which is UUID.
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

  /// Register new account. Returns new account ID which is UUID.
  ///
  /// Register new account. Returns new account ID which is UUID.
  Future<AccountIdLight?> postRegister() async {
    final response = await postRegisterWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'AccountIdLight',) as AccountIdLight;
    
    }
    return null;
  }

  /// Update profile visiblity value.
  ///
  /// Update profile visiblity value.  This will check that the first image moderation request has been moderated before this turns the profile public.  Sets capablity `view_public_profiles` on or off depending on the value.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [BooleanSetting] booleanSetting (required):
  Future<Response> putSettingProfileVisiblityWithHttpInfo(BooleanSetting booleanSetting,) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/settings/profile_visibility';

    // ignore: prefer_final_locals
    Object? postBody = booleanSetting;

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

  /// Update profile visiblity value.
  ///
  /// Update profile visiblity value.  This will check that the first image moderation request has been moderated before this turns the profile public.  Sets capablity `view_public_profiles` on or off depending on the value.
  ///
  /// Parameters:
  ///
  /// * [BooleanSetting] booleanSetting (required):
  Future<void> putSettingProfileVisiblity(BooleanSetting booleanSetting,) async {
    final response = await putSettingProfileVisiblityWithHttpInfo(booleanSetting,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}
