// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_database.dart';

// ignore_for_file: type=lint
class $AccountTable extends Account with TableInfo<$AccountTable, AccountData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AccountTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  @override
  late final GeneratedColumnWithTypeConverter<api.AccountId?, String>
      uuidAccountId = GeneratedColumn<String>(
              'uuid_account_id', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<api.AccountId?>($AccountTable.$converteruuidAccountId);
  @override
  late final GeneratedColumnWithTypeConverter<JsonString?, String>
      jsonAccountState = GeneratedColumn<String>(
              'json_account_state', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<JsonString?>($AccountTable.$converterjsonAccountState);
  @override
  late final GeneratedColumnWithTypeConverter<JsonString?, String>
      jsonPermissions = GeneratedColumn<String>(
              'json_permissions', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<JsonString?>($AccountTable.$converterjsonPermissions);
  @override
  late final GeneratedColumnWithTypeConverter<EnumString?, String>
      jsonProfileVisibility = GeneratedColumn<String>(
              'json_profile_visibility', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<EnumString?>(
              $AccountTable.$converterjsonProfileVisibility);
  static const VerificationMeta _profileFilterFavoritesMeta =
      const VerificationMeta('profileFilterFavorites');
  @override
  late final GeneratedColumn<bool> profileFilterFavorites =
      GeneratedColumn<bool>('profile_filter_favorites', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("profile_filter_favorites" IN (0, 1))'),
          defaultValue: const Constant(PROFILE_FILTER_FAVORITES_DEFAULT));
  @override
  late final GeneratedColumnWithTypeConverter<api.ProfileIteratorSessionId?,
      int> profileIteratorSessionId = GeneratedColumn<int>(
          'profile_iterator_session_id', aliasedName, true,
          type: DriftSqlType.int, requiredDuringInsert: false)
      .withConverter<api.ProfileIteratorSessionId?>(
          $AccountTable.$converterprofileIteratorSessionId);
  @override
  late final GeneratedColumnWithTypeConverter<
      api.AutomaticProfileSearchIteratorSessionId?,
      int> automatiProfileSearchIteratorSessionId = GeneratedColumn<int>(
          'automati_profile_search_iterator_session_id', aliasedName, true,
          type: DriftSqlType.int, requiredDuringInsert: false)
      .withConverter<api.AutomaticProfileSearchIteratorSessionId?>(
          $AccountTable.$converterautomatiProfileSearchIteratorSessionId);
  @override
  late final GeneratedColumnWithTypeConverter<
      api.ReceivedLikesIteratorSessionId?,
      int> receivedLikesIteratorSessionId = GeneratedColumn<int>(
          'received_likes_iterator_session_id', aliasedName, true,
          type: DriftSqlType.int, requiredDuringInsert: false)
      .withConverter<api.ReceivedLikesIteratorSessionId?>(
          $AccountTable.$converterreceivedLikesIteratorSessionId);
  @override
  late final GeneratedColumnWithTypeConverter<api.MatchesIteratorSessionId?,
      int> matchesIteratorSessionId = GeneratedColumn<int>(
          'matches_iterator_session_id', aliasedName, true,
          type: DriftSqlType.int, requiredDuringInsert: false)
      .withConverter<api.MatchesIteratorSessionId?>(
          $AccountTable.$convertermatchesIteratorSessionId);
  @override
  late final GeneratedColumnWithTypeConverter<api.ClientId?, int> clientId =
      GeneratedColumn<int>('client_id', aliasedName, true,
              type: DriftSqlType.int, requiredDuringInsert: false)
          .withConverter<api.ClientId?>($AccountTable.$converterclientId);
  @override
  late final GeneratedColumnWithTypeConverter<EnumString?, String>
      jsonAvailableProfileAttributesOrderMode = GeneratedColumn<String>(
              'json_available_profile_attributes_order_mode', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<EnumString?>(
              $AccountTable.$converterjsonAvailableProfileAttributesOrderMode);
  static const VerificationMeta _initialSyncDoneLoginRepositoryMeta =
      const VerificationMeta('initialSyncDoneLoginRepository');
  @override
  late final GeneratedColumn<bool> initialSyncDoneLoginRepository =
      GeneratedColumn<bool>(
          'initial_sync_done_login_repository', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("initial_sync_done_login_repository" IN (0, 1))'),
          defaultValue: const Constant(false));
  static const VerificationMeta _initialSyncDoneAccountRepositoryMeta =
      const VerificationMeta('initialSyncDoneAccountRepository');
  @override
  late final GeneratedColumn<bool> initialSyncDoneAccountRepository =
      GeneratedColumn<bool>(
          'initial_sync_done_account_repository', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("initial_sync_done_account_repository" IN (0, 1))'),
          defaultValue: const Constant(false));
  static const VerificationMeta _initialSyncDoneMediaRepositoryMeta =
      const VerificationMeta('initialSyncDoneMediaRepository');
  @override
  late final GeneratedColumn<bool> initialSyncDoneMediaRepository =
      GeneratedColumn<bool>(
          'initial_sync_done_media_repository', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("initial_sync_done_media_repository" IN (0, 1))'),
          defaultValue: const Constant(false));
  static const VerificationMeta _initialSyncDoneProfileRepositoryMeta =
      const VerificationMeta('initialSyncDoneProfileRepository');
  @override
  late final GeneratedColumn<bool> initialSyncDoneProfileRepository =
      GeneratedColumn<bool>(
          'initial_sync_done_profile_repository', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("initial_sync_done_profile_repository" IN (0, 1))'),
          defaultValue: const Constant(false));
  static const VerificationMeta _initialSyncDoneChatRepositoryMeta =
      const VerificationMeta('initialSyncDoneChatRepository');
  @override
  late final GeneratedColumn<bool> initialSyncDoneChatRepository =
      GeneratedColumn<bool>(
          'initial_sync_done_chat_repository', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("initial_sync_done_chat_repository" IN (0, 1))'),
          defaultValue: const Constant(false));
  static const VerificationMeta _syncVersionAccountMeta =
      const VerificationMeta('syncVersionAccount');
  @override
  late final GeneratedColumn<int> syncVersionAccount = GeneratedColumn<int>(
      'sync_version_account', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _syncVersionProfileMeta =
      const VerificationMeta('syncVersionProfile');
  @override
  late final GeneratedColumn<int> syncVersionProfile = GeneratedColumn<int>(
      'sync_version_profile', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _syncVersionMediaContentMeta =
      const VerificationMeta('syncVersionMediaContent');
  @override
  late final GeneratedColumn<int> syncVersionMediaContent =
      GeneratedColumn<int>('sync_version_media_content', aliasedName, true,
          type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _syncVersionClientConfigMeta =
      const VerificationMeta('syncVersionClientConfig');
  @override
  late final GeneratedColumn<int> syncVersionClientConfig =
      GeneratedColumn<int>('sync_version_client_config', aliasedName, true,
          type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _primaryContentGridCropSizeMeta =
      const VerificationMeta('primaryContentGridCropSize');
  @override
  late final GeneratedColumn<double> primaryContentGridCropSize =
      GeneratedColumn<double>(
          'primary_content_grid_crop_size', aliasedName, true,
          type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _primaryContentGridCropXMeta =
      const VerificationMeta('primaryContentGridCropX');
  @override
  late final GeneratedColumn<double> primaryContentGridCropX =
      GeneratedColumn<double>('primary_content_grid_crop_x', aliasedName, true,
          type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _primaryContentGridCropYMeta =
      const VerificationMeta('primaryContentGridCropY');
  @override
  late final GeneratedColumn<double> primaryContentGridCropY =
      GeneratedColumn<double>('primary_content_grid_crop_y', aliasedName, true,
          type: DriftSqlType.double, requiredDuringInsert: false);
  @override
  late final GeneratedColumnWithTypeConverter<api.ProfileContentVersion?,
      String> profileContentVersion = GeneratedColumn<String>(
          'profile_content_version', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false)
      .withConverter<api.ProfileContentVersion?>(
          $AccountTable.$converterprofileContentVersion);
  static const VerificationMeta _profileNameMeta =
      const VerificationMeta('profileName');
  @override
  late final GeneratedColumn<String> profileName = GeneratedColumn<String>(
      'profile_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _profileNameAcceptedMeta =
      const VerificationMeta('profileNameAccepted');
  @override
  late final GeneratedColumn<bool> profileNameAccepted = GeneratedColumn<bool>(
      'profile_name_accepted', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("profile_name_accepted" IN (0, 1))'));
  @override
  late final GeneratedColumnWithTypeConverter<EnumString?, String>
      profileNameModerationState = GeneratedColumn<String>(
              'profile_name_moderation_state', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<EnumString?>(
              $AccountTable.$converterprofileNameModerationState);
  static const VerificationMeta _profileTextMeta =
      const VerificationMeta('profileText');
  @override
  late final GeneratedColumn<String> profileText = GeneratedColumn<String>(
      'profile_text', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _profileTextAcceptedMeta =
      const VerificationMeta('profileTextAccepted');
  @override
  late final GeneratedColumn<bool> profileTextAccepted = GeneratedColumn<bool>(
      'profile_text_accepted', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("profile_text_accepted" IN (0, 1))'));
  @override
  late final GeneratedColumnWithTypeConverter<EnumString?, String>
      profileTextModerationState = GeneratedColumn<String>(
              'profile_text_moderation_state', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<EnumString?>(
              $AccountTable.$converterprofileTextModerationState);
  @override
  late final GeneratedColumnWithTypeConverter<
      api.ProfileTextModerationRejectedReasonCategory?,
      int> profileTextModerationRejectedCategory = GeneratedColumn<int>(
          'profile_text_moderation_rejected_category', aliasedName, true,
          type: DriftSqlType.int, requiredDuringInsert: false)
      .withConverter<api.ProfileTextModerationRejectedReasonCategory?>(
          $AccountTable.$converterprofileTextModerationRejectedCategory);
  @override
  late final GeneratedColumnWithTypeConverter<
      api.ProfileTextModerationRejectedReasonDetails?,
      String> profileTextModerationRejectedDetails = GeneratedColumn<String>(
          'profile_text_moderation_rejected_details', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false)
      .withConverter<api.ProfileTextModerationRejectedReasonDetails?>(
          $AccountTable.$converterprofileTextModerationRejectedDetails);
  static const VerificationMeta _profileAgeMeta =
      const VerificationMeta('profileAge');
  @override
  late final GeneratedColumn<int> profileAge = GeneratedColumn<int>(
      'profile_age', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _profileUnlimitedLikesMeta =
      const VerificationMeta('profileUnlimitedLikes');
  @override
  late final GeneratedColumn<bool> profileUnlimitedLikes =
      GeneratedColumn<bool>('profile_unlimited_likes', aliasedName, true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("profile_unlimited_likes" IN (0, 1))'));
  @override
  late final GeneratedColumnWithTypeConverter<api.ProfileVersion?, String>
      profileVersion = GeneratedColumn<String>(
              'profile_version', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<api.ProfileVersion?>(
              $AccountTable.$converterprofileVersion);
  @override
  late final GeneratedColumnWithTypeConverter<JsonList?, String>
      jsonProfileAttributes = GeneratedColumn<String>(
              'json_profile_attributes', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<JsonList?>(
              $AccountTable.$converterjsonProfileAttributes);
  static const VerificationMeta _profileLocationLatitudeMeta =
      const VerificationMeta('profileLocationLatitude');
  @override
  late final GeneratedColumn<double> profileLocationLatitude =
      GeneratedColumn<double>('profile_location_latitude', aliasedName, true,
          type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _profileLocationLongitudeMeta =
      const VerificationMeta('profileLocationLongitude');
  @override
  late final GeneratedColumn<double> profileLocationLongitude =
      GeneratedColumn<double>('profile_location_longitude', aliasedName, true,
          type: DriftSqlType.double, requiredDuringInsert: false);
  @override
  late final GeneratedColumnWithTypeConverter<JsonString?, String>
      jsonSearchGroups = GeneratedColumn<String>(
              'json_search_groups', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<JsonString?>($AccountTable.$converterjsonSearchGroups);
  @override
  late final GeneratedColumnWithTypeConverter<JsonString?, String>
      jsonProfileFilteringSettings = GeneratedColumn<String>(
              'json_profile_filtering_settings', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<JsonString?>(
              $AccountTable.$converterjsonProfileFilteringSettings);
  static const VerificationMeta _profileSearchAgeRangeMinMeta =
      const VerificationMeta('profileSearchAgeRangeMin');
  @override
  late final GeneratedColumn<int> profileSearchAgeRangeMin =
      GeneratedColumn<int>('profile_search_age_range_min', aliasedName, true,
          type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _profileSearchAgeRangeMaxMeta =
      const VerificationMeta('profileSearchAgeRangeMax');
  @override
  late final GeneratedColumn<int> profileSearchAgeRangeMax =
      GeneratedColumn<int>('profile_search_age_range_max', aliasedName, true,
          type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _accountEmailAddressMeta =
      const VerificationMeta('accountEmailAddress');
  @override
  late final GeneratedColumn<String> accountEmailAddress =
      GeneratedColumn<String>('account_email_address', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _refreshTokenAccountMeta =
      const VerificationMeta('refreshTokenAccount');
  @override
  late final GeneratedColumn<String> refreshTokenAccount =
      GeneratedColumn<String>('refresh_token_account', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _refreshTokenMediaMeta =
      const VerificationMeta('refreshTokenMedia');
  @override
  late final GeneratedColumn<String> refreshTokenMedia =
      GeneratedColumn<String>('refresh_token_media', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _refreshTokenProfileMeta =
      const VerificationMeta('refreshTokenProfile');
  @override
  late final GeneratedColumn<String> refreshTokenProfile =
      GeneratedColumn<String>('refresh_token_profile', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _refreshTokenChatMeta =
      const VerificationMeta('refreshTokenChat');
  @override
  late final GeneratedColumn<String> refreshTokenChat = GeneratedColumn<String>(
      'refresh_token_chat', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _accessTokenAccountMeta =
      const VerificationMeta('accessTokenAccount');
  @override
  late final GeneratedColumn<String> accessTokenAccount =
      GeneratedColumn<String>('access_token_account', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _accessTokenMediaMeta =
      const VerificationMeta('accessTokenMedia');
  @override
  late final GeneratedColumn<String> accessTokenMedia = GeneratedColumn<String>(
      'access_token_media', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _accessTokenProfileMeta =
      const VerificationMeta('accessTokenProfile');
  @override
  late final GeneratedColumn<String> accessTokenProfile =
      GeneratedColumn<String>('access_token_profile', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _accessTokenChatMeta =
      const VerificationMeta('accessTokenChat');
  @override
  late final GeneratedColumn<String> accessTokenChat = GeneratedColumn<String>(
      'access_token_chat', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _localImageSettingImageCacheMaxBytesMeta =
      const VerificationMeta('localImageSettingImageCacheMaxBytes');
  @override
  late final GeneratedColumn<int> localImageSettingImageCacheMaxBytes =
      GeneratedColumn<int>(
          'local_image_setting_image_cache_max_bytes', aliasedName, true,
          type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _localImageSettingCacheFullSizedImagesMeta =
      const VerificationMeta('localImageSettingCacheFullSizedImages');
  @override
  late final GeneratedColumn<
      bool> localImageSettingCacheFullSizedImages = GeneratedColumn<
          bool>(
      'local_image_setting_cache_full_sized_images', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("local_image_setting_cache_full_sized_images" IN (0, 1))'));
  static const VerificationMeta
      _localImageSettingImageCacheDownscalingSizeMeta =
      const VerificationMeta('localImageSettingImageCacheDownscalingSize');
  @override
  late final GeneratedColumn<int> localImageSettingImageCacheDownscalingSize =
      GeneratedColumn<int>(
          'local_image_setting_image_cache_downscaling_size', aliasedName, true,
          type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  late final GeneratedColumnWithTypeConverter<PrivateKeyData?, Uint8List>
      privateKeyData = GeneratedColumn<Uint8List>(
              'private_key_data', aliasedName, true,
              type: DriftSqlType.blob, requiredDuringInsert: false)
          .withConverter<PrivateKeyData?>(
              $AccountTable.$converterprivateKeyData);
  @override
  late final GeneratedColumnWithTypeConverter<PublicKeyData?, Uint8List>
      publicKeyData = GeneratedColumn<Uint8List>(
              'public_key_data', aliasedName, true,
              type: DriftSqlType.blob, requiredDuringInsert: false)
          .withConverter<PublicKeyData?>($AccountTable.$converterpublicKeyData);
  @override
  late final GeneratedColumnWithTypeConverter<api.PublicKeyId?, int>
      publicKeyId = GeneratedColumn<int>('public_key_id', aliasedName, true,
              type: DriftSqlType.int, requiredDuringInsert: false)
          .withConverter<api.PublicKeyId?>($AccountTable.$converterpublicKeyId);
  @override
  late final GeneratedColumnWithTypeConverter<UtcDateTime?, int>
      profileInitialAgeSetUnixTime = GeneratedColumn<int>(
              'profile_initial_age_set_unix_time', aliasedName, true,
              type: DriftSqlType.int, requiredDuringInsert: false)
          .withConverter<UtcDateTime?>(
              $AccountTable.$converterprofileInitialAgeSetUnixTime);
  static const VerificationMeta _profileInitialAgeMeta =
      const VerificationMeta('profileInitialAge');
  @override
  late final GeneratedColumn<int> profileInitialAge = GeneratedColumn<int>(
      'profile_initial_age', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  late final GeneratedColumnWithTypeConverter<UtcDateTime?, int>
      serverMaintenanceUnixTime = GeneratedColumn<int>(
              'server_maintenance_unix_time', aliasedName, true,
              type: DriftSqlType.int, requiredDuringInsert: false)
          .withConverter<UtcDateTime?>(
              $AccountTable.$converterserverMaintenanceUnixTime);
  @override
  late final GeneratedColumnWithTypeConverter<UtcDateTime?, int>
      serverMaintenanceUnixTimeViewed = GeneratedColumn<int>(
              'server_maintenance_unix_time_viewed', aliasedName, true,
              type: DriftSqlType.int, requiredDuringInsert: false)
          .withConverter<UtcDateTime?>(
              $AccountTable.$converterserverMaintenanceUnixTimeViewed);
  @override
  late final GeneratedColumnWithTypeConverter<api.CustomReportsFileHash?,
      String> customReportsFileHash = GeneratedColumn<String>(
          'custom_reports_file_hash', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false)
      .withConverter<api.CustomReportsFileHash?>(
          $AccountTable.$convertercustomReportsFileHash);
  @override
  late final GeneratedColumnWithTypeConverter<JsonString?, String>
      customReportsConfig = GeneratedColumn<String>(
              'custom_reports_config', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<JsonString?>(
              $AccountTable.$convertercustomReportsConfig);
  @override
  late final GeneratedColumnWithTypeConverter<api.ClientFeaturesFileHash?,
      String> clientFeaturesFileHash = GeneratedColumn<String>(
          'client_features_file_hash', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false)
      .withConverter<api.ClientFeaturesFileHash?>(
          $AccountTable.$converterclientFeaturesFileHash);
  @override
  late final GeneratedColumnWithTypeConverter<JsonString?, String>
      clientFeaturesConfig = GeneratedColumn<String>(
              'client_features_config', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<JsonString?>(
              $AccountTable.$converterclientFeaturesConfig);
  static const VerificationMeta _initialSetupSkippedMeta =
      const VerificationMeta('initialSetupSkipped');
  @override
  late final GeneratedColumn<bool> initialSetupSkipped = GeneratedColumn<bool>(
      'initial_setup_skipped', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("initial_setup_skipped" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        uuidAccountId,
        jsonAccountState,
        jsonPermissions,
        jsonProfileVisibility,
        profileFilterFavorites,
        profileIteratorSessionId,
        automatiProfileSearchIteratorSessionId,
        receivedLikesIteratorSessionId,
        matchesIteratorSessionId,
        clientId,
        jsonAvailableProfileAttributesOrderMode,
        initialSyncDoneLoginRepository,
        initialSyncDoneAccountRepository,
        initialSyncDoneMediaRepository,
        initialSyncDoneProfileRepository,
        initialSyncDoneChatRepository,
        syncVersionAccount,
        syncVersionProfile,
        syncVersionMediaContent,
        syncVersionClientConfig,
        primaryContentGridCropSize,
        primaryContentGridCropX,
        primaryContentGridCropY,
        profileContentVersion,
        profileName,
        profileNameAccepted,
        profileNameModerationState,
        profileText,
        profileTextAccepted,
        profileTextModerationState,
        profileTextModerationRejectedCategory,
        profileTextModerationRejectedDetails,
        profileAge,
        profileUnlimitedLikes,
        profileVersion,
        jsonProfileAttributes,
        profileLocationLatitude,
        profileLocationLongitude,
        jsonSearchGroups,
        jsonProfileFilteringSettings,
        profileSearchAgeRangeMin,
        profileSearchAgeRangeMax,
        accountEmailAddress,
        refreshTokenAccount,
        refreshTokenMedia,
        refreshTokenProfile,
        refreshTokenChat,
        accessTokenAccount,
        accessTokenMedia,
        accessTokenProfile,
        accessTokenChat,
        localImageSettingImageCacheMaxBytes,
        localImageSettingCacheFullSizedImages,
        localImageSettingImageCacheDownscalingSize,
        privateKeyData,
        publicKeyData,
        publicKeyId,
        profileInitialAgeSetUnixTime,
        profileInitialAge,
        serverMaintenanceUnixTime,
        serverMaintenanceUnixTimeViewed,
        customReportsFileHash,
        customReportsConfig,
        clientFeaturesFileHash,
        clientFeaturesConfig,
        initialSetupSkipped
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'account';
  @override
  VerificationContext validateIntegrity(Insertable<AccountData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('profile_filter_favorites')) {
      context.handle(
          _profileFilterFavoritesMeta,
          profileFilterFavorites.isAcceptableOrUnknown(
              data['profile_filter_favorites']!, _profileFilterFavoritesMeta));
    }
    if (data.containsKey('initial_sync_done_login_repository')) {
      context.handle(
          _initialSyncDoneLoginRepositoryMeta,
          initialSyncDoneLoginRepository.isAcceptableOrUnknown(
              data['initial_sync_done_login_repository']!,
              _initialSyncDoneLoginRepositoryMeta));
    }
    if (data.containsKey('initial_sync_done_account_repository')) {
      context.handle(
          _initialSyncDoneAccountRepositoryMeta,
          initialSyncDoneAccountRepository.isAcceptableOrUnknown(
              data['initial_sync_done_account_repository']!,
              _initialSyncDoneAccountRepositoryMeta));
    }
    if (data.containsKey('initial_sync_done_media_repository')) {
      context.handle(
          _initialSyncDoneMediaRepositoryMeta,
          initialSyncDoneMediaRepository.isAcceptableOrUnknown(
              data['initial_sync_done_media_repository']!,
              _initialSyncDoneMediaRepositoryMeta));
    }
    if (data.containsKey('initial_sync_done_profile_repository')) {
      context.handle(
          _initialSyncDoneProfileRepositoryMeta,
          initialSyncDoneProfileRepository.isAcceptableOrUnknown(
              data['initial_sync_done_profile_repository']!,
              _initialSyncDoneProfileRepositoryMeta));
    }
    if (data.containsKey('initial_sync_done_chat_repository')) {
      context.handle(
          _initialSyncDoneChatRepositoryMeta,
          initialSyncDoneChatRepository.isAcceptableOrUnknown(
              data['initial_sync_done_chat_repository']!,
              _initialSyncDoneChatRepositoryMeta));
    }
    if (data.containsKey('sync_version_account')) {
      context.handle(
          _syncVersionAccountMeta,
          syncVersionAccount.isAcceptableOrUnknown(
              data['sync_version_account']!, _syncVersionAccountMeta));
    }
    if (data.containsKey('sync_version_profile')) {
      context.handle(
          _syncVersionProfileMeta,
          syncVersionProfile.isAcceptableOrUnknown(
              data['sync_version_profile']!, _syncVersionProfileMeta));
    }
    if (data.containsKey('sync_version_media_content')) {
      context.handle(
          _syncVersionMediaContentMeta,
          syncVersionMediaContent.isAcceptableOrUnknown(
              data['sync_version_media_content']!,
              _syncVersionMediaContentMeta));
    }
    if (data.containsKey('sync_version_client_config')) {
      context.handle(
          _syncVersionClientConfigMeta,
          syncVersionClientConfig.isAcceptableOrUnknown(
              data['sync_version_client_config']!,
              _syncVersionClientConfigMeta));
    }
    if (data.containsKey('primary_content_grid_crop_size')) {
      context.handle(
          _primaryContentGridCropSizeMeta,
          primaryContentGridCropSize.isAcceptableOrUnknown(
              data['primary_content_grid_crop_size']!,
              _primaryContentGridCropSizeMeta));
    }
    if (data.containsKey('primary_content_grid_crop_x')) {
      context.handle(
          _primaryContentGridCropXMeta,
          primaryContentGridCropX.isAcceptableOrUnknown(
              data['primary_content_grid_crop_x']!,
              _primaryContentGridCropXMeta));
    }
    if (data.containsKey('primary_content_grid_crop_y')) {
      context.handle(
          _primaryContentGridCropYMeta,
          primaryContentGridCropY.isAcceptableOrUnknown(
              data['primary_content_grid_crop_y']!,
              _primaryContentGridCropYMeta));
    }
    if (data.containsKey('profile_name')) {
      context.handle(
          _profileNameMeta,
          profileName.isAcceptableOrUnknown(
              data['profile_name']!, _profileNameMeta));
    }
    if (data.containsKey('profile_name_accepted')) {
      context.handle(
          _profileNameAcceptedMeta,
          profileNameAccepted.isAcceptableOrUnknown(
              data['profile_name_accepted']!, _profileNameAcceptedMeta));
    }
    if (data.containsKey('profile_text')) {
      context.handle(
          _profileTextMeta,
          profileText.isAcceptableOrUnknown(
              data['profile_text']!, _profileTextMeta));
    }
    if (data.containsKey('profile_text_accepted')) {
      context.handle(
          _profileTextAcceptedMeta,
          profileTextAccepted.isAcceptableOrUnknown(
              data['profile_text_accepted']!, _profileTextAcceptedMeta));
    }
    if (data.containsKey('profile_age')) {
      context.handle(
          _profileAgeMeta,
          profileAge.isAcceptableOrUnknown(
              data['profile_age']!, _profileAgeMeta));
    }
    if (data.containsKey('profile_unlimited_likes')) {
      context.handle(
          _profileUnlimitedLikesMeta,
          profileUnlimitedLikes.isAcceptableOrUnknown(
              data['profile_unlimited_likes']!, _profileUnlimitedLikesMeta));
    }
    if (data.containsKey('profile_location_latitude')) {
      context.handle(
          _profileLocationLatitudeMeta,
          profileLocationLatitude.isAcceptableOrUnknown(
              data['profile_location_latitude']!,
              _profileLocationLatitudeMeta));
    }
    if (data.containsKey('profile_location_longitude')) {
      context.handle(
          _profileLocationLongitudeMeta,
          profileLocationLongitude.isAcceptableOrUnknown(
              data['profile_location_longitude']!,
              _profileLocationLongitudeMeta));
    }
    if (data.containsKey('profile_search_age_range_min')) {
      context.handle(
          _profileSearchAgeRangeMinMeta,
          profileSearchAgeRangeMin.isAcceptableOrUnknown(
              data['profile_search_age_range_min']!,
              _profileSearchAgeRangeMinMeta));
    }
    if (data.containsKey('profile_search_age_range_max')) {
      context.handle(
          _profileSearchAgeRangeMaxMeta,
          profileSearchAgeRangeMax.isAcceptableOrUnknown(
              data['profile_search_age_range_max']!,
              _profileSearchAgeRangeMaxMeta));
    }
    if (data.containsKey('account_email_address')) {
      context.handle(
          _accountEmailAddressMeta,
          accountEmailAddress.isAcceptableOrUnknown(
              data['account_email_address']!, _accountEmailAddressMeta));
    }
    if (data.containsKey('refresh_token_account')) {
      context.handle(
          _refreshTokenAccountMeta,
          refreshTokenAccount.isAcceptableOrUnknown(
              data['refresh_token_account']!, _refreshTokenAccountMeta));
    }
    if (data.containsKey('refresh_token_media')) {
      context.handle(
          _refreshTokenMediaMeta,
          refreshTokenMedia.isAcceptableOrUnknown(
              data['refresh_token_media']!, _refreshTokenMediaMeta));
    }
    if (data.containsKey('refresh_token_profile')) {
      context.handle(
          _refreshTokenProfileMeta,
          refreshTokenProfile.isAcceptableOrUnknown(
              data['refresh_token_profile']!, _refreshTokenProfileMeta));
    }
    if (data.containsKey('refresh_token_chat')) {
      context.handle(
          _refreshTokenChatMeta,
          refreshTokenChat.isAcceptableOrUnknown(
              data['refresh_token_chat']!, _refreshTokenChatMeta));
    }
    if (data.containsKey('access_token_account')) {
      context.handle(
          _accessTokenAccountMeta,
          accessTokenAccount.isAcceptableOrUnknown(
              data['access_token_account']!, _accessTokenAccountMeta));
    }
    if (data.containsKey('access_token_media')) {
      context.handle(
          _accessTokenMediaMeta,
          accessTokenMedia.isAcceptableOrUnknown(
              data['access_token_media']!, _accessTokenMediaMeta));
    }
    if (data.containsKey('access_token_profile')) {
      context.handle(
          _accessTokenProfileMeta,
          accessTokenProfile.isAcceptableOrUnknown(
              data['access_token_profile']!, _accessTokenProfileMeta));
    }
    if (data.containsKey('access_token_chat')) {
      context.handle(
          _accessTokenChatMeta,
          accessTokenChat.isAcceptableOrUnknown(
              data['access_token_chat']!, _accessTokenChatMeta));
    }
    if (data.containsKey('local_image_setting_image_cache_max_bytes')) {
      context.handle(
          _localImageSettingImageCacheMaxBytesMeta,
          localImageSettingImageCacheMaxBytes.isAcceptableOrUnknown(
              data['local_image_setting_image_cache_max_bytes']!,
              _localImageSettingImageCacheMaxBytesMeta));
    }
    if (data.containsKey('local_image_setting_cache_full_sized_images')) {
      context.handle(
          _localImageSettingCacheFullSizedImagesMeta,
          localImageSettingCacheFullSizedImages.isAcceptableOrUnknown(
              data['local_image_setting_cache_full_sized_images']!,
              _localImageSettingCacheFullSizedImagesMeta));
    }
    if (data.containsKey('local_image_setting_image_cache_downscaling_size')) {
      context.handle(
          _localImageSettingImageCacheDownscalingSizeMeta,
          localImageSettingImageCacheDownscalingSize.isAcceptableOrUnknown(
              data['local_image_setting_image_cache_downscaling_size']!,
              _localImageSettingImageCacheDownscalingSizeMeta));
    }
    if (data.containsKey('profile_initial_age')) {
      context.handle(
          _profileInitialAgeMeta,
          profileInitialAge.isAcceptableOrUnknown(
              data['profile_initial_age']!, _profileInitialAgeMeta));
    }
    if (data.containsKey('initial_setup_skipped')) {
      context.handle(
          _initialSetupSkippedMeta,
          initialSetupSkipped.isAcceptableOrUnknown(
              data['initial_setup_skipped']!, _initialSetupSkippedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AccountData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AccountData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      uuidAccountId: $AccountTable.$converteruuidAccountId.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}uuid_account_id'])),
      jsonAccountState: $AccountTable.$converterjsonAccountState.fromSql(
          attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}json_account_state'])),
      jsonPermissions: $AccountTable.$converterjsonPermissions.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}json_permissions'])),
      jsonProfileVisibility: $AccountTable.$converterjsonProfileVisibility
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}json_profile_visibility'])),
      profileFilterFavorites: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}profile_filter_favorites'])!,
      profileIteratorSessionId: $AccountTable.$converterprofileIteratorSessionId
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.int,
              data['${effectivePrefix}profile_iterator_session_id'])),
      automatiProfileSearchIteratorSessionId: $AccountTable
          .$converterautomatiProfileSearchIteratorSessionId
          .fromSql(attachedDatabase.typeMapping.read(
              DriftSqlType.int,
              data[
                  '${effectivePrefix}automati_profile_search_iterator_session_id'])),
      receivedLikesIteratorSessionId: $AccountTable
          .$converterreceivedLikesIteratorSessionId
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.int,
              data['${effectivePrefix}received_likes_iterator_session_id'])),
      matchesIteratorSessionId: $AccountTable.$convertermatchesIteratorSessionId
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.int,
              data['${effectivePrefix}matches_iterator_session_id'])),
      clientId: $AccountTable.$converterclientId.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}client_id'])),
      jsonAvailableProfileAttributesOrderMode: $AccountTable
          .$converterjsonAvailableProfileAttributesOrderMode
          .fromSql(attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data[
                  '${effectivePrefix}json_available_profile_attributes_order_mode'])),
      initialSyncDoneLoginRepository: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}initial_sync_done_login_repository'])!,
      initialSyncDoneAccountRepository: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}initial_sync_done_account_repository'])!,
      initialSyncDoneMediaRepository: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}initial_sync_done_media_repository'])!,
      initialSyncDoneProfileRepository: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}initial_sync_done_profile_repository'])!,
      initialSyncDoneChatRepository: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}initial_sync_done_chat_repository'])!,
      syncVersionAccount: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}sync_version_account']),
      syncVersionProfile: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}sync_version_profile']),
      syncVersionMediaContent: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}sync_version_media_content']),
      syncVersionClientConfig: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}sync_version_client_config']),
      primaryContentGridCropSize: attachedDatabase.typeMapping.read(
          DriftSqlType.double,
          data['${effectivePrefix}primary_content_grid_crop_size']),
      primaryContentGridCropX: attachedDatabase.typeMapping.read(
          DriftSqlType.double,
          data['${effectivePrefix}primary_content_grid_crop_x']),
      primaryContentGridCropY: attachedDatabase.typeMapping.read(
          DriftSqlType.double,
          data['${effectivePrefix}primary_content_grid_crop_y']),
      profileContentVersion: $AccountTable.$converterprofileContentVersion
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}profile_content_version'])),
      profileName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}profile_name']),
      profileNameAccepted: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}profile_name_accepted']),
      profileNameModerationState: $AccountTable
          .$converterprofileNameModerationState
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}profile_name_moderation_state'])),
      profileText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}profile_text']),
      profileTextAccepted: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}profile_text_accepted']),
      profileTextModerationState: $AccountTable
          .$converterprofileTextModerationState
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}profile_text_moderation_state'])),
      profileTextModerationRejectedCategory: $AccountTable
          .$converterprofileTextModerationRejectedCategory
          .fromSql(attachedDatabase.typeMapping.read(
              DriftSqlType.int,
              data[
                  '${effectivePrefix}profile_text_moderation_rejected_category'])),
      profileTextModerationRejectedDetails: $AccountTable
          .$converterprofileTextModerationRejectedDetails
          .fromSql(attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data[
                  '${effectivePrefix}profile_text_moderation_rejected_details'])),
      profileAge: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}profile_age']),
      profileUnlimitedLikes: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}profile_unlimited_likes']),
      profileVersion: $AccountTable.$converterprofileVersion.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}profile_version'])),
      jsonProfileAttributes: $AccountTable.$converterjsonProfileAttributes
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}json_profile_attributes'])),
      profileLocationLatitude: attachedDatabase.typeMapping.read(
          DriftSqlType.double,
          data['${effectivePrefix}profile_location_latitude']),
      profileLocationLongitude: attachedDatabase.typeMapping.read(
          DriftSqlType.double,
          data['${effectivePrefix}profile_location_longitude']),
      jsonSearchGroups: $AccountTable.$converterjsonSearchGroups.fromSql(
          attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}json_search_groups'])),
      jsonProfileFilteringSettings: $AccountTable
          .$converterjsonProfileFilteringSettings
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}json_profile_filtering_settings'])),
      profileSearchAgeRangeMin: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}profile_search_age_range_min']),
      profileSearchAgeRangeMax: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}profile_search_age_range_max']),
      accountEmailAddress: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}account_email_address']),
      refreshTokenAccount: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}refresh_token_account']),
      refreshTokenMedia: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}refresh_token_media']),
      refreshTokenProfile: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}refresh_token_profile']),
      refreshTokenChat: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}refresh_token_chat']),
      accessTokenAccount: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}access_token_account']),
      accessTokenMedia: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}access_token_media']),
      accessTokenProfile: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}access_token_profile']),
      accessTokenChat: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}access_token_chat']),
      localImageSettingImageCacheMaxBytes: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}local_image_setting_image_cache_max_bytes']),
      localImageSettingCacheFullSizedImages: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data[
              '${effectivePrefix}local_image_setting_cache_full_sized_images']),
      localImageSettingImageCacheDownscalingSize: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data[
              '${effectivePrefix}local_image_setting_image_cache_downscaling_size']),
      privateKeyData: $AccountTable.$converterprivateKeyData.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.blob, data['${effectivePrefix}private_key_data'])),
      publicKeyData: $AccountTable.$converterpublicKeyData.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.blob, data['${effectivePrefix}public_key_data'])),
      publicKeyId: $AccountTable.$converterpublicKeyId.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}public_key_id'])),
      profileInitialAgeSetUnixTime: $AccountTable
          .$converterprofileInitialAgeSetUnixTime
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.int,
              data['${effectivePrefix}profile_initial_age_set_unix_time'])),
      profileInitialAge: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}profile_initial_age']),
      serverMaintenanceUnixTime: $AccountTable
          .$converterserverMaintenanceUnixTime
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.int,
              data['${effectivePrefix}server_maintenance_unix_time'])),
      serverMaintenanceUnixTimeViewed: $AccountTable
          .$converterserverMaintenanceUnixTimeViewed
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.int,
              data['${effectivePrefix}server_maintenance_unix_time_viewed'])),
      customReportsFileHash: $AccountTable.$convertercustomReportsFileHash
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}custom_reports_file_hash'])),
      customReportsConfig: $AccountTable.$convertercustomReportsConfig.fromSql(
          attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}custom_reports_config'])),
      clientFeaturesFileHash: $AccountTable.$converterclientFeaturesFileHash
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}client_features_file_hash'])),
      clientFeaturesConfig: $AccountTable.$converterclientFeaturesConfig
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}client_features_config'])),
      initialSetupSkipped: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}initial_setup_skipped'])!,
    );
  }

  @override
  $AccountTable createAlias(String alias) {
    return $AccountTable(attachedDatabase, alias);
  }

  static TypeConverter<api.AccountId?, String?> $converteruuidAccountId =
      const NullAwareTypeConverter.wrap(AccountIdConverter());
  static TypeConverter<JsonString?, String?> $converterjsonAccountState =
      NullAwareTypeConverter.wrap(JsonString.driftConverter);
  static TypeConverter<JsonString?, String?> $converterjsonPermissions =
      NullAwareTypeConverter.wrap(JsonString.driftConverter);
  static TypeConverter<EnumString?, String?> $converterjsonProfileVisibility =
      NullAwareTypeConverter.wrap(EnumString.driftConverter);
  static TypeConverter<api.ProfileIteratorSessionId?, int?>
      $converterprofileIteratorSessionId =
      const NullAwareTypeConverter.wrap(ProfileIteratorSessionIdConverter());
  static TypeConverter<api.AutomaticProfileSearchIteratorSessionId?, int?>
      $converterautomatiProfileSearchIteratorSessionId =
      const NullAwareTypeConverter.wrap(
          AutomaticProfileSearchIteratorSessionIdConverter());
  static TypeConverter<api.ReceivedLikesIteratorSessionId?, int?>
      $converterreceivedLikesIteratorSessionId =
      const NullAwareTypeConverter.wrap(
          ReceivedLikesIteratorSessionIdConverter());
  static TypeConverter<api.MatchesIteratorSessionId?, int?>
      $convertermatchesIteratorSessionId =
      const NullAwareTypeConverter.wrap(MatchesIteratorSessionIdConverter());
  static TypeConverter<api.ClientId?, int?> $converterclientId =
      const NullAwareTypeConverter.wrap(ClientIdConverter());
  static TypeConverter<EnumString?, String?>
      $converterjsonAvailableProfileAttributesOrderMode =
      NullAwareTypeConverter.wrap(EnumString.driftConverter);
  static TypeConverter<api.ProfileContentVersion?, String?>
      $converterprofileContentVersion =
      const NullAwareTypeConverter.wrap(ProfileContentVersionConverter());
  static TypeConverter<EnumString?, String?>
      $converterprofileNameModerationState =
      NullAwareTypeConverter.wrap(EnumString.driftConverter);
  static TypeConverter<EnumString?, String?>
      $converterprofileTextModerationState =
      NullAwareTypeConverter.wrap(EnumString.driftConverter);
  static TypeConverter<api.ProfileTextModerationRejectedReasonCategory?, int?>
      $converterprofileTextModerationRejectedCategory =
      const NullAwareTypeConverter.wrap(
          ProfileTextModerationRejectedReasonCategoryConverter());
  static TypeConverter<api.ProfileTextModerationRejectedReasonDetails?, String?>
      $converterprofileTextModerationRejectedDetails =
      const NullAwareTypeConverter.wrap(
          ProfileTextModerationRejectedReasonDetailsConverter());
  static TypeConverter<api.ProfileVersion?, String?> $converterprofileVersion =
      const NullAwareTypeConverter.wrap(ProfileVersionConverter());
  static TypeConverter<JsonList?, String?> $converterjsonProfileAttributes =
      NullAwareTypeConverter.wrap(JsonList.driftConverter);
  static TypeConverter<JsonString?, String?> $converterjsonSearchGroups =
      NullAwareTypeConverter.wrap(JsonString.driftConverter);
  static TypeConverter<JsonString?, String?>
      $converterjsonProfileFilteringSettings =
      NullAwareTypeConverter.wrap(JsonString.driftConverter);
  static TypeConverter<PrivateKeyData?, Uint8List?> $converterprivateKeyData =
      const NullAwareTypeConverter.wrap(PrivateKeyDataConverter());
  static TypeConverter<PublicKeyData?, Uint8List?> $converterpublicKeyData =
      const NullAwareTypeConverter.wrap(PublicKeyDataConverter());
  static TypeConverter<api.PublicKeyId?, int?> $converterpublicKeyId =
      const NullAwareTypeConverter.wrap(PublicKeyIdConverter());
  static TypeConverter<UtcDateTime?, int?>
      $converterprofileInitialAgeSetUnixTime =
      const NullAwareTypeConverter.wrap(UtcDateTimeConverter());
  static TypeConverter<UtcDateTime?, int?> $converterserverMaintenanceUnixTime =
      const NullAwareTypeConverter.wrap(UtcDateTimeConverter());
  static TypeConverter<UtcDateTime?, int?>
      $converterserverMaintenanceUnixTimeViewed =
      const NullAwareTypeConverter.wrap(UtcDateTimeConverter());
  static TypeConverter<api.CustomReportsFileHash?, String?>
      $convertercustomReportsFileHash =
      const NullAwareTypeConverter.wrap(CustomReportsFileHashConverter());
  static TypeConverter<JsonString?, String?> $convertercustomReportsConfig =
      NullAwareTypeConverter.wrap(JsonString.driftConverter);
  static TypeConverter<api.ClientFeaturesFileHash?, String?>
      $converterclientFeaturesFileHash =
      const NullAwareTypeConverter.wrap(ClientFeaturesFileHashConverter());
  static TypeConverter<JsonString?, String?> $converterclientFeaturesConfig =
      NullAwareTypeConverter.wrap(JsonString.driftConverter);
}

class AccountData extends DataClass implements Insertable<AccountData> {
  final int id;
  final api.AccountId? uuidAccountId;
  final JsonString? jsonAccountState;
  final JsonString? jsonPermissions;
  final EnumString? jsonProfileVisibility;

  /// If true show only favorite profiles
  final bool profileFilterFavorites;
  final api.ProfileIteratorSessionId? profileIteratorSessionId;
  final api.AutomaticProfileSearchIteratorSessionId?
      automatiProfileSearchIteratorSessionId;
  final api.ReceivedLikesIteratorSessionId? receivedLikesIteratorSessionId;
  final api.MatchesIteratorSessionId? matchesIteratorSessionId;
  final api.ClientId? clientId;
  final EnumString? jsonAvailableProfileAttributesOrderMode;
  final bool initialSyncDoneLoginRepository;
  final bool initialSyncDoneAccountRepository;
  final bool initialSyncDoneMediaRepository;
  final bool initialSyncDoneProfileRepository;
  final bool initialSyncDoneChatRepository;
  final int? syncVersionAccount;
  final int? syncVersionProfile;
  final int? syncVersionMediaContent;
  final int? syncVersionClientConfig;
  final double? primaryContentGridCropSize;
  final double? primaryContentGridCropX;
  final double? primaryContentGridCropY;
  final api.ProfileContentVersion? profileContentVersion;
  final String? profileName;
  final bool? profileNameAccepted;
  final EnumString? profileNameModerationState;
  final String? profileText;
  final bool? profileTextAccepted;
  final EnumString? profileTextModerationState;
  final api.ProfileTextModerationRejectedReasonCategory?
      profileTextModerationRejectedCategory;
  final api.ProfileTextModerationRejectedReasonDetails?
      profileTextModerationRejectedDetails;
  final int? profileAge;
  final bool? profileUnlimitedLikes;
  final api.ProfileVersion? profileVersion;
  final JsonList? jsonProfileAttributes;
  final double? profileLocationLatitude;
  final double? profileLocationLongitude;
  final JsonString? jsonSearchGroups;
  final JsonString? jsonProfileFilteringSettings;
  final int? profileSearchAgeRangeMin;
  final int? profileSearchAgeRangeMax;
  final String? accountEmailAddress;
  final String? refreshTokenAccount;
  final String? refreshTokenMedia;
  final String? refreshTokenProfile;
  final String? refreshTokenChat;
  final String? accessTokenAccount;
  final String? accessTokenMedia;
  final String? accessTokenProfile;
  final String? accessTokenChat;
  final int? localImageSettingImageCacheMaxBytes;
  final bool? localImageSettingCacheFullSizedImages;
  final int? localImageSettingImageCacheDownscalingSize;
  final PrivateKeyData? privateKeyData;
  final PublicKeyData? publicKeyData;
  final api.PublicKeyId? publicKeyId;
  final UtcDateTime? profileInitialAgeSetUnixTime;
  final int? profileInitialAge;
  final UtcDateTime? serverMaintenanceUnixTime;
  final UtcDateTime? serverMaintenanceUnixTimeViewed;
  final api.CustomReportsFileHash? customReportsFileHash;
  final JsonString? customReportsConfig;
  final api.ClientFeaturesFileHash? clientFeaturesFileHash;
  final JsonString? clientFeaturesConfig;
  final bool initialSetupSkipped;
  const AccountData(
      {required this.id,
      this.uuidAccountId,
      this.jsonAccountState,
      this.jsonPermissions,
      this.jsonProfileVisibility,
      required this.profileFilterFavorites,
      this.profileIteratorSessionId,
      this.automatiProfileSearchIteratorSessionId,
      this.receivedLikesIteratorSessionId,
      this.matchesIteratorSessionId,
      this.clientId,
      this.jsonAvailableProfileAttributesOrderMode,
      required this.initialSyncDoneLoginRepository,
      required this.initialSyncDoneAccountRepository,
      required this.initialSyncDoneMediaRepository,
      required this.initialSyncDoneProfileRepository,
      required this.initialSyncDoneChatRepository,
      this.syncVersionAccount,
      this.syncVersionProfile,
      this.syncVersionMediaContent,
      this.syncVersionClientConfig,
      this.primaryContentGridCropSize,
      this.primaryContentGridCropX,
      this.primaryContentGridCropY,
      this.profileContentVersion,
      this.profileName,
      this.profileNameAccepted,
      this.profileNameModerationState,
      this.profileText,
      this.profileTextAccepted,
      this.profileTextModerationState,
      this.profileTextModerationRejectedCategory,
      this.profileTextModerationRejectedDetails,
      this.profileAge,
      this.profileUnlimitedLikes,
      this.profileVersion,
      this.jsonProfileAttributes,
      this.profileLocationLatitude,
      this.profileLocationLongitude,
      this.jsonSearchGroups,
      this.jsonProfileFilteringSettings,
      this.profileSearchAgeRangeMin,
      this.profileSearchAgeRangeMax,
      this.accountEmailAddress,
      this.refreshTokenAccount,
      this.refreshTokenMedia,
      this.refreshTokenProfile,
      this.refreshTokenChat,
      this.accessTokenAccount,
      this.accessTokenMedia,
      this.accessTokenProfile,
      this.accessTokenChat,
      this.localImageSettingImageCacheMaxBytes,
      this.localImageSettingCacheFullSizedImages,
      this.localImageSettingImageCacheDownscalingSize,
      this.privateKeyData,
      this.publicKeyData,
      this.publicKeyId,
      this.profileInitialAgeSetUnixTime,
      this.profileInitialAge,
      this.serverMaintenanceUnixTime,
      this.serverMaintenanceUnixTimeViewed,
      this.customReportsFileHash,
      this.customReportsConfig,
      this.clientFeaturesFileHash,
      this.clientFeaturesConfig,
      required this.initialSetupSkipped});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || uuidAccountId != null) {
      map['uuid_account_id'] = Variable<String>(
          $AccountTable.$converteruuidAccountId.toSql(uuidAccountId));
    }
    if (!nullToAbsent || jsonAccountState != null) {
      map['json_account_state'] = Variable<String>(
          $AccountTable.$converterjsonAccountState.toSql(jsonAccountState));
    }
    if (!nullToAbsent || jsonPermissions != null) {
      map['json_permissions'] = Variable<String>(
          $AccountTable.$converterjsonPermissions.toSql(jsonPermissions));
    }
    if (!nullToAbsent || jsonProfileVisibility != null) {
      map['json_profile_visibility'] = Variable<String>($AccountTable
          .$converterjsonProfileVisibility
          .toSql(jsonProfileVisibility));
    }
    map['profile_filter_favorites'] = Variable<bool>(profileFilterFavorites);
    if (!nullToAbsent || profileIteratorSessionId != null) {
      map['profile_iterator_session_id'] = Variable<int>($AccountTable
          .$converterprofileIteratorSessionId
          .toSql(profileIteratorSessionId));
    }
    if (!nullToAbsent || automatiProfileSearchIteratorSessionId != null) {
      map['automati_profile_search_iterator_session_id'] = Variable<int>(
          $AccountTable.$converterautomatiProfileSearchIteratorSessionId
              .toSql(automatiProfileSearchIteratorSessionId));
    }
    if (!nullToAbsent || receivedLikesIteratorSessionId != null) {
      map['received_likes_iterator_session_id'] = Variable<int>($AccountTable
          .$converterreceivedLikesIteratorSessionId
          .toSql(receivedLikesIteratorSessionId));
    }
    if (!nullToAbsent || matchesIteratorSessionId != null) {
      map['matches_iterator_session_id'] = Variable<int>($AccountTable
          .$convertermatchesIteratorSessionId
          .toSql(matchesIteratorSessionId));
    }
    if (!nullToAbsent || clientId != null) {
      map['client_id'] =
          Variable<int>($AccountTable.$converterclientId.toSql(clientId));
    }
    if (!nullToAbsent || jsonAvailableProfileAttributesOrderMode != null) {
      map['json_available_profile_attributes_order_mode'] = Variable<String>(
          $AccountTable.$converterjsonAvailableProfileAttributesOrderMode
              .toSql(jsonAvailableProfileAttributesOrderMode));
    }
    map['initial_sync_done_login_repository'] =
        Variable<bool>(initialSyncDoneLoginRepository);
    map['initial_sync_done_account_repository'] =
        Variable<bool>(initialSyncDoneAccountRepository);
    map['initial_sync_done_media_repository'] =
        Variable<bool>(initialSyncDoneMediaRepository);
    map['initial_sync_done_profile_repository'] =
        Variable<bool>(initialSyncDoneProfileRepository);
    map['initial_sync_done_chat_repository'] =
        Variable<bool>(initialSyncDoneChatRepository);
    if (!nullToAbsent || syncVersionAccount != null) {
      map['sync_version_account'] = Variable<int>(syncVersionAccount);
    }
    if (!nullToAbsent || syncVersionProfile != null) {
      map['sync_version_profile'] = Variable<int>(syncVersionProfile);
    }
    if (!nullToAbsent || syncVersionMediaContent != null) {
      map['sync_version_media_content'] =
          Variable<int>(syncVersionMediaContent);
    }
    if (!nullToAbsent || syncVersionClientConfig != null) {
      map['sync_version_client_config'] =
          Variable<int>(syncVersionClientConfig);
    }
    if (!nullToAbsent || primaryContentGridCropSize != null) {
      map['primary_content_grid_crop_size'] =
          Variable<double>(primaryContentGridCropSize);
    }
    if (!nullToAbsent || primaryContentGridCropX != null) {
      map['primary_content_grid_crop_x'] =
          Variable<double>(primaryContentGridCropX);
    }
    if (!nullToAbsent || primaryContentGridCropY != null) {
      map['primary_content_grid_crop_y'] =
          Variable<double>(primaryContentGridCropY);
    }
    if (!nullToAbsent || profileContentVersion != null) {
      map['profile_content_version'] = Variable<String>($AccountTable
          .$converterprofileContentVersion
          .toSql(profileContentVersion));
    }
    if (!nullToAbsent || profileName != null) {
      map['profile_name'] = Variable<String>(profileName);
    }
    if (!nullToAbsent || profileNameAccepted != null) {
      map['profile_name_accepted'] = Variable<bool>(profileNameAccepted);
    }
    if (!nullToAbsent || profileNameModerationState != null) {
      map['profile_name_moderation_state'] = Variable<String>($AccountTable
          .$converterprofileNameModerationState
          .toSql(profileNameModerationState));
    }
    if (!nullToAbsent || profileText != null) {
      map['profile_text'] = Variable<String>(profileText);
    }
    if (!nullToAbsent || profileTextAccepted != null) {
      map['profile_text_accepted'] = Variable<bool>(profileTextAccepted);
    }
    if (!nullToAbsent || profileTextModerationState != null) {
      map['profile_text_moderation_state'] = Variable<String>($AccountTable
          .$converterprofileTextModerationState
          .toSql(profileTextModerationState));
    }
    if (!nullToAbsent || profileTextModerationRejectedCategory != null) {
      map['profile_text_moderation_rejected_category'] = Variable<int>(
          $AccountTable.$converterprofileTextModerationRejectedCategory
              .toSql(profileTextModerationRejectedCategory));
    }
    if (!nullToAbsent || profileTextModerationRejectedDetails != null) {
      map['profile_text_moderation_rejected_details'] = Variable<String>(
          $AccountTable.$converterprofileTextModerationRejectedDetails
              .toSql(profileTextModerationRejectedDetails));
    }
    if (!nullToAbsent || profileAge != null) {
      map['profile_age'] = Variable<int>(profileAge);
    }
    if (!nullToAbsent || profileUnlimitedLikes != null) {
      map['profile_unlimited_likes'] = Variable<bool>(profileUnlimitedLikes);
    }
    if (!nullToAbsent || profileVersion != null) {
      map['profile_version'] = Variable<String>(
          $AccountTable.$converterprofileVersion.toSql(profileVersion));
    }
    if (!nullToAbsent || jsonProfileAttributes != null) {
      map['json_profile_attributes'] = Variable<String>($AccountTable
          .$converterjsonProfileAttributes
          .toSql(jsonProfileAttributes));
    }
    if (!nullToAbsent || profileLocationLatitude != null) {
      map['profile_location_latitude'] =
          Variable<double>(profileLocationLatitude);
    }
    if (!nullToAbsent || profileLocationLongitude != null) {
      map['profile_location_longitude'] =
          Variable<double>(profileLocationLongitude);
    }
    if (!nullToAbsent || jsonSearchGroups != null) {
      map['json_search_groups'] = Variable<String>(
          $AccountTable.$converterjsonSearchGroups.toSql(jsonSearchGroups));
    }
    if (!nullToAbsent || jsonProfileFilteringSettings != null) {
      map['json_profile_filtering_settings'] = Variable<String>($AccountTable
          .$converterjsonProfileFilteringSettings
          .toSql(jsonProfileFilteringSettings));
    }
    if (!nullToAbsent || profileSearchAgeRangeMin != null) {
      map['profile_search_age_range_min'] =
          Variable<int>(profileSearchAgeRangeMin);
    }
    if (!nullToAbsent || profileSearchAgeRangeMax != null) {
      map['profile_search_age_range_max'] =
          Variable<int>(profileSearchAgeRangeMax);
    }
    if (!nullToAbsent || accountEmailAddress != null) {
      map['account_email_address'] = Variable<String>(accountEmailAddress);
    }
    if (!nullToAbsent || refreshTokenAccount != null) {
      map['refresh_token_account'] = Variable<String>(refreshTokenAccount);
    }
    if (!nullToAbsent || refreshTokenMedia != null) {
      map['refresh_token_media'] = Variable<String>(refreshTokenMedia);
    }
    if (!nullToAbsent || refreshTokenProfile != null) {
      map['refresh_token_profile'] = Variable<String>(refreshTokenProfile);
    }
    if (!nullToAbsent || refreshTokenChat != null) {
      map['refresh_token_chat'] = Variable<String>(refreshTokenChat);
    }
    if (!nullToAbsent || accessTokenAccount != null) {
      map['access_token_account'] = Variable<String>(accessTokenAccount);
    }
    if (!nullToAbsent || accessTokenMedia != null) {
      map['access_token_media'] = Variable<String>(accessTokenMedia);
    }
    if (!nullToAbsent || accessTokenProfile != null) {
      map['access_token_profile'] = Variable<String>(accessTokenProfile);
    }
    if (!nullToAbsent || accessTokenChat != null) {
      map['access_token_chat'] = Variable<String>(accessTokenChat);
    }
    if (!nullToAbsent || localImageSettingImageCacheMaxBytes != null) {
      map['local_image_setting_image_cache_max_bytes'] =
          Variable<int>(localImageSettingImageCacheMaxBytes);
    }
    if (!nullToAbsent || localImageSettingCacheFullSizedImages != null) {
      map['local_image_setting_cache_full_sized_images'] =
          Variable<bool>(localImageSettingCacheFullSizedImages);
    }
    if (!nullToAbsent || localImageSettingImageCacheDownscalingSize != null) {
      map['local_image_setting_image_cache_downscaling_size'] =
          Variable<int>(localImageSettingImageCacheDownscalingSize);
    }
    if (!nullToAbsent || privateKeyData != null) {
      map['private_key_data'] = Variable<Uint8List>(
          $AccountTable.$converterprivateKeyData.toSql(privateKeyData));
    }
    if (!nullToAbsent || publicKeyData != null) {
      map['public_key_data'] = Variable<Uint8List>(
          $AccountTable.$converterpublicKeyData.toSql(publicKeyData));
    }
    if (!nullToAbsent || publicKeyId != null) {
      map['public_key_id'] =
          Variable<int>($AccountTable.$converterpublicKeyId.toSql(publicKeyId));
    }
    if (!nullToAbsent || profileInitialAgeSetUnixTime != null) {
      map['profile_initial_age_set_unix_time'] = Variable<int>($AccountTable
          .$converterprofileInitialAgeSetUnixTime
          .toSql(profileInitialAgeSetUnixTime));
    }
    if (!nullToAbsent || profileInitialAge != null) {
      map['profile_initial_age'] = Variable<int>(profileInitialAge);
    }
    if (!nullToAbsent || serverMaintenanceUnixTime != null) {
      map['server_maintenance_unix_time'] = Variable<int>($AccountTable
          .$converterserverMaintenanceUnixTime
          .toSql(serverMaintenanceUnixTime));
    }
    if (!nullToAbsent || serverMaintenanceUnixTimeViewed != null) {
      map['server_maintenance_unix_time_viewed'] = Variable<int>($AccountTable
          .$converterserverMaintenanceUnixTimeViewed
          .toSql(serverMaintenanceUnixTimeViewed));
    }
    if (!nullToAbsent || customReportsFileHash != null) {
      map['custom_reports_file_hash'] = Variable<String>($AccountTable
          .$convertercustomReportsFileHash
          .toSql(customReportsFileHash));
    }
    if (!nullToAbsent || customReportsConfig != null) {
      map['custom_reports_config'] = Variable<String>($AccountTable
          .$convertercustomReportsConfig
          .toSql(customReportsConfig));
    }
    if (!nullToAbsent || clientFeaturesFileHash != null) {
      map['client_features_file_hash'] = Variable<String>($AccountTable
          .$converterclientFeaturesFileHash
          .toSql(clientFeaturesFileHash));
    }
    if (!nullToAbsent || clientFeaturesConfig != null) {
      map['client_features_config'] = Variable<String>($AccountTable
          .$converterclientFeaturesConfig
          .toSql(clientFeaturesConfig));
    }
    map['initial_setup_skipped'] = Variable<bool>(initialSetupSkipped);
    return map;
  }

  AccountCompanion toCompanion(bool nullToAbsent) {
    return AccountCompanion(
      id: Value(id),
      uuidAccountId: uuidAccountId == null && nullToAbsent
          ? const Value.absent()
          : Value(uuidAccountId),
      jsonAccountState: jsonAccountState == null && nullToAbsent
          ? const Value.absent()
          : Value(jsonAccountState),
      jsonPermissions: jsonPermissions == null && nullToAbsent
          ? const Value.absent()
          : Value(jsonPermissions),
      jsonProfileVisibility: jsonProfileVisibility == null && nullToAbsent
          ? const Value.absent()
          : Value(jsonProfileVisibility),
      profileFilterFavorites: Value(profileFilterFavorites),
      profileIteratorSessionId: profileIteratorSessionId == null && nullToAbsent
          ? const Value.absent()
          : Value(profileIteratorSessionId),
      automatiProfileSearchIteratorSessionId:
          automatiProfileSearchIteratorSessionId == null && nullToAbsent
              ? const Value.absent()
              : Value(automatiProfileSearchIteratorSessionId),
      receivedLikesIteratorSessionId:
          receivedLikesIteratorSessionId == null && nullToAbsent
              ? const Value.absent()
              : Value(receivedLikesIteratorSessionId),
      matchesIteratorSessionId: matchesIteratorSessionId == null && nullToAbsent
          ? const Value.absent()
          : Value(matchesIteratorSessionId),
      clientId: clientId == null && nullToAbsent
          ? const Value.absent()
          : Value(clientId),
      jsonAvailableProfileAttributesOrderMode:
          jsonAvailableProfileAttributesOrderMode == null && nullToAbsent
              ? const Value.absent()
              : Value(jsonAvailableProfileAttributesOrderMode),
      initialSyncDoneLoginRepository: Value(initialSyncDoneLoginRepository),
      initialSyncDoneAccountRepository: Value(initialSyncDoneAccountRepository),
      initialSyncDoneMediaRepository: Value(initialSyncDoneMediaRepository),
      initialSyncDoneProfileRepository: Value(initialSyncDoneProfileRepository),
      initialSyncDoneChatRepository: Value(initialSyncDoneChatRepository),
      syncVersionAccount: syncVersionAccount == null && nullToAbsent
          ? const Value.absent()
          : Value(syncVersionAccount),
      syncVersionProfile: syncVersionProfile == null && nullToAbsent
          ? const Value.absent()
          : Value(syncVersionProfile),
      syncVersionMediaContent: syncVersionMediaContent == null && nullToAbsent
          ? const Value.absent()
          : Value(syncVersionMediaContent),
      syncVersionClientConfig: syncVersionClientConfig == null && nullToAbsent
          ? const Value.absent()
          : Value(syncVersionClientConfig),
      primaryContentGridCropSize:
          primaryContentGridCropSize == null && nullToAbsent
              ? const Value.absent()
              : Value(primaryContentGridCropSize),
      primaryContentGridCropX: primaryContentGridCropX == null && nullToAbsent
          ? const Value.absent()
          : Value(primaryContentGridCropX),
      primaryContentGridCropY: primaryContentGridCropY == null && nullToAbsent
          ? const Value.absent()
          : Value(primaryContentGridCropY),
      profileContentVersion: profileContentVersion == null && nullToAbsent
          ? const Value.absent()
          : Value(profileContentVersion),
      profileName: profileName == null && nullToAbsent
          ? const Value.absent()
          : Value(profileName),
      profileNameAccepted: profileNameAccepted == null && nullToAbsent
          ? const Value.absent()
          : Value(profileNameAccepted),
      profileNameModerationState:
          profileNameModerationState == null && nullToAbsent
              ? const Value.absent()
              : Value(profileNameModerationState),
      profileText: profileText == null && nullToAbsent
          ? const Value.absent()
          : Value(profileText),
      profileTextAccepted: profileTextAccepted == null && nullToAbsent
          ? const Value.absent()
          : Value(profileTextAccepted),
      profileTextModerationState:
          profileTextModerationState == null && nullToAbsent
              ? const Value.absent()
              : Value(profileTextModerationState),
      profileTextModerationRejectedCategory:
          profileTextModerationRejectedCategory == null && nullToAbsent
              ? const Value.absent()
              : Value(profileTextModerationRejectedCategory),
      profileTextModerationRejectedDetails:
          profileTextModerationRejectedDetails == null && nullToAbsent
              ? const Value.absent()
              : Value(profileTextModerationRejectedDetails),
      profileAge: profileAge == null && nullToAbsent
          ? const Value.absent()
          : Value(profileAge),
      profileUnlimitedLikes: profileUnlimitedLikes == null && nullToAbsent
          ? const Value.absent()
          : Value(profileUnlimitedLikes),
      profileVersion: profileVersion == null && nullToAbsent
          ? const Value.absent()
          : Value(profileVersion),
      jsonProfileAttributes: jsonProfileAttributes == null && nullToAbsent
          ? const Value.absent()
          : Value(jsonProfileAttributes),
      profileLocationLatitude: profileLocationLatitude == null && nullToAbsent
          ? const Value.absent()
          : Value(profileLocationLatitude),
      profileLocationLongitude: profileLocationLongitude == null && nullToAbsent
          ? const Value.absent()
          : Value(profileLocationLongitude),
      jsonSearchGroups: jsonSearchGroups == null && nullToAbsent
          ? const Value.absent()
          : Value(jsonSearchGroups),
      jsonProfileFilteringSettings:
          jsonProfileFilteringSettings == null && nullToAbsent
              ? const Value.absent()
              : Value(jsonProfileFilteringSettings),
      profileSearchAgeRangeMin: profileSearchAgeRangeMin == null && nullToAbsent
          ? const Value.absent()
          : Value(profileSearchAgeRangeMin),
      profileSearchAgeRangeMax: profileSearchAgeRangeMax == null && nullToAbsent
          ? const Value.absent()
          : Value(profileSearchAgeRangeMax),
      accountEmailAddress: accountEmailAddress == null && nullToAbsent
          ? const Value.absent()
          : Value(accountEmailAddress),
      refreshTokenAccount: refreshTokenAccount == null && nullToAbsent
          ? const Value.absent()
          : Value(refreshTokenAccount),
      refreshTokenMedia: refreshTokenMedia == null && nullToAbsent
          ? const Value.absent()
          : Value(refreshTokenMedia),
      refreshTokenProfile: refreshTokenProfile == null && nullToAbsent
          ? const Value.absent()
          : Value(refreshTokenProfile),
      refreshTokenChat: refreshTokenChat == null && nullToAbsent
          ? const Value.absent()
          : Value(refreshTokenChat),
      accessTokenAccount: accessTokenAccount == null && nullToAbsent
          ? const Value.absent()
          : Value(accessTokenAccount),
      accessTokenMedia: accessTokenMedia == null && nullToAbsent
          ? const Value.absent()
          : Value(accessTokenMedia),
      accessTokenProfile: accessTokenProfile == null && nullToAbsent
          ? const Value.absent()
          : Value(accessTokenProfile),
      accessTokenChat: accessTokenChat == null && nullToAbsent
          ? const Value.absent()
          : Value(accessTokenChat),
      localImageSettingImageCacheMaxBytes:
          localImageSettingImageCacheMaxBytes == null && nullToAbsent
              ? const Value.absent()
              : Value(localImageSettingImageCacheMaxBytes),
      localImageSettingCacheFullSizedImages:
          localImageSettingCacheFullSizedImages == null && nullToAbsent
              ? const Value.absent()
              : Value(localImageSettingCacheFullSizedImages),
      localImageSettingImageCacheDownscalingSize:
          localImageSettingImageCacheDownscalingSize == null && nullToAbsent
              ? const Value.absent()
              : Value(localImageSettingImageCacheDownscalingSize),
      privateKeyData: privateKeyData == null && nullToAbsent
          ? const Value.absent()
          : Value(privateKeyData),
      publicKeyData: publicKeyData == null && nullToAbsent
          ? const Value.absent()
          : Value(publicKeyData),
      publicKeyId: publicKeyId == null && nullToAbsent
          ? const Value.absent()
          : Value(publicKeyId),
      profileInitialAgeSetUnixTime:
          profileInitialAgeSetUnixTime == null && nullToAbsent
              ? const Value.absent()
              : Value(profileInitialAgeSetUnixTime),
      profileInitialAge: profileInitialAge == null && nullToAbsent
          ? const Value.absent()
          : Value(profileInitialAge),
      serverMaintenanceUnixTime:
          serverMaintenanceUnixTime == null && nullToAbsent
              ? const Value.absent()
              : Value(serverMaintenanceUnixTime),
      serverMaintenanceUnixTimeViewed:
          serverMaintenanceUnixTimeViewed == null && nullToAbsent
              ? const Value.absent()
              : Value(serverMaintenanceUnixTimeViewed),
      customReportsFileHash: customReportsFileHash == null && nullToAbsent
          ? const Value.absent()
          : Value(customReportsFileHash),
      customReportsConfig: customReportsConfig == null && nullToAbsent
          ? const Value.absent()
          : Value(customReportsConfig),
      clientFeaturesFileHash: clientFeaturesFileHash == null && nullToAbsent
          ? const Value.absent()
          : Value(clientFeaturesFileHash),
      clientFeaturesConfig: clientFeaturesConfig == null && nullToAbsent
          ? const Value.absent()
          : Value(clientFeaturesConfig),
      initialSetupSkipped: Value(initialSetupSkipped),
    );
  }

  factory AccountData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AccountData(
      id: serializer.fromJson<int>(json['id']),
      uuidAccountId: serializer.fromJson<api.AccountId?>(json['uuidAccountId']),
      jsonAccountState:
          serializer.fromJson<JsonString?>(json['jsonAccountState']),
      jsonPermissions:
          serializer.fromJson<JsonString?>(json['jsonPermissions']),
      jsonProfileVisibility:
          serializer.fromJson<EnumString?>(json['jsonProfileVisibility']),
      profileFilterFavorites:
          serializer.fromJson<bool>(json['profileFilterFavorites']),
      profileIteratorSessionId:
          serializer.fromJson<api.ProfileIteratorSessionId?>(
              json['profileIteratorSessionId']),
      automatiProfileSearchIteratorSessionId:
          serializer.fromJson<api.AutomaticProfileSearchIteratorSessionId?>(
              json['automatiProfileSearchIteratorSessionId']),
      receivedLikesIteratorSessionId:
          serializer.fromJson<api.ReceivedLikesIteratorSessionId?>(
              json['receivedLikesIteratorSessionId']),
      matchesIteratorSessionId:
          serializer.fromJson<api.MatchesIteratorSessionId?>(
              json['matchesIteratorSessionId']),
      clientId: serializer.fromJson<api.ClientId?>(json['clientId']),
      jsonAvailableProfileAttributesOrderMode: serializer.fromJson<EnumString?>(
          json['jsonAvailableProfileAttributesOrderMode']),
      initialSyncDoneLoginRepository:
          serializer.fromJson<bool>(json['initialSyncDoneLoginRepository']),
      initialSyncDoneAccountRepository:
          serializer.fromJson<bool>(json['initialSyncDoneAccountRepository']),
      initialSyncDoneMediaRepository:
          serializer.fromJson<bool>(json['initialSyncDoneMediaRepository']),
      initialSyncDoneProfileRepository:
          serializer.fromJson<bool>(json['initialSyncDoneProfileRepository']),
      initialSyncDoneChatRepository:
          serializer.fromJson<bool>(json['initialSyncDoneChatRepository']),
      syncVersionAccount: serializer.fromJson<int?>(json['syncVersionAccount']),
      syncVersionProfile: serializer.fromJson<int?>(json['syncVersionProfile']),
      syncVersionMediaContent:
          serializer.fromJson<int?>(json['syncVersionMediaContent']),
      syncVersionClientConfig:
          serializer.fromJson<int?>(json['syncVersionClientConfig']),
      primaryContentGridCropSize:
          serializer.fromJson<double?>(json['primaryContentGridCropSize']),
      primaryContentGridCropX:
          serializer.fromJson<double?>(json['primaryContentGridCropX']),
      primaryContentGridCropY:
          serializer.fromJson<double?>(json['primaryContentGridCropY']),
      profileContentVersion: serializer
          .fromJson<api.ProfileContentVersion?>(json['profileContentVersion']),
      profileName: serializer.fromJson<String?>(json['profileName']),
      profileNameAccepted:
          serializer.fromJson<bool?>(json['profileNameAccepted']),
      profileNameModerationState:
          serializer.fromJson<EnumString?>(json['profileNameModerationState']),
      profileText: serializer.fromJson<String?>(json['profileText']),
      profileTextAccepted:
          serializer.fromJson<bool?>(json['profileTextAccepted']),
      profileTextModerationState:
          serializer.fromJson<EnumString?>(json['profileTextModerationState']),
      profileTextModerationRejectedCategory:
          serializer.fromJson<api.ProfileTextModerationRejectedReasonCategory?>(
              json['profileTextModerationRejectedCategory']),
      profileTextModerationRejectedDetails:
          serializer.fromJson<api.ProfileTextModerationRejectedReasonDetails?>(
              json['profileTextModerationRejectedDetails']),
      profileAge: serializer.fromJson<int?>(json['profileAge']),
      profileUnlimitedLikes:
          serializer.fromJson<bool?>(json['profileUnlimitedLikes']),
      profileVersion:
          serializer.fromJson<api.ProfileVersion?>(json['profileVersion']),
      jsonProfileAttributes:
          serializer.fromJson<JsonList?>(json['jsonProfileAttributes']),
      profileLocationLatitude:
          serializer.fromJson<double?>(json['profileLocationLatitude']),
      profileLocationLongitude:
          serializer.fromJson<double?>(json['profileLocationLongitude']),
      jsonSearchGroups:
          serializer.fromJson<JsonString?>(json['jsonSearchGroups']),
      jsonProfileFilteringSettings: serializer
          .fromJson<JsonString?>(json['jsonProfileFilteringSettings']),
      profileSearchAgeRangeMin:
          serializer.fromJson<int?>(json['profileSearchAgeRangeMin']),
      profileSearchAgeRangeMax:
          serializer.fromJson<int?>(json['profileSearchAgeRangeMax']),
      accountEmailAddress:
          serializer.fromJson<String?>(json['accountEmailAddress']),
      refreshTokenAccount:
          serializer.fromJson<String?>(json['refreshTokenAccount']),
      refreshTokenMedia:
          serializer.fromJson<String?>(json['refreshTokenMedia']),
      refreshTokenProfile:
          serializer.fromJson<String?>(json['refreshTokenProfile']),
      refreshTokenChat: serializer.fromJson<String?>(json['refreshTokenChat']),
      accessTokenAccount:
          serializer.fromJson<String?>(json['accessTokenAccount']),
      accessTokenMedia: serializer.fromJson<String?>(json['accessTokenMedia']),
      accessTokenProfile:
          serializer.fromJson<String?>(json['accessTokenProfile']),
      accessTokenChat: serializer.fromJson<String?>(json['accessTokenChat']),
      localImageSettingImageCacheMaxBytes: serializer
          .fromJson<int?>(json['localImageSettingImageCacheMaxBytes']),
      localImageSettingCacheFullSizedImages: serializer
          .fromJson<bool?>(json['localImageSettingCacheFullSizedImages']),
      localImageSettingImageCacheDownscalingSize: serializer
          .fromJson<int?>(json['localImageSettingImageCacheDownscalingSize']),
      privateKeyData:
          serializer.fromJson<PrivateKeyData?>(json['privateKeyData']),
      publicKeyData: serializer.fromJson<PublicKeyData?>(json['publicKeyData']),
      publicKeyId: serializer.fromJson<api.PublicKeyId?>(json['publicKeyId']),
      profileInitialAgeSetUnixTime: serializer
          .fromJson<UtcDateTime?>(json['profileInitialAgeSetUnixTime']),
      profileInitialAge: serializer.fromJson<int?>(json['profileInitialAge']),
      serverMaintenanceUnixTime:
          serializer.fromJson<UtcDateTime?>(json['serverMaintenanceUnixTime']),
      serverMaintenanceUnixTimeViewed: serializer
          .fromJson<UtcDateTime?>(json['serverMaintenanceUnixTimeViewed']),
      customReportsFileHash: serializer
          .fromJson<api.CustomReportsFileHash?>(json['customReportsFileHash']),
      customReportsConfig:
          serializer.fromJson<JsonString?>(json['customReportsConfig']),
      clientFeaturesFileHash: serializer.fromJson<api.ClientFeaturesFileHash?>(
          json['clientFeaturesFileHash']),
      clientFeaturesConfig:
          serializer.fromJson<JsonString?>(json['clientFeaturesConfig']),
      initialSetupSkipped:
          serializer.fromJson<bool>(json['initialSetupSkipped']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uuidAccountId': serializer.toJson<api.AccountId?>(uuidAccountId),
      'jsonAccountState': serializer.toJson<JsonString?>(jsonAccountState),
      'jsonPermissions': serializer.toJson<JsonString?>(jsonPermissions),
      'jsonProfileVisibility':
          serializer.toJson<EnumString?>(jsonProfileVisibility),
      'profileFilterFavorites': serializer.toJson<bool>(profileFilterFavorites),
      'profileIteratorSessionId': serializer
          .toJson<api.ProfileIteratorSessionId?>(profileIteratorSessionId),
      'automatiProfileSearchIteratorSessionId':
          serializer.toJson<api.AutomaticProfileSearchIteratorSessionId?>(
              automatiProfileSearchIteratorSessionId),
      'receivedLikesIteratorSessionId':
          serializer.toJson<api.ReceivedLikesIteratorSessionId?>(
              receivedLikesIteratorSessionId),
      'matchesIteratorSessionId': serializer
          .toJson<api.MatchesIteratorSessionId?>(matchesIteratorSessionId),
      'clientId': serializer.toJson<api.ClientId?>(clientId),
      'jsonAvailableProfileAttributesOrderMode': serializer
          .toJson<EnumString?>(jsonAvailableProfileAttributesOrderMode),
      'initialSyncDoneLoginRepository':
          serializer.toJson<bool>(initialSyncDoneLoginRepository),
      'initialSyncDoneAccountRepository':
          serializer.toJson<bool>(initialSyncDoneAccountRepository),
      'initialSyncDoneMediaRepository':
          serializer.toJson<bool>(initialSyncDoneMediaRepository),
      'initialSyncDoneProfileRepository':
          serializer.toJson<bool>(initialSyncDoneProfileRepository),
      'initialSyncDoneChatRepository':
          serializer.toJson<bool>(initialSyncDoneChatRepository),
      'syncVersionAccount': serializer.toJson<int?>(syncVersionAccount),
      'syncVersionProfile': serializer.toJson<int?>(syncVersionProfile),
      'syncVersionMediaContent':
          serializer.toJson<int?>(syncVersionMediaContent),
      'syncVersionClientConfig':
          serializer.toJson<int?>(syncVersionClientConfig),
      'primaryContentGridCropSize':
          serializer.toJson<double?>(primaryContentGridCropSize),
      'primaryContentGridCropX':
          serializer.toJson<double?>(primaryContentGridCropX),
      'primaryContentGridCropY':
          serializer.toJson<double?>(primaryContentGridCropY),
      'profileContentVersion':
          serializer.toJson<api.ProfileContentVersion?>(profileContentVersion),
      'profileName': serializer.toJson<String?>(profileName),
      'profileNameAccepted': serializer.toJson<bool?>(profileNameAccepted),
      'profileNameModerationState':
          serializer.toJson<EnumString?>(profileNameModerationState),
      'profileText': serializer.toJson<String?>(profileText),
      'profileTextAccepted': serializer.toJson<bool?>(profileTextAccepted),
      'profileTextModerationState':
          serializer.toJson<EnumString?>(profileTextModerationState),
      'profileTextModerationRejectedCategory':
          serializer.toJson<api.ProfileTextModerationRejectedReasonCategory?>(
              profileTextModerationRejectedCategory),
      'profileTextModerationRejectedDetails':
          serializer.toJson<api.ProfileTextModerationRejectedReasonDetails?>(
              profileTextModerationRejectedDetails),
      'profileAge': serializer.toJson<int?>(profileAge),
      'profileUnlimitedLikes': serializer.toJson<bool?>(profileUnlimitedLikes),
      'profileVersion': serializer.toJson<api.ProfileVersion?>(profileVersion),
      'jsonProfileAttributes':
          serializer.toJson<JsonList?>(jsonProfileAttributes),
      'profileLocationLatitude':
          serializer.toJson<double?>(profileLocationLatitude),
      'profileLocationLongitude':
          serializer.toJson<double?>(profileLocationLongitude),
      'jsonSearchGroups': serializer.toJson<JsonString?>(jsonSearchGroups),
      'jsonProfileFilteringSettings':
          serializer.toJson<JsonString?>(jsonProfileFilteringSettings),
      'profileSearchAgeRangeMin':
          serializer.toJson<int?>(profileSearchAgeRangeMin),
      'profileSearchAgeRangeMax':
          serializer.toJson<int?>(profileSearchAgeRangeMax),
      'accountEmailAddress': serializer.toJson<String?>(accountEmailAddress),
      'refreshTokenAccount': serializer.toJson<String?>(refreshTokenAccount),
      'refreshTokenMedia': serializer.toJson<String?>(refreshTokenMedia),
      'refreshTokenProfile': serializer.toJson<String?>(refreshTokenProfile),
      'refreshTokenChat': serializer.toJson<String?>(refreshTokenChat),
      'accessTokenAccount': serializer.toJson<String?>(accessTokenAccount),
      'accessTokenMedia': serializer.toJson<String?>(accessTokenMedia),
      'accessTokenProfile': serializer.toJson<String?>(accessTokenProfile),
      'accessTokenChat': serializer.toJson<String?>(accessTokenChat),
      'localImageSettingImageCacheMaxBytes':
          serializer.toJson<int?>(localImageSettingImageCacheMaxBytes),
      'localImageSettingCacheFullSizedImages':
          serializer.toJson<bool?>(localImageSettingCacheFullSizedImages),
      'localImageSettingImageCacheDownscalingSize':
          serializer.toJson<int?>(localImageSettingImageCacheDownscalingSize),
      'privateKeyData': serializer.toJson<PrivateKeyData?>(privateKeyData),
      'publicKeyData': serializer.toJson<PublicKeyData?>(publicKeyData),
      'publicKeyId': serializer.toJson<api.PublicKeyId?>(publicKeyId),
      'profileInitialAgeSetUnixTime':
          serializer.toJson<UtcDateTime?>(profileInitialAgeSetUnixTime),
      'profileInitialAge': serializer.toJson<int?>(profileInitialAge),
      'serverMaintenanceUnixTime':
          serializer.toJson<UtcDateTime?>(serverMaintenanceUnixTime),
      'serverMaintenanceUnixTimeViewed':
          serializer.toJson<UtcDateTime?>(serverMaintenanceUnixTimeViewed),
      'customReportsFileHash':
          serializer.toJson<api.CustomReportsFileHash?>(customReportsFileHash),
      'customReportsConfig':
          serializer.toJson<JsonString?>(customReportsConfig),
      'clientFeaturesFileHash': serializer
          .toJson<api.ClientFeaturesFileHash?>(clientFeaturesFileHash),
      'clientFeaturesConfig':
          serializer.toJson<JsonString?>(clientFeaturesConfig),
      'initialSetupSkipped': serializer.toJson<bool>(initialSetupSkipped),
    };
  }

  AccountData copyWith(
          {int? id,
          Value<api.AccountId?> uuidAccountId = const Value.absent(),
          Value<JsonString?> jsonAccountState = const Value.absent(),
          Value<JsonString?> jsonPermissions = const Value.absent(),
          Value<EnumString?> jsonProfileVisibility = const Value.absent(),
          bool? profileFilterFavorites,
          Value<api.ProfileIteratorSessionId?> profileIteratorSessionId =
              const Value.absent(),
          Value<api.AutomaticProfileSearchIteratorSessionId?>
              automatiProfileSearchIteratorSessionId = const Value.absent(),
          Value<api.ReceivedLikesIteratorSessionId?> receivedLikesIteratorSessionId =
              const Value.absent(),
          Value<api.MatchesIteratorSessionId?> matchesIteratorSessionId =
              const Value.absent(),
          Value<api.ClientId?> clientId = const Value.absent(),
          Value<EnumString?> jsonAvailableProfileAttributesOrderMode =
              const Value.absent(),
          bool? initialSyncDoneLoginRepository,
          bool? initialSyncDoneAccountRepository,
          bool? initialSyncDoneMediaRepository,
          bool? initialSyncDoneProfileRepository,
          bool? initialSyncDoneChatRepository,
          Value<int?> syncVersionAccount = const Value.absent(),
          Value<int?> syncVersionProfile = const Value.absent(),
          Value<int?> syncVersionMediaContent = const Value.absent(),
          Value<int?> syncVersionClientConfig = const Value.absent(),
          Value<double?> primaryContentGridCropSize = const Value.absent(),
          Value<double?> primaryContentGridCropX = const Value.absent(),
          Value<double?> primaryContentGridCropY = const Value.absent(),
          Value<api.ProfileContentVersion?> profileContentVersion =
              const Value.absent(),
          Value<String?> profileName = const Value.absent(),
          Value<bool?> profileNameAccepted = const Value.absent(),
          Value<EnumString?> profileNameModerationState = const Value.absent(),
          Value<String?> profileText = const Value.absent(),
          Value<bool?> profileTextAccepted = const Value.absent(),
          Value<EnumString?> profileTextModerationState = const Value.absent(),
          Value<api.ProfileTextModerationRejectedReasonCategory?>
              profileTextModerationRejectedCategory = const Value.absent(),
          Value<api.ProfileTextModerationRejectedReasonDetails?>
              profileTextModerationRejectedDetails = const Value.absent(),
          Value<int?> profileAge = const Value.absent(),
          Value<bool?> profileUnlimitedLikes = const Value.absent(),
          Value<api.ProfileVersion?> profileVersion = const Value.absent(),
          Value<JsonList?> jsonProfileAttributes = const Value.absent(),
          Value<double?> profileLocationLatitude = const Value.absent(),
          Value<double?> profileLocationLongitude = const Value.absent(),
          Value<JsonString?> jsonSearchGroups = const Value.absent(),
          Value<JsonString?> jsonProfileFilteringSettings =
              const Value.absent(),
          Value<int?> profileSearchAgeRangeMin = const Value.absent(),
          Value<int?> profileSearchAgeRangeMax = const Value.absent(),
          Value<String?> accountEmailAddress = const Value.absent(),
          Value<String?> refreshTokenAccount = const Value.absent(),
          Value<String?> refreshTokenMedia = const Value.absent(),
          Value<String?> refreshTokenProfile = const Value.absent(),
          Value<String?> refreshTokenChat = const Value.absent(),
          Value<String?> accessTokenAccount = const Value.absent(),
          Value<String?> accessTokenMedia = const Value.absent(),
          Value<String?> accessTokenProfile = const Value.absent(),
          Value<String?> accessTokenChat = const Value.absent(),
          Value<int?> localImageSettingImageCacheMaxBytes =
              const Value.absent(),
          Value<bool?> localImageSettingCacheFullSizedImages =
              const Value.absent(),
          Value<int?> localImageSettingImageCacheDownscalingSize =
              const Value.absent(),
          Value<PrivateKeyData?> privateKeyData = const Value.absent(),
          Value<PublicKeyData?> publicKeyData = const Value.absent(),
          Value<api.PublicKeyId?> publicKeyId = const Value.absent(),
          Value<UtcDateTime?> profileInitialAgeSetUnixTime =
              const Value.absent(),
          Value<int?> profileInitialAge = const Value.absent(),
          Value<UtcDateTime?> serverMaintenanceUnixTime = const Value.absent(),
          Value<UtcDateTime?> serverMaintenanceUnixTimeViewed =
              const Value.absent(),
          Value<api.CustomReportsFileHash?> customReportsFileHash =
              const Value.absent(),
          Value<JsonString?> customReportsConfig = const Value.absent(),
          Value<api.ClientFeaturesFileHash?> clientFeaturesFileHash = const Value.absent(),
          Value<JsonString?> clientFeaturesConfig = const Value.absent(),
          bool? initialSetupSkipped}) =>
      AccountData(
        id: id ?? this.id,
        uuidAccountId:
            uuidAccountId.present ? uuidAccountId.value : this.uuidAccountId,
        jsonAccountState: jsonAccountState.present
            ? jsonAccountState.value
            : this.jsonAccountState,
        jsonPermissions: jsonPermissions.present
            ? jsonPermissions.value
            : this.jsonPermissions,
        jsonProfileVisibility: jsonProfileVisibility.present
            ? jsonProfileVisibility.value
            : this.jsonProfileVisibility,
        profileFilterFavorites:
            profileFilterFavorites ?? this.profileFilterFavorites,
        profileIteratorSessionId: profileIteratorSessionId.present
            ? profileIteratorSessionId.value
            : this.profileIteratorSessionId,
        automatiProfileSearchIteratorSessionId:
            automatiProfileSearchIteratorSessionId.present
                ? automatiProfileSearchIteratorSessionId.value
                : this.automatiProfileSearchIteratorSessionId,
        receivedLikesIteratorSessionId: receivedLikesIteratorSessionId.present
            ? receivedLikesIteratorSessionId.value
            : this.receivedLikesIteratorSessionId,
        matchesIteratorSessionId: matchesIteratorSessionId.present
            ? matchesIteratorSessionId.value
            : this.matchesIteratorSessionId,
        clientId: clientId.present ? clientId.value : this.clientId,
        jsonAvailableProfileAttributesOrderMode:
            jsonAvailableProfileAttributesOrderMode.present
                ? jsonAvailableProfileAttributesOrderMode.value
                : this.jsonAvailableProfileAttributesOrderMode,
        initialSyncDoneLoginRepository: initialSyncDoneLoginRepository ??
            this.initialSyncDoneLoginRepository,
        initialSyncDoneAccountRepository: initialSyncDoneAccountRepository ??
            this.initialSyncDoneAccountRepository,
        initialSyncDoneMediaRepository: initialSyncDoneMediaRepository ??
            this.initialSyncDoneMediaRepository,
        initialSyncDoneProfileRepository: initialSyncDoneProfileRepository ??
            this.initialSyncDoneProfileRepository,
        initialSyncDoneChatRepository:
            initialSyncDoneChatRepository ?? this.initialSyncDoneChatRepository,
        syncVersionAccount: syncVersionAccount.present
            ? syncVersionAccount.value
            : this.syncVersionAccount,
        syncVersionProfile: syncVersionProfile.present
            ? syncVersionProfile.value
            : this.syncVersionProfile,
        syncVersionMediaContent: syncVersionMediaContent.present
            ? syncVersionMediaContent.value
            : this.syncVersionMediaContent,
        syncVersionClientConfig: syncVersionClientConfig.present
            ? syncVersionClientConfig.value
            : this.syncVersionClientConfig,
        primaryContentGridCropSize: primaryContentGridCropSize.present
            ? primaryContentGridCropSize.value
            : this.primaryContentGridCropSize,
        primaryContentGridCropX: primaryContentGridCropX.present
            ? primaryContentGridCropX.value
            : this.primaryContentGridCropX,
        primaryContentGridCropY: primaryContentGridCropY.present
            ? primaryContentGridCropY.value
            : this.primaryContentGridCropY,
        profileContentVersion: profileContentVersion.present
            ? profileContentVersion.value
            : this.profileContentVersion,
        profileName: profileName.present ? profileName.value : this.profileName,
        profileNameAccepted: profileNameAccepted.present
            ? profileNameAccepted.value
            : this.profileNameAccepted,
        profileNameModerationState: profileNameModerationState.present
            ? profileNameModerationState.value
            : this.profileNameModerationState,
        profileText: profileText.present ? profileText.value : this.profileText,
        profileTextAccepted: profileTextAccepted.present
            ? profileTextAccepted.value
            : this.profileTextAccepted,
        profileTextModerationState: profileTextModerationState.present
            ? profileTextModerationState.value
            : this.profileTextModerationState,
        profileTextModerationRejectedCategory:
            profileTextModerationRejectedCategory.present
                ? profileTextModerationRejectedCategory.value
                : this.profileTextModerationRejectedCategory,
        profileTextModerationRejectedDetails:
            profileTextModerationRejectedDetails.present
                ? profileTextModerationRejectedDetails.value
                : this.profileTextModerationRejectedDetails,
        profileAge: profileAge.present ? profileAge.value : this.profileAge,
        profileUnlimitedLikes: profileUnlimitedLikes.present
            ? profileUnlimitedLikes.value
            : this.profileUnlimitedLikes,
        profileVersion:
            profileVersion.present ? profileVersion.value : this.profileVersion,
        jsonProfileAttributes: jsonProfileAttributes.present
            ? jsonProfileAttributes.value
            : this.jsonProfileAttributes,
        profileLocationLatitude: profileLocationLatitude.present
            ? profileLocationLatitude.value
            : this.profileLocationLatitude,
        profileLocationLongitude: profileLocationLongitude.present
            ? profileLocationLongitude.value
            : this.profileLocationLongitude,
        jsonSearchGroups: jsonSearchGroups.present
            ? jsonSearchGroups.value
            : this.jsonSearchGroups,
        jsonProfileFilteringSettings: jsonProfileFilteringSettings.present
            ? jsonProfileFilteringSettings.value
            : this.jsonProfileFilteringSettings,
        profileSearchAgeRangeMin: profileSearchAgeRangeMin.present
            ? profileSearchAgeRangeMin.value
            : this.profileSearchAgeRangeMin,
        profileSearchAgeRangeMax: profileSearchAgeRangeMax.present
            ? profileSearchAgeRangeMax.value
            : this.profileSearchAgeRangeMax,
        accountEmailAddress: accountEmailAddress.present
            ? accountEmailAddress.value
            : this.accountEmailAddress,
        refreshTokenAccount: refreshTokenAccount.present
            ? refreshTokenAccount.value
            : this.refreshTokenAccount,
        refreshTokenMedia: refreshTokenMedia.present
            ? refreshTokenMedia.value
            : this.refreshTokenMedia,
        refreshTokenProfile: refreshTokenProfile.present
            ? refreshTokenProfile.value
            : this.refreshTokenProfile,
        refreshTokenChat: refreshTokenChat.present
            ? refreshTokenChat.value
            : this.refreshTokenChat,
        accessTokenAccount: accessTokenAccount.present
            ? accessTokenAccount.value
            : this.accessTokenAccount,
        accessTokenMedia: accessTokenMedia.present
            ? accessTokenMedia.value
            : this.accessTokenMedia,
        accessTokenProfile: accessTokenProfile.present
            ? accessTokenProfile.value
            : this.accessTokenProfile,
        accessTokenChat: accessTokenChat.present
            ? accessTokenChat.value
            : this.accessTokenChat,
        localImageSettingImageCacheMaxBytes:
            localImageSettingImageCacheMaxBytes.present
                ? localImageSettingImageCacheMaxBytes.value
                : this.localImageSettingImageCacheMaxBytes,
        localImageSettingCacheFullSizedImages:
            localImageSettingCacheFullSizedImages.present
                ? localImageSettingCacheFullSizedImages.value
                : this.localImageSettingCacheFullSizedImages,
        localImageSettingImageCacheDownscalingSize:
            localImageSettingImageCacheDownscalingSize.present
                ? localImageSettingImageCacheDownscalingSize.value
                : this.localImageSettingImageCacheDownscalingSize,
        privateKeyData:
            privateKeyData.present ? privateKeyData.value : this.privateKeyData,
        publicKeyData:
            publicKeyData.present ? publicKeyData.value : this.publicKeyData,
        publicKeyId: publicKeyId.present ? publicKeyId.value : this.publicKeyId,
        profileInitialAgeSetUnixTime: profileInitialAgeSetUnixTime.present
            ? profileInitialAgeSetUnixTime.value
            : this.profileInitialAgeSetUnixTime,
        profileInitialAge: profileInitialAge.present
            ? profileInitialAge.value
            : this.profileInitialAge,
        serverMaintenanceUnixTime: serverMaintenanceUnixTime.present
            ? serverMaintenanceUnixTime.value
            : this.serverMaintenanceUnixTime,
        serverMaintenanceUnixTimeViewed: serverMaintenanceUnixTimeViewed.present
            ? serverMaintenanceUnixTimeViewed.value
            : this.serverMaintenanceUnixTimeViewed,
        customReportsFileHash: customReportsFileHash.present
            ? customReportsFileHash.value
            : this.customReportsFileHash,
        customReportsConfig: customReportsConfig.present
            ? customReportsConfig.value
            : this.customReportsConfig,
        clientFeaturesFileHash: clientFeaturesFileHash.present
            ? clientFeaturesFileHash.value
            : this.clientFeaturesFileHash,
        clientFeaturesConfig: clientFeaturesConfig.present
            ? clientFeaturesConfig.value
            : this.clientFeaturesConfig,
        initialSetupSkipped: initialSetupSkipped ?? this.initialSetupSkipped,
      );
  AccountData copyWithCompanion(AccountCompanion data) {
    return AccountData(
      id: data.id.present ? data.id.value : this.id,
      uuidAccountId: data.uuidAccountId.present
          ? data.uuidAccountId.value
          : this.uuidAccountId,
      jsonAccountState: data.jsonAccountState.present
          ? data.jsonAccountState.value
          : this.jsonAccountState,
      jsonPermissions: data.jsonPermissions.present
          ? data.jsonPermissions.value
          : this.jsonPermissions,
      jsonProfileVisibility: data.jsonProfileVisibility.present
          ? data.jsonProfileVisibility.value
          : this.jsonProfileVisibility,
      profileFilterFavorites: data.profileFilterFavorites.present
          ? data.profileFilterFavorites.value
          : this.profileFilterFavorites,
      profileIteratorSessionId: data.profileIteratorSessionId.present
          ? data.profileIteratorSessionId.value
          : this.profileIteratorSessionId,
      automatiProfileSearchIteratorSessionId:
          data.automatiProfileSearchIteratorSessionId.present
              ? data.automatiProfileSearchIteratorSessionId.value
              : this.automatiProfileSearchIteratorSessionId,
      receivedLikesIteratorSessionId:
          data.receivedLikesIteratorSessionId.present
              ? data.receivedLikesIteratorSessionId.value
              : this.receivedLikesIteratorSessionId,
      matchesIteratorSessionId: data.matchesIteratorSessionId.present
          ? data.matchesIteratorSessionId.value
          : this.matchesIteratorSessionId,
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      jsonAvailableProfileAttributesOrderMode:
          data.jsonAvailableProfileAttributesOrderMode.present
              ? data.jsonAvailableProfileAttributesOrderMode.value
              : this.jsonAvailableProfileAttributesOrderMode,
      initialSyncDoneLoginRepository:
          data.initialSyncDoneLoginRepository.present
              ? data.initialSyncDoneLoginRepository.value
              : this.initialSyncDoneLoginRepository,
      initialSyncDoneAccountRepository:
          data.initialSyncDoneAccountRepository.present
              ? data.initialSyncDoneAccountRepository.value
              : this.initialSyncDoneAccountRepository,
      initialSyncDoneMediaRepository:
          data.initialSyncDoneMediaRepository.present
              ? data.initialSyncDoneMediaRepository.value
              : this.initialSyncDoneMediaRepository,
      initialSyncDoneProfileRepository:
          data.initialSyncDoneProfileRepository.present
              ? data.initialSyncDoneProfileRepository.value
              : this.initialSyncDoneProfileRepository,
      initialSyncDoneChatRepository: data.initialSyncDoneChatRepository.present
          ? data.initialSyncDoneChatRepository.value
          : this.initialSyncDoneChatRepository,
      syncVersionAccount: data.syncVersionAccount.present
          ? data.syncVersionAccount.value
          : this.syncVersionAccount,
      syncVersionProfile: data.syncVersionProfile.present
          ? data.syncVersionProfile.value
          : this.syncVersionProfile,
      syncVersionMediaContent: data.syncVersionMediaContent.present
          ? data.syncVersionMediaContent.value
          : this.syncVersionMediaContent,
      syncVersionClientConfig: data.syncVersionClientConfig.present
          ? data.syncVersionClientConfig.value
          : this.syncVersionClientConfig,
      primaryContentGridCropSize: data.primaryContentGridCropSize.present
          ? data.primaryContentGridCropSize.value
          : this.primaryContentGridCropSize,
      primaryContentGridCropX: data.primaryContentGridCropX.present
          ? data.primaryContentGridCropX.value
          : this.primaryContentGridCropX,
      primaryContentGridCropY: data.primaryContentGridCropY.present
          ? data.primaryContentGridCropY.value
          : this.primaryContentGridCropY,
      profileContentVersion: data.profileContentVersion.present
          ? data.profileContentVersion.value
          : this.profileContentVersion,
      profileName:
          data.profileName.present ? data.profileName.value : this.profileName,
      profileNameAccepted: data.profileNameAccepted.present
          ? data.profileNameAccepted.value
          : this.profileNameAccepted,
      profileNameModerationState: data.profileNameModerationState.present
          ? data.profileNameModerationState.value
          : this.profileNameModerationState,
      profileText:
          data.profileText.present ? data.profileText.value : this.profileText,
      profileTextAccepted: data.profileTextAccepted.present
          ? data.profileTextAccepted.value
          : this.profileTextAccepted,
      profileTextModerationState: data.profileTextModerationState.present
          ? data.profileTextModerationState.value
          : this.profileTextModerationState,
      profileTextModerationRejectedCategory:
          data.profileTextModerationRejectedCategory.present
              ? data.profileTextModerationRejectedCategory.value
              : this.profileTextModerationRejectedCategory,
      profileTextModerationRejectedDetails:
          data.profileTextModerationRejectedDetails.present
              ? data.profileTextModerationRejectedDetails.value
              : this.profileTextModerationRejectedDetails,
      profileAge:
          data.profileAge.present ? data.profileAge.value : this.profileAge,
      profileUnlimitedLikes: data.profileUnlimitedLikes.present
          ? data.profileUnlimitedLikes.value
          : this.profileUnlimitedLikes,
      profileVersion: data.profileVersion.present
          ? data.profileVersion.value
          : this.profileVersion,
      jsonProfileAttributes: data.jsonProfileAttributes.present
          ? data.jsonProfileAttributes.value
          : this.jsonProfileAttributes,
      profileLocationLatitude: data.profileLocationLatitude.present
          ? data.profileLocationLatitude.value
          : this.profileLocationLatitude,
      profileLocationLongitude: data.profileLocationLongitude.present
          ? data.profileLocationLongitude.value
          : this.profileLocationLongitude,
      jsonSearchGroups: data.jsonSearchGroups.present
          ? data.jsonSearchGroups.value
          : this.jsonSearchGroups,
      jsonProfileFilteringSettings: data.jsonProfileFilteringSettings.present
          ? data.jsonProfileFilteringSettings.value
          : this.jsonProfileFilteringSettings,
      profileSearchAgeRangeMin: data.profileSearchAgeRangeMin.present
          ? data.profileSearchAgeRangeMin.value
          : this.profileSearchAgeRangeMin,
      profileSearchAgeRangeMax: data.profileSearchAgeRangeMax.present
          ? data.profileSearchAgeRangeMax.value
          : this.profileSearchAgeRangeMax,
      accountEmailAddress: data.accountEmailAddress.present
          ? data.accountEmailAddress.value
          : this.accountEmailAddress,
      refreshTokenAccount: data.refreshTokenAccount.present
          ? data.refreshTokenAccount.value
          : this.refreshTokenAccount,
      refreshTokenMedia: data.refreshTokenMedia.present
          ? data.refreshTokenMedia.value
          : this.refreshTokenMedia,
      refreshTokenProfile: data.refreshTokenProfile.present
          ? data.refreshTokenProfile.value
          : this.refreshTokenProfile,
      refreshTokenChat: data.refreshTokenChat.present
          ? data.refreshTokenChat.value
          : this.refreshTokenChat,
      accessTokenAccount: data.accessTokenAccount.present
          ? data.accessTokenAccount.value
          : this.accessTokenAccount,
      accessTokenMedia: data.accessTokenMedia.present
          ? data.accessTokenMedia.value
          : this.accessTokenMedia,
      accessTokenProfile: data.accessTokenProfile.present
          ? data.accessTokenProfile.value
          : this.accessTokenProfile,
      accessTokenChat: data.accessTokenChat.present
          ? data.accessTokenChat.value
          : this.accessTokenChat,
      localImageSettingImageCacheMaxBytes:
          data.localImageSettingImageCacheMaxBytes.present
              ? data.localImageSettingImageCacheMaxBytes.value
              : this.localImageSettingImageCacheMaxBytes,
      localImageSettingCacheFullSizedImages:
          data.localImageSettingCacheFullSizedImages.present
              ? data.localImageSettingCacheFullSizedImages.value
              : this.localImageSettingCacheFullSizedImages,
      localImageSettingImageCacheDownscalingSize:
          data.localImageSettingImageCacheDownscalingSize.present
              ? data.localImageSettingImageCacheDownscalingSize.value
              : this.localImageSettingImageCacheDownscalingSize,
      privateKeyData: data.privateKeyData.present
          ? data.privateKeyData.value
          : this.privateKeyData,
      publicKeyData: data.publicKeyData.present
          ? data.publicKeyData.value
          : this.publicKeyData,
      publicKeyId:
          data.publicKeyId.present ? data.publicKeyId.value : this.publicKeyId,
      profileInitialAgeSetUnixTime: data.profileInitialAgeSetUnixTime.present
          ? data.profileInitialAgeSetUnixTime.value
          : this.profileInitialAgeSetUnixTime,
      profileInitialAge: data.profileInitialAge.present
          ? data.profileInitialAge.value
          : this.profileInitialAge,
      serverMaintenanceUnixTime: data.serverMaintenanceUnixTime.present
          ? data.serverMaintenanceUnixTime.value
          : this.serverMaintenanceUnixTime,
      serverMaintenanceUnixTimeViewed:
          data.serverMaintenanceUnixTimeViewed.present
              ? data.serverMaintenanceUnixTimeViewed.value
              : this.serverMaintenanceUnixTimeViewed,
      customReportsFileHash: data.customReportsFileHash.present
          ? data.customReportsFileHash.value
          : this.customReportsFileHash,
      customReportsConfig: data.customReportsConfig.present
          ? data.customReportsConfig.value
          : this.customReportsConfig,
      clientFeaturesFileHash: data.clientFeaturesFileHash.present
          ? data.clientFeaturesFileHash.value
          : this.clientFeaturesFileHash,
      clientFeaturesConfig: data.clientFeaturesConfig.present
          ? data.clientFeaturesConfig.value
          : this.clientFeaturesConfig,
      initialSetupSkipped: data.initialSetupSkipped.present
          ? data.initialSetupSkipped.value
          : this.initialSetupSkipped,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AccountData(')
          ..write('id: $id, ')
          ..write('uuidAccountId: $uuidAccountId, ')
          ..write('jsonAccountState: $jsonAccountState, ')
          ..write('jsonPermissions: $jsonPermissions, ')
          ..write('jsonProfileVisibility: $jsonProfileVisibility, ')
          ..write('profileFilterFavorites: $profileFilterFavorites, ')
          ..write('profileIteratorSessionId: $profileIteratorSessionId, ')
          ..write(
              'automatiProfileSearchIteratorSessionId: $automatiProfileSearchIteratorSessionId, ')
          ..write(
              'receivedLikesIteratorSessionId: $receivedLikesIteratorSessionId, ')
          ..write('matchesIteratorSessionId: $matchesIteratorSessionId, ')
          ..write('clientId: $clientId, ')
          ..write(
              'jsonAvailableProfileAttributesOrderMode: $jsonAvailableProfileAttributesOrderMode, ')
          ..write(
              'initialSyncDoneLoginRepository: $initialSyncDoneLoginRepository, ')
          ..write(
              'initialSyncDoneAccountRepository: $initialSyncDoneAccountRepository, ')
          ..write(
              'initialSyncDoneMediaRepository: $initialSyncDoneMediaRepository, ')
          ..write(
              'initialSyncDoneProfileRepository: $initialSyncDoneProfileRepository, ')
          ..write(
              'initialSyncDoneChatRepository: $initialSyncDoneChatRepository, ')
          ..write('syncVersionAccount: $syncVersionAccount, ')
          ..write('syncVersionProfile: $syncVersionProfile, ')
          ..write('syncVersionMediaContent: $syncVersionMediaContent, ')
          ..write('syncVersionClientConfig: $syncVersionClientConfig, ')
          ..write('primaryContentGridCropSize: $primaryContentGridCropSize, ')
          ..write('primaryContentGridCropX: $primaryContentGridCropX, ')
          ..write('primaryContentGridCropY: $primaryContentGridCropY, ')
          ..write('profileContentVersion: $profileContentVersion, ')
          ..write('profileName: $profileName, ')
          ..write('profileNameAccepted: $profileNameAccepted, ')
          ..write('profileNameModerationState: $profileNameModerationState, ')
          ..write('profileText: $profileText, ')
          ..write('profileTextAccepted: $profileTextAccepted, ')
          ..write('profileTextModerationState: $profileTextModerationState, ')
          ..write(
              'profileTextModerationRejectedCategory: $profileTextModerationRejectedCategory, ')
          ..write(
              'profileTextModerationRejectedDetails: $profileTextModerationRejectedDetails, ')
          ..write('profileAge: $profileAge, ')
          ..write('profileUnlimitedLikes: $profileUnlimitedLikes, ')
          ..write('profileVersion: $profileVersion, ')
          ..write('jsonProfileAttributes: $jsonProfileAttributes, ')
          ..write('profileLocationLatitude: $profileLocationLatitude, ')
          ..write('profileLocationLongitude: $profileLocationLongitude, ')
          ..write('jsonSearchGroups: $jsonSearchGroups, ')
          ..write(
              'jsonProfileFilteringSettings: $jsonProfileFilteringSettings, ')
          ..write('profileSearchAgeRangeMin: $profileSearchAgeRangeMin, ')
          ..write('profileSearchAgeRangeMax: $profileSearchAgeRangeMax, ')
          ..write('accountEmailAddress: $accountEmailAddress, ')
          ..write('refreshTokenAccount: $refreshTokenAccount, ')
          ..write('refreshTokenMedia: $refreshTokenMedia, ')
          ..write('refreshTokenProfile: $refreshTokenProfile, ')
          ..write('refreshTokenChat: $refreshTokenChat, ')
          ..write('accessTokenAccount: $accessTokenAccount, ')
          ..write('accessTokenMedia: $accessTokenMedia, ')
          ..write('accessTokenProfile: $accessTokenProfile, ')
          ..write('accessTokenChat: $accessTokenChat, ')
          ..write(
              'localImageSettingImageCacheMaxBytes: $localImageSettingImageCacheMaxBytes, ')
          ..write(
              'localImageSettingCacheFullSizedImages: $localImageSettingCacheFullSizedImages, ')
          ..write(
              'localImageSettingImageCacheDownscalingSize: $localImageSettingImageCacheDownscalingSize, ')
          ..write('privateKeyData: $privateKeyData, ')
          ..write('publicKeyData: $publicKeyData, ')
          ..write('publicKeyId: $publicKeyId, ')
          ..write(
              'profileInitialAgeSetUnixTime: $profileInitialAgeSetUnixTime, ')
          ..write('profileInitialAge: $profileInitialAge, ')
          ..write('serverMaintenanceUnixTime: $serverMaintenanceUnixTime, ')
          ..write(
              'serverMaintenanceUnixTimeViewed: $serverMaintenanceUnixTimeViewed, ')
          ..write('customReportsFileHash: $customReportsFileHash, ')
          ..write('customReportsConfig: $customReportsConfig, ')
          ..write('clientFeaturesFileHash: $clientFeaturesFileHash, ')
          ..write('clientFeaturesConfig: $clientFeaturesConfig, ')
          ..write('initialSetupSkipped: $initialSetupSkipped')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        id,
        uuidAccountId,
        jsonAccountState,
        jsonPermissions,
        jsonProfileVisibility,
        profileFilterFavorites,
        profileIteratorSessionId,
        automatiProfileSearchIteratorSessionId,
        receivedLikesIteratorSessionId,
        matchesIteratorSessionId,
        clientId,
        jsonAvailableProfileAttributesOrderMode,
        initialSyncDoneLoginRepository,
        initialSyncDoneAccountRepository,
        initialSyncDoneMediaRepository,
        initialSyncDoneProfileRepository,
        initialSyncDoneChatRepository,
        syncVersionAccount,
        syncVersionProfile,
        syncVersionMediaContent,
        syncVersionClientConfig,
        primaryContentGridCropSize,
        primaryContentGridCropX,
        primaryContentGridCropY,
        profileContentVersion,
        profileName,
        profileNameAccepted,
        profileNameModerationState,
        profileText,
        profileTextAccepted,
        profileTextModerationState,
        profileTextModerationRejectedCategory,
        profileTextModerationRejectedDetails,
        profileAge,
        profileUnlimitedLikes,
        profileVersion,
        jsonProfileAttributes,
        profileLocationLatitude,
        profileLocationLongitude,
        jsonSearchGroups,
        jsonProfileFilteringSettings,
        profileSearchAgeRangeMin,
        profileSearchAgeRangeMax,
        accountEmailAddress,
        refreshTokenAccount,
        refreshTokenMedia,
        refreshTokenProfile,
        refreshTokenChat,
        accessTokenAccount,
        accessTokenMedia,
        accessTokenProfile,
        accessTokenChat,
        localImageSettingImageCacheMaxBytes,
        localImageSettingCacheFullSizedImages,
        localImageSettingImageCacheDownscalingSize,
        privateKeyData,
        publicKeyData,
        publicKeyId,
        profileInitialAgeSetUnixTime,
        profileInitialAge,
        serverMaintenanceUnixTime,
        serverMaintenanceUnixTimeViewed,
        customReportsFileHash,
        customReportsConfig,
        clientFeaturesFileHash,
        clientFeaturesConfig,
        initialSetupSkipped
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AccountData &&
          other.id == this.id &&
          other.uuidAccountId == this.uuidAccountId &&
          other.jsonAccountState == this.jsonAccountState &&
          other.jsonPermissions == this.jsonPermissions &&
          other.jsonProfileVisibility == this.jsonProfileVisibility &&
          other.profileFilterFavorites == this.profileFilterFavorites &&
          other.profileIteratorSessionId == this.profileIteratorSessionId &&
          other.automatiProfileSearchIteratorSessionId ==
              this.automatiProfileSearchIteratorSessionId &&
          other.receivedLikesIteratorSessionId ==
              this.receivedLikesIteratorSessionId &&
          other.matchesIteratorSessionId == this.matchesIteratorSessionId &&
          other.clientId == this.clientId &&
          other.jsonAvailableProfileAttributesOrderMode ==
              this.jsonAvailableProfileAttributesOrderMode &&
          other.initialSyncDoneLoginRepository ==
              this.initialSyncDoneLoginRepository &&
          other.initialSyncDoneAccountRepository ==
              this.initialSyncDoneAccountRepository &&
          other.initialSyncDoneMediaRepository ==
              this.initialSyncDoneMediaRepository &&
          other.initialSyncDoneProfileRepository ==
              this.initialSyncDoneProfileRepository &&
          other.initialSyncDoneChatRepository ==
              this.initialSyncDoneChatRepository &&
          other.syncVersionAccount == this.syncVersionAccount &&
          other.syncVersionProfile == this.syncVersionProfile &&
          other.syncVersionMediaContent == this.syncVersionMediaContent &&
          other.syncVersionClientConfig == this.syncVersionClientConfig &&
          other.primaryContentGridCropSize == this.primaryContentGridCropSize &&
          other.primaryContentGridCropX == this.primaryContentGridCropX &&
          other.primaryContentGridCropY == this.primaryContentGridCropY &&
          other.profileContentVersion == this.profileContentVersion &&
          other.profileName == this.profileName &&
          other.profileNameAccepted == this.profileNameAccepted &&
          other.profileNameModerationState == this.profileNameModerationState &&
          other.profileText == this.profileText &&
          other.profileTextAccepted == this.profileTextAccepted &&
          other.profileTextModerationState == this.profileTextModerationState &&
          other.profileTextModerationRejectedCategory ==
              this.profileTextModerationRejectedCategory &&
          other.profileTextModerationRejectedDetails ==
              this.profileTextModerationRejectedDetails &&
          other.profileAge == this.profileAge &&
          other.profileUnlimitedLikes == this.profileUnlimitedLikes &&
          other.profileVersion == this.profileVersion &&
          other.jsonProfileAttributes == this.jsonProfileAttributes &&
          other.profileLocationLatitude == this.profileLocationLatitude &&
          other.profileLocationLongitude == this.profileLocationLongitude &&
          other.jsonSearchGroups == this.jsonSearchGroups &&
          other.jsonProfileFilteringSettings ==
              this.jsonProfileFilteringSettings &&
          other.profileSearchAgeRangeMin == this.profileSearchAgeRangeMin &&
          other.profileSearchAgeRangeMax == this.profileSearchAgeRangeMax &&
          other.accountEmailAddress == this.accountEmailAddress &&
          other.refreshTokenAccount == this.refreshTokenAccount &&
          other.refreshTokenMedia == this.refreshTokenMedia &&
          other.refreshTokenProfile == this.refreshTokenProfile &&
          other.refreshTokenChat == this.refreshTokenChat &&
          other.accessTokenAccount == this.accessTokenAccount &&
          other.accessTokenMedia == this.accessTokenMedia &&
          other.accessTokenProfile == this.accessTokenProfile &&
          other.accessTokenChat == this.accessTokenChat &&
          other.localImageSettingImageCacheMaxBytes ==
              this.localImageSettingImageCacheMaxBytes &&
          other.localImageSettingCacheFullSizedImages ==
              this.localImageSettingCacheFullSizedImages &&
          other.localImageSettingImageCacheDownscalingSize ==
              this.localImageSettingImageCacheDownscalingSize &&
          other.privateKeyData == this.privateKeyData &&
          other.publicKeyData == this.publicKeyData &&
          other.publicKeyId == this.publicKeyId &&
          other.profileInitialAgeSetUnixTime ==
              this.profileInitialAgeSetUnixTime &&
          other.profileInitialAge == this.profileInitialAge &&
          other.serverMaintenanceUnixTime == this.serverMaintenanceUnixTime &&
          other.serverMaintenanceUnixTimeViewed ==
              this.serverMaintenanceUnixTimeViewed &&
          other.customReportsFileHash == this.customReportsFileHash &&
          other.customReportsConfig == this.customReportsConfig &&
          other.clientFeaturesFileHash == this.clientFeaturesFileHash &&
          other.clientFeaturesConfig == this.clientFeaturesConfig &&
          other.initialSetupSkipped == this.initialSetupSkipped);
}

class AccountCompanion extends UpdateCompanion<AccountData> {
  final Value<int> id;
  final Value<api.AccountId?> uuidAccountId;
  final Value<JsonString?> jsonAccountState;
  final Value<JsonString?> jsonPermissions;
  final Value<EnumString?> jsonProfileVisibility;
  final Value<bool> profileFilterFavorites;
  final Value<api.ProfileIteratorSessionId?> profileIteratorSessionId;
  final Value<api.AutomaticProfileSearchIteratorSessionId?>
      automatiProfileSearchIteratorSessionId;
  final Value<api.ReceivedLikesIteratorSessionId?>
      receivedLikesIteratorSessionId;
  final Value<api.MatchesIteratorSessionId?> matchesIteratorSessionId;
  final Value<api.ClientId?> clientId;
  final Value<EnumString?> jsonAvailableProfileAttributesOrderMode;
  final Value<bool> initialSyncDoneLoginRepository;
  final Value<bool> initialSyncDoneAccountRepository;
  final Value<bool> initialSyncDoneMediaRepository;
  final Value<bool> initialSyncDoneProfileRepository;
  final Value<bool> initialSyncDoneChatRepository;
  final Value<int?> syncVersionAccount;
  final Value<int?> syncVersionProfile;
  final Value<int?> syncVersionMediaContent;
  final Value<int?> syncVersionClientConfig;
  final Value<double?> primaryContentGridCropSize;
  final Value<double?> primaryContentGridCropX;
  final Value<double?> primaryContentGridCropY;
  final Value<api.ProfileContentVersion?> profileContentVersion;
  final Value<String?> profileName;
  final Value<bool?> profileNameAccepted;
  final Value<EnumString?> profileNameModerationState;
  final Value<String?> profileText;
  final Value<bool?> profileTextAccepted;
  final Value<EnumString?> profileTextModerationState;
  final Value<api.ProfileTextModerationRejectedReasonCategory?>
      profileTextModerationRejectedCategory;
  final Value<api.ProfileTextModerationRejectedReasonDetails?>
      profileTextModerationRejectedDetails;
  final Value<int?> profileAge;
  final Value<bool?> profileUnlimitedLikes;
  final Value<api.ProfileVersion?> profileVersion;
  final Value<JsonList?> jsonProfileAttributes;
  final Value<double?> profileLocationLatitude;
  final Value<double?> profileLocationLongitude;
  final Value<JsonString?> jsonSearchGroups;
  final Value<JsonString?> jsonProfileFilteringSettings;
  final Value<int?> profileSearchAgeRangeMin;
  final Value<int?> profileSearchAgeRangeMax;
  final Value<String?> accountEmailAddress;
  final Value<String?> refreshTokenAccount;
  final Value<String?> refreshTokenMedia;
  final Value<String?> refreshTokenProfile;
  final Value<String?> refreshTokenChat;
  final Value<String?> accessTokenAccount;
  final Value<String?> accessTokenMedia;
  final Value<String?> accessTokenProfile;
  final Value<String?> accessTokenChat;
  final Value<int?> localImageSettingImageCacheMaxBytes;
  final Value<bool?> localImageSettingCacheFullSizedImages;
  final Value<int?> localImageSettingImageCacheDownscalingSize;
  final Value<PrivateKeyData?> privateKeyData;
  final Value<PublicKeyData?> publicKeyData;
  final Value<api.PublicKeyId?> publicKeyId;
  final Value<UtcDateTime?> profileInitialAgeSetUnixTime;
  final Value<int?> profileInitialAge;
  final Value<UtcDateTime?> serverMaintenanceUnixTime;
  final Value<UtcDateTime?> serverMaintenanceUnixTimeViewed;
  final Value<api.CustomReportsFileHash?> customReportsFileHash;
  final Value<JsonString?> customReportsConfig;
  final Value<api.ClientFeaturesFileHash?> clientFeaturesFileHash;
  final Value<JsonString?> clientFeaturesConfig;
  final Value<bool> initialSetupSkipped;
  const AccountCompanion({
    this.id = const Value.absent(),
    this.uuidAccountId = const Value.absent(),
    this.jsonAccountState = const Value.absent(),
    this.jsonPermissions = const Value.absent(),
    this.jsonProfileVisibility = const Value.absent(),
    this.profileFilterFavorites = const Value.absent(),
    this.profileIteratorSessionId = const Value.absent(),
    this.automatiProfileSearchIteratorSessionId = const Value.absent(),
    this.receivedLikesIteratorSessionId = const Value.absent(),
    this.matchesIteratorSessionId = const Value.absent(),
    this.clientId = const Value.absent(),
    this.jsonAvailableProfileAttributesOrderMode = const Value.absent(),
    this.initialSyncDoneLoginRepository = const Value.absent(),
    this.initialSyncDoneAccountRepository = const Value.absent(),
    this.initialSyncDoneMediaRepository = const Value.absent(),
    this.initialSyncDoneProfileRepository = const Value.absent(),
    this.initialSyncDoneChatRepository = const Value.absent(),
    this.syncVersionAccount = const Value.absent(),
    this.syncVersionProfile = const Value.absent(),
    this.syncVersionMediaContent = const Value.absent(),
    this.syncVersionClientConfig = const Value.absent(),
    this.primaryContentGridCropSize = const Value.absent(),
    this.primaryContentGridCropX = const Value.absent(),
    this.primaryContentGridCropY = const Value.absent(),
    this.profileContentVersion = const Value.absent(),
    this.profileName = const Value.absent(),
    this.profileNameAccepted = const Value.absent(),
    this.profileNameModerationState = const Value.absent(),
    this.profileText = const Value.absent(),
    this.profileTextAccepted = const Value.absent(),
    this.profileTextModerationState = const Value.absent(),
    this.profileTextModerationRejectedCategory = const Value.absent(),
    this.profileTextModerationRejectedDetails = const Value.absent(),
    this.profileAge = const Value.absent(),
    this.profileUnlimitedLikes = const Value.absent(),
    this.profileVersion = const Value.absent(),
    this.jsonProfileAttributes = const Value.absent(),
    this.profileLocationLatitude = const Value.absent(),
    this.profileLocationLongitude = const Value.absent(),
    this.jsonSearchGroups = const Value.absent(),
    this.jsonProfileFilteringSettings = const Value.absent(),
    this.profileSearchAgeRangeMin = const Value.absent(),
    this.profileSearchAgeRangeMax = const Value.absent(),
    this.accountEmailAddress = const Value.absent(),
    this.refreshTokenAccount = const Value.absent(),
    this.refreshTokenMedia = const Value.absent(),
    this.refreshTokenProfile = const Value.absent(),
    this.refreshTokenChat = const Value.absent(),
    this.accessTokenAccount = const Value.absent(),
    this.accessTokenMedia = const Value.absent(),
    this.accessTokenProfile = const Value.absent(),
    this.accessTokenChat = const Value.absent(),
    this.localImageSettingImageCacheMaxBytes = const Value.absent(),
    this.localImageSettingCacheFullSizedImages = const Value.absent(),
    this.localImageSettingImageCacheDownscalingSize = const Value.absent(),
    this.privateKeyData = const Value.absent(),
    this.publicKeyData = const Value.absent(),
    this.publicKeyId = const Value.absent(),
    this.profileInitialAgeSetUnixTime = const Value.absent(),
    this.profileInitialAge = const Value.absent(),
    this.serverMaintenanceUnixTime = const Value.absent(),
    this.serverMaintenanceUnixTimeViewed = const Value.absent(),
    this.customReportsFileHash = const Value.absent(),
    this.customReportsConfig = const Value.absent(),
    this.clientFeaturesFileHash = const Value.absent(),
    this.clientFeaturesConfig = const Value.absent(),
    this.initialSetupSkipped = const Value.absent(),
  });
  AccountCompanion.insert({
    this.id = const Value.absent(),
    this.uuidAccountId = const Value.absent(),
    this.jsonAccountState = const Value.absent(),
    this.jsonPermissions = const Value.absent(),
    this.jsonProfileVisibility = const Value.absent(),
    this.profileFilterFavorites = const Value.absent(),
    this.profileIteratorSessionId = const Value.absent(),
    this.automatiProfileSearchIteratorSessionId = const Value.absent(),
    this.receivedLikesIteratorSessionId = const Value.absent(),
    this.matchesIteratorSessionId = const Value.absent(),
    this.clientId = const Value.absent(),
    this.jsonAvailableProfileAttributesOrderMode = const Value.absent(),
    this.initialSyncDoneLoginRepository = const Value.absent(),
    this.initialSyncDoneAccountRepository = const Value.absent(),
    this.initialSyncDoneMediaRepository = const Value.absent(),
    this.initialSyncDoneProfileRepository = const Value.absent(),
    this.initialSyncDoneChatRepository = const Value.absent(),
    this.syncVersionAccount = const Value.absent(),
    this.syncVersionProfile = const Value.absent(),
    this.syncVersionMediaContent = const Value.absent(),
    this.syncVersionClientConfig = const Value.absent(),
    this.primaryContentGridCropSize = const Value.absent(),
    this.primaryContentGridCropX = const Value.absent(),
    this.primaryContentGridCropY = const Value.absent(),
    this.profileContentVersion = const Value.absent(),
    this.profileName = const Value.absent(),
    this.profileNameAccepted = const Value.absent(),
    this.profileNameModerationState = const Value.absent(),
    this.profileText = const Value.absent(),
    this.profileTextAccepted = const Value.absent(),
    this.profileTextModerationState = const Value.absent(),
    this.profileTextModerationRejectedCategory = const Value.absent(),
    this.profileTextModerationRejectedDetails = const Value.absent(),
    this.profileAge = const Value.absent(),
    this.profileUnlimitedLikes = const Value.absent(),
    this.profileVersion = const Value.absent(),
    this.jsonProfileAttributes = const Value.absent(),
    this.profileLocationLatitude = const Value.absent(),
    this.profileLocationLongitude = const Value.absent(),
    this.jsonSearchGroups = const Value.absent(),
    this.jsonProfileFilteringSettings = const Value.absent(),
    this.profileSearchAgeRangeMin = const Value.absent(),
    this.profileSearchAgeRangeMax = const Value.absent(),
    this.accountEmailAddress = const Value.absent(),
    this.refreshTokenAccount = const Value.absent(),
    this.refreshTokenMedia = const Value.absent(),
    this.refreshTokenProfile = const Value.absent(),
    this.refreshTokenChat = const Value.absent(),
    this.accessTokenAccount = const Value.absent(),
    this.accessTokenMedia = const Value.absent(),
    this.accessTokenProfile = const Value.absent(),
    this.accessTokenChat = const Value.absent(),
    this.localImageSettingImageCacheMaxBytes = const Value.absent(),
    this.localImageSettingCacheFullSizedImages = const Value.absent(),
    this.localImageSettingImageCacheDownscalingSize = const Value.absent(),
    this.privateKeyData = const Value.absent(),
    this.publicKeyData = const Value.absent(),
    this.publicKeyId = const Value.absent(),
    this.profileInitialAgeSetUnixTime = const Value.absent(),
    this.profileInitialAge = const Value.absent(),
    this.serverMaintenanceUnixTime = const Value.absent(),
    this.serverMaintenanceUnixTimeViewed = const Value.absent(),
    this.customReportsFileHash = const Value.absent(),
    this.customReportsConfig = const Value.absent(),
    this.clientFeaturesFileHash = const Value.absent(),
    this.clientFeaturesConfig = const Value.absent(),
    this.initialSetupSkipped = const Value.absent(),
  });
  static Insertable<AccountData> custom({
    Expression<int>? id,
    Expression<String>? uuidAccountId,
    Expression<String>? jsonAccountState,
    Expression<String>? jsonPermissions,
    Expression<String>? jsonProfileVisibility,
    Expression<bool>? profileFilterFavorites,
    Expression<int>? profileIteratorSessionId,
    Expression<int>? automatiProfileSearchIteratorSessionId,
    Expression<int>? receivedLikesIteratorSessionId,
    Expression<int>? matchesIteratorSessionId,
    Expression<int>? clientId,
    Expression<String>? jsonAvailableProfileAttributesOrderMode,
    Expression<bool>? initialSyncDoneLoginRepository,
    Expression<bool>? initialSyncDoneAccountRepository,
    Expression<bool>? initialSyncDoneMediaRepository,
    Expression<bool>? initialSyncDoneProfileRepository,
    Expression<bool>? initialSyncDoneChatRepository,
    Expression<int>? syncVersionAccount,
    Expression<int>? syncVersionProfile,
    Expression<int>? syncVersionMediaContent,
    Expression<int>? syncVersionClientConfig,
    Expression<double>? primaryContentGridCropSize,
    Expression<double>? primaryContentGridCropX,
    Expression<double>? primaryContentGridCropY,
    Expression<String>? profileContentVersion,
    Expression<String>? profileName,
    Expression<bool>? profileNameAccepted,
    Expression<String>? profileNameModerationState,
    Expression<String>? profileText,
    Expression<bool>? profileTextAccepted,
    Expression<String>? profileTextModerationState,
    Expression<int>? profileTextModerationRejectedCategory,
    Expression<String>? profileTextModerationRejectedDetails,
    Expression<int>? profileAge,
    Expression<bool>? profileUnlimitedLikes,
    Expression<String>? profileVersion,
    Expression<String>? jsonProfileAttributes,
    Expression<double>? profileLocationLatitude,
    Expression<double>? profileLocationLongitude,
    Expression<String>? jsonSearchGroups,
    Expression<String>? jsonProfileFilteringSettings,
    Expression<int>? profileSearchAgeRangeMin,
    Expression<int>? profileSearchAgeRangeMax,
    Expression<String>? accountEmailAddress,
    Expression<String>? refreshTokenAccount,
    Expression<String>? refreshTokenMedia,
    Expression<String>? refreshTokenProfile,
    Expression<String>? refreshTokenChat,
    Expression<String>? accessTokenAccount,
    Expression<String>? accessTokenMedia,
    Expression<String>? accessTokenProfile,
    Expression<String>? accessTokenChat,
    Expression<int>? localImageSettingImageCacheMaxBytes,
    Expression<bool>? localImageSettingCacheFullSizedImages,
    Expression<int>? localImageSettingImageCacheDownscalingSize,
    Expression<Uint8List>? privateKeyData,
    Expression<Uint8List>? publicKeyData,
    Expression<int>? publicKeyId,
    Expression<int>? profileInitialAgeSetUnixTime,
    Expression<int>? profileInitialAge,
    Expression<int>? serverMaintenanceUnixTime,
    Expression<int>? serverMaintenanceUnixTimeViewed,
    Expression<String>? customReportsFileHash,
    Expression<String>? customReportsConfig,
    Expression<String>? clientFeaturesFileHash,
    Expression<String>? clientFeaturesConfig,
    Expression<bool>? initialSetupSkipped,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuidAccountId != null) 'uuid_account_id': uuidAccountId,
      if (jsonAccountState != null) 'json_account_state': jsonAccountState,
      if (jsonPermissions != null) 'json_permissions': jsonPermissions,
      if (jsonProfileVisibility != null)
        'json_profile_visibility': jsonProfileVisibility,
      if (profileFilterFavorites != null)
        'profile_filter_favorites': profileFilterFavorites,
      if (profileIteratorSessionId != null)
        'profile_iterator_session_id': profileIteratorSessionId,
      if (automatiProfileSearchIteratorSessionId != null)
        'automati_profile_search_iterator_session_id':
            automatiProfileSearchIteratorSessionId,
      if (receivedLikesIteratorSessionId != null)
        'received_likes_iterator_session_id': receivedLikesIteratorSessionId,
      if (matchesIteratorSessionId != null)
        'matches_iterator_session_id': matchesIteratorSessionId,
      if (clientId != null) 'client_id': clientId,
      if (jsonAvailableProfileAttributesOrderMode != null)
        'json_available_profile_attributes_order_mode':
            jsonAvailableProfileAttributesOrderMode,
      if (initialSyncDoneLoginRepository != null)
        'initial_sync_done_login_repository': initialSyncDoneLoginRepository,
      if (initialSyncDoneAccountRepository != null)
        'initial_sync_done_account_repository':
            initialSyncDoneAccountRepository,
      if (initialSyncDoneMediaRepository != null)
        'initial_sync_done_media_repository': initialSyncDoneMediaRepository,
      if (initialSyncDoneProfileRepository != null)
        'initial_sync_done_profile_repository':
            initialSyncDoneProfileRepository,
      if (initialSyncDoneChatRepository != null)
        'initial_sync_done_chat_repository': initialSyncDoneChatRepository,
      if (syncVersionAccount != null)
        'sync_version_account': syncVersionAccount,
      if (syncVersionProfile != null)
        'sync_version_profile': syncVersionProfile,
      if (syncVersionMediaContent != null)
        'sync_version_media_content': syncVersionMediaContent,
      if (syncVersionClientConfig != null)
        'sync_version_client_config': syncVersionClientConfig,
      if (primaryContentGridCropSize != null)
        'primary_content_grid_crop_size': primaryContentGridCropSize,
      if (primaryContentGridCropX != null)
        'primary_content_grid_crop_x': primaryContentGridCropX,
      if (primaryContentGridCropY != null)
        'primary_content_grid_crop_y': primaryContentGridCropY,
      if (profileContentVersion != null)
        'profile_content_version': profileContentVersion,
      if (profileName != null) 'profile_name': profileName,
      if (profileNameAccepted != null)
        'profile_name_accepted': profileNameAccepted,
      if (profileNameModerationState != null)
        'profile_name_moderation_state': profileNameModerationState,
      if (profileText != null) 'profile_text': profileText,
      if (profileTextAccepted != null)
        'profile_text_accepted': profileTextAccepted,
      if (profileTextModerationState != null)
        'profile_text_moderation_state': profileTextModerationState,
      if (profileTextModerationRejectedCategory != null)
        'profile_text_moderation_rejected_category':
            profileTextModerationRejectedCategory,
      if (profileTextModerationRejectedDetails != null)
        'profile_text_moderation_rejected_details':
            profileTextModerationRejectedDetails,
      if (profileAge != null) 'profile_age': profileAge,
      if (profileUnlimitedLikes != null)
        'profile_unlimited_likes': profileUnlimitedLikes,
      if (profileVersion != null) 'profile_version': profileVersion,
      if (jsonProfileAttributes != null)
        'json_profile_attributes': jsonProfileAttributes,
      if (profileLocationLatitude != null)
        'profile_location_latitude': profileLocationLatitude,
      if (profileLocationLongitude != null)
        'profile_location_longitude': profileLocationLongitude,
      if (jsonSearchGroups != null) 'json_search_groups': jsonSearchGroups,
      if (jsonProfileFilteringSettings != null)
        'json_profile_filtering_settings': jsonProfileFilteringSettings,
      if (profileSearchAgeRangeMin != null)
        'profile_search_age_range_min': profileSearchAgeRangeMin,
      if (profileSearchAgeRangeMax != null)
        'profile_search_age_range_max': profileSearchAgeRangeMax,
      if (accountEmailAddress != null)
        'account_email_address': accountEmailAddress,
      if (refreshTokenAccount != null)
        'refresh_token_account': refreshTokenAccount,
      if (refreshTokenMedia != null) 'refresh_token_media': refreshTokenMedia,
      if (refreshTokenProfile != null)
        'refresh_token_profile': refreshTokenProfile,
      if (refreshTokenChat != null) 'refresh_token_chat': refreshTokenChat,
      if (accessTokenAccount != null)
        'access_token_account': accessTokenAccount,
      if (accessTokenMedia != null) 'access_token_media': accessTokenMedia,
      if (accessTokenProfile != null)
        'access_token_profile': accessTokenProfile,
      if (accessTokenChat != null) 'access_token_chat': accessTokenChat,
      if (localImageSettingImageCacheMaxBytes != null)
        'local_image_setting_image_cache_max_bytes':
            localImageSettingImageCacheMaxBytes,
      if (localImageSettingCacheFullSizedImages != null)
        'local_image_setting_cache_full_sized_images':
            localImageSettingCacheFullSizedImages,
      if (localImageSettingImageCacheDownscalingSize != null)
        'local_image_setting_image_cache_downscaling_size':
            localImageSettingImageCacheDownscalingSize,
      if (privateKeyData != null) 'private_key_data': privateKeyData,
      if (publicKeyData != null) 'public_key_data': publicKeyData,
      if (publicKeyId != null) 'public_key_id': publicKeyId,
      if (profileInitialAgeSetUnixTime != null)
        'profile_initial_age_set_unix_time': profileInitialAgeSetUnixTime,
      if (profileInitialAge != null) 'profile_initial_age': profileInitialAge,
      if (serverMaintenanceUnixTime != null)
        'server_maintenance_unix_time': serverMaintenanceUnixTime,
      if (serverMaintenanceUnixTimeViewed != null)
        'server_maintenance_unix_time_viewed': serverMaintenanceUnixTimeViewed,
      if (customReportsFileHash != null)
        'custom_reports_file_hash': customReportsFileHash,
      if (customReportsConfig != null)
        'custom_reports_config': customReportsConfig,
      if (clientFeaturesFileHash != null)
        'client_features_file_hash': clientFeaturesFileHash,
      if (clientFeaturesConfig != null)
        'client_features_config': clientFeaturesConfig,
      if (initialSetupSkipped != null)
        'initial_setup_skipped': initialSetupSkipped,
    });
  }

  AccountCompanion copyWith(
      {Value<int>? id,
      Value<api.AccountId?>? uuidAccountId,
      Value<JsonString?>? jsonAccountState,
      Value<JsonString?>? jsonPermissions,
      Value<EnumString?>? jsonProfileVisibility,
      Value<bool>? profileFilterFavorites,
      Value<api.ProfileIteratorSessionId?>? profileIteratorSessionId,
      Value<api.AutomaticProfileSearchIteratorSessionId?>?
          automatiProfileSearchIteratorSessionId,
      Value<api.ReceivedLikesIteratorSessionId?>?
          receivedLikesIteratorSessionId,
      Value<api.MatchesIteratorSessionId?>? matchesIteratorSessionId,
      Value<api.ClientId?>? clientId,
      Value<EnumString?>? jsonAvailableProfileAttributesOrderMode,
      Value<bool>? initialSyncDoneLoginRepository,
      Value<bool>? initialSyncDoneAccountRepository,
      Value<bool>? initialSyncDoneMediaRepository,
      Value<bool>? initialSyncDoneProfileRepository,
      Value<bool>? initialSyncDoneChatRepository,
      Value<int?>? syncVersionAccount,
      Value<int?>? syncVersionProfile,
      Value<int?>? syncVersionMediaContent,
      Value<int?>? syncVersionClientConfig,
      Value<double?>? primaryContentGridCropSize,
      Value<double?>? primaryContentGridCropX,
      Value<double?>? primaryContentGridCropY,
      Value<api.ProfileContentVersion?>? profileContentVersion,
      Value<String?>? profileName,
      Value<bool?>? profileNameAccepted,
      Value<EnumString?>? profileNameModerationState,
      Value<String?>? profileText,
      Value<bool?>? profileTextAccepted,
      Value<EnumString?>? profileTextModerationState,
      Value<api.ProfileTextModerationRejectedReasonCategory?>?
          profileTextModerationRejectedCategory,
      Value<api.ProfileTextModerationRejectedReasonDetails?>?
          profileTextModerationRejectedDetails,
      Value<int?>? profileAge,
      Value<bool?>? profileUnlimitedLikes,
      Value<api.ProfileVersion?>? profileVersion,
      Value<JsonList?>? jsonProfileAttributes,
      Value<double?>? profileLocationLatitude,
      Value<double?>? profileLocationLongitude,
      Value<JsonString?>? jsonSearchGroups,
      Value<JsonString?>? jsonProfileFilteringSettings,
      Value<int?>? profileSearchAgeRangeMin,
      Value<int?>? profileSearchAgeRangeMax,
      Value<String?>? accountEmailAddress,
      Value<String?>? refreshTokenAccount,
      Value<String?>? refreshTokenMedia,
      Value<String?>? refreshTokenProfile,
      Value<String?>? refreshTokenChat,
      Value<String?>? accessTokenAccount,
      Value<String?>? accessTokenMedia,
      Value<String?>? accessTokenProfile,
      Value<String?>? accessTokenChat,
      Value<int?>? localImageSettingImageCacheMaxBytes,
      Value<bool?>? localImageSettingCacheFullSizedImages,
      Value<int?>? localImageSettingImageCacheDownscalingSize,
      Value<PrivateKeyData?>? privateKeyData,
      Value<PublicKeyData?>? publicKeyData,
      Value<api.PublicKeyId?>? publicKeyId,
      Value<UtcDateTime?>? profileInitialAgeSetUnixTime,
      Value<int?>? profileInitialAge,
      Value<UtcDateTime?>? serverMaintenanceUnixTime,
      Value<UtcDateTime?>? serverMaintenanceUnixTimeViewed,
      Value<api.CustomReportsFileHash?>? customReportsFileHash,
      Value<JsonString?>? customReportsConfig,
      Value<api.ClientFeaturesFileHash?>? clientFeaturesFileHash,
      Value<JsonString?>? clientFeaturesConfig,
      Value<bool>? initialSetupSkipped}) {
    return AccountCompanion(
      id: id ?? this.id,
      uuidAccountId: uuidAccountId ?? this.uuidAccountId,
      jsonAccountState: jsonAccountState ?? this.jsonAccountState,
      jsonPermissions: jsonPermissions ?? this.jsonPermissions,
      jsonProfileVisibility:
          jsonProfileVisibility ?? this.jsonProfileVisibility,
      profileFilterFavorites:
          profileFilterFavorites ?? this.profileFilterFavorites,
      profileIteratorSessionId:
          profileIteratorSessionId ?? this.profileIteratorSessionId,
      automatiProfileSearchIteratorSessionId:
          automatiProfileSearchIteratorSessionId ??
              this.automatiProfileSearchIteratorSessionId,
      receivedLikesIteratorSessionId:
          receivedLikesIteratorSessionId ?? this.receivedLikesIteratorSessionId,
      matchesIteratorSessionId:
          matchesIteratorSessionId ?? this.matchesIteratorSessionId,
      clientId: clientId ?? this.clientId,
      jsonAvailableProfileAttributesOrderMode:
          jsonAvailableProfileAttributesOrderMode ??
              this.jsonAvailableProfileAttributesOrderMode,
      initialSyncDoneLoginRepository:
          initialSyncDoneLoginRepository ?? this.initialSyncDoneLoginRepository,
      initialSyncDoneAccountRepository: initialSyncDoneAccountRepository ??
          this.initialSyncDoneAccountRepository,
      initialSyncDoneMediaRepository:
          initialSyncDoneMediaRepository ?? this.initialSyncDoneMediaRepository,
      initialSyncDoneProfileRepository: initialSyncDoneProfileRepository ??
          this.initialSyncDoneProfileRepository,
      initialSyncDoneChatRepository:
          initialSyncDoneChatRepository ?? this.initialSyncDoneChatRepository,
      syncVersionAccount: syncVersionAccount ?? this.syncVersionAccount,
      syncVersionProfile: syncVersionProfile ?? this.syncVersionProfile,
      syncVersionMediaContent:
          syncVersionMediaContent ?? this.syncVersionMediaContent,
      syncVersionClientConfig:
          syncVersionClientConfig ?? this.syncVersionClientConfig,
      primaryContentGridCropSize:
          primaryContentGridCropSize ?? this.primaryContentGridCropSize,
      primaryContentGridCropX:
          primaryContentGridCropX ?? this.primaryContentGridCropX,
      primaryContentGridCropY:
          primaryContentGridCropY ?? this.primaryContentGridCropY,
      profileContentVersion:
          profileContentVersion ?? this.profileContentVersion,
      profileName: profileName ?? this.profileName,
      profileNameAccepted: profileNameAccepted ?? this.profileNameAccepted,
      profileNameModerationState:
          profileNameModerationState ?? this.profileNameModerationState,
      profileText: profileText ?? this.profileText,
      profileTextAccepted: profileTextAccepted ?? this.profileTextAccepted,
      profileTextModerationState:
          profileTextModerationState ?? this.profileTextModerationState,
      profileTextModerationRejectedCategory:
          profileTextModerationRejectedCategory ??
              this.profileTextModerationRejectedCategory,
      profileTextModerationRejectedDetails:
          profileTextModerationRejectedDetails ??
              this.profileTextModerationRejectedDetails,
      profileAge: profileAge ?? this.profileAge,
      profileUnlimitedLikes:
          profileUnlimitedLikes ?? this.profileUnlimitedLikes,
      profileVersion: profileVersion ?? this.profileVersion,
      jsonProfileAttributes:
          jsonProfileAttributes ?? this.jsonProfileAttributes,
      profileLocationLatitude:
          profileLocationLatitude ?? this.profileLocationLatitude,
      profileLocationLongitude:
          profileLocationLongitude ?? this.profileLocationLongitude,
      jsonSearchGroups: jsonSearchGroups ?? this.jsonSearchGroups,
      jsonProfileFilteringSettings:
          jsonProfileFilteringSettings ?? this.jsonProfileFilteringSettings,
      profileSearchAgeRangeMin:
          profileSearchAgeRangeMin ?? this.profileSearchAgeRangeMin,
      profileSearchAgeRangeMax:
          profileSearchAgeRangeMax ?? this.profileSearchAgeRangeMax,
      accountEmailAddress: accountEmailAddress ?? this.accountEmailAddress,
      refreshTokenAccount: refreshTokenAccount ?? this.refreshTokenAccount,
      refreshTokenMedia: refreshTokenMedia ?? this.refreshTokenMedia,
      refreshTokenProfile: refreshTokenProfile ?? this.refreshTokenProfile,
      refreshTokenChat: refreshTokenChat ?? this.refreshTokenChat,
      accessTokenAccount: accessTokenAccount ?? this.accessTokenAccount,
      accessTokenMedia: accessTokenMedia ?? this.accessTokenMedia,
      accessTokenProfile: accessTokenProfile ?? this.accessTokenProfile,
      accessTokenChat: accessTokenChat ?? this.accessTokenChat,
      localImageSettingImageCacheMaxBytes:
          localImageSettingImageCacheMaxBytes ??
              this.localImageSettingImageCacheMaxBytes,
      localImageSettingCacheFullSizedImages:
          localImageSettingCacheFullSizedImages ??
              this.localImageSettingCacheFullSizedImages,
      localImageSettingImageCacheDownscalingSize:
          localImageSettingImageCacheDownscalingSize ??
              this.localImageSettingImageCacheDownscalingSize,
      privateKeyData: privateKeyData ?? this.privateKeyData,
      publicKeyData: publicKeyData ?? this.publicKeyData,
      publicKeyId: publicKeyId ?? this.publicKeyId,
      profileInitialAgeSetUnixTime:
          profileInitialAgeSetUnixTime ?? this.profileInitialAgeSetUnixTime,
      profileInitialAge: profileInitialAge ?? this.profileInitialAge,
      serverMaintenanceUnixTime:
          serverMaintenanceUnixTime ?? this.serverMaintenanceUnixTime,
      serverMaintenanceUnixTimeViewed: serverMaintenanceUnixTimeViewed ??
          this.serverMaintenanceUnixTimeViewed,
      customReportsFileHash:
          customReportsFileHash ?? this.customReportsFileHash,
      customReportsConfig: customReportsConfig ?? this.customReportsConfig,
      clientFeaturesFileHash:
          clientFeaturesFileHash ?? this.clientFeaturesFileHash,
      clientFeaturesConfig: clientFeaturesConfig ?? this.clientFeaturesConfig,
      initialSetupSkipped: initialSetupSkipped ?? this.initialSetupSkipped,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uuidAccountId.present) {
      map['uuid_account_id'] = Variable<String>(
          $AccountTable.$converteruuidAccountId.toSql(uuidAccountId.value));
    }
    if (jsonAccountState.present) {
      map['json_account_state'] = Variable<String>($AccountTable
          .$converterjsonAccountState
          .toSql(jsonAccountState.value));
    }
    if (jsonPermissions.present) {
      map['json_permissions'] = Variable<String>(
          $AccountTable.$converterjsonPermissions.toSql(jsonPermissions.value));
    }
    if (jsonProfileVisibility.present) {
      map['json_profile_visibility'] = Variable<String>($AccountTable
          .$converterjsonProfileVisibility
          .toSql(jsonProfileVisibility.value));
    }
    if (profileFilterFavorites.present) {
      map['profile_filter_favorites'] =
          Variable<bool>(profileFilterFavorites.value);
    }
    if (profileIteratorSessionId.present) {
      map['profile_iterator_session_id'] = Variable<int>($AccountTable
          .$converterprofileIteratorSessionId
          .toSql(profileIteratorSessionId.value));
    }
    if (automatiProfileSearchIteratorSessionId.present) {
      map['automati_profile_search_iterator_session_id'] = Variable<int>(
          $AccountTable.$converterautomatiProfileSearchIteratorSessionId
              .toSql(automatiProfileSearchIteratorSessionId.value));
    }
    if (receivedLikesIteratorSessionId.present) {
      map['received_likes_iterator_session_id'] = Variable<int>($AccountTable
          .$converterreceivedLikesIteratorSessionId
          .toSql(receivedLikesIteratorSessionId.value));
    }
    if (matchesIteratorSessionId.present) {
      map['matches_iterator_session_id'] = Variable<int>($AccountTable
          .$convertermatchesIteratorSessionId
          .toSql(matchesIteratorSessionId.value));
    }
    if (clientId.present) {
      map['client_id'] =
          Variable<int>($AccountTable.$converterclientId.toSql(clientId.value));
    }
    if (jsonAvailableProfileAttributesOrderMode.present) {
      map['json_available_profile_attributes_order_mode'] = Variable<String>(
          $AccountTable.$converterjsonAvailableProfileAttributesOrderMode
              .toSql(jsonAvailableProfileAttributesOrderMode.value));
    }
    if (initialSyncDoneLoginRepository.present) {
      map['initial_sync_done_login_repository'] =
          Variable<bool>(initialSyncDoneLoginRepository.value);
    }
    if (initialSyncDoneAccountRepository.present) {
      map['initial_sync_done_account_repository'] =
          Variable<bool>(initialSyncDoneAccountRepository.value);
    }
    if (initialSyncDoneMediaRepository.present) {
      map['initial_sync_done_media_repository'] =
          Variable<bool>(initialSyncDoneMediaRepository.value);
    }
    if (initialSyncDoneProfileRepository.present) {
      map['initial_sync_done_profile_repository'] =
          Variable<bool>(initialSyncDoneProfileRepository.value);
    }
    if (initialSyncDoneChatRepository.present) {
      map['initial_sync_done_chat_repository'] =
          Variable<bool>(initialSyncDoneChatRepository.value);
    }
    if (syncVersionAccount.present) {
      map['sync_version_account'] = Variable<int>(syncVersionAccount.value);
    }
    if (syncVersionProfile.present) {
      map['sync_version_profile'] = Variable<int>(syncVersionProfile.value);
    }
    if (syncVersionMediaContent.present) {
      map['sync_version_media_content'] =
          Variable<int>(syncVersionMediaContent.value);
    }
    if (syncVersionClientConfig.present) {
      map['sync_version_client_config'] =
          Variable<int>(syncVersionClientConfig.value);
    }
    if (primaryContentGridCropSize.present) {
      map['primary_content_grid_crop_size'] =
          Variable<double>(primaryContentGridCropSize.value);
    }
    if (primaryContentGridCropX.present) {
      map['primary_content_grid_crop_x'] =
          Variable<double>(primaryContentGridCropX.value);
    }
    if (primaryContentGridCropY.present) {
      map['primary_content_grid_crop_y'] =
          Variable<double>(primaryContentGridCropY.value);
    }
    if (profileContentVersion.present) {
      map['profile_content_version'] = Variable<String>($AccountTable
          .$converterprofileContentVersion
          .toSql(profileContentVersion.value));
    }
    if (profileName.present) {
      map['profile_name'] = Variable<String>(profileName.value);
    }
    if (profileNameAccepted.present) {
      map['profile_name_accepted'] = Variable<bool>(profileNameAccepted.value);
    }
    if (profileNameModerationState.present) {
      map['profile_name_moderation_state'] = Variable<String>($AccountTable
          .$converterprofileNameModerationState
          .toSql(profileNameModerationState.value));
    }
    if (profileText.present) {
      map['profile_text'] = Variable<String>(profileText.value);
    }
    if (profileTextAccepted.present) {
      map['profile_text_accepted'] = Variable<bool>(profileTextAccepted.value);
    }
    if (profileTextModerationState.present) {
      map['profile_text_moderation_state'] = Variable<String>($AccountTable
          .$converterprofileTextModerationState
          .toSql(profileTextModerationState.value));
    }
    if (profileTextModerationRejectedCategory.present) {
      map['profile_text_moderation_rejected_category'] = Variable<int>(
          $AccountTable.$converterprofileTextModerationRejectedCategory
              .toSql(profileTextModerationRejectedCategory.value));
    }
    if (profileTextModerationRejectedDetails.present) {
      map['profile_text_moderation_rejected_details'] = Variable<String>(
          $AccountTable.$converterprofileTextModerationRejectedDetails
              .toSql(profileTextModerationRejectedDetails.value));
    }
    if (profileAge.present) {
      map['profile_age'] = Variable<int>(profileAge.value);
    }
    if (profileUnlimitedLikes.present) {
      map['profile_unlimited_likes'] =
          Variable<bool>(profileUnlimitedLikes.value);
    }
    if (profileVersion.present) {
      map['profile_version'] = Variable<String>(
          $AccountTable.$converterprofileVersion.toSql(profileVersion.value));
    }
    if (jsonProfileAttributes.present) {
      map['json_profile_attributes'] = Variable<String>($AccountTable
          .$converterjsonProfileAttributes
          .toSql(jsonProfileAttributes.value));
    }
    if (profileLocationLatitude.present) {
      map['profile_location_latitude'] =
          Variable<double>(profileLocationLatitude.value);
    }
    if (profileLocationLongitude.present) {
      map['profile_location_longitude'] =
          Variable<double>(profileLocationLongitude.value);
    }
    if (jsonSearchGroups.present) {
      map['json_search_groups'] = Variable<String>($AccountTable
          .$converterjsonSearchGroups
          .toSql(jsonSearchGroups.value));
    }
    if (jsonProfileFilteringSettings.present) {
      map['json_profile_filtering_settings'] = Variable<String>($AccountTable
          .$converterjsonProfileFilteringSettings
          .toSql(jsonProfileFilteringSettings.value));
    }
    if (profileSearchAgeRangeMin.present) {
      map['profile_search_age_range_min'] =
          Variable<int>(profileSearchAgeRangeMin.value);
    }
    if (profileSearchAgeRangeMax.present) {
      map['profile_search_age_range_max'] =
          Variable<int>(profileSearchAgeRangeMax.value);
    }
    if (accountEmailAddress.present) {
      map['account_email_address'] =
          Variable<String>(accountEmailAddress.value);
    }
    if (refreshTokenAccount.present) {
      map['refresh_token_account'] =
          Variable<String>(refreshTokenAccount.value);
    }
    if (refreshTokenMedia.present) {
      map['refresh_token_media'] = Variable<String>(refreshTokenMedia.value);
    }
    if (refreshTokenProfile.present) {
      map['refresh_token_profile'] =
          Variable<String>(refreshTokenProfile.value);
    }
    if (refreshTokenChat.present) {
      map['refresh_token_chat'] = Variable<String>(refreshTokenChat.value);
    }
    if (accessTokenAccount.present) {
      map['access_token_account'] = Variable<String>(accessTokenAccount.value);
    }
    if (accessTokenMedia.present) {
      map['access_token_media'] = Variable<String>(accessTokenMedia.value);
    }
    if (accessTokenProfile.present) {
      map['access_token_profile'] = Variable<String>(accessTokenProfile.value);
    }
    if (accessTokenChat.present) {
      map['access_token_chat'] = Variable<String>(accessTokenChat.value);
    }
    if (localImageSettingImageCacheMaxBytes.present) {
      map['local_image_setting_image_cache_max_bytes'] =
          Variable<int>(localImageSettingImageCacheMaxBytes.value);
    }
    if (localImageSettingCacheFullSizedImages.present) {
      map['local_image_setting_cache_full_sized_images'] =
          Variable<bool>(localImageSettingCacheFullSizedImages.value);
    }
    if (localImageSettingImageCacheDownscalingSize.present) {
      map['local_image_setting_image_cache_downscaling_size'] =
          Variable<int>(localImageSettingImageCacheDownscalingSize.value);
    }
    if (privateKeyData.present) {
      map['private_key_data'] = Variable<Uint8List>(
          $AccountTable.$converterprivateKeyData.toSql(privateKeyData.value));
    }
    if (publicKeyData.present) {
      map['public_key_data'] = Variable<Uint8List>(
          $AccountTable.$converterpublicKeyData.toSql(publicKeyData.value));
    }
    if (publicKeyId.present) {
      map['public_key_id'] = Variable<int>(
          $AccountTable.$converterpublicKeyId.toSql(publicKeyId.value));
    }
    if (profileInitialAgeSetUnixTime.present) {
      map['profile_initial_age_set_unix_time'] = Variable<int>($AccountTable
          .$converterprofileInitialAgeSetUnixTime
          .toSql(profileInitialAgeSetUnixTime.value));
    }
    if (profileInitialAge.present) {
      map['profile_initial_age'] = Variable<int>(profileInitialAge.value);
    }
    if (serverMaintenanceUnixTime.present) {
      map['server_maintenance_unix_time'] = Variable<int>($AccountTable
          .$converterserverMaintenanceUnixTime
          .toSql(serverMaintenanceUnixTime.value));
    }
    if (serverMaintenanceUnixTimeViewed.present) {
      map['server_maintenance_unix_time_viewed'] = Variable<int>($AccountTable
          .$converterserverMaintenanceUnixTimeViewed
          .toSql(serverMaintenanceUnixTimeViewed.value));
    }
    if (customReportsFileHash.present) {
      map['custom_reports_file_hash'] = Variable<String>($AccountTable
          .$convertercustomReportsFileHash
          .toSql(customReportsFileHash.value));
    }
    if (customReportsConfig.present) {
      map['custom_reports_config'] = Variable<String>($AccountTable
          .$convertercustomReportsConfig
          .toSql(customReportsConfig.value));
    }
    if (clientFeaturesFileHash.present) {
      map['client_features_file_hash'] = Variable<String>($AccountTable
          .$converterclientFeaturesFileHash
          .toSql(clientFeaturesFileHash.value));
    }
    if (clientFeaturesConfig.present) {
      map['client_features_config'] = Variable<String>($AccountTable
          .$converterclientFeaturesConfig
          .toSql(clientFeaturesConfig.value));
    }
    if (initialSetupSkipped.present) {
      map['initial_setup_skipped'] = Variable<bool>(initialSetupSkipped.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AccountCompanion(')
          ..write('id: $id, ')
          ..write('uuidAccountId: $uuidAccountId, ')
          ..write('jsonAccountState: $jsonAccountState, ')
          ..write('jsonPermissions: $jsonPermissions, ')
          ..write('jsonProfileVisibility: $jsonProfileVisibility, ')
          ..write('profileFilterFavorites: $profileFilterFavorites, ')
          ..write('profileIteratorSessionId: $profileIteratorSessionId, ')
          ..write(
              'automatiProfileSearchIteratorSessionId: $automatiProfileSearchIteratorSessionId, ')
          ..write(
              'receivedLikesIteratorSessionId: $receivedLikesIteratorSessionId, ')
          ..write('matchesIteratorSessionId: $matchesIteratorSessionId, ')
          ..write('clientId: $clientId, ')
          ..write(
              'jsonAvailableProfileAttributesOrderMode: $jsonAvailableProfileAttributesOrderMode, ')
          ..write(
              'initialSyncDoneLoginRepository: $initialSyncDoneLoginRepository, ')
          ..write(
              'initialSyncDoneAccountRepository: $initialSyncDoneAccountRepository, ')
          ..write(
              'initialSyncDoneMediaRepository: $initialSyncDoneMediaRepository, ')
          ..write(
              'initialSyncDoneProfileRepository: $initialSyncDoneProfileRepository, ')
          ..write(
              'initialSyncDoneChatRepository: $initialSyncDoneChatRepository, ')
          ..write('syncVersionAccount: $syncVersionAccount, ')
          ..write('syncVersionProfile: $syncVersionProfile, ')
          ..write('syncVersionMediaContent: $syncVersionMediaContent, ')
          ..write('syncVersionClientConfig: $syncVersionClientConfig, ')
          ..write('primaryContentGridCropSize: $primaryContentGridCropSize, ')
          ..write('primaryContentGridCropX: $primaryContentGridCropX, ')
          ..write('primaryContentGridCropY: $primaryContentGridCropY, ')
          ..write('profileContentVersion: $profileContentVersion, ')
          ..write('profileName: $profileName, ')
          ..write('profileNameAccepted: $profileNameAccepted, ')
          ..write('profileNameModerationState: $profileNameModerationState, ')
          ..write('profileText: $profileText, ')
          ..write('profileTextAccepted: $profileTextAccepted, ')
          ..write('profileTextModerationState: $profileTextModerationState, ')
          ..write(
              'profileTextModerationRejectedCategory: $profileTextModerationRejectedCategory, ')
          ..write(
              'profileTextModerationRejectedDetails: $profileTextModerationRejectedDetails, ')
          ..write('profileAge: $profileAge, ')
          ..write('profileUnlimitedLikes: $profileUnlimitedLikes, ')
          ..write('profileVersion: $profileVersion, ')
          ..write('jsonProfileAttributes: $jsonProfileAttributes, ')
          ..write('profileLocationLatitude: $profileLocationLatitude, ')
          ..write('profileLocationLongitude: $profileLocationLongitude, ')
          ..write('jsonSearchGroups: $jsonSearchGroups, ')
          ..write(
              'jsonProfileFilteringSettings: $jsonProfileFilteringSettings, ')
          ..write('profileSearchAgeRangeMin: $profileSearchAgeRangeMin, ')
          ..write('profileSearchAgeRangeMax: $profileSearchAgeRangeMax, ')
          ..write('accountEmailAddress: $accountEmailAddress, ')
          ..write('refreshTokenAccount: $refreshTokenAccount, ')
          ..write('refreshTokenMedia: $refreshTokenMedia, ')
          ..write('refreshTokenProfile: $refreshTokenProfile, ')
          ..write('refreshTokenChat: $refreshTokenChat, ')
          ..write('accessTokenAccount: $accessTokenAccount, ')
          ..write('accessTokenMedia: $accessTokenMedia, ')
          ..write('accessTokenProfile: $accessTokenProfile, ')
          ..write('accessTokenChat: $accessTokenChat, ')
          ..write(
              'localImageSettingImageCacheMaxBytes: $localImageSettingImageCacheMaxBytes, ')
          ..write(
              'localImageSettingCacheFullSizedImages: $localImageSettingCacheFullSizedImages, ')
          ..write(
              'localImageSettingImageCacheDownscalingSize: $localImageSettingImageCacheDownscalingSize, ')
          ..write('privateKeyData: $privateKeyData, ')
          ..write('publicKeyData: $publicKeyData, ')
          ..write('publicKeyId: $publicKeyId, ')
          ..write(
              'profileInitialAgeSetUnixTime: $profileInitialAgeSetUnixTime, ')
          ..write('profileInitialAge: $profileInitialAge, ')
          ..write('serverMaintenanceUnixTime: $serverMaintenanceUnixTime, ')
          ..write(
              'serverMaintenanceUnixTimeViewed: $serverMaintenanceUnixTimeViewed, ')
          ..write('customReportsFileHash: $customReportsFileHash, ')
          ..write('customReportsConfig: $customReportsConfig, ')
          ..write('clientFeaturesFileHash: $clientFeaturesFileHash, ')
          ..write('clientFeaturesConfig: $clientFeaturesConfig, ')
          ..write('initialSetupSkipped: $initialSetupSkipped')
          ..write(')'))
        .toString();
  }
}

class $ProfilesTable extends Profiles with TableInfo<$ProfilesTable, Profile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  @override
  late final GeneratedColumnWithTypeConverter<api.AccountId, String>
      uuidAccountId = GeneratedColumn<String>(
              'uuid_account_id', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: true,
              defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'))
          .withConverter<api.AccountId>($ProfilesTable.$converteruuidAccountId);
  @override
  late final GeneratedColumnWithTypeConverter<api.ProfileContentVersion?,
      String> profileContentVersion = GeneratedColumn<String>(
          'profile_content_version', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false)
      .withConverter<api.ProfileContentVersion?>(
          $ProfilesTable.$converterprofileContentVersion);
  static const VerificationMeta _profileNameMeta =
      const VerificationMeta('profileName');
  @override
  late final GeneratedColumn<String> profileName = GeneratedColumn<String>(
      'profile_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _profileNameAcceptedMeta =
      const VerificationMeta('profileNameAccepted');
  @override
  late final GeneratedColumn<bool> profileNameAccepted = GeneratedColumn<bool>(
      'profile_name_accepted', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("profile_name_accepted" IN (0, 1))'));
  static const VerificationMeta _profileTextMeta =
      const VerificationMeta('profileText');
  @override
  late final GeneratedColumn<String> profileText = GeneratedColumn<String>(
      'profile_text', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _profileTextAcceptedMeta =
      const VerificationMeta('profileTextAccepted');
  @override
  late final GeneratedColumn<bool> profileTextAccepted = GeneratedColumn<bool>(
      'profile_text_accepted', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("profile_text_accepted" IN (0, 1))'));
  @override
  late final GeneratedColumnWithTypeConverter<api.ProfileVersion?, String>
      profileVersion = GeneratedColumn<String>(
              'profile_version', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<api.ProfileVersion?>(
              $ProfilesTable.$converterprofileVersion);
  static const VerificationMeta _profileAgeMeta =
      const VerificationMeta('profileAge');
  @override
  late final GeneratedColumn<int> profileAge = GeneratedColumn<int>(
      'profile_age', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _profileLastSeenTimeValueMeta =
      const VerificationMeta('profileLastSeenTimeValue');
  @override
  late final GeneratedColumn<int> profileLastSeenTimeValue =
      GeneratedColumn<int>('profile_last_seen_time_value', aliasedName, true,
          type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _profileUnlimitedLikesMeta =
      const VerificationMeta('profileUnlimitedLikes');
  @override
  late final GeneratedColumn<bool> profileUnlimitedLikes =
      GeneratedColumn<bool>('profile_unlimited_likes', aliasedName, true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("profile_unlimited_likes" IN (0, 1))'));
  @override
  late final GeneratedColumnWithTypeConverter<JsonList?, String>
      jsonProfileAttributes = GeneratedColumn<String>(
              'json_profile_attributes', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<JsonList?>(
              $ProfilesTable.$converterjsonProfileAttributes);
  static const VerificationMeta _primaryContentGridCropSizeMeta =
      const VerificationMeta('primaryContentGridCropSize');
  @override
  late final GeneratedColumn<double> primaryContentGridCropSize =
      GeneratedColumn<double>(
          'primary_content_grid_crop_size', aliasedName, true,
          type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _primaryContentGridCropXMeta =
      const VerificationMeta('primaryContentGridCropX');
  @override
  late final GeneratedColumn<double> primaryContentGridCropX =
      GeneratedColumn<double>('primary_content_grid_crop_x', aliasedName, true,
          type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _primaryContentGridCropYMeta =
      const VerificationMeta('primaryContentGridCropY');
  @override
  late final GeneratedColumn<double> primaryContentGridCropY =
      GeneratedColumn<double>('primary_content_grid_crop_y', aliasedName, true,
          type: DriftSqlType.double, requiredDuringInsert: false);
  @override
  late final GeneratedColumnWithTypeConverter<UtcDateTime?, int>
      profileDataRefreshTime = GeneratedColumn<int>(
              'profile_data_refresh_time', aliasedName, true,
              type: DriftSqlType.int, requiredDuringInsert: false)
          .withConverter<UtcDateTime?>(
              $ProfilesTable.$converterprofileDataRefreshTime);
  @override
  late final GeneratedColumnWithTypeConverter<UtcDateTime?, int>
      newLikeInfoReceivedTime = GeneratedColumn<int>(
              'new_like_info_received_time', aliasedName, true,
              type: DriftSqlType.int, requiredDuringInsert: false)
          .withConverter<UtcDateTime?>(
              $ProfilesTable.$converternewLikeInfoReceivedTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        uuidAccountId,
        profileContentVersion,
        profileName,
        profileNameAccepted,
        profileText,
        profileTextAccepted,
        profileVersion,
        profileAge,
        profileLastSeenTimeValue,
        profileUnlimitedLikes,
        jsonProfileAttributes,
        primaryContentGridCropSize,
        primaryContentGridCropX,
        primaryContentGridCropY,
        profileDataRefreshTime,
        newLikeInfoReceivedTime
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'profiles';
  @override
  VerificationContext validateIntegrity(Insertable<Profile> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('profile_name')) {
      context.handle(
          _profileNameMeta,
          profileName.isAcceptableOrUnknown(
              data['profile_name']!, _profileNameMeta));
    }
    if (data.containsKey('profile_name_accepted')) {
      context.handle(
          _profileNameAcceptedMeta,
          profileNameAccepted.isAcceptableOrUnknown(
              data['profile_name_accepted']!, _profileNameAcceptedMeta));
    }
    if (data.containsKey('profile_text')) {
      context.handle(
          _profileTextMeta,
          profileText.isAcceptableOrUnknown(
              data['profile_text']!, _profileTextMeta));
    }
    if (data.containsKey('profile_text_accepted')) {
      context.handle(
          _profileTextAcceptedMeta,
          profileTextAccepted.isAcceptableOrUnknown(
              data['profile_text_accepted']!, _profileTextAcceptedMeta));
    }
    if (data.containsKey('profile_age')) {
      context.handle(
          _profileAgeMeta,
          profileAge.isAcceptableOrUnknown(
              data['profile_age']!, _profileAgeMeta));
    }
    if (data.containsKey('profile_last_seen_time_value')) {
      context.handle(
          _profileLastSeenTimeValueMeta,
          profileLastSeenTimeValue.isAcceptableOrUnknown(
              data['profile_last_seen_time_value']!,
              _profileLastSeenTimeValueMeta));
    }
    if (data.containsKey('profile_unlimited_likes')) {
      context.handle(
          _profileUnlimitedLikesMeta,
          profileUnlimitedLikes.isAcceptableOrUnknown(
              data['profile_unlimited_likes']!, _profileUnlimitedLikesMeta));
    }
    if (data.containsKey('primary_content_grid_crop_size')) {
      context.handle(
          _primaryContentGridCropSizeMeta,
          primaryContentGridCropSize.isAcceptableOrUnknown(
              data['primary_content_grid_crop_size']!,
              _primaryContentGridCropSizeMeta));
    }
    if (data.containsKey('primary_content_grid_crop_x')) {
      context.handle(
          _primaryContentGridCropXMeta,
          primaryContentGridCropX.isAcceptableOrUnknown(
              data['primary_content_grid_crop_x']!,
              _primaryContentGridCropXMeta));
    }
    if (data.containsKey('primary_content_grid_crop_y')) {
      context.handle(
          _primaryContentGridCropYMeta,
          primaryContentGridCropY.isAcceptableOrUnknown(
              data['primary_content_grid_crop_y']!,
              _primaryContentGridCropYMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Profile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Profile(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      uuidAccountId: $ProfilesTable.$converteruuidAccountId.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}uuid_account_id'])!),
      profileContentVersion: $ProfilesTable.$converterprofileContentVersion
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}profile_content_version'])),
      profileName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}profile_name']),
      profileNameAccepted: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}profile_name_accepted']),
      profileText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}profile_text']),
      profileTextAccepted: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}profile_text_accepted']),
      profileVersion: $ProfilesTable.$converterprofileVersion.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}profile_version'])),
      profileAge: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}profile_age']),
      profileLastSeenTimeValue: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}profile_last_seen_time_value']),
      profileUnlimitedLikes: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}profile_unlimited_likes']),
      jsonProfileAttributes: $ProfilesTable.$converterjsonProfileAttributes
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}json_profile_attributes'])),
      primaryContentGridCropSize: attachedDatabase.typeMapping.read(
          DriftSqlType.double,
          data['${effectivePrefix}primary_content_grid_crop_size']),
      primaryContentGridCropX: attachedDatabase.typeMapping.read(
          DriftSqlType.double,
          data['${effectivePrefix}primary_content_grid_crop_x']),
      primaryContentGridCropY: attachedDatabase.typeMapping.read(
          DriftSqlType.double,
          data['${effectivePrefix}primary_content_grid_crop_y']),
      profileDataRefreshTime: $ProfilesTable.$converterprofileDataRefreshTime
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.int,
              data['${effectivePrefix}profile_data_refresh_time'])),
      newLikeInfoReceivedTime: $ProfilesTable.$converternewLikeInfoReceivedTime
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.int,
              data['${effectivePrefix}new_like_info_received_time'])),
    );
  }

  @override
  $ProfilesTable createAlias(String alias) {
    return $ProfilesTable(attachedDatabase, alias);
  }

  static TypeConverter<api.AccountId, String> $converteruuidAccountId =
      const AccountIdConverter();
  static TypeConverter<api.ProfileContentVersion?, String?>
      $converterprofileContentVersion =
      const NullAwareTypeConverter.wrap(ProfileContentVersionConverter());
  static TypeConverter<api.ProfileVersion?, String?> $converterprofileVersion =
      const NullAwareTypeConverter.wrap(ProfileVersionConverter());
  static TypeConverter<JsonList?, String?> $converterjsonProfileAttributes =
      NullAwareTypeConverter.wrap(JsonList.driftConverter);
  static TypeConverter<UtcDateTime?, int?> $converterprofileDataRefreshTime =
      const NullAwareTypeConverter.wrap(UtcDateTimeConverter());
  static TypeConverter<UtcDateTime?, int?> $converternewLikeInfoReceivedTime =
      const NullAwareTypeConverter.wrap(UtcDateTimeConverter());
}

class Profile extends DataClass implements Insertable<Profile> {
  final int id;
  final api.AccountId uuidAccountId;
  final api.ProfileContentVersion? profileContentVersion;
  final String? profileName;
  final bool? profileNameAccepted;
  final String? profileText;
  final bool? profileTextAccepted;
  final api.ProfileVersion? profileVersion;
  final int? profileAge;
  final int? profileLastSeenTimeValue;
  final bool? profileUnlimitedLikes;
  final JsonList? jsonProfileAttributes;
  final double? primaryContentGridCropSize;
  final double? primaryContentGridCropX;
  final double? primaryContentGridCropY;
  final UtcDateTime? profileDataRefreshTime;
  final UtcDateTime? newLikeInfoReceivedTime;
  const Profile(
      {required this.id,
      required this.uuidAccountId,
      this.profileContentVersion,
      this.profileName,
      this.profileNameAccepted,
      this.profileText,
      this.profileTextAccepted,
      this.profileVersion,
      this.profileAge,
      this.profileLastSeenTimeValue,
      this.profileUnlimitedLikes,
      this.jsonProfileAttributes,
      this.primaryContentGridCropSize,
      this.primaryContentGridCropX,
      this.primaryContentGridCropY,
      this.profileDataRefreshTime,
      this.newLikeInfoReceivedTime});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['uuid_account_id'] = Variable<String>(
          $ProfilesTable.$converteruuidAccountId.toSql(uuidAccountId));
    }
    if (!nullToAbsent || profileContentVersion != null) {
      map['profile_content_version'] = Variable<String>($ProfilesTable
          .$converterprofileContentVersion
          .toSql(profileContentVersion));
    }
    if (!nullToAbsent || profileName != null) {
      map['profile_name'] = Variable<String>(profileName);
    }
    if (!nullToAbsent || profileNameAccepted != null) {
      map['profile_name_accepted'] = Variable<bool>(profileNameAccepted);
    }
    if (!nullToAbsent || profileText != null) {
      map['profile_text'] = Variable<String>(profileText);
    }
    if (!nullToAbsent || profileTextAccepted != null) {
      map['profile_text_accepted'] = Variable<bool>(profileTextAccepted);
    }
    if (!nullToAbsent || profileVersion != null) {
      map['profile_version'] = Variable<String>(
          $ProfilesTable.$converterprofileVersion.toSql(profileVersion));
    }
    if (!nullToAbsent || profileAge != null) {
      map['profile_age'] = Variable<int>(profileAge);
    }
    if (!nullToAbsent || profileLastSeenTimeValue != null) {
      map['profile_last_seen_time_value'] =
          Variable<int>(profileLastSeenTimeValue);
    }
    if (!nullToAbsent || profileUnlimitedLikes != null) {
      map['profile_unlimited_likes'] = Variable<bool>(profileUnlimitedLikes);
    }
    if (!nullToAbsent || jsonProfileAttributes != null) {
      map['json_profile_attributes'] = Variable<String>($ProfilesTable
          .$converterjsonProfileAttributes
          .toSql(jsonProfileAttributes));
    }
    if (!nullToAbsent || primaryContentGridCropSize != null) {
      map['primary_content_grid_crop_size'] =
          Variable<double>(primaryContentGridCropSize);
    }
    if (!nullToAbsent || primaryContentGridCropX != null) {
      map['primary_content_grid_crop_x'] =
          Variable<double>(primaryContentGridCropX);
    }
    if (!nullToAbsent || primaryContentGridCropY != null) {
      map['primary_content_grid_crop_y'] =
          Variable<double>(primaryContentGridCropY);
    }
    if (!nullToAbsent || profileDataRefreshTime != null) {
      map['profile_data_refresh_time'] = Variable<int>($ProfilesTable
          .$converterprofileDataRefreshTime
          .toSql(profileDataRefreshTime));
    }
    if (!nullToAbsent || newLikeInfoReceivedTime != null) {
      map['new_like_info_received_time'] = Variable<int>($ProfilesTable
          .$converternewLikeInfoReceivedTime
          .toSql(newLikeInfoReceivedTime));
    }
    return map;
  }

  ProfilesCompanion toCompanion(bool nullToAbsent) {
    return ProfilesCompanion(
      id: Value(id),
      uuidAccountId: Value(uuidAccountId),
      profileContentVersion: profileContentVersion == null && nullToAbsent
          ? const Value.absent()
          : Value(profileContentVersion),
      profileName: profileName == null && nullToAbsent
          ? const Value.absent()
          : Value(profileName),
      profileNameAccepted: profileNameAccepted == null && nullToAbsent
          ? const Value.absent()
          : Value(profileNameAccepted),
      profileText: profileText == null && nullToAbsent
          ? const Value.absent()
          : Value(profileText),
      profileTextAccepted: profileTextAccepted == null && nullToAbsent
          ? const Value.absent()
          : Value(profileTextAccepted),
      profileVersion: profileVersion == null && nullToAbsent
          ? const Value.absent()
          : Value(profileVersion),
      profileAge: profileAge == null && nullToAbsent
          ? const Value.absent()
          : Value(profileAge),
      profileLastSeenTimeValue: profileLastSeenTimeValue == null && nullToAbsent
          ? const Value.absent()
          : Value(profileLastSeenTimeValue),
      profileUnlimitedLikes: profileUnlimitedLikes == null && nullToAbsent
          ? const Value.absent()
          : Value(profileUnlimitedLikes),
      jsonProfileAttributes: jsonProfileAttributes == null && nullToAbsent
          ? const Value.absent()
          : Value(jsonProfileAttributes),
      primaryContentGridCropSize:
          primaryContentGridCropSize == null && nullToAbsent
              ? const Value.absent()
              : Value(primaryContentGridCropSize),
      primaryContentGridCropX: primaryContentGridCropX == null && nullToAbsent
          ? const Value.absent()
          : Value(primaryContentGridCropX),
      primaryContentGridCropY: primaryContentGridCropY == null && nullToAbsent
          ? const Value.absent()
          : Value(primaryContentGridCropY),
      profileDataRefreshTime: profileDataRefreshTime == null && nullToAbsent
          ? const Value.absent()
          : Value(profileDataRefreshTime),
      newLikeInfoReceivedTime: newLikeInfoReceivedTime == null && nullToAbsent
          ? const Value.absent()
          : Value(newLikeInfoReceivedTime),
    );
  }

  factory Profile.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Profile(
      id: serializer.fromJson<int>(json['id']),
      uuidAccountId: serializer.fromJson<api.AccountId>(json['uuidAccountId']),
      profileContentVersion: serializer
          .fromJson<api.ProfileContentVersion?>(json['profileContentVersion']),
      profileName: serializer.fromJson<String?>(json['profileName']),
      profileNameAccepted:
          serializer.fromJson<bool?>(json['profileNameAccepted']),
      profileText: serializer.fromJson<String?>(json['profileText']),
      profileTextAccepted:
          serializer.fromJson<bool?>(json['profileTextAccepted']),
      profileVersion:
          serializer.fromJson<api.ProfileVersion?>(json['profileVersion']),
      profileAge: serializer.fromJson<int?>(json['profileAge']),
      profileLastSeenTimeValue:
          serializer.fromJson<int?>(json['profileLastSeenTimeValue']),
      profileUnlimitedLikes:
          serializer.fromJson<bool?>(json['profileUnlimitedLikes']),
      jsonProfileAttributes:
          serializer.fromJson<JsonList?>(json['jsonProfileAttributes']),
      primaryContentGridCropSize:
          serializer.fromJson<double?>(json['primaryContentGridCropSize']),
      primaryContentGridCropX:
          serializer.fromJson<double?>(json['primaryContentGridCropX']),
      primaryContentGridCropY:
          serializer.fromJson<double?>(json['primaryContentGridCropY']),
      profileDataRefreshTime:
          serializer.fromJson<UtcDateTime?>(json['profileDataRefreshTime']),
      newLikeInfoReceivedTime:
          serializer.fromJson<UtcDateTime?>(json['newLikeInfoReceivedTime']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uuidAccountId': serializer.toJson<api.AccountId>(uuidAccountId),
      'profileContentVersion':
          serializer.toJson<api.ProfileContentVersion?>(profileContentVersion),
      'profileName': serializer.toJson<String?>(profileName),
      'profileNameAccepted': serializer.toJson<bool?>(profileNameAccepted),
      'profileText': serializer.toJson<String?>(profileText),
      'profileTextAccepted': serializer.toJson<bool?>(profileTextAccepted),
      'profileVersion': serializer.toJson<api.ProfileVersion?>(profileVersion),
      'profileAge': serializer.toJson<int?>(profileAge),
      'profileLastSeenTimeValue':
          serializer.toJson<int?>(profileLastSeenTimeValue),
      'profileUnlimitedLikes': serializer.toJson<bool?>(profileUnlimitedLikes),
      'jsonProfileAttributes':
          serializer.toJson<JsonList?>(jsonProfileAttributes),
      'primaryContentGridCropSize':
          serializer.toJson<double?>(primaryContentGridCropSize),
      'primaryContentGridCropX':
          serializer.toJson<double?>(primaryContentGridCropX),
      'primaryContentGridCropY':
          serializer.toJson<double?>(primaryContentGridCropY),
      'profileDataRefreshTime':
          serializer.toJson<UtcDateTime?>(profileDataRefreshTime),
      'newLikeInfoReceivedTime':
          serializer.toJson<UtcDateTime?>(newLikeInfoReceivedTime),
    };
  }

  Profile copyWith(
          {int? id,
          api.AccountId? uuidAccountId,
          Value<api.ProfileContentVersion?> profileContentVersion =
              const Value.absent(),
          Value<String?> profileName = const Value.absent(),
          Value<bool?> profileNameAccepted = const Value.absent(),
          Value<String?> profileText = const Value.absent(),
          Value<bool?> profileTextAccepted = const Value.absent(),
          Value<api.ProfileVersion?> profileVersion = const Value.absent(),
          Value<int?> profileAge = const Value.absent(),
          Value<int?> profileLastSeenTimeValue = const Value.absent(),
          Value<bool?> profileUnlimitedLikes = const Value.absent(),
          Value<JsonList?> jsonProfileAttributes = const Value.absent(),
          Value<double?> primaryContentGridCropSize = const Value.absent(),
          Value<double?> primaryContentGridCropX = const Value.absent(),
          Value<double?> primaryContentGridCropY = const Value.absent(),
          Value<UtcDateTime?> profileDataRefreshTime = const Value.absent(),
          Value<UtcDateTime?> newLikeInfoReceivedTime =
              const Value.absent()}) =>
      Profile(
        id: id ?? this.id,
        uuidAccountId: uuidAccountId ?? this.uuidAccountId,
        profileContentVersion: profileContentVersion.present
            ? profileContentVersion.value
            : this.profileContentVersion,
        profileName: profileName.present ? profileName.value : this.profileName,
        profileNameAccepted: profileNameAccepted.present
            ? profileNameAccepted.value
            : this.profileNameAccepted,
        profileText: profileText.present ? profileText.value : this.profileText,
        profileTextAccepted: profileTextAccepted.present
            ? profileTextAccepted.value
            : this.profileTextAccepted,
        profileVersion:
            profileVersion.present ? profileVersion.value : this.profileVersion,
        profileAge: profileAge.present ? profileAge.value : this.profileAge,
        profileLastSeenTimeValue: profileLastSeenTimeValue.present
            ? profileLastSeenTimeValue.value
            : this.profileLastSeenTimeValue,
        profileUnlimitedLikes: profileUnlimitedLikes.present
            ? profileUnlimitedLikes.value
            : this.profileUnlimitedLikes,
        jsonProfileAttributes: jsonProfileAttributes.present
            ? jsonProfileAttributes.value
            : this.jsonProfileAttributes,
        primaryContentGridCropSize: primaryContentGridCropSize.present
            ? primaryContentGridCropSize.value
            : this.primaryContentGridCropSize,
        primaryContentGridCropX: primaryContentGridCropX.present
            ? primaryContentGridCropX.value
            : this.primaryContentGridCropX,
        primaryContentGridCropY: primaryContentGridCropY.present
            ? primaryContentGridCropY.value
            : this.primaryContentGridCropY,
        profileDataRefreshTime: profileDataRefreshTime.present
            ? profileDataRefreshTime.value
            : this.profileDataRefreshTime,
        newLikeInfoReceivedTime: newLikeInfoReceivedTime.present
            ? newLikeInfoReceivedTime.value
            : this.newLikeInfoReceivedTime,
      );
  Profile copyWithCompanion(ProfilesCompanion data) {
    return Profile(
      id: data.id.present ? data.id.value : this.id,
      uuidAccountId: data.uuidAccountId.present
          ? data.uuidAccountId.value
          : this.uuidAccountId,
      profileContentVersion: data.profileContentVersion.present
          ? data.profileContentVersion.value
          : this.profileContentVersion,
      profileName:
          data.profileName.present ? data.profileName.value : this.profileName,
      profileNameAccepted: data.profileNameAccepted.present
          ? data.profileNameAccepted.value
          : this.profileNameAccepted,
      profileText:
          data.profileText.present ? data.profileText.value : this.profileText,
      profileTextAccepted: data.profileTextAccepted.present
          ? data.profileTextAccepted.value
          : this.profileTextAccepted,
      profileVersion: data.profileVersion.present
          ? data.profileVersion.value
          : this.profileVersion,
      profileAge:
          data.profileAge.present ? data.profileAge.value : this.profileAge,
      profileLastSeenTimeValue: data.profileLastSeenTimeValue.present
          ? data.profileLastSeenTimeValue.value
          : this.profileLastSeenTimeValue,
      profileUnlimitedLikes: data.profileUnlimitedLikes.present
          ? data.profileUnlimitedLikes.value
          : this.profileUnlimitedLikes,
      jsonProfileAttributes: data.jsonProfileAttributes.present
          ? data.jsonProfileAttributes.value
          : this.jsonProfileAttributes,
      primaryContentGridCropSize: data.primaryContentGridCropSize.present
          ? data.primaryContentGridCropSize.value
          : this.primaryContentGridCropSize,
      primaryContentGridCropX: data.primaryContentGridCropX.present
          ? data.primaryContentGridCropX.value
          : this.primaryContentGridCropX,
      primaryContentGridCropY: data.primaryContentGridCropY.present
          ? data.primaryContentGridCropY.value
          : this.primaryContentGridCropY,
      profileDataRefreshTime: data.profileDataRefreshTime.present
          ? data.profileDataRefreshTime.value
          : this.profileDataRefreshTime,
      newLikeInfoReceivedTime: data.newLikeInfoReceivedTime.present
          ? data.newLikeInfoReceivedTime.value
          : this.newLikeInfoReceivedTime,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Profile(')
          ..write('id: $id, ')
          ..write('uuidAccountId: $uuidAccountId, ')
          ..write('profileContentVersion: $profileContentVersion, ')
          ..write('profileName: $profileName, ')
          ..write('profileNameAccepted: $profileNameAccepted, ')
          ..write('profileText: $profileText, ')
          ..write('profileTextAccepted: $profileTextAccepted, ')
          ..write('profileVersion: $profileVersion, ')
          ..write('profileAge: $profileAge, ')
          ..write('profileLastSeenTimeValue: $profileLastSeenTimeValue, ')
          ..write('profileUnlimitedLikes: $profileUnlimitedLikes, ')
          ..write('jsonProfileAttributes: $jsonProfileAttributes, ')
          ..write('primaryContentGridCropSize: $primaryContentGridCropSize, ')
          ..write('primaryContentGridCropX: $primaryContentGridCropX, ')
          ..write('primaryContentGridCropY: $primaryContentGridCropY, ')
          ..write('profileDataRefreshTime: $profileDataRefreshTime, ')
          ..write('newLikeInfoReceivedTime: $newLikeInfoReceivedTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      uuidAccountId,
      profileContentVersion,
      profileName,
      profileNameAccepted,
      profileText,
      profileTextAccepted,
      profileVersion,
      profileAge,
      profileLastSeenTimeValue,
      profileUnlimitedLikes,
      jsonProfileAttributes,
      primaryContentGridCropSize,
      primaryContentGridCropX,
      primaryContentGridCropY,
      profileDataRefreshTime,
      newLikeInfoReceivedTime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Profile &&
          other.id == this.id &&
          other.uuidAccountId == this.uuidAccountId &&
          other.profileContentVersion == this.profileContentVersion &&
          other.profileName == this.profileName &&
          other.profileNameAccepted == this.profileNameAccepted &&
          other.profileText == this.profileText &&
          other.profileTextAccepted == this.profileTextAccepted &&
          other.profileVersion == this.profileVersion &&
          other.profileAge == this.profileAge &&
          other.profileLastSeenTimeValue == this.profileLastSeenTimeValue &&
          other.profileUnlimitedLikes == this.profileUnlimitedLikes &&
          other.jsonProfileAttributes == this.jsonProfileAttributes &&
          other.primaryContentGridCropSize == this.primaryContentGridCropSize &&
          other.primaryContentGridCropX == this.primaryContentGridCropX &&
          other.primaryContentGridCropY == this.primaryContentGridCropY &&
          other.profileDataRefreshTime == this.profileDataRefreshTime &&
          other.newLikeInfoReceivedTime == this.newLikeInfoReceivedTime);
}

class ProfilesCompanion extends UpdateCompanion<Profile> {
  final Value<int> id;
  final Value<api.AccountId> uuidAccountId;
  final Value<api.ProfileContentVersion?> profileContentVersion;
  final Value<String?> profileName;
  final Value<bool?> profileNameAccepted;
  final Value<String?> profileText;
  final Value<bool?> profileTextAccepted;
  final Value<api.ProfileVersion?> profileVersion;
  final Value<int?> profileAge;
  final Value<int?> profileLastSeenTimeValue;
  final Value<bool?> profileUnlimitedLikes;
  final Value<JsonList?> jsonProfileAttributes;
  final Value<double?> primaryContentGridCropSize;
  final Value<double?> primaryContentGridCropX;
  final Value<double?> primaryContentGridCropY;
  final Value<UtcDateTime?> profileDataRefreshTime;
  final Value<UtcDateTime?> newLikeInfoReceivedTime;
  const ProfilesCompanion({
    this.id = const Value.absent(),
    this.uuidAccountId = const Value.absent(),
    this.profileContentVersion = const Value.absent(),
    this.profileName = const Value.absent(),
    this.profileNameAccepted = const Value.absent(),
    this.profileText = const Value.absent(),
    this.profileTextAccepted = const Value.absent(),
    this.profileVersion = const Value.absent(),
    this.profileAge = const Value.absent(),
    this.profileLastSeenTimeValue = const Value.absent(),
    this.profileUnlimitedLikes = const Value.absent(),
    this.jsonProfileAttributes = const Value.absent(),
    this.primaryContentGridCropSize = const Value.absent(),
    this.primaryContentGridCropX = const Value.absent(),
    this.primaryContentGridCropY = const Value.absent(),
    this.profileDataRefreshTime = const Value.absent(),
    this.newLikeInfoReceivedTime = const Value.absent(),
  });
  ProfilesCompanion.insert({
    this.id = const Value.absent(),
    required api.AccountId uuidAccountId,
    this.profileContentVersion = const Value.absent(),
    this.profileName = const Value.absent(),
    this.profileNameAccepted = const Value.absent(),
    this.profileText = const Value.absent(),
    this.profileTextAccepted = const Value.absent(),
    this.profileVersion = const Value.absent(),
    this.profileAge = const Value.absent(),
    this.profileLastSeenTimeValue = const Value.absent(),
    this.profileUnlimitedLikes = const Value.absent(),
    this.jsonProfileAttributes = const Value.absent(),
    this.primaryContentGridCropSize = const Value.absent(),
    this.primaryContentGridCropX = const Value.absent(),
    this.primaryContentGridCropY = const Value.absent(),
    this.profileDataRefreshTime = const Value.absent(),
    this.newLikeInfoReceivedTime = const Value.absent(),
  }) : uuidAccountId = Value(uuidAccountId);
  static Insertable<Profile> custom({
    Expression<int>? id,
    Expression<String>? uuidAccountId,
    Expression<String>? profileContentVersion,
    Expression<String>? profileName,
    Expression<bool>? profileNameAccepted,
    Expression<String>? profileText,
    Expression<bool>? profileTextAccepted,
    Expression<String>? profileVersion,
    Expression<int>? profileAge,
    Expression<int>? profileLastSeenTimeValue,
    Expression<bool>? profileUnlimitedLikes,
    Expression<String>? jsonProfileAttributes,
    Expression<double>? primaryContentGridCropSize,
    Expression<double>? primaryContentGridCropX,
    Expression<double>? primaryContentGridCropY,
    Expression<int>? profileDataRefreshTime,
    Expression<int>? newLikeInfoReceivedTime,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuidAccountId != null) 'uuid_account_id': uuidAccountId,
      if (profileContentVersion != null)
        'profile_content_version': profileContentVersion,
      if (profileName != null) 'profile_name': profileName,
      if (profileNameAccepted != null)
        'profile_name_accepted': profileNameAccepted,
      if (profileText != null) 'profile_text': profileText,
      if (profileTextAccepted != null)
        'profile_text_accepted': profileTextAccepted,
      if (profileVersion != null) 'profile_version': profileVersion,
      if (profileAge != null) 'profile_age': profileAge,
      if (profileLastSeenTimeValue != null)
        'profile_last_seen_time_value': profileLastSeenTimeValue,
      if (profileUnlimitedLikes != null)
        'profile_unlimited_likes': profileUnlimitedLikes,
      if (jsonProfileAttributes != null)
        'json_profile_attributes': jsonProfileAttributes,
      if (primaryContentGridCropSize != null)
        'primary_content_grid_crop_size': primaryContentGridCropSize,
      if (primaryContentGridCropX != null)
        'primary_content_grid_crop_x': primaryContentGridCropX,
      if (primaryContentGridCropY != null)
        'primary_content_grid_crop_y': primaryContentGridCropY,
      if (profileDataRefreshTime != null)
        'profile_data_refresh_time': profileDataRefreshTime,
      if (newLikeInfoReceivedTime != null)
        'new_like_info_received_time': newLikeInfoReceivedTime,
    });
  }

  ProfilesCompanion copyWith(
      {Value<int>? id,
      Value<api.AccountId>? uuidAccountId,
      Value<api.ProfileContentVersion?>? profileContentVersion,
      Value<String?>? profileName,
      Value<bool?>? profileNameAccepted,
      Value<String?>? profileText,
      Value<bool?>? profileTextAccepted,
      Value<api.ProfileVersion?>? profileVersion,
      Value<int?>? profileAge,
      Value<int?>? profileLastSeenTimeValue,
      Value<bool?>? profileUnlimitedLikes,
      Value<JsonList?>? jsonProfileAttributes,
      Value<double?>? primaryContentGridCropSize,
      Value<double?>? primaryContentGridCropX,
      Value<double?>? primaryContentGridCropY,
      Value<UtcDateTime?>? profileDataRefreshTime,
      Value<UtcDateTime?>? newLikeInfoReceivedTime}) {
    return ProfilesCompanion(
      id: id ?? this.id,
      uuidAccountId: uuidAccountId ?? this.uuidAccountId,
      profileContentVersion:
          profileContentVersion ?? this.profileContentVersion,
      profileName: profileName ?? this.profileName,
      profileNameAccepted: profileNameAccepted ?? this.profileNameAccepted,
      profileText: profileText ?? this.profileText,
      profileTextAccepted: profileTextAccepted ?? this.profileTextAccepted,
      profileVersion: profileVersion ?? this.profileVersion,
      profileAge: profileAge ?? this.profileAge,
      profileLastSeenTimeValue:
          profileLastSeenTimeValue ?? this.profileLastSeenTimeValue,
      profileUnlimitedLikes:
          profileUnlimitedLikes ?? this.profileUnlimitedLikes,
      jsonProfileAttributes:
          jsonProfileAttributes ?? this.jsonProfileAttributes,
      primaryContentGridCropSize:
          primaryContentGridCropSize ?? this.primaryContentGridCropSize,
      primaryContentGridCropX:
          primaryContentGridCropX ?? this.primaryContentGridCropX,
      primaryContentGridCropY:
          primaryContentGridCropY ?? this.primaryContentGridCropY,
      profileDataRefreshTime:
          profileDataRefreshTime ?? this.profileDataRefreshTime,
      newLikeInfoReceivedTime:
          newLikeInfoReceivedTime ?? this.newLikeInfoReceivedTime,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uuidAccountId.present) {
      map['uuid_account_id'] = Variable<String>(
          $ProfilesTable.$converteruuidAccountId.toSql(uuidAccountId.value));
    }
    if (profileContentVersion.present) {
      map['profile_content_version'] = Variable<String>($ProfilesTable
          .$converterprofileContentVersion
          .toSql(profileContentVersion.value));
    }
    if (profileName.present) {
      map['profile_name'] = Variable<String>(profileName.value);
    }
    if (profileNameAccepted.present) {
      map['profile_name_accepted'] = Variable<bool>(profileNameAccepted.value);
    }
    if (profileText.present) {
      map['profile_text'] = Variable<String>(profileText.value);
    }
    if (profileTextAccepted.present) {
      map['profile_text_accepted'] = Variable<bool>(profileTextAccepted.value);
    }
    if (profileVersion.present) {
      map['profile_version'] = Variable<String>(
          $ProfilesTable.$converterprofileVersion.toSql(profileVersion.value));
    }
    if (profileAge.present) {
      map['profile_age'] = Variable<int>(profileAge.value);
    }
    if (profileLastSeenTimeValue.present) {
      map['profile_last_seen_time_value'] =
          Variable<int>(profileLastSeenTimeValue.value);
    }
    if (profileUnlimitedLikes.present) {
      map['profile_unlimited_likes'] =
          Variable<bool>(profileUnlimitedLikes.value);
    }
    if (jsonProfileAttributes.present) {
      map['json_profile_attributes'] = Variable<String>($ProfilesTable
          .$converterjsonProfileAttributes
          .toSql(jsonProfileAttributes.value));
    }
    if (primaryContentGridCropSize.present) {
      map['primary_content_grid_crop_size'] =
          Variable<double>(primaryContentGridCropSize.value);
    }
    if (primaryContentGridCropX.present) {
      map['primary_content_grid_crop_x'] =
          Variable<double>(primaryContentGridCropX.value);
    }
    if (primaryContentGridCropY.present) {
      map['primary_content_grid_crop_y'] =
          Variable<double>(primaryContentGridCropY.value);
    }
    if (profileDataRefreshTime.present) {
      map['profile_data_refresh_time'] = Variable<int>($ProfilesTable
          .$converterprofileDataRefreshTime
          .toSql(profileDataRefreshTime.value));
    }
    if (newLikeInfoReceivedTime.present) {
      map['new_like_info_received_time'] = Variable<int>($ProfilesTable
          .$converternewLikeInfoReceivedTime
          .toSql(newLikeInfoReceivedTime.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProfilesCompanion(')
          ..write('id: $id, ')
          ..write('uuidAccountId: $uuidAccountId, ')
          ..write('profileContentVersion: $profileContentVersion, ')
          ..write('profileName: $profileName, ')
          ..write('profileNameAccepted: $profileNameAccepted, ')
          ..write('profileText: $profileText, ')
          ..write('profileTextAccepted: $profileTextAccepted, ')
          ..write('profileVersion: $profileVersion, ')
          ..write('profileAge: $profileAge, ')
          ..write('profileLastSeenTimeValue: $profileLastSeenTimeValue, ')
          ..write('profileUnlimitedLikes: $profileUnlimitedLikes, ')
          ..write('jsonProfileAttributes: $jsonProfileAttributes, ')
          ..write('primaryContentGridCropSize: $primaryContentGridCropSize, ')
          ..write('primaryContentGridCropX: $primaryContentGridCropX, ')
          ..write('primaryContentGridCropY: $primaryContentGridCropY, ')
          ..write('profileDataRefreshTime: $profileDataRefreshTime, ')
          ..write('newLikeInfoReceivedTime: $newLikeInfoReceivedTime')
          ..write(')'))
        .toString();
  }
}

class $PublicProfileContentTable extends PublicProfileContent
    with TableInfo<$PublicProfileContentTable, PublicProfileContentData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PublicProfileContentTable(this.attachedDatabase, [this._alias]);
  @override
  late final GeneratedColumnWithTypeConverter<api.AccountId, String>
      uuidAccountId = GeneratedColumn<String>(
              'uuid_account_id', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<api.AccountId>(
              $PublicProfileContentTable.$converteruuidAccountId);
  static const VerificationMeta _contentIndexMeta =
      const VerificationMeta('contentIndex');
  @override
  late final GeneratedColumn<int> contentIndex = GeneratedColumn<int>(
      'content_index', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<api.ContentId, String>
      uuidContentId = GeneratedColumn<String>(
              'uuid_content_id', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<api.ContentId>(
              $PublicProfileContentTable.$converteruuidContentId);
  static const VerificationMeta _contentAcceptedMeta =
      const VerificationMeta('contentAccepted');
  @override
  late final GeneratedColumn<bool> contentAccepted = GeneratedColumn<bool>(
      'content_accepted', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("content_accepted" IN (0, 1))'));
  static const VerificationMeta _primaryContentMeta =
      const VerificationMeta('primaryContent');
  @override
  late final GeneratedColumn<bool> primaryContent = GeneratedColumn<bool>(
      'primary_content', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("primary_content" IN (0, 1))'));
  @override
  List<GeneratedColumn> get $columns => [
        uuidAccountId,
        contentIndex,
        uuidContentId,
        contentAccepted,
        primaryContent
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'public_profile_content';
  @override
  VerificationContext validateIntegrity(
      Insertable<PublicProfileContentData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('content_index')) {
      context.handle(
          _contentIndexMeta,
          contentIndex.isAcceptableOrUnknown(
              data['content_index']!, _contentIndexMeta));
    } else if (isInserting) {
      context.missing(_contentIndexMeta);
    }
    if (data.containsKey('content_accepted')) {
      context.handle(
          _contentAcceptedMeta,
          contentAccepted.isAcceptableOrUnknown(
              data['content_accepted']!, _contentAcceptedMeta));
    } else if (isInserting) {
      context.missing(_contentAcceptedMeta);
    }
    if (data.containsKey('primary_content')) {
      context.handle(
          _primaryContentMeta,
          primaryContent.isAcceptableOrUnknown(
              data['primary_content']!, _primaryContentMeta));
    } else if (isInserting) {
      context.missing(_primaryContentMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {uuidAccountId, contentIndex};
  @override
  PublicProfileContentData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PublicProfileContentData(
      uuidAccountId: $PublicProfileContentTable.$converteruuidAccountId.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}uuid_account_id'])!),
      contentIndex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}content_index'])!,
      uuidContentId: $PublicProfileContentTable.$converteruuidContentId.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}uuid_content_id'])!),
      contentAccepted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}content_accepted'])!,
      primaryContent: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}primary_content'])!,
    );
  }

  @override
  $PublicProfileContentTable createAlias(String alias) {
    return $PublicProfileContentTable(attachedDatabase, alias);
  }

  static TypeConverter<api.AccountId, String> $converteruuidAccountId =
      const AccountIdConverter();
  static TypeConverter<api.ContentId, String> $converteruuidContentId =
      const ContentIdConverter();
}

class PublicProfileContentData extends DataClass
    implements Insertable<PublicProfileContentData> {
  final api.AccountId uuidAccountId;
  final int contentIndex;
  final api.ContentId uuidContentId;
  final bool contentAccepted;
  final bool primaryContent;
  const PublicProfileContentData(
      {required this.uuidAccountId,
      required this.contentIndex,
      required this.uuidContentId,
      required this.contentAccepted,
      required this.primaryContent});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    {
      map['uuid_account_id'] = Variable<String>($PublicProfileContentTable
          .$converteruuidAccountId
          .toSql(uuidAccountId));
    }
    map['content_index'] = Variable<int>(contentIndex);
    {
      map['uuid_content_id'] = Variable<String>($PublicProfileContentTable
          .$converteruuidContentId
          .toSql(uuidContentId));
    }
    map['content_accepted'] = Variable<bool>(contentAccepted);
    map['primary_content'] = Variable<bool>(primaryContent);
    return map;
  }

  PublicProfileContentCompanion toCompanion(bool nullToAbsent) {
    return PublicProfileContentCompanion(
      uuidAccountId: Value(uuidAccountId),
      contentIndex: Value(contentIndex),
      uuidContentId: Value(uuidContentId),
      contentAccepted: Value(contentAccepted),
      primaryContent: Value(primaryContent),
    );
  }

  factory PublicProfileContentData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PublicProfileContentData(
      uuidAccountId: serializer.fromJson<api.AccountId>(json['uuidAccountId']),
      contentIndex: serializer.fromJson<int>(json['contentIndex']),
      uuidContentId: serializer.fromJson<api.ContentId>(json['uuidContentId']),
      contentAccepted: serializer.fromJson<bool>(json['contentAccepted']),
      primaryContent: serializer.fromJson<bool>(json['primaryContent']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uuidAccountId': serializer.toJson<api.AccountId>(uuidAccountId),
      'contentIndex': serializer.toJson<int>(contentIndex),
      'uuidContentId': serializer.toJson<api.ContentId>(uuidContentId),
      'contentAccepted': serializer.toJson<bool>(contentAccepted),
      'primaryContent': serializer.toJson<bool>(primaryContent),
    };
  }

  PublicProfileContentData copyWith(
          {api.AccountId? uuidAccountId,
          int? contentIndex,
          api.ContentId? uuidContentId,
          bool? contentAccepted,
          bool? primaryContent}) =>
      PublicProfileContentData(
        uuidAccountId: uuidAccountId ?? this.uuidAccountId,
        contentIndex: contentIndex ?? this.contentIndex,
        uuidContentId: uuidContentId ?? this.uuidContentId,
        contentAccepted: contentAccepted ?? this.contentAccepted,
        primaryContent: primaryContent ?? this.primaryContent,
      );
  PublicProfileContentData copyWithCompanion(
      PublicProfileContentCompanion data) {
    return PublicProfileContentData(
      uuidAccountId: data.uuidAccountId.present
          ? data.uuidAccountId.value
          : this.uuidAccountId,
      contentIndex: data.contentIndex.present
          ? data.contentIndex.value
          : this.contentIndex,
      uuidContentId: data.uuidContentId.present
          ? data.uuidContentId.value
          : this.uuidContentId,
      contentAccepted: data.contentAccepted.present
          ? data.contentAccepted.value
          : this.contentAccepted,
      primaryContent: data.primaryContent.present
          ? data.primaryContent.value
          : this.primaryContent,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PublicProfileContentData(')
          ..write('uuidAccountId: $uuidAccountId, ')
          ..write('contentIndex: $contentIndex, ')
          ..write('uuidContentId: $uuidContentId, ')
          ..write('contentAccepted: $contentAccepted, ')
          ..write('primaryContent: $primaryContent')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(uuidAccountId, contentIndex, uuidContentId,
      contentAccepted, primaryContent);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PublicProfileContentData &&
          other.uuidAccountId == this.uuidAccountId &&
          other.contentIndex == this.contentIndex &&
          other.uuidContentId == this.uuidContentId &&
          other.contentAccepted == this.contentAccepted &&
          other.primaryContent == this.primaryContent);
}

class PublicProfileContentCompanion
    extends UpdateCompanion<PublicProfileContentData> {
  final Value<api.AccountId> uuidAccountId;
  final Value<int> contentIndex;
  final Value<api.ContentId> uuidContentId;
  final Value<bool> contentAccepted;
  final Value<bool> primaryContent;
  final Value<int> rowid;
  const PublicProfileContentCompanion({
    this.uuidAccountId = const Value.absent(),
    this.contentIndex = const Value.absent(),
    this.uuidContentId = const Value.absent(),
    this.contentAccepted = const Value.absent(),
    this.primaryContent = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PublicProfileContentCompanion.insert({
    required api.AccountId uuidAccountId,
    required int contentIndex,
    required api.ContentId uuidContentId,
    required bool contentAccepted,
    required bool primaryContent,
    this.rowid = const Value.absent(),
  })  : uuidAccountId = Value(uuidAccountId),
        contentIndex = Value(contentIndex),
        uuidContentId = Value(uuidContentId),
        contentAccepted = Value(contentAccepted),
        primaryContent = Value(primaryContent);
  static Insertable<PublicProfileContentData> custom({
    Expression<String>? uuidAccountId,
    Expression<int>? contentIndex,
    Expression<String>? uuidContentId,
    Expression<bool>? contentAccepted,
    Expression<bool>? primaryContent,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (uuidAccountId != null) 'uuid_account_id': uuidAccountId,
      if (contentIndex != null) 'content_index': contentIndex,
      if (uuidContentId != null) 'uuid_content_id': uuidContentId,
      if (contentAccepted != null) 'content_accepted': contentAccepted,
      if (primaryContent != null) 'primary_content': primaryContent,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PublicProfileContentCompanion copyWith(
      {Value<api.AccountId>? uuidAccountId,
      Value<int>? contentIndex,
      Value<api.ContentId>? uuidContentId,
      Value<bool>? contentAccepted,
      Value<bool>? primaryContent,
      Value<int>? rowid}) {
    return PublicProfileContentCompanion(
      uuidAccountId: uuidAccountId ?? this.uuidAccountId,
      contentIndex: contentIndex ?? this.contentIndex,
      uuidContentId: uuidContentId ?? this.uuidContentId,
      contentAccepted: contentAccepted ?? this.contentAccepted,
      primaryContent: primaryContent ?? this.primaryContent,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uuidAccountId.present) {
      map['uuid_account_id'] = Variable<String>($PublicProfileContentTable
          .$converteruuidAccountId
          .toSql(uuidAccountId.value));
    }
    if (contentIndex.present) {
      map['content_index'] = Variable<int>(contentIndex.value);
    }
    if (uuidContentId.present) {
      map['uuid_content_id'] = Variable<String>($PublicProfileContentTable
          .$converteruuidContentId
          .toSql(uuidContentId.value));
    }
    if (contentAccepted.present) {
      map['content_accepted'] = Variable<bool>(contentAccepted.value);
    }
    if (primaryContent.present) {
      map['primary_content'] = Variable<bool>(primaryContent.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PublicProfileContentCompanion(')
          ..write('uuidAccountId: $uuidAccountId, ')
          ..write('contentIndex: $contentIndex, ')
          ..write('uuidContentId: $uuidContentId, ')
          ..write('contentAccepted: $contentAccepted, ')
          ..write('primaryContent: $primaryContent, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MyMediaContentTable extends MyMediaContent
    with TableInfo<$MyMediaContentTable, MyMediaContentData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MyMediaContentTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _contentIndexMeta =
      const VerificationMeta('contentIndex');
  @override
  late final GeneratedColumn<int> contentIndex = GeneratedColumn<int>(
      'content_index', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  late final GeneratedColumnWithTypeConverter<api.ContentId, String>
      uuidContentId = GeneratedColumn<String>(
              'uuid_content_id', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<api.ContentId>(
              $MyMediaContentTable.$converteruuidContentId);
  static const VerificationMeta _faceDetectedMeta =
      const VerificationMeta('faceDetected');
  @override
  late final GeneratedColumn<bool> faceDetected = GeneratedColumn<bool>(
      'face_detected', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("face_detected" IN (0, 1))'));
  @override
  late final GeneratedColumnWithTypeConverter<EnumString?, String>
      moderationState = GeneratedColumn<String>(
              'moderation_state', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<EnumString?>(
              $MyMediaContentTable.$convertermoderationState);
  @override
  late final GeneratedColumnWithTypeConverter<
      api.ProfileContentModerationRejectedReasonCategory?,
      int> contentModerationRejectedCategory = GeneratedColumn<int>(
          'content_moderation_rejected_category', aliasedName, true,
          type: DriftSqlType.int, requiredDuringInsert: false)
      .withConverter<api.ProfileContentModerationRejectedReasonCategory?>(
          $MyMediaContentTable.$convertercontentModerationRejectedCategory);
  @override
  late final GeneratedColumnWithTypeConverter<
      api.ProfileContentModerationRejectedReasonDetails?,
      String> contentModerationRejectedDetails = GeneratedColumn<String>(
          'content_moderation_rejected_details', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false)
      .withConverter<api.ProfileContentModerationRejectedReasonDetails?>(
          $MyMediaContentTable.$convertercontentModerationRejectedDetails);
  @override
  List<GeneratedColumn> get $columns => [
        contentIndex,
        uuidContentId,
        faceDetected,
        moderationState,
        contentModerationRejectedCategory,
        contentModerationRejectedDetails
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'my_media_content';
  @override
  VerificationContext validateIntegrity(Insertable<MyMediaContentData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('content_index')) {
      context.handle(
          _contentIndexMeta,
          contentIndex.isAcceptableOrUnknown(
              data['content_index']!, _contentIndexMeta));
    }
    if (data.containsKey('face_detected')) {
      context.handle(
          _faceDetectedMeta,
          faceDetected.isAcceptableOrUnknown(
              data['face_detected']!, _faceDetectedMeta));
    } else if (isInserting) {
      context.missing(_faceDetectedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {contentIndex};
  @override
  MyMediaContentData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MyMediaContentData(
      contentIndex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}content_index'])!,
      uuidContentId: $MyMediaContentTable.$converteruuidContentId.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}uuid_content_id'])!),
      faceDetected: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}face_detected'])!,
      moderationState: $MyMediaContentTable.$convertermoderationState.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}moderation_state'])),
      contentModerationRejectedCategory: $MyMediaContentTable
          .$convertercontentModerationRejectedCategory
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.int,
              data['${effectivePrefix}content_moderation_rejected_category'])),
      contentModerationRejectedDetails: $MyMediaContentTable
          .$convertercontentModerationRejectedDetails
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}content_moderation_rejected_details'])),
    );
  }

  @override
  $MyMediaContentTable createAlias(String alias) {
    return $MyMediaContentTable(attachedDatabase, alias);
  }

  static TypeConverter<api.ContentId, String> $converteruuidContentId =
      const ContentIdConverter();
  static TypeConverter<EnumString?, String?> $convertermoderationState =
      NullAwareTypeConverter.wrap(EnumString.driftConverter);
  static TypeConverter<api.ProfileContentModerationRejectedReasonCategory?,
          int?> $convertercontentModerationRejectedCategory =
      const NullAwareTypeConverter.wrap(
          ProfileContentModerationRejectedReasonCategoryConverter());
  static TypeConverter<api.ProfileContentModerationRejectedReasonDetails?,
          String?> $convertercontentModerationRejectedDetails =
      const NullAwareTypeConverter.wrap(
          ProfileContentModerationRejectedReasonDetailsConverter());
}

class MyMediaContentData extends DataClass
    implements Insertable<MyMediaContentData> {
  /// Security content has index -1. Profile content indexes start from 0.
  final int contentIndex;
  final api.ContentId uuidContentId;
  final bool faceDetected;
  final EnumString? moderationState;
  final api.ProfileContentModerationRejectedReasonCategory?
      contentModerationRejectedCategory;
  final api.ProfileContentModerationRejectedReasonDetails?
      contentModerationRejectedDetails;
  const MyMediaContentData(
      {required this.contentIndex,
      required this.uuidContentId,
      required this.faceDetected,
      this.moderationState,
      this.contentModerationRejectedCategory,
      this.contentModerationRejectedDetails});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['content_index'] = Variable<int>(contentIndex);
    {
      map['uuid_content_id'] = Variable<String>(
          $MyMediaContentTable.$converteruuidContentId.toSql(uuidContentId));
    }
    map['face_detected'] = Variable<bool>(faceDetected);
    if (!nullToAbsent || moderationState != null) {
      map['moderation_state'] = Variable<String>($MyMediaContentTable
          .$convertermoderationState
          .toSql(moderationState));
    }
    if (!nullToAbsent || contentModerationRejectedCategory != null) {
      map['content_moderation_rejected_category'] = Variable<int>(
          $MyMediaContentTable.$convertercontentModerationRejectedCategory
              .toSql(contentModerationRejectedCategory));
    }
    if (!nullToAbsent || contentModerationRejectedDetails != null) {
      map['content_moderation_rejected_details'] = Variable<String>(
          $MyMediaContentTable.$convertercontentModerationRejectedDetails
              .toSql(contentModerationRejectedDetails));
    }
    return map;
  }

  MyMediaContentCompanion toCompanion(bool nullToAbsent) {
    return MyMediaContentCompanion(
      contentIndex: Value(contentIndex),
      uuidContentId: Value(uuidContentId),
      faceDetected: Value(faceDetected),
      moderationState: moderationState == null && nullToAbsent
          ? const Value.absent()
          : Value(moderationState),
      contentModerationRejectedCategory:
          contentModerationRejectedCategory == null && nullToAbsent
              ? const Value.absent()
              : Value(contentModerationRejectedCategory),
      contentModerationRejectedDetails:
          contentModerationRejectedDetails == null && nullToAbsent
              ? const Value.absent()
              : Value(contentModerationRejectedDetails),
    );
  }

  factory MyMediaContentData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MyMediaContentData(
      contentIndex: serializer.fromJson<int>(json['contentIndex']),
      uuidContentId: serializer.fromJson<api.ContentId>(json['uuidContentId']),
      faceDetected: serializer.fromJson<bool>(json['faceDetected']),
      moderationState:
          serializer.fromJson<EnumString?>(json['moderationState']),
      contentModerationRejectedCategory: serializer
          .fromJson<api.ProfileContentModerationRejectedReasonCategory?>(
              json['contentModerationRejectedCategory']),
      contentModerationRejectedDetails: serializer
          .fromJson<api.ProfileContentModerationRejectedReasonDetails?>(
              json['contentModerationRejectedDetails']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'contentIndex': serializer.toJson<int>(contentIndex),
      'uuidContentId': serializer.toJson<api.ContentId>(uuidContentId),
      'faceDetected': serializer.toJson<bool>(faceDetected),
      'moderationState': serializer.toJson<EnumString?>(moderationState),
      'contentModerationRejectedCategory': serializer
          .toJson<api.ProfileContentModerationRejectedReasonCategory?>(
              contentModerationRejectedCategory),
      'contentModerationRejectedDetails':
          serializer.toJson<api.ProfileContentModerationRejectedReasonDetails?>(
              contentModerationRejectedDetails),
    };
  }

  MyMediaContentData copyWith(
          {int? contentIndex,
          api.ContentId? uuidContentId,
          bool? faceDetected,
          Value<EnumString?> moderationState = const Value.absent(),
          Value<api.ProfileContentModerationRejectedReasonCategory?>
              contentModerationRejectedCategory = const Value.absent(),
          Value<api.ProfileContentModerationRejectedReasonDetails?>
              contentModerationRejectedDetails = const Value.absent()}) =>
      MyMediaContentData(
        contentIndex: contentIndex ?? this.contentIndex,
        uuidContentId: uuidContentId ?? this.uuidContentId,
        faceDetected: faceDetected ?? this.faceDetected,
        moderationState: moderationState.present
            ? moderationState.value
            : this.moderationState,
        contentModerationRejectedCategory:
            contentModerationRejectedCategory.present
                ? contentModerationRejectedCategory.value
                : this.contentModerationRejectedCategory,
        contentModerationRejectedDetails:
            contentModerationRejectedDetails.present
                ? contentModerationRejectedDetails.value
                : this.contentModerationRejectedDetails,
      );
  MyMediaContentData copyWithCompanion(MyMediaContentCompanion data) {
    return MyMediaContentData(
      contentIndex: data.contentIndex.present
          ? data.contentIndex.value
          : this.contentIndex,
      uuidContentId: data.uuidContentId.present
          ? data.uuidContentId.value
          : this.uuidContentId,
      faceDetected: data.faceDetected.present
          ? data.faceDetected.value
          : this.faceDetected,
      moderationState: data.moderationState.present
          ? data.moderationState.value
          : this.moderationState,
      contentModerationRejectedCategory:
          data.contentModerationRejectedCategory.present
              ? data.contentModerationRejectedCategory.value
              : this.contentModerationRejectedCategory,
      contentModerationRejectedDetails:
          data.contentModerationRejectedDetails.present
              ? data.contentModerationRejectedDetails.value
              : this.contentModerationRejectedDetails,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MyMediaContentData(')
          ..write('contentIndex: $contentIndex, ')
          ..write('uuidContentId: $uuidContentId, ')
          ..write('faceDetected: $faceDetected, ')
          ..write('moderationState: $moderationState, ')
          ..write(
              'contentModerationRejectedCategory: $contentModerationRejectedCategory, ')
          ..write(
              'contentModerationRejectedDetails: $contentModerationRejectedDetails')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      contentIndex,
      uuidContentId,
      faceDetected,
      moderationState,
      contentModerationRejectedCategory,
      contentModerationRejectedDetails);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MyMediaContentData &&
          other.contentIndex == this.contentIndex &&
          other.uuidContentId == this.uuidContentId &&
          other.faceDetected == this.faceDetected &&
          other.moderationState == this.moderationState &&
          other.contentModerationRejectedCategory ==
              this.contentModerationRejectedCategory &&
          other.contentModerationRejectedDetails ==
              this.contentModerationRejectedDetails);
}

class MyMediaContentCompanion extends UpdateCompanion<MyMediaContentData> {
  final Value<int> contentIndex;
  final Value<api.ContentId> uuidContentId;
  final Value<bool> faceDetected;
  final Value<EnumString?> moderationState;
  final Value<api.ProfileContentModerationRejectedReasonCategory?>
      contentModerationRejectedCategory;
  final Value<api.ProfileContentModerationRejectedReasonDetails?>
      contentModerationRejectedDetails;
  const MyMediaContentCompanion({
    this.contentIndex = const Value.absent(),
    this.uuidContentId = const Value.absent(),
    this.faceDetected = const Value.absent(),
    this.moderationState = const Value.absent(),
    this.contentModerationRejectedCategory = const Value.absent(),
    this.contentModerationRejectedDetails = const Value.absent(),
  });
  MyMediaContentCompanion.insert({
    this.contentIndex = const Value.absent(),
    required api.ContentId uuidContentId,
    required bool faceDetected,
    this.moderationState = const Value.absent(),
    this.contentModerationRejectedCategory = const Value.absent(),
    this.contentModerationRejectedDetails = const Value.absent(),
  })  : uuidContentId = Value(uuidContentId),
        faceDetected = Value(faceDetected);
  static Insertable<MyMediaContentData> custom({
    Expression<int>? contentIndex,
    Expression<String>? uuidContentId,
    Expression<bool>? faceDetected,
    Expression<String>? moderationState,
    Expression<int>? contentModerationRejectedCategory,
    Expression<String>? contentModerationRejectedDetails,
  }) {
    return RawValuesInsertable({
      if (contentIndex != null) 'content_index': contentIndex,
      if (uuidContentId != null) 'uuid_content_id': uuidContentId,
      if (faceDetected != null) 'face_detected': faceDetected,
      if (moderationState != null) 'moderation_state': moderationState,
      if (contentModerationRejectedCategory != null)
        'content_moderation_rejected_category':
            contentModerationRejectedCategory,
      if (contentModerationRejectedDetails != null)
        'content_moderation_rejected_details': contentModerationRejectedDetails,
    });
  }

  MyMediaContentCompanion copyWith(
      {Value<int>? contentIndex,
      Value<api.ContentId>? uuidContentId,
      Value<bool>? faceDetected,
      Value<EnumString?>? moderationState,
      Value<api.ProfileContentModerationRejectedReasonCategory?>?
          contentModerationRejectedCategory,
      Value<api.ProfileContentModerationRejectedReasonDetails?>?
          contentModerationRejectedDetails}) {
    return MyMediaContentCompanion(
      contentIndex: contentIndex ?? this.contentIndex,
      uuidContentId: uuidContentId ?? this.uuidContentId,
      faceDetected: faceDetected ?? this.faceDetected,
      moderationState: moderationState ?? this.moderationState,
      contentModerationRejectedCategory: contentModerationRejectedCategory ??
          this.contentModerationRejectedCategory,
      contentModerationRejectedDetails: contentModerationRejectedDetails ??
          this.contentModerationRejectedDetails,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (contentIndex.present) {
      map['content_index'] = Variable<int>(contentIndex.value);
    }
    if (uuidContentId.present) {
      map['uuid_content_id'] = Variable<String>($MyMediaContentTable
          .$converteruuidContentId
          .toSql(uuidContentId.value));
    }
    if (faceDetected.present) {
      map['face_detected'] = Variable<bool>(faceDetected.value);
    }
    if (moderationState.present) {
      map['moderation_state'] = Variable<String>($MyMediaContentTable
          .$convertermoderationState
          .toSql(moderationState.value));
    }
    if (contentModerationRejectedCategory.present) {
      map['content_moderation_rejected_category'] = Variable<int>(
          $MyMediaContentTable.$convertercontentModerationRejectedCategory
              .toSql(contentModerationRejectedCategory.value));
    }
    if (contentModerationRejectedDetails.present) {
      map['content_moderation_rejected_details'] = Variable<String>(
          $MyMediaContentTable.$convertercontentModerationRejectedDetails
              .toSql(contentModerationRejectedDetails.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MyMediaContentCompanion(')
          ..write('contentIndex: $contentIndex, ')
          ..write('uuidContentId: $uuidContentId, ')
          ..write('faceDetected: $faceDetected, ')
          ..write('moderationState: $moderationState, ')
          ..write(
              'contentModerationRejectedCategory: $contentModerationRejectedCategory, ')
          ..write(
              'contentModerationRejectedDetails: $contentModerationRejectedDetails')
          ..write(')'))
        .toString();
  }
}

class $ProfileStatesTable extends ProfileStates
    with TableInfo<$ProfileStatesTable, ProfileState> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProfileStatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  @override
  late final GeneratedColumnWithTypeConverter<api.AccountId, String>
      uuidAccountId = GeneratedColumn<String>(
              'uuid_account_id', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: true,
              defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'))
          .withConverter<api.AccountId>(
              $ProfileStatesTable.$converteruuidAccountId);
  @override
  late final GeneratedColumnWithTypeConverter<UtcDateTime?, int> isInFavorites =
      GeneratedColumn<int>('is_in_favorites', aliasedName, true,
              type: DriftSqlType.int, requiredDuringInsert: false)
          .withConverter<UtcDateTime?>(
              $ProfileStatesTable.$converterisInFavorites);
  @override
  late final GeneratedColumnWithTypeConverter<UtcDateTime?, int>
      isInReceivedLikes = GeneratedColumn<int>(
              'is_in_received_likes', aliasedName, true,
              type: DriftSqlType.int, requiredDuringInsert: false)
          .withConverter<UtcDateTime?>(
              $ProfileStatesTable.$converterisInReceivedLikes);
  @override
  late final GeneratedColumnWithTypeConverter<UtcDateTime?, int> isInSentLikes =
      GeneratedColumn<int>('is_in_sent_likes', aliasedName, true,
              type: DriftSqlType.int, requiredDuringInsert: false)
          .withConverter<UtcDateTime?>(
              $ProfileStatesTable.$converterisInSentLikes);
  @override
  late final GeneratedColumnWithTypeConverter<UtcDateTime?, int> isInMatches =
      GeneratedColumn<int>('is_in_matches', aliasedName, true,
              type: DriftSqlType.int, requiredDuringInsert: false)
          .withConverter<UtcDateTime?>(
              $ProfileStatesTable.$converterisInMatches);
  @override
  late final GeneratedColumnWithTypeConverter<UtcDateTime?, int>
      isInProfileGrid = GeneratedColumn<int>(
              'is_in_profile_grid', aliasedName, true,
              type: DriftSqlType.int, requiredDuringInsert: false)
          .withConverter<UtcDateTime?>(
              $ProfileStatesTable.$converterisInProfileGrid);
  @override
  late final GeneratedColumnWithTypeConverter<UtcDateTime?, int>
      isInAutomaticProfileSearchGrid = GeneratedColumn<int>(
              'is_in_automatic_profile_search_grid', aliasedName, true,
              type: DriftSqlType.int, requiredDuringInsert: false)
          .withConverter<UtcDateTime?>(
              $ProfileStatesTable.$converterisInAutomaticProfileSearchGrid);
  @override
  late final GeneratedColumnWithTypeConverter<UtcDateTime?, int>
      isInReceivedLikesGrid = GeneratedColumn<int>(
              'is_in_received_likes_grid', aliasedName, true,
              type: DriftSqlType.int, requiredDuringInsert: false)
          .withConverter<UtcDateTime?>(
              $ProfileStatesTable.$converterisInReceivedLikesGrid);
  @override
  late final GeneratedColumnWithTypeConverter<UtcDateTime?, int>
      isInMatchesGrid = GeneratedColumn<int>(
              'is_in_matches_grid', aliasedName, true,
              type: DriftSqlType.int, requiredDuringInsert: false)
          .withConverter<UtcDateTime?>(
              $ProfileStatesTable.$converterisInMatchesGrid);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        uuidAccountId,
        isInFavorites,
        isInReceivedLikes,
        isInSentLikes,
        isInMatches,
        isInProfileGrid,
        isInAutomaticProfileSearchGrid,
        isInReceivedLikesGrid,
        isInMatchesGrid
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'profile_states';
  @override
  VerificationContext validateIntegrity(Insertable<ProfileState> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProfileState map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProfileState(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      uuidAccountId: $ProfileStatesTable.$converteruuidAccountId.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}uuid_account_id'])!),
      isInFavorites: $ProfileStatesTable.$converterisInFavorites.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.int, data['${effectivePrefix}is_in_favorites'])),
      isInReceivedLikes: $ProfileStatesTable.$converterisInReceivedLikes
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.int,
              data['${effectivePrefix}is_in_received_likes'])),
      isInSentLikes: $ProfileStatesTable.$converterisInSentLikes.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.int, data['${effectivePrefix}is_in_sent_likes'])),
      isInMatches: $ProfileStatesTable.$converterisInMatches.fromSql(
          attachedDatabase.typeMapping
              .read(DriftSqlType.int, data['${effectivePrefix}is_in_matches'])),
      isInProfileGrid: $ProfileStatesTable.$converterisInProfileGrid.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.int, data['${effectivePrefix}is_in_profile_grid'])),
      isInAutomaticProfileSearchGrid: $ProfileStatesTable
          .$converterisInAutomaticProfileSearchGrid
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.int,
              data['${effectivePrefix}is_in_automatic_profile_search_grid'])),
      isInReceivedLikesGrid: $ProfileStatesTable.$converterisInReceivedLikesGrid
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.int,
              data['${effectivePrefix}is_in_received_likes_grid'])),
      isInMatchesGrid: $ProfileStatesTable.$converterisInMatchesGrid.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.int, data['${effectivePrefix}is_in_matches_grid'])),
    );
  }

  @override
  $ProfileStatesTable createAlias(String alias) {
    return $ProfileStatesTable(attachedDatabase, alias);
  }

  static TypeConverter<api.AccountId, String> $converteruuidAccountId =
      const AccountIdConverter();
  static TypeConverter<UtcDateTime?, int?> $converterisInFavorites =
      const NullAwareTypeConverter.wrap(UtcDateTimeConverter());
  static TypeConverter<UtcDateTime?, int?> $converterisInReceivedLikes =
      const NullAwareTypeConverter.wrap(UtcDateTimeConverter());
  static TypeConverter<UtcDateTime?, int?> $converterisInSentLikes =
      const NullAwareTypeConverter.wrap(UtcDateTimeConverter());
  static TypeConverter<UtcDateTime?, int?> $converterisInMatches =
      const NullAwareTypeConverter.wrap(UtcDateTimeConverter());
  static TypeConverter<UtcDateTime?, int?> $converterisInProfileGrid =
      const NullAwareTypeConverter.wrap(UtcDateTimeConverter());
  static TypeConverter<UtcDateTime?, int?>
      $converterisInAutomaticProfileSearchGrid =
      const NullAwareTypeConverter.wrap(UtcDateTimeConverter());
  static TypeConverter<UtcDateTime?, int?> $converterisInReceivedLikesGrid =
      const NullAwareTypeConverter.wrap(UtcDateTimeConverter());
  static TypeConverter<UtcDateTime?, int?> $converterisInMatchesGrid =
      const NullAwareTypeConverter.wrap(UtcDateTimeConverter());
}

class ProfileState extends DataClass implements Insertable<ProfileState> {
  final int id;
  final api.AccountId uuidAccountId;
  final UtcDateTime? isInFavorites;
  final UtcDateTime? isInReceivedLikes;
  final UtcDateTime? isInSentLikes;
  final UtcDateTime? isInMatches;
  final UtcDateTime? isInProfileGrid;
  final UtcDateTime? isInAutomaticProfileSearchGrid;
  final UtcDateTime? isInReceivedLikesGrid;
  final UtcDateTime? isInMatchesGrid;
  const ProfileState(
      {required this.id,
      required this.uuidAccountId,
      this.isInFavorites,
      this.isInReceivedLikes,
      this.isInSentLikes,
      this.isInMatches,
      this.isInProfileGrid,
      this.isInAutomaticProfileSearchGrid,
      this.isInReceivedLikesGrid,
      this.isInMatchesGrid});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['uuid_account_id'] = Variable<String>(
          $ProfileStatesTable.$converteruuidAccountId.toSql(uuidAccountId));
    }
    if (!nullToAbsent || isInFavorites != null) {
      map['is_in_favorites'] = Variable<int>(
          $ProfileStatesTable.$converterisInFavorites.toSql(isInFavorites));
    }
    if (!nullToAbsent || isInReceivedLikes != null) {
      map['is_in_received_likes'] = Variable<int>($ProfileStatesTable
          .$converterisInReceivedLikes
          .toSql(isInReceivedLikes));
    }
    if (!nullToAbsent || isInSentLikes != null) {
      map['is_in_sent_likes'] = Variable<int>(
          $ProfileStatesTable.$converterisInSentLikes.toSql(isInSentLikes));
    }
    if (!nullToAbsent || isInMatches != null) {
      map['is_in_matches'] = Variable<int>(
          $ProfileStatesTable.$converterisInMatches.toSql(isInMatches));
    }
    if (!nullToAbsent || isInProfileGrid != null) {
      map['is_in_profile_grid'] = Variable<int>(
          $ProfileStatesTable.$converterisInProfileGrid.toSql(isInProfileGrid));
    }
    if (!nullToAbsent || isInAutomaticProfileSearchGrid != null) {
      map['is_in_automatic_profile_search_grid'] = Variable<int>(
          $ProfileStatesTable.$converterisInAutomaticProfileSearchGrid
              .toSql(isInAutomaticProfileSearchGrid));
    }
    if (!nullToAbsent || isInReceivedLikesGrid != null) {
      map['is_in_received_likes_grid'] = Variable<int>($ProfileStatesTable
          .$converterisInReceivedLikesGrid
          .toSql(isInReceivedLikesGrid));
    }
    if (!nullToAbsent || isInMatchesGrid != null) {
      map['is_in_matches_grid'] = Variable<int>(
          $ProfileStatesTable.$converterisInMatchesGrid.toSql(isInMatchesGrid));
    }
    return map;
  }

  ProfileStatesCompanion toCompanion(bool nullToAbsent) {
    return ProfileStatesCompanion(
      id: Value(id),
      uuidAccountId: Value(uuidAccountId),
      isInFavorites: isInFavorites == null && nullToAbsent
          ? const Value.absent()
          : Value(isInFavorites),
      isInReceivedLikes: isInReceivedLikes == null && nullToAbsent
          ? const Value.absent()
          : Value(isInReceivedLikes),
      isInSentLikes: isInSentLikes == null && nullToAbsent
          ? const Value.absent()
          : Value(isInSentLikes),
      isInMatches: isInMatches == null && nullToAbsent
          ? const Value.absent()
          : Value(isInMatches),
      isInProfileGrid: isInProfileGrid == null && nullToAbsent
          ? const Value.absent()
          : Value(isInProfileGrid),
      isInAutomaticProfileSearchGrid:
          isInAutomaticProfileSearchGrid == null && nullToAbsent
              ? const Value.absent()
              : Value(isInAutomaticProfileSearchGrid),
      isInReceivedLikesGrid: isInReceivedLikesGrid == null && nullToAbsent
          ? const Value.absent()
          : Value(isInReceivedLikesGrid),
      isInMatchesGrid: isInMatchesGrid == null && nullToAbsent
          ? const Value.absent()
          : Value(isInMatchesGrid),
    );
  }

  factory ProfileState.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProfileState(
      id: serializer.fromJson<int>(json['id']),
      uuidAccountId: serializer.fromJson<api.AccountId>(json['uuidAccountId']),
      isInFavorites: serializer.fromJson<UtcDateTime?>(json['isInFavorites']),
      isInReceivedLikes:
          serializer.fromJson<UtcDateTime?>(json['isInReceivedLikes']),
      isInSentLikes: serializer.fromJson<UtcDateTime?>(json['isInSentLikes']),
      isInMatches: serializer.fromJson<UtcDateTime?>(json['isInMatches']),
      isInProfileGrid:
          serializer.fromJson<UtcDateTime?>(json['isInProfileGrid']),
      isInAutomaticProfileSearchGrid: serializer
          .fromJson<UtcDateTime?>(json['isInAutomaticProfileSearchGrid']),
      isInReceivedLikesGrid:
          serializer.fromJson<UtcDateTime?>(json['isInReceivedLikesGrid']),
      isInMatchesGrid:
          serializer.fromJson<UtcDateTime?>(json['isInMatchesGrid']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uuidAccountId': serializer.toJson<api.AccountId>(uuidAccountId),
      'isInFavorites': serializer.toJson<UtcDateTime?>(isInFavorites),
      'isInReceivedLikes': serializer.toJson<UtcDateTime?>(isInReceivedLikes),
      'isInSentLikes': serializer.toJson<UtcDateTime?>(isInSentLikes),
      'isInMatches': serializer.toJson<UtcDateTime?>(isInMatches),
      'isInProfileGrid': serializer.toJson<UtcDateTime?>(isInProfileGrid),
      'isInAutomaticProfileSearchGrid':
          serializer.toJson<UtcDateTime?>(isInAutomaticProfileSearchGrid),
      'isInReceivedLikesGrid':
          serializer.toJson<UtcDateTime?>(isInReceivedLikesGrid),
      'isInMatchesGrid': serializer.toJson<UtcDateTime?>(isInMatchesGrid),
    };
  }

  ProfileState copyWith(
          {int? id,
          api.AccountId? uuidAccountId,
          Value<UtcDateTime?> isInFavorites = const Value.absent(),
          Value<UtcDateTime?> isInReceivedLikes = const Value.absent(),
          Value<UtcDateTime?> isInSentLikes = const Value.absent(),
          Value<UtcDateTime?> isInMatches = const Value.absent(),
          Value<UtcDateTime?> isInProfileGrid = const Value.absent(),
          Value<UtcDateTime?> isInAutomaticProfileSearchGrid =
              const Value.absent(),
          Value<UtcDateTime?> isInReceivedLikesGrid = const Value.absent(),
          Value<UtcDateTime?> isInMatchesGrid = const Value.absent()}) =>
      ProfileState(
        id: id ?? this.id,
        uuidAccountId: uuidAccountId ?? this.uuidAccountId,
        isInFavorites:
            isInFavorites.present ? isInFavorites.value : this.isInFavorites,
        isInReceivedLikes: isInReceivedLikes.present
            ? isInReceivedLikes.value
            : this.isInReceivedLikes,
        isInSentLikes:
            isInSentLikes.present ? isInSentLikes.value : this.isInSentLikes,
        isInMatches: isInMatches.present ? isInMatches.value : this.isInMatches,
        isInProfileGrid: isInProfileGrid.present
            ? isInProfileGrid.value
            : this.isInProfileGrid,
        isInAutomaticProfileSearchGrid: isInAutomaticProfileSearchGrid.present
            ? isInAutomaticProfileSearchGrid.value
            : this.isInAutomaticProfileSearchGrid,
        isInReceivedLikesGrid: isInReceivedLikesGrid.present
            ? isInReceivedLikesGrid.value
            : this.isInReceivedLikesGrid,
        isInMatchesGrid: isInMatchesGrid.present
            ? isInMatchesGrid.value
            : this.isInMatchesGrid,
      );
  ProfileState copyWithCompanion(ProfileStatesCompanion data) {
    return ProfileState(
      id: data.id.present ? data.id.value : this.id,
      uuidAccountId: data.uuidAccountId.present
          ? data.uuidAccountId.value
          : this.uuidAccountId,
      isInFavorites: data.isInFavorites.present
          ? data.isInFavorites.value
          : this.isInFavorites,
      isInReceivedLikes: data.isInReceivedLikes.present
          ? data.isInReceivedLikes.value
          : this.isInReceivedLikes,
      isInSentLikes: data.isInSentLikes.present
          ? data.isInSentLikes.value
          : this.isInSentLikes,
      isInMatches:
          data.isInMatches.present ? data.isInMatches.value : this.isInMatches,
      isInProfileGrid: data.isInProfileGrid.present
          ? data.isInProfileGrid.value
          : this.isInProfileGrid,
      isInAutomaticProfileSearchGrid:
          data.isInAutomaticProfileSearchGrid.present
              ? data.isInAutomaticProfileSearchGrid.value
              : this.isInAutomaticProfileSearchGrid,
      isInReceivedLikesGrid: data.isInReceivedLikesGrid.present
          ? data.isInReceivedLikesGrid.value
          : this.isInReceivedLikesGrid,
      isInMatchesGrid: data.isInMatchesGrid.present
          ? data.isInMatchesGrid.value
          : this.isInMatchesGrid,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProfileState(')
          ..write('id: $id, ')
          ..write('uuidAccountId: $uuidAccountId, ')
          ..write('isInFavorites: $isInFavorites, ')
          ..write('isInReceivedLikes: $isInReceivedLikes, ')
          ..write('isInSentLikes: $isInSentLikes, ')
          ..write('isInMatches: $isInMatches, ')
          ..write('isInProfileGrid: $isInProfileGrid, ')
          ..write(
              'isInAutomaticProfileSearchGrid: $isInAutomaticProfileSearchGrid, ')
          ..write('isInReceivedLikesGrid: $isInReceivedLikesGrid, ')
          ..write('isInMatchesGrid: $isInMatchesGrid')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      uuidAccountId,
      isInFavorites,
      isInReceivedLikes,
      isInSentLikes,
      isInMatches,
      isInProfileGrid,
      isInAutomaticProfileSearchGrid,
      isInReceivedLikesGrid,
      isInMatchesGrid);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProfileState &&
          other.id == this.id &&
          other.uuidAccountId == this.uuidAccountId &&
          other.isInFavorites == this.isInFavorites &&
          other.isInReceivedLikes == this.isInReceivedLikes &&
          other.isInSentLikes == this.isInSentLikes &&
          other.isInMatches == this.isInMatches &&
          other.isInProfileGrid == this.isInProfileGrid &&
          other.isInAutomaticProfileSearchGrid ==
              this.isInAutomaticProfileSearchGrid &&
          other.isInReceivedLikesGrid == this.isInReceivedLikesGrid &&
          other.isInMatchesGrid == this.isInMatchesGrid);
}

class ProfileStatesCompanion extends UpdateCompanion<ProfileState> {
  final Value<int> id;
  final Value<api.AccountId> uuidAccountId;
  final Value<UtcDateTime?> isInFavorites;
  final Value<UtcDateTime?> isInReceivedLikes;
  final Value<UtcDateTime?> isInSentLikes;
  final Value<UtcDateTime?> isInMatches;
  final Value<UtcDateTime?> isInProfileGrid;
  final Value<UtcDateTime?> isInAutomaticProfileSearchGrid;
  final Value<UtcDateTime?> isInReceivedLikesGrid;
  final Value<UtcDateTime?> isInMatchesGrid;
  const ProfileStatesCompanion({
    this.id = const Value.absent(),
    this.uuidAccountId = const Value.absent(),
    this.isInFavorites = const Value.absent(),
    this.isInReceivedLikes = const Value.absent(),
    this.isInSentLikes = const Value.absent(),
    this.isInMatches = const Value.absent(),
    this.isInProfileGrid = const Value.absent(),
    this.isInAutomaticProfileSearchGrid = const Value.absent(),
    this.isInReceivedLikesGrid = const Value.absent(),
    this.isInMatchesGrid = const Value.absent(),
  });
  ProfileStatesCompanion.insert({
    this.id = const Value.absent(),
    required api.AccountId uuidAccountId,
    this.isInFavorites = const Value.absent(),
    this.isInReceivedLikes = const Value.absent(),
    this.isInSentLikes = const Value.absent(),
    this.isInMatches = const Value.absent(),
    this.isInProfileGrid = const Value.absent(),
    this.isInAutomaticProfileSearchGrid = const Value.absent(),
    this.isInReceivedLikesGrid = const Value.absent(),
    this.isInMatchesGrid = const Value.absent(),
  }) : uuidAccountId = Value(uuidAccountId);
  static Insertable<ProfileState> custom({
    Expression<int>? id,
    Expression<String>? uuidAccountId,
    Expression<int>? isInFavorites,
    Expression<int>? isInReceivedLikes,
    Expression<int>? isInSentLikes,
    Expression<int>? isInMatches,
    Expression<int>? isInProfileGrid,
    Expression<int>? isInAutomaticProfileSearchGrid,
    Expression<int>? isInReceivedLikesGrid,
    Expression<int>? isInMatchesGrid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuidAccountId != null) 'uuid_account_id': uuidAccountId,
      if (isInFavorites != null) 'is_in_favorites': isInFavorites,
      if (isInReceivedLikes != null) 'is_in_received_likes': isInReceivedLikes,
      if (isInSentLikes != null) 'is_in_sent_likes': isInSentLikes,
      if (isInMatches != null) 'is_in_matches': isInMatches,
      if (isInProfileGrid != null) 'is_in_profile_grid': isInProfileGrid,
      if (isInAutomaticProfileSearchGrid != null)
        'is_in_automatic_profile_search_grid': isInAutomaticProfileSearchGrid,
      if (isInReceivedLikesGrid != null)
        'is_in_received_likes_grid': isInReceivedLikesGrid,
      if (isInMatchesGrid != null) 'is_in_matches_grid': isInMatchesGrid,
    });
  }

  ProfileStatesCompanion copyWith(
      {Value<int>? id,
      Value<api.AccountId>? uuidAccountId,
      Value<UtcDateTime?>? isInFavorites,
      Value<UtcDateTime?>? isInReceivedLikes,
      Value<UtcDateTime?>? isInSentLikes,
      Value<UtcDateTime?>? isInMatches,
      Value<UtcDateTime?>? isInProfileGrid,
      Value<UtcDateTime?>? isInAutomaticProfileSearchGrid,
      Value<UtcDateTime?>? isInReceivedLikesGrid,
      Value<UtcDateTime?>? isInMatchesGrid}) {
    return ProfileStatesCompanion(
      id: id ?? this.id,
      uuidAccountId: uuidAccountId ?? this.uuidAccountId,
      isInFavorites: isInFavorites ?? this.isInFavorites,
      isInReceivedLikes: isInReceivedLikes ?? this.isInReceivedLikes,
      isInSentLikes: isInSentLikes ?? this.isInSentLikes,
      isInMatches: isInMatches ?? this.isInMatches,
      isInProfileGrid: isInProfileGrid ?? this.isInProfileGrid,
      isInAutomaticProfileSearchGrid:
          isInAutomaticProfileSearchGrid ?? this.isInAutomaticProfileSearchGrid,
      isInReceivedLikesGrid:
          isInReceivedLikesGrid ?? this.isInReceivedLikesGrid,
      isInMatchesGrid: isInMatchesGrid ?? this.isInMatchesGrid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uuidAccountId.present) {
      map['uuid_account_id'] = Variable<String>($ProfileStatesTable
          .$converteruuidAccountId
          .toSql(uuidAccountId.value));
    }
    if (isInFavorites.present) {
      map['is_in_favorites'] = Variable<int>($ProfileStatesTable
          .$converterisInFavorites
          .toSql(isInFavorites.value));
    }
    if (isInReceivedLikes.present) {
      map['is_in_received_likes'] = Variable<int>($ProfileStatesTable
          .$converterisInReceivedLikes
          .toSql(isInReceivedLikes.value));
    }
    if (isInSentLikes.present) {
      map['is_in_sent_likes'] = Variable<int>($ProfileStatesTable
          .$converterisInSentLikes
          .toSql(isInSentLikes.value));
    }
    if (isInMatches.present) {
      map['is_in_matches'] = Variable<int>(
          $ProfileStatesTable.$converterisInMatches.toSql(isInMatches.value));
    }
    if (isInProfileGrid.present) {
      map['is_in_profile_grid'] = Variable<int>($ProfileStatesTable
          .$converterisInProfileGrid
          .toSql(isInProfileGrid.value));
    }
    if (isInAutomaticProfileSearchGrid.present) {
      map['is_in_automatic_profile_search_grid'] = Variable<int>(
          $ProfileStatesTable.$converterisInAutomaticProfileSearchGrid
              .toSql(isInAutomaticProfileSearchGrid.value));
    }
    if (isInReceivedLikesGrid.present) {
      map['is_in_received_likes_grid'] = Variable<int>($ProfileStatesTable
          .$converterisInReceivedLikesGrid
          .toSql(isInReceivedLikesGrid.value));
    }
    if (isInMatchesGrid.present) {
      map['is_in_matches_grid'] = Variable<int>($ProfileStatesTable
          .$converterisInMatchesGrid
          .toSql(isInMatchesGrid.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProfileStatesCompanion(')
          ..write('id: $id, ')
          ..write('uuidAccountId: $uuidAccountId, ')
          ..write('isInFavorites: $isInFavorites, ')
          ..write('isInReceivedLikes: $isInReceivedLikes, ')
          ..write('isInSentLikes: $isInSentLikes, ')
          ..write('isInMatches: $isInMatches, ')
          ..write('isInProfileGrid: $isInProfileGrid, ')
          ..write(
              'isInAutomaticProfileSearchGrid: $isInAutomaticProfileSearchGrid, ')
          ..write('isInReceivedLikesGrid: $isInReceivedLikesGrid, ')
          ..write('isInMatchesGrid: $isInMatchesGrid')
          ..write(')'))
        .toString();
  }
}

class $ConversationListTable extends ConversationList
    with TableInfo<$ConversationListTable, ConversationListData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ConversationListTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  @override
  late final GeneratedColumnWithTypeConverter<api.AccountId, String>
      uuidAccountId = GeneratedColumn<String>(
              'uuid_account_id', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: true,
              defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'))
          .withConverter<api.AccountId>(
              $ConversationListTable.$converteruuidAccountId);
  @override
  late final GeneratedColumnWithTypeConverter<UtcDateTime?, int>
      conversationLastChangedTime = GeneratedColumn<int>(
              'conversation_last_changed_time', aliasedName, true,
              type: DriftSqlType.int, requiredDuringInsert: false)
          .withConverter<UtcDateTime?>(
              $ConversationListTable.$converterconversationLastChangedTime);
  @override
  late final GeneratedColumnWithTypeConverter<UtcDateTime?, int>
      isInConversationList = GeneratedColumn<int>(
              'is_in_conversation_list', aliasedName, true,
              type: DriftSqlType.int, requiredDuringInsert: false)
          .withConverter<UtcDateTime?>(
              $ConversationListTable.$converterisInConversationList);
  @override
  late final GeneratedColumnWithTypeConverter<UtcDateTime?, int>
      isInSentBlocks = GeneratedColumn<int>(
              'is_in_sent_blocks', aliasedName, true,
              type: DriftSqlType.int, requiredDuringInsert: false)
          .withConverter<UtcDateTime?>(
              $ConversationListTable.$converterisInSentBlocks);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        uuidAccountId,
        conversationLastChangedTime,
        isInConversationList,
        isInSentBlocks
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'conversation_list';
  @override
  VerificationContext validateIntegrity(
      Insertable<ConversationListData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ConversationListData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ConversationListData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      uuidAccountId: $ConversationListTable.$converteruuidAccountId.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}uuid_account_id'])!),
      conversationLastChangedTime: $ConversationListTable
          .$converterconversationLastChangedTime
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.int,
              data['${effectivePrefix}conversation_last_changed_time'])),
      isInConversationList: $ConversationListTable
          .$converterisInConversationList
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.int,
              data['${effectivePrefix}is_in_conversation_list'])),
      isInSentBlocks: $ConversationListTable.$converterisInSentBlocks.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.int, data['${effectivePrefix}is_in_sent_blocks'])),
    );
  }

  @override
  $ConversationListTable createAlias(String alias) {
    return $ConversationListTable(attachedDatabase, alias);
  }

  static TypeConverter<api.AccountId, String> $converteruuidAccountId =
      const AccountIdConverter();
  static TypeConverter<UtcDateTime?, int?>
      $converterconversationLastChangedTime =
      const NullAwareTypeConverter.wrap(UtcDateTimeConverter());
  static TypeConverter<UtcDateTime?, int?> $converterisInConversationList =
      const NullAwareTypeConverter.wrap(UtcDateTimeConverter());
  static TypeConverter<UtcDateTime?, int?> $converterisInSentBlocks =
      const NullAwareTypeConverter.wrap(UtcDateTimeConverter());
}

class ConversationListData extends DataClass
    implements Insertable<ConversationListData> {
  final int id;
  final api.AccountId uuidAccountId;
  final UtcDateTime? conversationLastChangedTime;
  final UtcDateTime? isInConversationList;
  final UtcDateTime? isInSentBlocks;
  const ConversationListData(
      {required this.id,
      required this.uuidAccountId,
      this.conversationLastChangedTime,
      this.isInConversationList,
      this.isInSentBlocks});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['uuid_account_id'] = Variable<String>(
          $ConversationListTable.$converteruuidAccountId.toSql(uuidAccountId));
    }
    if (!nullToAbsent || conversationLastChangedTime != null) {
      map['conversation_last_changed_time'] = Variable<int>(
          $ConversationListTable.$converterconversationLastChangedTime
              .toSql(conversationLastChangedTime));
    }
    if (!nullToAbsent || isInConversationList != null) {
      map['is_in_conversation_list'] = Variable<int>($ConversationListTable
          .$converterisInConversationList
          .toSql(isInConversationList));
    }
    if (!nullToAbsent || isInSentBlocks != null) {
      map['is_in_sent_blocks'] = Variable<int>($ConversationListTable
          .$converterisInSentBlocks
          .toSql(isInSentBlocks));
    }
    return map;
  }

  ConversationListCompanion toCompanion(bool nullToAbsent) {
    return ConversationListCompanion(
      id: Value(id),
      uuidAccountId: Value(uuidAccountId),
      conversationLastChangedTime:
          conversationLastChangedTime == null && nullToAbsent
              ? const Value.absent()
              : Value(conversationLastChangedTime),
      isInConversationList: isInConversationList == null && nullToAbsent
          ? const Value.absent()
          : Value(isInConversationList),
      isInSentBlocks: isInSentBlocks == null && nullToAbsent
          ? const Value.absent()
          : Value(isInSentBlocks),
    );
  }

  factory ConversationListData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ConversationListData(
      id: serializer.fromJson<int>(json['id']),
      uuidAccountId: serializer.fromJson<api.AccountId>(json['uuidAccountId']),
      conversationLastChangedTime: serializer
          .fromJson<UtcDateTime?>(json['conversationLastChangedTime']),
      isInConversationList:
          serializer.fromJson<UtcDateTime?>(json['isInConversationList']),
      isInSentBlocks: serializer.fromJson<UtcDateTime?>(json['isInSentBlocks']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uuidAccountId': serializer.toJson<api.AccountId>(uuidAccountId),
      'conversationLastChangedTime':
          serializer.toJson<UtcDateTime?>(conversationLastChangedTime),
      'isInConversationList':
          serializer.toJson<UtcDateTime?>(isInConversationList),
      'isInSentBlocks': serializer.toJson<UtcDateTime?>(isInSentBlocks),
    };
  }

  ConversationListData copyWith(
          {int? id,
          api.AccountId? uuidAccountId,
          Value<UtcDateTime?> conversationLastChangedTime =
              const Value.absent(),
          Value<UtcDateTime?> isInConversationList = const Value.absent(),
          Value<UtcDateTime?> isInSentBlocks = const Value.absent()}) =>
      ConversationListData(
        id: id ?? this.id,
        uuidAccountId: uuidAccountId ?? this.uuidAccountId,
        conversationLastChangedTime: conversationLastChangedTime.present
            ? conversationLastChangedTime.value
            : this.conversationLastChangedTime,
        isInConversationList: isInConversationList.present
            ? isInConversationList.value
            : this.isInConversationList,
        isInSentBlocks:
            isInSentBlocks.present ? isInSentBlocks.value : this.isInSentBlocks,
      );
  ConversationListData copyWithCompanion(ConversationListCompanion data) {
    return ConversationListData(
      id: data.id.present ? data.id.value : this.id,
      uuidAccountId: data.uuidAccountId.present
          ? data.uuidAccountId.value
          : this.uuidAccountId,
      conversationLastChangedTime: data.conversationLastChangedTime.present
          ? data.conversationLastChangedTime.value
          : this.conversationLastChangedTime,
      isInConversationList: data.isInConversationList.present
          ? data.isInConversationList.value
          : this.isInConversationList,
      isInSentBlocks: data.isInSentBlocks.present
          ? data.isInSentBlocks.value
          : this.isInSentBlocks,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ConversationListData(')
          ..write('id: $id, ')
          ..write('uuidAccountId: $uuidAccountId, ')
          ..write('conversationLastChangedTime: $conversationLastChangedTime, ')
          ..write('isInConversationList: $isInConversationList, ')
          ..write('isInSentBlocks: $isInSentBlocks')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, uuidAccountId,
      conversationLastChangedTime, isInConversationList, isInSentBlocks);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ConversationListData &&
          other.id == this.id &&
          other.uuidAccountId == this.uuidAccountId &&
          other.conversationLastChangedTime ==
              this.conversationLastChangedTime &&
          other.isInConversationList == this.isInConversationList &&
          other.isInSentBlocks == this.isInSentBlocks);
}

class ConversationListCompanion extends UpdateCompanion<ConversationListData> {
  final Value<int> id;
  final Value<api.AccountId> uuidAccountId;
  final Value<UtcDateTime?> conversationLastChangedTime;
  final Value<UtcDateTime?> isInConversationList;
  final Value<UtcDateTime?> isInSentBlocks;
  const ConversationListCompanion({
    this.id = const Value.absent(),
    this.uuidAccountId = const Value.absent(),
    this.conversationLastChangedTime = const Value.absent(),
    this.isInConversationList = const Value.absent(),
    this.isInSentBlocks = const Value.absent(),
  });
  ConversationListCompanion.insert({
    this.id = const Value.absent(),
    required api.AccountId uuidAccountId,
    this.conversationLastChangedTime = const Value.absent(),
    this.isInConversationList = const Value.absent(),
    this.isInSentBlocks = const Value.absent(),
  }) : uuidAccountId = Value(uuidAccountId);
  static Insertable<ConversationListData> custom({
    Expression<int>? id,
    Expression<String>? uuidAccountId,
    Expression<int>? conversationLastChangedTime,
    Expression<int>? isInConversationList,
    Expression<int>? isInSentBlocks,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuidAccountId != null) 'uuid_account_id': uuidAccountId,
      if (conversationLastChangedTime != null)
        'conversation_last_changed_time': conversationLastChangedTime,
      if (isInConversationList != null)
        'is_in_conversation_list': isInConversationList,
      if (isInSentBlocks != null) 'is_in_sent_blocks': isInSentBlocks,
    });
  }

  ConversationListCompanion copyWith(
      {Value<int>? id,
      Value<api.AccountId>? uuidAccountId,
      Value<UtcDateTime?>? conversationLastChangedTime,
      Value<UtcDateTime?>? isInConversationList,
      Value<UtcDateTime?>? isInSentBlocks}) {
    return ConversationListCompanion(
      id: id ?? this.id,
      uuidAccountId: uuidAccountId ?? this.uuidAccountId,
      conversationLastChangedTime:
          conversationLastChangedTime ?? this.conversationLastChangedTime,
      isInConversationList: isInConversationList ?? this.isInConversationList,
      isInSentBlocks: isInSentBlocks ?? this.isInSentBlocks,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uuidAccountId.present) {
      map['uuid_account_id'] = Variable<String>($ConversationListTable
          .$converteruuidAccountId
          .toSql(uuidAccountId.value));
    }
    if (conversationLastChangedTime.present) {
      map['conversation_last_changed_time'] = Variable<int>(
          $ConversationListTable.$converterconversationLastChangedTime
              .toSql(conversationLastChangedTime.value));
    }
    if (isInConversationList.present) {
      map['is_in_conversation_list'] = Variable<int>($ConversationListTable
          .$converterisInConversationList
          .toSql(isInConversationList.value));
    }
    if (isInSentBlocks.present) {
      map['is_in_sent_blocks'] = Variable<int>($ConversationListTable
          .$converterisInSentBlocks
          .toSql(isInSentBlocks.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ConversationListCompanion(')
          ..write('id: $id, ')
          ..write('uuidAccountId: $uuidAccountId, ')
          ..write('conversationLastChangedTime: $conversationLastChangedTime, ')
          ..write('isInConversationList: $isInConversationList, ')
          ..write('isInSentBlocks: $isInSentBlocks')
          ..write(')'))
        .toString();
  }
}

class $MessageTableTable extends MessageTable
    with TableInfo<$MessageTableTable, MessageTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MessageTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  @override
  late final GeneratedColumnWithTypeConverter<api.AccountId, String>
      uuidLocalAccountId = GeneratedColumn<String>(
              'uuid_local_account_id', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<api.AccountId>(
              $MessageTableTable.$converteruuidLocalAccountId);
  @override
  late final GeneratedColumnWithTypeConverter<api.AccountId, String>
      uuidRemoteAccountId = GeneratedColumn<String>(
              'uuid_remote_account_id', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<api.AccountId>(
              $MessageTableTable.$converteruuidRemoteAccountId);
  @override
  late final GeneratedColumnWithTypeConverter<Message?, Uint8List> message =
      GeneratedColumn<Uint8List>('message', aliasedName, true,
              type: DriftSqlType.blob, requiredDuringInsert: false)
          .withConverter<Message?>($MessageTableTable.$convertermessage);
  @override
  late final GeneratedColumnWithTypeConverter<UtcDateTime, int> localUnixTime =
      GeneratedColumn<int>('local_unix_time', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<UtcDateTime>(
              $MessageTableTable.$converterlocalUnixTime);
  static const VerificationMeta _messageStateMeta =
      const VerificationMeta('messageState');
  @override
  late final GeneratedColumn<int> messageState = GeneratedColumn<int>(
      'message_state', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _symmetricMessageEncryptionKeyMeta =
      const VerificationMeta('symmetricMessageEncryptionKey');
  @override
  late final GeneratedColumn<Uint8List> symmetricMessageEncryptionKey =
      GeneratedColumn<Uint8List>(
          'symmetric_message_encryption_key', aliasedName, true,
          type: DriftSqlType.blob, requiredDuringInsert: false);
  @override
  late final GeneratedColumnWithTypeConverter<api.MessageNumber?, int>
      messageNumber = GeneratedColumn<int>('message_number', aliasedName, true,
              type: DriftSqlType.int, requiredDuringInsert: false)
          .withConverter<api.MessageNumber?>(
              $MessageTableTable.$convertermessageNumber);
  @override
  late final GeneratedColumnWithTypeConverter<UtcDateTime?, int> unixTime =
      GeneratedColumn<int>('unix_time', aliasedName, true,
              type: DriftSqlType.int, requiredDuringInsert: false)
          .withConverter<UtcDateTime?>($MessageTableTable.$converterunixTime);
  static const VerificationMeta _backendSignedPgpMessageMeta =
      const VerificationMeta('backendSignedPgpMessage');
  @override
  late final GeneratedColumn<Uint8List> backendSignedPgpMessage =
      GeneratedColumn<Uint8List>(
          'backend_signed_pgp_message', aliasedName, true,
          type: DriftSqlType.blob, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        uuidLocalAccountId,
        uuidRemoteAccountId,
        message,
        localUnixTime,
        messageState,
        symmetricMessageEncryptionKey,
        messageNumber,
        unixTime,
        backendSignedPgpMessage
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'message_table';
  @override
  VerificationContext validateIntegrity(Insertable<MessageTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('message_state')) {
      context.handle(
          _messageStateMeta,
          messageState.isAcceptableOrUnknown(
              data['message_state']!, _messageStateMeta));
    } else if (isInserting) {
      context.missing(_messageStateMeta);
    }
    if (data.containsKey('symmetric_message_encryption_key')) {
      context.handle(
          _symmetricMessageEncryptionKeyMeta,
          symmetricMessageEncryptionKey.isAcceptableOrUnknown(
              data['symmetric_message_encryption_key']!,
              _symmetricMessageEncryptionKeyMeta));
    }
    if (data.containsKey('backend_signed_pgp_message')) {
      context.handle(
          _backendSignedPgpMessageMeta,
          backendSignedPgpMessage.isAcceptableOrUnknown(
              data['backend_signed_pgp_message']!,
              _backendSignedPgpMessageMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MessageTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MessageTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      uuidLocalAccountId: $MessageTableTable.$converteruuidLocalAccountId
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}uuid_local_account_id'])!),
      uuidRemoteAccountId: $MessageTableTable.$converteruuidRemoteAccountId
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}uuid_remote_account_id'])!),
      message: $MessageTableTable.$convertermessage.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.blob, data['${effectivePrefix}message'])),
      localUnixTime: $MessageTableTable.$converterlocalUnixTime.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.int, data['${effectivePrefix}local_unix_time'])!),
      messageState: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}message_state'])!,
      symmetricMessageEncryptionKey: attachedDatabase.typeMapping.read(
          DriftSqlType.blob,
          data['${effectivePrefix}symmetric_message_encryption_key']),
      messageNumber: $MessageTableTable.$convertermessageNumber.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.int, data['${effectivePrefix}message_number'])),
      unixTime: $MessageTableTable.$converterunixTime.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}unix_time'])),
      backendSignedPgpMessage: attachedDatabase.typeMapping.read(
          DriftSqlType.blob,
          data['${effectivePrefix}backend_signed_pgp_message']),
    );
  }

  @override
  $MessageTableTable createAlias(String alias) {
    return $MessageTableTable(attachedDatabase, alias);
  }

  static TypeConverter<api.AccountId, String> $converteruuidLocalAccountId =
      const AccountIdConverter();
  static TypeConverter<api.AccountId, String> $converteruuidRemoteAccountId =
      const AccountIdConverter();
  static TypeConverter<Message?, Uint8List?> $convertermessage =
      const NullAwareTypeConverter.wrap(MessageConverter());
  static TypeConverter<UtcDateTime, int> $converterlocalUnixTime =
      const UtcDateTimeConverter();
  static TypeConverter<api.MessageNumber?, int?> $convertermessageNumber =
      const NullAwareTypeConverter.wrap(MessageNumberConverter());
  static TypeConverter<UtcDateTime?, int?> $converterunixTime =
      const NullAwareTypeConverter.wrap(UtcDateTimeConverter());
}

class MessageTableData extends DataClass
    implements Insertable<MessageTableData> {
  final int id;
  final api.AccountId uuidLocalAccountId;
  final api.AccountId uuidRemoteAccountId;
  final Message? message;
  final UtcDateTime localUnixTime;
  final int messageState;
  final Uint8List? symmetricMessageEncryptionKey;
  final api.MessageNumber? messageNumber;
  final UtcDateTime? unixTime;
  final Uint8List? backendSignedPgpMessage;
  const MessageTableData(
      {required this.id,
      required this.uuidLocalAccountId,
      required this.uuidRemoteAccountId,
      this.message,
      required this.localUnixTime,
      required this.messageState,
      this.symmetricMessageEncryptionKey,
      this.messageNumber,
      this.unixTime,
      this.backendSignedPgpMessage});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['uuid_local_account_id'] = Variable<String>($MessageTableTable
          .$converteruuidLocalAccountId
          .toSql(uuidLocalAccountId));
    }
    {
      map['uuid_remote_account_id'] = Variable<String>($MessageTableTable
          .$converteruuidRemoteAccountId
          .toSql(uuidRemoteAccountId));
    }
    if (!nullToAbsent || message != null) {
      map['message'] = Variable<Uint8List>(
          $MessageTableTable.$convertermessage.toSql(message));
    }
    {
      map['local_unix_time'] = Variable<int>(
          $MessageTableTable.$converterlocalUnixTime.toSql(localUnixTime));
    }
    map['message_state'] = Variable<int>(messageState);
    if (!nullToAbsent || symmetricMessageEncryptionKey != null) {
      map['symmetric_message_encryption_key'] =
          Variable<Uint8List>(symmetricMessageEncryptionKey);
    }
    if (!nullToAbsent || messageNumber != null) {
      map['message_number'] = Variable<int>(
          $MessageTableTable.$convertermessageNumber.toSql(messageNumber));
    }
    if (!nullToAbsent || unixTime != null) {
      map['unix_time'] =
          Variable<int>($MessageTableTable.$converterunixTime.toSql(unixTime));
    }
    if (!nullToAbsent || backendSignedPgpMessage != null) {
      map['backend_signed_pgp_message'] =
          Variable<Uint8List>(backendSignedPgpMessage);
    }
    return map;
  }

  MessageTableCompanion toCompanion(bool nullToAbsent) {
    return MessageTableCompanion(
      id: Value(id),
      uuidLocalAccountId: Value(uuidLocalAccountId),
      uuidRemoteAccountId: Value(uuidRemoteAccountId),
      message: message == null && nullToAbsent
          ? const Value.absent()
          : Value(message),
      localUnixTime: Value(localUnixTime),
      messageState: Value(messageState),
      symmetricMessageEncryptionKey:
          symmetricMessageEncryptionKey == null && nullToAbsent
              ? const Value.absent()
              : Value(symmetricMessageEncryptionKey),
      messageNumber: messageNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(messageNumber),
      unixTime: unixTime == null && nullToAbsent
          ? const Value.absent()
          : Value(unixTime),
      backendSignedPgpMessage: backendSignedPgpMessage == null && nullToAbsent
          ? const Value.absent()
          : Value(backendSignedPgpMessage),
    );
  }

  factory MessageTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MessageTableData(
      id: serializer.fromJson<int>(json['id']),
      uuidLocalAccountId:
          serializer.fromJson<api.AccountId>(json['uuidLocalAccountId']),
      uuidRemoteAccountId:
          serializer.fromJson<api.AccountId>(json['uuidRemoteAccountId']),
      message: serializer.fromJson<Message?>(json['message']),
      localUnixTime: serializer.fromJson<UtcDateTime>(json['localUnixTime']),
      messageState: serializer.fromJson<int>(json['messageState']),
      symmetricMessageEncryptionKey: serializer
          .fromJson<Uint8List?>(json['symmetricMessageEncryptionKey']),
      messageNumber:
          serializer.fromJson<api.MessageNumber?>(json['messageNumber']),
      unixTime: serializer.fromJson<UtcDateTime?>(json['unixTime']),
      backendSignedPgpMessage:
          serializer.fromJson<Uint8List?>(json['backendSignedPgpMessage']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uuidLocalAccountId':
          serializer.toJson<api.AccountId>(uuidLocalAccountId),
      'uuidRemoteAccountId':
          serializer.toJson<api.AccountId>(uuidRemoteAccountId),
      'message': serializer.toJson<Message?>(message),
      'localUnixTime': serializer.toJson<UtcDateTime>(localUnixTime),
      'messageState': serializer.toJson<int>(messageState),
      'symmetricMessageEncryptionKey':
          serializer.toJson<Uint8List?>(symmetricMessageEncryptionKey),
      'messageNumber': serializer.toJson<api.MessageNumber?>(messageNumber),
      'unixTime': serializer.toJson<UtcDateTime?>(unixTime),
      'backendSignedPgpMessage':
          serializer.toJson<Uint8List?>(backendSignedPgpMessage),
    };
  }

  MessageTableData copyWith(
          {int? id,
          api.AccountId? uuidLocalAccountId,
          api.AccountId? uuidRemoteAccountId,
          Value<Message?> message = const Value.absent(),
          UtcDateTime? localUnixTime,
          int? messageState,
          Value<Uint8List?> symmetricMessageEncryptionKey =
              const Value.absent(),
          Value<api.MessageNumber?> messageNumber = const Value.absent(),
          Value<UtcDateTime?> unixTime = const Value.absent(),
          Value<Uint8List?> backendSignedPgpMessage = const Value.absent()}) =>
      MessageTableData(
        id: id ?? this.id,
        uuidLocalAccountId: uuidLocalAccountId ?? this.uuidLocalAccountId,
        uuidRemoteAccountId: uuidRemoteAccountId ?? this.uuidRemoteAccountId,
        message: message.present ? message.value : this.message,
        localUnixTime: localUnixTime ?? this.localUnixTime,
        messageState: messageState ?? this.messageState,
        symmetricMessageEncryptionKey: symmetricMessageEncryptionKey.present
            ? symmetricMessageEncryptionKey.value
            : this.symmetricMessageEncryptionKey,
        messageNumber:
            messageNumber.present ? messageNumber.value : this.messageNumber,
        unixTime: unixTime.present ? unixTime.value : this.unixTime,
        backendSignedPgpMessage: backendSignedPgpMessage.present
            ? backendSignedPgpMessage.value
            : this.backendSignedPgpMessage,
      );
  MessageTableData copyWithCompanion(MessageTableCompanion data) {
    return MessageTableData(
      id: data.id.present ? data.id.value : this.id,
      uuidLocalAccountId: data.uuidLocalAccountId.present
          ? data.uuidLocalAccountId.value
          : this.uuidLocalAccountId,
      uuidRemoteAccountId: data.uuidRemoteAccountId.present
          ? data.uuidRemoteAccountId.value
          : this.uuidRemoteAccountId,
      message: data.message.present ? data.message.value : this.message,
      localUnixTime: data.localUnixTime.present
          ? data.localUnixTime.value
          : this.localUnixTime,
      messageState: data.messageState.present
          ? data.messageState.value
          : this.messageState,
      symmetricMessageEncryptionKey: data.symmetricMessageEncryptionKey.present
          ? data.symmetricMessageEncryptionKey.value
          : this.symmetricMessageEncryptionKey,
      messageNumber: data.messageNumber.present
          ? data.messageNumber.value
          : this.messageNumber,
      unixTime: data.unixTime.present ? data.unixTime.value : this.unixTime,
      backendSignedPgpMessage: data.backendSignedPgpMessage.present
          ? data.backendSignedPgpMessage.value
          : this.backendSignedPgpMessage,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MessageTableData(')
          ..write('id: $id, ')
          ..write('uuidLocalAccountId: $uuidLocalAccountId, ')
          ..write('uuidRemoteAccountId: $uuidRemoteAccountId, ')
          ..write('message: $message, ')
          ..write('localUnixTime: $localUnixTime, ')
          ..write('messageState: $messageState, ')
          ..write(
              'symmetricMessageEncryptionKey: $symmetricMessageEncryptionKey, ')
          ..write('messageNumber: $messageNumber, ')
          ..write('unixTime: $unixTime, ')
          ..write('backendSignedPgpMessage: $backendSignedPgpMessage')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      uuidLocalAccountId,
      uuidRemoteAccountId,
      message,
      localUnixTime,
      messageState,
      $driftBlobEquality.hash(symmetricMessageEncryptionKey),
      messageNumber,
      unixTime,
      $driftBlobEquality.hash(backendSignedPgpMessage));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MessageTableData &&
          other.id == this.id &&
          other.uuidLocalAccountId == this.uuidLocalAccountId &&
          other.uuidRemoteAccountId == this.uuidRemoteAccountId &&
          other.message == this.message &&
          other.localUnixTime == this.localUnixTime &&
          other.messageState == this.messageState &&
          $driftBlobEquality.equals(other.symmetricMessageEncryptionKey,
              this.symmetricMessageEncryptionKey) &&
          other.messageNumber == this.messageNumber &&
          other.unixTime == this.unixTime &&
          $driftBlobEquality.equals(
              other.backendSignedPgpMessage, this.backendSignedPgpMessage));
}

class MessageTableCompanion extends UpdateCompanion<MessageTableData> {
  final Value<int> id;
  final Value<api.AccountId> uuidLocalAccountId;
  final Value<api.AccountId> uuidRemoteAccountId;
  final Value<Message?> message;
  final Value<UtcDateTime> localUnixTime;
  final Value<int> messageState;
  final Value<Uint8List?> symmetricMessageEncryptionKey;
  final Value<api.MessageNumber?> messageNumber;
  final Value<UtcDateTime?> unixTime;
  final Value<Uint8List?> backendSignedPgpMessage;
  const MessageTableCompanion({
    this.id = const Value.absent(),
    this.uuidLocalAccountId = const Value.absent(),
    this.uuidRemoteAccountId = const Value.absent(),
    this.message = const Value.absent(),
    this.localUnixTime = const Value.absent(),
    this.messageState = const Value.absent(),
    this.symmetricMessageEncryptionKey = const Value.absent(),
    this.messageNumber = const Value.absent(),
    this.unixTime = const Value.absent(),
    this.backendSignedPgpMessage = const Value.absent(),
  });
  MessageTableCompanion.insert({
    this.id = const Value.absent(),
    required api.AccountId uuidLocalAccountId,
    required api.AccountId uuidRemoteAccountId,
    this.message = const Value.absent(),
    required UtcDateTime localUnixTime,
    required int messageState,
    this.symmetricMessageEncryptionKey = const Value.absent(),
    this.messageNumber = const Value.absent(),
    this.unixTime = const Value.absent(),
    this.backendSignedPgpMessage = const Value.absent(),
  })  : uuidLocalAccountId = Value(uuidLocalAccountId),
        uuidRemoteAccountId = Value(uuidRemoteAccountId),
        localUnixTime = Value(localUnixTime),
        messageState = Value(messageState);
  static Insertable<MessageTableData> custom({
    Expression<int>? id,
    Expression<String>? uuidLocalAccountId,
    Expression<String>? uuidRemoteAccountId,
    Expression<Uint8List>? message,
    Expression<int>? localUnixTime,
    Expression<int>? messageState,
    Expression<Uint8List>? symmetricMessageEncryptionKey,
    Expression<int>? messageNumber,
    Expression<int>? unixTime,
    Expression<Uint8List>? backendSignedPgpMessage,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuidLocalAccountId != null)
        'uuid_local_account_id': uuidLocalAccountId,
      if (uuidRemoteAccountId != null)
        'uuid_remote_account_id': uuidRemoteAccountId,
      if (message != null) 'message': message,
      if (localUnixTime != null) 'local_unix_time': localUnixTime,
      if (messageState != null) 'message_state': messageState,
      if (symmetricMessageEncryptionKey != null)
        'symmetric_message_encryption_key': symmetricMessageEncryptionKey,
      if (messageNumber != null) 'message_number': messageNumber,
      if (unixTime != null) 'unix_time': unixTime,
      if (backendSignedPgpMessage != null)
        'backend_signed_pgp_message': backendSignedPgpMessage,
    });
  }

  MessageTableCompanion copyWith(
      {Value<int>? id,
      Value<api.AccountId>? uuidLocalAccountId,
      Value<api.AccountId>? uuidRemoteAccountId,
      Value<Message?>? message,
      Value<UtcDateTime>? localUnixTime,
      Value<int>? messageState,
      Value<Uint8List?>? symmetricMessageEncryptionKey,
      Value<api.MessageNumber?>? messageNumber,
      Value<UtcDateTime?>? unixTime,
      Value<Uint8List?>? backendSignedPgpMessage}) {
    return MessageTableCompanion(
      id: id ?? this.id,
      uuidLocalAccountId: uuidLocalAccountId ?? this.uuidLocalAccountId,
      uuidRemoteAccountId: uuidRemoteAccountId ?? this.uuidRemoteAccountId,
      message: message ?? this.message,
      localUnixTime: localUnixTime ?? this.localUnixTime,
      messageState: messageState ?? this.messageState,
      symmetricMessageEncryptionKey:
          symmetricMessageEncryptionKey ?? this.symmetricMessageEncryptionKey,
      messageNumber: messageNumber ?? this.messageNumber,
      unixTime: unixTime ?? this.unixTime,
      backendSignedPgpMessage:
          backendSignedPgpMessage ?? this.backendSignedPgpMessage,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uuidLocalAccountId.present) {
      map['uuid_local_account_id'] = Variable<String>($MessageTableTable
          .$converteruuidLocalAccountId
          .toSql(uuidLocalAccountId.value));
    }
    if (uuidRemoteAccountId.present) {
      map['uuid_remote_account_id'] = Variable<String>($MessageTableTable
          .$converteruuidRemoteAccountId
          .toSql(uuidRemoteAccountId.value));
    }
    if (message.present) {
      map['message'] = Variable<Uint8List>(
          $MessageTableTable.$convertermessage.toSql(message.value));
    }
    if (localUnixTime.present) {
      map['local_unix_time'] = Variable<int>($MessageTableTable
          .$converterlocalUnixTime
          .toSql(localUnixTime.value));
    }
    if (messageState.present) {
      map['message_state'] = Variable<int>(messageState.value);
    }
    if (symmetricMessageEncryptionKey.present) {
      map['symmetric_message_encryption_key'] =
          Variable<Uint8List>(symmetricMessageEncryptionKey.value);
    }
    if (messageNumber.present) {
      map['message_number'] = Variable<int>($MessageTableTable
          .$convertermessageNumber
          .toSql(messageNumber.value));
    }
    if (unixTime.present) {
      map['unix_time'] = Variable<int>(
          $MessageTableTable.$converterunixTime.toSql(unixTime.value));
    }
    if (backendSignedPgpMessage.present) {
      map['backend_signed_pgp_message'] =
          Variable<Uint8List>(backendSignedPgpMessage.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MessageTableCompanion(')
          ..write('id: $id, ')
          ..write('uuidLocalAccountId: $uuidLocalAccountId, ')
          ..write('uuidRemoteAccountId: $uuidRemoteAccountId, ')
          ..write('message: $message, ')
          ..write('localUnixTime: $localUnixTime, ')
          ..write('messageState: $messageState, ')
          ..write(
              'symmetricMessageEncryptionKey: $symmetricMessageEncryptionKey, ')
          ..write('messageNumber: $messageNumber, ')
          ..write('unixTime: $unixTime, ')
          ..write('backendSignedPgpMessage: $backendSignedPgpMessage')
          ..write(')'))
        .toString();
  }
}

class $ConversationsTable extends Conversations
    with TableInfo<$ConversationsTable, Conversation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ConversationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  @override
  late final GeneratedColumnWithTypeConverter<api.AccountId, String>
      uuidAccountId = GeneratedColumn<String>(
              'uuid_account_id', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: true,
              defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'))
          .withConverter<api.AccountId>(
              $ConversationsTable.$converteruuidAccountId);
  static const VerificationMeta _publicKeyDataMeta =
      const VerificationMeta('publicKeyData');
  @override
  late final GeneratedColumn<Uint8List> publicKeyData =
      GeneratedColumn<Uint8List>('public_key_data', aliasedName, true,
          type: DriftSqlType.blob, requiredDuringInsert: false);
  @override
  late final GeneratedColumnWithTypeConverter<api.PublicKeyId?, int>
      publicKeyId = GeneratedColumn<int>('public_key_id', aliasedName, true,
              type: DriftSqlType.int, requiredDuringInsert: false)
          .withConverter<api.PublicKeyId?>(
              $ConversationsTable.$converterpublicKeyId);
  @override
  List<GeneratedColumn> get $columns =>
      [id, uuidAccountId, publicKeyData, publicKeyId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'conversations';
  @override
  VerificationContext validateIntegrity(Insertable<Conversation> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('public_key_data')) {
      context.handle(
          _publicKeyDataMeta,
          publicKeyData.isAcceptableOrUnknown(
              data['public_key_data']!, _publicKeyDataMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Conversation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Conversation(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      uuidAccountId: $ConversationsTable.$converteruuidAccountId.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}uuid_account_id'])!),
      publicKeyData: attachedDatabase.typeMapping
          .read(DriftSqlType.blob, data['${effectivePrefix}public_key_data']),
      publicKeyId: $ConversationsTable.$converterpublicKeyId.fromSql(
          attachedDatabase.typeMapping
              .read(DriftSqlType.int, data['${effectivePrefix}public_key_id'])),
    );
  }

  @override
  $ConversationsTable createAlias(String alias) {
    return $ConversationsTable(attachedDatabase, alias);
  }

  static TypeConverter<api.AccountId, String> $converteruuidAccountId =
      const AccountIdConverter();
  static TypeConverter<api.PublicKeyId?, int?> $converterpublicKeyId =
      const NullAwareTypeConverter.wrap(PublicKeyIdConverter());
}

class Conversation extends DataClass implements Insertable<Conversation> {
  final int id;
  final api.AccountId uuidAccountId;
  final Uint8List? publicKeyData;
  final api.PublicKeyId? publicKeyId;
  const Conversation(
      {required this.id,
      required this.uuidAccountId,
      this.publicKeyData,
      this.publicKeyId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['uuid_account_id'] = Variable<String>(
          $ConversationsTable.$converteruuidAccountId.toSql(uuidAccountId));
    }
    if (!nullToAbsent || publicKeyData != null) {
      map['public_key_data'] = Variable<Uint8List>(publicKeyData);
    }
    if (!nullToAbsent || publicKeyId != null) {
      map['public_key_id'] = Variable<int>(
          $ConversationsTable.$converterpublicKeyId.toSql(publicKeyId));
    }
    return map;
  }

  ConversationsCompanion toCompanion(bool nullToAbsent) {
    return ConversationsCompanion(
      id: Value(id),
      uuidAccountId: Value(uuidAccountId),
      publicKeyData: publicKeyData == null && nullToAbsent
          ? const Value.absent()
          : Value(publicKeyData),
      publicKeyId: publicKeyId == null && nullToAbsent
          ? const Value.absent()
          : Value(publicKeyId),
    );
  }

  factory Conversation.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Conversation(
      id: serializer.fromJson<int>(json['id']),
      uuidAccountId: serializer.fromJson<api.AccountId>(json['uuidAccountId']),
      publicKeyData: serializer.fromJson<Uint8List?>(json['publicKeyData']),
      publicKeyId: serializer.fromJson<api.PublicKeyId?>(json['publicKeyId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uuidAccountId': serializer.toJson<api.AccountId>(uuidAccountId),
      'publicKeyData': serializer.toJson<Uint8List?>(publicKeyData),
      'publicKeyId': serializer.toJson<api.PublicKeyId?>(publicKeyId),
    };
  }

  Conversation copyWith(
          {int? id,
          api.AccountId? uuidAccountId,
          Value<Uint8List?> publicKeyData = const Value.absent(),
          Value<api.PublicKeyId?> publicKeyId = const Value.absent()}) =>
      Conversation(
        id: id ?? this.id,
        uuidAccountId: uuidAccountId ?? this.uuidAccountId,
        publicKeyData:
            publicKeyData.present ? publicKeyData.value : this.publicKeyData,
        publicKeyId: publicKeyId.present ? publicKeyId.value : this.publicKeyId,
      );
  Conversation copyWithCompanion(ConversationsCompanion data) {
    return Conversation(
      id: data.id.present ? data.id.value : this.id,
      uuidAccountId: data.uuidAccountId.present
          ? data.uuidAccountId.value
          : this.uuidAccountId,
      publicKeyData: data.publicKeyData.present
          ? data.publicKeyData.value
          : this.publicKeyData,
      publicKeyId:
          data.publicKeyId.present ? data.publicKeyId.value : this.publicKeyId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Conversation(')
          ..write('id: $id, ')
          ..write('uuidAccountId: $uuidAccountId, ')
          ..write('publicKeyData: $publicKeyData, ')
          ..write('publicKeyId: $publicKeyId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, uuidAccountId, $driftBlobEquality.hash(publicKeyData), publicKeyId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Conversation &&
          other.id == this.id &&
          other.uuidAccountId == this.uuidAccountId &&
          $driftBlobEquality.equals(other.publicKeyData, this.publicKeyData) &&
          other.publicKeyId == this.publicKeyId);
}

class ConversationsCompanion extends UpdateCompanion<Conversation> {
  final Value<int> id;
  final Value<api.AccountId> uuidAccountId;
  final Value<Uint8List?> publicKeyData;
  final Value<api.PublicKeyId?> publicKeyId;
  const ConversationsCompanion({
    this.id = const Value.absent(),
    this.uuidAccountId = const Value.absent(),
    this.publicKeyData = const Value.absent(),
    this.publicKeyId = const Value.absent(),
  });
  ConversationsCompanion.insert({
    this.id = const Value.absent(),
    required api.AccountId uuidAccountId,
    this.publicKeyData = const Value.absent(),
    this.publicKeyId = const Value.absent(),
  }) : uuidAccountId = Value(uuidAccountId);
  static Insertable<Conversation> custom({
    Expression<int>? id,
    Expression<String>? uuidAccountId,
    Expression<Uint8List>? publicKeyData,
    Expression<int>? publicKeyId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuidAccountId != null) 'uuid_account_id': uuidAccountId,
      if (publicKeyData != null) 'public_key_data': publicKeyData,
      if (publicKeyId != null) 'public_key_id': publicKeyId,
    });
  }

  ConversationsCompanion copyWith(
      {Value<int>? id,
      Value<api.AccountId>? uuidAccountId,
      Value<Uint8List?>? publicKeyData,
      Value<api.PublicKeyId?>? publicKeyId}) {
    return ConversationsCompanion(
      id: id ?? this.id,
      uuidAccountId: uuidAccountId ?? this.uuidAccountId,
      publicKeyData: publicKeyData ?? this.publicKeyData,
      publicKeyId: publicKeyId ?? this.publicKeyId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uuidAccountId.present) {
      map['uuid_account_id'] = Variable<String>($ConversationsTable
          .$converteruuidAccountId
          .toSql(uuidAccountId.value));
    }
    if (publicKeyData.present) {
      map['public_key_data'] = Variable<Uint8List>(publicKeyData.value);
    }
    if (publicKeyId.present) {
      map['public_key_id'] = Variable<int>(
          $ConversationsTable.$converterpublicKeyId.toSql(publicKeyId.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ConversationsCompanion(')
          ..write('id: $id, ')
          ..write('uuidAccountId: $uuidAccountId, ')
          ..write('publicKeyData: $publicKeyData, ')
          ..write('publicKeyId: $publicKeyId')
          ..write(')'))
        .toString();
  }
}

class $AvailableProfileAttributesTableTable
    extends AvailableProfileAttributesTable
    with
        TableInfo<$AvailableProfileAttributesTableTable,
            AvailableProfileAttributesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AvailableProfileAttributesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  late final GeneratedColumnWithTypeConverter<JsonString, String>
      jsonAttribute = GeneratedColumn<String>(
              'json_attribute', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<JsonString>(
              $AvailableProfileAttributesTableTable.$converterjsonAttribute);
  @override
  late final GeneratedColumnWithTypeConverter<api.ProfileAttributeHash, String>
      attributeHash = GeneratedColumn<String>(
              'attribute_hash', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<api.ProfileAttributeHash>(
              $AvailableProfileAttributesTableTable.$converterattributeHash);
  @override
  List<GeneratedColumn> get $columns => [id, jsonAttribute, attributeHash];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'available_profile_attributes_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<AvailableProfileAttributesTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AvailableProfileAttributesTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AvailableProfileAttributesTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      jsonAttribute: $AvailableProfileAttributesTableTable
          .$converterjsonAttribute
          .fromSql(attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}json_attribute'])!),
      attributeHash: $AvailableProfileAttributesTableTable
          .$converterattributeHash
          .fromSql(attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}attribute_hash'])!),
    );
  }

  @override
  $AvailableProfileAttributesTableTable createAlias(String alias) {
    return $AvailableProfileAttributesTableTable(attachedDatabase, alias);
  }

  static TypeConverter<JsonString, String> $converterjsonAttribute =
      JsonString.driftConverter;
  static TypeConverter<api.ProfileAttributeHash, String>
      $converterattributeHash = const ProfileAttributeHashConverter();
}

class AvailableProfileAttributesTableData extends DataClass
    implements Insertable<AvailableProfileAttributesTableData> {
  final int id;
  final JsonString jsonAttribute;
  final api.ProfileAttributeHash attributeHash;
  const AvailableProfileAttributesTableData(
      {required this.id,
      required this.jsonAttribute,
      required this.attributeHash});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['json_attribute'] = Variable<String>(
          $AvailableProfileAttributesTableTable.$converterjsonAttribute
              .toSql(jsonAttribute));
    }
    {
      map['attribute_hash'] = Variable<String>(
          $AvailableProfileAttributesTableTable.$converterattributeHash
              .toSql(attributeHash));
    }
    return map;
  }

  AvailableProfileAttributesTableCompanion toCompanion(bool nullToAbsent) {
    return AvailableProfileAttributesTableCompanion(
      id: Value(id),
      jsonAttribute: Value(jsonAttribute),
      attributeHash: Value(attributeHash),
    );
  }

  factory AvailableProfileAttributesTableData.fromJson(
      Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AvailableProfileAttributesTableData(
      id: serializer.fromJson<int>(json['id']),
      jsonAttribute: serializer.fromJson<JsonString>(json['jsonAttribute']),
      attributeHash:
          serializer.fromJson<api.ProfileAttributeHash>(json['attributeHash']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'jsonAttribute': serializer.toJson<JsonString>(jsonAttribute),
      'attributeHash':
          serializer.toJson<api.ProfileAttributeHash>(attributeHash),
    };
  }

  AvailableProfileAttributesTableData copyWith(
          {int? id,
          JsonString? jsonAttribute,
          api.ProfileAttributeHash? attributeHash}) =>
      AvailableProfileAttributesTableData(
        id: id ?? this.id,
        jsonAttribute: jsonAttribute ?? this.jsonAttribute,
        attributeHash: attributeHash ?? this.attributeHash,
      );
  AvailableProfileAttributesTableData copyWithCompanion(
      AvailableProfileAttributesTableCompanion data) {
    return AvailableProfileAttributesTableData(
      id: data.id.present ? data.id.value : this.id,
      jsonAttribute: data.jsonAttribute.present
          ? data.jsonAttribute.value
          : this.jsonAttribute,
      attributeHash: data.attributeHash.present
          ? data.attributeHash.value
          : this.attributeHash,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AvailableProfileAttributesTableData(')
          ..write('id: $id, ')
          ..write('jsonAttribute: $jsonAttribute, ')
          ..write('attributeHash: $attributeHash')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, jsonAttribute, attributeHash);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AvailableProfileAttributesTableData &&
          other.id == this.id &&
          other.jsonAttribute == this.jsonAttribute &&
          other.attributeHash == this.attributeHash);
}

class AvailableProfileAttributesTableCompanion
    extends UpdateCompanion<AvailableProfileAttributesTableData> {
  final Value<int> id;
  final Value<JsonString> jsonAttribute;
  final Value<api.ProfileAttributeHash> attributeHash;
  const AvailableProfileAttributesTableCompanion({
    this.id = const Value.absent(),
    this.jsonAttribute = const Value.absent(),
    this.attributeHash = const Value.absent(),
  });
  AvailableProfileAttributesTableCompanion.insert({
    this.id = const Value.absent(),
    required JsonString jsonAttribute,
    required api.ProfileAttributeHash attributeHash,
  })  : jsonAttribute = Value(jsonAttribute),
        attributeHash = Value(attributeHash);
  static Insertable<AvailableProfileAttributesTableData> custom({
    Expression<int>? id,
    Expression<String>? jsonAttribute,
    Expression<String>? attributeHash,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (jsonAttribute != null) 'json_attribute': jsonAttribute,
      if (attributeHash != null) 'attribute_hash': attributeHash,
    });
  }

  AvailableProfileAttributesTableCompanion copyWith(
      {Value<int>? id,
      Value<JsonString>? jsonAttribute,
      Value<api.ProfileAttributeHash>? attributeHash}) {
    return AvailableProfileAttributesTableCompanion(
      id: id ?? this.id,
      jsonAttribute: jsonAttribute ?? this.jsonAttribute,
      attributeHash: attributeHash ?? this.attributeHash,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (jsonAttribute.present) {
      map['json_attribute'] = Variable<String>(
          $AvailableProfileAttributesTableTable.$converterjsonAttribute
              .toSql(jsonAttribute.value));
    }
    if (attributeHash.present) {
      map['attribute_hash'] = Variable<String>(
          $AvailableProfileAttributesTableTable.$converterattributeHash
              .toSql(attributeHash.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AvailableProfileAttributesTableCompanion(')
          ..write('id: $id, ')
          ..write('jsonAttribute: $jsonAttribute, ')
          ..write('attributeHash: $attributeHash')
          ..write(')'))
        .toString();
  }
}

class $UiSettingsTable extends UiSettings
    with TableInfo<$UiSettingsTable, UiSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UiSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _advancedFiltersMeta =
      const VerificationMeta('advancedFilters');
  @override
  late final GeneratedColumn<bool> advancedFilters = GeneratedColumn<bool>(
      'advanced_filters', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("advanced_filters" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _gridHorizontalPaddingMeta =
      const VerificationMeta('gridHorizontalPadding');
  @override
  late final GeneratedColumn<double> gridHorizontalPadding =
      GeneratedColumn<double>('grid_horizontal_padding', aliasedName, true,
          type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _gridInternalPaddingMeta =
      const VerificationMeta('gridInternalPadding');
  @override
  late final GeneratedColumn<double> gridInternalPadding =
      GeneratedColumn<double>('grid_internal_padding', aliasedName, true,
          type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _gridProfileThumbnailBorderRadiusMeta =
      const VerificationMeta('gridProfileThumbnailBorderRadius');
  @override
  late final GeneratedColumn<double> gridProfileThumbnailBorderRadius =
      GeneratedColumn<double>(
          'grid_profile_thumbnail_border_radius', aliasedName, true,
          type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _gridRowProfileCountMeta =
      const VerificationMeta('gridRowProfileCount');
  @override
  late final GeneratedColumn<int> gridRowProfileCount = GeneratedColumn<int>(
      'grid_row_profile_count', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        advancedFilters,
        gridHorizontalPadding,
        gridInternalPadding,
        gridProfileThumbnailBorderRadius,
        gridRowProfileCount
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ui_settings';
  @override
  VerificationContext validateIntegrity(Insertable<UiSetting> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('advanced_filters')) {
      context.handle(
          _advancedFiltersMeta,
          advancedFilters.isAcceptableOrUnknown(
              data['advanced_filters']!, _advancedFiltersMeta));
    }
    if (data.containsKey('grid_horizontal_padding')) {
      context.handle(
          _gridHorizontalPaddingMeta,
          gridHorizontalPadding.isAcceptableOrUnknown(
              data['grid_horizontal_padding']!, _gridHorizontalPaddingMeta));
    }
    if (data.containsKey('grid_internal_padding')) {
      context.handle(
          _gridInternalPaddingMeta,
          gridInternalPadding.isAcceptableOrUnknown(
              data['grid_internal_padding']!, _gridInternalPaddingMeta));
    }
    if (data.containsKey('grid_profile_thumbnail_border_radius')) {
      context.handle(
          _gridProfileThumbnailBorderRadiusMeta,
          gridProfileThumbnailBorderRadius.isAcceptableOrUnknown(
              data['grid_profile_thumbnail_border_radius']!,
              _gridProfileThumbnailBorderRadiusMeta));
    }
    if (data.containsKey('grid_row_profile_count')) {
      context.handle(
          _gridRowProfileCountMeta,
          gridRowProfileCount.isAcceptableOrUnknown(
              data['grid_row_profile_count']!, _gridRowProfileCountMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UiSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UiSetting(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      advancedFilters: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}advanced_filters'])!,
      gridHorizontalPadding: attachedDatabase.typeMapping.read(
          DriftSqlType.double,
          data['${effectivePrefix}grid_horizontal_padding']),
      gridInternalPadding: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}grid_internal_padding']),
      gridProfileThumbnailBorderRadius: attachedDatabase.typeMapping.read(
          DriftSqlType.double,
          data['${effectivePrefix}grid_profile_thumbnail_border_radius']),
      gridRowProfileCount: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}grid_row_profile_count']),
    );
  }

  @override
  $UiSettingsTable createAlias(String alias) {
    return $UiSettingsTable(attachedDatabase, alias);
  }
}

class UiSetting extends DataClass implements Insertable<UiSetting> {
  final int id;
  final bool advancedFilters;
  final double? gridHorizontalPadding;
  final double? gridInternalPadding;
  final double? gridProfileThumbnailBorderRadius;
  final int? gridRowProfileCount;
  const UiSetting(
      {required this.id,
      required this.advancedFilters,
      this.gridHorizontalPadding,
      this.gridInternalPadding,
      this.gridProfileThumbnailBorderRadius,
      this.gridRowProfileCount});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['advanced_filters'] = Variable<bool>(advancedFilters);
    if (!nullToAbsent || gridHorizontalPadding != null) {
      map['grid_horizontal_padding'] = Variable<double>(gridHorizontalPadding);
    }
    if (!nullToAbsent || gridInternalPadding != null) {
      map['grid_internal_padding'] = Variable<double>(gridInternalPadding);
    }
    if (!nullToAbsent || gridProfileThumbnailBorderRadius != null) {
      map['grid_profile_thumbnail_border_radius'] =
          Variable<double>(gridProfileThumbnailBorderRadius);
    }
    if (!nullToAbsent || gridRowProfileCount != null) {
      map['grid_row_profile_count'] = Variable<int>(gridRowProfileCount);
    }
    return map;
  }

  UiSettingsCompanion toCompanion(bool nullToAbsent) {
    return UiSettingsCompanion(
      id: Value(id),
      advancedFilters: Value(advancedFilters),
      gridHorizontalPadding: gridHorizontalPadding == null && nullToAbsent
          ? const Value.absent()
          : Value(gridHorizontalPadding),
      gridInternalPadding: gridInternalPadding == null && nullToAbsent
          ? const Value.absent()
          : Value(gridInternalPadding),
      gridProfileThumbnailBorderRadius:
          gridProfileThumbnailBorderRadius == null && nullToAbsent
              ? const Value.absent()
              : Value(gridProfileThumbnailBorderRadius),
      gridRowProfileCount: gridRowProfileCount == null && nullToAbsent
          ? const Value.absent()
          : Value(gridRowProfileCount),
    );
  }

  factory UiSetting.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UiSetting(
      id: serializer.fromJson<int>(json['id']),
      advancedFilters: serializer.fromJson<bool>(json['advancedFilters']),
      gridHorizontalPadding:
          serializer.fromJson<double?>(json['gridHorizontalPadding']),
      gridInternalPadding:
          serializer.fromJson<double?>(json['gridInternalPadding']),
      gridProfileThumbnailBorderRadius: serializer
          .fromJson<double?>(json['gridProfileThumbnailBorderRadius']),
      gridRowProfileCount:
          serializer.fromJson<int?>(json['gridRowProfileCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'advancedFilters': serializer.toJson<bool>(advancedFilters),
      'gridHorizontalPadding':
          serializer.toJson<double?>(gridHorizontalPadding),
      'gridInternalPadding': serializer.toJson<double?>(gridInternalPadding),
      'gridProfileThumbnailBorderRadius':
          serializer.toJson<double?>(gridProfileThumbnailBorderRadius),
      'gridRowProfileCount': serializer.toJson<int?>(gridRowProfileCount),
    };
  }

  UiSetting copyWith(
          {int? id,
          bool? advancedFilters,
          Value<double?> gridHorizontalPadding = const Value.absent(),
          Value<double?> gridInternalPadding = const Value.absent(),
          Value<double?> gridProfileThumbnailBorderRadius =
              const Value.absent(),
          Value<int?> gridRowProfileCount = const Value.absent()}) =>
      UiSetting(
        id: id ?? this.id,
        advancedFilters: advancedFilters ?? this.advancedFilters,
        gridHorizontalPadding: gridHorizontalPadding.present
            ? gridHorizontalPadding.value
            : this.gridHorizontalPadding,
        gridInternalPadding: gridInternalPadding.present
            ? gridInternalPadding.value
            : this.gridInternalPadding,
        gridProfileThumbnailBorderRadius:
            gridProfileThumbnailBorderRadius.present
                ? gridProfileThumbnailBorderRadius.value
                : this.gridProfileThumbnailBorderRadius,
        gridRowProfileCount: gridRowProfileCount.present
            ? gridRowProfileCount.value
            : this.gridRowProfileCount,
      );
  UiSetting copyWithCompanion(UiSettingsCompanion data) {
    return UiSetting(
      id: data.id.present ? data.id.value : this.id,
      advancedFilters: data.advancedFilters.present
          ? data.advancedFilters.value
          : this.advancedFilters,
      gridHorizontalPadding: data.gridHorizontalPadding.present
          ? data.gridHorizontalPadding.value
          : this.gridHorizontalPadding,
      gridInternalPadding: data.gridInternalPadding.present
          ? data.gridInternalPadding.value
          : this.gridInternalPadding,
      gridProfileThumbnailBorderRadius:
          data.gridProfileThumbnailBorderRadius.present
              ? data.gridProfileThumbnailBorderRadius.value
              : this.gridProfileThumbnailBorderRadius,
      gridRowProfileCount: data.gridRowProfileCount.present
          ? data.gridRowProfileCount.value
          : this.gridRowProfileCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UiSetting(')
          ..write('id: $id, ')
          ..write('advancedFilters: $advancedFilters, ')
          ..write('gridHorizontalPadding: $gridHorizontalPadding, ')
          ..write('gridInternalPadding: $gridInternalPadding, ')
          ..write(
              'gridProfileThumbnailBorderRadius: $gridProfileThumbnailBorderRadius, ')
          ..write('gridRowProfileCount: $gridRowProfileCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      advancedFilters,
      gridHorizontalPadding,
      gridInternalPadding,
      gridProfileThumbnailBorderRadius,
      gridRowProfileCount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UiSetting &&
          other.id == this.id &&
          other.advancedFilters == this.advancedFilters &&
          other.gridHorizontalPadding == this.gridHorizontalPadding &&
          other.gridInternalPadding == this.gridInternalPadding &&
          other.gridProfileThumbnailBorderRadius ==
              this.gridProfileThumbnailBorderRadius &&
          other.gridRowProfileCount == this.gridRowProfileCount);
}

class UiSettingsCompanion extends UpdateCompanion<UiSetting> {
  final Value<int> id;
  final Value<bool> advancedFilters;
  final Value<double?> gridHorizontalPadding;
  final Value<double?> gridInternalPadding;
  final Value<double?> gridProfileThumbnailBorderRadius;
  final Value<int?> gridRowProfileCount;
  const UiSettingsCompanion({
    this.id = const Value.absent(),
    this.advancedFilters = const Value.absent(),
    this.gridHorizontalPadding = const Value.absent(),
    this.gridInternalPadding = const Value.absent(),
    this.gridProfileThumbnailBorderRadius = const Value.absent(),
    this.gridRowProfileCount = const Value.absent(),
  });
  UiSettingsCompanion.insert({
    this.id = const Value.absent(),
    this.advancedFilters = const Value.absent(),
    this.gridHorizontalPadding = const Value.absent(),
    this.gridInternalPadding = const Value.absent(),
    this.gridProfileThumbnailBorderRadius = const Value.absent(),
    this.gridRowProfileCount = const Value.absent(),
  });
  static Insertable<UiSetting> custom({
    Expression<int>? id,
    Expression<bool>? advancedFilters,
    Expression<double>? gridHorizontalPadding,
    Expression<double>? gridInternalPadding,
    Expression<double>? gridProfileThumbnailBorderRadius,
    Expression<int>? gridRowProfileCount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (advancedFilters != null) 'advanced_filters': advancedFilters,
      if (gridHorizontalPadding != null)
        'grid_horizontal_padding': gridHorizontalPadding,
      if (gridInternalPadding != null)
        'grid_internal_padding': gridInternalPadding,
      if (gridProfileThumbnailBorderRadius != null)
        'grid_profile_thumbnail_border_radius':
            gridProfileThumbnailBorderRadius,
      if (gridRowProfileCount != null)
        'grid_row_profile_count': gridRowProfileCount,
    });
  }

  UiSettingsCompanion copyWith(
      {Value<int>? id,
      Value<bool>? advancedFilters,
      Value<double?>? gridHorizontalPadding,
      Value<double?>? gridInternalPadding,
      Value<double?>? gridProfileThumbnailBorderRadius,
      Value<int?>? gridRowProfileCount}) {
    return UiSettingsCompanion(
      id: id ?? this.id,
      advancedFilters: advancedFilters ?? this.advancedFilters,
      gridHorizontalPadding:
          gridHorizontalPadding ?? this.gridHorizontalPadding,
      gridInternalPadding: gridInternalPadding ?? this.gridInternalPadding,
      gridProfileThumbnailBorderRadius: gridProfileThumbnailBorderRadius ??
          this.gridProfileThumbnailBorderRadius,
      gridRowProfileCount: gridRowProfileCount ?? this.gridRowProfileCount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (advancedFilters.present) {
      map['advanced_filters'] = Variable<bool>(advancedFilters.value);
    }
    if (gridHorizontalPadding.present) {
      map['grid_horizontal_padding'] =
          Variable<double>(gridHorizontalPadding.value);
    }
    if (gridInternalPadding.present) {
      map['grid_internal_padding'] =
          Variable<double>(gridInternalPadding.value);
    }
    if (gridProfileThumbnailBorderRadius.present) {
      map['grid_profile_thumbnail_border_radius'] =
          Variable<double>(gridProfileThumbnailBorderRadius.value);
    }
    if (gridRowProfileCount.present) {
      map['grid_row_profile_count'] = Variable<int>(gridRowProfileCount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UiSettingsCompanion(')
          ..write('id: $id, ')
          ..write('advancedFilters: $advancedFilters, ')
          ..write('gridHorizontalPadding: $gridHorizontalPadding, ')
          ..write('gridInternalPadding: $gridInternalPadding, ')
          ..write(
              'gridProfileThumbnailBorderRadius: $gridProfileThumbnailBorderRadius, ')
          ..write('gridRowProfileCount: $gridRowProfileCount')
          ..write(')'))
        .toString();
  }
}

abstract class _$AccountDatabase extends GeneratedDatabase {
  _$AccountDatabase(QueryExecutor e) : super(e);
  late final $AccountTable account = $AccountTable(this);
  late final $ProfilesTable profiles = $ProfilesTable(this);
  late final $PublicProfileContentTable publicProfileContent =
      $PublicProfileContentTable(this);
  late final $MyMediaContentTable myMediaContent = $MyMediaContentTable(this);
  late final $ProfileStatesTable profileStates = $ProfileStatesTable(this);
  late final $ConversationListTable conversationList =
      $ConversationListTable(this);
  late final $MessageTableTable messageTable = $MessageTableTable(this);
  late final $ConversationsTable conversations = $ConversationsTable(this);
  late final $AvailableProfileAttributesTableTable
      availableProfileAttributesTable =
      $AvailableProfileAttributesTableTable(this);
  late final $UiSettingsTable uiSettings = $UiSettingsTable(this);
  late final DaoCurrentContent daoCurrentContent =
      DaoCurrentContent(this as AccountDatabase);
  late final DaoMyProfile daoMyProfile = DaoMyProfile(this as AccountDatabase);
  late final DaoProfileSettings daoProfileSettings =
      DaoProfileSettings(this as AccountDatabase);
  late final DaoAccountSettings daoAccountSettings =
      DaoAccountSettings(this as AccountDatabase);
  late final DaoTokens daoTokens = DaoTokens(this as AccountDatabase);
  late final DaoInitialSync daoInitialSync =
      DaoInitialSync(this as AccountDatabase);
  late final DaoSyncVersions daoSyncVersions =
      DaoSyncVersions(this as AccountDatabase);
  late final DaoLocalImageSettings daoLocalImageSettings =
      DaoLocalImageSettings(this as AccountDatabase);
  late final DaoMessageKeys daoMessageKeys =
      DaoMessageKeys(this as AccountDatabase);
  late final DaoProfileInitialAgeInfo daoProfileInitialAgeInfo =
      DaoProfileInitialAgeInfo(this as AccountDatabase);
  late final DaoAvailableProfileAttributes daoAvailableProfileAttributes =
      DaoAvailableProfileAttributes(this as AccountDatabase);
  late final DaoServerMaintenance daoServerMaintenance =
      DaoServerMaintenance(this as AccountDatabase);
  late final DaoCustomReports daoCustomReports =
      DaoCustomReports(this as AccountDatabase);
  late final DaoClientFeatures daoClientFeatures =
      DaoClientFeatures(this as AccountDatabase);
  late final DaoInitialSetup daoInitialSetup =
      DaoInitialSetup(this as AccountDatabase);
  late final DaoMessageTable daoMessageTable =
      DaoMessageTable(this as AccountDatabase);
  late final DaoConversationList daoConversationList =
      DaoConversationList(this as AccountDatabase);
  late final DaoProfiles daoProfiles = DaoProfiles(this as AccountDatabase);
  late final DaoPublicProfileContent daoPublicProfileContent =
      DaoPublicProfileContent(this as AccountDatabase);
  late final DaoMyMediaContent daoMyMediaContent =
      DaoMyMediaContent(this as AccountDatabase);
  late final DaoProfileStates daoProfileStates =
      DaoProfileStates(this as AccountDatabase);
  late final DaoConversations daoConversations =
      DaoConversations(this as AccountDatabase);
  late final DaoAvailableProfileAttributesTable
      daoAvailableProfileAttributesTable =
      DaoAvailableProfileAttributesTable(this as AccountDatabase);
  late final DaoUiSettings daoUiSettings =
      DaoUiSettings(this as AccountDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        account,
        profiles,
        publicProfileContent,
        myMediaContent,
        profileStates,
        conversationList,
        messageTable,
        conversations,
        availableProfileAttributesTable,
        uiSettings
      ];
}
