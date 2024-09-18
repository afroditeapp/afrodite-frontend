//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ApiClient {
  ApiClient({this.basePath = 'http://localhost', this.authentication,});

  final String basePath;
  final Authentication? authentication;

  var _client = Client();
  final _defaultHeaderMap = <String, String>{};

  /// Returns the current HTTP [Client] instance to use in this class.
  ///
  /// The return value is guaranteed to never be null.
  Client get client => _client;

  /// Requests to use a new HTTP [Client] in this class.
  set client(Client newClient) {
    _client = newClient;
  }

  Map<String, String> get defaultHeaderMap => _defaultHeaderMap;

  void addDefaultHeader(String key, String value) {
     _defaultHeaderMap[key] = value;
  }

  // We don't use a Map<String, String> for queryParams.
  // If collectionFormat is 'multi', a key might appear multiple times.
  Future<Response> invokeAPI(
    String path,
    String method,
    List<QueryParam> queryParams,
    Object? body,
    Map<String, String> headerParams,
    Map<String, String> formParams,
    String? contentType,
  ) async {
    await authentication?.applyToParams(queryParams, headerParams);

    headerParams.addAll(_defaultHeaderMap);
    if (contentType != null) {
      headerParams['Content-Type'] = contentType;
    }

    final urlEncodedQueryParams = queryParams.map((param) => '$param');
    final queryString = urlEncodedQueryParams.isNotEmpty ? '?${urlEncodedQueryParams.join('&')}' : '';
    final uri = Uri.parse('$basePath$path$queryString');

    try {
      // Special case for uploading a single file which isn't a 'multipart/form-data'.
      if (
        body is MultipartFile && (contentType == null ||
        !contentType.toLowerCase().startsWith('multipart/form-data'))
      ) {
        final request = StreamedRequest(method, uri);
        request.headers.addAll(headerParams);
        request.contentLength = body.length;
        body.finalize().listen(
          request.sink.add,
          onDone: request.sink.close,
          // ignore: avoid_types_on_closure_parameters
          onError: (Object error, StackTrace trace) => request.sink.close(),
          cancelOnError: true,
        );
        final response = await _client.send(request);
        return Response.fromStream(response);
      }

      if (body is MultipartRequest) {
        final request = MultipartRequest(method, uri);
        request.fields.addAll(body.fields);
        request.files.addAll(body.files);
        request.headers.addAll(body.headers);
        request.headers.addAll(headerParams);
        final response = await _client.send(request);
        return Response.fromStream(response);
      }

      final msgBody = contentType == 'application/x-www-form-urlencoded'
        ? formParams
        : await serializeAsync(body);
      final nullableHeaderParams = headerParams.isEmpty ? null : headerParams;

      switch(method) {
        case 'POST': return await _client.post(uri, headers: nullableHeaderParams, body: msgBody,);
        case 'PUT': return await _client.put(uri, headers: nullableHeaderParams, body: msgBody,);
        case 'DELETE': return await _client.delete(uri, headers: nullableHeaderParams, body: msgBody,);
        case 'PATCH': return await _client.patch(uri, headers: nullableHeaderParams, body: msgBody,);
        case 'HEAD': return await _client.head(uri, headers: nullableHeaderParams,);
        case 'GET': return await _client.get(uri, headers: nullableHeaderParams,);
      }
    } on SocketException catch (error, trace) {
      throw ApiException.withInner(
        HttpStatus.badRequest,
        'Socket operation failed: $method $path',
        error,
        trace,
      );
    } on TlsException catch (error, trace) {
      throw ApiException.withInner(
        HttpStatus.badRequest,
        'TLS/SSL communication failed: $method $path',
        error,
        trace,
      );
    } on IOException catch (error, trace) {
      throw ApiException.withInner(
        HttpStatus.badRequest,
        'I/O operation failed: $method $path',
        error,
        trace,
      );
    } on ClientException catch (error, trace) {
      throw ApiException.withInner(
        HttpStatus.badRequest,
        'HTTP connection failed: $method $path',
        error,
        trace,
      );
    } on Exception catch (error, trace) {
      throw ApiException.withInner(
        HttpStatus.badRequest,
        'Exception occurred: $method $path',
        error,
        trace,
      );
    }

    throw ApiException(
      HttpStatus.badRequest,
      'Invalid HTTP operation: $method $path',
    );
  }

  Future<dynamic> deserializeAsync(String value, String targetType, {bool growable = false,}) async =>
    // ignore: deprecated_member_use_from_same_package
    deserialize(value, targetType, growable: growable);

  @Deprecated('Scheduled for removal in OpenAPI Generator 6.x. Use deserializeAsync() instead.')
  dynamic deserialize(String value, String targetType, {bool growable = false,}) {
    // Remove all spaces. Necessary for regular expressions as well.
    targetType = targetType.replaceAll(' ', ''); // ignore: parameter_assignments

    // If the expected target type is String, nothing to do...
    return targetType == 'String'
      ? value
      : fromJson(json.decode(value), targetType, growable: growable);
  }

  // ignore: deprecated_member_use_from_same_package
  Future<String> serializeAsync(Object? value) async => serialize(value);

  @Deprecated('Scheduled for removal in OpenAPI Generator 6.x. Use serializeAsync() instead.')
  String serialize(Object? value) => value == null ? '' : json.encode(value);

  /// Returns a native instance of an OpenAPI class matching the [specified type][targetType].
  static dynamic fromJson(dynamic value, String targetType, {bool growable = false,}) {
    try {
      switch (targetType) {
        case 'String':
          return value is String ? value : value.toString();
        case 'int':
          return value is int ? value : int.parse('$value');
        case 'double':
          return value is double ? value : double.parse('$value');
        case 'bool':
          if (value is bool) {
            return value;
          }
          final valueString = '$value'.toLowerCase();
          return valueString == 'true' || valueString == '1';
        case 'DateTime':
          return value is DateTime ? value : DateTime.tryParse(value);
        case 'AcceptedProfileAges':
          return AcceptedProfileAges.fromJson(value);
        case 'AccessToken':
          return AccessToken.fromJson(value);
        case 'AccessibleAccount':
          return AccessibleAccount.fromJson(value);
        case 'Account':
          return Account.fromJson(value);
        case 'AccountContent':
          return AccountContent.fromJson(value);
        case 'AccountData':
          return AccountData.fromJson(value);
        case 'AccountId':
          return AccountId.fromJson(value);
        case 'AccountSetup':
          return AccountSetup.fromJson(value);
        case 'AccountState':
          return AccountStateTypeTransformer().decode(value);
        case 'AccountSyncVersion':
          return AccountSyncVersion.fromJson(value);
        case 'Attribute':
          return Attribute.fromJson(value);
        case 'AttributeMode':
          return AttributeModeTypeTransformer().decode(value);
        case 'AttributeOrderMode':
          return AttributeOrderModeTypeTransformer().decode(value);
        case 'AttributeValue':
          return AttributeValue.fromJson(value);
        case 'AttributeValueOrderMode':
          return AttributeValueOrderModeTypeTransformer().decode(value);
        case 'AuthPair':
          return AuthPair.fromJson(value);
        case 'AvailableProfileAttributes':
          return AvailableProfileAttributes.fromJson(value);
        case 'BackendConfig':
          return BackendConfig.fromJson(value);
        case 'BackendVersion':
          return BackendVersion.fromJson(value);
        case 'BooleanSetting':
          return BooleanSetting.fromJson(value);
        case 'BotConfig':
          return BotConfig.fromJson(value);
        case 'BuildInfo':
          return BuildInfo.fromJson(value);
        case 'Capabilities':
          return Capabilities.fromJson(value);
        case 'ClientId':
          return ClientId.fromJson(value);
        case 'ClientInfo':
          return ClientInfo.fromJson(value);
        case 'ClientLocalId':
          return ClientLocalId.fromJson(value);
        case 'ClientType':
          return ClientTypeTypeTransformer().decode(value);
        case 'CommandOutput':
          return CommandOutput.fromJson(value);
        case 'ContentId':
          return ContentId.fromJson(value);
        case 'ContentInfo':
          return ContentInfo.fromJson(value);
        case 'ContentInfoDetailed':
          return ContentInfoDetailed.fromJson(value);
        case 'ContentProcessingId':
          return ContentProcessingId.fromJson(value);
        case 'ContentProcessingState':
          return ContentProcessingState.fromJson(value);
        case 'ContentProcessingStateChanged':
          return ContentProcessingStateChanged.fromJson(value);
        case 'ContentProcessingStateType':
          return ContentProcessingStateTypeTypeTransformer().decode(value);
        case 'ContentSlot':
          return ContentSlotTypeTransformer().decode(value);
        case 'ContentState':
          return ContentStateTypeTransformer().decode(value);
        case 'CurrentModerationRequest':
          return CurrentModerationRequest.fromJson(value);
        case 'DeleteStatus':
          return DeleteStatus.fromJson(value);
        case 'DemoModeConfirmLogin':
          return DemoModeConfirmLogin.fromJson(value);
        case 'DemoModeConfirmLoginResult':
          return DemoModeConfirmLoginResult.fromJson(value);
        case 'DemoModeLoginResult':
          return DemoModeLoginResult.fromJson(value);
        case 'DemoModeLoginToAccount':
          return DemoModeLoginToAccount.fromJson(value);
        case 'DemoModeLoginToken':
          return DemoModeLoginToken.fromJson(value);
        case 'DemoModePassword':
          return DemoModePassword.fromJson(value);
        case 'DemoModeToken':
          return DemoModeToken.fromJson(value);
        case 'DownloadType':
          return DownloadTypeTypeTransformer().decode(value);
        case 'DownloadTypeQueryParam':
          return DownloadTypeQueryParam.fromJson(value);
        case 'EventToClient':
          return EventToClient.fromJson(value);
        case 'EventType':
          return EventTypeTypeTransformer().decode(value);
        case 'FavoriteProfilesPage':
          return FavoriteProfilesPage.fromJson(value);
        case 'FcmDeviceToken':
          return FcmDeviceToken.fromJson(value);
        case 'GetContentQueryParams':
          return GetContentQueryParams.fromJson(value);
        case 'GetInitialProfileAgeInfoResult':
          return GetInitialProfileAgeInfoResult.fromJson(value);
        case 'GetMyProfileResult':
          return GetMyProfileResult.fromJson(value);
        case 'GetProfileContentQueryParams':
          return GetProfileContentQueryParams.fromJson(value);
        case 'GetProfileContentResult':
          return GetProfileContentResult.fromJson(value);
        case 'GetProfileQueryParam':
          return GetProfileQueryParam.fromJson(value);
        case 'GetProfileResult':
          return GetProfileResult.fromJson(value);
        case 'GetPublicKey':
          return GetPublicKey.fromJson(value);
        case 'GroupValues':
          return GroupValues.fromJson(value);
        case 'HandleModerationRequest':
          return HandleModerationRequest.fromJson(value);
        case 'IconLocation':
          return IconLocationTypeTransformer().decode(value);
        case 'IconResource':
          return IconResource.fromJson(value);
        case 'IteratorSessionId':
          return IteratorSessionId.fromJson(value);
        case 'Language':
          return Language.fromJson(value);
        case 'LastSeenTimeFilter':
          return LastSeenTimeFilter.fromJson(value);
        case 'LatestBirthdate':
          return LatestBirthdate.fromJson(value);
        case 'LatestViewedMessageChanged':
          return LatestViewedMessageChanged.fromJson(value);
        case 'LimitedActionResult':
          return LimitedActionResult.fromJson(value);
        case 'LimitedActionStatus':
          return LimitedActionStatusTypeTransformer().decode(value);
        case 'Location':
          return Location.fromJson(value);
        case 'LoginResult':
          return LoginResult.fromJson(value);
        case 'MapTileX':
          return MapTileX.fromJson(value);
        case 'MapTileY':
          return MapTileY.fromJson(value);
        case 'MapTileZ':
          return MapTileZ.fromJson(value);
        case 'MatchesPage':
          return MatchesPage.fromJson(value);
        case 'MatchesSyncVersion':
          return MatchesSyncVersion.fromJson(value);
        case 'MediaContentType':
          return MediaContentTypeTypeTransformer().decode(value);
        case 'MessageNumber':
          return MessageNumber.fromJson(value);
        case 'Moderation':
          return Moderation.fromJson(value);
        case 'ModerationList':
          return ModerationList.fromJson(value);
        case 'ModerationQueueType':
          return ModerationQueueTypeTypeTransformer().decode(value);
        case 'ModerationQueueTypeParam':
          return ModerationQueueTypeParam.fromJson(value);
        case 'ModerationRequest':
          return ModerationRequest.fromJson(value);
        case 'ModerationRequestContent':
          return ModerationRequestContent.fromJson(value);
        case 'ModerationRequestId':
          return ModerationRequestId.fromJson(value);
        case 'ModerationRequestState':
          return ModerationRequestStateTypeTransformer().decode(value);
        case 'NewContentParams':
          return NewContentParams.fromJson(value);
        case 'NewReceivedLikesAvailableResult':
          return NewReceivedLikesAvailableResult.fromJson(value);
        case 'PendingMessage':
          return PendingMessage.fromJson(value);
        case 'PendingMessageAcknowledgementList':
          return PendingMessageAcknowledgementList.fromJson(value);
        case 'PendingMessageId':
          return PendingMessageId.fromJson(value);
        case 'PendingNotificationToken':
          return PendingNotificationToken.fromJson(value);
        case 'PendingNotificationWithData':
          return PendingNotificationWithData.fromJson(value);
        case 'PendingProfileContent':
          return PendingProfileContent.fromJson(value);
        case 'PendingSecurityContent':
          return PendingSecurityContent.fromJson(value);
        case 'PerfHistoryQuery':
          return PerfHistoryQuery.fromJson(value);
        case 'PerfHistoryQueryResult':
          return PerfHistoryQueryResult.fromJson(value);
        case 'PerfHistoryValue':
          return PerfHistoryValue.fromJson(value);
        case 'PerfValueArea':
          return PerfValueArea.fromJson(value);
        case 'Profile':
          return Profile.fromJson(value);
        case 'ProfileAttributeFilterList':
          return ProfileAttributeFilterList.fromJson(value);
        case 'ProfileAttributeFilterListUpdate':
          return ProfileAttributeFilterListUpdate.fromJson(value);
        case 'ProfileAttributeFilterValue':
          return ProfileAttributeFilterValue.fromJson(value);
        case 'ProfileAttributeFilterValueUpdate':
          return ProfileAttributeFilterValueUpdate.fromJson(value);
        case 'ProfileAttributeValue':
          return ProfileAttributeValue.fromJson(value);
        case 'ProfileAttributeValueUpdate':
          return ProfileAttributeValueUpdate.fromJson(value);
        case 'ProfileAttributes':
          return ProfileAttributes.fromJson(value);
        case 'ProfileAttributesSyncVersion':
          return ProfileAttributesSyncVersion.fromJson(value);
        case 'ProfileContent':
          return ProfileContent.fromJson(value);
        case 'ProfileContentVersion':
          return ProfileContentVersion.fromJson(value);
        case 'ProfileLink':
          return ProfileLink.fromJson(value);
        case 'ProfilePage':
          return ProfilePage.fromJson(value);
        case 'ProfileSearchAgeRange':
          return ProfileSearchAgeRange.fromJson(value);
        case 'ProfileSyncVersion':
          return ProfileSyncVersion.fromJson(value);
        case 'ProfileUpdate':
          return ProfileUpdate.fromJson(value);
        case 'ProfileVersion':
          return ProfileVersion.fromJson(value);
        case 'ProfileVisibility':
          return ProfileVisibilityTypeTransformer().decode(value);
        case 'PublicKey':
          return PublicKey.fromJson(value);
        case 'PublicKeyData':
          return PublicKeyData.fromJson(value);
        case 'PublicKeyId':
          return PublicKeyId.fromJson(value);
        case 'PublicKeyIdAndVersion':
          return PublicKeyIdAndVersion.fromJson(value);
        case 'PublicKeyVersion':
          return PublicKeyVersion.fromJson(value);
        case 'RebootQueryParam':
          return RebootQueryParam.fromJson(value);
        case 'ReceivedBlocksPage':
          return ReceivedBlocksPage.fromJson(value);
        case 'ReceivedBlocksSyncVersion':
          return ReceivedBlocksSyncVersion.fromJson(value);
        case 'ReceivedLikesIteratorSessionId':
          return ReceivedLikesIteratorSessionId.fromJson(value);
        case 'ReceivedLikesPage':
          return ReceivedLikesPage.fromJson(value);
        case 'ReceivedLikesSyncVersion':
          return ReceivedLikesSyncVersion.fromJson(value);
        case 'RefreshToken':
          return RefreshToken.fromJson(value);
        case 'ResetDataQueryParam':
          return ResetDataQueryParam.fromJson(value);
        case 'ResetReceivedLikesIteratorResult':
          return ResetReceivedLikesIteratorResult.fromJson(value);
        case 'SearchGroups':
          return SearchGroups.fromJson(value);
        case 'SecurityContent':
          return SecurityContent.fromJson(value);
        case 'SendMessageResult':
          return SendMessageResult.fromJson(value);
        case 'SentBlocksPage':
          return SentBlocksPage.fromJson(value);
        case 'SentBlocksSyncVersion':
          return SentBlocksSyncVersion.fromJson(value);
        case 'SentLikesPage':
          return SentLikesPage.fromJson(value);
        case 'SentLikesSyncVersion':
          return SentLikesSyncVersion.fromJson(value);
        case 'SentMessageId':
          return SentMessageId.fromJson(value);
        case 'SentMessageIdList':
          return SentMessageIdList.fromJson(value);
        case 'SetAccountSetup':
          return SetAccountSetup.fromJson(value);
        case 'SetProfileContent':
          return SetProfileContent.fromJson(value);
        case 'SetPublicKey':
          return SetPublicKey.fromJson(value);
        case 'SignInWithLoginInfo':
          return SignInWithLoginInfo.fromJson(value);
        case 'SlotId':
          return SlotId.fromJson(value);
        case 'SoftwareInfo':
          return SoftwareInfo.fromJson(value);
        case 'SoftwareOptions':
          return SoftwareOptionsTypeTransformer().decode(value);
        case 'SyncVersion':
          return SyncVersion.fromJson(value);
        case 'SystemInfo':
          return SystemInfo.fromJson(value);
        case 'SystemInfoList':
          return SystemInfoList.fromJson(value);
        case 'TimeGranularity':
          return TimeGranularityTypeTransformer().decode(value);
        case 'Translation':
          return Translation.fromJson(value);
        case 'UnixTime':
          return UnixTime.fromJson(value);
        case 'UpdateMessageViewStatus':
          return UpdateMessageViewStatus.fromJson(value);
        default:
          dynamic match;
          if (value is List && (match = _regList.firstMatch(targetType)?.group(1)) != null) {
            return value
              .map<dynamic>((dynamic v) => fromJson(v, match, growable: growable,))
              .toList(growable: growable);
          }
          if (value is Set && (match = _regSet.firstMatch(targetType)?.group(1)) != null) {
            return value
              .map<dynamic>((dynamic v) => fromJson(v, match, growable: growable,))
              .toSet();
          }
          if (value is Map && (match = _regMap.firstMatch(targetType)?.group(1)) != null) {
            return Map<String, dynamic>.fromIterables(
              value.keys.cast<String>(),
              value.values.map<dynamic>((dynamic v) => fromJson(v, match, growable: growable,)),
            );
          }
      }
    } on Exception catch (error, trace) {
      throw ApiException.withInner(HttpStatus.internalServerError, 'Exception during deserialization.', error, trace,);
    }
    throw ApiException(HttpStatus.internalServerError, 'Could not find a suitable class for deserialization',);
  }
}

/// Primarily intended for use in an isolate.
class DeserializationMessage {
  const DeserializationMessage({
    required this.json,
    required this.targetType,
    this.growable = false,
  });

  /// The JSON value to deserialize.
  final String json;

  /// Target type to deserialize to.
  final String targetType;

  /// Whether to make deserialized lists or maps growable.
  final bool growable;
}

/// Primarily intended for use in an isolate.
Future<dynamic> decodeAsync(DeserializationMessage message) async {
  // Remove all spaces. Necessary for regular expressions as well.
  final targetType = message.targetType.replaceAll(' ', '');

  // If the expected target type is String, nothing to do...
  return targetType == 'String'
    ? message.json
    : json.decode(message.json);
}

/// Primarily intended for use in an isolate.
Future<dynamic> deserializeAsync(DeserializationMessage message) async {
  // Remove all spaces. Necessary for regular expressions as well.
  final targetType = message.targetType.replaceAll(' ', '');

  // If the expected target type is String, nothing to do...
  return targetType == 'String'
    ? message.json
    : ApiClient.fromJson(
        json.decode(message.json),
        targetType,
        growable: message.growable,
      );
}

/// Primarily intended for use in an isolate.
Future<String> serializeAsync(Object? value) async => value == null ? '' : json.encode(value);
