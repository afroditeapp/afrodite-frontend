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
        case 'AccountBanReasonCategory':
          return AccountBanReasonCategory.fromJson(value);
        case 'AccountBanReasonDetails':
          return AccountBanReasonDetails.fromJson(value);
        case 'AccountContent':
          return AccountContent.fromJson(value);
        case 'AccountData':
          return AccountData.fromJson(value);
        case 'AccountId':
          return AccountId.fromJson(value);
        case 'AccountIdDbValue':
          return AccountIdDbValue.fromJson(value);
        case 'AccountSetup':
          return AccountSetup.fromJson(value);
        case 'AccountStateContainer':
          return AccountStateContainer.fromJson(value);
        case 'AccountSyncVersion':
          return AccountSyncVersion.fromJson(value);
        case 'AdminInfo':
          return AdminInfo.fromJson(value);
        case 'AllMatchesPage':
          return AllMatchesPage.fromJson(value);
        case 'Attribute':
          return Attribute.fromJson(value);
        case 'AttributeIdAndHash':
          return AttributeIdAndHash.fromJson(value);
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
        case 'BackendConfig':
          return BackendConfig.fromJson(value);
        case 'BackendVersion':
          return BackendVersion.fromJson(value);
        case 'BooleanSetting':
          return BooleanSetting.fromJson(value);
        case 'BotConfig':
          return BotConfig.fromJson(value);
        case 'ClientConfig':
          return ClientConfig.fromJson(value);
        case 'ClientConfigSyncVersion':
          return ClientConfigSyncVersion.fromJson(value);
        case 'ClientId':
          return ClientId.fromJson(value);
        case 'ClientInfo':
          return ClientInfo.fromJson(value);
        case 'ClientLocalId':
          return ClientLocalId.fromJson(value);
        case 'ClientType':
          return ClientTypeTypeTransformer().decode(value);
        case 'ClientVersion':
          return ClientVersion.fromJson(value);
        case 'CommandOutput':
          return CommandOutput.fromJson(value);
        case 'ContentId':
          return ContentId.fromJson(value);
        case 'ContentInfo':
          return ContentInfo.fromJson(value);
        case 'ContentInfoDetailed':
          return ContentInfoDetailed.fromJson(value);
        case 'ContentInfoWithFd':
          return ContentInfoWithFd.fromJson(value);
        case 'ContentModerationState':
          return ContentModerationStateTypeTransformer().decode(value);
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
        case 'CurrentAccountInteractionState':
          return CurrentAccountInteractionStateTypeTransformer().decode(value);
        case 'CustomReport':
          return CustomReport.fromJson(value);
        case 'CustomReportContent':
          return CustomReportContent.fromJson(value);
        case 'CustomReportLanguage':
          return CustomReportLanguage.fromJson(value);
        case 'CustomReportTranslation':
          return CustomReportTranslation.fromJson(value);
        case 'CustomReportType':
          return CustomReportTypeTypeTransformer().decode(value);
        case 'CustomReportsConfig':
          return CustomReportsConfig.fromJson(value);
        case 'CustomReportsFileHash':
          return CustomReportsFileHash.fromJson(value);
        case 'CustomReportsOrderMode':
          return CustomReportsOrderModeTypeTransformer().decode(value);
        case 'DeleteLikeResult':
          return DeleteLikeResult.fromJson(value);
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
        case 'EventToClient':
          return EventToClient.fromJson(value);
        case 'EventType':
          return EventTypeTypeTransformer().decode(value);
        case 'FavoriteProfilesPage':
          return FavoriteProfilesPage.fromJson(value);
        case 'FcmDeviceToken':
          return FcmDeviceToken.fromJson(value);
        case 'GetAccountBanTimeResult':
          return GetAccountBanTimeResult.fromJson(value);
        case 'GetAccountDeletionRequestResult':
          return GetAccountDeletionRequestResult.fromJson(value);
        case 'GetAccountIdFromEmailResult':
          return GetAccountIdFromEmailResult.fromJson(value);
        case 'GetAllAdminsResult':
          return GetAllAdminsResult.fromJson(value);
        case 'GetCustomReportsConfigResult':
          return GetCustomReportsConfigResult.fromJson(value);
        case 'GetInitialProfileAgeInfoResult':
          return GetInitialProfileAgeInfoResult.fromJson(value);
        case 'GetMediaContentResult':
          return GetMediaContentResult.fromJson(value);
        case 'GetMyProfileResult':
          return GetMyProfileResult.fromJson(value);
        case 'GetNewsItemResult':
          return GetNewsItemResult.fromJson(value);
        case 'GetPerfDataEndTimeParameter':
          return GetPerfDataEndTimeParameter.fromJson(value);
        case 'GetProfileAgeAndName':
          return GetProfileAgeAndName.fromJson(value);
        case 'GetProfileContentPendingModerationList':
          return GetProfileContentPendingModerationList.fromJson(value);
        case 'GetProfileContentResult':
          return GetProfileContentResult.fromJson(value);
        case 'GetProfileFilteringSettings':
          return GetProfileFilteringSettings.fromJson(value);
        case 'GetProfileNamePendingModerationList':
          return GetProfileNamePendingModerationList.fromJson(value);
        case 'GetProfileNameState':
          return GetProfileNameState.fromJson(value);
        case 'GetProfileResult':
          return GetProfileResult.fromJson(value);
        case 'GetProfileStatisticsHistoryResult':
          return GetProfileStatisticsHistoryResult.fromJson(value);
        case 'GetProfileStatisticsResult':
          return GetProfileStatisticsResult.fromJson(value);
        case 'GetProfileTextPendingModerationList':
          return GetProfileTextPendingModerationList.fromJson(value);
        case 'GetProfileTextState':
          return GetProfileTextState.fromJson(value);
        case 'GetPublicKey':
          return GetPublicKey.fromJson(value);
        case 'GetReportList':
          return GetReportList.fromJson(value);
        case 'GroupValues':
          return GroupValues.fromJson(value);
        case 'InitialContentModerationCompletedResult':
          return InitialContentModerationCompletedResult.fromJson(value);
        case 'Language':
          return Language.fromJson(value);
        case 'LastSeenTimeFilter':
          return LastSeenTimeFilter.fromJson(value);
        case 'LatestBirthdate':
          return LatestBirthdate.fromJson(value);
        case 'LatestViewedMessageChanged':
          return LatestViewedMessageChanged.fromJson(value);
        case 'LimitedActionStatus':
          return LimitedActionStatusTypeTransformer().decode(value);
        case 'Location':
          return Location.fromJson(value);
        case 'LoginResult':
          return LoginResult.fromJson(value);
        case 'MaintenanceTask':
          return MaintenanceTask.fromJson(value);
        case 'ManagerInstanceNameList':
          return ManagerInstanceNameList.fromJson(value);
        case 'MatchesIteratorSessionId':
          return MatchesIteratorSessionId.fromJson(value);
        case 'MatchesPage':
          return MatchesPage.fromJson(value);
        case 'MatchesSyncVersion':
          return MatchesSyncVersion.fromJson(value);
        case 'MaxDistanceKm':
          return MaxDistanceKm.fromJson(value);
        case 'MediaContentSyncVersion':
          return MediaContentSyncVersion.fromJson(value);
        case 'MediaContentType':
          return MediaContentTypeTypeTransformer().decode(value);
        case 'MessageNumber':
          return MessageNumber.fromJson(value);
        case 'ModerationQueueType':
          return ModerationQueueTypeTypeTransformer().decode(value);
        case 'MyProfileContent':
          return MyProfileContent.fromJson(value);
        case 'NewReceivedLikesCount':
          return NewReceivedLikesCount.fromJson(value);
        case 'NewReceivedLikesCountResult':
          return NewReceivedLikesCountResult.fromJson(value);
        case 'NewsId':
          return NewsId.fromJson(value);
        case 'NewsItem':
          return NewsItem.fromJson(value);
        case 'NewsItemSimple':
          return NewsItemSimple.fromJson(value);
        case 'NewsIteratorSessionId':
          return NewsIteratorSessionId.fromJson(value);
        case 'NewsPage':
          return NewsPage.fromJson(value);
        case 'NewsSyncVersion':
          return NewsSyncVersion.fromJson(value);
        case 'NewsTranslationVersion':
          return NewsTranslationVersion.fromJson(value);
        case 'PageItemCountForNewLikes':
          return PageItemCountForNewLikes.fromJson(value);
        case 'PageItemCountForNewPublicNews':
          return PageItemCountForNewPublicNews.fromJson(value);
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
        case 'PerfMetricQueryResult':
          return PerfMetricQueryResult.fromJson(value);
        case 'PerfMetricValueArea':
          return PerfMetricValueArea.fromJson(value);
        case 'PerfMetricValues':
          return PerfMetricValues.fromJson(value);
        case 'Permissions':
          return Permissions.fromJson(value);
        case 'PostModerateProfileContent':
          return PostModerateProfileContent.fromJson(value);
        case 'PostModerateProfileName':
          return PostModerateProfileName.fromJson(value);
        case 'PostModerateProfileText':
          return PostModerateProfileText.fromJson(value);
        case 'ProcessReport':
          return ProcessReport.fromJson(value);
        case 'Profile':
          return Profile.fromJson(value);
        case 'ProfileAgeCounts':
          return ProfileAgeCounts.fromJson(value);
        case 'ProfileAttributeFilterValue':
          return ProfileAttributeFilterValue.fromJson(value);
        case 'ProfileAttributeFilterValueUpdate':
          return ProfileAttributeFilterValueUpdate.fromJson(value);
        case 'ProfileAttributeHash':
          return ProfileAttributeHash.fromJson(value);
        case 'ProfileAttributeInfo':
          return ProfileAttributeInfo.fromJson(value);
        case 'ProfileAttributeQuery':
          return ProfileAttributeQuery.fromJson(value);
        case 'ProfileAttributeQueryItem':
          return ProfileAttributeQueryItem.fromJson(value);
        case 'ProfileAttributeQueryResult':
          return ProfileAttributeQueryResult.fromJson(value);
        case 'ProfileAttributeValue':
          return ProfileAttributeValue.fromJson(value);
        case 'ProfileAttributeValueUpdate':
          return ProfileAttributeValueUpdate.fromJson(value);
        case 'ProfileContent':
          return ProfileContent.fromJson(value);
        case 'ProfileContentModerationRejectedReasonCategory':
          return ProfileContentModerationRejectedReasonCategory.fromJson(value);
        case 'ProfileContentModerationRejectedReasonDetails':
          return ProfileContentModerationRejectedReasonDetails.fromJson(value);
        case 'ProfileContentPendingModeration':
          return ProfileContentPendingModeration.fromJson(value);
        case 'ProfileContentVersion':
          return ProfileContentVersion.fromJson(value);
        case 'ProfileCreatedTimeFilter':
          return ProfileCreatedTimeFilter.fromJson(value);
        case 'ProfileEditedTimeFilter':
          return ProfileEditedTimeFilter.fromJson(value);
        case 'ProfileFilteringSettingsUpdate':
          return ProfileFilteringSettingsUpdate.fromJson(value);
        case 'ProfileIteratorPage':
          return ProfileIteratorPage.fromJson(value);
        case 'ProfileIteratorPageValue':
          return ProfileIteratorPageValue.fromJson(value);
        case 'ProfileIteratorSessionId':
          return ProfileIteratorSessionId.fromJson(value);
        case 'ProfileLink':
          return ProfileLink.fromJson(value);
        case 'ProfileNameModerationState':
          return ProfileNameModerationStateTypeTransformer().decode(value);
        case 'ProfileNamePendingModeration':
          return ProfileNamePendingModeration.fromJson(value);
        case 'ProfilePage':
          return ProfilePage.fromJson(value);
        case 'ProfileSearchAgeRange':
          return ProfileSearchAgeRange.fromJson(value);
        case 'ProfileStatisticsHistoryValue':
          return ProfileStatisticsHistoryValue.fromJson(value);
        case 'ProfileStatisticsHistoryValueType':
          return ProfileStatisticsHistoryValueTypeTypeTransformer().decode(value);
        case 'ProfileSyncVersion':
          return ProfileSyncVersion.fromJson(value);
        case 'ProfileTextModerationInfo':
          return ProfileTextModerationInfo.fromJson(value);
        case 'ProfileTextModerationRejectedReasonCategory':
          return ProfileTextModerationRejectedReasonCategory.fromJson(value);
        case 'ProfileTextModerationRejectedReasonDetails':
          return ProfileTextModerationRejectedReasonDetails.fromJson(value);
        case 'ProfileTextModerationState':
          return ProfileTextModerationStateTypeTransformer().decode(value);
        case 'ProfileTextPendingModeration':
          return ProfileTextPendingModeration.fromJson(value);
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
        case 'RemoteBotLogin':
          return RemoteBotLogin.fromJson(value);
        case 'ReportAccountInfo':
          return ReportAccountInfo.fromJson(value);
        case 'ReportChatInfo':
          return ReportChatInfo.fromJson(value);
        case 'ReportChatInfoInteractionState':
          return ReportChatInfoInteractionStateTypeTransformer().decode(value);
        case 'ReportContent':
          return ReportContent.fromJson(value);
        case 'ReportDetailed':
          return ReportDetailed.fromJson(value);
        case 'ReportDetailedInfo':
          return ReportDetailedInfo.fromJson(value);
        case 'ReportIteratorMode':
          return ReportIteratorModeTypeTransformer().decode(value);
        case 'ReportIteratorQuery':
          return ReportIteratorQuery.fromJson(value);
        case 'ReportProcessingState':
          return ReportProcessingStateTypeTransformer().decode(value);
        case 'ReportTypeNumber':
          return ReportTypeNumber.fromJson(value);
        case 'ResetMatchesIteratorResult':
          return ResetMatchesIteratorResult.fromJson(value);
        case 'ResetNewsIteratorResult':
          return ResetNewsIteratorResult.fromJson(value);
        case 'ResetReceivedLikesIteratorResult':
          return ResetReceivedLikesIteratorResult.fromJson(value);
        case 'ScheduledMaintenanceStatus':
          return ScheduledMaintenanceStatus.fromJson(value);
        case 'ScheduledTaskStatus':
          return ScheduledTaskStatus.fromJson(value);
        case 'ScheduledTaskType':
          return ScheduledTaskTypeTypeTransformer().decode(value);
        case 'ScheduledTaskTypeValue':
          return ScheduledTaskTypeValue.fromJson(value);
        case 'SearchGroups':
          return SearchGroups.fromJson(value);
        case 'SecurityContent':
          return SecurityContent.fromJson(value);
        case 'SendLikeResult':
          return SendLikeResult.fromJson(value);
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
        case 'SetAccountBanState':
          return SetAccountBanState.fromJson(value);
        case 'SetAccountSetup':
          return SetAccountSetup.fromJson(value);
        case 'SetProfileContent':
          return SetProfileContent.fromJson(value);
        case 'SetPublicKey':
          return SetPublicKey.fromJson(value);
        case 'SignInWithLoginInfo':
          return SignInWithLoginInfo.fromJson(value);
        case 'SoftwareInfo':
          return SoftwareInfo.fromJson(value);
        case 'SoftwareUpdateState':
          return SoftwareUpdateStateTypeTransformer().decode(value);
        case 'SoftwareUpdateStatus':
          return SoftwareUpdateStatus.fromJson(value);
        case 'StatisticsProfileVisibility':
          return StatisticsProfileVisibilityTypeTransformer().decode(value);
        case 'SyncVersion':
          return SyncVersion.fromJson(value);
        case 'SystemInfo':
          return SystemInfo.fromJson(value);
        case 'TimeGranularity':
          return TimeGranularityTypeTransformer().decode(value);
        case 'Translation':
          return Translation.fromJson(value);
        case 'UnixTime':
          return UnixTime.fromJson(value);
        case 'UnreadNewsCount':
          return UnreadNewsCount.fromJson(value);
        case 'UnreadNewsCountResult':
          return UnreadNewsCountResult.fromJson(value);
        case 'UpdateChatMessageReport':
          return UpdateChatMessageReport.fromJson(value);
        case 'UpdateCustomReportBoolean':
          return UpdateCustomReportBoolean.fromJson(value);
        case 'UpdateMessageViewStatus':
          return UpdateMessageViewStatus.fromJson(value);
        case 'UpdateNewsTranslation':
          return UpdateNewsTranslation.fromJson(value);
        case 'UpdateNewsTranslationResult':
          return UpdateNewsTranslationResult.fromJson(value);
        case 'UpdateProfileContentReport':
          return UpdateProfileContentReport.fromJson(value);
        case 'UpdateProfileNameReport':
          return UpdateProfileNameReport.fromJson(value);
        case 'UpdateProfileTextReport':
          return UpdateProfileTextReport.fromJson(value);
        case 'UpdateReportResult':
          return UpdateReportResult.fromJson(value);
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
