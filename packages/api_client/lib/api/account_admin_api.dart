//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class AccountAdminApi {
  AccountAdminApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Performs an HTTP 'DELETE /ca0uk9qgmQ82WCpd83_WNNn8qOY/{nid}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [int] nid (required):
  Future<Response> deleteNewsItemWithHttpInfo(int nid,) async {
    // ignore: prefer_const_declarations
    final path = r'/ca0uk9qgmQ82WCpd83_WNNn8qOY/{nid}'
      .replaceAll('{nid}', nid.toString());

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

  /// Parameters:
  ///
  /// * [int] nid (required):
  Future<void> deleteNewsItem(int nid,) async {
    final response = await deleteNewsItemWithHttpInfo(nid,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'DELETE /jo1Lboa4U8YVA07py8NJebpu1zo/{nid}/{locale}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [int] nid (required):
  ///
  /// * [String] locale (required):
  Future<Response> deleteNewsTranslationWithHttpInfo(int nid, String locale,) async {
    // ignore: prefer_const_declarations
    final path = r'/jo1Lboa4U8YVA07py8NJebpu1zo/{nid}/{locale}'
      .replaceAll('{nid}', nid.toString())
      .replaceAll('{locale}', locale);

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

  /// Parameters:
  ///
  /// * [int] nid (required):
  ///
  /// * [String] locale (required):
  Future<void> deleteNewsTranslation(int nid, String locale,) async {
    final response = await deleteNewsTranslationWithHttpInfo(nid, locale,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Get account ID from email
  ///
  /// # Access  Permission [model_account::Permissions::admin_find_account_by_email] is required.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] email (required):
  Future<Response> getAccountIdFromEmailWithHttpInfo(String email,) async {
    // ignore: prefer_const_declarations
    final path = r'/QOWhJ4V6cg9BzbwLCnopDKA6eEM/{email}'
      .replaceAll('{email}', email);

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

  /// Get account ID from email
  ///
  /// # Access  Permission [model_account::Permissions::admin_find_account_by_email] is required.
  ///
  /// Parameters:
  ///
  /// * [String] email (required):
  Future<GetAccountIdFromEmailResult?> getAccountIdFromEmail(String email,) async {
    final response = await getAccountIdFromEmailWithHttpInfo(email,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'GetAccountIdFromEmailResult',) as GetAccountIdFromEmailResult;
    
    }
    return null;
  }

  /// Get [model::Account] for specific account.
  ///
  /// # Access  Permission [model_account::Permissions::admin_view_private_info] is required.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  Future<Response> getAccountStateAdminWithHttpInfo(String aid,) async {
    // ignore: prefer_const_declarations
    final path = r'/SJd6qnB7ZOLWObvYpZvSEAQlV9E/{aid}'
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

  /// Get [model::Account] for specific account.
  ///
  /// # Access  Permission [model_account::Permissions::admin_view_private_info] is required.
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  Future<Account?> getAccountStateAdmin(String aid,) async {
    final response = await getAccountStateAdminWithHttpInfo(aid,);
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

  /// Get all admins
  ///
  /// # Access  Permission [model_account::Permissions::admin_view_private_info] is required.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getAllAdminsWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/S08JTRmVrgj4MoI2AYsbMMcfpoU';

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

  /// Get all admins
  ///
  /// # Access  Permission [model_account::Permissions::admin_view_private_info] is required.
  Future<GetAllAdminsResult?> getAllAdmins() async {
    final response = await getAllAdminsWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'GetAllAdminsResult',) as GetAllAdminsResult;
    
    }
    return null;
  }

  /// Performs an HTTP 'POST /XEss8YDw9lPgwKoH6K9THZIF_N4' operation and returns the [Response].
  Future<Response> postCreateNewsItemWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/XEss8YDw9lPgwKoH6K9THZIF_N4';

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

  Future<NewsId?> postCreateNewsItem() async {
    final response = await postCreateNewsItemWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'NewsId',) as NewsId;
    
    }
    return null;
  }

  /// Delete account instantly
  ///
  /// # Access  Permission [model_account::Permissions::admin_delete_account] is required.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  Future<Response> postDeleteAccountWithHttpInfo(String aid,) async {
    // ignore: prefer_const_declarations
    final path = r'/bdvzsZZOVVO89-enOb3tFnpU7yk/{aid}'
      .replaceAll('{aid}', aid);

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

  /// Delete account instantly
  ///
  /// # Access  Permission [model_account::Permissions::admin_delete_account] is required.
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  Future<void> postDeleteAccount(String aid,) async {
    final response = await postDeleteAccountWithHttpInfo(aid,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Ban or unban account
  ///
  /// # Access  Permission [model_account::Permissions::admin_ban_account] is required.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [SetAccountBanState] setAccountBanState (required):
  Future<Response> postSetBanStateWithHttpInfo(SetAccountBanState setAccountBanState,) async {
    // ignore: prefer_const_declarations
    final path = r'/R5G1j887_zSwcgInJG5Y7mz73nE';

    // ignore: prefer_final_locals
    Object? postBody = setAccountBanState;

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

  /// Ban or unban account
  ///
  /// # Access  Permission [model_account::Permissions::admin_ban_account] is required.
  ///
  /// Parameters:
  ///
  /// * [SetAccountBanState] setAccountBanState (required):
  Future<void> postSetBanState(SetAccountBanState setAccountBanState,) async {
    final response = await postSetBanStateWithHttpInfo(setAccountBanState,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'DELETE /McvctMKFEqrUfola2WlvkbigBDU/{nid}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [int] nid (required):
  ///
  /// * [BooleanSetting] booleanSetting (required):
  Future<Response> postSetNewsPublicityWithHttpInfo(int nid, BooleanSetting booleanSetting,) async {
    // ignore: prefer_const_declarations
    final path = r'/McvctMKFEqrUfola2WlvkbigBDU/{nid}'
      .replaceAll('{nid}', nid.toString());

    // ignore: prefer_final_locals
    Object? postBody = booleanSetting;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


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

  /// Parameters:
  ///
  /// * [int] nid (required):
  ///
  /// * [BooleanSetting] booleanSetting (required):
  Future<void> postSetNewsPublicity(int nid, BooleanSetting booleanSetting,) async {
    final response = await postSetNewsPublicityWithHttpInfo(nid, booleanSetting,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Set permissions for account
  ///
  /// # Access  Permission [model_account::Permissions::admin_modify_permissions] is required.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  ///
  /// * [Permissions] permissions (required):
  Future<Response> postSetPermissionsWithHttpInfo(String aid, Permissions permissions,) async {
    // ignore: prefer_const_declarations
    final path = r'/dVzZRtEelHVDz6bG4AcjaZSQVFo/{aid}'
      .replaceAll('{aid}', aid);

    // ignore: prefer_final_locals
    Object? postBody = permissions;

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

  /// Set permissions for account
  ///
  /// # Access  Permission [model_account::Permissions::admin_modify_permissions] is required.
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  ///
  /// * [Permissions] permissions (required):
  Future<void> postSetPermissions(String aid, Permissions permissions,) async {
    final response = await postSetPermissionsWithHttpInfo(aid, permissions,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /4pD-Q4FhZGTNkUGYExHmZN6TxjU/{nid}/{locale}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [int] nid (required):
  ///
  /// * [String] locale (required):
  ///
  /// * [UpdateNewsTranslation] updateNewsTranslation (required):
  Future<Response> postUpdateNewsTranslationWithHttpInfo(int nid, String locale, UpdateNewsTranslation updateNewsTranslation,) async {
    // ignore: prefer_const_declarations
    final path = r'/4pD-Q4FhZGTNkUGYExHmZN6TxjU/{nid}/{locale}'
      .replaceAll('{nid}', nid.toString())
      .replaceAll('{locale}', locale);

    // ignore: prefer_final_locals
    Object? postBody = updateNewsTranslation;

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
  /// * [int] nid (required):
  ///
  /// * [String] locale (required):
  ///
  /// * [UpdateNewsTranslation] updateNewsTranslation (required):
  Future<UpdateNewsTranslationResult?> postUpdateNewsTranslation(int nid, String locale, UpdateNewsTranslation updateNewsTranslation,) async {
    final response = await postUpdateNewsTranslationWithHttpInfo(nid, locale, updateNewsTranslation,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'UpdateNewsTranslationResult',) as UpdateNewsTranslationResult;
    
    }
    return null;
  }
}
