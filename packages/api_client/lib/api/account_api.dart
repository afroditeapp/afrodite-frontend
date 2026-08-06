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

  /// Remove association membership.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> deleteAssociationMembershipWithHttpInfo({ Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/association_membership';

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

  /// Remove association membership.
  Future<void> deleteAssociationMembership({ Future<void>? abortTrigger, }) async {
    final response = await deleteAssociationMembershipWithHttpInfo(abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'GET /account_api/get_account_app_notification_settings' operation and returns the [Response].
  Future<Response> getAccountAppNotificationSettingsWithHttpInfo({ Future<void>? abortTrigger, }) async {
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
      abortTrigger: abortTrigger,
    );
  }

  Future<AccountAppNotificationSettings?> getAccountAppNotificationSettings({ Future<void>? abortTrigger, }) async {
    final response = await getAccountAppNotificationSettingsWithHttpInfo(abortTrigger: abortTrigger,);
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
  Future<Response> getAccountBanTimeWithHttpInfo(String aid, { Future<void>? abortTrigger, }) async {
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
      abortTrigger: abortTrigger,
    );
  }

  /// Get account ban time
  ///
  /// # Access - Account owner - Permission [model::Permissions::admin_ban_account]
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  Future<GetAccountBanTimeResult?> getAccountBanTime(String aid, { Future<void>? abortTrigger, }) async {
    final response = await getAccountBanTimeWithHttpInfo(aid, abortTrigger: abortTrigger,);
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

  /// Get account deletion request state
  ///
  /// # Access - Account owner - Permission [model_account::Permissions::admin_request_account_deletion]
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  Future<Response> getAccountDeletionRequestStateWithHttpInfo(String aid, { Future<void>? abortTrigger, }) async {
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
      abortTrigger: abortTrigger,
    );
  }

  /// Get account deletion request state
  ///
  /// # Access - Account owner - Permission [model_account::Permissions::admin_request_account_deletion]
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  Future<GetAccountDeletionRequestResult?> getAccountDeletionRequestState(String aid, { Future<void>? abortTrigger, }) async {
    final response = await getAccountDeletionRequestStateWithHttpInfo(aid, abortTrigger: abortTrigger,);
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

  /// Get current account state.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getAccountStateWithHttpInfo({ Future<void>? abortTrigger, }) async {
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
      abortTrigger: abortTrigger,
    );
  }

  /// Get current account state.
  Future<Account?> getAccountState({ Future<void>? abortTrigger, }) async {
    final response = await getAccountStateWithHttpInfo(abortTrigger: abortTrigger,);
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

  /// Get account verification queue status for current account.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getAccountVerificationQueueStatusWithHttpInfo({ Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/account_verification_queue';

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

  /// Get account verification queue status for current account.
  Future<AccountVerificationQueueStatus?> getAccountVerificationQueueStatus({ Future<void>? abortTrigger, }) async {
    final response = await getAccountVerificationQueueStatusWithHttpInfo(abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'AccountVerificationQueueStatus',) as AccountVerificationQueueStatus;
    
    }
    return null;
  }

  /// Get association members-only info markdown text.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getAssociationMembersOnlyInfoWithHttpInfo({ Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/association_members_only_info';

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

  /// Get association members-only info markdown text.
  Future<GetAssociationMembersOnlyInfo?> getAssociationMembersOnlyInfo({ Future<void>? abortTrigger, }) async {
    final response = await getAssociationMembersOnlyInfoWithHttpInfo(abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'GetAssociationMembersOnlyInfo',) as GetAssociationMembersOnlyInfo;
    
    }
    return null;
  }

  /// Get current association membership.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getAssociationMembershipWithHttpInfo({ Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/association_membership';

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

  /// Get current association membership.
  Future<GetAssociationMembership?> getAssociationMembership({ Future<void>? abortTrigger, }) async {
    final response = await getAssociationMembershipWithHttpInfo(abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'GetAssociationMembership',) as GetAssociationMembership;
    
    }
    return null;
  }

  /// Performs an HTTP 'GET /account_api/email_address_state' operation and returns the [Response].
  Future<Response> getEmailAddressStateWithHttpInfo({ Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/email_address_state';

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

  Future<EmailAddressState?> getEmailAddressState({ Future<void>? abortTrigger, }) async {
    final response = await getEmailAddressStateWithHttpInfo(abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'EmailAddressState',) as EmailAddressState;
    
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
  Future<Response> getNewsItemWithHttpInfo(int nid, String locale, { bool? requireLocale, Future<void>? abortTrigger, }) async {
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
      abortTrigger: abortTrigger,
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
  Future<GetNewsItemResult?> getNewsItem(int nid, String locale, { bool? requireLocale, Future<void>? abortTrigger, }) async {
    final response = await getNewsItemWithHttpInfo(nid, locale, requireLocale: requireLocale, abortTrigger: abortTrigger,);
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

  /// Get current sign in with Apple and Google state.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getSignInWithInfoWithHttpInfo({ Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/sign_in_with_info';

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

  /// Get current sign in with Apple and Google state.
  Future<SignInWithState?> getSignInWithInfo({ Future<void>? abortTrigger, }) async {
    final response = await getSignInWithInfoWithHttpInfo(abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'SignInWithState',) as SignInWithState;
    
    }
    return null;
  }

  /// Show email verification form page. Token is passed via query parameter to prevent email scanners from accidentally verifying the email.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getVerifyEmailWithHttpInfo({ Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/verify_email';

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

  /// Show email verification form page. Token is passed via query parameter to prevent email scanners from accidentally verifying the email.
  Future<void> getVerifyEmail({ Future<void>? abortTrigger, }) async {
    final response = await getVerifyEmailWithHttpInfo(abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Show email change verification form page. Token is passed via query parameter to prevent email scanners from accidentally verifying the new email.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getVerifyNewEmailWithHttpInfo({ Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/verify_new_email';

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

  /// Show email change verification form page. Token is passed via query parameter to prevent email scanners from accidentally verifying the new email.
  Future<void> getVerifyNewEmail({ Future<void>? abortTrigger, }) async {
    final response = await getVerifyNewEmailWithHttpInfo(abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /account_api/post_account_app_notification_settings' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [AccountAppNotificationSettings] accountAppNotificationSettings (required):
  Future<Response> postAccountAppNotificationSettingsWithHttpInfo(AccountAppNotificationSettings accountAppNotificationSettings, { Future<void>? abortTrigger, }) async {
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
      abortTrigger: abortTrigger,
    );
  }

  /// Parameters:
  ///
  /// * [AccountAppNotificationSettings] accountAppNotificationSettings (required):
  Future<void> postAccountAppNotificationSettings(AccountAppNotificationSettings accountAppNotificationSettings, { Future<void>? abortTrigger, }) async {
    final response = await postAccountAppNotificationSettingsWithHttpInfo(accountAppNotificationSettings, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Add account verification request to queue for current account.
  ///
  /// Adding new request requires initial setup to be completed.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [AccountVerificationQueueItem] accountVerificationQueueItem (required):
  Future<Response> postAccountVerificationQueueItemWithHttpInfo(AccountVerificationQueueItem accountVerificationQueueItem, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/account_verification_queue';

    // ignore: prefer_final_locals
    Object? postBody = accountVerificationQueueItem;

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

  /// Add account verification request to queue for current account.
  ///
  /// Adding new request requires initial setup to be completed.
  ///
  /// Parameters:
  ///
  /// * [AccountVerificationQueueItem] accountVerificationQueueItem (required):
  Future<PostAccountVerificationQueueItemResult?> postAccountVerificationQueueItem(AccountVerificationQueueItem accountVerificationQueueItem, { Future<void>? abortTrigger, }) async {
    final response = await postAccountVerificationQueueItemWithHttpInfo(accountVerificationQueueItem, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'PostAccountVerificationQueueItemResult',) as PostAccountVerificationQueueItemResult;
    
    }
    return null;
  }

  /// Verify user's age once for current account.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [PostAgeVerification] postAgeVerification (required):
  Future<Response> postAgeVerificationWithHttpInfo(PostAgeVerification postAgeVerification, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/age_verification';

    // ignore: prefer_final_locals
    Object? postBody = postAgeVerification;

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

  /// Verify user's age once for current account.
  ///
  /// Parameters:
  ///
  /// * [PostAgeVerification] postAgeVerification (required):
  Future<PostAgeVerificationResult?> postAgeVerification(PostAgeVerification postAgeVerification, { Future<void>? abortTrigger, }) async {
    final response = await postAgeVerificationWithHttpInfo(postAgeVerification, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'PostAgeVerificationResult',) as PostAgeVerificationResult;
    
    }
    return null;
  }

  /// Create or update association membership.
  ///
  /// When membership already exists, the full name and domicile fields are editable.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [UpdateAssociationMembership] updateAssociationMembership (required):
  Future<Response> postAssociationMembershipWithHttpInfo(UpdateAssociationMembership updateAssociationMembership, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/association_membership';

    // ignore: prefer_final_locals
    Object? postBody = updateAssociationMembership;

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

  /// Create or update association membership.
  ///
  /// When membership already exists, the full name and domicile fields are editable.
  ///
  /// Parameters:
  ///
  /// * [UpdateAssociationMembership] updateAssociationMembership (required):
  Future<void> postAssociationMembership(UpdateAssociationMembership updateAssociationMembership, { Future<void>? abortTrigger, }) async {
    final response = await postAssociationMembershipWithHttpInfo(updateAssociationMembership, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Cancel email changing process
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> postCancelEmailChangeWithHttpInfo({ Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/cancel_email_change';

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

  /// Cancel email changing process
  Future<void> postCancelEmailChange({ Future<void>? abortTrigger, }) async {
    final response = await postCancelEmailChangeWithHttpInfo(abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Complete initial setup.
  ///
  /// Media content with InSlot state will be removed.  Requirements:  - Account must be in `InitialSetup` state.  
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> postCompleteSetupWithHttpInfo({ Future<void>? abortTrigger, }) async {
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
      abortTrigger: abortTrigger,
    );
  }

  /// Complete initial setup.
  ///
  /// Media content with InSlot state will be removed.  Requirements:  - Account must be in `InitialSetup` state.  
  Future<void> postCompleteSetup({ Future<void>? abortTrigger, }) async {
    final response = await postCompleteSetupWithHttpInfo(abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Send custom report without any content
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [UpdateCustomReportEmpty] updateCustomReportEmpty (required):
  Future<Response> postCustomReportEmptyWithHttpInfo(UpdateCustomReportEmpty updateCustomReportEmpty, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/custom_report_empty';

    // ignore: prefer_final_locals
    Object? postBody = updateCustomReportEmpty;

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

  /// Send custom report without any content
  ///
  /// Parameters:
  ///
  /// * [UpdateCustomReportEmpty] updateCustomReportEmpty (required):
  Future<UpdateReportResult?> postCustomReportEmpty(UpdateCustomReportEmpty updateCustomReportEmpty, { Future<void>? abortTrigger, }) async {
    final response = await postCustomReportEmptyWithHttpInfo(updateCustomReportEmpty, abortTrigger: abortTrigger,);
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
  /// * [DemoAccountToken] demoAccountToken (required):
  Future<Response> postDemoAccountAccessibleAccountsWithHttpInfo(DemoAccountToken demoAccountToken, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/demo_account_accessible_accounts';

    // ignore: prefer_final_locals
    Object? postBody = demoAccountToken;

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

  /// Get demo account's available accounts.
  ///
  /// This path is using HTTP POST because there is JSON in the request body.
  ///
  /// Parameters:
  ///
  /// * [DemoAccountToken] demoAccountToken (required):
  Future<List<AccessibleAccount>?> postDemoAccountAccessibleAccounts(DemoAccountToken demoAccountToken, { Future<void>? abortTrigger, }) async {
    final response = await postDemoAccountAccessibleAccountsWithHttpInfo(demoAccountToken, abortTrigger: abortTrigger,);
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

  /// Access demo account, which allows accessing all or specific accounts depending on the server configuration.
  ///
  /// This API route has 1 second wait time to make password guessing harder. Account will be locked if the password is guessed. Server process restart will reset the lock.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [DemoAccountLoginCredentials] demoAccountLoginCredentials (required):
  Future<Response> postDemoAccountLoginWithHttpInfo(DemoAccountLoginCredentials demoAccountLoginCredentials, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/demo_account_login';

    // ignore: prefer_final_locals
    Object? postBody = demoAccountLoginCredentials;

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

  /// Access demo account, which allows accessing all or specific accounts depending on the server configuration.
  ///
  /// This API route has 1 second wait time to make password guessing harder. Account will be locked if the password is guessed. Server process restart will reset the lock.
  ///
  /// Parameters:
  ///
  /// * [DemoAccountLoginCredentials] demoAccountLoginCredentials (required):
  Future<DemoAccountLoginResult?> postDemoAccountLogin(DemoAccountLoginCredentials demoAccountLoginCredentials, { Future<void>? abortTrigger, }) async {
    final response = await postDemoAccountLoginWithHttpInfo(demoAccountLoginCredentials, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'DemoAccountLoginResult',) as DemoAccountLoginResult;
    
    }
    return null;
  }

  /// Performs an HTTP 'POST /account_api/demo_account_login_to_account' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [DemoAccountLoginToAccount] demoAccountLoginToAccount (required):
  Future<Response> postDemoAccountLoginToAccountWithHttpInfo(DemoAccountLoginToAccount demoAccountLoginToAccount, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/demo_account_login_to_account';

    // ignore: prefer_final_locals
    Object? postBody = demoAccountLoginToAccount;

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
  /// * [DemoAccountLoginToAccount] demoAccountLoginToAccount (required):
  Future<LoginResult?> postDemoAccountLoginToAccount(DemoAccountLoginToAccount demoAccountLoginToAccount, { Future<void>? abortTrigger, }) async {
    final response = await postDemoAccountLoginToAccountWithHttpInfo(demoAccountLoginToAccount, abortTrigger: abortTrigger,);
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

  /// Performs an HTTP 'POST /account_api/demo_account_logout' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [DemoAccountToken] demoAccountToken (required):
  Future<Response> postDemoAccountLogoutWithHttpInfo(DemoAccountToken demoAccountToken, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/demo_account_logout';

    // ignore: prefer_final_locals
    Object? postBody = demoAccountToken;

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
  /// * [DemoAccountToken] demoAccountToken (required):
  Future<void> postDemoAccountLogout(DemoAccountToken demoAccountToken, { Future<void>? abortTrigger, }) async {
    final response = await postDemoAccountLogoutWithHttpInfo(demoAccountToken, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /account_api/demo_account_register_account' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [DemoAccountToken] demoAccountToken (required):
  Future<Response> postDemoAccountRegisterAccountWithHttpInfo(DemoAccountToken demoAccountToken, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/demo_account_register_account';

    // ignore: prefer_final_locals
    Object? postBody = demoAccountToken;

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
  /// * [DemoAccountToken] demoAccountToken (required):
  Future<DemoAccountRegisterAccountResult?> postDemoAccountRegisterAccount(DemoAccountToken demoAccountToken, { Future<void>? abortTrigger, }) async {
    final response = await postDemoAccountRegisterAccountWithHttpInfo(demoAccountToken, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'DemoAccountRegisterAccountResult',) as DemoAccountRegisterAccountResult;
    
    }
    return null;
  }

  /// Login using email login token (single use).
  ///
  /// The route always takes at least 5 seconds to complete to make token guessing slower.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [EmailLogin] emailLogin (required):
  Future<Response> postEmailLoginWithTokenWithHttpInfo(EmailLogin emailLogin, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/email_login_with_token';

    // ignore: prefer_final_locals
    Object? postBody = emailLogin;

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

  /// Login using email login token (single use).
  ///
  /// The route always takes at least 5 seconds to complete to make token guessing slower.
  ///
  /// Parameters:
  ///
  /// * [EmailLogin] emailLogin (required):
  Future<LoginResult?> postEmailLoginWithToken(EmailLogin emailLogin, { Future<void>? abortTrigger, }) async {
    final response = await postEmailLoginWithTokenWithHttpInfo(emailLogin, abortTrigger: abortTrigger,);
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

  /// Performs an HTTP 'POST /account_api/client_features_config' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ClientFeaturesConfigHash] clientFeaturesConfigHash (required):
  Future<Response> postGetClientFeaturesConfigWithHttpInfo(ClientFeaturesConfigHash clientFeaturesConfigHash, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/client_features_config';

    // ignore: prefer_final_locals
    Object? postBody = clientFeaturesConfigHash;

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
  /// * [ClientFeaturesConfigHash] clientFeaturesConfigHash (required):
  Future<GetClientFeaturesConfigResult?> postGetClientFeaturesConfig(ClientFeaturesConfigHash clientFeaturesConfigHash, { Future<void>? abortTrigger, }) async {
    final response = await postGetClientFeaturesConfigWithHttpInfo(clientFeaturesConfigHash, abortTrigger: abortTrigger,);
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
  /// * [CustomReportsConfigHash] customReportsConfigHash (required):
  Future<Response> postGetCustomReportsConfigWithHttpInfo(CustomReportsConfigHash customReportsConfigHash, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/custom_reports_config';

    // ignore: prefer_final_locals
    Object? postBody = customReportsConfigHash;

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
  /// * [CustomReportsConfigHash] customReportsConfigHash (required):
  Future<GetCustomReportsConfigResult?> postGetCustomReportsConfig(CustomReportsConfigHash customReportsConfigHash, { Future<void>? abortTrigger, }) async {
    final response = await postGetCustomReportsConfigWithHttpInfo(customReportsConfigHash, abortTrigger: abortTrigger,);
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

  /// Performs an HTTP 'POST /account_api/dynamic_client_features_config' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [DynamicClientFeaturesConfigHash] dynamicClientFeaturesConfigHash (required):
  Future<Response> postGetDynamicClientFeaturesConfigWithHttpInfo(DynamicClientFeaturesConfigHash dynamicClientFeaturesConfigHash, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/dynamic_client_features_config';

    // ignore: prefer_final_locals
    Object? postBody = dynamicClientFeaturesConfigHash;

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
  /// * [DynamicClientFeaturesConfigHash] dynamicClientFeaturesConfigHash (required):
  Future<GetDynamicClientFeaturesConfigResult?> postGetDynamicClientFeaturesConfig(DynamicClientFeaturesConfigHash dynamicClientFeaturesConfigHash, { Future<void>? abortTrigger, }) async {
    final response = await postGetDynamicClientFeaturesConfigWithHttpInfo(dynamicClientFeaturesConfigHash, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'GetDynamicClientFeaturesConfigResult',) as GetDynamicClientFeaturesConfigResult;
    
    }
    return null;
  }

  /// Performs an HTTP 'POST /account_api/news_page' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] locale (required):
  ///
  /// * [NewsIteratorState] newsIteratorState (required):
  Future<Response> postGetNewsPageWithHttpInfo(String locale, NewsIteratorState newsIteratorState, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/news_page';

    // ignore: prefer_final_locals
    Object? postBody = newsIteratorState;

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
      abortTrigger: abortTrigger,
    );
  }

  /// Parameters:
  ///
  /// * [String] locale (required):
  ///
  /// * [NewsIteratorState] newsIteratorState (required):
  Future<NewsPage?> postGetNewsPage(String locale, NewsIteratorState newsIteratorState, { Future<void>? abortTrigger, }) async {
    final response = await postGetNewsPageWithHttpInfo(locale, newsIteratorState, abortTrigger: abortTrigger,);
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
  Future<Response> postGetUnreadNewsCountWithHttpInfo({ Future<void>? abortTrigger, }) async {
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
      abortTrigger: abortTrigger,
    );
  }

  /// The unread news count for public news.
  Future<UnreadNewsCountResult?> postGetUnreadNewsCount({ Future<void>? abortTrigger, }) async {
    final response = await postGetUnreadNewsCountWithHttpInfo(abortTrigger: abortTrigger,);
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

  /// Initiate email change process by providing a new email address.
  ///
  /// The process: 1. User provides new email address 2. Verification email sent to new address 3. Notification email sent to current address 4. After configured time elapses and new email is verified, email changes  Error is returned when  - account does not already have email address set,  - the new email is the current email or  - email address change is already in progress.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [InitEmailChange] initEmailChange (required):
  Future<Response> postInitEmailChangeWithHttpInfo(InitEmailChange initEmailChange, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/init_email_change';

    // ignore: prefer_final_locals
    Object? postBody = initEmailChange;

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

  /// Initiate email change process by providing a new email address.
  ///
  /// The process: 1. User provides new email address 2. Verification email sent to new address 3. Notification email sent to current address 4. After configured time elapses and new email is verified, email changes  Error is returned when  - account does not already have email address set,  - the new email is the current email or  - email address change is already in progress.
  ///
  /// Parameters:
  ///
  /// * [InitEmailChange] initEmailChange (required):
  Future<InitEmailChangeResult?> postInitEmailChange(InitEmailChange initEmailChange, { Future<void>? abortTrigger, }) async {
    final response = await postInitEmailChangeWithHttpInfo(initEmailChange, abortTrigger: abortTrigger,);
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

  /// Set initial email address for bots and accounts owned by demo account when initial setup is ongoing.
  ///
  /// Does nothing if the provided email address is the same as the current email address.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [SetInitialEmail] setInitialEmail (required):
  Future<Response> postInitialEmailWithHttpInfo(SetInitialEmail setInitialEmail, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/initial_email';

    // ignore: prefer_final_locals
    Object? postBody = setInitialEmail;

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

  /// Set initial email address for bots and accounts owned by demo account when initial setup is ongoing.
  ///
  /// Does nothing if the provided email address is the same as the current email address.
  ///
  /// Parameters:
  ///
  /// * [SetInitialEmail] setInitialEmail (required):
  Future<void> postInitialEmail(SetInitialEmail setInitialEmail, { Future<void>? abortTrigger, }) async {
    final response = await postInitialEmailWithHttpInfo(setInitialEmail, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /account_api/logout' operation and returns the [Response].
  Future<Response> postLogoutWithHttpInfo({ Future<void>? abortTrigger, }) async {
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
      abortTrigger: abortTrigger,
    );
  }

  Future<void> postLogout({ Future<void>? abortTrigger, }) async {
    final response = await postLogoutWithHttpInfo(abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Request email login token to be sent via email.
  ///
  /// The route always takes at least 5 seconds to complete to prevent timing attacks that could be used to enumerate existing email addresses.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [RequestEmailLoginToken] requestEmailLoginToken (required):
  Future<Response> postRequestEmailLoginTokenWithHttpInfo(RequestEmailLoginToken requestEmailLoginToken, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/request_email_login_token';

    // ignore: prefer_final_locals
    Object? postBody = requestEmailLoginToken;

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

  /// Request email login token to be sent via email.
  ///
  /// The route always takes at least 5 seconds to complete to prevent timing attacks that could be used to enumerate existing email addresses.
  ///
  /// Parameters:
  ///
  /// * [RequestEmailLoginToken] requestEmailLoginToken (required):
  Future<RequestEmailLoginTokenResult?> postRequestEmailLoginToken(RequestEmailLoginToken requestEmailLoginToken, { Future<void>? abortTrigger, }) async {
    final response = await postRequestEmailLoginTokenWithHttpInfo(requestEmailLoginToken, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'RequestEmailLoginTokenResult',) as RequestEmailLoginTokenResult;
    
    }
    return null;
  }

  /// Performs an HTTP 'POST /account_api/reset_news_paging' operation and returns the [Response].
  Future<Response> postResetNewsPagingWithHttpInfo({ Future<void>? abortTrigger, }) async {
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
      abortTrigger: abortTrigger,
    );
  }

  Future<ResetNewsIteratorResult?> postResetNewsPaging({ Future<void>? abortTrigger, }) async {
    final response = await postResetNewsPagingWithHttpInfo(abortTrigger: abortTrigger,);
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

  /// Performs an HTTP 'POST /account_api/send_verify_email_message' operation and returns the [Response].
  Future<Response> postSendVerifyEmailMessageWithHttpInfo({ Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/send_verify_email_message';

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

  Future<SendVerifyEmailMessageResult?> postSendVerifyEmailMessage({ Future<void>? abortTrigger, }) async {
    final response = await postSendVerifyEmailMessageWithHttpInfo(abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'SendVerifyEmailMessageResult',) as SendVerifyEmailMessageResult;
    
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
  Future<Response> postSetAccountDeletionRequestStateWithHttpInfo(String aid, BooleanSetting booleanSetting, { Future<void>? abortTrigger, }) async {
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
      abortTrigger: abortTrigger,
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
  Future<void> postSetAccountDeletionRequestState(String aid, BooleanSetting booleanSetting, { Future<void>? abortTrigger, }) async {
    final response = await postSetAccountDeletionRequestStateWithHttpInfo(aid, booleanSetting, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Enable or disable email login for an account.
  ///
  /// Users can set this for their own account. Admins with `admin_edit_login` permission can set this for any account.  This is useful to prevent email login spam attacks.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [SetEmailLoginEnabled] setEmailLoginEnabled (required):
  Future<Response> postSetEmailLoginEnabledWithHttpInfo(SetEmailLoginEnabled setEmailLoginEnabled, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/set_email_login_enabled';

    // ignore: prefer_final_locals
    Object? postBody = setEmailLoginEnabled;

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

  /// Enable or disable email login for an account.
  ///
  /// Users can set this for their own account. Admins with `admin_edit_login` permission can set this for any account.  This is useful to prevent email login spam attacks.
  ///
  /// Parameters:
  ///
  /// * [SetEmailLoginEnabled] setEmailLoginEnabled (required):
  Future<void> postSetEmailLoginEnabled(SetEmailLoginEnabled setEmailLoginEnabled, { Future<void>? abortTrigger, }) async {
    final response = await postSetEmailLoginEnabledWithHttpInfo(setEmailLoginEnabled, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Start new session with sign in with Apple or Google.
  ///
  /// Registers new account if it does not exist, when registration is enabled for the current client platform in dynamic server config.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [SignInWithLoginInfo] signInWithLoginInfo (required):
  Future<Response> postSignInWithLoginWithHttpInfo(SignInWithLoginInfo signInWithLoginInfo, { Future<void>? abortTrigger, }) async {
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
      abortTrigger: abortTrigger,
    );
  }

  /// Start new session with sign in with Apple or Google.
  ///
  /// Registers new account if it does not exist, when registration is enabled for the current client platform in dynamic server config.
  ///
  /// Parameters:
  ///
  /// * [SignInWithLoginInfo] signInWithLoginInfo (required):
  Future<LoginResult?> postSignInWithLogin(SignInWithLoginInfo signInWithLoginInfo, { Future<void>? abortTrigger, }) async {
    final response = await postSignInWithLoginWithHttpInfo(signInWithLoginInfo, abortTrigger: abortTrigger,);
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

  /// Verify email address using the token from the form submission.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> postVerifyEmailWithHttpInfo({ Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/verify_email';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/x-www-form-urlencoded'];


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

  /// Verify email address using the token from the form submission.
  Future<void> postVerifyEmail({ Future<void>? abortTrigger, }) async {
    final response = await postVerifyEmailWithHttpInfo(abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Verify new email address using the token from the form submission.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> postVerifyNewEmailWithHttpInfo({ Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/verify_new_email';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/x-www-form-urlencoded'];


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

  /// Verify new email address using the token from the form submission.
  Future<void> postVerifyNewEmail({ Future<void>? abortTrigger, }) async {
    final response = await postVerifyNewEmailWithHttpInfo(abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Update current profile visiblity value.
  ///
  /// NOTE: Client uses this in initial setup.  # Limits - When [AccountState::Banned], the visiblity can only be set to private.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [BooleanSetting] booleanSetting (required):
  Future<Response> putSettingProfileVisiblityWithHttpInfo(BooleanSetting booleanSetting, { Future<void>? abortTrigger, }) async {
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
      abortTrigger: abortTrigger,
    );
  }

  /// Update current profile visiblity value.
  ///
  /// NOTE: Client uses this in initial setup.  # Limits - When [AccountState::Banned], the visiblity can only be set to private.
  ///
  /// Parameters:
  ///
  /// * [BooleanSetting] booleanSetting (required):
  Future<void> putSettingProfileVisiblity(BooleanSetting booleanSetting, { Future<void>? abortTrigger, }) async {
    final response = await putSettingProfileVisiblityWithHttpInfo(booleanSetting, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'PUT /account_api/settings/unlimited_likes' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [BooleanSetting] booleanSetting (required):
  Future<Response> putSettingUnlimitedLikesWithHttpInfo(BooleanSetting booleanSetting, { Future<void>? abortTrigger, }) async {
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
      abortTrigger: abortTrigger,
    );
  }

  /// Parameters:
  ///
  /// * [BooleanSetting] booleanSetting (required):
  Future<void> putSettingUnlimitedLikes(BooleanSetting booleanSetting, { Future<void>? abortTrigger, }) async {
    final response = await putSettingUnlimitedLikesWithHttpInfo(booleanSetting, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Associate or disassociate Apple sign in with account.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [PutSignInWithApple] putSignInWithApple (required):
  Future<Response> putSignInWithAppleWithHttpInfo(PutSignInWithApple putSignInWithApple, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/sign_in_with_apple';

    // ignore: prefer_final_locals
    Object? postBody = putSignInWithApple;

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
      abortTrigger: abortTrigger,
    );
  }

  /// Associate or disassociate Apple sign in with account.
  ///
  /// Parameters:
  ///
  /// * [PutSignInWithApple] putSignInWithApple (required):
  Future<void> putSignInWithApple(PutSignInWithApple putSignInWithApple, { Future<void>? abortTrigger, }) async {
    final response = await putSignInWithAppleWithHttpInfo(putSignInWithApple, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Associate or disassociate Google sign in with account.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [PutSignInWithGoogle] putSignInWithGoogle (required):
  Future<Response> putSignInWithGoogleWithHttpInfo(PutSignInWithGoogle putSignInWithGoogle, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/account_api/sign_in_with_google';

    // ignore: prefer_final_locals
    Object? postBody = putSignInWithGoogle;

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
      abortTrigger: abortTrigger,
    );
  }

  /// Associate or disassociate Google sign in with account.
  ///
  /// Parameters:
  ///
  /// * [PutSignInWithGoogle] putSignInWithGoogle (required):
  Future<void> putSignInWithGoogle(PutSignInWithGoogle putSignInWithGoogle, { Future<void>? abortTrigger, }) async {
    final response = await putSignInWithGoogleWithHttpInfo(putSignInWithGoogle, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}
