//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class AccountApi {
  AccountApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Performs an HTTP 'GET /account_api/get_account_app_notification_settings' operation and returns the [Response].
  Future<Response> getAccountAppNotificationSettingsWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/get_account_app_notification_settings';

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

  Future<AccountAppNotificationSettings?> getAccountAppNotificationSettings() async {
    final response = await getAccountAppNotificationSettingsWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'AccountAppNotificationSettings',) as AccountAppNotificationSettings;
    
    }
    return null;
  }

  /// Get account ban time
  ///
  /// # Access - Account owner - Permission [model::Permissions::admin_ban_account]
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  Future<Response> getAccountBanTimeWithHttpInfo(String aid,) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/account_ban_time/{aid}'
      .replaceAll('{aid}', aid);

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

  /// Get account ban time
  ///
  /// # Access - Account owner - Permission [model::Permissions::admin_ban_account]
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  Future<GetAccountBanTimeResult?> getAccountBanTime(String aid,) async {
    final response = await getAccountBanTimeWithHttpInfo(aid,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'GetAccountBanTimeResult',) as GetAccountBanTimeResult;
    
    }
    return null;
  }

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

  /// Get account deletion request state
  ///
  /// # Access - Account owner - Permission [model_account::Permissions::admin_request_account_deletion]
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  Future<Response> getAccountDeletionRequestStateWithHttpInfo(String aid,) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/get_account_deletion_request_state/{aid}'
      .replaceAll('{aid}', aid);

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

  /// Get account deletion request state
  ///
  /// # Access - Account owner - Permission [model_account::Permissions::admin_request_account_deletion]
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  Future<GetAccountDeletionRequestResult?> getAccountDeletionRequestState(String aid,) async {
    final response = await getAccountDeletionRequestStateWithHttpInfo(aid,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'GetAccountDeletionRequestResult',) as GetAccountDeletionRequestResult;
    
    }
    return null;
  }

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

  /// Performs an HTTP 'GET /account_api/latest_birthdate' operation and returns the [Response].
  Future<Response> getLatestBirthdateWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/latest_birthdate';

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

  Future<LatestBirthdate?> getLatestBirthdate() async {
    final response = await getLatestBirthdateWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'LatestBirthdate',) as LatestBirthdate;
    
    }
    return null;
  }

  /// Get news item content using specific locale and fallback to locale \"en\" if news translation is not found.
  ///
  /// If specific locale is not found when [RequireNewsLocale::require_locale] is `true` then [GetNewsItemResult::item] is `None`.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] nid (required):
  ///
  /// * [String] locale (required):
  ///
  /// * [bool] requireLocale:
  Future<Response> getNewsItemWithHttpInfo(int nid, String locale, { bool? requireLocale, }) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/news_item/{nid}'
      .replaceAll('{nid}', nid.toString());

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'locale', locale));
    if (requireLocale != null) {
      queryParams.addAll(_queryParams('', 'require_locale', requireLocale));
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

  /// Get news item content using specific locale and fallback to locale \"en\" if news translation is not found.
  ///
  /// If specific locale is not found when [RequireNewsLocale::require_locale] is `true` then [GetNewsItemResult::item] is `None`.
  ///
  /// Parameters:
  ///
  /// * [int] nid (required):
  ///
  /// * [String] locale (required):
  ///
  /// * [bool] requireLocale:
  Future<GetNewsItemResult?> getNewsItem(int nid, String locale, { bool? requireLocale, }) async {
    final response = await getNewsItemWithHttpInfo(nid, locale,  requireLocale: requireLocale, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'GetNewsItemResult',) as GetNewsItemResult;
    
    }
    return null;
  }

  /// Performs an HTTP 'POST /account_api/post_account_app_notification_settings' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [AccountAppNotificationSettings] accountAppNotificationSettings (required):
  Future<Response> postAccountAppNotificationSettingsWithHttpInfo(AccountAppNotificationSettings accountAppNotificationSettings,) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/post_account_app_notification_settings';

    // ignore: prefer_final_locals
    Object? postBody = accountAppNotificationSettings;

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
  /// * [AccountAppNotificationSettings] accountAppNotificationSettings (required):
  Future<void> postAccountAppNotificationSettings(AccountAppNotificationSettings accountAppNotificationSettings,) async {
    final response = await postAccountAppNotificationSettingsWithHttpInfo(accountAppNotificationSettings,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

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
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [SetAccountSetup] setAccountSetup (required):
  Future<Response> postAccountSetupWithHttpInfo(SetAccountSetup setAccountSetup,) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/account_setup';

    // ignore: prefer_final_locals
    Object? postBody = setAccountSetup;

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
  /// Parameters:
  ///
  /// * [SetAccountSetup] setAccountSetup (required):
  Future<void> postAccountSetup(SetAccountSetup setAccountSetup,) async {
    final response = await postAccountSetupWithHttpInfo(setAccountSetup,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Complete initial setup.
  ///
  /// Requirements:  - Account must be in `InitialSetup` state.  - Account must have a valid AccountSetup info set.  
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
  /// Requirements:  - Account must be in `InitialSetup` state.  - Account must have a valid AccountSetup info set.  
  Future<void> postCompleteSetup() async {
    final response = await postCompleteSetupWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Send custom report
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [UpdateCustomReportBoolean] updateCustomReportBoolean (required):
  Future<Response> postCustomReportBooleanWithHttpInfo(UpdateCustomReportBoolean updateCustomReportBoolean,) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/custom_report_boolean';

    // ignore: prefer_final_locals
    Object? postBody = updateCustomReportBoolean;

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

  /// Send custom report
  ///
  /// Parameters:
  ///
  /// * [UpdateCustomReportBoolean] updateCustomReportBoolean (required):
  Future<UpdateReportResult?> postCustomReportBoolean(UpdateCustomReportBoolean updateCustomReportBoolean,) async {
    final response = await postCustomReportBooleanWithHttpInfo(updateCustomReportBoolean,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'UpdateReportResult',) as UpdateReportResult;
    
    }
    return null;
  }

  /// Get demo account's available accounts.
  ///
  /// This path is using HTTP POST because there is JSON in the request body.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [DemoModeToken] demoModeToken (required):
  Future<Response> postDemoModeAccessibleAccountsWithHttpInfo(DemoModeToken demoModeToken,) async {
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
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Get demo account's available accounts.
  ///
  /// This path is using HTTP POST because there is JSON in the request body.
  ///
  /// Parameters:
  ///
  /// * [DemoModeToken] demoModeToken (required):
  Future<List<AccessibleAccount>?> postDemoModeAccessibleAccounts(DemoModeToken demoModeToken,) async {
    final response = await postDemoModeAccessibleAccountsWithHttpInfo(demoModeToken,);
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
        .toList(growable: false);

    }
    return null;
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

  /// Performs an HTTP 'POST /account_api/demo_mode_logout' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [DemoModeToken] demoModeToken (required):
  Future<Response> postDemoModeLogoutWithHttpInfo(DemoModeToken demoModeToken,) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/demo_mode_logout';

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
  Future<void> postDemoModeLogout(DemoModeToken demoModeToken,) async {
    final response = await postDemoModeLogoutWithHttpInfo(demoModeToken,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
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

  /// Performs an HTTP 'POST /account_api/client_features_config' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ClientFeaturesFileHash] clientFeaturesFileHash (required):
  Future<Response> postGetClientFeaturesConfigWithHttpInfo(ClientFeaturesFileHash clientFeaturesFileHash,) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/client_features_config';

    // ignore: prefer_final_locals
    Object? postBody = clientFeaturesFileHash;

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
  /// * [ClientFeaturesFileHash] clientFeaturesFileHash (required):
  Future<GetClientFeaturesConfigResult?> postGetClientFeaturesConfig(ClientFeaturesFileHash clientFeaturesFileHash,) async {
    final response = await postGetClientFeaturesConfigWithHttpInfo(clientFeaturesFileHash,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'GetClientFeaturesConfigResult',) as GetClientFeaturesConfigResult;
    
    }
    return null;
  }

  /// Performs an HTTP 'POST /account_api/custom_reports_config' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [CustomReportsFileHash] customReportsFileHash (required):
  Future<Response> postGetCustomReportsConfigWithHttpInfo(CustomReportsFileHash customReportsFileHash,) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/custom_reports_config';

    // ignore: prefer_final_locals
    Object? postBody = customReportsFileHash;

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
  /// * [CustomReportsFileHash] customReportsFileHash (required):
  Future<GetCustomReportsConfigResult?> postGetCustomReportsConfig(CustomReportsFileHash customReportsFileHash,) async {
    final response = await postGetCustomReportsConfigWithHttpInfo(customReportsFileHash,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'GetCustomReportsConfigResult',) as GetCustomReportsConfigResult;
    
    }
    return null;
  }

  /// Performs an HTTP 'POST /account_api/next_client_id' operation and returns the [Response].
  Future<Response> postGetNextClientIdWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/next_client_id';

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

  Future<ClientId?> postGetNextClientId() async {
    final response = await postGetNextClientIdWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ClientId',) as ClientId;
    
    }
    return null;
  }

  /// Performs an HTTP 'POST /account_api/next_news_page' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] locale (required):
  ///
  /// * [NewsIteratorSessionId] newsIteratorSessionId (required):
  Future<Response> postGetNextNewsPageWithHttpInfo(String locale, NewsIteratorSessionId newsIteratorSessionId,) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/next_news_page';

    // ignore: prefer_final_locals
    Object? postBody = newsIteratorSessionId;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'locale', locale));

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
  /// * [String] locale (required):
  ///
  /// * [NewsIteratorSessionId] newsIteratorSessionId (required):
  Future<NewsPage?> postGetNextNewsPage(String locale, NewsIteratorSessionId newsIteratorSessionId,) async {
    final response = await postGetNextNewsPageWithHttpInfo(locale, newsIteratorSessionId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'NewsPage',) as NewsPage;
    
    }
    return null;
  }

  /// The unread news count for public news.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> postGetUnreadNewsCountWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/news_count';

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

  /// The unread news count for public news.
  Future<UnreadNewsCountResult?> postGetUnreadNewsCount() async {
    final response = await postGetUnreadNewsCountWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'UnreadNewsCountResult',) as UnreadNewsCountResult;
    
    }
    return null;
  }

  /// Performs an HTTP 'POST /account_api/logout' operation and returns the [Response].
  Future<Response> postLogoutWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/logout';

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

  Future<void> postLogout() async {
    final response = await postLogoutWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /account_api/reset_news_paging' operation and returns the [Response].
  Future<Response> postResetNewsPagingWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/reset_news_paging';

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

  Future<ResetNewsIteratorResult?> postResetNewsPaging() async {
    final response = await postResetNewsPagingWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ResetNewsIteratorResult',) as ResetNewsIteratorResult;
    
    }
    return null;
  }

  /// Request account deletion or cancel the deletion
  ///
  /// # Access - Account owner - Permission [model_account::Permissions::admin_request_account_deletion]
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  ///
  /// * [BooleanSetting] booleanSetting (required):
  Future<Response> postSetAccountDeletionRequestStateWithHttpInfo(String aid, BooleanSetting booleanSetting,) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/set_account_deletion_request_state/{aid}'
      .replaceAll('{aid}', aid);

    // ignore: prefer_final_locals
    Object? postBody = booleanSetting;

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

  /// Request account deletion or cancel the deletion
  ///
  /// # Access - Account owner - Permission [model_account::Permissions::admin_request_account_deletion]
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  ///
  /// * [BooleanSetting] booleanSetting (required):
  Future<void> postSetAccountDeletionRequestState(String aid, BooleanSetting booleanSetting,) async {
    final response = await postSetAccountDeletionRequestStateWithHttpInfo(aid, booleanSetting,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

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
  /// NOTE: Client uses this in initial setup.
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
  /// NOTE: Client uses this in initial setup.
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

  /// Performs an HTTP 'PUT /account_api/settings/unlimited_likes' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [BooleanSetting] booleanSetting (required):
  Future<Response> putSettingUnlimitedLikesWithHttpInfo(BooleanSetting booleanSetting,) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/settings/unlimited_likes';

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

  /// Parameters:
  ///
  /// * [BooleanSetting] booleanSetting (required):
  Future<void> putSettingUnlimitedLikes(BooleanSetting booleanSetting,) async {
    final response = await putSettingUnlimitedLikesWithHttpInfo(booleanSetting,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}
