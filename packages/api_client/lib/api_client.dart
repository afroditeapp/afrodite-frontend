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
        case 'AccessToken':
          return AccessToken.fromJson(value);
        case 'AccessibleAccount':
          return AccessibleAccount.fromJson(value);
        case 'Account':
          return Account.fromJson(value);
        case 'AccountAppNotificationSettings':
          return AccountAppNotificationSettings.fromJson(value);
        case 'AccountBanReasonCategory':
          return AccountBanReasonCategory.fromJson(value);
        case 'AccountBanReasonDetails':
          return AccountBanReasonDetails.fromJson(value);
        case 'AccountContent':
          return AccountContent.fromJson(value);
        case 'AccountId':
          return AccountId.fromJson(value);
        case 'AccountIdDbValue':
          return AccountIdDbValue.fromJson(value);
        case 'AccountLockedState':
          return AccountLockedState.fromJson(value);
        case 'AccountSetup':
          return AccountSetup.fromJson(value);
        case 'AccountStateContainer':
          return AccountStateContainer.fromJson(value);
        case 'AccountSyncVersion':
          return AccountSyncVersion.fromJson(value);
        case 'AddPublicKeyResult':
          return AddPublicKeyResult.fromJson(value);
        case 'AdminInfo':
          return AdminInfo.fromJson(value);
        case 'AdminNotification':
          return AdminNotification.fromJson(value);
        case 'AdminNotificationSettings':
          return AdminNotificationSettings.fromJson(value);
        case 'ApiUsageCount':
          return ApiUsageCount.fromJson(value);
        case 'ApiUsageStatistics':
          return ApiUsageStatistics.fromJson(value);
        case 'Attribute':
          return Attribute.fromJson(value);
        case 'AttributeHash':
          return AttributeHash.fromJson(value);
        case 'AttributeMode':
          return AttributeModeTypeTransformer().decode(value);
        case 'AttributeOrderMode':
          return AttributeOrderModeTypeTransformer().decode(value);
        case 'AttributeValue':
          return AttributeValue.fromJson(value);
        case 'AttributeValueOrderMode':
          return AttributeValueOrderModeTypeTransformer().decode(value);
        case 'AttributionConfig':
          return AttributionConfig.fromJson(value);
        case 'AuthPair':
          return AuthPair.fromJson(value);
        case 'AutomaticProfileSearchCompletedNotification':
          return AutomaticProfileSearchCompletedNotification.fromJson(value);
        case 'AutomaticProfileSearchCompletedNotificationViewed':
          return AutomaticProfileSearchCompletedNotificationViewed.fromJson(value);
        case 'AutomaticProfileSearchIteratorSessionId':
          return AutomaticProfileSearchIteratorSessionId.fromJson(value);
        case 'AutomaticProfileSearchSettings':
          return AutomaticProfileSearchSettings.fromJson(value);
        case 'BackendConfig':
          return BackendConfig.fromJson(value);
        case 'BackendVersion':
          return BackendVersion.fromJson(value);
        case 'BooleanSetting':
          return BooleanSetting.fromJson(value);
        case 'ChatAppNotificationSettings':
          return ChatAppNotificationSettings.fromJson(value);
        case 'ChatConfig':
          return ChatConfig.fromJson(value);
        case 'ChatEmailNotificationSettings':
          return ChatEmailNotificationSettings.fromJson(value);
        case 'ChatMessageReport':
          return ChatMessageReport.fromJson(value);
        case 'CheckOnlineStatusConfig':
          return CheckOnlineStatusConfig.fromJson(value);
        case 'CheckOnlineStatusResponse':
          return CheckOnlineStatusResponse.fromJson(value);
        case 'ClientConfig':
          return ClientConfig.fromJson(value);
        case 'ClientConfigSyncVersion':
          return ClientConfigSyncVersion.fromJson(value);
        case 'ClientFeaturesConfig':
          return ClientFeaturesConfig.fromJson(value);
        case 'ClientFeaturesConfigHash':
          return ClientFeaturesConfigHash.fromJson(value);
        case 'ClientInfo':
          return ClientInfo.fromJson(value);
        case 'ClientLanguage':
          return ClientLanguage.fromJson(value);
        case 'ClientType':
          return ClientTypeTypeTransformer().decode(value);
        case 'ClientVersion':
          return ClientVersion.fromJson(value);
        case 'ClientVersionCount':
          return ClientVersionCount.fromJson(value);
        case 'ClientVersionStatistics':
          return ClientVersionStatistics.fromJson(value);
        case 'CommandOutput':
          return CommandOutput.fromJson(value);
        case 'ConnectionStatistics':
          return ConnectionStatistics.fromJson(value);
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
        case 'ConversationId':
          return ConversationId.fromJson(value);
        case 'CurrentAccountInteractionState':
          return CurrentAccountInteractionStateTypeTransformer().decode(value);
        case 'CustomReport':
          return CustomReport.fromJson(value);
        case 'CustomReportLanguage':
          return CustomReportLanguage.fromJson(value);
        case 'CustomReportTranslation':
          return CustomReportTranslation.fromJson(value);
        case 'CustomReportType':
          return CustomReportTypeTypeTransformer().decode(value);
        case 'CustomReportsConfig':
          return CustomReportsConfig.fromJson(value);
        case 'CustomReportsConfigHash':
          return CustomReportsConfigHash.fromJson(value);
        case 'CustomReportsOrderMode':
          return CustomReportsOrderModeTypeTransformer().decode(value);
        case 'DailyLikesConfig':
          return DailyLikesConfig.fromJson(value);
        case 'DailyLikesLeft':
          return DailyLikesLeft.fromJson(value);
        case 'DailyLikesLeftSyncVersion':
          return DailyLikesLeftSyncVersion.fromJson(value);
        case 'DataExportName':
          return DataExportName.fromJson(value);
        case 'DataExportState':
          return DataExportState.fromJson(value);
        case 'DataExportStateType':
          return DataExportStateTypeTypeTransformer().decode(value);
        case 'DataExportType':
          return DataExportTypeTypeTransformer().decode(value);
        case 'DeliveryInfoType':
          return DeliveryInfoTypeTypeTransformer().decode(value);
        case 'DemoAccountLoginCredentials':
          return DemoAccountLoginCredentials.fromJson(value);
        case 'DemoAccountLoginResult':
          return DemoAccountLoginResult.fromJson(value);
        case 'DemoAccountLoginToAccount':
          return DemoAccountLoginToAccount.fromJson(value);
        case 'DemoAccountRegisterAccountResult':
          return DemoAccountRegisterAccountResult.fromJson(value);
        case 'DemoAccountToken':
          return DemoAccountToken.fromJson(value);
        case 'EmailAddressState':
          return EmailAddressState.fromJson(value);
        case 'EmailAddressStateAdmin':
          return EmailAddressStateAdmin.fromJson(value);
        case 'EmailLoginToken':
          return EmailLoginToken.fromJson(value);
        case 'EventToClient':
          return EventToClient.fromJson(value);
        case 'EventToServer':
          return EventToServer.fromJson(value);
        case 'EventToServerType':
          return EventToServerTypeTypeTransformer().decode(value);
        case 'EventType':
          return EventTypeTypeTransformer().decode(value);
        case 'FavoriteProfilesPage':
          return FavoriteProfilesPage.fromJson(value);
        case 'FeaturesConfig':
          return FeaturesConfig.fromJson(value);
        case 'GetAccountBanTimeResult':
          return GetAccountBanTimeResult.fromJson(value);
        case 'GetAccountDeletionRequestResult':
          return GetAccountDeletionRequestResult.fromJson(value);
        case 'GetAccountIdFromEmailResult':
          return GetAccountIdFromEmailResult.fromJson(value);
        case 'GetAdminNotification':
          return GetAdminNotification.fromJson(value);
        case 'GetAllAdminsResult':
          return GetAllAdminsResult.fromJson(value);
        case 'GetApiUsageStatisticsResult':
          return GetApiUsageStatisticsResult.fromJson(value);
        case 'GetApiUsageStatisticsSettings':
          return GetApiUsageStatisticsSettings.fromJson(value);
        case 'GetChatMessageReports':
          return GetChatMessageReports.fromJson(value);
        case 'GetClientFeaturesConfigResult':
          return GetClientFeaturesConfigResult.fromJson(value);
        case 'GetClientLanguage':
          return GetClientLanguage.fromJson(value);
        case 'GetClientVersionStatisticsResult':
          return GetClientVersionStatisticsResult.fromJson(value);
        case 'GetClientVersionStatisticsSettings':
          return GetClientVersionStatisticsSettings.fromJson(value);
        case 'GetConversationId':
          return GetConversationId.fromJson(value);
        case 'GetCustomReportsConfigResult':
          return GetCustomReportsConfigResult.fromJson(value);
        case 'GetInitialProfileAgeResult':
          return GetInitialProfileAgeResult.fromJson(value);
        case 'GetIpAddressStatisticsResult':
          return GetIpAddressStatisticsResult.fromJson(value);
        case 'GetIpAddressStatisticsSettings':
          return GetIpAddressStatisticsSettings.fromJson(value);
        case 'GetIpCountryStatisticsResult':
          return GetIpCountryStatisticsResult.fromJson(value);
        case 'GetIpCountryStatisticsSettings':
          return GetIpCountryStatisticsSettings.fromJson(value);
        case 'GetLatestPublicKeyId':
          return GetLatestPublicKeyId.fromJson(value);
        case 'GetMediaContentPendingModerationList':
          return GetMediaContentPendingModerationList.fromJson(value);
        case 'GetMediaContentResult':
          return GetMediaContentResult.fromJson(value);
        case 'GetMyProfileResult':
          return GetMyProfileResult.fromJson(value);
        case 'GetNewsItemResult':
          return GetNewsItemResult.fromJson(value);
        case 'GetPrivatePublicKeyInfo':
          return GetPrivatePublicKeyInfo.fromJson(value);
        case 'GetProfileAgeAndName':
          return GetProfileAgeAndName.fromJson(value);
        case 'GetProfileContentResult':
          return GetProfileContentResult.fromJson(value);
        case 'GetProfileFilters':
          return GetProfileFilters.fromJson(value);
        case 'GetProfileResult':
          return GetProfileResult.fromJson(value);
        case 'GetProfileStatisticsHistoryResult':
          return GetProfileStatisticsHistoryResult.fromJson(value);
        case 'GetProfileStatisticsResult':
          return GetProfileStatisticsResult.fromJson(value);
        case 'GetProfileStringPendingModerationList':
          return GetProfileStringPendingModerationList.fromJson(value);
        case 'GetProfileStringState':
          return GetProfileStringState.fromJson(value);
        case 'GetPushNotificationInfo':
          return GetPushNotificationInfo.fromJson(value);
        case 'GetReportList':
          return GetReportList.fromJson(value);
        case 'GetSentMessage':
          return GetSentMessage.fromJson(value);
        case 'GroupValues':
          return GroupValues.fromJson(value);
        case 'InitEmailChange':
          return InitEmailChange.fromJson(value);
        case 'InitEmailChangeAdmin':
          return InitEmailChangeAdmin.fromJson(value);
        case 'InitEmailChangeResult':
          return InitEmailChangeResult.fromJson(value);
        case 'InitialProfileAge':
          return InitialProfileAge.fromJson(value);
        case 'IpAddressInfo':
          return IpAddressInfo.fromJson(value);
        case 'IpCountryStatistics':
          return IpCountryStatistics.fromJson(value);
        case 'IpCountryStatisticsType':
          return IpCountryStatisticsTypeTypeTransformer().decode(value);
        case 'IpCountryStatisticsValue':
          return IpCountryStatisticsValue.fromJson(value);
        case 'JitsiMeetUrl':
          return JitsiMeetUrl.fromJson(value);
        case 'Language':
          return Language.fromJson(value);
        case 'LastSeenTimeFilter':
          return LastSeenTimeFilter.fromJson(value);
        case 'LatestBirthdate':
          return LatestBirthdate.fromJson(value);
        case 'LikesConfig':
          return LikesConfig.fromJson(value);
        case 'LimitedActionStatus':
          return LimitedActionStatusTypeTransformer().decode(value);
        case 'LocalBotsConfig':
          return LocalBotsConfig.fromJson(value);
        case 'Location':
          return Location.fromJson(value);
        case 'LoginResult':
          return LoginResult.fromJson(value);
        case 'MaintenanceTask':
          return MaintenanceTask.fromJson(value);
        case 'ManagerInstanceNameList':
          return ManagerInstanceNameList.fromJson(value);
        case 'MapBounds':
          return MapBounds.fromJson(value);
        case 'MapConfig':
          return MapConfig.fromJson(value);
        case 'MapCoordinate':
          return MapCoordinate.fromJson(value);
        case 'MapZoom':
          return MapZoom.fromJson(value);
        case 'MarkReceivedLikesViewed':
          return MarkReceivedLikesViewed.fromJson(value);
        case 'MatchId':
          return MatchId.fromJson(value);
        case 'MatchesIteratorState':
          return MatchesIteratorState.fromJson(value);
        case 'MatchesPage':
          return MatchesPage.fromJson(value);
        case 'MaxDistanceKm':
          return MaxDistanceKm.fromJson(value);
        case 'MediaAppNotificationSettings':
          return MediaAppNotificationSettings.fromJson(value);
        case 'MediaContentModerationCompletedNotification':
          return MediaContentModerationCompletedNotification.fromJson(value);
        case 'MediaContentModerationCompletedNotificationViewed':
          return MediaContentModerationCompletedNotificationViewed.fromJson(value);
        case 'MediaContentModerationRejectedReasonCategory':
          return MediaContentModerationRejectedReasonCategory.fromJson(value);
        case 'MediaContentModerationRejectedReasonDetails':
          return MediaContentModerationRejectedReasonDetails.fromJson(value);
        case 'MediaContentPendingModeration':
          return MediaContentPendingModeration.fromJson(value);
        case 'MediaContentSyncVersion':
          return MediaContentSyncVersion.fromJson(value);
        case 'MediaContentType':
          return MediaContentTypeTypeTransformer().decode(value);
        case 'MessageDeliveryInfo':
          return MessageDeliveryInfo.fromJson(value);
        case 'MessageDeliveryInfoIdList':
          return MessageDeliveryInfoIdList.fromJson(value);
        case 'MessageDeliveryInfoList':
          return MessageDeliveryInfoList.fromJson(value);
        case 'MessageId':
          return MessageId.fromJson(value);
        case 'MessageNumber':
          return MessageNumber.fromJson(value);
        case 'MessageSeenList':
          return MessageSeenList.fromJson(value);
        case 'MinDistanceKm':
          return MinDistanceKm.fromJson(value);
        case 'ModerationQueueType':
          return ModerationQueueTypeTypeTransformer().decode(value);
        case 'MyProfileContent':
          return MyProfileContent.fromJson(value);
        case 'NewReceivedLikesCount':
          return NewReceivedLikesCount.fromJson(value);
        case 'NewReceivedLikesCountResult':
          return NewReceivedLikesCountResult.fromJson(value);
        case 'NewsConfig':
          return NewsConfig.fromJson(value);
        case 'NewsId':
          return NewsId.fromJson(value);
        case 'NewsItem':
          return NewsItem.fromJson(value);
        case 'NewsItemSimple':
          return NewsItemSimple.fromJson(value);
        case 'NewsIteratorState':
          return NewsIteratorState.fromJson(value);
        case 'NewsPage':
          return NewsPage.fromJson(value);
        case 'NewsSyncVersion':
          return NewsSyncVersion.fromJson(value);
        case 'NewsTranslationVersion':
          return NewsTranslationVersion.fromJson(value);
        case 'NotificationId':
          return NotificationId.fromJson(value);
        case 'NotificationIdViewed':
          return NotificationIdViewed.fromJson(value);
        case 'NotificationStatus':
          return NotificationStatus.fromJson(value);
        case 'PartialProfileAttributesConfig':
          return PartialProfileAttributesConfig.fromJson(value);
        case 'PendingMessageAcknowledgementList':
          return PendingMessageAcknowledgementList.fromJson(value);
        case 'PendingMessageId':
          return PendingMessageId.fromJson(value);
        case 'PerfMetricQuery':
          return PerfMetricQuery.fromJson(value);
        case 'PerfMetricQueryResult':
          return PerfMetricQueryResult.fromJson(value);
        case 'PerfMetricValueArea':
          return PerfMetricValueArea.fromJson(value);
        case 'PerfMetricValues':
          return PerfMetricValues.fromJson(value);
        case 'Permissions':
          return Permissions.fromJson(value);
        case 'PostMediaContentFaceDetectedValue':
          return PostMediaContentFaceDetectedValue.fromJson(value);
        case 'PostModerateMediaContent':
          return PostModerateMediaContent.fromJson(value);
        case 'PostModerateProfileString':
          return PostModerateProfileString.fromJson(value);
        case 'PostStartDataExport':
          return PostStartDataExport.fromJson(value);
        case 'PostVideoCallUrlResult':
          return PostVideoCallUrlResult.fromJson(value);
        case 'ProcessReport':
          return ProcessReport.fromJson(value);
        case 'Profile':
          return Profile.fromJson(value);
        case 'ProfileAgeCounts':
          return ProfileAgeCounts.fromJson(value);
        case 'ProfileAppNotificationSettings':
          return ProfileAppNotificationSettings.fromJson(value);
        case 'ProfileAttributeFilterValue':
          return ProfileAttributeFilterValue.fromJson(value);
        case 'ProfileAttributeFilterValueUpdate':
          return ProfileAttributeFilterValueUpdate.fromJson(value);
        case 'ProfileAttributeInfo':
          return ProfileAttributeInfo.fromJson(value);
        case 'ProfileAttributeValue':
          return ProfileAttributeValue.fromJson(value);
        case 'ProfileAttributeValueUpdate':
          return ProfileAttributeValueUpdate.fromJson(value);
        case 'ProfileAttributesConfigQuery':
          return ProfileAttributesConfigQuery.fromJson(value);
        case 'ProfileAttributesConfigQueryItem':
          return ProfileAttributesConfigQueryItem.fromJson(value);
        case 'ProfileAttributesConfigQueryResult':
          return ProfileAttributesConfigQueryResult.fromJson(value);
        case 'ProfileConfig':
          return ProfileConfig.fromJson(value);
        case 'ProfileContent':
          return ProfileContent.fromJson(value);
        case 'ProfileContentVersion':
          return ProfileContentVersion.fromJson(value);
        case 'ProfileCreatedTimeFilter':
          return ProfileCreatedTimeFilter.fromJson(value);
        case 'ProfileEditedTimeFilter':
          return ProfileEditedTimeFilter.fromJson(value);
        case 'ProfileFiltersUpdate':
          return ProfileFiltersUpdate.fromJson(value);
        case 'ProfileIteratorPage':
          return ProfileIteratorPage.fromJson(value);
        case 'ProfileIteratorPageValue':
          return ProfileIteratorPageValue.fromJson(value);
        case 'ProfileIteratorSessionId':
          return ProfileIteratorSessionId.fromJson(value);
        case 'ProfileLink':
          return ProfileLink.fromJson(value);
        case 'ProfilePage':
          return ProfilePage.fromJson(value);
        case 'ProfileStatisticsHistoryValue':
          return ProfileStatisticsHistoryValue.fromJson(value);
        case 'ProfileStatisticsHistoryValueType':
          return ProfileStatisticsHistoryValueTypeTypeTransformer().decode(value);
        case 'ProfileStringModerationCompletedNotification':
          return ProfileStringModerationCompletedNotification.fromJson(value);
        case 'ProfileStringModerationCompletedNotificationViewed':
          return ProfileStringModerationCompletedNotificationViewed.fromJson(value);
        case 'ProfileStringModerationContentType':
          return ProfileStringModerationContentTypeTypeTransformer().decode(value);
        case 'ProfileStringModerationInfo':
          return ProfileStringModerationInfo.fromJson(value);
        case 'ProfileStringModerationRejectedReasonCategory':
          return ProfileStringModerationRejectedReasonCategory.fromJson(value);
        case 'ProfileStringModerationRejectedReasonDetails':
          return ProfileStringModerationRejectedReasonDetails.fromJson(value);
        case 'ProfileStringModerationState':
          return ProfileStringModerationStateTypeTransformer().decode(value);
        case 'ProfileStringPendingModeration':
          return ProfileStringPendingModeration.fromJson(value);
        case 'ProfileSyncVersion':
          return ProfileSyncVersion.fromJson(value);
        case 'ProfileTextMaxCharactersFilter':
          return ProfileTextMaxCharactersFilter.fromJson(value);
        case 'ProfileTextMinCharactersFilter':
          return ProfileTextMinCharactersFilter.fromJson(value);
        case 'ProfileUpdate':
          return ProfileUpdate.fromJson(value);
        case 'ProfileVersion':
          return ProfileVersion.fromJson(value);
        case 'ProfileVisibility':
          return ProfileVisibilityTypeTransformer().decode(value);
        case 'PublicKeyId':
          return PublicKeyId.fromJson(value);
        case 'PublicationId':
          return PublicationId.fromJson(value);
        case 'PushNotificationDeviceToken':
          return PushNotificationDeviceToken.fromJson(value);
        case 'PushNotificationEncryptionKey':
          return PushNotificationEncryptionKey.fromJson(value);
        case 'PushNotificationInfoSyncVersion':
          return PushNotificationInfoSyncVersion.fromJson(value);
        case 'ReceivedLikeId':
          return ReceivedLikeId.fromJson(value);
        case 'ReceivedLikesIteratorState':
          return ReceivedLikesIteratorState.fromJson(value);
        case 'ReceivedLikesPage':
          return ReceivedLikesPage.fromJson(value);
        case 'ReceivedLikesPageItem':
          return ReceivedLikesPageItem.fromJson(value);
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
        case 'ReportId':
          return ReportId.fromJson(value);
        case 'ReportIteratorMode':
          return ReportIteratorModeTypeTransformer().decode(value);
        case 'ReportIteratorQuery':
          return ReportIteratorQuery.fromJson(value);
        case 'ReportProcessingState':
          return ReportProcessingStateTypeTransformer().decode(value);
        case 'ReportTypeNumber':
          return ReportTypeNumber.fromJson(value);
        case 'RequestEmailLoginToken':
          return RequestEmailLoginToken.fromJson(value);
        case 'RequestEmailLoginTokenResult':
          return RequestEmailLoginTokenResult.fromJson(value);
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
        case 'ScheduledTasksConfig':
          return ScheduledTasksConfig.fromJson(value);
        case 'SearchAgeRange':
          return SearchAgeRange.fromJson(value);
        case 'SearchGroups':
          return SearchGroups.fromJson(value);
        case 'SecurityContent':
          return SecurityContent.fromJson(value);
        case 'SendLikeResult':
          return SendLikeResult.fromJson(value);
        case 'SendMessageResult':
          return SendMessageResult.fromJson(value);
        case 'SendVerifyEmailMessageResult':
          return SendVerifyEmailMessageResult.fromJson(value);
        case 'SentBlocksPage':
          return SentBlocksPage.fromJson(value);
        case 'SentMessageIdList':
          return SentMessageIdList.fromJson(value);
        case 'ServerConfig':
          return ServerConfig.fromJson(value);
        case 'SetAccountBanState':
          return SetAccountBanState.fromJson(value);
        case 'SetAccountSetup':
          return SetAccountSetup.fromJson(value);
        case 'SetEmailLoginEnabled':
          return SetEmailLoginEnabled.fromJson(value);
        case 'SetInitialEmail':
          return SetInitialEmail.fromJson(value);
        case 'SetMaxPublicKeyCount':
          return SetMaxPublicKeyCount.fromJson(value);
        case 'SetProfileContent':
          return SetProfileContent.fromJson(value);
        case 'SetProfileName':
          return SetProfileName.fromJson(value);
        case 'SignInWithAppleInfo':
          return SignInWithAppleInfo.fromJson(value);
        case 'SignInWithGoogleInfo':
          return SignInWithGoogleInfo.fromJson(value);
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
        case 'StringResource':
          return StringResource.fromJson(value);
        case 'SyncVersion':
          return SyncVersion.fromJson(value);
        case 'SystemInfo':
          return SystemInfo.fromJson(value);
        case 'TimeGranularity':
          return TimeGranularityTypeTransformer().decode(value);
        case 'Translation':
          return Translation.fromJson(value);
        case 'TypingIndicatorConfig':
          return TypingIndicatorConfig.fromJson(value);
        case 'UnixTime':
          return UnixTime.fromJson(value);
        case 'UnreadNewsCount':
          return UnreadNewsCount.fromJson(value);
        case 'UnreadNewsCountResult':
          return UnreadNewsCountResult.fromJson(value);
        case 'UpdateChatMessageReport':
          return UpdateChatMessageReport.fromJson(value);
        case 'UpdateCustomReportEmpty':
          return UpdateCustomReportEmpty.fromJson(value);
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
        case 'VapidPublicKey':
          return VapidPublicKey.fromJson(value);
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
