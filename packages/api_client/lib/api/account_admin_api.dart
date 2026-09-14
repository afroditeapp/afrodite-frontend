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

  /// Performs an HTTP 'DELETE /account_api/delete_news/{nid}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [int] nid (required):
  Future<Response> deleteNewsItemWithHttpInfo(int nid, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/delete_news/{nid}'
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
      abortTrigger: abortTrigger,
    );
  }

  /// Parameters:
  ///
  /// * [int] nid (required):
  Future<void> deleteNewsItem(int nid, { Future<void>? abortTrigger, }) async {
    final response = await deleteNewsItemWithHttpInfo(nid, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'DELETE /account_api/delete_news_translation/{nid}/{locale}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [int] nid (required):
  ///
  /// * [String] locale (required):
  Future<Response> deleteNewsTranslationWithHttpInfo(int nid, String locale, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/delete_news_translation/{nid}/{locale}'
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
      abortTrigger: abortTrigger,
    );
  }

  /// Parameters:
  ///
  /// * [int] nid (required):
  ///
  /// * [String] locale (required):
  Future<void> deleteNewsTranslation(int nid, String locale, { Future<void>? abortTrigger, }) async {
    final response = await deleteNewsTranslationWithHttpInfo(nid, locale, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Get account ID from email
  ///
  /// # Access  Permission [model_account::Permissions::admin_find_account_by_email_address] is required.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] email (required):
  Future<Response> getAccountIdFromEmailWithHttpInfo(String email, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/get_account_id_from_email/{email}'
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
      abortTrigger: abortTrigger,
    );
  }

  /// Get account ID from email
  ///
  /// # Access  Permission [model_account::Permissions::admin_find_account_by_email_address] is required.
  ///
  /// Parameters:
  ///
  /// * [String] email (required):
  Future<GetAccountIdFromEmailResult?> getAccountIdFromEmail(String email, { Future<void>? abortTrigger, }) async {
    final response = await getAccountIdFromEmailWithHttpInfo(email, abortTrigger: abortTrigger,);
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

  /// Get account locked state
  ///
  /// # Access  Permission [model::Permissions::admin_view_login] is required.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  Future<Response> getAccountLockedStateWithHttpInfo(String aid, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/get_account_locked_state/{aid}'
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
      abortTrigger: abortTrigger,
    );
  }

  /// Get account locked state
  ///
  /// # Access  Permission [model::Permissions::admin_view_login] is required.
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  Future<AccountLockedState?> getAccountLockedState(String aid, { Future<void>? abortTrigger, }) async {
    final response = await getAccountLockedStateWithHttpInfo(aid, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'AccountLockedState',) as AccountLockedState;
    
    }
    return null;
  }

  /// Get login session info for specific account.
  ///
  /// This includes the client platform and app attestation details of the last login session.  # Access  Permission [model::Permissions::admin_view_login] is required.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  Future<Response> getAccountLoginSessionInfoWithHttpInfo(String aid, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/get_account_login_session_info/{aid}'
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
      abortTrigger: abortTrigger,
    );
  }

  /// Get login session info for specific account.
  ///
  /// This includes the client platform and app attestation details of the last login session.  # Access  Permission [model::Permissions::admin_view_login] is required.
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  Future<GetAccountLoginSessionInfo?> getAccountLoginSessionInfo(String aid, { Future<void>? abortTrigger, }) async {
    final response = await getAccountLoginSessionInfoWithHttpInfo(aid, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'GetAccountLoginSessionInfo',) as GetAccountLoginSessionInfo;
    
    }
    return null;
  }

  /// Get [model::Account] for specific account.
  ///
  /// # Access  Permission [model::Permissions::admin_view_account_state] is required.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  Future<Response> getAccountStateAdminWithHttpInfo(String aid, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/get_account_state_admin/{aid}'
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
      abortTrigger: abortTrigger,
    );
  }

  /// Get [model::Account] for specific account.
  ///
  /// # Access  Permission [model::Permissions::admin_view_account_state] is required.
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  Future<Account?> getAccountStateAdmin(String aid, { Future<void>? abortTrigger, }) async {
    final response = await getAccountStateAdminWithHttpInfo(aid, abortTrigger: abortTrigger,);
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

  /// Get next item in account verification queue.
  ///
  /// # Access * Permission [model::Permissions::admin_verify_account]
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getAccountVerificationQueueNextItemWithHttpInfo({ Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/account_verification_queue_next_item';

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
      abortTrigger: abortTrigger,
    );
  }

  /// Get next item in account verification queue.
  ///
  /// # Access * Permission [model::Permissions::admin_verify_account]
  Future<GetAccountVerificationQueueNextItemResult?> getAccountVerificationQueueNextItem({ Future<void>? abortTrigger, }) async {
    final response = await getAccountVerificationQueueNextItemWithHttpInfo(abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'GetAccountVerificationQueueNextItemResult',) as GetAccountVerificationQueueNextItemResult;
    
    }
    return null;
  }

  /// Get all admins
  ///
  /// # Access  Permission [model_account::Permissions::admin_view_permissions] is required.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getAllAdminsWithHttpInfo({ Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/get_all_admins';

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
      abortTrigger: abortTrigger,
    );
  }

  /// Get all admins
  ///
  /// # Access  Permission [model_account::Permissions::admin_view_permissions] is required.
  Future<GetAllAdminsResult?> getAllAdmins({ Future<void>? abortTrigger, }) async {
    final response = await getAllAdminsWithHttpInfo(abortTrigger: abortTrigger,);
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

  /// Performs an HTTP 'GET /account_api/custom_email_config' operation and returns the [Response].
  Future<Response> getCustomEmailConfigWithHttpInfo({ Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/custom_email_config';

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
      abortTrigger: abortTrigger,
    );
  }

  Future<GetCustomEmailConfig?> getCustomEmailConfig({ Future<void>? abortTrigger, }) async {
    final response = await getCustomEmailConfigWithHttpInfo(abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'GetCustomEmailConfig',) as GetCustomEmailConfig;
    
    }
    return null;
  }

  /// List all custom emails, newest first.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] page (required):
  Future<Response> getCustomEmailListWithHttpInfo(int page, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/custom_email_list';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'page', page));

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// List all custom emails, newest first.
  ///
  /// Parameters:
  ///
  /// * [int] page (required):
  Future<List<CustomEmail>?> getCustomEmailList(int page, { Future<void>? abortTrigger, }) async {
    final response = await getCustomEmailListWithHttpInfo(page, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<CustomEmail>') as List)
        .cast<CustomEmail>()
        .toList(growable: false);

    }
    return null;
  }

  /// Get email address state for admin.
  ///
  /// Requires `admin_view_email_address` permission.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  Future<Response> getEmailAddressStateAdminWithHttpInfo(String aid, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/email_address_state_admin/{aid}'
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
      abortTrigger: abortTrigger,
    );
  }

  /// Get email address state for admin.
  ///
  /// Requires `admin_view_email_address` permission.
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  Future<EmailAddressStateAdmin?> getEmailAddressStateAdmin(String aid, { Future<void>? abortTrigger, }) async {
    final response = await getEmailAddressStateAdminWithHttpInfo(aid, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'EmailAddressStateAdmin',) as EmailAddressStateAdmin;
    
    }
    return null;
  }

  /// Get the manual association membership registry.
  ///
  /// # Access  Permission [model::Permissions::admin_view_association_membership] is required.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getManualAssociationMembershipRegistryWithHttpInfo({ Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/manual_association_membership_registry';

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
      abortTrigger: abortTrigger,
    );
  }

  /// Get the manual association membership registry.
  ///
  /// # Access  Permission [model::Permissions::admin_view_association_membership] is required.
  Future<ManualAssociationMembershipRegistry?> getManualAssociationMembershipRegistry({ Future<void>? abortTrigger, }) async {
    final response = await getManualAssociationMembershipRegistryWithHttpInfo(abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ManualAssociationMembershipRegistry',) as ManualAssociationMembershipRegistry;
    
    }
    return null;
  }

  /// Get [model::Permissions] for specific account.
  ///
  /// # Access  Permission [model::Permissions::admin_view_permissions] is required.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  Future<Response> getPermissionsWithHttpInfo(String aid, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/get_permissions/{aid}'
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
      abortTrigger: abortTrigger,
    );
  }

  /// Get [model::Permissions] for specific account.
  ///
  /// # Access  Permission [model::Permissions::admin_view_permissions] is required.
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  Future<Permissions?> getPermissions(String aid, { Future<void>? abortTrigger, }) async {
    final response = await getPermissionsWithHttpInfo(aid, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Permissions',) as Permissions;
    
    }
    return null;
  }

  /// Remove next item from account verification queue if possible.
  ///
  /// Removal succeeds only when the provided account id matches queue head item owner. No error is returned if there is a mismatch.  # Access * Permission [model::Permissions::admin_verify_account]
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [PostAccountVerificationQueueRemoveNextItem] postAccountVerificationQueueRemoveNextItem (required):
  Future<Response> postAccountVerificationQueueRemoveNextItemWithHttpInfo(PostAccountVerificationQueueRemoveNextItem postAccountVerificationQueueRemoveNextItem, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/account_verification_queue_remove_next_item';

    // ignore: prefer_final_locals
    Object? postBody = postAccountVerificationQueueRemoveNextItem;

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
      abortTrigger: abortTrigger,
    );
  }

  /// Remove next item from account verification queue if possible.
  ///
  /// Removal succeeds only when the provided account id matches queue head item owner. No error is returned if there is a mismatch.  # Access * Permission [model::Permissions::admin_verify_account]
  ///
  /// Parameters:
  ///
  /// * [PostAccountVerificationQueueRemoveNextItem] postAccountVerificationQueueRemoveNextItem (required):
  Future<void> postAccountVerificationQueueRemoveNextItem(PostAccountVerificationQueueRemoveNextItem postAccountVerificationQueueRemoveNextItem, { Future<void>? abortTrigger, }) async {
    final response = await postAccountVerificationQueueRemoveNextItemWithHttpInfo(postAccountVerificationQueueRemoveNextItem, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Cancel email changing process for any account.
  ///
  /// # Access  Permission [model::Permissions::admin_change_email_address] is required.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  Future<Response> postAdminCancelEmailChangeWithHttpInfo(String aid, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/admin_cancel_email_change/{aid}'
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
      abortTrigger: abortTrigger,
    );
  }

  /// Cancel email changing process for any account.
  ///
  /// # Access  Permission [model::Permissions::admin_change_email_address] is required.
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  Future<void> postAdminCancelEmailChange(String aid, { Future<void>? abortTrigger, }) async {
    final response = await postAdminCancelEmailChangeWithHttpInfo(aid, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Initiate email change process for any account by providing a new email address.
  ///
  /// This is the admin version of the email change endpoint.  # Access  Permission [model::Permissions::admin_change_email_address] is required.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [InitEmailChangeAdmin] initEmailChangeAdmin (required):
  Future<Response> postAdminInitEmailChangeWithHttpInfo(InitEmailChangeAdmin initEmailChangeAdmin, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/admin_init_email_change';

    // ignore: prefer_final_locals
    Object? postBody = initEmailChangeAdmin;

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
      abortTrigger: abortTrigger,
    );
  }

  /// Initiate email change process for any account by providing a new email address.
  ///
  /// This is the admin version of the email change endpoint.  # Access  Permission [model::Permissions::admin_change_email_address] is required.
  ///
  /// Parameters:
  ///
  /// * [InitEmailChangeAdmin] initEmailChangeAdmin (required):
  Future<InitEmailChangeResult?> postAdminInitEmailChange(InitEmailChangeAdmin initEmailChangeAdmin, { Future<void>? abortTrigger, }) async {
    final response = await postAdminInitEmailChangeWithHttpInfo(initEmailChangeAdmin, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'InitEmailChangeResult',) as InitEmailChangeResult;
    
    }
    return null;
  }

  /// Logout any account
  ///
  /// # Access  Permission [model::Permissions::admin_edit_login] is required.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  Future<Response> postAdminLogoutWithHttpInfo(String aid, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/admin_logout/{aid}'
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
      abortTrigger: abortTrigger,
    );
  }

  /// Logout any account
  ///
  /// # Access  Permission [model::Permissions::admin_edit_login] is required.
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  Future<void> postAdminLogout(String aid, { Future<void>? abortTrigger, }) async {
    final response = await postAdminLogoutWithHttpInfo(aid, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Create a new custom email message draft.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> postCreateCustomEmailWithHttpInfo({ Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/create_custom_email';

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
      abortTrigger: abortTrigger,
    );
  }

  /// Create a new custom email message draft.
  Future<CustomEmailId?> postCreateCustomEmail({ Future<void>? abortTrigger, }) async {
    final response = await postCreateCustomEmailWithHttpInfo(abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'CustomEmailId',) as CustomEmailId;
    
    }
    return null;
  }

  /// Performs an HTTP 'POST /account_api/create_news_item' operation and returns the [Response].
  Future<Response> postCreateNewsItemWithHttpInfo({ Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/create_news_item';

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
      abortTrigger: abortTrigger,
    );
  }

  Future<NewsId?> postCreateNewsItem({ Future<void>? abortTrigger, }) async {
    final response = await postCreateNewsItemWithHttpInfo(abortTrigger: abortTrigger,);
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
  Future<Response> postDeleteAccountWithHttpInfo(String aid, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/delete_account/{aid}'
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
      abortTrigger: abortTrigger,
    );
  }

  /// Delete account instantly
  ///
  /// # Access  Permission [model_account::Permissions::admin_delete_account] is required.
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  Future<void> postDeleteAccount(String aid, { Future<void>? abortTrigger, }) async {
    final response = await postDeleteAccountWithHttpInfo(aid, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Remove association membership of an account.
  ///
  /// # Access  Permission [model::Permissions::admin_edit_association_membership] is required.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [AccountId] accountId (required):
  Future<Response> postDeleteAssociationMembershipWithHttpInfo(AccountId accountId, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/delete_association_membership';

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
      abortTrigger: abortTrigger,
    );
  }

  /// Remove association membership of an account.
  ///
  /// # Access  Permission [model::Permissions::admin_edit_association_membership] is required.
  ///
  /// Parameters:
  ///
  /// * [AccountId] accountId (required):
  Future<void> postDeleteAssociationMembership(AccountId accountId, { Future<void>? abortTrigger, }) async {
    final response = await postDeleteAssociationMembershipWithHttpInfo(accountId, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Get a single association member entry for an account.
  ///
  /// # Access  Permission [model::Permissions::admin_view_association_membership] is required.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [AccountId] accountId (required):
  Future<Response> postGetAssociationMemberWithHttpInfo(AccountId accountId, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/association_member';

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
      abortTrigger: abortTrigger,
    );
  }

  /// Get a single association member entry for an account.
  ///
  /// # Access  Permission [model::Permissions::admin_view_association_membership] is required.
  ///
  /// Parameters:
  ///
  /// * [AccountId] accountId (required):
  Future<GetAssociationMember?> postGetAssociationMember(AccountId accountId, { Future<void>? abortTrigger, }) async {
    final response = await postGetAssociationMemberWithHttpInfo(accountId, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'GetAssociationMember',) as GetAssociationMember;
    
    }
    return null;
  }

  /// Get a paged list of association members with an account.
  ///
  /// # Access  Permission [model::Permissions::admin_view_association_membership] is required.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [GetAssociationMembersPage] getAssociationMembersPage (required):
  Future<Response> postGetAssociationMembersPageWithHttpInfo(GetAssociationMembersPage getAssociationMembersPage, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/association_members_page';

    // ignore: prefer_final_locals
    Object? postBody = getAssociationMembersPage;

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
      abortTrigger: abortTrigger,
    );
  }

  /// Get a paged list of association members with an account.
  ///
  /// # Access  Permission [model::Permissions::admin_view_association_membership] is required.
  ///
  /// Parameters:
  ///
  /// * [GetAssociationMembersPage] getAssociationMembersPage (required):
  Future<AssociationMembersPage?> postGetAssociationMembersPage(GetAssociationMembersPage getAssociationMembersPage, { Future<void>? abortTrigger, }) async {
    final response = await postGetAssociationMembersPageWithHttpInfo(getAssociationMembersPage, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'AssociationMembersPage',) as AssociationMembersPage;
    
    }
    return null;
  }

  /// Get client version statistics.
  ///
  /// HTTP method is POST to allow JSON request body.  # Permissions Requires admin_server_view_info.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [GetClientVersionStatisticsSettings] getClientVersionStatisticsSettings (required):
  Future<Response> postGetClientVersionStatisticsWithHttpInfo(GetClientVersionStatisticsSettings getClientVersionStatisticsSettings, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/client_version_statistics';

    // ignore: prefer_final_locals
    Object? postBody = getClientVersionStatisticsSettings;

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
      abortTrigger: abortTrigger,
    );
  }

  /// Get client version statistics.
  ///
  /// HTTP method is POST to allow JSON request body.  # Permissions Requires admin_server_view_info.
  ///
  /// Parameters:
  ///
  /// * [GetClientVersionStatisticsSettings] getClientVersionStatisticsSettings (required):
  Future<GetClientVersionStatisticsResult?> postGetClientVersionStatistics(GetClientVersionStatisticsSettings getClientVersionStatisticsSettings, { Future<void>? abortTrigger, }) async {
    final response = await postGetClientVersionStatisticsWithHttpInfo(getClientVersionStatisticsSettings, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'GetClientVersionStatisticsResult',) as GetClientVersionStatisticsResult;
    
    }
    return null;
  }

  /// Set the manual association membership registry.
  ///
  /// # Access  Permission [model::Permissions::admin_edit_association_membership] is required.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [ManualAssociationMembershipRegistryInput] manualAssociationMembershipRegistryInput (required):
  Future<Response> postManualAssociationMembershipRegistryWithHttpInfo(ManualAssociationMembershipRegistryInput manualAssociationMembershipRegistryInput, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/manual_association_membership_registry';

    // ignore: prefer_final_locals
    Object? postBody = manualAssociationMembershipRegistryInput;

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
      abortTrigger: abortTrigger,
    );
  }

  /// Set the manual association membership registry.
  ///
  /// # Access  Permission [model::Permissions::admin_edit_association_membership] is required.
  ///
  /// Parameters:
  ///
  /// * [ManualAssociationMembershipRegistryInput] manualAssociationMembershipRegistryInput (required):
  Future<void> postManualAssociationMembershipRegistry(ManualAssociationMembershipRegistryInput manualAssociationMembershipRegistryInput, { Future<void>? abortTrigger, }) async {
    final response = await postManualAssociationMembershipRegistryWithHttpInfo(manualAssociationMembershipRegistryInput, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Save info banners to dynamic client config.
  ///
  /// Existing banners cannot be removed.  Don't edit [model:InfoBanner::version] field as server will update that.  # Access  Permission [model::Permissions::admin_server_edit_info_banners] is required.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [SaveInfoBanners] saveInfoBanners (required):
  Future<Response> postSaveInfoBannersWithHttpInfo(SaveInfoBanners saveInfoBanners, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/save_info_banners';

    // ignore: prefer_final_locals
    Object? postBody = saveInfoBanners;

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
      abortTrigger: abortTrigger,
    );
  }

  /// Save info banners to dynamic client config.
  ///
  /// Existing banners cannot be removed.  Don't edit [model:InfoBanner::version] field as server will update that.  # Access  Permission [model::Permissions::admin_server_edit_info_banners] is required.
  ///
  /// Parameters:
  ///
  /// * [SaveInfoBanners] saveInfoBanners (required):
  Future<void> postSaveInfoBanners(SaveInfoBanners saveInfoBanners, { Future<void>? abortTrigger, }) async {
    final response = await postSaveInfoBannersWithHttpInfo(saveInfoBanners, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /account_api/send_custom_email_draft_to_my_email_address' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [SendCustomEmail] sendCustomEmail (required):
  Future<Response> postSendCustomEmailDraftToMyEmailAddressWithHttpInfo(SendCustomEmail sendCustomEmail, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/send_custom_email_draft_to_my_email_address';

    // ignore: prefer_final_locals
    Object? postBody = sendCustomEmail;

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
      abortTrigger: abortTrigger,
    );
  }

  /// Parameters:
  ///
  /// * [SendCustomEmail] sendCustomEmail (required):
  Future<void> postSendCustomEmailDraftToMyEmailAddress(SendCustomEmail sendCustomEmail, { Future<void>? abortTrigger, }) async {
    final response = await postSendCustomEmailDraftToMyEmailAddressWithHttpInfo(sendCustomEmail, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /account_api/send_custom_email_to_all_accounts' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [SendCustomEmail] sendCustomEmail (required):
  Future<Response> postSendCustomEmailToAllAccountsWithHttpInfo(SendCustomEmail sendCustomEmail, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/send_custom_email_to_all_accounts';

    // ignore: prefer_final_locals
    Object? postBody = sendCustomEmail;

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
      abortTrigger: abortTrigger,
    );
  }

  /// Parameters:
  ///
  /// * [SendCustomEmail] sendCustomEmail (required):
  Future<void> postSendCustomEmailToAllAccounts(SendCustomEmail sendCustomEmail, { Future<void>? abortTrigger, }) async {
    final response = await postSendCustomEmailToAllAccountsWithHttpInfo(sendCustomEmail, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Set account locked state
  ///
  /// # Access  Permission [model::Permissions::admin_edit_login] is required.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  ///
  /// * [AccountLockedState] accountLockedState (required):
  Future<Response> postSetAccountLockedStateWithHttpInfo(String aid, AccountLockedState accountLockedState, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/set_account_locked_state/{aid}'
      .replaceAll('{aid}', aid);

    // ignore: prefer_final_locals
    Object? postBody = accountLockedState;

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
      abortTrigger: abortTrigger,
    );
  }

  /// Set account locked state
  ///
  /// # Access  Permission [model::Permissions::admin_edit_login] is required.
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  ///
  /// * [AccountLockedState] accountLockedState (required):
  Future<void> postSetAccountLockedState(String aid, AccountLockedState accountLockedState, { Future<void>? abortTrigger, }) async {
    final response = await postSetAccountLockedStateWithHttpInfo(aid, accountLockedState, abortTrigger: abortTrigger,);
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
  Future<Response> postSetBanStateWithHttpInfo(SetAccountBanState setAccountBanState, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/set_ban_state';

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
      abortTrigger: abortTrigger,
    );
  }

  /// Ban or unban account
  ///
  /// # Access  Permission [model_account::Permissions::admin_ban_account] is required.
  ///
  /// Parameters:
  ///
  /// * [SetAccountBanState] setAccountBanState (required):
  Future<void> postSetBanState(SetAccountBanState setAccountBanState, { Future<void>? abortTrigger, }) async {
    final response = await postSetBanStateWithHttpInfo(setAccountBanState, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'DELETE /account_api/set_news_publicity/{nid}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [int] nid (required):
  ///
  /// * [BooleanSetting] booleanSetting (required):
  Future<Response> postSetNewsPublicityWithHttpInfo(int nid, BooleanSetting booleanSetting, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/set_news_publicity/{nid}'
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
      abortTrigger: abortTrigger,
    );
  }

  /// Parameters:
  ///
  /// * [int] nid (required):
  ///
  /// * [BooleanSetting] booleanSetting (required):
  Future<void> postSetNewsPublicity(int nid, BooleanSetting booleanSetting, { Future<void>? abortTrigger, }) async {
    final response = await postSetNewsPublicityWithHttpInfo(nid, booleanSetting, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Set permissions for account
  ///
  /// # Access  Permission [model_account::Permissions::admin_edit_permissions] is required.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  ///
  /// * [Permissions] permissions (required):
  Future<Response> postSetPermissionsWithHttpInfo(String aid, Permissions permissions, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/set_permissions/{aid}'
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
      abortTrigger: abortTrigger,
    );
  }

  /// Set permissions for account
  ///
  /// # Access  Permission [model_account::Permissions::admin_edit_permissions] is required.
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  ///
  /// * [Permissions] permissions (required):
  Future<void> postSetPermissions(String aid, Permissions permissions, { Future<void>? abortTrigger, }) async {
    final response = await postSetPermissionsWithHttpInfo(aid, permissions, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Change the membership type of an existing association membership.
  ///
  /// # Access  Permission [model::Permissions::admin_edit_association_membership] is required.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [UpdateAssociationMembershipType] updateAssociationMembershipType (required):
  Future<Response> postUpdateAssociationMembershipTypeWithHttpInfo(UpdateAssociationMembershipType updateAssociationMembershipType, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/update_association_membership_type';

    // ignore: prefer_final_locals
    Object? postBody = updateAssociationMembershipType;

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
      abortTrigger: abortTrigger,
    );
  }

  /// Change the membership type of an existing association membership.
  ///
  /// # Access  Permission [model::Permissions::admin_edit_association_membership] is required.
  ///
  /// Parameters:
  ///
  /// * [UpdateAssociationMembershipType] updateAssociationMembershipType (required):
  Future<void> postUpdateAssociationMembershipType(UpdateAssociationMembershipType updateAssociationMembershipType, { Future<void>? abortTrigger, }) async {
    final response = await postUpdateAssociationMembershipTypeWithHttpInfo(updateAssociationMembershipType, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Update a custom email message draft.
  ///
  /// Translation with \"default\" locale must exist and all translations must have non empty subject and body.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [UpdateCustomEmail] updateCustomEmail (required):
  Future<Response> postUpdateCustomEmailWithHttpInfo(UpdateCustomEmail updateCustomEmail, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/update_custom_email';

    // ignore: prefer_final_locals
    Object? postBody = updateCustomEmail;

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
      abortTrigger: abortTrigger,
    );
  }

  /// Update a custom email message draft.
  ///
  /// Translation with \"default\" locale must exist and all translations must have non empty subject and body.
  ///
  /// Parameters:
  ///
  /// * [UpdateCustomEmail] updateCustomEmail (required):
  Future<void> postUpdateCustomEmail(UpdateCustomEmail updateCustomEmail, { Future<void>? abortTrigger, }) async {
    final response = await postUpdateCustomEmailWithHttpInfo(updateCustomEmail, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /account_api/update_news_translation/{nid}/{locale}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [int] nid (required):
  ///
  /// * [String] locale (required):
  ///
  /// * [UpdateNewsTranslation] updateNewsTranslation (required):
  Future<Response> postUpdateNewsTranslationWithHttpInfo(int nid, String locale, UpdateNewsTranslation updateNewsTranslation, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/update_news_translation/{nid}/{locale}'
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
      abortTrigger: abortTrigger,
    );
  }

  /// Parameters:
  ///
  /// * [int] nid (required):
  ///
  /// * [String] locale (required):
  ///
  /// * [UpdateNewsTranslation] updateNewsTranslation (required):
  Future<UpdateNewsTranslationResult?> postUpdateNewsTranslation(int nid, String locale, UpdateNewsTranslation updateNewsTranslation, { Future<void>? abortTrigger, }) async {
    final response = await postUpdateNewsTranslationWithHttpInfo(nid, locale, updateNewsTranslation, abortTrigger: abortTrigger,);
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
