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

  /// Cancel account deletion.
  ///
  /// Account state will move to previous state.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> deleteCancelDeletionWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/_aiEAY0WZCquNl_WQ5fDORGuHwA';

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
  /// Account state will move to previous state.
  Future<void> deleteCancelDeletion() async {
    final response = await deleteCancelDeletionWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Get changeable user information to account.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getAccountDataWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/Ln3_j2LpJIbQABKwnMMhUEtio5k';

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

  /// Get non-changeable user information to account.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getAccountSetupWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/RNb6qhf_lZU8t6kOm5kQY7Y34ok';

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
    final path = r'/C9sCP6O2IfIBQCu8LM1_SCybuW0';

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

  /// Get deletion status.
  ///
  /// Get information when account will be really deleted.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getDeletionStatusWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/_aiEAY0WZCquNl_WQ5fDORGuHwA';

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
  /// Get information when account will be really deleted.
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

  /// Performs an HTTP 'GET /Hg2W1drXZ94YVp3Uh38hnQzYIng' operation and returns the [Response].
  Future<Response> getLatestBirthdateWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/Hg2W1drXZ94YVp3Uh38hnQzYIng';

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
    final path = r'/2OHF85k7hpH2tAibkA0V9YLwpF4/{nid}'
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

  /// The unread news count for public news.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getUnreadNewsCountWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/ljfyAP7CbP0864cA6nZX7ESufjY';

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

  /// The unread news count for public news.
  Future<UnreadNewsCountResult?> getUnreadNewsCount() async {
    final response = await getUnreadNewsCountWithHttpInfo();
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

  /// Set changeable user information to account.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [AccountData] accountData (required):
  Future<Response> postAccountDataWithHttpInfo(AccountData accountData,) async {
    // ignore: prefer_const_declarations
    final path = r'/Ln3_j2LpJIbQABKwnMMhUEtio5k';

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
    final path = r'/RNb6qhf_lZU8t6kOm5kQY7Y34ok';

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
  /// Requirements:  - Account must be in `InitialSetup` state.  - Account must have a valid AccountSetup info set.  - Account must have a moderation request.  - The current or pending security image of the account is in the request.  - The current or pending first profile image of the account is in the    request.  
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> postCompleteSetupWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/VzPyCXS5Hx50SbAApdpUYfCY-Iw';

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
  /// Requirements:  - Account must be in `InitialSetup` state.  - Account must have a valid AccountSetup info set.  - Account must have a moderation request.  - The current or pending security image of the account is in the request.  - The current or pending first profile image of the account is in the    request.  
  Future<void> postCompleteSetup() async {
    final response = await postCompleteSetupWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Delete account.
  ///
  /// Changes account state to `pending deletion` from all possible states. Previous state will be saved, so it will be possible to stop automatic deletion process.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> postDeleteWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/_aiEAY0WZCquNl_WQ5fDORGuHwA';

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
  /// Changes account state to `pending deletion` from all possible states. Previous state will be saved, so it will be possible to stop automatic deletion process.
  Future<void> postDelete() async {
    final response = await postDeleteWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
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
    final path = r'/xyG8kH6eLanLiKYXdnOx1xxeAdA';

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

  /// Performs an HTTP 'POST /3KlEajKOIo1Drd3uW-IzQ1L3qlE' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [DemoModeConfirmLogin] demoModeConfirmLogin (required):
  Future<Response> postDemoModeConfirmLoginWithHttpInfo(DemoModeConfirmLogin demoModeConfirmLogin,) async {
    // ignore: prefer_const_declarations
    final path = r'/3KlEajKOIo1Drd3uW-IzQ1L3qlE';

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
    final path = r'/TYbxniP-G9ibgdoAkpvVWTKkxaU';

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

  /// Performs an HTTP 'POST /sBH-LyNGOOFXivrv5clCpNrkwcA' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [DemoModeLoginToAccount] demoModeLoginToAccount (required):
  Future<Response> postDemoModeLoginToAccountWithHttpInfo(DemoModeLoginToAccount demoModeLoginToAccount,) async {
    // ignore: prefer_const_declarations
    final path = r'/sBH-LyNGOOFXivrv5clCpNrkwcA';

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

  /// Performs an HTTP 'POST /oDv1gK4Y6nMrPgEo5nArQAckh6Q' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [DemoModeToken] demoModeToken (required):
  Future<Response> postDemoModeRegisterAccountWithHttpInfo(DemoModeToken demoModeToken,) async {
    // ignore: prefer_const_declarations
    final path = r'/oDv1gK4Y6nMrPgEo5nArQAckh6Q';

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

  /// Performs an HTTP 'POST /b5kd4x8_ybr1Rj_tprU5BxF_xGo' operation and returns the [Response].
  Future<Response> postGetNextClientIdWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/b5kd4x8_ybr1Rj_tprU5BxF_xGo';

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

  /// Performs an HTTP 'POST /i9QOC8N-Nx9PdWvjKyAz8tXD2Q0' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] locale (required):
  ///
  /// * [NewsIteratorSessionId] newsIteratorSessionId (required):
  Future<Response> postGetNextNewsPageWithHttpInfo(String locale, NewsIteratorSessionId newsIteratorSessionId,) async {
    // ignore: prefer_const_declarations
    final path = r'/i9QOC8N-Nx9PdWvjKyAz8tXD2Q0';

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

  /// Performs an HTTP 'POST /BQwxuLNWbM8vN0-p-Wu-QCRy3x0' operation and returns the [Response].
  Future<Response> postResetNewsPagingWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/BQwxuLNWbM8vN0-p-Wu-QCRy3x0';

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

  /// Start new session with sign in with Apple or Google. Creates new account if it does not exists.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [SignInWithLoginInfo] signInWithLoginInfo (required):
  Future<Response> postSignInWithLoginWithHttpInfo(SignInWithLoginInfo signInWithLoginInfo,) async {
    // ignore: prefer_const_declarations
    final path = r'/ijts6B4AAg_6Dyjhaw85iBnw5Bo';

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
    final path = r'/yG0OQXcMed-EGdvhSoq3qlXTYQc';

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

  /// Performs an HTTP 'PUT /oKbgnRxyzLb50Y2_ZCuLJYtEIcM' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [BooleanSetting] booleanSetting (required):
  Future<Response> putSettingUnlimitedLikesWithHttpInfo(BooleanSetting booleanSetting,) async {
    // ignore: prefer_const_declarations
    final path = r'/oKbgnRxyzLb50Y2_ZCuLJYtEIcM';

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
