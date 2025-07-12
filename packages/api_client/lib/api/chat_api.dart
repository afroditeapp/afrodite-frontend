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

  /// Delete sent like.
  ///
  /// Delete will not work if profile is a match.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [AccountId] accountId (required):
  Future<Response> deleteLikeWithHttpInfo(AccountId accountId,) async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/delete_like';

    // ignore: prefer_final_locals
    Object? postBody = accountId;

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

  /// Delete sent like.
  ///
  /// Delete will not work if profile is a match.
  ///
  /// Parameters:
  ///
  /// * [AccountId] accountId (required):
  Future<DeleteLikeResult?> deleteLike(AccountId accountId,) async {
    final response = await deleteLikeWithHttpInfo(accountId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'DeleteLikeResult',) as DeleteLikeResult;
    
    }
    return null;
  }

  /// Performs an HTTP 'GET /chat_api/get_chat_app_notification_settings' operation and returns the [Response].
  Future<Response> getChatAppNotificationSettingsWithHttpInfo() async {
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
    );
  }

  Future<ChatAppNotificationSettings?> getChatAppNotificationSettings() async {
    final response = await getChatAppNotificationSettingsWithHttpInfo();
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

  /// Get account specific conversation ID which can be used to display new message received notifications.
  ///
  /// The ID is available only for accounts which are a match.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  Future<Response> getConversationIdWithHttpInfo(String aid,) async {
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
    );
  }

  /// Get account specific conversation ID which can be used to display new message received notifications.
  ///
  /// The ID is available only for accounts which are a match.
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  Future<GetConversationId?> getConversationId(String aid,) async {
    final response = await getConversationIdWithHttpInfo(aid,);
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
  Future<Response> getDailyLikesLeftWithHttpInfo() async {
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
    );
  }

  /// Get daily likes left value.
  Future<DailyLikesLeft?> getDailyLikesLeft() async {
    final response = await getDailyLikesLeftWithHttpInfo();
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

  /// Get latest public key ID for some account
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  Future<Response> getLatestPublicKeyIdWithHttpInfo(String aid,) async {
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
    );
  }

  /// Get latest public key ID for some account
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  Future<GetLatestPublicKeyId?> getLatestPublicKeyId(String aid,) async {
    final response = await getLatestPublicKeyIdWithHttpInfo(aid,);
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

  /// Get matches
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getMatchesWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/matches';

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

  /// Get matches
  Future<AllMatchesPage?> getMatches() async {
    final response = await getMatchesWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'AllMatchesPage',) as AllMatchesPage;
    
    }
    return null;
  }

  /// Get message number of the most recent message that the recipient has viewed.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [AccountId] accountId (required):
  Future<Response> getMessageNumberOfLatestViewedMessageWithHttpInfo(AccountId accountId,) async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/message_number_of_latest_viewed_message';

    // ignore: prefer_final_locals
    Object? postBody = accountId;

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

  /// Get message number of the most recent message that the recipient has viewed.
  ///
  /// Parameters:
  ///
  /// * [AccountId] accountId (required):
  Future<MessageNumber?> getMessageNumberOfLatestViewedMessage(AccountId accountId,) async {
    final response = await getMessageNumberOfLatestViewedMessageWithHttpInfo(accountId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'MessageNumber',) as MessageNumber;
    
    }
    return null;
  }

  /// Get list of pending messages.
  ///
  /// The returned bytes is list of objects with following data: - Binary data length as minimal i64 - Binary data  Minimal i64 has this format: - i64 byte count (u8, values: 1, 2, 4, 8) - i64 bytes (little-endian)  Binary data is binary PGP message which contains backend signed binary data. The binary data contains: - Version (u8, values: 1) - Sender AccountId UUID big-endian bytes (16 bytes) - Receiver AccountId UUID big-endian bytes (16 bytes) - Sender public key ID (minimal i64) - Receiver public key ID (minimal i64) - Message number (minimal i64) - Unix time (minimal i64) - Message data
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getPendingMessagesWithHttpInfo() async {
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
    );
  }

  /// Get list of pending messages.
  ///
  /// The returned bytes is list of objects with following data: - Binary data length as minimal i64 - Binary data  Minimal i64 has this format: - i64 byte count (u8, values: 1, 2, 4, 8) - i64 bytes (little-endian)  Binary data is binary PGP message which contains backend signed binary data. The binary data contains: - Version (u8, values: 1) - Sender AccountId UUID big-endian bytes (16 bytes) - Receiver AccountId UUID big-endian bytes (16 bytes) - Sender public key ID (minimal i64) - Receiver public key ID (minimal i64) - Message number (minimal i64) - Unix time (minimal i64) - Message data
  Future<MultipartFile?> getPendingMessages() async {
    final response = await getPendingMessagesWithHttpInfo();
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
  /// # Access * Owner of the requested account * Permission [model::Permissions::admin_edit_max_public_key_count]
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  Future<Response> getPrivatePublicKeyInfoWithHttpInfo(String aid,) async {
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
    );
  }

  /// Get private public key info
  ///
  /// # Access * Owner of the requested account * Permission [model::Permissions::admin_edit_max_public_key_count]
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  Future<GetPrivatePublicKeyInfo?> getPrivatePublicKeyInfo(String aid,) async {
    final response = await getPrivatePublicKeyInfoWithHttpInfo(aid,);
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
  Future<Response> getPublicKeyWithHttpInfo(String aid, int id,) async {
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
    );
  }

  /// Get current public key of some account
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  ///
  /// * [int] id (required):
  Future<MultipartFile?> getPublicKey(String aid, int id,) async {
    final response = await getPublicKeyWithHttpInfo(aid, id,);
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

  /// Get list of received blocks
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getReceivedBlocksWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/received_blocks';

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

  /// Get list of received blocks
  Future<ReceivedBlocksPage?> getReceivedBlocks() async {
    final response = await getReceivedBlocksWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ReceivedBlocksPage',) as ReceivedBlocksPage;
    
    }
    return null;
  }

  /// Get list of sent blocks
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getSentBlocksWithHttpInfo() async {
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
    );
  }

  /// Get list of sent blocks
  Future<SentBlocksPage?> getSentBlocks() async {
    final response = await getSentBlocksWithHttpInfo();
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

  /// Get sent likes.
  ///
  /// Profile will not be returned if:  - Profile is hidden (not public) - Profile is a match
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getSentLikesWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/sent_likes';

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

  /// Get sent likes.
  ///
  /// Profile will not be returned if:  - Profile is hidden (not public) - Profile is a match
  Future<SentLikesPage?> getSentLikes() async {
    final response = await getSentLikesWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'SentLikesPage',) as SentLikesPage;
    
    }
    return null;
  }

  /// Performs an HTTP 'GET /chat_api/sent_message_ids' operation and returns the [Response].
  Future<Response> getSentMessageIdsWithHttpInfo() async {
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
    );
  }

  Future<SentMessageIdList?> getSentMessageIds() async {
    final response = await getSentMessageIdsWithHttpInfo();
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

  /// Create Jitsi Meet video call URLs to a meeting with an user.
  ///
  /// The user must be a match.  If result value is empty then video calling is disabled.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  Future<Response> getVideoCallUrlsWithHttpInfo(String aid,) async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/get_video_call_urls';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'aid', aid));

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

  /// Create Jitsi Meet video call URLs to a meeting with an user.
  ///
  /// The user must be a match.  If result value is empty then video calling is disabled.
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  Future<GetVideoCallUrlsResult?> getVideoCallUrls(String aid,) async {
    final response = await getVideoCallUrlsWithHttpInfo(aid,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'GetVideoCallUrlsResult',) as GetVideoCallUrlsResult;
    
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
  Future<Response> postAddPublicKeyWithHttpInfo(MultipartFile body,) async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/add_public_key';

    // ignore: prefer_final_locals
    Object? postBody = body;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/octet-stream'];


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

  /// Add new public key.
  ///
  /// Returns next public key ID number.  # Limits  Server can store limited amount of public keys. The limit is configurable from server config file and also user specific config exists. Max value between the two previous values is used to check is adding the key allowed.  Max key size is 8192 bytes.  The key must be OpenPGP public key with one signed user which ID is [model::AccountId] string.  
  ///
  /// Parameters:
  ///
  /// * [MultipartFile] body (required):
  Future<AddPublicKeyResult?> postAddPublicKey(MultipartFile body,) async {
    final response = await postAddPublicKeyWithHttpInfo(body,);
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

  /// Performs an HTTP 'POST /chat_api/add_receiver_acknowledgement' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [PendingMessageAcknowledgementList] pendingMessageAcknowledgementList (required):
  Future<Response> postAddReceiverAcknowledgementWithHttpInfo(PendingMessageAcknowledgementList pendingMessageAcknowledgementList,) async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/add_receiver_acknowledgement';

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
    );
  }

  /// Parameters:
  ///
  /// * [PendingMessageAcknowledgementList] pendingMessageAcknowledgementList (required):
  Future<void> postAddReceiverAcknowledgement(PendingMessageAcknowledgementList pendingMessageAcknowledgementList,) async {
    final response = await postAddReceiverAcknowledgementWithHttpInfo(pendingMessageAcknowledgementList,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /chat_api/add_sender_acknowledgement' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [SentMessageIdList] sentMessageIdList (required):
  Future<Response> postAddSenderAcknowledgementWithHttpInfo(SentMessageIdList sentMessageIdList,) async {
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
    );
  }

  /// Parameters:
  ///
  /// * [SentMessageIdList] sentMessageIdList (required):
  Future<void> postAddSenderAcknowledgement(SentMessageIdList sentMessageIdList,) async {
    final response = await postAddSenderAcknowledgementWithHttpInfo(sentMessageIdList,);
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
  Future<Response> postBlockProfileWithHttpInfo(AccountId accountId,) async {
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
    );
  }

  /// Block profile
  ///
  /// Parameters:
  ///
  /// * [AccountId] accountId (required):
  Future<void> postBlockProfile(AccountId accountId,) async {
    final response = await postBlockProfileWithHttpInfo(accountId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /chat_api/post_chat_app_notification_settings' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ChatAppNotificationSettings] chatAppNotificationSettings (required):
  Future<Response> postChatAppNotificationSettingsWithHttpInfo(ChatAppNotificationSettings chatAppNotificationSettings,) async {
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
    );
  }

  /// Parameters:
  ///
  /// * [ChatAppNotificationSettings] chatAppNotificationSettings (required):
  Future<void> postChatAppNotificationSettings(ChatAppNotificationSettings chatAppNotificationSettings,) async {
    final response = await postChatAppNotificationSettingsWithHttpInfo(chatAppNotificationSettings,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Report chat message.
  ///
  /// The report target must be a match.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [UpdateChatMessageReport] updateChatMessageReport (required):
  Future<Response> postChatMessageReportWithHttpInfo(UpdateChatMessageReport updateChatMessageReport,) async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/chat_message_report';

    // ignore: prefer_final_locals
    Object? postBody = updateChatMessageReport;

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

  /// Report chat message.
  ///
  /// The report target must be a match.
  ///
  /// Parameters:
  ///
  /// * [UpdateChatMessageReport] updateChatMessageReport (required):
  Future<UpdateReportResult?> postChatMessageReport(UpdateChatMessageReport updateChatMessageReport,) async {
    final response = await postChatMessageReportWithHttpInfo(updateChatMessageReport,);
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

  /// Performs an HTTP 'POST /chat_api/new_received_likes_count' operation and returns the [Response].
  Future<Response> postGetNewReceivedLikesCountWithHttpInfo() async {
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
    );
  }

  Future<NewReceivedLikesCountResult?> postGetNewReceivedLikesCount() async {
    final response = await postGetNewReceivedLikesCountWithHttpInfo();
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

  /// Update matches iterator and get next page of matches. If the page is empty there is no more matches available.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [MatchesIteratorSessionId] matchesIteratorSessionId (required):
  Future<Response> postGetNextMatchesPageWithHttpInfo(MatchesIteratorSessionId matchesIteratorSessionId,) async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/matches_page';

    // ignore: prefer_final_locals
    Object? postBody = matchesIteratorSessionId;

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

  /// Update matches iterator and get next page of matches. If the page is empty there is no more matches available.
  ///
  /// Parameters:
  ///
  /// * [MatchesIteratorSessionId] matchesIteratorSessionId (required):
  Future<MatchesPage?> postGetNextMatchesPage(MatchesIteratorSessionId matchesIteratorSessionId,) async {
    final response = await postGetNextMatchesPageWithHttpInfo(matchesIteratorSessionId,);
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

  /// Update received likes iterator and get next page of received likes. If the page is empty there is no more received likes available.
  ///
  /// Profile will not be returned if: - Profile is blocked - Profile is a match
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [ReceivedLikesIteratorSessionId] receivedLikesIteratorSessionId (required):
  Future<Response> postGetNextReceivedLikesPageWithHttpInfo(ReceivedLikesIteratorSessionId receivedLikesIteratorSessionId,) async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/received_likes';

    // ignore: prefer_final_locals
    Object? postBody = receivedLikesIteratorSessionId;

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

  /// Update received likes iterator and get next page of received likes. If the page is empty there is no more received likes available.
  ///
  /// Profile will not be returned if: - Profile is blocked - Profile is a match
  ///
  /// Parameters:
  ///
  /// * [ReceivedLikesIteratorSessionId] receivedLikesIteratorSessionId (required):
  Future<ReceivedLikesPage?> postGetNextReceivedLikesPage(ReceivedLikesIteratorSessionId receivedLikesIteratorSessionId,) async {
    final response = await postGetNextReceivedLikesPageWithHttpInfo(receivedLikesIteratorSessionId,);
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
  /// * [SentMessageId] sentMessageId (required):
  Future<Response> postGetSentMessageWithHttpInfo(SentMessageId sentMessageId,) async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/sent_message';

    // ignore: prefer_final_locals
    Object? postBody = sentMessageId;

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

  /// Receive unreceived [model_chat::SignedMessageData] for sent message.
  ///
  /// This is HTTP POST route only to allow JSON request body.
  ///
  /// Parameters:
  ///
  /// * [SentMessageId] sentMessageId (required):
  Future<GetSentMessage?> postGetSentMessage(SentMessageId sentMessageId,) async {
    final response = await postGetSentMessageWithHttpInfo(sentMessageId,);
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

  /// Update message number of the most recent message that the recipient has viewed.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [UpdateMessageViewStatus] updateMessageViewStatus (required):
  Future<Response> postMessageNumberOfLatestViewedMessageWithHttpInfo(UpdateMessageViewStatus updateMessageViewStatus,) async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/message_number_of_latest_viewed_message';

    // ignore: prefer_final_locals
    Object? postBody = updateMessageViewStatus;

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

  /// Update message number of the most recent message that the recipient has viewed.
  ///
  /// Parameters:
  ///
  /// * [UpdateMessageViewStatus] updateMessageViewStatus (required):
  Future<void> postMessageNumberOfLatestViewedMessage(UpdateMessageViewStatus updateMessageViewStatus,) async {
    final response = await postMessageNumberOfLatestViewedMessageWithHttpInfo(updateMessageViewStatus,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /chat_api/matches/reset' operation and returns the [Response].
  Future<Response> postResetMatchesPagingWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/matches/reset';

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

  Future<ResetMatchesIteratorResult?> postResetMatchesPaging() async {
    final response = await postResetMatchesPagingWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ResetMatchesIteratorResult',) as ResetMatchesIteratorResult;
    
    }
    return null;
  }

  /// Performs an HTTP 'POST /chat_api/received_likes/reset' operation and returns the [Response].
  Future<Response> postResetReceivedLikesPagingWithHttpInfo() async {
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
    );
  }

  Future<ResetReceivedLikesIteratorResult?> postResetReceivedLikesPaging() async {
    final response = await postResetReceivedLikesPagingWithHttpInfo();
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

  /// Send a like to some account. If both will like each other, then the accounts will be a match.
  ///
  /// This route might update [model_chat::DailyLikesLeft] and WebSocket event about the update is not sent because this route returns the new value.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [AccountId] accountId (required):
  Future<Response> postSendLikeWithHttpInfo(AccountId accountId,) async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/send_like';

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

  /// Send a like to some account. If both will like each other, then the accounts will be a match.
  ///
  /// This route might update [model_chat::DailyLikesLeft] and WebSocket event about the update is not sent because this route returns the new value.
  ///
  /// Parameters:
  ///
  /// * [AccountId] accountId (required):
  Future<SendLikeResult?> postSendLike(AccountId accountId,) async {
    final response = await postSendLikeWithHttpInfo(accountId,);
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
  /// Max pending message count is 50. Max message size is u16::MAX.  The sender message ID must be value which server expects.  Sending will fail if one or two way block exists.  Only the latest public key for sender and receiver can be used when sending a message.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] senderPublicKeyId (required):
  ///
  /// * [String] receiver (required):
  ///   Receiver of the message.
  ///
  /// * [int] receiverPublicKeyId (required):
  ///   Message receiver's public key ID for check to prevent sending message encrypted with outdated public key.
  ///
  /// * [int] clientId (required):
  ///
  /// * [int] clientLocalId (required):
  ///
  /// * [MultipartFile] body (required):
  Future<Response> postSendMessageWithHttpInfo(int senderPublicKeyId, String receiver, int receiverPublicKeyId, int clientId, int clientLocalId, MultipartFile body,) async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/send_message';

    // ignore: prefer_final_locals
    Object? postBody = body;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'sender_public_key_id', senderPublicKeyId));
      queryParams.addAll(_queryParams('', 'receiver', receiver));
      queryParams.addAll(_queryParams('', 'receiver_public_key_id', receiverPublicKeyId));
      queryParams.addAll(_queryParams('', 'client_id', clientId));
      queryParams.addAll(_queryParams('', 'client_local_id', clientLocalId));

    const contentTypes = <String>['application/octet-stream'];


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

  /// Send message to a match.
  ///
  /// Max pending message count is 50. Max message size is u16::MAX.  The sender message ID must be value which server expects.  Sending will fail if one or two way block exists.  Only the latest public key for sender and receiver can be used when sending a message.
  ///
  /// Parameters:
  ///
  /// * [int] senderPublicKeyId (required):
  ///
  /// * [String] receiver (required):
  ///   Receiver of the message.
  ///
  /// * [int] receiverPublicKeyId (required):
  ///   Message receiver's public key ID for check to prevent sending message encrypted with outdated public key.
  ///
  /// * [int] clientId (required):
  ///
  /// * [int] clientLocalId (required):
  ///
  /// * [MultipartFile] body (required):
  Future<SendMessageResult?> postSendMessage(int senderPublicKeyId, String receiver, int receiverPublicKeyId, int clientId, int clientLocalId, MultipartFile body,) async {
    final response = await postSendMessageWithHttpInfo(senderPublicKeyId, receiver, receiverPublicKeyId, clientId, clientLocalId, body,);
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
  Future<Response> postUnblockProfileWithHttpInfo(AccountId accountId,) async {
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
    );
  }

  /// Unblock profile
  ///
  /// Parameters:
  ///
  /// * [AccountId] accountId (required):
  Future<void> postUnblockProfile(AccountId accountId,) async {
    final response = await postUnblockProfileWithHttpInfo(accountId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}
