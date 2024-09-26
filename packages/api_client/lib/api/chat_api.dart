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
    final path = r'/O3DZlGOjDYbQ8PlCorta0onQDLI';

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
  Future<LimitedActionResult?> deleteLike(AccountId accountId,) async {
    final response = await deleteLikeWithHttpInfo(accountId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'LimitedActionResult',) as LimitedActionResult;
    
    }
    return null;
  }

  /// Get matches
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getMatchesWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/kzySqAe9qYi69MoCBnFGKdn76-Q';

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
  Future<MatchesPage?> getMatches() async {
    final response = await getMatchesWithHttpInfo();
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

  /// Get message number of the most recent message that the recipient has viewed.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [AccountId] accountId (required):
  Future<Response> getMessageNumberOfLatestViewedMessageWithHttpInfo(AccountId accountId,) async {
    // ignore: prefer_const_declarations
    final path = r'/gas7m77c7kw7N7TKyMQVzUKy3AQ';

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
  /// The returned bytes is list of objects with following data: - UTF-8 text length encoded as 16 bit little endian number. - UTF-8 text which is PendingMessage JSON. - Binary message data length as 16 bit little endian number. - Binary message data
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getPendingMessagesWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/7sKe87sefWrLYS0JvbPS10_F8oc';

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
  /// The returned bytes is list of objects with following data: - UTF-8 text length encoded as 16 bit little endian number. - UTF-8 text which is PendingMessage JSON. - Binary message data length as 16 bit little endian number. - Binary message data
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

  /// Get current public key of some account
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  ///
  /// * [int] version (required):
  Future<Response> getPublicKeyWithHttpInfo(String aid, int version,) async {
    // ignore: prefer_const_declarations
    final path = r'/e-r4VrqWJD1kIttg1McD9kv5o0k/{aid}'
      .replaceAll('{aid}', aid);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'version', version));

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
  /// * [int] version (required):
  Future<GetPublicKey?> getPublicKey(String aid, int version,) async {
    final response = await getPublicKeyWithHttpInfo(aid, version,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'GetPublicKey',) as GetPublicKey;
    
    }
    return null;
  }

  /// Get list of received blocks
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getReceivedBlocksWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/hjP9LovH2kBxnbwWKSyVgFL4o58';

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
    final path = r'/3qT3qSKKzXHjo8LGEphwMLF8vjk';

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
  /// Profile will not be returned if:  - Profile is hidden (not public) - Profile is blocked - Profile is a match
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getSentLikesWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/pTybb424uGsXvCyOLljsPujVe5Y';

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
  /// Profile will not be returned if:  - Profile is hidden (not public) - Profile is blocked - Profile is a match
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

  /// Performs an HTTP 'GET /-sDy1a8MS72uNy3UUtX9K8-wYWU' operation and returns the [Response].
  Future<Response> getSentMessageIdsWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/-sDy1a8MS72uNy3UUtX9K8-wYWU';

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

  /// Performs an HTTP 'POST /PBreZU5Cmo7tTtNMMb58yN_xFZ8' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [PendingMessageAcknowledgementList] pendingMessageAcknowledgementList (required):
  Future<Response> postAddReceiverAcknowledgementWithHttpInfo(PendingMessageAcknowledgementList pendingMessageAcknowledgementList,) async {
    // ignore: prefer_const_declarations
    final path = r'/PBreZU5Cmo7tTtNMMb58yN_xFZ8';

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

  /// Performs an HTTP 'POST /E-yVIcGOLJyZ7nsT_Lh4KPCRkQg' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [SentMessageIdList] sentMessageIdList (required):
  Future<Response> postAddSenderAcknowledgementWithHttpInfo(SentMessageIdList sentMessageIdList,) async {
    // ignore: prefer_const_declarations
    final path = r'/E-yVIcGOLJyZ7nsT_Lh4KPCRkQg';

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
    final path = r'/MpWSY01lXj7KaDK1KCNHLWRg9k4';

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

  /// Performs an HTTP 'POST /dCPla4TZep6KONk57U2J7p7s6jw' operation and returns the [Response].
  Future<Response> postGetNewReceivedLikesCountWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/dCPla4TZep6KONk57U2J7p7s6jw';

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

  /// Update received likes iterator and get next page
  ///
  /// of received likes. If the page is empty there is no more received likes available.  Profile will not be returned if: - Profile is blocked - Profile is a match
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [ReceivedLikesIteratorSessionId] receivedLikesIteratorSessionId (required):
  Future<Response> postGetNextReceivedLikesPageWithHttpInfo(ReceivedLikesIteratorSessionId receivedLikesIteratorSessionId,) async {
    // ignore: prefer_const_declarations
    final path = r'/eEB4pq6DGUYlMVAYwPCm2RT5HP0';

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

  /// Update received likes iterator and get next page
  ///
  /// of received likes. If the page is empty there is no more received likes available.  Profile will not be returned if: - Profile is blocked - Profile is a match
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

  /// Get pending notification and reset pending notification.
  ///
  /// Requesting this route is always valid to avoid figuring out device token values more easily.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [PendingNotificationToken] pendingNotificationToken (required):
  Future<Response> postGetPendingNotificationWithHttpInfo(PendingNotificationToken pendingNotificationToken,) async {
    // ignore: prefer_const_declarations
    final path = r'/MhQXhJMKgrUh0s95FueOgalQg-o';

    // ignore: prefer_final_locals
    Object? postBody = pendingNotificationToken;

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

  /// Get pending notification and reset pending notification.
  ///
  /// Requesting this route is always valid to avoid figuring out device token values more easily.
  ///
  /// Parameters:
  ///
  /// * [PendingNotificationToken] pendingNotificationToken (required):
  Future<PendingNotificationWithData?> postGetPendingNotification(PendingNotificationToken pendingNotificationToken,) async {
    final response = await postGetPendingNotificationWithHttpInfo(pendingNotificationToken,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'PendingNotificationWithData',) as PendingNotificationWithData;
    
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
    final path = r'/gas7m77c7kw7N7TKyMQVzUKy3AQ';

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

  /// Replace current public key with a new public key.
  ///
  /// Returns public key ID number which server increments. This must be called only when needed as this route will fail every time if current public key ID number is i64::MAX.  Only version 1 public keys are currently supported.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [SetPublicKey] setPublicKey (required):
  Future<Response> postPublicKeyWithHttpInfo(SetPublicKey setPublicKey,) async {
    // ignore: prefer_const_declarations
    final path = r'/e-r4VrqWJD1kIttg1McD9kv5o0k';

    // ignore: prefer_final_locals
    Object? postBody = setPublicKey;

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

  /// Replace current public key with a new public key.
  ///
  /// Returns public key ID number which server increments. This must be called only when needed as this route will fail every time if current public key ID number is i64::MAX.  Only version 1 public keys are currently supported.
  ///
  /// Parameters:
  ///
  /// * [SetPublicKey] setPublicKey (required):
  Future<PublicKeyId?> postPublicKey(SetPublicKey setPublicKey,) async {
    final response = await postPublicKeyWithHttpInfo(setPublicKey,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'PublicKeyId',) as PublicKeyId;
    
    }
    return null;
  }

  /// Performs an HTTP 'POST /B75BRIylLV-JmwoB4YiOYSlyO-A' operation and returns the [Response].
  Future<Response> postResetReceivedLikesPagingWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/B75BRIylLV-JmwoB4YiOYSlyO-A';

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

  /// Send a like to some account. If both will like each other, then
  ///
  /// the accounts will be a match.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [AccountId] accountId (required):
  Future<Response> postSendLikeWithHttpInfo(AccountId accountId,) async {
    // ignore: prefer_const_declarations
    final path = r'/sXq6ko76GtT7DuNXnkTTtFL6isY';

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

  /// Send a like to some account. If both will like each other, then
  ///
  /// the accounts will be a match.
  ///
  /// Parameters:
  ///
  /// * [AccountId] accountId (required):
  Future<LimitedActionResult?> postSendLike(AccountId accountId,) async {
    final response = await postSendLikeWithHttpInfo(accountId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'LimitedActionResult',) as LimitedActionResult;
    
    }
    return null;
  }

  /// Send message to a match.
  ///
  /// Max pending message count is 50. Max message size is u16::MAX.  The sender message ID must be value which server expects.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] receiver (required):
  ///   Receiver of the message.
  ///
  /// * [int] receiverPublicKeyId (required):
  ///   Message receiver's public key ID for check to prevent sending message encrypted with outdated public key.
  ///
  /// * [int] receiverPublicKeyVersion (required):
  ///
  /// * [int] clientId (required):
  ///
  /// * [int] clientLocalId (required):
  ///
  /// * [MultipartFile] body (required):
  Future<Response> postSendMessageWithHttpInfo(String receiver, int receiverPublicKeyId, int receiverPublicKeyVersion, int clientId, int clientLocalId, MultipartFile body,) async {
    // ignore: prefer_const_declarations
    final path = r'/YEFESgzw0YxQUETcUmnmfWCaF1g';

    // ignore: prefer_final_locals
    Object? postBody = body;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'receiver', receiver));
      queryParams.addAll(_queryParams('', 'receiver_public_key_id', receiverPublicKeyId));
      queryParams.addAll(_queryParams('', 'receiver_public_key_version', receiverPublicKeyVersion));
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
  /// Max pending message count is 50. Max message size is u16::MAX.  The sender message ID must be value which server expects.
  ///
  /// Parameters:
  ///
  /// * [String] receiver (required):
  ///   Receiver of the message.
  ///
  /// * [int] receiverPublicKeyId (required):
  ///   Message receiver's public key ID for check to prevent sending message encrypted with outdated public key.
  ///
  /// * [int] receiverPublicKeyVersion (required):
  ///
  /// * [int] clientId (required):
  ///
  /// * [int] clientLocalId (required):
  ///
  /// * [MultipartFile] body (required):
  Future<SendMessageResult?> postSendMessage(String receiver, int receiverPublicKeyId, int receiverPublicKeyVersion, int clientId, int clientLocalId, MultipartFile body,) async {
    final response = await postSendMessageWithHttpInfo(receiver, receiverPublicKeyId, receiverPublicKeyVersion, clientId, clientLocalId, body,);
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

  /// Performs an HTTP 'POST /CBoGGZ4HDW0REbM6SxasDCvXJNM' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [FcmDeviceToken] fcmDeviceToken (required):
  Future<Response> postSetDeviceTokenWithHttpInfo(FcmDeviceToken fcmDeviceToken,) async {
    // ignore: prefer_const_declarations
    final path = r'/CBoGGZ4HDW0REbM6SxasDCvXJNM';

    // ignore: prefer_final_locals
    Object? postBody = fcmDeviceToken;

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
  /// * [FcmDeviceToken] fcmDeviceToken (required):
  Future<PendingNotificationToken?> postSetDeviceToken(FcmDeviceToken fcmDeviceToken,) async {
    final response = await postSetDeviceTokenWithHttpInfo(fcmDeviceToken,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'PendingNotificationToken',) as PendingNotificationToken;
    
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
    final path = r'/j2Ofh-WeAFmjCQqO_AyHIM1eZEo';

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
