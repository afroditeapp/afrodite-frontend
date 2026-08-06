//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class ChatApi {
  ChatApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Performs an HTTP 'GET /chat_api/get_chat_app_notification_settings' operation and returns the [Response].
  Future<Response> getChatAppNotificationSettingsWithHttpInfo({ Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/get_chat_app_notification_settings';

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

  Future<ChatAppNotificationSettings?> getChatAppNotificationSettings({ Future<void>? abortTrigger, }) async {
    final response = await getChatAppNotificationSettingsWithHttpInfo(abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ChatAppNotificationSettings',) as ChatAppNotificationSettings;
    
    }
    return null;
  }

  /// Performs an HTTP 'GET /chat_api/get_chat_email_notification_settings' operation and returns the [Response].
  Future<Response> getChatEmailNotificationSettingsWithHttpInfo({ Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/get_chat_email_notification_settings';

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

  Future<ChatEmailNotificationSettings?> getChatEmailNotificationSettings({ Future<void>? abortTrigger, }) async {
    final response = await getChatEmailNotificationSettingsWithHttpInfo(abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ChatEmailNotificationSettings',) as ChatEmailNotificationSettings;
    
    }
    return null;
  }

  /// Performs an HTTP 'GET /chat_api/get_chat_privacy_settings' operation and returns the [Response].
  Future<Response> getChatPrivacySettingsWithHttpInfo({ Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/get_chat_privacy_settings';

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

  Future<ChatPrivacySettings?> getChatPrivacySettings({ Future<void>? abortTrigger, }) async {
    final response = await getChatPrivacySettingsWithHttpInfo(abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ChatPrivacySettings',) as ChatPrivacySettings;
    
    }
    return null;
  }

  /// Get account specific conversation ID which can be used to display new message received notifications.
  ///
  /// The ID is available only for accounts which are a match.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  Future<Response> getConversationIdWithHttpInfo(String aid, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/conversation_id/{aid}'
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

  /// Get account specific conversation ID which can be used to display new message received notifications.
  ///
  /// The ID is available only for accounts which are a match.
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  Future<GetConversationId?> getConversationId(String aid, { Future<void>? abortTrigger, }) async {
    final response = await getConversationIdWithHttpInfo(aid, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'GetConversationId',) as GetConversationId;
    
    }
    return null;
  }

  /// Get daily likes left value.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getDailyLikesLeftWithHttpInfo({ Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/daily_likes_left';

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

  /// Get daily likes left value.
  Future<DailyLikesLeft?> getDailyLikesLeft({ Future<void>? abortTrigger, }) async {
    final response = await getDailyLikesLeftWithHttpInfo(abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'DailyLikesLeft',) as DailyLikesLeft;
    
    }
    return null;
  }

  /// Performs an HTTP 'GET /chat_api/matches/initial_state' operation and returns the [Response].
  Future<Response> getInitialMatchesIteratorStateWithHttpInfo({ Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/matches/initial_state';

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

  Future<MatchesIteratorState?> getInitialMatchesIteratorState({ Future<void>? abortTrigger, }) async {
    final response = await getInitialMatchesIteratorStateWithHttpInfo(abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'MatchesIteratorState',) as MatchesIteratorState;
    
    }
    return null;
  }

  /// Get latest public key ID for some account
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  Future<Response> getLatestPublicKeyIdWithHttpInfo(String aid, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/latest_public_key_id/{aid}'
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

  /// Get latest public key ID for some account
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  Future<GetLatestPublicKeyId?> getLatestPublicKeyId(String aid, { Future<void>? abortTrigger, }) async {
    final response = await getLatestPublicKeyIdWithHttpInfo(aid, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'GetLatestPublicKeyId',) as GetLatestPublicKeyId;
    
    }
    return null;
  }

  /// Get all message delivery info where the API caller is the message sender.
  ///
  /// This endpoint returns delivery information (delivered/seen status) for all messages sent by the authenticated user.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getMessageDeliveryInfoWithHttpInfo({ Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/message_delivery_info';

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

  /// Get all message delivery info where the API caller is the message sender.
  ///
  /// This endpoint returns delivery information (delivered/seen status) for all messages sent by the authenticated user.
  Future<MessageDeliveryInfoList?> getMessageDeliveryInfo({ Future<void>? abortTrigger, }) async {
    final response = await getMessageDeliveryInfoWithHttpInfo(abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'MessageDeliveryInfoList',) as MessageDeliveryInfoList;
    
    }
    return null;
  }

  /// Performs an HTTP 'GET /chat_api/pending_notifications' operation and returns the [Response].
  Future<Response> getPendingChatNotificationsWithHttpInfo({ Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/pending_notifications';

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

  Future<List<PendingChatNotification>?> getPendingChatNotifications({ Future<void>? abortTrigger, }) async {
    final response = await getPendingChatNotificationsWithHttpInfo(abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<PendingChatNotification>') as List)
        .cast<PendingChatNotification>()
        .toList(growable: false);

    }
    return null;
  }

  /// Get pending latest seen message numbers where the API caller is the message sender. Returns entries that the viewer has reported as seen but have not yet been delivered back to the sender.
  ///
  /// The received entries must be deleted using delete API.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getPendingLatestSeenMessagesWithHttpInfo({ Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/pending_latest_seen_messages';

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

  /// Get pending latest seen message numbers where the API caller is the message sender. Returns entries that the viewer has reported as seen but have not yet been delivered back to the sender.
  ///
  /// The received entries must be deleted using delete API.
  Future<LatestSeenMessageInfoList?> getPendingLatestSeenMessages({ Future<void>? abortTrigger, }) async {
    final response = await getPendingLatestSeenMessagesWithHttpInfo(abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'LatestSeenMessageInfoList',) as LatestSeenMessageInfoList;
    
    }
    return null;
  }

  /// Get list of pending messages.
  ///
  /// The returned bytes is - List of objects  Data for single object: - Binary data length as minimal i64 - Binary data  Minimal i64 has this format: - i64 byte count (u8, values: 1, 2, 3, 4, 5, 6, 7, 8) - i64 bytes (little-endian)  Binary data is binary PGP message which contains backend signed binary data. The binary data contains: - Version (u8, values: 1) - Sender AccountId UUID big-endian bytes (16 bytes) - Recipient AccountId UUID big-endian bytes (16 bytes) - Message MessageId UUID big-endian bytes (16 bytes) - Sender public key ID (minimal i64) - Recipient public key ID (minimal i64) - Message number (minimal i64) - Unix time (minimal i64) - Message data
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getPendingMessagesWithHttpInfo({ Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/pending_messages';

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

  /// Get list of pending messages.
  ///
  /// The returned bytes is - List of objects  Data for single object: - Binary data length as minimal i64 - Binary data  Minimal i64 has this format: - i64 byte count (u8, values: 1, 2, 3, 4, 5, 6, 7, 8) - i64 bytes (little-endian)  Binary data is binary PGP message which contains backend signed binary data. The binary data contains: - Version (u8, values: 1) - Sender AccountId UUID big-endian bytes (16 bytes) - Recipient AccountId UUID big-endian bytes (16 bytes) - Message MessageId UUID big-endian bytes (16 bytes) - Sender public key ID (minimal i64) - Recipient public key ID (minimal i64) - Message number (minimal i64) - Unix time (minimal i64) - Message data
  Future<MultipartFile?> getPendingMessages({ Future<void>? abortTrigger, }) async {
    final response = await getPendingMessagesWithHttpInfo(abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'MultipartFile',) as MultipartFile;
    
    }
    return null;
  }

  /// Get private public key info
  ///
  /// # Access * Owner of the requested account
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  Future<Response> getPrivatePublicKeyInfoWithHttpInfo(String aid, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/private_public_key_info/{aid}'
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

  /// Get private public key info
  ///
  /// # Access * Owner of the requested account
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  Future<GetPrivatePublicKeyInfo?> getPrivatePublicKeyInfo(String aid, { Future<void>? abortTrigger, }) async {
    final response = await getPrivatePublicKeyInfoWithHttpInfo(aid, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'GetPrivatePublicKeyInfo',) as GetPrivatePublicKeyInfo;
    
    }
    return null;
  }

  /// Get current public key of some account
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  ///
  /// * [int] id (required):
  Future<Response> getPublicKeyWithHttpInfo(String aid, int id, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/public_key/{aid}'
      .replaceAll('{aid}', aid);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'id', id));

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

  /// Get current public key of some account
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  ///
  /// * [int] id (required):
  Future<MultipartFile?> getPublicKey(String aid, int id, { Future<void>? abortTrigger, }) async {
    final response = await getPublicKeyWithHttpInfo(aid, id, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'MultipartFile',) as MultipartFile;
    
    }
    return null;
  }

  /// Get list of sent blocks
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getSentBlocksWithHttpInfo({ Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/sent_blocks';

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

  /// Get list of sent blocks
  Future<SentBlocksPage?> getSentBlocks({ Future<void>? abortTrigger, }) async {
    final response = await getSentBlocksWithHttpInfo(abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'SentBlocksPage',) as SentBlocksPage;
    
    }
    return null;
  }

  /// Performs an HTTP 'GET /chat_api/sent_message_ids' operation and returns the [Response].
  Future<Response> getSentMessageIdsWithHttpInfo({ Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/sent_message_ids';

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

  Future<SentMessageIdList?> getSentMessageIds({ Future<void>? abortTrigger, }) async {
    final response = await getSentMessageIdsWithHttpInfo(abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'SentMessageIdList',) as SentMessageIdList;
    
    }
    return null;
  }

  /// Add new public key.
  ///
  /// Returns next public key ID number.  # Limits  Server can store limited amount of public keys. The limit is configurable from server config file and also user specific config exists. Max value between the two previous values is used to check is adding the key allowed.  Max key size is 8192 bytes.  The key must be OpenPGP public key with one signed user which ID is [model::AccountId] string.  
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [MultipartFile] body (required):
  ///
  /// * [bool] ignorePendingMessages:
  ///   Ignore pending messages error. If this is true, the public key will be added even if there are pending messages.
  Future<Response> postAddPublicKeyWithHttpInfo(MultipartFile body, { bool? ignorePendingMessages, Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/add_public_key';

    // ignore: prefer_final_locals
    Object? postBody = body;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (ignorePendingMessages != null) {
      queryParams.addAll(_queryParams('', 'ignore_pending_messages', ignorePendingMessages));
    }

    const contentTypes = <String>['application/octet-stream'];


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

  /// Add new public key.
  ///
  /// Returns next public key ID number.  # Limits  Server can store limited amount of public keys. The limit is configurable from server config file and also user specific config exists. Max value between the two previous values is used to check is adding the key allowed.  Max key size is 8192 bytes.  The key must be OpenPGP public key with one signed user which ID is [model::AccountId] string.  
  ///
  /// Parameters:
  ///
  /// * [MultipartFile] body (required):
  ///
  /// * [bool] ignorePendingMessages:
  ///   Ignore pending messages error. If this is true, the public key will be added even if there are pending messages.
  Future<AddPublicKeyResult?> postAddPublicKey(MultipartFile body, { bool? ignorePendingMessages, Future<void>? abortTrigger, }) async {
    final response = await postAddPublicKeyWithHttpInfo(body, ignorePendingMessages: ignorePendingMessages, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'AddPublicKeyResult',) as AddPublicKeyResult;
    
    }
    return null;
  }

  /// Performs an HTTP 'POST /chat_api/add_recipient_acknowledgement' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [PendingMessageAcknowledgementList] pendingMessageAcknowledgementList (required):
  Future<Response> postAddRecipientAcknowledgementWithHttpInfo(PendingMessageAcknowledgementList pendingMessageAcknowledgementList, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/add_recipient_acknowledgement';

    // ignore: prefer_final_locals
    Object? postBody = pendingMessageAcknowledgementList;

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
  /// * [PendingMessageAcknowledgementList] pendingMessageAcknowledgementList (required):
  Future<void> postAddRecipientAcknowledgement(PendingMessageAcknowledgementList pendingMessageAcknowledgementList, { Future<void>? abortTrigger, }) async {
    final response = await postAddRecipientAcknowledgementWithHttpInfo(pendingMessageAcknowledgementList, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /chat_api/add_sender_acknowledgement' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [SentMessageIdList] sentMessageIdList (required):
  Future<Response> postAddSenderAcknowledgementWithHttpInfo(SentMessageIdList sentMessageIdList, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/add_sender_acknowledgement';

    // ignore: prefer_final_locals
    Object? postBody = sentMessageIdList;

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
  /// * [SentMessageIdList] sentMessageIdList (required):
  Future<void> postAddSenderAcknowledgement(SentMessageIdList sentMessageIdList, { Future<void>? abortTrigger, }) async {
    final response = await postAddSenderAcknowledgementWithHttpInfo(sentMessageIdList, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Block profile
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [AccountId] accountId (required):
  Future<Response> postBlockProfileWithHttpInfo(AccountId accountId, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/block_profile';

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

  /// Block profile
  ///
  /// Parameters:
  ///
  /// * [AccountId] accountId (required):
  Future<void> postBlockProfile(AccountId accountId, { Future<void>? abortTrigger, }) async {
    final response = await postBlockProfileWithHttpInfo(accountId, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /chat_api/post_chat_app_notification_settings' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ChatAppNotificationSettings] chatAppNotificationSettings (required):
  Future<Response> postChatAppNotificationSettingsWithHttpInfo(ChatAppNotificationSettings chatAppNotificationSettings, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/post_chat_app_notification_settings';

    // ignore: prefer_final_locals
    Object? postBody = chatAppNotificationSettings;

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
  /// * [ChatAppNotificationSettings] chatAppNotificationSettings (required):
  Future<void> postChatAppNotificationSettings(ChatAppNotificationSettings chatAppNotificationSettings, { Future<void>? abortTrigger, }) async {
    final response = await postChatAppNotificationSettingsWithHttpInfo(chatAppNotificationSettings, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /chat_api/post_chat_email_notification_settings' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ChatEmailNotificationSettings] chatEmailNotificationSettings (required):
  Future<Response> postChatEmailNotificationSettingsWithHttpInfo(ChatEmailNotificationSettings chatEmailNotificationSettings, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/post_chat_email_notification_settings';

    // ignore: prefer_final_locals
    Object? postBody = chatEmailNotificationSettings;

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
  /// * [ChatEmailNotificationSettings] chatEmailNotificationSettings (required):
  Future<void> postChatEmailNotificationSettings(ChatEmailNotificationSettings chatEmailNotificationSettings, { Future<void>? abortTrigger, }) async {
    final response = await postChatEmailNotificationSettingsWithHttpInfo(chatEmailNotificationSettings, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Report chat message.
  ///
  /// The report target must be a match. Supports reporting at most 10 messages per request.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [UpdateChatMessageReports] updateChatMessageReports (required):
  Future<Response> postChatMessageReportsWithHttpInfo(UpdateChatMessageReports updateChatMessageReports, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/chat_message_reports';

    // ignore: prefer_final_locals
    Object? postBody = updateChatMessageReports;

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

  /// Report chat message.
  ///
  /// The report target must be a match. Supports reporting at most 10 messages per request.
  ///
  /// Parameters:
  ///
  /// * [UpdateChatMessageReports] updateChatMessageReports (required):
  Future<UpdateReportResult?> postChatMessageReports(UpdateChatMessageReports updateChatMessageReports, { Future<void>? abortTrigger, }) async {
    final response = await postChatMessageReportsWithHttpInfo(updateChatMessageReports, abortTrigger: abortTrigger,);
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

  /// Performs an HTTP 'POST /chat_api/post_chat_privacy_settings' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ChatPrivacySettings] chatPrivacySettings (required):
  Future<Response> postChatPrivacySettingsWithHttpInfo(ChatPrivacySettings chatPrivacySettings, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/post_chat_privacy_settings';

    // ignore: prefer_final_locals
    Object? postBody = chatPrivacySettings;

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
  /// * [ChatPrivacySettings] chatPrivacySettings (required):
  Future<void> postChatPrivacySettings(ChatPrivacySettings chatPrivacySettings, { Future<void>? abortTrigger, }) async {
    final response = await postChatPrivacySettingsWithHttpInfo(chatPrivacySettings, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Create video call URL to a meeting with an user.
  ///
  /// The user must be a match.  If result value is empty then video calling is disabled.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  Future<Response> postCreateVideoCallUrlWithHttpInfo(String aid, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/post_create_video_call_url';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'aid', aid));

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

  /// Create video call URL to a meeting with an user.
  ///
  /// The user must be a match.  If result value is empty then video calling is disabled.
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  Future<PostVideoCallUrlResult?> postCreateVideoCallUrl(String aid, { Future<void>? abortTrigger, }) async {
    final response = await postCreateVideoCallUrlWithHttpInfo(aid, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'PostVideoCallUrlResult',) as PostVideoCallUrlResult;
    
    }
    return null;
  }

  /// Delete message delivery info entries by their database IDs.
  ///
  /// This endpoint allows message senders to remove delivery info entries that they have already processed.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [MessageDeliveryInfoIdList] messageDeliveryInfoIdList (required):
  Future<Response> postDeleteMessageDeliveryInfoWithHttpInfo(MessageDeliveryInfoIdList messageDeliveryInfoIdList, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/delete_message_delivery_info';

    // ignore: prefer_final_locals
    Object? postBody = messageDeliveryInfoIdList;

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

  /// Delete message delivery info entries by their database IDs.
  ///
  /// This endpoint allows message senders to remove delivery info entries that they have already processed.
  ///
  /// Parameters:
  ///
  /// * [MessageDeliveryInfoIdList] messageDeliveryInfoIdList (required):
  Future<void> postDeleteMessageDeliveryInfo(MessageDeliveryInfoIdList messageDeliveryInfoIdList, { Future<void>? abortTrigger, }) async {
    final response = await postDeleteMessageDeliveryInfoWithHttpInfo(messageDeliveryInfoIdList, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /chat_api/pending_notifications/delete' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [List<PendingChatNotificationToDelete>] pendingChatNotificationToDelete (required):
  Future<Response> postDeletePendingChatNotificationsWithHttpInfo(List<PendingChatNotificationToDelete> pendingChatNotificationToDelete, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/pending_notifications/delete';

    // ignore: prefer_final_locals
    Object? postBody = pendingChatNotificationToDelete;

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
  /// * [List<PendingChatNotificationToDelete>] pendingChatNotificationToDelete (required):
  Future<void> postDeletePendingChatNotifications(List<PendingChatNotificationToDelete> pendingChatNotificationToDelete, { Future<void>? abortTrigger, }) async {
    final response = await postDeletePendingChatNotificationsWithHttpInfo(pendingChatNotificationToDelete, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Delete pending latest seen message entries.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [LatestSeenMessageInfoList] latestSeenMessageInfoList (required):
  Future<Response> postDeletePendingLatestSeenMessagesWithHttpInfo(LatestSeenMessageInfoList latestSeenMessageInfoList, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/pending_latest_seen_messages/delete';

    // ignore: prefer_final_locals
    Object? postBody = latestSeenMessageInfoList;

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

  /// Delete pending latest seen message entries.
  ///
  /// Parameters:
  ///
  /// * [LatestSeenMessageInfoList] latestSeenMessageInfoList (required):
  Future<void> postDeletePendingLatestSeenMessages(LatestSeenMessageInfoList latestSeenMessageInfoList, { Future<void>? abortTrigger, }) async {
    final response = await postDeletePendingLatestSeenMessagesWithHttpInfo(latestSeenMessageInfoList, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Get requested page of matches iterator page. If the page is empty there is no more matches available.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [MatchesIteratorState] matchesIteratorState (required):
  Future<Response> postGetMatchesIteratorPageWithHttpInfo(MatchesIteratorState matchesIteratorState, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/matches';

    // ignore: prefer_final_locals
    Object? postBody = matchesIteratorState;

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

  /// Get requested page of matches iterator page. If the page is empty there is no more matches available.
  ///
  /// Parameters:
  ///
  /// * [MatchesIteratorState] matchesIteratorState (required):
  Future<MatchesPage?> postGetMatchesIteratorPage(MatchesIteratorState matchesIteratorState, { Future<void>? abortTrigger, }) async {
    final response = await postGetMatchesIteratorPageWithHttpInfo(matchesIteratorState, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'MatchesPage',) as MatchesPage;
    
    }
    return null;
  }

  /// Performs an HTTP 'POST /chat_api/new_received_likes_count' operation and returns the [Response].
  Future<Response> postGetNewReceivedLikesCountWithHttpInfo({ Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/new_received_likes_count';

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

  Future<NewReceivedLikesCountResult?> postGetNewReceivedLikesCount({ Future<void>? abortTrigger, }) async {
    final response = await postGetNewReceivedLikesCountWithHttpInfo(abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'NewReceivedLikesCountResult',) as NewReceivedLikesCountResult;
    
    }
    return null;
  }

  /// Get next page of received likes. If the page is empty there is no more received likes available.
  ///
  /// Profile will not be returned if: - Profile is blocked - Profile is a match
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [ReceivedLikesIteratorState] receivedLikesIteratorState (required):
  Future<Response> postGetReceivedLikesPageWithHttpInfo(ReceivedLikesIteratorState receivedLikesIteratorState, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/received_likes';

    // ignore: prefer_final_locals
    Object? postBody = receivedLikesIteratorState;

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

  /// Get next page of received likes. If the page is empty there is no more received likes available.
  ///
  /// Profile will not be returned if: - Profile is blocked - Profile is a match
  ///
  /// Parameters:
  ///
  /// * [ReceivedLikesIteratorState] receivedLikesIteratorState (required):
  Future<ReceivedLikesPage?> postGetReceivedLikesPage(ReceivedLikesIteratorState receivedLikesIteratorState, { Future<void>? abortTrigger, }) async {
    final response = await postGetReceivedLikesPageWithHttpInfo(receivedLikesIteratorState, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ReceivedLikesPage',) as ReceivedLikesPage;
    
    }
    return null;
  }

  /// Receive unreceived [model_chat::SignedMessageData] for sent message.
  ///
  /// This is HTTP POST route only to allow JSON request body.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [MessageId] messageId (required):
  Future<Response> postGetSentMessageWithHttpInfo(MessageId messageId, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/sent_message';

    // ignore: prefer_final_locals
    Object? postBody = messageId;

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

  /// Receive unreceived [model_chat::SignedMessageData] for sent message.
  ///
  /// This is HTTP POST route only to allow JSON request body.
  ///
  /// Parameters:
  ///
  /// * [MessageId] messageId (required):
  Future<GetSentMessage?> postGetSentMessage(MessageId messageId, { Future<void>? abortTrigger, }) async {
    final response = await postGetSentMessageWithHttpInfo(messageId, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'GetSentMessage',) as GetSentMessage;
    
    }
    return null;
  }

  /// Mark received message as seen. Only latest message number is stored so client should mark the latest messages as seen.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [SeenMessage] seenMessage (required):
  Future<Response> postMarkMessageAsSeenWithHttpInfo(SeenMessage seenMessage, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/mark_message_as_seen';

    // ignore: prefer_final_locals
    Object? postBody = seenMessage;

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

  /// Mark received message as seen. Only latest message number is stored so client should mark the latest messages as seen.
  ///
  /// Parameters:
  ///
  /// * [SeenMessage] seenMessage (required):
  Future<void> postMarkMessageAsSeen(SeenMessage seenMessage, { Future<void>? abortTrigger, }) async {
    final response = await postMarkMessageAsSeenWithHttpInfo(seenMessage, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /chat_api/mark_received_likes_viewed' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [MarkReceivedLikesViewed] markReceivedLikesViewed (required):
  Future<Response> postMarkReceivedLikesViewedWithHttpInfo(MarkReceivedLikesViewed markReceivedLikesViewed, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/mark_received_likes_viewed';

    // ignore: prefer_final_locals
    Object? postBody = markReceivedLikesViewed;

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
  /// * [MarkReceivedLikesViewed] markReceivedLikesViewed (required):
  Future<void> postMarkReceivedLikesViewed(MarkReceivedLikesViewed markReceivedLikesViewed, { Future<void>? abortTrigger, }) async {
    final response = await postMarkReceivedLikesViewedWithHttpInfo(markReceivedLikesViewed, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /chat_api/reset_new_received_likes_count' operation and returns the [Response].
  Future<Response> postResetNewReceivedLikesCountWithHttpInfo({ Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/reset_new_received_likes_count';

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

  Future<NewReceivedLikesCountResult?> postResetNewReceivedLikesCount({ Future<void>? abortTrigger, }) async {
    final response = await postResetNewReceivedLikesCountWithHttpInfo(abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'NewReceivedLikesCountResult',) as NewReceivedLikesCountResult;
    
    }
    return null;
  }

  /// Performs an HTTP 'POST /chat_api/received_likes/reset' operation and returns the [Response].
  Future<Response> postResetReceivedLikesPagingWithHttpInfo({ Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/received_likes/reset';

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

  Future<ResetReceivedLikesIteratorResult?> postResetReceivedLikesPaging({ Future<void>? abortTrigger, }) async {
    final response = await postResetReceivedLikesPagingWithHttpInfo(abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ResetReceivedLikesIteratorResult',) as ResetReceivedLikesIteratorResult;
    
    }
    return null;
  }

  /// Send a like to some account. If both will like each other, then the accounts will be a match. The second account must set [SendLike::allow_matching] to true.
  ///
  /// This route might update [model_chat::DailyLikesLeft] and WebSocket event about the update is not sent because this route returns the new value.  The like sending is allowed even if accounts aren't a match when considering age and gender preferences. This is because changing the preferences isn't limited.  # Access * [AccountState::Normal]
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [SendLike] sendLike (required):
  Future<Response> postSendLikeWithHttpInfo(SendLike sendLike, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/send_like';

    // ignore: prefer_final_locals
    Object? postBody = sendLike;

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

  /// Send a like to some account. If both will like each other, then the accounts will be a match. The second account must set [SendLike::allow_matching] to true.
  ///
  /// This route might update [model_chat::DailyLikesLeft] and WebSocket event about the update is not sent because this route returns the new value.  The like sending is allowed even if accounts aren't a match when considering age and gender preferences. This is because changing the preferences isn't limited.  # Access * [AccountState::Normal]
  ///
  /// Parameters:
  ///
  /// * [SendLike] sendLike (required):
  Future<SendLikeResult?> postSendLike(SendLike sendLike, { Future<void>? abortTrigger, }) async {
    final response = await postSendLikeWithHttpInfo(sendLike, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'SendLikeResult',) as SendLikeResult;
    
    }
    return null;
  }

  /// Send message to a match.
  ///
  /// Server config file defines max count for conversation pending messages. Max message size is u16::MAX.  Sending will fail if one or two way block exists.  Only the latest public key for sender and recipient can be used when sending a message.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] senderPublicKeyId (required):
  ///
  /// * [String] recipient (required):
  ///   Recipient of the message.
  ///
  /// * [int] recipientPublicKeyId (required):
  ///   Message recipient's public key ID for check to prevent sending message encrypted with outdated public key.
  ///
  /// * [String] messageId (required):
  ///
  /// * [MultipartFile] body (required):
  Future<Response> postSendMessageWithHttpInfo(int senderPublicKeyId, String recipient, int recipientPublicKeyId, String messageId, MultipartFile body, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/send_message';

    // ignore: prefer_final_locals
    Object? postBody = body;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'sender_public_key_id', senderPublicKeyId));
      queryParams.addAll(_queryParams('', 'recipient', recipient));
      queryParams.addAll(_queryParams('', 'recipient_public_key_id', recipientPublicKeyId));
      queryParams.addAll(_queryParams('', 'message_id', messageId));

    const contentTypes = <String>['application/octet-stream'];


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

  /// Send message to a match.
  ///
  /// Server config file defines max count for conversation pending messages. Max message size is u16::MAX.  Sending will fail if one or two way block exists.  Only the latest public key for sender and recipient can be used when sending a message.
  ///
  /// Parameters:
  ///
  /// * [int] senderPublicKeyId (required):
  ///
  /// * [String] recipient (required):
  ///   Recipient of the message.
  ///
  /// * [int] recipientPublicKeyId (required):
  ///   Message recipient's public key ID for check to prevent sending message encrypted with outdated public key.
  ///
  /// * [String] messageId (required):
  ///
  /// * [MultipartFile] body (required):
  Future<SendMessageResult?> postSendMessage(int senderPublicKeyId, String recipient, int recipientPublicKeyId, String messageId, MultipartFile body, { Future<void>? abortTrigger, }) async {
    final response = await postSendMessageWithHttpInfo(senderPublicKeyId, recipient, recipientPublicKeyId, messageId, body, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'SendMessageResult',) as SendMessageResult;
    
    }
    return null;
  }

  /// Unblock profile
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [AccountId] accountId (required):
  Future<Response> postUnblockProfileWithHttpInfo(AccountId accountId, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/unblock_profile';

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

  /// Unblock profile
  ///
  /// Parameters:
  ///
  /// * [AccountId] accountId (required):
  Future<void> postUnblockProfile(AccountId accountId, { Future<void>? abortTrigger, }) async {
    final response = await postUnblockProfileWithHttpInfo(accountId, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}
