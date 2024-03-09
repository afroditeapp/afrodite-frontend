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

  /// Get changeable user information to account.
  ///
  /// Get changeable user information to account.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getAccountDataWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/account_data';

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

  /// Get changeable user information to account.
  ///
  /// Get changeable user information to account.
  Future<AccountData?> getAccountData() async {
    final response = await getAccountDataWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'AccountData',) as AccountData;
    
    }
    return null;
  }

  /// Get non-changeable user information to account.
  ///
  /// Get non-changeable user information to account.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getAccountSetupWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/account_setup';

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

  /// Get non-changeable user information to account.
  ///
  /// Get non-changeable user information to account.
  Future<AccountSetup?> getAccountSetup() async {
    final response = await getAccountSetupWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'AccountSetup',) as AccountSetup;
    
    }
    return null;
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

  /// Performs an HTTP 'GET /account_api/demo_mode_accessible_accounts' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [DemoModeToken] demoModeToken (required):
  Future<Response> getDemoModeAccessibleAccountsWithHttpInfo(DemoModeToken demoModeToken,) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/demo_mode_accessible_accounts';

    // ignore: prefer_final_locals
    Object? postBody = demoModeToken;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


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
  /// * [DemoModeToken] demoModeToken (required):
  Future<List<AccessibleAccount>?> getDemoModeAccessibleAccounts(DemoModeToken demoModeToken,) async {
    final response = await getDemoModeAccessibleAccountsWithHttpInfo(demoModeToken,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<AccessibleAccount>') as List)
        .cast<AccessibleAccount>()
        .toList();

    }
    return null;
  }

  /// Set changeable user information to account.
  ///
  /// Set changeable user information to account.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [AccountData] accountData (required):
  Future<Response> postAccountDataWithHttpInfo(AccountData accountData,) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/account_data';

    // ignore: prefer_final_locals
    Object? postBody = accountData;

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

  /// Set changeable user information to account.
  ///
  /// Set changeable user information to account.
  ///
  /// Parameters:
  ///
  /// * [AccountData] accountData (required):
  Future<void> postAccountData(AccountData accountData,) async {
    final response = await postAccountDataWithHttpInfo(accountData,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
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
    final path = r'/account_api/account_setup';

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
  /// Complete initial setup.  Requirements: - Account must be in `InitialSetup` state. - Account must have a valid AccountSetup info set. - Account must have a moderation request. - The current or pending security image of the account is in the request. - The current or pending first profile image of the account is in the request. 
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
  /// Complete initial setup.  Requirements: - Account must be in `InitialSetup` state. - Account must have a valid AccountSetup info set. - Account must have a moderation request. - The current or pending security image of the account is in the request. - The current or pending first profile image of the account is in the request. 
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

  /// Performs an HTTP 'POST /account_api/demo_mode_confirm_login' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [DemoModeConfirmLogin] demoModeConfirmLogin (required):
  Future<Response> postDemoModeConfirmLoginWithHttpInfo(DemoModeConfirmLogin demoModeConfirmLogin,) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/demo_mode_confirm_login';

    // ignore: prefer_final_locals
    Object? postBody = demoModeConfirmLogin;

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
  /// * [DemoModeConfirmLogin] demoModeConfirmLogin (required):
  Future<DemoModeConfirmLoginResult?> postDemoModeConfirmLogin(DemoModeConfirmLogin demoModeConfirmLogin,) async {
    final response = await postDemoModeConfirmLoginWithHttpInfo(demoModeConfirmLogin,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'DemoModeConfirmLoginResult',) as DemoModeConfirmLoginResult;
    
    }
    return null;
  }

  /// Access demo mode, which allows accessing all or specific accounts
  ///
  /// Access demo mode, which allows accessing all or specific accounts depending on the server configuration.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [DemoModePassword] demoModePassword (required):
  Future<Response> postDemoModeLoginWithHttpInfo(DemoModePassword demoModePassword,) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/demo_mode_login';

    // ignore: prefer_final_locals
    Object? postBody = demoModePassword;

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

  /// Access demo mode, which allows accessing all or specific accounts
  ///
  /// Access demo mode, which allows accessing all or specific accounts depending on the server configuration.
  ///
  /// Parameters:
  ///
  /// * [DemoModePassword] demoModePassword (required):
  Future<DemoModeLoginResult?> postDemoModeLogin(DemoModePassword demoModePassword,) async {
    final response = await postDemoModeLoginWithHttpInfo(demoModePassword,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'DemoModeLoginResult',) as DemoModeLoginResult;
    
    }
    return null;
  }

  /// Performs an HTTP 'POST /account_api/demo_mode_login_to_account' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [DemoModeLoginToAccount] demoModeLoginToAccount (required):
  Future<Response> postDemoModeLoginToAccountWithHttpInfo(DemoModeLoginToAccount demoModeLoginToAccount,) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/demo_mode_login_to_account';

    // ignore: prefer_final_locals
    Object? postBody = demoModeLoginToAccount;

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
  /// * [DemoModeLoginToAccount] demoModeLoginToAccount (required):
  Future<LoginResult?> postDemoModeLoginToAccount(DemoModeLoginToAccount demoModeLoginToAccount,) async {
    final response = await postDemoModeLoginToAccountWithHttpInfo(demoModeLoginToAccount,);
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

  /// Performs an HTTP 'POST /account_api/demo_mode_register_account' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [DemoModeToken] demoModeToken (required):
  Future<Response> postDemoModeRegisterAccountWithHttpInfo(DemoModeToken demoModeToken,) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/demo_mode_register_account';

    // ignore: prefer_final_locals
    Object? postBody = demoModeToken;

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
  /// * [DemoModeToken] demoModeToken (required):
  Future<AccountId?> postDemoModeRegisterAccount(DemoModeToken demoModeToken,) async {
    final response = await postDemoModeRegisterAccountWithHttpInfo(demoModeToken,);
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

  /// Get new AccessToken.
  ///
  /// Get new AccessToken.  Available only if server is running in debug mode and bot_login is enabled from config file.
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

  /// Get new AccessToken.
  ///
  /// Get new AccessToken.  Available only if server is running in debug mode and bot_login is enabled from config file.
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

  /// Register new account. Returns new account ID which is UUID.
  ///
  /// Register new account. Returns new account ID which is UUID.  Available only if server is running in debug mode and bot_login is enabled from config file.
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
  /// Register new account. Returns new account ID which is UUID.  Available only if server is running in debug mode and bot_login is enabled from config file.
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

  /// Start new session with sign in with Apple or Google. Creates new account if
  ///
  /// Start new session with sign in with Apple or Google. Creates new account if it does not exists.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [SignInWithLoginInfo] signInWithLoginInfo (required):
  Future<Response> postSignInWithLoginWithHttpInfo(SignInWithLoginInfo signInWithLoginInfo,) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/sign_in_with_login';

    // ignore: prefer_final_locals
    Object? postBody = signInWithLoginInfo;

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

  /// Start new session with sign in with Apple or Google. Creates new account if
  ///
  /// Start new session with sign in with Apple or Google. Creates new account if it does not exists.
  ///
  /// Parameters:
  ///
  /// * [SignInWithLoginInfo] signInWithLoginInfo (required):
  Future<LoginResult?> postSignInWithLogin(SignInWithLoginInfo signInWithLoginInfo,) async {
    final response = await postSignInWithLoginWithHttpInfo(signInWithLoginInfo,);
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

  /// Update current or pending profile visiblity value.
  ///
  /// Update current or pending profile visiblity value.  Requirements: - Account state must be `Normal`.
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

  /// Update current or pending profile visiblity value.
  ///
  /// Update current or pending profile visiblity value.  Requirements: - Account state must be `Normal`.
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
