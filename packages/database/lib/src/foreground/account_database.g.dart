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
  static const VerificationMeta _uuidAccountIdMeta =
      const VerificationMeta('uuidAccountId');
  @override
  late final GeneratedColumnWithTypeConverter<AccountId?, String>
      uuidAccountId = GeneratedColumn<String>(
              'uuid_account_id', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<AccountId?>($AccountTable.$converteruuidAccountId);
  static const VerificationMeta _jsonAccountStateMeta =
      const VerificationMeta('jsonAccountState');
  @override
  late final GeneratedColumnWithTypeConverter<EnumString?, String>
      jsonAccountState = GeneratedColumn<String>(
              'json_account_state', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<EnumString?>($AccountTable.$converterjsonAccountState);
  static const VerificationMeta _jsonCapabilitiesMeta =
      const VerificationMeta('jsonCapabilities');
  @override
  late final GeneratedColumnWithTypeConverter<JsonString?, String>
      jsonCapabilities = GeneratedColumn<String>(
              'json_capabilities', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<JsonString?>($AccountTable.$converterjsonCapabilities);
  static const VerificationMeta _jsonAvailableProfileAttributesMeta =
      const VerificationMeta('jsonAvailableProfileAttributes');
  @override
  late final GeneratedColumnWithTypeConverter<JsonString?, String>
      jsonAvailableProfileAttributes = GeneratedColumn<String>(
              'json_available_profile_attributes', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<JsonString?>(
              $AccountTable.$converterjsonAvailableProfileAttributes);
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
  static const VerificationMeta _profileIteratorSessionIdMeta =
      const VerificationMeta('profileIteratorSessionId');
  @override
  late final GeneratedColumnWithTypeConverter<IteratorSessionId?, String>
      profileIteratorSessionId = GeneratedColumn<String>(
              'profile_iterator_session_id', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<IteratorSessionId?>(
              $AccountTable.$converterprofileIteratorSessionId);
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
  static const VerificationMeta _syncVersionReceivedLikesMeta =
      const VerificationMeta('syncVersionReceivedLikes');
  @override
  late final GeneratedColumn<int> syncVersionReceivedLikes =
      GeneratedColumn<int>('sync_version_received_likes', aliasedName, true,
          type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _syncVersionReceivedBlocksMeta =
      const VerificationMeta('syncVersionReceivedBlocks');
  @override
  late final GeneratedColumn<int> syncVersionReceivedBlocks =
      GeneratedColumn<int>('sync_version_received_blocks', aliasedName, true,
          type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _syncVersionSentLikesMeta =
      const VerificationMeta('syncVersionSentLikes');
  @override
  late final GeneratedColumn<int> syncVersionSentLikes = GeneratedColumn<int>(
      'sync_version_sent_likes', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _syncVersionSentBlocksMeta =
      const VerificationMeta('syncVersionSentBlocks');
  @override
  late final GeneratedColumn<int> syncVersionSentBlocks = GeneratedColumn<int>(
      'sync_version_sent_blocks', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _syncVersionMatchesMeta =
      const VerificationMeta('syncVersionMatches');
  @override
  late final GeneratedColumn<int> syncVersionMatches = GeneratedColumn<int>(
      'sync_version_matches', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _syncVersionAvailableProfileAttributesMeta =
      const VerificationMeta('syncVersionAvailableProfileAttributes');
  @override
  late final GeneratedColumn<int> syncVersionAvailableProfileAttributes =
      GeneratedColumn<int>(
          'sync_version_available_profile_attributes', aliasedName, true,
          type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _uuidPendingContentId0Meta =
      const VerificationMeta('uuidPendingContentId0');
  @override
  late final GeneratedColumnWithTypeConverter<ContentId?, String>
      uuidPendingContentId0 = GeneratedColumn<String>(
              'uuid_pending_content_id0', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<ContentId?>(
              $AccountTable.$converteruuidPendingContentId0);
  static const VerificationMeta _uuidPendingContentId1Meta =
      const VerificationMeta('uuidPendingContentId1');
  @override
  late final GeneratedColumnWithTypeConverter<ContentId?, String>
      uuidPendingContentId1 = GeneratedColumn<String>(
              'uuid_pending_content_id1', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<ContentId?>(
              $AccountTable.$converteruuidPendingContentId1);
  static const VerificationMeta _uuidPendingContentId2Meta =
      const VerificationMeta('uuidPendingContentId2');
  @override
  late final GeneratedColumnWithTypeConverter<ContentId?, String>
      uuidPendingContentId2 = GeneratedColumn<String>(
              'uuid_pending_content_id2', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<ContentId?>(
              $AccountTable.$converteruuidPendingContentId2);
  static const VerificationMeta _uuidPendingContentId3Meta =
      const VerificationMeta('uuidPendingContentId3');
  @override
  late final GeneratedColumnWithTypeConverter<ContentId?, String>
      uuidPendingContentId3 = GeneratedColumn<String>(
              'uuid_pending_content_id3', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<ContentId?>(
              $AccountTable.$converteruuidPendingContentId3);
  static const VerificationMeta _uuidPendingContentId4Meta =
      const VerificationMeta('uuidPendingContentId4');
  @override
  late final GeneratedColumnWithTypeConverter<ContentId?, String>
      uuidPendingContentId4 = GeneratedColumn<String>(
              'uuid_pending_content_id4', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<ContentId?>(
              $AccountTable.$converteruuidPendingContentId4);
  static const VerificationMeta _uuidPendingContentId5Meta =
      const VerificationMeta('uuidPendingContentId5');
  @override
  late final GeneratedColumnWithTypeConverter<ContentId?, String>
      uuidPendingContentId5 = GeneratedColumn<String>(
              'uuid_pending_content_id5', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<ContentId?>(
              $AccountTable.$converteruuidPendingContentId5);
  static const VerificationMeta _uuidPendingSecurityContentIdMeta =
      const VerificationMeta('uuidPendingSecurityContentId');
  @override
  late final GeneratedColumnWithTypeConverter<ContentId?, String>
      uuidPendingSecurityContentId = GeneratedColumn<String>(
              'uuid_pending_security_content_id', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<ContentId?>(
              $AccountTable.$converteruuidPendingSecurityContentId);
  static const VerificationMeta _pendingPrimaryContentGridCropSizeMeta =
      const VerificationMeta('pendingPrimaryContentGridCropSize');
  @override
  late final GeneratedColumn<double> pendingPrimaryContentGridCropSize =
      GeneratedColumn<double>(
          'pending_primary_content_grid_crop_size', aliasedName, true,
          type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _pendingPrimaryContentGridCropXMeta =
      const VerificationMeta('pendingPrimaryContentGridCropX');
  @override
  late final GeneratedColumn<double> pendingPrimaryContentGridCropX =
      GeneratedColumn<double>(
          'pending_primary_content_grid_crop_x', aliasedName, true,
          type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _pendingPrimaryContentGridCropYMeta =
      const VerificationMeta('pendingPrimaryContentGridCropY');
  @override
  late final GeneratedColumn<double> pendingPrimaryContentGridCropY =
      GeneratedColumn<double>(
          'pending_primary_content_grid_crop_y', aliasedName, true,
          type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _uuidContentId0Meta =
      const VerificationMeta('uuidContentId0');
  @override
  late final GeneratedColumnWithTypeConverter<ContentId?, String>
      uuidContentId0 = GeneratedColumn<String>(
              'uuid_content_id0', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<ContentId?>($AccountTable.$converteruuidContentId0);
  static const VerificationMeta _uuidContentId1Meta =
      const VerificationMeta('uuidContentId1');
  @override
  late final GeneratedColumnWithTypeConverter<ContentId?, String>
      uuidContentId1 = GeneratedColumn<String>(
              'uuid_content_id1', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<ContentId?>($AccountTable.$converteruuidContentId1);
  static const VerificationMeta _uuidContentId2Meta =
      const VerificationMeta('uuidContentId2');
  @override
  late final GeneratedColumnWithTypeConverter<ContentId?, String>
      uuidContentId2 = GeneratedColumn<String>(
              'uuid_content_id2', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<ContentId?>($AccountTable.$converteruuidContentId2);
  static const VerificationMeta _uuidContentId3Meta =
      const VerificationMeta('uuidContentId3');
  @override
  late final GeneratedColumnWithTypeConverter<ContentId?, String>
      uuidContentId3 = GeneratedColumn<String>(
              'uuid_content_id3', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<ContentId?>($AccountTable.$converteruuidContentId3);
  static const VerificationMeta _uuidContentId4Meta =
      const VerificationMeta('uuidContentId4');
  @override
  late final GeneratedColumnWithTypeConverter<ContentId?, String>
      uuidContentId4 = GeneratedColumn<String>(
              'uuid_content_id4', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<ContentId?>($AccountTable.$converteruuidContentId4);
  static const VerificationMeta _uuidContentId5Meta =
      const VerificationMeta('uuidContentId5');
  @override
  late final GeneratedColumnWithTypeConverter<ContentId?, String>
      uuidContentId5 = GeneratedColumn<String>(
              'uuid_content_id5', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<ContentId?>($AccountTable.$converteruuidContentId5);
  static const VerificationMeta _uuidSecurityContentIdMeta =
      const VerificationMeta('uuidSecurityContentId');
  @override
  late final GeneratedColumnWithTypeConverter<ContentId?, String>
      uuidSecurityContentId = GeneratedColumn<String>(
              'uuid_security_content_id', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<ContentId?>(
              $AccountTable.$converteruuidSecurityContentId);
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
  static const VerificationMeta _profileContentVersionMeta =
      const VerificationMeta('profileContentVersion');
  @override
  late final GeneratedColumnWithTypeConverter<ProfileContentVersion?, String>
      profileContentVersion = GeneratedColumn<String>(
              'profile_content_version', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<ProfileContentVersion?>(
              $AccountTable.$converterprofileContentVersion);
  static const VerificationMeta _profileNameMeta =
      const VerificationMeta('profileName');
  @override
  late final GeneratedColumn<String> profileName = GeneratedColumn<String>(
      'profile_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _profileTextMeta =
      const VerificationMeta('profileText');
  @override
  late final GeneratedColumn<String> profileText = GeneratedColumn<String>(
      'profile_text', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
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
  static const VerificationMeta _profileVersionMeta =
      const VerificationMeta('profileVersion');
  @override
  late final GeneratedColumnWithTypeConverter<ProfileVersion?, String>
      profileVersion = GeneratedColumn<String>(
              'profile_version', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<ProfileVersion?>(
              $AccountTable.$converterprofileVersion);
  static const VerificationMeta _jsonProfileAttributesMeta =
      const VerificationMeta('jsonProfileAttributes');
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
  static const VerificationMeta _jsonProfileVisibilityMeta =
      const VerificationMeta('jsonProfileVisibility');
  @override
  late final GeneratedColumnWithTypeConverter<EnumString?, String>
      jsonProfileVisibility = GeneratedColumn<String>(
              'json_profile_visibility', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<EnumString?>(
              $AccountTable.$converterjsonProfileVisibility);
  static const VerificationMeta _jsonSearchGroupsMeta =
      const VerificationMeta('jsonSearchGroups');
  @override
  late final GeneratedColumnWithTypeConverter<JsonString?, String>
      jsonSearchGroups = GeneratedColumn<String>(
              'json_search_groups', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<JsonString?>($AccountTable.$converterjsonSearchGroups);
  static const VerificationMeta _jsonProfileAttributeFiltersMeta =
      const VerificationMeta('jsonProfileAttributeFilters');
  @override
  late final GeneratedColumnWithTypeConverter<JsonString?, String>
      jsonProfileAttributeFilters = GeneratedColumn<String>(
              'json_profile_attribute_filters', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<JsonString?>(
              $AccountTable.$converterjsonProfileAttributeFilters);
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
  static const VerificationMeta _profileLastSeenTimeFilterMeta =
      const VerificationMeta('profileLastSeenTimeFilter');
  @override
  late final GeneratedColumnWithTypeConverter<LastSeenTimeFilter?, int>
      profileLastSeenTimeFilter = GeneratedColumn<int>(
              'profile_last_seen_time_filter', aliasedName, true,
              type: DriftSqlType.int, requiredDuringInsert: false)
          .withConverter<LastSeenTimeFilter?>(
              $AccountTable.$converterprofileLastSeenTimeFilter);
  static const VerificationMeta _profileUnlimitedLikesFilterMeta =
      const VerificationMeta('profileUnlimitedLikesFilter');
  @override
  late final GeneratedColumn<bool> profileUnlimitedLikesFilter =
      GeneratedColumn<bool>('profile_unlimited_likes_filter', aliasedName, true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("profile_unlimited_likes_filter" IN (0, 1))'));
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
  static const VerificationMeta _privateKeyDataMeta =
      const VerificationMeta('privateKeyData');
  @override
  late final GeneratedColumnWithTypeConverter<PrivateKeyData?, String>
      privateKeyData = GeneratedColumn<String>(
              'private_key_data', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<PrivateKeyData?>(
              $AccountTable.$converterprivateKeyData);
  static const VerificationMeta _publicKeyDataMeta =
      const VerificationMeta('publicKeyData');
  @override
  late final GeneratedColumnWithTypeConverter<PublicKeyData?, String>
      publicKeyData = GeneratedColumn<String>(
              'public_key_data', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<PublicKeyData?>($AccountTable.$converterpublicKeyData);
  static const VerificationMeta _publicKeyIdMeta =
      const VerificationMeta('publicKeyId');
  @override
  late final GeneratedColumnWithTypeConverter<PublicKeyId?, int> publicKeyId =
      GeneratedColumn<int>('public_key_id', aliasedName, true,
              type: DriftSqlType.int, requiredDuringInsert: false)
          .withConverter<PublicKeyId?>($AccountTable.$converterpublicKeyId);
  static const VerificationMeta _publicKeyVersionMeta =
      const VerificationMeta('publicKeyVersion');
  @override
  late final GeneratedColumnWithTypeConverter<PublicKeyVersion?, int>
      publicKeyVersion = GeneratedColumn<int>(
              'public_key_version', aliasedName, true,
              type: DriftSqlType.int, requiredDuringInsert: false)
          .withConverter<PublicKeyVersion?>(
              $AccountTable.$converterpublicKeyVersion);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        uuidAccountId,
        jsonAccountState,
        jsonCapabilities,
        jsonAvailableProfileAttributes,
        profileFilterFavorites,
        profileIteratorSessionId,
        initialSyncDoneLoginRepository,
        initialSyncDoneAccountRepository,
        initialSyncDoneMediaRepository,
        initialSyncDoneProfileRepository,
        initialSyncDoneChatRepository,
        syncVersionAccount,
        syncVersionReceivedLikes,
        syncVersionReceivedBlocks,
        syncVersionSentLikes,
        syncVersionSentBlocks,
        syncVersionMatches,
        syncVersionAvailableProfileAttributes,
        uuidPendingContentId0,
        uuidPendingContentId1,
        uuidPendingContentId2,
        uuidPendingContentId3,
        uuidPendingContentId4,
        uuidPendingContentId5,
        uuidPendingSecurityContentId,
        pendingPrimaryContentGridCropSize,
        pendingPrimaryContentGridCropX,
        pendingPrimaryContentGridCropY,
        uuidContentId0,
        uuidContentId1,
        uuidContentId2,
        uuidContentId3,
        uuidContentId4,
        uuidContentId5,
        uuidSecurityContentId,
        primaryContentGridCropSize,
        primaryContentGridCropX,
        primaryContentGridCropY,
        profileContentVersion,
        profileName,
        profileText,
        profileAge,
        profileUnlimitedLikes,
        profileVersion,
        jsonProfileAttributes,
        profileLocationLatitude,
        profileLocationLongitude,
        jsonProfileVisibility,
        jsonSearchGroups,
        jsonProfileAttributeFilters,
        profileSearchAgeRangeMin,
        profileSearchAgeRangeMax,
        profileLastSeenTimeFilter,
        profileUnlimitedLikesFilter,
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
        publicKeyVersion
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
    context.handle(_uuidAccountIdMeta, const VerificationResult.success());
    context.handle(_jsonAccountStateMeta, const VerificationResult.success());
    context.handle(_jsonCapabilitiesMeta, const VerificationResult.success());
    context.handle(_jsonAvailableProfileAttributesMeta,
        const VerificationResult.success());
    if (data.containsKey('profile_filter_favorites')) {
      context.handle(
          _profileFilterFavoritesMeta,
          profileFilterFavorites.isAcceptableOrUnknown(
              data['profile_filter_favorites']!, _profileFilterFavoritesMeta));
    }
    context.handle(
        _profileIteratorSessionIdMeta, const VerificationResult.success());
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
    if (data.containsKey('sync_version_received_likes')) {
      context.handle(
          _syncVersionReceivedLikesMeta,
          syncVersionReceivedLikes.isAcceptableOrUnknown(
              data['sync_version_received_likes']!,
              _syncVersionReceivedLikesMeta));
    }
    if (data.containsKey('sync_version_received_blocks')) {
      context.handle(
          _syncVersionReceivedBlocksMeta,
          syncVersionReceivedBlocks.isAcceptableOrUnknown(
              data['sync_version_received_blocks']!,
              _syncVersionReceivedBlocksMeta));
    }
    if (data.containsKey('sync_version_sent_likes')) {
      context.handle(
          _syncVersionSentLikesMeta,
          syncVersionSentLikes.isAcceptableOrUnknown(
              data['sync_version_sent_likes']!, _syncVersionSentLikesMeta));
    }
    if (data.containsKey('sync_version_sent_blocks')) {
      context.handle(
          _syncVersionSentBlocksMeta,
          syncVersionSentBlocks.isAcceptableOrUnknown(
              data['sync_version_sent_blocks']!, _syncVersionSentBlocksMeta));
    }
    if (data.containsKey('sync_version_matches')) {
      context.handle(
          _syncVersionMatchesMeta,
          syncVersionMatches.isAcceptableOrUnknown(
              data['sync_version_matches']!, _syncVersionMatchesMeta));
    }
    if (data.containsKey('sync_version_available_profile_attributes')) {
      context.handle(
          _syncVersionAvailableProfileAttributesMeta,
          syncVersionAvailableProfileAttributes.isAcceptableOrUnknown(
              data['sync_version_available_profile_attributes']!,
              _syncVersionAvailableProfileAttributesMeta));
    }
    context.handle(
        _uuidPendingContentId0Meta, const VerificationResult.success());
    context.handle(
        _uuidPendingContentId1Meta, const VerificationResult.success());
    context.handle(
        _uuidPendingContentId2Meta, const VerificationResult.success());
    context.handle(
        _uuidPendingContentId3Meta, const VerificationResult.success());
    context.handle(
        _uuidPendingContentId4Meta, const VerificationResult.success());
    context.handle(
        _uuidPendingContentId5Meta, const VerificationResult.success());
    context.handle(
        _uuidPendingSecurityContentIdMeta, const VerificationResult.success());
    if (data.containsKey('pending_primary_content_grid_crop_size')) {
      context.handle(
          _pendingPrimaryContentGridCropSizeMeta,
          pendingPrimaryContentGridCropSize.isAcceptableOrUnknown(
              data['pending_primary_content_grid_crop_size']!,
              _pendingPrimaryContentGridCropSizeMeta));
    }
    if (data.containsKey('pending_primary_content_grid_crop_x')) {
      context.handle(
          _pendingPrimaryContentGridCropXMeta,
          pendingPrimaryContentGridCropX.isAcceptableOrUnknown(
              data['pending_primary_content_grid_crop_x']!,
              _pendingPrimaryContentGridCropXMeta));
    }
    if (data.containsKey('pending_primary_content_grid_crop_y')) {
      context.handle(
          _pendingPrimaryContentGridCropYMeta,
          pendingPrimaryContentGridCropY.isAcceptableOrUnknown(
              data['pending_primary_content_grid_crop_y']!,
              _pendingPrimaryContentGridCropYMeta));
    }
    context.handle(_uuidContentId0Meta, const VerificationResult.success());
    context.handle(_uuidContentId1Meta, const VerificationResult.success());
    context.handle(_uuidContentId2Meta, const VerificationResult.success());
    context.handle(_uuidContentId3Meta, const VerificationResult.success());
    context.handle(_uuidContentId4Meta, const VerificationResult.success());
    context.handle(_uuidContentId5Meta, const VerificationResult.success());
    context.handle(
        _uuidSecurityContentIdMeta, const VerificationResult.success());
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
    context.handle(
        _profileContentVersionMeta, const VerificationResult.success());
    if (data.containsKey('profile_name')) {
      context.handle(
          _profileNameMeta,
          profileName.isAcceptableOrUnknown(
              data['profile_name']!, _profileNameMeta));
    }
    if (data.containsKey('profile_text')) {
      context.handle(
          _profileTextMeta,
          profileText.isAcceptableOrUnknown(
              data['profile_text']!, _profileTextMeta));
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
    context.handle(_profileVersionMeta, const VerificationResult.success());
    context.handle(
        _jsonProfileAttributesMeta, const VerificationResult.success());
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
    context.handle(
        _jsonProfileVisibilityMeta, const VerificationResult.success());
    context.handle(_jsonSearchGroupsMeta, const VerificationResult.success());
    context.handle(
        _jsonProfileAttributeFiltersMeta, const VerificationResult.success());
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
    context.handle(
        _profileLastSeenTimeFilterMeta, const VerificationResult.success());
    if (data.containsKey('profile_unlimited_likes_filter')) {
      context.handle(
          _profileUnlimitedLikesFilterMeta,
          profileUnlimitedLikesFilter.isAcceptableOrUnknown(
              data['profile_unlimited_likes_filter']!,
              _profileUnlimitedLikesFilterMeta));
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
    context.handle(_privateKeyDataMeta, const VerificationResult.success());
    context.handle(_publicKeyDataMeta, const VerificationResult.success());
    context.handle(_publicKeyIdMeta, const VerificationResult.success());
    context.handle(_publicKeyVersionMeta, const VerificationResult.success());
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
      jsonCapabilities: $AccountTable.$converterjsonCapabilities.fromSql(
          attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}json_capabilities'])),
      jsonAvailableProfileAttributes: $AccountTable
          .$converterjsonAvailableProfileAttributes
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}json_available_profile_attributes'])),
      profileFilterFavorites: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}profile_filter_favorites'])!,
      profileIteratorSessionId: $AccountTable.$converterprofileIteratorSessionId
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}profile_iterator_session_id'])),
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
      syncVersionReceivedLikes: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}sync_version_received_likes']),
      syncVersionReceivedBlocks: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}sync_version_received_blocks']),
      syncVersionSentLikes: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}sync_version_sent_likes']),
      syncVersionSentBlocks: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}sync_version_sent_blocks']),
      syncVersionMatches: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}sync_version_matches']),
      syncVersionAvailableProfileAttributes: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}sync_version_available_profile_attributes']),
      uuidPendingContentId0: $AccountTable.$converteruuidPendingContentId0
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}uuid_pending_content_id0'])),
      uuidPendingContentId1: $AccountTable.$converteruuidPendingContentId1
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}uuid_pending_content_id1'])),
      uuidPendingContentId2: $AccountTable.$converteruuidPendingContentId2
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}uuid_pending_content_id2'])),
      uuidPendingContentId3: $AccountTable.$converteruuidPendingContentId3
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}uuid_pending_content_id3'])),
      uuidPendingContentId4: $AccountTable.$converteruuidPendingContentId4
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}uuid_pending_content_id4'])),
      uuidPendingContentId5: $AccountTable.$converteruuidPendingContentId5
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}uuid_pending_content_id5'])),
      uuidPendingSecurityContentId: $AccountTable
          .$converteruuidPendingSecurityContentId
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}uuid_pending_security_content_id'])),
      pendingPrimaryContentGridCropSize: attachedDatabase.typeMapping.read(
          DriftSqlType.double,
          data['${effectivePrefix}pending_primary_content_grid_crop_size']),
      pendingPrimaryContentGridCropX: attachedDatabase.typeMapping.read(
          DriftSqlType.double,
          data['${effectivePrefix}pending_primary_content_grid_crop_x']),
      pendingPrimaryContentGridCropY: attachedDatabase.typeMapping.read(
          DriftSqlType.double,
          data['${effectivePrefix}pending_primary_content_grid_crop_y']),
      uuidContentId0: $AccountTable.$converteruuidContentId0.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}uuid_content_id0'])),
      uuidContentId1: $AccountTable.$converteruuidContentId1.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}uuid_content_id1'])),
      uuidContentId2: $AccountTable.$converteruuidContentId2.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}uuid_content_id2'])),
      uuidContentId3: $AccountTable.$converteruuidContentId3.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}uuid_content_id3'])),
      uuidContentId4: $AccountTable.$converteruuidContentId4.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}uuid_content_id4'])),
      uuidContentId5: $AccountTable.$converteruuidContentId5.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}uuid_content_id5'])),
      uuidSecurityContentId: $AccountTable.$converteruuidSecurityContentId
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}uuid_security_content_id'])),
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
      profileText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}profile_text']),
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
      jsonProfileVisibility: $AccountTable.$converterjsonProfileVisibility
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}json_profile_visibility'])),
      jsonSearchGroups: $AccountTable.$converterjsonSearchGroups.fromSql(
          attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}json_search_groups'])),
      jsonProfileAttributeFilters: $AccountTable
          .$converterjsonProfileAttributeFilters
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}json_profile_attribute_filters'])),
      profileSearchAgeRangeMin: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}profile_search_age_range_min']),
      profileSearchAgeRangeMax: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}profile_search_age_range_max']),
      profileLastSeenTimeFilter: $AccountTable
          .$converterprofileLastSeenTimeFilter
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.int,
              data['${effectivePrefix}profile_last_seen_time_filter'])),
      profileUnlimitedLikesFilter: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}profile_unlimited_likes_filter']),
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
              DriftSqlType.string, data['${effectivePrefix}private_key_data'])),
      publicKeyData: $AccountTable.$converterpublicKeyData.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}public_key_data'])),
      publicKeyId: $AccountTable.$converterpublicKeyId.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}public_key_id'])),
      publicKeyVersion: $AccountTable.$converterpublicKeyVersion.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.int, data['${effectivePrefix}public_key_version'])),
    );
  }

  @override
  $AccountTable createAlias(String alias) {
    return $AccountTable(attachedDatabase, alias);
  }

  static TypeConverter<AccountId?, String?> $converteruuidAccountId =
      const NullAwareTypeConverter.wrap(AccountIdConverter());
  static TypeConverter<EnumString?, String?> $converterjsonAccountState =
      NullAwareTypeConverter.wrap(EnumString.driftConverter);
  static TypeConverter<JsonString?, String?> $converterjsonCapabilities =
      NullAwareTypeConverter.wrap(JsonString.driftConverter);
  static TypeConverter<JsonString?, String?>
      $converterjsonAvailableProfileAttributes =
      NullAwareTypeConverter.wrap(JsonString.driftConverter);
  static TypeConverter<IteratorSessionId?, String?>
      $converterprofileIteratorSessionId =
      const NullAwareTypeConverter.wrap(IteratorSessionIdConverter());
  static TypeConverter<ContentId?, String?> $converteruuidPendingContentId0 =
      const NullAwareTypeConverter.wrap(ContentIdConverter());
  static TypeConverter<ContentId?, String?> $converteruuidPendingContentId1 =
      const NullAwareTypeConverter.wrap(ContentIdConverter());
  static TypeConverter<ContentId?, String?> $converteruuidPendingContentId2 =
      const NullAwareTypeConverter.wrap(ContentIdConverter());
  static TypeConverter<ContentId?, String?> $converteruuidPendingContentId3 =
      const NullAwareTypeConverter.wrap(ContentIdConverter());
  static TypeConverter<ContentId?, String?> $converteruuidPendingContentId4 =
      const NullAwareTypeConverter.wrap(ContentIdConverter());
  static TypeConverter<ContentId?, String?> $converteruuidPendingContentId5 =
      const NullAwareTypeConverter.wrap(ContentIdConverter());
  static TypeConverter<ContentId?, String?>
      $converteruuidPendingSecurityContentId =
      const NullAwareTypeConverter.wrap(ContentIdConverter());
  static TypeConverter<ContentId?, String?> $converteruuidContentId0 =
      const NullAwareTypeConverter.wrap(ContentIdConverter());
  static TypeConverter<ContentId?, String?> $converteruuidContentId1 =
      const NullAwareTypeConverter.wrap(ContentIdConverter());
  static TypeConverter<ContentId?, String?> $converteruuidContentId2 =
      const NullAwareTypeConverter.wrap(ContentIdConverter());
  static TypeConverter<ContentId?, String?> $converteruuidContentId3 =
      const NullAwareTypeConverter.wrap(ContentIdConverter());
  static TypeConverter<ContentId?, String?> $converteruuidContentId4 =
      const NullAwareTypeConverter.wrap(ContentIdConverter());
  static TypeConverter<ContentId?, String?> $converteruuidContentId5 =
      const NullAwareTypeConverter.wrap(ContentIdConverter());
  static TypeConverter<ContentId?, String?> $converteruuidSecurityContentId =
      const NullAwareTypeConverter.wrap(ContentIdConverter());
  static TypeConverter<ProfileContentVersion?, String?>
      $converterprofileContentVersion =
      const NullAwareTypeConverter.wrap(ProfileContentVersionConverter());
  static TypeConverter<ProfileVersion?, String?> $converterprofileVersion =
      const NullAwareTypeConverter.wrap(ProfileVersionConverter());
  static TypeConverter<JsonList?, String?> $converterjsonProfileAttributes =
      NullAwareTypeConverter.wrap(JsonList.driftConverter);
  static TypeConverter<EnumString?, String?> $converterjsonProfileVisibility =
      NullAwareTypeConverter.wrap(EnumString.driftConverter);
  static TypeConverter<JsonString?, String?> $converterjsonSearchGroups =
      NullAwareTypeConverter.wrap(JsonString.driftConverter);
  static TypeConverter<JsonString?, String?>
      $converterjsonProfileAttributeFilters =
      NullAwareTypeConverter.wrap(JsonString.driftConverter);
  static TypeConverter<LastSeenTimeFilter?, int?>
      $converterprofileLastSeenTimeFilter =
      const NullAwareTypeConverter.wrap(LastSeenTimeFilterConverter());
  static TypeConverter<PrivateKeyData?, String?> $converterprivateKeyData =
      const NullAwareTypeConverter.wrap(PrivateKeyDataConverter());
  static TypeConverter<PublicKeyData?, String?> $converterpublicKeyData =
      const NullAwareTypeConverter.wrap(PublicKeyDataConverter());
  static TypeConverter<PublicKeyId?, int?> $converterpublicKeyId =
      const NullAwareTypeConverter.wrap(PublicKeyIdConverter());
  static TypeConverter<PublicKeyVersion?, int?> $converterpublicKeyVersion =
      const NullAwareTypeConverter.wrap(PublicKeyVersionConverter());
}

class AccountData extends DataClass implements Insertable<AccountData> {
  final int id;
  final AccountId? uuidAccountId;
  final EnumString? jsonAccountState;
  final JsonString? jsonCapabilities;
  final JsonString? jsonAvailableProfileAttributes;

  /// If true show only favorite profiles
  final bool profileFilterFavorites;
  final IteratorSessionId? profileIteratorSessionId;
  final bool initialSyncDoneLoginRepository;
  final bool initialSyncDoneAccountRepository;
  final bool initialSyncDoneMediaRepository;
  final bool initialSyncDoneProfileRepository;
  final bool initialSyncDoneChatRepository;
  final int? syncVersionAccount;
  final int? syncVersionReceivedLikes;
  final int? syncVersionReceivedBlocks;
  final int? syncVersionSentLikes;
  final int? syncVersionSentBlocks;
  final int? syncVersionMatches;
  final int? syncVersionAvailableProfileAttributes;
  final ContentId? uuidPendingContentId0;
  final ContentId? uuidPendingContentId1;
  final ContentId? uuidPendingContentId2;
  final ContentId? uuidPendingContentId3;
  final ContentId? uuidPendingContentId4;
  final ContentId? uuidPendingContentId5;
  final ContentId? uuidPendingSecurityContentId;
  final double? pendingPrimaryContentGridCropSize;
  final double? pendingPrimaryContentGridCropX;
  final double? pendingPrimaryContentGridCropY;
  final ContentId? uuidContentId0;
  final ContentId? uuidContentId1;
  final ContentId? uuidContentId2;
  final ContentId? uuidContentId3;
  final ContentId? uuidContentId4;
  final ContentId? uuidContentId5;
  final ContentId? uuidSecurityContentId;
  final double? primaryContentGridCropSize;
  final double? primaryContentGridCropX;
  final double? primaryContentGridCropY;
  final ProfileContentVersion? profileContentVersion;
  final String? profileName;
  final String? profileText;
  final int? profileAge;
  final bool? profileUnlimitedLikes;
  final ProfileVersion? profileVersion;
  final JsonList? jsonProfileAttributes;
  final double? profileLocationLatitude;
  final double? profileLocationLongitude;
  final EnumString? jsonProfileVisibility;
  final JsonString? jsonSearchGroups;
  final JsonString? jsonProfileAttributeFilters;
  final int? profileSearchAgeRangeMin;
  final int? profileSearchAgeRangeMax;
  final LastSeenTimeFilter? profileLastSeenTimeFilter;
  final bool? profileUnlimitedLikesFilter;
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
  final PublicKeyId? publicKeyId;
  final PublicKeyVersion? publicKeyVersion;
  const AccountData(
      {required this.id,
      this.uuidAccountId,
      this.jsonAccountState,
      this.jsonCapabilities,
      this.jsonAvailableProfileAttributes,
      required this.profileFilterFavorites,
      this.profileIteratorSessionId,
      required this.initialSyncDoneLoginRepository,
      required this.initialSyncDoneAccountRepository,
      required this.initialSyncDoneMediaRepository,
      required this.initialSyncDoneProfileRepository,
      required this.initialSyncDoneChatRepository,
      this.syncVersionAccount,
      this.syncVersionReceivedLikes,
      this.syncVersionReceivedBlocks,
      this.syncVersionSentLikes,
      this.syncVersionSentBlocks,
      this.syncVersionMatches,
      this.syncVersionAvailableProfileAttributes,
      this.uuidPendingContentId0,
      this.uuidPendingContentId1,
      this.uuidPendingContentId2,
      this.uuidPendingContentId3,
      this.uuidPendingContentId4,
      this.uuidPendingContentId5,
      this.uuidPendingSecurityContentId,
      this.pendingPrimaryContentGridCropSize,
      this.pendingPrimaryContentGridCropX,
      this.pendingPrimaryContentGridCropY,
      this.uuidContentId0,
      this.uuidContentId1,
      this.uuidContentId2,
      this.uuidContentId3,
      this.uuidContentId4,
      this.uuidContentId5,
      this.uuidSecurityContentId,
      this.primaryContentGridCropSize,
      this.primaryContentGridCropX,
      this.primaryContentGridCropY,
      this.profileContentVersion,
      this.profileName,
      this.profileText,
      this.profileAge,
      this.profileUnlimitedLikes,
      this.profileVersion,
      this.jsonProfileAttributes,
      this.profileLocationLatitude,
      this.profileLocationLongitude,
      this.jsonProfileVisibility,
      this.jsonSearchGroups,
      this.jsonProfileAttributeFilters,
      this.profileSearchAgeRangeMin,
      this.profileSearchAgeRangeMax,
      this.profileLastSeenTimeFilter,
      this.profileUnlimitedLikesFilter,
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
      this.publicKeyVersion});
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
    if (!nullToAbsent || jsonCapabilities != null) {
      map['json_capabilities'] = Variable<String>(
          $AccountTable.$converterjsonCapabilities.toSql(jsonCapabilities));
    }
    if (!nullToAbsent || jsonAvailableProfileAttributes != null) {
      map['json_available_profile_attributes'] = Variable<String>($AccountTable
          .$converterjsonAvailableProfileAttributes
          .toSql(jsonAvailableProfileAttributes));
    }
    map['profile_filter_favorites'] = Variable<bool>(profileFilterFavorites);
    if (!nullToAbsent || profileIteratorSessionId != null) {
      map['profile_iterator_session_id'] = Variable<String>($AccountTable
          .$converterprofileIteratorSessionId
          .toSql(profileIteratorSessionId));
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
    if (!nullToAbsent || syncVersionReceivedLikes != null) {
      map['sync_version_received_likes'] =
          Variable<int>(syncVersionReceivedLikes);
    }
    if (!nullToAbsent || syncVersionReceivedBlocks != null) {
      map['sync_version_received_blocks'] =
          Variable<int>(syncVersionReceivedBlocks);
    }
    if (!nullToAbsent || syncVersionSentLikes != null) {
      map['sync_version_sent_likes'] = Variable<int>(syncVersionSentLikes);
    }
    if (!nullToAbsent || syncVersionSentBlocks != null) {
      map['sync_version_sent_blocks'] = Variable<int>(syncVersionSentBlocks);
    }
    if (!nullToAbsent || syncVersionMatches != null) {
      map['sync_version_matches'] = Variable<int>(syncVersionMatches);
    }
    if (!nullToAbsent || syncVersionAvailableProfileAttributes != null) {
      map['sync_version_available_profile_attributes'] =
          Variable<int>(syncVersionAvailableProfileAttributes);
    }
    if (!nullToAbsent || uuidPendingContentId0 != null) {
      map['uuid_pending_content_id0'] = Variable<String>($AccountTable
          .$converteruuidPendingContentId0
          .toSql(uuidPendingContentId0));
    }
    if (!nullToAbsent || uuidPendingContentId1 != null) {
      map['uuid_pending_content_id1'] = Variable<String>($AccountTable
          .$converteruuidPendingContentId1
          .toSql(uuidPendingContentId1));
    }
    if (!nullToAbsent || uuidPendingContentId2 != null) {
      map['uuid_pending_content_id2'] = Variable<String>($AccountTable
          .$converteruuidPendingContentId2
          .toSql(uuidPendingContentId2));
    }
    if (!nullToAbsent || uuidPendingContentId3 != null) {
      map['uuid_pending_content_id3'] = Variable<String>($AccountTable
          .$converteruuidPendingContentId3
          .toSql(uuidPendingContentId3));
    }
    if (!nullToAbsent || uuidPendingContentId4 != null) {
      map['uuid_pending_content_id4'] = Variable<String>($AccountTable
          .$converteruuidPendingContentId4
          .toSql(uuidPendingContentId4));
    }
    if (!nullToAbsent || uuidPendingContentId5 != null) {
      map['uuid_pending_content_id5'] = Variable<String>($AccountTable
          .$converteruuidPendingContentId5
          .toSql(uuidPendingContentId5));
    }
    if (!nullToAbsent || uuidPendingSecurityContentId != null) {
      map['uuid_pending_security_content_id'] = Variable<String>($AccountTable
          .$converteruuidPendingSecurityContentId
          .toSql(uuidPendingSecurityContentId));
    }
    if (!nullToAbsent || pendingPrimaryContentGridCropSize != null) {
      map['pending_primary_content_grid_crop_size'] =
          Variable<double>(pendingPrimaryContentGridCropSize);
    }
    if (!nullToAbsent || pendingPrimaryContentGridCropX != null) {
      map['pending_primary_content_grid_crop_x'] =
          Variable<double>(pendingPrimaryContentGridCropX);
    }
    if (!nullToAbsent || pendingPrimaryContentGridCropY != null) {
      map['pending_primary_content_grid_crop_y'] =
          Variable<double>(pendingPrimaryContentGridCropY);
    }
    if (!nullToAbsent || uuidContentId0 != null) {
      map['uuid_content_id0'] = Variable<String>(
          $AccountTable.$converteruuidContentId0.toSql(uuidContentId0));
    }
    if (!nullToAbsent || uuidContentId1 != null) {
      map['uuid_content_id1'] = Variable<String>(
          $AccountTable.$converteruuidContentId1.toSql(uuidContentId1));
    }
    if (!nullToAbsent || uuidContentId2 != null) {
      map['uuid_content_id2'] = Variable<String>(
          $AccountTable.$converteruuidContentId2.toSql(uuidContentId2));
    }
    if (!nullToAbsent || uuidContentId3 != null) {
      map['uuid_content_id3'] = Variable<String>(
          $AccountTable.$converteruuidContentId3.toSql(uuidContentId3));
    }
    if (!nullToAbsent || uuidContentId4 != null) {
      map['uuid_content_id4'] = Variable<String>(
          $AccountTable.$converteruuidContentId4.toSql(uuidContentId4));
    }
    if (!nullToAbsent || uuidContentId5 != null) {
      map['uuid_content_id5'] = Variable<String>(
          $AccountTable.$converteruuidContentId5.toSql(uuidContentId5));
    }
    if (!nullToAbsent || uuidSecurityContentId != null) {
      map['uuid_security_content_id'] = Variable<String>($AccountTable
          .$converteruuidSecurityContentId
          .toSql(uuidSecurityContentId));
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
    if (!nullToAbsent || profileText != null) {
      map['profile_text'] = Variable<String>(profileText);
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
    if (!nullToAbsent || jsonProfileVisibility != null) {
      map['json_profile_visibility'] = Variable<String>($AccountTable
          .$converterjsonProfileVisibility
          .toSql(jsonProfileVisibility));
    }
    if (!nullToAbsent || jsonSearchGroups != null) {
      map['json_search_groups'] = Variable<String>(
          $AccountTable.$converterjsonSearchGroups.toSql(jsonSearchGroups));
    }
    if (!nullToAbsent || jsonProfileAttributeFilters != null) {
      map['json_profile_attribute_filters'] = Variable<String>($AccountTable
          .$converterjsonProfileAttributeFilters
          .toSql(jsonProfileAttributeFilters));
    }
    if (!nullToAbsent || profileSearchAgeRangeMin != null) {
      map['profile_search_age_range_min'] =
          Variable<int>(profileSearchAgeRangeMin);
    }
    if (!nullToAbsent || profileSearchAgeRangeMax != null) {
      map['profile_search_age_range_max'] =
          Variable<int>(profileSearchAgeRangeMax);
    }
    if (!nullToAbsent || profileLastSeenTimeFilter != null) {
      map['profile_last_seen_time_filter'] = Variable<int>($AccountTable
          .$converterprofileLastSeenTimeFilter
          .toSql(profileLastSeenTimeFilter));
    }
    if (!nullToAbsent || profileUnlimitedLikesFilter != null) {
      map['profile_unlimited_likes_filter'] =
          Variable<bool>(profileUnlimitedLikesFilter);
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
      map['private_key_data'] = Variable<String>(
          $AccountTable.$converterprivateKeyData.toSql(privateKeyData));
    }
    if (!nullToAbsent || publicKeyData != null) {
      map['public_key_data'] = Variable<String>(
          $AccountTable.$converterpublicKeyData.toSql(publicKeyData));
    }
    if (!nullToAbsent || publicKeyId != null) {
      map['public_key_id'] =
          Variable<int>($AccountTable.$converterpublicKeyId.toSql(publicKeyId));
    }
    if (!nullToAbsent || publicKeyVersion != null) {
      map['public_key_version'] = Variable<int>(
          $AccountTable.$converterpublicKeyVersion.toSql(publicKeyVersion));
    }
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
      jsonCapabilities: jsonCapabilities == null && nullToAbsent
          ? const Value.absent()
          : Value(jsonCapabilities),
      jsonAvailableProfileAttributes:
          jsonAvailableProfileAttributes == null && nullToAbsent
              ? const Value.absent()
              : Value(jsonAvailableProfileAttributes),
      profileFilterFavorites: Value(profileFilterFavorites),
      profileIteratorSessionId: profileIteratorSessionId == null && nullToAbsent
          ? const Value.absent()
          : Value(profileIteratorSessionId),
      initialSyncDoneLoginRepository: Value(initialSyncDoneLoginRepository),
      initialSyncDoneAccountRepository: Value(initialSyncDoneAccountRepository),
      initialSyncDoneMediaRepository: Value(initialSyncDoneMediaRepository),
      initialSyncDoneProfileRepository: Value(initialSyncDoneProfileRepository),
      initialSyncDoneChatRepository: Value(initialSyncDoneChatRepository),
      syncVersionAccount: syncVersionAccount == null && nullToAbsent
          ? const Value.absent()
          : Value(syncVersionAccount),
      syncVersionReceivedLikes: syncVersionReceivedLikes == null && nullToAbsent
          ? const Value.absent()
          : Value(syncVersionReceivedLikes),
      syncVersionReceivedBlocks:
          syncVersionReceivedBlocks == null && nullToAbsent
              ? const Value.absent()
              : Value(syncVersionReceivedBlocks),
      syncVersionSentLikes: syncVersionSentLikes == null && nullToAbsent
          ? const Value.absent()
          : Value(syncVersionSentLikes),
      syncVersionSentBlocks: syncVersionSentBlocks == null && nullToAbsent
          ? const Value.absent()
          : Value(syncVersionSentBlocks),
      syncVersionMatches: syncVersionMatches == null && nullToAbsent
          ? const Value.absent()
          : Value(syncVersionMatches),
      syncVersionAvailableProfileAttributes:
          syncVersionAvailableProfileAttributes == null && nullToAbsent
              ? const Value.absent()
              : Value(syncVersionAvailableProfileAttributes),
      uuidPendingContentId0: uuidPendingContentId0 == null && nullToAbsent
          ? const Value.absent()
          : Value(uuidPendingContentId0),
      uuidPendingContentId1: uuidPendingContentId1 == null && nullToAbsent
          ? const Value.absent()
          : Value(uuidPendingContentId1),
      uuidPendingContentId2: uuidPendingContentId2 == null && nullToAbsent
          ? const Value.absent()
          : Value(uuidPendingContentId2),
      uuidPendingContentId3: uuidPendingContentId3 == null && nullToAbsent
          ? const Value.absent()
          : Value(uuidPendingContentId3),
      uuidPendingContentId4: uuidPendingContentId4 == null && nullToAbsent
          ? const Value.absent()
          : Value(uuidPendingContentId4),
      uuidPendingContentId5: uuidPendingContentId5 == null && nullToAbsent
          ? const Value.absent()
          : Value(uuidPendingContentId5),
      uuidPendingSecurityContentId:
          uuidPendingSecurityContentId == null && nullToAbsent
              ? const Value.absent()
              : Value(uuidPendingSecurityContentId),
      pendingPrimaryContentGridCropSize:
          pendingPrimaryContentGridCropSize == null && nullToAbsent
              ? const Value.absent()
              : Value(pendingPrimaryContentGridCropSize),
      pendingPrimaryContentGridCropX:
          pendingPrimaryContentGridCropX == null && nullToAbsent
              ? const Value.absent()
              : Value(pendingPrimaryContentGridCropX),
      pendingPrimaryContentGridCropY:
          pendingPrimaryContentGridCropY == null && nullToAbsent
              ? const Value.absent()
              : Value(pendingPrimaryContentGridCropY),
      uuidContentId0: uuidContentId0 == null && nullToAbsent
          ? const Value.absent()
          : Value(uuidContentId0),
      uuidContentId1: uuidContentId1 == null && nullToAbsent
          ? const Value.absent()
          : Value(uuidContentId1),
      uuidContentId2: uuidContentId2 == null && nullToAbsent
          ? const Value.absent()
          : Value(uuidContentId2),
      uuidContentId3: uuidContentId3 == null && nullToAbsent
          ? const Value.absent()
          : Value(uuidContentId3),
      uuidContentId4: uuidContentId4 == null && nullToAbsent
          ? const Value.absent()
          : Value(uuidContentId4),
      uuidContentId5: uuidContentId5 == null && nullToAbsent
          ? const Value.absent()
          : Value(uuidContentId5),
      uuidSecurityContentId: uuidSecurityContentId == null && nullToAbsent
          ? const Value.absent()
          : Value(uuidSecurityContentId),
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
      profileText: profileText == null && nullToAbsent
          ? const Value.absent()
          : Value(profileText),
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
      jsonProfileVisibility: jsonProfileVisibility == null && nullToAbsent
          ? const Value.absent()
          : Value(jsonProfileVisibility),
      jsonSearchGroups: jsonSearchGroups == null && nullToAbsent
          ? const Value.absent()
          : Value(jsonSearchGroups),
      jsonProfileAttributeFilters:
          jsonProfileAttributeFilters == null && nullToAbsent
              ? const Value.absent()
              : Value(jsonProfileAttributeFilters),
      profileSearchAgeRangeMin: profileSearchAgeRangeMin == null && nullToAbsent
          ? const Value.absent()
          : Value(profileSearchAgeRangeMin),
      profileSearchAgeRangeMax: profileSearchAgeRangeMax == null && nullToAbsent
          ? const Value.absent()
          : Value(profileSearchAgeRangeMax),
      profileLastSeenTimeFilter:
          profileLastSeenTimeFilter == null && nullToAbsent
              ? const Value.absent()
              : Value(profileLastSeenTimeFilter),
      profileUnlimitedLikesFilter:
          profileUnlimitedLikesFilter == null && nullToAbsent
              ? const Value.absent()
              : Value(profileUnlimitedLikesFilter),
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
      publicKeyVersion: publicKeyVersion == null && nullToAbsent
          ? const Value.absent()
          : Value(publicKeyVersion),
    );
  }

  factory AccountData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AccountData(
      id: serializer.fromJson<int>(json['id']),
      uuidAccountId: serializer.fromJson<AccountId?>(json['uuidAccountId']),
      jsonAccountState:
          serializer.fromJson<EnumString?>(json['jsonAccountState']),
      jsonCapabilities:
          serializer.fromJson<JsonString?>(json['jsonCapabilities']),
      jsonAvailableProfileAttributes: serializer
          .fromJson<JsonString?>(json['jsonAvailableProfileAttributes']),
      profileFilterFavorites:
          serializer.fromJson<bool>(json['profileFilterFavorites']),
      profileIteratorSessionId: serializer
          .fromJson<IteratorSessionId?>(json['profileIteratorSessionId']),
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
      syncVersionReceivedLikes:
          serializer.fromJson<int?>(json['syncVersionReceivedLikes']),
      syncVersionReceivedBlocks:
          serializer.fromJson<int?>(json['syncVersionReceivedBlocks']),
      syncVersionSentLikes:
          serializer.fromJson<int?>(json['syncVersionSentLikes']),
      syncVersionSentBlocks:
          serializer.fromJson<int?>(json['syncVersionSentBlocks']),
      syncVersionMatches: serializer.fromJson<int?>(json['syncVersionMatches']),
      syncVersionAvailableProfileAttributes: serializer
          .fromJson<int?>(json['syncVersionAvailableProfileAttributes']),
      uuidPendingContentId0:
          serializer.fromJson<ContentId?>(json['uuidPendingContentId0']),
      uuidPendingContentId1:
          serializer.fromJson<ContentId?>(json['uuidPendingContentId1']),
      uuidPendingContentId2:
          serializer.fromJson<ContentId?>(json['uuidPendingContentId2']),
      uuidPendingContentId3:
          serializer.fromJson<ContentId?>(json['uuidPendingContentId3']),
      uuidPendingContentId4:
          serializer.fromJson<ContentId?>(json['uuidPendingContentId4']),
      uuidPendingContentId5:
          serializer.fromJson<ContentId?>(json['uuidPendingContentId5']),
      uuidPendingSecurityContentId:
          serializer.fromJson<ContentId?>(json['uuidPendingSecurityContentId']),
      pendingPrimaryContentGridCropSize: serializer
          .fromJson<double?>(json['pendingPrimaryContentGridCropSize']),
      pendingPrimaryContentGridCropX:
          serializer.fromJson<double?>(json['pendingPrimaryContentGridCropX']),
      pendingPrimaryContentGridCropY:
          serializer.fromJson<double?>(json['pendingPrimaryContentGridCropY']),
      uuidContentId0: serializer.fromJson<ContentId?>(json['uuidContentId0']),
      uuidContentId1: serializer.fromJson<ContentId?>(json['uuidContentId1']),
      uuidContentId2: serializer.fromJson<ContentId?>(json['uuidContentId2']),
      uuidContentId3: serializer.fromJson<ContentId?>(json['uuidContentId3']),
      uuidContentId4: serializer.fromJson<ContentId?>(json['uuidContentId4']),
      uuidContentId5: serializer.fromJson<ContentId?>(json['uuidContentId5']),
      uuidSecurityContentId:
          serializer.fromJson<ContentId?>(json['uuidSecurityContentId']),
      primaryContentGridCropSize:
          serializer.fromJson<double?>(json['primaryContentGridCropSize']),
      primaryContentGridCropX:
          serializer.fromJson<double?>(json['primaryContentGridCropX']),
      primaryContentGridCropY:
          serializer.fromJson<double?>(json['primaryContentGridCropY']),
      profileContentVersion: serializer
          .fromJson<ProfileContentVersion?>(json['profileContentVersion']),
      profileName: serializer.fromJson<String?>(json['profileName']),
      profileText: serializer.fromJson<String?>(json['profileText']),
      profileAge: serializer.fromJson<int?>(json['profileAge']),
      profileUnlimitedLikes:
          serializer.fromJson<bool?>(json['profileUnlimitedLikes']),
      profileVersion:
          serializer.fromJson<ProfileVersion?>(json['profileVersion']),
      jsonProfileAttributes:
          serializer.fromJson<JsonList?>(json['jsonProfileAttributes']),
      profileLocationLatitude:
          serializer.fromJson<double?>(json['profileLocationLatitude']),
      profileLocationLongitude:
          serializer.fromJson<double?>(json['profileLocationLongitude']),
      jsonProfileVisibility:
          serializer.fromJson<EnumString?>(json['jsonProfileVisibility']),
      jsonSearchGroups:
          serializer.fromJson<JsonString?>(json['jsonSearchGroups']),
      jsonProfileAttributeFilters:
          serializer.fromJson<JsonString?>(json['jsonProfileAttributeFilters']),
      profileSearchAgeRangeMin:
          serializer.fromJson<int?>(json['profileSearchAgeRangeMin']),
      profileSearchAgeRangeMax:
          serializer.fromJson<int?>(json['profileSearchAgeRangeMax']),
      profileLastSeenTimeFilter: serializer
          .fromJson<LastSeenTimeFilter?>(json['profileLastSeenTimeFilter']),
      profileUnlimitedLikesFilter:
          serializer.fromJson<bool?>(json['profileUnlimitedLikesFilter']),
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
      publicKeyId: serializer.fromJson<PublicKeyId?>(json['publicKeyId']),
      publicKeyVersion:
          serializer.fromJson<PublicKeyVersion?>(json['publicKeyVersion']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uuidAccountId': serializer.toJson<AccountId?>(uuidAccountId),
      'jsonAccountState': serializer.toJson<EnumString?>(jsonAccountState),
      'jsonCapabilities': serializer.toJson<JsonString?>(jsonCapabilities),
      'jsonAvailableProfileAttributes':
          serializer.toJson<JsonString?>(jsonAvailableProfileAttributes),
      'profileFilterFavorites': serializer.toJson<bool>(profileFilterFavorites),
      'profileIteratorSessionId':
          serializer.toJson<IteratorSessionId?>(profileIteratorSessionId),
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
      'syncVersionReceivedLikes':
          serializer.toJson<int?>(syncVersionReceivedLikes),
      'syncVersionReceivedBlocks':
          serializer.toJson<int?>(syncVersionReceivedBlocks),
      'syncVersionSentLikes': serializer.toJson<int?>(syncVersionSentLikes),
      'syncVersionSentBlocks': serializer.toJson<int?>(syncVersionSentBlocks),
      'syncVersionMatches': serializer.toJson<int?>(syncVersionMatches),
      'syncVersionAvailableProfileAttributes':
          serializer.toJson<int?>(syncVersionAvailableProfileAttributes),
      'uuidPendingContentId0':
          serializer.toJson<ContentId?>(uuidPendingContentId0),
      'uuidPendingContentId1':
          serializer.toJson<ContentId?>(uuidPendingContentId1),
      'uuidPendingContentId2':
          serializer.toJson<ContentId?>(uuidPendingContentId2),
      'uuidPendingContentId3':
          serializer.toJson<ContentId?>(uuidPendingContentId3),
      'uuidPendingContentId4':
          serializer.toJson<ContentId?>(uuidPendingContentId4),
      'uuidPendingContentId5':
          serializer.toJson<ContentId?>(uuidPendingContentId5),
      'uuidPendingSecurityContentId':
          serializer.toJson<ContentId?>(uuidPendingSecurityContentId),
      'pendingPrimaryContentGridCropSize':
          serializer.toJson<double?>(pendingPrimaryContentGridCropSize),
      'pendingPrimaryContentGridCropX':
          serializer.toJson<double?>(pendingPrimaryContentGridCropX),
      'pendingPrimaryContentGridCropY':
          serializer.toJson<double?>(pendingPrimaryContentGridCropY),
      'uuidContentId0': serializer.toJson<ContentId?>(uuidContentId0),
      'uuidContentId1': serializer.toJson<ContentId?>(uuidContentId1),
      'uuidContentId2': serializer.toJson<ContentId?>(uuidContentId2),
      'uuidContentId3': serializer.toJson<ContentId?>(uuidContentId3),
      'uuidContentId4': serializer.toJson<ContentId?>(uuidContentId4),
      'uuidContentId5': serializer.toJson<ContentId?>(uuidContentId5),
      'uuidSecurityContentId':
          serializer.toJson<ContentId?>(uuidSecurityContentId),
      'primaryContentGridCropSize':
          serializer.toJson<double?>(primaryContentGridCropSize),
      'primaryContentGridCropX':
          serializer.toJson<double?>(primaryContentGridCropX),
      'primaryContentGridCropY':
          serializer.toJson<double?>(primaryContentGridCropY),
      'profileContentVersion':
          serializer.toJson<ProfileContentVersion?>(profileContentVersion),
      'profileName': serializer.toJson<String?>(profileName),
      'profileText': serializer.toJson<String?>(profileText),
      'profileAge': serializer.toJson<int?>(profileAge),
      'profileUnlimitedLikes': serializer.toJson<bool?>(profileUnlimitedLikes),
      'profileVersion': serializer.toJson<ProfileVersion?>(profileVersion),
      'jsonProfileAttributes':
          serializer.toJson<JsonList?>(jsonProfileAttributes),
      'profileLocationLatitude':
          serializer.toJson<double?>(profileLocationLatitude),
      'profileLocationLongitude':
          serializer.toJson<double?>(profileLocationLongitude),
      'jsonProfileVisibility':
          serializer.toJson<EnumString?>(jsonProfileVisibility),
      'jsonSearchGroups': serializer.toJson<JsonString?>(jsonSearchGroups),
      'jsonProfileAttributeFilters':
          serializer.toJson<JsonString?>(jsonProfileAttributeFilters),
      'profileSearchAgeRangeMin':
          serializer.toJson<int?>(profileSearchAgeRangeMin),
      'profileSearchAgeRangeMax':
          serializer.toJson<int?>(profileSearchAgeRangeMax),
      'profileLastSeenTimeFilter':
          serializer.toJson<LastSeenTimeFilter?>(profileLastSeenTimeFilter),
      'profileUnlimitedLikesFilter':
          serializer.toJson<bool?>(profileUnlimitedLikesFilter),
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
      'publicKeyId': serializer.toJson<PublicKeyId?>(publicKeyId),
      'publicKeyVersion':
          serializer.toJson<PublicKeyVersion?>(publicKeyVersion),
    };
  }

  AccountData copyWith(
          {int? id,
          Value<AccountId?> uuidAccountId = const Value.absent(),
          Value<EnumString?> jsonAccountState = const Value.absent(),
          Value<JsonString?> jsonCapabilities = const Value.absent(),
          Value<JsonString?> jsonAvailableProfileAttributes =
              const Value.absent(),
          bool? profileFilterFavorites,
          Value<IteratorSessionId?> profileIteratorSessionId =
              const Value.absent(),
          bool? initialSyncDoneLoginRepository,
          bool? initialSyncDoneAccountRepository,
          bool? initialSyncDoneMediaRepository,
          bool? initialSyncDoneProfileRepository,
          bool? initialSyncDoneChatRepository,
          Value<int?> syncVersionAccount = const Value.absent(),
          Value<int?> syncVersionReceivedLikes = const Value.absent(),
          Value<int?> syncVersionReceivedBlocks = const Value.absent(),
          Value<int?> syncVersionSentLikes = const Value.absent(),
          Value<int?> syncVersionSentBlocks = const Value.absent(),
          Value<int?> syncVersionMatches = const Value.absent(),
          Value<int?> syncVersionAvailableProfileAttributes =
              const Value.absent(),
          Value<ContentId?> uuidPendingContentId0 = const Value.absent(),
          Value<ContentId?> uuidPendingContentId1 = const Value.absent(),
          Value<ContentId?> uuidPendingContentId2 = const Value.absent(),
          Value<ContentId?> uuidPendingContentId3 = const Value.absent(),
          Value<ContentId?> uuidPendingContentId4 = const Value.absent(),
          Value<ContentId?> uuidPendingContentId5 = const Value.absent(),
          Value<ContentId?> uuidPendingSecurityContentId = const Value.absent(),
          Value<double?> pendingPrimaryContentGridCropSize =
              const Value.absent(),
          Value<double?> pendingPrimaryContentGridCropX = const Value.absent(),
          Value<double?> pendingPrimaryContentGridCropY = const Value.absent(),
          Value<ContentId?> uuidContentId0 = const Value.absent(),
          Value<ContentId?> uuidContentId1 = const Value.absent(),
          Value<ContentId?> uuidContentId2 = const Value.absent(),
          Value<ContentId?> uuidContentId3 = const Value.absent(),
          Value<ContentId?> uuidContentId4 = const Value.absent(),
          Value<ContentId?> uuidContentId5 = const Value.absent(),
          Value<ContentId?> uuidSecurityContentId = const Value.absent(),
          Value<double?> primaryContentGridCropSize = const Value.absent(),
          Value<double?> primaryContentGridCropX = const Value.absent(),
          Value<double?> primaryContentGridCropY = const Value.absent(),
          Value<ProfileContentVersion?> profileContentVersion =
              const Value.absent(),
          Value<String?> profileName = const Value.absent(),
          Value<String?> profileText = const Value.absent(),
          Value<int?> profileAge = const Value.absent(),
          Value<bool?> profileUnlimitedLikes = const Value.absent(),
          Value<ProfileVersion?> profileVersion = const Value.absent(),
          Value<JsonList?> jsonProfileAttributes = const Value.absent(),
          Value<double?> profileLocationLatitude = const Value.absent(),
          Value<double?> profileLocationLongitude = const Value.absent(),
          Value<EnumString?> jsonProfileVisibility = const Value.absent(),
          Value<JsonString?> jsonSearchGroups = const Value.absent(),
          Value<JsonString?> jsonProfileAttributeFilters = const Value.absent(),
          Value<int?> profileSearchAgeRangeMin = const Value.absent(),
          Value<int?> profileSearchAgeRangeMax = const Value.absent(),
          Value<LastSeenTimeFilter?> profileLastSeenTimeFilter =
              const Value.absent(),
          Value<bool?> profileUnlimitedLikesFilter = const Value.absent(),
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
          Value<PublicKeyId?> publicKeyId = const Value.absent(),
          Value<PublicKeyVersion?> publicKeyVersion = const Value.absent()}) =>
      AccountData(
        id: id ?? this.id,
        uuidAccountId:
            uuidAccountId.present ? uuidAccountId.value : this.uuidAccountId,
        jsonAccountState: jsonAccountState.present
            ? jsonAccountState.value
            : this.jsonAccountState,
        jsonCapabilities: jsonCapabilities.present
            ? jsonCapabilities.value
            : this.jsonCapabilities,
        jsonAvailableProfileAttributes: jsonAvailableProfileAttributes.present
            ? jsonAvailableProfileAttributes.value
            : this.jsonAvailableProfileAttributes,
        profileFilterFavorites:
            profileFilterFavorites ?? this.profileFilterFavorites,
        profileIteratorSessionId: profileIteratorSessionId.present
            ? profileIteratorSessionId.value
            : this.profileIteratorSessionId,
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
        syncVersionReceivedLikes: syncVersionReceivedLikes.present
            ? syncVersionReceivedLikes.value
            : this.syncVersionReceivedLikes,
        syncVersionReceivedBlocks: syncVersionReceivedBlocks.present
            ? syncVersionReceivedBlocks.value
            : this.syncVersionReceivedBlocks,
        syncVersionSentLikes: syncVersionSentLikes.present
            ? syncVersionSentLikes.value
            : this.syncVersionSentLikes,
        syncVersionSentBlocks: syncVersionSentBlocks.present
            ? syncVersionSentBlocks.value
            : this.syncVersionSentBlocks,
        syncVersionMatches: syncVersionMatches.present
            ? syncVersionMatches.value
            : this.syncVersionMatches,
        syncVersionAvailableProfileAttributes:
            syncVersionAvailableProfileAttributes.present
                ? syncVersionAvailableProfileAttributes.value
                : this.syncVersionAvailableProfileAttributes,
        uuidPendingContentId0: uuidPendingContentId0.present
            ? uuidPendingContentId0.value
            : this.uuidPendingContentId0,
        uuidPendingContentId1: uuidPendingContentId1.present
            ? uuidPendingContentId1.value
            : this.uuidPendingContentId1,
        uuidPendingContentId2: uuidPendingContentId2.present
            ? uuidPendingContentId2.value
            : this.uuidPendingContentId2,
        uuidPendingContentId3: uuidPendingContentId3.present
            ? uuidPendingContentId3.value
            : this.uuidPendingContentId3,
        uuidPendingContentId4: uuidPendingContentId4.present
            ? uuidPendingContentId4.value
            : this.uuidPendingContentId4,
        uuidPendingContentId5: uuidPendingContentId5.present
            ? uuidPendingContentId5.value
            : this.uuidPendingContentId5,
        uuidPendingSecurityContentId: uuidPendingSecurityContentId.present
            ? uuidPendingSecurityContentId.value
            : this.uuidPendingSecurityContentId,
        pendingPrimaryContentGridCropSize:
            pendingPrimaryContentGridCropSize.present
                ? pendingPrimaryContentGridCropSize.value
                : this.pendingPrimaryContentGridCropSize,
        pendingPrimaryContentGridCropX: pendingPrimaryContentGridCropX.present
            ? pendingPrimaryContentGridCropX.value
            : this.pendingPrimaryContentGridCropX,
        pendingPrimaryContentGridCropY: pendingPrimaryContentGridCropY.present
            ? pendingPrimaryContentGridCropY.value
            : this.pendingPrimaryContentGridCropY,
        uuidContentId0:
            uuidContentId0.present ? uuidContentId0.value : this.uuidContentId0,
        uuidContentId1:
            uuidContentId1.present ? uuidContentId1.value : this.uuidContentId1,
        uuidContentId2:
            uuidContentId2.present ? uuidContentId2.value : this.uuidContentId2,
        uuidContentId3:
            uuidContentId3.present ? uuidContentId3.value : this.uuidContentId3,
        uuidContentId4:
            uuidContentId4.present ? uuidContentId4.value : this.uuidContentId4,
        uuidContentId5:
            uuidContentId5.present ? uuidContentId5.value : this.uuidContentId5,
        uuidSecurityContentId: uuidSecurityContentId.present
            ? uuidSecurityContentId.value
            : this.uuidSecurityContentId,
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
        profileText: profileText.present ? profileText.value : this.profileText,
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
        jsonProfileVisibility: jsonProfileVisibility.present
            ? jsonProfileVisibility.value
            : this.jsonProfileVisibility,
        jsonSearchGroups: jsonSearchGroups.present
            ? jsonSearchGroups.value
            : this.jsonSearchGroups,
        jsonProfileAttributeFilters: jsonProfileAttributeFilters.present
            ? jsonProfileAttributeFilters.value
            : this.jsonProfileAttributeFilters,
        profileSearchAgeRangeMin: profileSearchAgeRangeMin.present
            ? profileSearchAgeRangeMin.value
            : this.profileSearchAgeRangeMin,
        profileSearchAgeRangeMax: profileSearchAgeRangeMax.present
            ? profileSearchAgeRangeMax.value
            : this.profileSearchAgeRangeMax,
        profileLastSeenTimeFilter: profileLastSeenTimeFilter.present
            ? profileLastSeenTimeFilter.value
            : this.profileLastSeenTimeFilter,
        profileUnlimitedLikesFilter: profileUnlimitedLikesFilter.present
            ? profileUnlimitedLikesFilter.value
            : this.profileUnlimitedLikesFilter,
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
        publicKeyVersion: publicKeyVersion.present
            ? publicKeyVersion.value
            : this.publicKeyVersion,
      );
  @override
  String toString() {
    return (StringBuffer('AccountData(')
          ..write('id: $id, ')
          ..write('uuidAccountId: $uuidAccountId, ')
          ..write('jsonAccountState: $jsonAccountState, ')
          ..write('jsonCapabilities: $jsonCapabilities, ')
          ..write(
              'jsonAvailableProfileAttributes: $jsonAvailableProfileAttributes, ')
          ..write('profileFilterFavorites: $profileFilterFavorites, ')
          ..write('profileIteratorSessionId: $profileIteratorSessionId, ')
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
          ..write('syncVersionReceivedLikes: $syncVersionReceivedLikes, ')
          ..write('syncVersionReceivedBlocks: $syncVersionReceivedBlocks, ')
          ..write('syncVersionSentLikes: $syncVersionSentLikes, ')
          ..write('syncVersionSentBlocks: $syncVersionSentBlocks, ')
          ..write('syncVersionMatches: $syncVersionMatches, ')
          ..write(
              'syncVersionAvailableProfileAttributes: $syncVersionAvailableProfileAttributes, ')
          ..write('uuidPendingContentId0: $uuidPendingContentId0, ')
          ..write('uuidPendingContentId1: $uuidPendingContentId1, ')
          ..write('uuidPendingContentId2: $uuidPendingContentId2, ')
          ..write('uuidPendingContentId3: $uuidPendingContentId3, ')
          ..write('uuidPendingContentId4: $uuidPendingContentId4, ')
          ..write('uuidPendingContentId5: $uuidPendingContentId5, ')
          ..write(
              'uuidPendingSecurityContentId: $uuidPendingSecurityContentId, ')
          ..write(
              'pendingPrimaryContentGridCropSize: $pendingPrimaryContentGridCropSize, ')
          ..write(
              'pendingPrimaryContentGridCropX: $pendingPrimaryContentGridCropX, ')
          ..write(
              'pendingPrimaryContentGridCropY: $pendingPrimaryContentGridCropY, ')
          ..write('uuidContentId0: $uuidContentId0, ')
          ..write('uuidContentId1: $uuidContentId1, ')
          ..write('uuidContentId2: $uuidContentId2, ')
          ..write('uuidContentId3: $uuidContentId3, ')
          ..write('uuidContentId4: $uuidContentId4, ')
          ..write('uuidContentId5: $uuidContentId5, ')
          ..write('uuidSecurityContentId: $uuidSecurityContentId, ')
          ..write('primaryContentGridCropSize: $primaryContentGridCropSize, ')
          ..write('primaryContentGridCropX: $primaryContentGridCropX, ')
          ..write('primaryContentGridCropY: $primaryContentGridCropY, ')
          ..write('profileContentVersion: $profileContentVersion, ')
          ..write('profileName: $profileName, ')
          ..write('profileText: $profileText, ')
          ..write('profileAge: $profileAge, ')
          ..write('profileUnlimitedLikes: $profileUnlimitedLikes, ')
          ..write('profileVersion: $profileVersion, ')
          ..write('jsonProfileAttributes: $jsonProfileAttributes, ')
          ..write('profileLocationLatitude: $profileLocationLatitude, ')
          ..write('profileLocationLongitude: $profileLocationLongitude, ')
          ..write('jsonProfileVisibility: $jsonProfileVisibility, ')
          ..write('jsonSearchGroups: $jsonSearchGroups, ')
          ..write('jsonProfileAttributeFilters: $jsonProfileAttributeFilters, ')
          ..write('profileSearchAgeRangeMin: $profileSearchAgeRangeMin, ')
          ..write('profileSearchAgeRangeMax: $profileSearchAgeRangeMax, ')
          ..write('profileLastSeenTimeFilter: $profileLastSeenTimeFilter, ')
          ..write('profileUnlimitedLikesFilter: $profileUnlimitedLikesFilter, ')
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
          ..write('publicKeyVersion: $publicKeyVersion')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        id,
        uuidAccountId,
        jsonAccountState,
        jsonCapabilities,
        jsonAvailableProfileAttributes,
        profileFilterFavorites,
        profileIteratorSessionId,
        initialSyncDoneLoginRepository,
        initialSyncDoneAccountRepository,
        initialSyncDoneMediaRepository,
        initialSyncDoneProfileRepository,
        initialSyncDoneChatRepository,
        syncVersionAccount,
        syncVersionReceivedLikes,
        syncVersionReceivedBlocks,
        syncVersionSentLikes,
        syncVersionSentBlocks,
        syncVersionMatches,
        syncVersionAvailableProfileAttributes,
        uuidPendingContentId0,
        uuidPendingContentId1,
        uuidPendingContentId2,
        uuidPendingContentId3,
        uuidPendingContentId4,
        uuidPendingContentId5,
        uuidPendingSecurityContentId,
        pendingPrimaryContentGridCropSize,
        pendingPrimaryContentGridCropX,
        pendingPrimaryContentGridCropY,
        uuidContentId0,
        uuidContentId1,
        uuidContentId2,
        uuidContentId3,
        uuidContentId4,
        uuidContentId5,
        uuidSecurityContentId,
        primaryContentGridCropSize,
        primaryContentGridCropX,
        primaryContentGridCropY,
        profileContentVersion,
        profileName,
        profileText,
        profileAge,
        profileUnlimitedLikes,
        profileVersion,
        jsonProfileAttributes,
        profileLocationLatitude,
        profileLocationLongitude,
        jsonProfileVisibility,
        jsonSearchGroups,
        jsonProfileAttributeFilters,
        profileSearchAgeRangeMin,
        profileSearchAgeRangeMax,
        profileLastSeenTimeFilter,
        profileUnlimitedLikesFilter,
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
        publicKeyVersion
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AccountData &&
          other.id == this.id &&
          other.uuidAccountId == this.uuidAccountId &&
          other.jsonAccountState == this.jsonAccountState &&
          other.jsonCapabilities == this.jsonCapabilities &&
          other.jsonAvailableProfileAttributes ==
              this.jsonAvailableProfileAttributes &&
          other.profileFilterFavorites == this.profileFilterFavorites &&
          other.profileIteratorSessionId == this.profileIteratorSessionId &&
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
          other.syncVersionReceivedLikes == this.syncVersionReceivedLikes &&
          other.syncVersionReceivedBlocks == this.syncVersionReceivedBlocks &&
          other.syncVersionSentLikes == this.syncVersionSentLikes &&
          other.syncVersionSentBlocks == this.syncVersionSentBlocks &&
          other.syncVersionMatches == this.syncVersionMatches &&
          other.syncVersionAvailableProfileAttributes ==
              this.syncVersionAvailableProfileAttributes &&
          other.uuidPendingContentId0 == this.uuidPendingContentId0 &&
          other.uuidPendingContentId1 == this.uuidPendingContentId1 &&
          other.uuidPendingContentId2 == this.uuidPendingContentId2 &&
          other.uuidPendingContentId3 == this.uuidPendingContentId3 &&
          other.uuidPendingContentId4 == this.uuidPendingContentId4 &&
          other.uuidPendingContentId5 == this.uuidPendingContentId5 &&
          other.uuidPendingSecurityContentId ==
              this.uuidPendingSecurityContentId &&
          other.pendingPrimaryContentGridCropSize ==
              this.pendingPrimaryContentGridCropSize &&
          other.pendingPrimaryContentGridCropX ==
              this.pendingPrimaryContentGridCropX &&
          other.pendingPrimaryContentGridCropY ==
              this.pendingPrimaryContentGridCropY &&
          other.uuidContentId0 == this.uuidContentId0 &&
          other.uuidContentId1 == this.uuidContentId1 &&
          other.uuidContentId2 == this.uuidContentId2 &&
          other.uuidContentId3 == this.uuidContentId3 &&
          other.uuidContentId4 == this.uuidContentId4 &&
          other.uuidContentId5 == this.uuidContentId5 &&
          other.uuidSecurityContentId == this.uuidSecurityContentId &&
          other.primaryContentGridCropSize == this.primaryContentGridCropSize &&
          other.primaryContentGridCropX == this.primaryContentGridCropX &&
          other.primaryContentGridCropY == this.primaryContentGridCropY &&
          other.profileContentVersion == this.profileContentVersion &&
          other.profileName == this.profileName &&
          other.profileText == this.profileText &&
          other.profileAge == this.profileAge &&
          other.profileUnlimitedLikes == this.profileUnlimitedLikes &&
          other.profileVersion == this.profileVersion &&
          other.jsonProfileAttributes == this.jsonProfileAttributes &&
          other.profileLocationLatitude == this.profileLocationLatitude &&
          other.profileLocationLongitude == this.profileLocationLongitude &&
          other.jsonProfileVisibility == this.jsonProfileVisibility &&
          other.jsonSearchGroups == this.jsonSearchGroups &&
          other.jsonProfileAttributeFilters ==
              this.jsonProfileAttributeFilters &&
          other.profileSearchAgeRangeMin == this.profileSearchAgeRangeMin &&
          other.profileSearchAgeRangeMax == this.profileSearchAgeRangeMax &&
          other.profileLastSeenTimeFilter == this.profileLastSeenTimeFilter &&
          other.profileUnlimitedLikesFilter ==
              this.profileUnlimitedLikesFilter &&
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
          other.publicKeyVersion == this.publicKeyVersion);
}

class AccountCompanion extends UpdateCompanion<AccountData> {
  final Value<int> id;
  final Value<AccountId?> uuidAccountId;
  final Value<EnumString?> jsonAccountState;
  final Value<JsonString?> jsonCapabilities;
  final Value<JsonString?> jsonAvailableProfileAttributes;
  final Value<bool> profileFilterFavorites;
  final Value<IteratorSessionId?> profileIteratorSessionId;
  final Value<bool> initialSyncDoneLoginRepository;
  final Value<bool> initialSyncDoneAccountRepository;
  final Value<bool> initialSyncDoneMediaRepository;
  final Value<bool> initialSyncDoneProfileRepository;
  final Value<bool> initialSyncDoneChatRepository;
  final Value<int?> syncVersionAccount;
  final Value<int?> syncVersionReceivedLikes;
  final Value<int?> syncVersionReceivedBlocks;
  final Value<int?> syncVersionSentLikes;
  final Value<int?> syncVersionSentBlocks;
  final Value<int?> syncVersionMatches;
  final Value<int?> syncVersionAvailableProfileAttributes;
  final Value<ContentId?> uuidPendingContentId0;
  final Value<ContentId?> uuidPendingContentId1;
  final Value<ContentId?> uuidPendingContentId2;
  final Value<ContentId?> uuidPendingContentId3;
  final Value<ContentId?> uuidPendingContentId4;
  final Value<ContentId?> uuidPendingContentId5;
  final Value<ContentId?> uuidPendingSecurityContentId;
  final Value<double?> pendingPrimaryContentGridCropSize;
  final Value<double?> pendingPrimaryContentGridCropX;
  final Value<double?> pendingPrimaryContentGridCropY;
  final Value<ContentId?> uuidContentId0;
  final Value<ContentId?> uuidContentId1;
  final Value<ContentId?> uuidContentId2;
  final Value<ContentId?> uuidContentId3;
  final Value<ContentId?> uuidContentId4;
  final Value<ContentId?> uuidContentId5;
  final Value<ContentId?> uuidSecurityContentId;
  final Value<double?> primaryContentGridCropSize;
  final Value<double?> primaryContentGridCropX;
  final Value<double?> primaryContentGridCropY;
  final Value<ProfileContentVersion?> profileContentVersion;
  final Value<String?> profileName;
  final Value<String?> profileText;
  final Value<int?> profileAge;
  final Value<bool?> profileUnlimitedLikes;
  final Value<ProfileVersion?> profileVersion;
  final Value<JsonList?> jsonProfileAttributes;
  final Value<double?> profileLocationLatitude;
  final Value<double?> profileLocationLongitude;
  final Value<EnumString?> jsonProfileVisibility;
  final Value<JsonString?> jsonSearchGroups;
  final Value<JsonString?> jsonProfileAttributeFilters;
  final Value<int?> profileSearchAgeRangeMin;
  final Value<int?> profileSearchAgeRangeMax;
  final Value<LastSeenTimeFilter?> profileLastSeenTimeFilter;
  final Value<bool?> profileUnlimitedLikesFilter;
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
  final Value<PublicKeyId?> publicKeyId;
  final Value<PublicKeyVersion?> publicKeyVersion;
  const AccountCompanion({
    this.id = const Value.absent(),
    this.uuidAccountId = const Value.absent(),
    this.jsonAccountState = const Value.absent(),
    this.jsonCapabilities = const Value.absent(),
    this.jsonAvailableProfileAttributes = const Value.absent(),
    this.profileFilterFavorites = const Value.absent(),
    this.profileIteratorSessionId = const Value.absent(),
    this.initialSyncDoneLoginRepository = const Value.absent(),
    this.initialSyncDoneAccountRepository = const Value.absent(),
    this.initialSyncDoneMediaRepository = const Value.absent(),
    this.initialSyncDoneProfileRepository = const Value.absent(),
    this.initialSyncDoneChatRepository = const Value.absent(),
    this.syncVersionAccount = const Value.absent(),
    this.syncVersionReceivedLikes = const Value.absent(),
    this.syncVersionReceivedBlocks = const Value.absent(),
    this.syncVersionSentLikes = const Value.absent(),
    this.syncVersionSentBlocks = const Value.absent(),
    this.syncVersionMatches = const Value.absent(),
    this.syncVersionAvailableProfileAttributes = const Value.absent(),
    this.uuidPendingContentId0 = const Value.absent(),
    this.uuidPendingContentId1 = const Value.absent(),
    this.uuidPendingContentId2 = const Value.absent(),
    this.uuidPendingContentId3 = const Value.absent(),
    this.uuidPendingContentId4 = const Value.absent(),
    this.uuidPendingContentId5 = const Value.absent(),
    this.uuidPendingSecurityContentId = const Value.absent(),
    this.pendingPrimaryContentGridCropSize = const Value.absent(),
    this.pendingPrimaryContentGridCropX = const Value.absent(),
    this.pendingPrimaryContentGridCropY = const Value.absent(),
    this.uuidContentId0 = const Value.absent(),
    this.uuidContentId1 = const Value.absent(),
    this.uuidContentId2 = const Value.absent(),
    this.uuidContentId3 = const Value.absent(),
    this.uuidContentId4 = const Value.absent(),
    this.uuidContentId5 = const Value.absent(),
    this.uuidSecurityContentId = const Value.absent(),
    this.primaryContentGridCropSize = const Value.absent(),
    this.primaryContentGridCropX = const Value.absent(),
    this.primaryContentGridCropY = const Value.absent(),
    this.profileContentVersion = const Value.absent(),
    this.profileName = const Value.absent(),
    this.profileText = const Value.absent(),
    this.profileAge = const Value.absent(),
    this.profileUnlimitedLikes = const Value.absent(),
    this.profileVersion = const Value.absent(),
    this.jsonProfileAttributes = const Value.absent(),
    this.profileLocationLatitude = const Value.absent(),
    this.profileLocationLongitude = const Value.absent(),
    this.jsonProfileVisibility = const Value.absent(),
    this.jsonSearchGroups = const Value.absent(),
    this.jsonProfileAttributeFilters = const Value.absent(),
    this.profileSearchAgeRangeMin = const Value.absent(),
    this.profileSearchAgeRangeMax = const Value.absent(),
    this.profileLastSeenTimeFilter = const Value.absent(),
    this.profileUnlimitedLikesFilter = const Value.absent(),
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
    this.publicKeyVersion = const Value.absent(),
  });
  AccountCompanion.insert({
    this.id = const Value.absent(),
    this.uuidAccountId = const Value.absent(),
    this.jsonAccountState = const Value.absent(),
    this.jsonCapabilities = const Value.absent(),
    this.jsonAvailableProfileAttributes = const Value.absent(),
    this.profileFilterFavorites = const Value.absent(),
    this.profileIteratorSessionId = const Value.absent(),
    this.initialSyncDoneLoginRepository = const Value.absent(),
    this.initialSyncDoneAccountRepository = const Value.absent(),
    this.initialSyncDoneMediaRepository = const Value.absent(),
    this.initialSyncDoneProfileRepository = const Value.absent(),
    this.initialSyncDoneChatRepository = const Value.absent(),
    this.syncVersionAccount = const Value.absent(),
    this.syncVersionReceivedLikes = const Value.absent(),
    this.syncVersionReceivedBlocks = const Value.absent(),
    this.syncVersionSentLikes = const Value.absent(),
    this.syncVersionSentBlocks = const Value.absent(),
    this.syncVersionMatches = const Value.absent(),
    this.syncVersionAvailableProfileAttributes = const Value.absent(),
    this.uuidPendingContentId0 = const Value.absent(),
    this.uuidPendingContentId1 = const Value.absent(),
    this.uuidPendingContentId2 = const Value.absent(),
    this.uuidPendingContentId3 = const Value.absent(),
    this.uuidPendingContentId4 = const Value.absent(),
    this.uuidPendingContentId5 = const Value.absent(),
    this.uuidPendingSecurityContentId = const Value.absent(),
    this.pendingPrimaryContentGridCropSize = const Value.absent(),
    this.pendingPrimaryContentGridCropX = const Value.absent(),
    this.pendingPrimaryContentGridCropY = const Value.absent(),
    this.uuidContentId0 = const Value.absent(),
    this.uuidContentId1 = const Value.absent(),
    this.uuidContentId2 = const Value.absent(),
    this.uuidContentId3 = const Value.absent(),
    this.uuidContentId4 = const Value.absent(),
    this.uuidContentId5 = const Value.absent(),
    this.uuidSecurityContentId = const Value.absent(),
    this.primaryContentGridCropSize = const Value.absent(),
    this.primaryContentGridCropX = const Value.absent(),
    this.primaryContentGridCropY = const Value.absent(),
    this.profileContentVersion = const Value.absent(),
    this.profileName = const Value.absent(),
    this.profileText = const Value.absent(),
    this.profileAge = const Value.absent(),
    this.profileUnlimitedLikes = const Value.absent(),
    this.profileVersion = const Value.absent(),
    this.jsonProfileAttributes = const Value.absent(),
    this.profileLocationLatitude = const Value.absent(),
    this.profileLocationLongitude = const Value.absent(),
    this.jsonProfileVisibility = const Value.absent(),
    this.jsonSearchGroups = const Value.absent(),
    this.jsonProfileAttributeFilters = const Value.absent(),
    this.profileSearchAgeRangeMin = const Value.absent(),
    this.profileSearchAgeRangeMax = const Value.absent(),
    this.profileLastSeenTimeFilter = const Value.absent(),
    this.profileUnlimitedLikesFilter = const Value.absent(),
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
    this.publicKeyVersion = const Value.absent(),
  });
  static Insertable<AccountData> custom({
    Expression<int>? id,
    Expression<String>? uuidAccountId,
    Expression<String>? jsonAccountState,
    Expression<String>? jsonCapabilities,
    Expression<String>? jsonAvailableProfileAttributes,
    Expression<bool>? profileFilterFavorites,
    Expression<String>? profileIteratorSessionId,
    Expression<bool>? initialSyncDoneLoginRepository,
    Expression<bool>? initialSyncDoneAccountRepository,
    Expression<bool>? initialSyncDoneMediaRepository,
    Expression<bool>? initialSyncDoneProfileRepository,
    Expression<bool>? initialSyncDoneChatRepository,
    Expression<int>? syncVersionAccount,
    Expression<int>? syncVersionReceivedLikes,
    Expression<int>? syncVersionReceivedBlocks,
    Expression<int>? syncVersionSentLikes,
    Expression<int>? syncVersionSentBlocks,
    Expression<int>? syncVersionMatches,
    Expression<int>? syncVersionAvailableProfileAttributes,
    Expression<String>? uuidPendingContentId0,
    Expression<String>? uuidPendingContentId1,
    Expression<String>? uuidPendingContentId2,
    Expression<String>? uuidPendingContentId3,
    Expression<String>? uuidPendingContentId4,
    Expression<String>? uuidPendingContentId5,
    Expression<String>? uuidPendingSecurityContentId,
    Expression<double>? pendingPrimaryContentGridCropSize,
    Expression<double>? pendingPrimaryContentGridCropX,
    Expression<double>? pendingPrimaryContentGridCropY,
    Expression<String>? uuidContentId0,
    Expression<String>? uuidContentId1,
    Expression<String>? uuidContentId2,
    Expression<String>? uuidContentId3,
    Expression<String>? uuidContentId4,
    Expression<String>? uuidContentId5,
    Expression<String>? uuidSecurityContentId,
    Expression<double>? primaryContentGridCropSize,
    Expression<double>? primaryContentGridCropX,
    Expression<double>? primaryContentGridCropY,
    Expression<String>? profileContentVersion,
    Expression<String>? profileName,
    Expression<String>? profileText,
    Expression<int>? profileAge,
    Expression<bool>? profileUnlimitedLikes,
    Expression<String>? profileVersion,
    Expression<String>? jsonProfileAttributes,
    Expression<double>? profileLocationLatitude,
    Expression<double>? profileLocationLongitude,
    Expression<String>? jsonProfileVisibility,
    Expression<String>? jsonSearchGroups,
    Expression<String>? jsonProfileAttributeFilters,
    Expression<int>? profileSearchAgeRangeMin,
    Expression<int>? profileSearchAgeRangeMax,
    Expression<int>? profileLastSeenTimeFilter,
    Expression<bool>? profileUnlimitedLikesFilter,
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
    Expression<String>? privateKeyData,
    Expression<String>? publicKeyData,
    Expression<int>? publicKeyId,
    Expression<int>? publicKeyVersion,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuidAccountId != null) 'uuid_account_id': uuidAccountId,
      if (jsonAccountState != null) 'json_account_state': jsonAccountState,
      if (jsonCapabilities != null) 'json_capabilities': jsonCapabilities,
      if (jsonAvailableProfileAttributes != null)
        'json_available_profile_attributes': jsonAvailableProfileAttributes,
      if (profileFilterFavorites != null)
        'profile_filter_favorites': profileFilterFavorites,
      if (profileIteratorSessionId != null)
        'profile_iterator_session_id': profileIteratorSessionId,
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
      if (syncVersionReceivedLikes != null)
        'sync_version_received_likes': syncVersionReceivedLikes,
      if (syncVersionReceivedBlocks != null)
        'sync_version_received_blocks': syncVersionReceivedBlocks,
      if (syncVersionSentLikes != null)
        'sync_version_sent_likes': syncVersionSentLikes,
      if (syncVersionSentBlocks != null)
        'sync_version_sent_blocks': syncVersionSentBlocks,
      if (syncVersionMatches != null)
        'sync_version_matches': syncVersionMatches,
      if (syncVersionAvailableProfileAttributes != null)
        'sync_version_available_profile_attributes':
            syncVersionAvailableProfileAttributes,
      if (uuidPendingContentId0 != null)
        'uuid_pending_content_id0': uuidPendingContentId0,
      if (uuidPendingContentId1 != null)
        'uuid_pending_content_id1': uuidPendingContentId1,
      if (uuidPendingContentId2 != null)
        'uuid_pending_content_id2': uuidPendingContentId2,
      if (uuidPendingContentId3 != null)
        'uuid_pending_content_id3': uuidPendingContentId3,
      if (uuidPendingContentId4 != null)
        'uuid_pending_content_id4': uuidPendingContentId4,
      if (uuidPendingContentId5 != null)
        'uuid_pending_content_id5': uuidPendingContentId5,
      if (uuidPendingSecurityContentId != null)
        'uuid_pending_security_content_id': uuidPendingSecurityContentId,
      if (pendingPrimaryContentGridCropSize != null)
        'pending_primary_content_grid_crop_size':
            pendingPrimaryContentGridCropSize,
      if (pendingPrimaryContentGridCropX != null)
        'pending_primary_content_grid_crop_x': pendingPrimaryContentGridCropX,
      if (pendingPrimaryContentGridCropY != null)
        'pending_primary_content_grid_crop_y': pendingPrimaryContentGridCropY,
      if (uuidContentId0 != null) 'uuid_content_id0': uuidContentId0,
      if (uuidContentId1 != null) 'uuid_content_id1': uuidContentId1,
      if (uuidContentId2 != null) 'uuid_content_id2': uuidContentId2,
      if (uuidContentId3 != null) 'uuid_content_id3': uuidContentId3,
      if (uuidContentId4 != null) 'uuid_content_id4': uuidContentId4,
      if (uuidContentId5 != null) 'uuid_content_id5': uuidContentId5,
      if (uuidSecurityContentId != null)
        'uuid_security_content_id': uuidSecurityContentId,
      if (primaryContentGridCropSize != null)
        'primary_content_grid_crop_size': primaryContentGridCropSize,
      if (primaryContentGridCropX != null)
        'primary_content_grid_crop_x': primaryContentGridCropX,
      if (primaryContentGridCropY != null)
        'primary_content_grid_crop_y': primaryContentGridCropY,
      if (profileContentVersion != null)
        'profile_content_version': profileContentVersion,
      if (profileName != null) 'profile_name': profileName,
      if (profileText != null) 'profile_text': profileText,
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
      if (jsonProfileVisibility != null)
        'json_profile_visibility': jsonProfileVisibility,
      if (jsonSearchGroups != null) 'json_search_groups': jsonSearchGroups,
      if (jsonProfileAttributeFilters != null)
        'json_profile_attribute_filters': jsonProfileAttributeFilters,
      if (profileSearchAgeRangeMin != null)
        'profile_search_age_range_min': profileSearchAgeRangeMin,
      if (profileSearchAgeRangeMax != null)
        'profile_search_age_range_max': profileSearchAgeRangeMax,
      if (profileLastSeenTimeFilter != null)
        'profile_last_seen_time_filter': profileLastSeenTimeFilter,
      if (profileUnlimitedLikesFilter != null)
        'profile_unlimited_likes_filter': profileUnlimitedLikesFilter,
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
      if (publicKeyVersion != null) 'public_key_version': publicKeyVersion,
    });
  }

  AccountCompanion copyWith(
      {Value<int>? id,
      Value<AccountId?>? uuidAccountId,
      Value<EnumString?>? jsonAccountState,
      Value<JsonString?>? jsonCapabilities,
      Value<JsonString?>? jsonAvailableProfileAttributes,
      Value<bool>? profileFilterFavorites,
      Value<IteratorSessionId?>? profileIteratorSessionId,
      Value<bool>? initialSyncDoneLoginRepository,
      Value<bool>? initialSyncDoneAccountRepository,
      Value<bool>? initialSyncDoneMediaRepository,
      Value<bool>? initialSyncDoneProfileRepository,
      Value<bool>? initialSyncDoneChatRepository,
      Value<int?>? syncVersionAccount,
      Value<int?>? syncVersionReceivedLikes,
      Value<int?>? syncVersionReceivedBlocks,
      Value<int?>? syncVersionSentLikes,
      Value<int?>? syncVersionSentBlocks,
      Value<int?>? syncVersionMatches,
      Value<int?>? syncVersionAvailableProfileAttributes,
      Value<ContentId?>? uuidPendingContentId0,
      Value<ContentId?>? uuidPendingContentId1,
      Value<ContentId?>? uuidPendingContentId2,
      Value<ContentId?>? uuidPendingContentId3,
      Value<ContentId?>? uuidPendingContentId4,
      Value<ContentId?>? uuidPendingContentId5,
      Value<ContentId?>? uuidPendingSecurityContentId,
      Value<double?>? pendingPrimaryContentGridCropSize,
      Value<double?>? pendingPrimaryContentGridCropX,
      Value<double?>? pendingPrimaryContentGridCropY,
      Value<ContentId?>? uuidContentId0,
      Value<ContentId?>? uuidContentId1,
      Value<ContentId?>? uuidContentId2,
      Value<ContentId?>? uuidContentId3,
      Value<ContentId?>? uuidContentId4,
      Value<ContentId?>? uuidContentId5,
      Value<ContentId?>? uuidSecurityContentId,
      Value<double?>? primaryContentGridCropSize,
      Value<double?>? primaryContentGridCropX,
      Value<double?>? primaryContentGridCropY,
      Value<ProfileContentVersion?>? profileContentVersion,
      Value<String?>? profileName,
      Value<String?>? profileText,
      Value<int?>? profileAge,
      Value<bool?>? profileUnlimitedLikes,
      Value<ProfileVersion?>? profileVersion,
      Value<JsonList?>? jsonProfileAttributes,
      Value<double?>? profileLocationLatitude,
      Value<double?>? profileLocationLongitude,
      Value<EnumString?>? jsonProfileVisibility,
      Value<JsonString?>? jsonSearchGroups,
      Value<JsonString?>? jsonProfileAttributeFilters,
      Value<int?>? profileSearchAgeRangeMin,
      Value<int?>? profileSearchAgeRangeMax,
      Value<LastSeenTimeFilter?>? profileLastSeenTimeFilter,
      Value<bool?>? profileUnlimitedLikesFilter,
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
      Value<PublicKeyId?>? publicKeyId,
      Value<PublicKeyVersion?>? publicKeyVersion}) {
    return AccountCompanion(
      id: id ?? this.id,
      uuidAccountId: uuidAccountId ?? this.uuidAccountId,
      jsonAccountState: jsonAccountState ?? this.jsonAccountState,
      jsonCapabilities: jsonCapabilities ?? this.jsonCapabilities,
      jsonAvailableProfileAttributes:
          jsonAvailableProfileAttributes ?? this.jsonAvailableProfileAttributes,
      profileFilterFavorites:
          profileFilterFavorites ?? this.profileFilterFavorites,
      profileIteratorSessionId:
          profileIteratorSessionId ?? this.profileIteratorSessionId,
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
      syncVersionReceivedLikes:
          syncVersionReceivedLikes ?? this.syncVersionReceivedLikes,
      syncVersionReceivedBlocks:
          syncVersionReceivedBlocks ?? this.syncVersionReceivedBlocks,
      syncVersionSentLikes: syncVersionSentLikes ?? this.syncVersionSentLikes,
      syncVersionSentBlocks:
          syncVersionSentBlocks ?? this.syncVersionSentBlocks,
      syncVersionMatches: syncVersionMatches ?? this.syncVersionMatches,
      syncVersionAvailableProfileAttributes:
          syncVersionAvailableProfileAttributes ??
              this.syncVersionAvailableProfileAttributes,
      uuidPendingContentId0:
          uuidPendingContentId0 ?? this.uuidPendingContentId0,
      uuidPendingContentId1:
          uuidPendingContentId1 ?? this.uuidPendingContentId1,
      uuidPendingContentId2:
          uuidPendingContentId2 ?? this.uuidPendingContentId2,
      uuidPendingContentId3:
          uuidPendingContentId3 ?? this.uuidPendingContentId3,
      uuidPendingContentId4:
          uuidPendingContentId4 ?? this.uuidPendingContentId4,
      uuidPendingContentId5:
          uuidPendingContentId5 ?? this.uuidPendingContentId5,
      uuidPendingSecurityContentId:
          uuidPendingSecurityContentId ?? this.uuidPendingSecurityContentId,
      pendingPrimaryContentGridCropSize: pendingPrimaryContentGridCropSize ??
          this.pendingPrimaryContentGridCropSize,
      pendingPrimaryContentGridCropX:
          pendingPrimaryContentGridCropX ?? this.pendingPrimaryContentGridCropX,
      pendingPrimaryContentGridCropY:
          pendingPrimaryContentGridCropY ?? this.pendingPrimaryContentGridCropY,
      uuidContentId0: uuidContentId0 ?? this.uuidContentId0,
      uuidContentId1: uuidContentId1 ?? this.uuidContentId1,
      uuidContentId2: uuidContentId2 ?? this.uuidContentId2,
      uuidContentId3: uuidContentId3 ?? this.uuidContentId3,
      uuidContentId4: uuidContentId4 ?? this.uuidContentId4,
      uuidContentId5: uuidContentId5 ?? this.uuidContentId5,
      uuidSecurityContentId:
          uuidSecurityContentId ?? this.uuidSecurityContentId,
      primaryContentGridCropSize:
          primaryContentGridCropSize ?? this.primaryContentGridCropSize,
      primaryContentGridCropX:
          primaryContentGridCropX ?? this.primaryContentGridCropX,
      primaryContentGridCropY:
          primaryContentGridCropY ?? this.primaryContentGridCropY,
      profileContentVersion:
          profileContentVersion ?? this.profileContentVersion,
      profileName: profileName ?? this.profileName,
      profileText: profileText ?? this.profileText,
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
      jsonProfileVisibility:
          jsonProfileVisibility ?? this.jsonProfileVisibility,
      jsonSearchGroups: jsonSearchGroups ?? this.jsonSearchGroups,
      jsonProfileAttributeFilters:
          jsonProfileAttributeFilters ?? this.jsonProfileAttributeFilters,
      profileSearchAgeRangeMin:
          profileSearchAgeRangeMin ?? this.profileSearchAgeRangeMin,
      profileSearchAgeRangeMax:
          profileSearchAgeRangeMax ?? this.profileSearchAgeRangeMax,
      profileLastSeenTimeFilter:
          profileLastSeenTimeFilter ?? this.profileLastSeenTimeFilter,
      profileUnlimitedLikesFilter:
          profileUnlimitedLikesFilter ?? this.profileUnlimitedLikesFilter,
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
      publicKeyVersion: publicKeyVersion ?? this.publicKeyVersion,
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
    if (jsonCapabilities.present) {
      map['json_capabilities'] = Variable<String>($AccountTable
          .$converterjsonCapabilities
          .toSql(jsonCapabilities.value));
    }
    if (jsonAvailableProfileAttributes.present) {
      map['json_available_profile_attributes'] = Variable<String>($AccountTable
          .$converterjsonAvailableProfileAttributes
          .toSql(jsonAvailableProfileAttributes.value));
    }
    if (profileFilterFavorites.present) {
      map['profile_filter_favorites'] =
          Variable<bool>(profileFilterFavorites.value);
    }
    if (profileIteratorSessionId.present) {
      map['profile_iterator_session_id'] = Variable<String>($AccountTable
          .$converterprofileIteratorSessionId
          .toSql(profileIteratorSessionId.value));
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
    if (syncVersionReceivedLikes.present) {
      map['sync_version_received_likes'] =
          Variable<int>(syncVersionReceivedLikes.value);
    }
    if (syncVersionReceivedBlocks.present) {
      map['sync_version_received_blocks'] =
          Variable<int>(syncVersionReceivedBlocks.value);
    }
    if (syncVersionSentLikes.present) {
      map['sync_version_sent_likes'] =
          Variable<int>(syncVersionSentLikes.value);
    }
    if (syncVersionSentBlocks.present) {
      map['sync_version_sent_blocks'] =
          Variable<int>(syncVersionSentBlocks.value);
    }
    if (syncVersionMatches.present) {
      map['sync_version_matches'] = Variable<int>(syncVersionMatches.value);
    }
    if (syncVersionAvailableProfileAttributes.present) {
      map['sync_version_available_profile_attributes'] =
          Variable<int>(syncVersionAvailableProfileAttributes.value);
    }
    if (uuidPendingContentId0.present) {
      map['uuid_pending_content_id0'] = Variable<String>($AccountTable
          .$converteruuidPendingContentId0
          .toSql(uuidPendingContentId0.value));
    }
    if (uuidPendingContentId1.present) {
      map['uuid_pending_content_id1'] = Variable<String>($AccountTable
          .$converteruuidPendingContentId1
          .toSql(uuidPendingContentId1.value));
    }
    if (uuidPendingContentId2.present) {
      map['uuid_pending_content_id2'] = Variable<String>($AccountTable
          .$converteruuidPendingContentId2
          .toSql(uuidPendingContentId2.value));
    }
    if (uuidPendingContentId3.present) {
      map['uuid_pending_content_id3'] = Variable<String>($AccountTable
          .$converteruuidPendingContentId3
          .toSql(uuidPendingContentId3.value));
    }
    if (uuidPendingContentId4.present) {
      map['uuid_pending_content_id4'] = Variable<String>($AccountTable
          .$converteruuidPendingContentId4
          .toSql(uuidPendingContentId4.value));
    }
    if (uuidPendingContentId5.present) {
      map['uuid_pending_content_id5'] = Variable<String>($AccountTable
          .$converteruuidPendingContentId5
          .toSql(uuidPendingContentId5.value));
    }
    if (uuidPendingSecurityContentId.present) {
      map['uuid_pending_security_content_id'] = Variable<String>($AccountTable
          .$converteruuidPendingSecurityContentId
          .toSql(uuidPendingSecurityContentId.value));
    }
    if (pendingPrimaryContentGridCropSize.present) {
      map['pending_primary_content_grid_crop_size'] =
          Variable<double>(pendingPrimaryContentGridCropSize.value);
    }
    if (pendingPrimaryContentGridCropX.present) {
      map['pending_primary_content_grid_crop_x'] =
          Variable<double>(pendingPrimaryContentGridCropX.value);
    }
    if (pendingPrimaryContentGridCropY.present) {
      map['pending_primary_content_grid_crop_y'] =
          Variable<double>(pendingPrimaryContentGridCropY.value);
    }
    if (uuidContentId0.present) {
      map['uuid_content_id0'] = Variable<String>(
          $AccountTable.$converteruuidContentId0.toSql(uuidContentId0.value));
    }
    if (uuidContentId1.present) {
      map['uuid_content_id1'] = Variable<String>(
          $AccountTable.$converteruuidContentId1.toSql(uuidContentId1.value));
    }
    if (uuidContentId2.present) {
      map['uuid_content_id2'] = Variable<String>(
          $AccountTable.$converteruuidContentId2.toSql(uuidContentId2.value));
    }
    if (uuidContentId3.present) {
      map['uuid_content_id3'] = Variable<String>(
          $AccountTable.$converteruuidContentId3.toSql(uuidContentId3.value));
    }
    if (uuidContentId4.present) {
      map['uuid_content_id4'] = Variable<String>(
          $AccountTable.$converteruuidContentId4.toSql(uuidContentId4.value));
    }
    if (uuidContentId5.present) {
      map['uuid_content_id5'] = Variable<String>(
          $AccountTable.$converteruuidContentId5.toSql(uuidContentId5.value));
    }
    if (uuidSecurityContentId.present) {
      map['uuid_security_content_id'] = Variable<String>($AccountTable
          .$converteruuidSecurityContentId
          .toSql(uuidSecurityContentId.value));
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
    if (profileText.present) {
      map['profile_text'] = Variable<String>(profileText.value);
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
    if (jsonProfileVisibility.present) {
      map['json_profile_visibility'] = Variable<String>($AccountTable
          .$converterjsonProfileVisibility
          .toSql(jsonProfileVisibility.value));
    }
    if (jsonSearchGroups.present) {
      map['json_search_groups'] = Variable<String>($AccountTable
          .$converterjsonSearchGroups
          .toSql(jsonSearchGroups.value));
    }
    if (jsonProfileAttributeFilters.present) {
      map['json_profile_attribute_filters'] = Variable<String>($AccountTable
          .$converterjsonProfileAttributeFilters
          .toSql(jsonProfileAttributeFilters.value));
    }
    if (profileSearchAgeRangeMin.present) {
      map['profile_search_age_range_min'] =
          Variable<int>(profileSearchAgeRangeMin.value);
    }
    if (profileSearchAgeRangeMax.present) {
      map['profile_search_age_range_max'] =
          Variable<int>(profileSearchAgeRangeMax.value);
    }
    if (profileLastSeenTimeFilter.present) {
      map['profile_last_seen_time_filter'] = Variable<int>($AccountTable
          .$converterprofileLastSeenTimeFilter
          .toSql(profileLastSeenTimeFilter.value));
    }
    if (profileUnlimitedLikesFilter.present) {
      map['profile_unlimited_likes_filter'] =
          Variable<bool>(profileUnlimitedLikesFilter.value);
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
      map['private_key_data'] = Variable<String>(
          $AccountTable.$converterprivateKeyData.toSql(privateKeyData.value));
    }
    if (publicKeyData.present) {
      map['public_key_data'] = Variable<String>(
          $AccountTable.$converterpublicKeyData.toSql(publicKeyData.value));
    }
    if (publicKeyId.present) {
      map['public_key_id'] = Variable<int>(
          $AccountTable.$converterpublicKeyId.toSql(publicKeyId.value));
    }
    if (publicKeyVersion.present) {
      map['public_key_version'] = Variable<int>($AccountTable
          .$converterpublicKeyVersion
          .toSql(publicKeyVersion.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AccountCompanion(')
          ..write('id: $id, ')
          ..write('uuidAccountId: $uuidAccountId, ')
          ..write('jsonAccountState: $jsonAccountState, ')
          ..write('jsonCapabilities: $jsonCapabilities, ')
          ..write(
              'jsonAvailableProfileAttributes: $jsonAvailableProfileAttributes, ')
          ..write('profileFilterFavorites: $profileFilterFavorites, ')
          ..write('profileIteratorSessionId: $profileIteratorSessionId, ')
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
          ..write('syncVersionReceivedLikes: $syncVersionReceivedLikes, ')
          ..write('syncVersionReceivedBlocks: $syncVersionReceivedBlocks, ')
          ..write('syncVersionSentLikes: $syncVersionSentLikes, ')
          ..write('syncVersionSentBlocks: $syncVersionSentBlocks, ')
          ..write('syncVersionMatches: $syncVersionMatches, ')
          ..write(
              'syncVersionAvailableProfileAttributes: $syncVersionAvailableProfileAttributes, ')
          ..write('uuidPendingContentId0: $uuidPendingContentId0, ')
          ..write('uuidPendingContentId1: $uuidPendingContentId1, ')
          ..write('uuidPendingContentId2: $uuidPendingContentId2, ')
          ..write('uuidPendingContentId3: $uuidPendingContentId3, ')
          ..write('uuidPendingContentId4: $uuidPendingContentId4, ')
          ..write('uuidPendingContentId5: $uuidPendingContentId5, ')
          ..write(
              'uuidPendingSecurityContentId: $uuidPendingSecurityContentId, ')
          ..write(
              'pendingPrimaryContentGridCropSize: $pendingPrimaryContentGridCropSize, ')
          ..write(
              'pendingPrimaryContentGridCropX: $pendingPrimaryContentGridCropX, ')
          ..write(
              'pendingPrimaryContentGridCropY: $pendingPrimaryContentGridCropY, ')
          ..write('uuidContentId0: $uuidContentId0, ')
          ..write('uuidContentId1: $uuidContentId1, ')
          ..write('uuidContentId2: $uuidContentId2, ')
          ..write('uuidContentId3: $uuidContentId3, ')
          ..write('uuidContentId4: $uuidContentId4, ')
          ..write('uuidContentId5: $uuidContentId5, ')
          ..write('uuidSecurityContentId: $uuidSecurityContentId, ')
          ..write('primaryContentGridCropSize: $primaryContentGridCropSize, ')
          ..write('primaryContentGridCropX: $primaryContentGridCropX, ')
          ..write('primaryContentGridCropY: $primaryContentGridCropY, ')
          ..write('profileContentVersion: $profileContentVersion, ')
          ..write('profileName: $profileName, ')
          ..write('profileText: $profileText, ')
          ..write('profileAge: $profileAge, ')
          ..write('profileUnlimitedLikes: $profileUnlimitedLikes, ')
          ..write('profileVersion: $profileVersion, ')
          ..write('jsonProfileAttributes: $jsonProfileAttributes, ')
          ..write('profileLocationLatitude: $profileLocationLatitude, ')
          ..write('profileLocationLongitude: $profileLocationLongitude, ')
          ..write('jsonProfileVisibility: $jsonProfileVisibility, ')
          ..write('jsonSearchGroups: $jsonSearchGroups, ')
          ..write('jsonProfileAttributeFilters: $jsonProfileAttributeFilters, ')
          ..write('profileSearchAgeRangeMin: $profileSearchAgeRangeMin, ')
          ..write('profileSearchAgeRangeMax: $profileSearchAgeRangeMax, ')
          ..write('profileLastSeenTimeFilter: $profileLastSeenTimeFilter, ')
          ..write('profileUnlimitedLikesFilter: $profileUnlimitedLikesFilter, ')
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
          ..write('publicKeyVersion: $publicKeyVersion')
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
  static const VerificationMeta _uuidAccountIdMeta =
      const VerificationMeta('uuidAccountId');
  @override
  late final GeneratedColumnWithTypeConverter<AccountId, String> uuidAccountId =
      GeneratedColumn<String>('uuid_account_id', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: true,
              defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'))
          .withConverter<AccountId>($ProfilesTable.$converteruuidAccountId);
  static const VerificationMeta _uuidContentId0Meta =
      const VerificationMeta('uuidContentId0');
  @override
  late final GeneratedColumnWithTypeConverter<ContentId?, String>
      uuidContentId0 = GeneratedColumn<String>(
              'uuid_content_id0', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<ContentId?>($ProfilesTable.$converteruuidContentId0);
  static const VerificationMeta _uuidContentId1Meta =
      const VerificationMeta('uuidContentId1');
  @override
  late final GeneratedColumnWithTypeConverter<ContentId?, String>
      uuidContentId1 = GeneratedColumn<String>(
              'uuid_content_id1', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<ContentId?>($ProfilesTable.$converteruuidContentId1);
  static const VerificationMeta _uuidContentId2Meta =
      const VerificationMeta('uuidContentId2');
  @override
  late final GeneratedColumnWithTypeConverter<ContentId?, String>
      uuidContentId2 = GeneratedColumn<String>(
              'uuid_content_id2', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<ContentId?>($ProfilesTable.$converteruuidContentId2);
  static const VerificationMeta _uuidContentId3Meta =
      const VerificationMeta('uuidContentId3');
  @override
  late final GeneratedColumnWithTypeConverter<ContentId?, String>
      uuidContentId3 = GeneratedColumn<String>(
              'uuid_content_id3', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<ContentId?>($ProfilesTable.$converteruuidContentId3);
  static const VerificationMeta _uuidContentId4Meta =
      const VerificationMeta('uuidContentId4');
  @override
  late final GeneratedColumnWithTypeConverter<ContentId?, String>
      uuidContentId4 = GeneratedColumn<String>(
              'uuid_content_id4', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<ContentId?>($ProfilesTable.$converteruuidContentId4);
  static const VerificationMeta _uuidContentId5Meta =
      const VerificationMeta('uuidContentId5');
  @override
  late final GeneratedColumnWithTypeConverter<ContentId?, String>
      uuidContentId5 = GeneratedColumn<String>(
              'uuid_content_id5', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<ContentId?>($ProfilesTable.$converteruuidContentId5);
  static const VerificationMeta _profileContentVersionMeta =
      const VerificationMeta('profileContentVersion');
  @override
  late final GeneratedColumnWithTypeConverter<ProfileContentVersion?, String>
      profileContentVersion = GeneratedColumn<String>(
              'profile_content_version', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<ProfileContentVersion?>(
              $ProfilesTable.$converterprofileContentVersion);
  static const VerificationMeta _profileNameMeta =
      const VerificationMeta('profileName');
  @override
  late final GeneratedColumn<String> profileName = GeneratedColumn<String>(
      'profile_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _profileTextMeta =
      const VerificationMeta('profileText');
  @override
  late final GeneratedColumn<String> profileText = GeneratedColumn<String>(
      'profile_text', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _profileVersionMeta =
      const VerificationMeta('profileVersion');
  @override
  late final GeneratedColumnWithTypeConverter<ProfileVersion?, String>
      profileVersion = GeneratedColumn<String>(
              'profile_version', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<ProfileVersion?>(
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
  static const VerificationMeta _jsonProfileAttributesMeta =
      const VerificationMeta('jsonProfileAttributes');
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
  static const VerificationMeta _publicKeyDataMeta =
      const VerificationMeta('publicKeyData');
  @override
  late final GeneratedColumnWithTypeConverter<PublicKeyData?, String>
      publicKeyData = GeneratedColumn<String>(
              'public_key_data', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<PublicKeyData?>(
              $ProfilesTable.$converterpublicKeyData);
  static const VerificationMeta _publicKeyIdMeta =
      const VerificationMeta('publicKeyId');
  @override
  late final GeneratedColumnWithTypeConverter<PublicKeyId?, int> publicKeyId =
      GeneratedColumn<int>('public_key_id', aliasedName, true,
              type: DriftSqlType.int, requiredDuringInsert: false)
          .withConverter<PublicKeyId?>($ProfilesTable.$converterpublicKeyId);
  static const VerificationMeta _publicKeyVersionMeta =
      const VerificationMeta('publicKeyVersion');
  @override
  late final GeneratedColumnWithTypeConverter<PublicKeyVersion?, int>
      publicKeyVersion = GeneratedColumn<int>(
              'public_key_version', aliasedName, true,
              type: DriftSqlType.int, requiredDuringInsert: false)
          .withConverter<PublicKeyVersion?>(
              $ProfilesTable.$converterpublicKeyVersion);
  static const VerificationMeta _conversationNextSenderMessageIdMeta =
      const VerificationMeta('conversationNextSenderMessageId');
  @override
  late final GeneratedColumnWithTypeConverter<SenderMessageId?, int>
      conversationNextSenderMessageId = GeneratedColumn<int>(
              'conversation_next_sender_message_id', aliasedName, true,
              type: DriftSqlType.int, requiredDuringInsert: false)
          .withConverter<SenderMessageId?>(
              $ProfilesTable.$converterconversationNextSenderMessageId);
  static const VerificationMeta _unreadMessagesCountMeta =
      const VerificationMeta('unreadMessagesCount');
  @override
  late final GeneratedColumnWithTypeConverter<UnreadMessagesCount, int>
      unreadMessagesCount = GeneratedColumn<int>(
              'unread_messages_count', aliasedName, false,
              type: DriftSqlType.int,
              requiredDuringInsert: false,
              defaultValue: const Constant(0))
          .withConverter<UnreadMessagesCount>(
              $ProfilesTable.$converterunreadMessagesCount);
  static const VerificationMeta _isInFavoritesMeta =
      const VerificationMeta('isInFavorites');
  @override
  late final GeneratedColumnWithTypeConverter<UtcDateTime?, int> isInFavorites =
      GeneratedColumn<int>('is_in_favorites', aliasedName, true,
              type: DriftSqlType.int, requiredDuringInsert: false)
          .withConverter<UtcDateTime?>($ProfilesTable.$converterisInFavorites);
  static const VerificationMeta _isInMatchesMeta =
      const VerificationMeta('isInMatches');
  @override
  late final GeneratedColumnWithTypeConverter<UtcDateTime?, int> isInMatches =
      GeneratedColumn<int>('is_in_matches', aliasedName, true,
              type: DriftSqlType.int, requiredDuringInsert: false)
          .withConverter<UtcDateTime?>($ProfilesTable.$converterisInMatches);
  static const VerificationMeta _isInReceivedBlocksMeta =
      const VerificationMeta('isInReceivedBlocks');
  @override
  late final GeneratedColumnWithTypeConverter<UtcDateTime?, int>
      isInReceivedBlocks = GeneratedColumn<int>(
              'is_in_received_blocks', aliasedName, true,
              type: DriftSqlType.int, requiredDuringInsert: false)
          .withConverter<UtcDateTime?>(
              $ProfilesTable.$converterisInReceivedBlocks);
  static const VerificationMeta _isInReceivedLikesMeta =
      const VerificationMeta('isInReceivedLikes');
  @override
  late final GeneratedColumnWithTypeConverter<UtcDateTime?, int>
      isInReceivedLikes = GeneratedColumn<int>(
              'is_in_received_likes', aliasedName, true,
              type: DriftSqlType.int, requiredDuringInsert: false)
          .withConverter<UtcDateTime?>(
              $ProfilesTable.$converterisInReceivedLikes);
  static const VerificationMeta _isInSentBlocksMeta =
      const VerificationMeta('isInSentBlocks');
  @override
  late final GeneratedColumnWithTypeConverter<UtcDateTime?, int>
      isInSentBlocks = GeneratedColumn<int>(
              'is_in_sent_blocks', aliasedName, true,
              type: DriftSqlType.int, requiredDuringInsert: false)
          .withConverter<UtcDateTime?>($ProfilesTable.$converterisInSentBlocks);
  static const VerificationMeta _isInSentLikesMeta =
      const VerificationMeta('isInSentLikes');
  @override
  late final GeneratedColumnWithTypeConverter<UtcDateTime?, int> isInSentLikes =
      GeneratedColumn<int>('is_in_sent_likes', aliasedName, true,
              type: DriftSqlType.int, requiredDuringInsert: false)
          .withConverter<UtcDateTime?>($ProfilesTable.$converterisInSentLikes);
  static const VerificationMeta _isInProfileGridMeta =
      const VerificationMeta('isInProfileGrid');
  @override
  late final GeneratedColumnWithTypeConverter<UtcDateTime?, int>
      isInProfileGrid = GeneratedColumn<int>(
              'is_in_profile_grid', aliasedName, true,
              type: DriftSqlType.int, requiredDuringInsert: false)
          .withConverter<UtcDateTime?>(
              $ProfilesTable.$converterisInProfileGrid);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        uuidAccountId,
        uuidContentId0,
        uuidContentId1,
        uuidContentId2,
        uuidContentId3,
        uuidContentId4,
        uuidContentId5,
        profileContentVersion,
        profileName,
        profileText,
        profileVersion,
        profileAge,
        profileLastSeenTimeValue,
        profileUnlimitedLikes,
        jsonProfileAttributes,
        primaryContentGridCropSize,
        primaryContentGridCropX,
        primaryContentGridCropY,
        publicKeyData,
        publicKeyId,
        publicKeyVersion,
        conversationNextSenderMessageId,
        unreadMessagesCount,
        isInFavorites,
        isInMatches,
        isInReceivedBlocks,
        isInReceivedLikes,
        isInSentBlocks,
        isInSentLikes,
        isInProfileGrid
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
    context.handle(_uuidAccountIdMeta, const VerificationResult.success());
    context.handle(_uuidContentId0Meta, const VerificationResult.success());
    context.handle(_uuidContentId1Meta, const VerificationResult.success());
    context.handle(_uuidContentId2Meta, const VerificationResult.success());
    context.handle(_uuidContentId3Meta, const VerificationResult.success());
    context.handle(_uuidContentId4Meta, const VerificationResult.success());
    context.handle(_uuidContentId5Meta, const VerificationResult.success());
    context.handle(
        _profileContentVersionMeta, const VerificationResult.success());
    if (data.containsKey('profile_name')) {
      context.handle(
          _profileNameMeta,
          profileName.isAcceptableOrUnknown(
              data['profile_name']!, _profileNameMeta));
    }
    if (data.containsKey('profile_text')) {
      context.handle(
          _profileTextMeta,
          profileText.isAcceptableOrUnknown(
              data['profile_text']!, _profileTextMeta));
    }
    context.handle(_profileVersionMeta, const VerificationResult.success());
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
    context.handle(
        _jsonProfileAttributesMeta, const VerificationResult.success());
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
    context.handle(_publicKeyDataMeta, const VerificationResult.success());
    context.handle(_publicKeyIdMeta, const VerificationResult.success());
    context.handle(_publicKeyVersionMeta, const VerificationResult.success());
    context.handle(_conversationNextSenderMessageIdMeta,
        const VerificationResult.success());
    context.handle(
        _unreadMessagesCountMeta, const VerificationResult.success());
    context.handle(_isInFavoritesMeta, const VerificationResult.success());
    context.handle(_isInMatchesMeta, const VerificationResult.success());
    context.handle(_isInReceivedBlocksMeta, const VerificationResult.success());
    context.handle(_isInReceivedLikesMeta, const VerificationResult.success());
    context.handle(_isInSentBlocksMeta, const VerificationResult.success());
    context.handle(_isInSentLikesMeta, const VerificationResult.success());
    context.handle(_isInProfileGridMeta, const VerificationResult.success());
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
      uuidContentId0: $ProfilesTable.$converteruuidContentId0.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}uuid_content_id0'])),
      uuidContentId1: $ProfilesTable.$converteruuidContentId1.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}uuid_content_id1'])),
      uuidContentId2: $ProfilesTable.$converteruuidContentId2.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}uuid_content_id2'])),
      uuidContentId3: $ProfilesTable.$converteruuidContentId3.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}uuid_content_id3'])),
      uuidContentId4: $ProfilesTable.$converteruuidContentId4.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}uuid_content_id4'])),
      uuidContentId5: $ProfilesTable.$converteruuidContentId5.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}uuid_content_id5'])),
      profileContentVersion: $ProfilesTable.$converterprofileContentVersion
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}profile_content_version'])),
      profileName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}profile_name']),
      profileText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}profile_text']),
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
      publicKeyData: $ProfilesTable.$converterpublicKeyData.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}public_key_data'])),
      publicKeyId: $ProfilesTable.$converterpublicKeyId.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}public_key_id'])),
      publicKeyVersion: $ProfilesTable.$converterpublicKeyVersion.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.int, data['${effectivePrefix}public_key_version'])),
      conversationNextSenderMessageId: $ProfilesTable
          .$converterconversationNextSenderMessageId
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.int,
              data['${effectivePrefix}conversation_next_sender_message_id'])),
      unreadMessagesCount: $ProfilesTable.$converterunreadMessagesCount.fromSql(
          attachedDatabase.typeMapping.read(DriftSqlType.int,
              data['${effectivePrefix}unread_messages_count'])!),
      isInFavorites: $ProfilesTable.$converterisInFavorites.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.int, data['${effectivePrefix}is_in_favorites'])),
      isInMatches: $ProfilesTable.$converterisInMatches.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}is_in_matches'])),
      isInReceivedBlocks: $ProfilesTable.$converterisInReceivedBlocks.fromSql(
          attachedDatabase.typeMapping.read(DriftSqlType.int,
              data['${effectivePrefix}is_in_received_blocks'])),
      isInReceivedLikes: $ProfilesTable.$converterisInReceivedLikes.fromSql(
          attachedDatabase.typeMapping.read(DriftSqlType.int,
              data['${effectivePrefix}is_in_received_likes'])),
      isInSentBlocks: $ProfilesTable.$converterisInSentBlocks.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.int, data['${effectivePrefix}is_in_sent_blocks'])),
      isInSentLikes: $ProfilesTable.$converterisInSentLikes.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.int, data['${effectivePrefix}is_in_sent_likes'])),
      isInProfileGrid: $ProfilesTable.$converterisInProfileGrid.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.int, data['${effectivePrefix}is_in_profile_grid'])),
    );
  }

  @override
  $ProfilesTable createAlias(String alias) {
    return $ProfilesTable(attachedDatabase, alias);
  }

  static TypeConverter<AccountId, String> $converteruuidAccountId =
      const AccountIdConverter();
  static TypeConverter<ContentId?, String?> $converteruuidContentId0 =
      const NullAwareTypeConverter.wrap(ContentIdConverter());
  static TypeConverter<ContentId?, String?> $converteruuidContentId1 =
      const NullAwareTypeConverter.wrap(ContentIdConverter());
  static TypeConverter<ContentId?, String?> $converteruuidContentId2 =
      const NullAwareTypeConverter.wrap(ContentIdConverter());
  static TypeConverter<ContentId?, String?> $converteruuidContentId3 =
      const NullAwareTypeConverter.wrap(ContentIdConverter());
  static TypeConverter<ContentId?, String?> $converteruuidContentId4 =
      const NullAwareTypeConverter.wrap(ContentIdConverter());
  static TypeConverter<ContentId?, String?> $converteruuidContentId5 =
      const NullAwareTypeConverter.wrap(ContentIdConverter());
  static TypeConverter<ProfileContentVersion?, String?>
      $converterprofileContentVersion =
      const NullAwareTypeConverter.wrap(ProfileContentVersionConverter());
  static TypeConverter<ProfileVersion?, String?> $converterprofileVersion =
      const NullAwareTypeConverter.wrap(ProfileVersionConverter());
  static TypeConverter<JsonList?, String?> $converterjsonProfileAttributes =
      NullAwareTypeConverter.wrap(JsonList.driftConverter);
  static TypeConverter<PublicKeyData?, String?> $converterpublicKeyData =
      const NullAwareTypeConverter.wrap(PublicKeyDataConverter());
  static TypeConverter<PublicKeyId?, int?> $converterpublicKeyId =
      const NullAwareTypeConverter.wrap(PublicKeyIdConverter());
  static TypeConverter<PublicKeyVersion?, int?> $converterpublicKeyVersion =
      const NullAwareTypeConverter.wrap(PublicKeyVersionConverter());
  static TypeConverter<SenderMessageId?, int?>
      $converterconversationNextSenderMessageId =
      const NullAwareTypeConverter.wrap(SenderMessageIdConverter());
  static TypeConverter<UnreadMessagesCount, int> $converterunreadMessagesCount =
      UnreadMessagesCountConverter();
  static TypeConverter<UtcDateTime?, int?> $converterisInFavorites =
      const NullAwareTypeConverter.wrap(UtcDateTimeConverter());
  static TypeConverter<UtcDateTime?, int?> $converterisInMatches =
      const NullAwareTypeConverter.wrap(UtcDateTimeConverter());
  static TypeConverter<UtcDateTime?, int?> $converterisInReceivedBlocks =
      const NullAwareTypeConverter.wrap(UtcDateTimeConverter());
  static TypeConverter<UtcDateTime?, int?> $converterisInReceivedLikes =
      const NullAwareTypeConverter.wrap(UtcDateTimeConverter());
  static TypeConverter<UtcDateTime?, int?> $converterisInSentBlocks =
      const NullAwareTypeConverter.wrap(UtcDateTimeConverter());
  static TypeConverter<UtcDateTime?, int?> $converterisInSentLikes =
      const NullAwareTypeConverter.wrap(UtcDateTimeConverter());
  static TypeConverter<UtcDateTime?, int?> $converterisInProfileGrid =
      const NullAwareTypeConverter.wrap(UtcDateTimeConverter());
}

class Profile extends DataClass implements Insertable<Profile> {
  final int id;
  final AccountId uuidAccountId;

  /// Primary content ID for the profile.
  final ContentId? uuidContentId0;
  final ContentId? uuidContentId1;
  final ContentId? uuidContentId2;
  final ContentId? uuidContentId3;
  final ContentId? uuidContentId4;
  final ContentId? uuidContentId5;
  final ProfileContentVersion? profileContentVersion;
  final String? profileName;
  final String? profileText;
  final ProfileVersion? profileVersion;
  final int? profileAge;
  final int? profileLastSeenTimeValue;
  final bool? profileUnlimitedLikes;
  final JsonList? jsonProfileAttributes;
  final double? primaryContentGridCropSize;
  final double? primaryContentGridCropX;
  final double? primaryContentGridCropY;
  final PublicKeyData? publicKeyData;
  final PublicKeyId? publicKeyId;
  final PublicKeyVersion? publicKeyVersion;
  final SenderMessageId? conversationNextSenderMessageId;
  final UnreadMessagesCount unreadMessagesCount;
  final UtcDateTime? isInFavorites;
  final UtcDateTime? isInMatches;
  final UtcDateTime? isInReceivedBlocks;
  final UtcDateTime? isInReceivedLikes;
  final UtcDateTime? isInSentBlocks;
  final UtcDateTime? isInSentLikes;
  final UtcDateTime? isInProfileGrid;
  const Profile(
      {required this.id,
      required this.uuidAccountId,
      this.uuidContentId0,
      this.uuidContentId1,
      this.uuidContentId2,
      this.uuidContentId3,
      this.uuidContentId4,
      this.uuidContentId5,
      this.profileContentVersion,
      this.profileName,
      this.profileText,
      this.profileVersion,
      this.profileAge,
      this.profileLastSeenTimeValue,
      this.profileUnlimitedLikes,
      this.jsonProfileAttributes,
      this.primaryContentGridCropSize,
      this.primaryContentGridCropX,
      this.primaryContentGridCropY,
      this.publicKeyData,
      this.publicKeyId,
      this.publicKeyVersion,
      this.conversationNextSenderMessageId,
      required this.unreadMessagesCount,
      this.isInFavorites,
      this.isInMatches,
      this.isInReceivedBlocks,
      this.isInReceivedLikes,
      this.isInSentBlocks,
      this.isInSentLikes,
      this.isInProfileGrid});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['uuid_account_id'] = Variable<String>(
          $ProfilesTable.$converteruuidAccountId.toSql(uuidAccountId));
    }
    if (!nullToAbsent || uuidContentId0 != null) {
      map['uuid_content_id0'] = Variable<String>(
          $ProfilesTable.$converteruuidContentId0.toSql(uuidContentId0));
    }
    if (!nullToAbsent || uuidContentId1 != null) {
      map['uuid_content_id1'] = Variable<String>(
          $ProfilesTable.$converteruuidContentId1.toSql(uuidContentId1));
    }
    if (!nullToAbsent || uuidContentId2 != null) {
      map['uuid_content_id2'] = Variable<String>(
          $ProfilesTable.$converteruuidContentId2.toSql(uuidContentId2));
    }
    if (!nullToAbsent || uuidContentId3 != null) {
      map['uuid_content_id3'] = Variable<String>(
          $ProfilesTable.$converteruuidContentId3.toSql(uuidContentId3));
    }
    if (!nullToAbsent || uuidContentId4 != null) {
      map['uuid_content_id4'] = Variable<String>(
          $ProfilesTable.$converteruuidContentId4.toSql(uuidContentId4));
    }
    if (!nullToAbsent || uuidContentId5 != null) {
      map['uuid_content_id5'] = Variable<String>(
          $ProfilesTable.$converteruuidContentId5.toSql(uuidContentId5));
    }
    if (!nullToAbsent || profileContentVersion != null) {
      map['profile_content_version'] = Variable<String>($ProfilesTable
          .$converterprofileContentVersion
          .toSql(profileContentVersion));
    }
    if (!nullToAbsent || profileName != null) {
      map['profile_name'] = Variable<String>(profileName);
    }
    if (!nullToAbsent || profileText != null) {
      map['profile_text'] = Variable<String>(profileText);
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
    if (!nullToAbsent || publicKeyData != null) {
      map['public_key_data'] = Variable<String>(
          $ProfilesTable.$converterpublicKeyData.toSql(publicKeyData));
    }
    if (!nullToAbsent || publicKeyId != null) {
      map['public_key_id'] = Variable<int>(
          $ProfilesTable.$converterpublicKeyId.toSql(publicKeyId));
    }
    if (!nullToAbsent || publicKeyVersion != null) {
      map['public_key_version'] = Variable<int>(
          $ProfilesTable.$converterpublicKeyVersion.toSql(publicKeyVersion));
    }
    if (!nullToAbsent || conversationNextSenderMessageId != null) {
      map['conversation_next_sender_message_id'] = Variable<int>($ProfilesTable
          .$converterconversationNextSenderMessageId
          .toSql(conversationNextSenderMessageId));
    }
    {
      map['unread_messages_count'] = Variable<int>($ProfilesTable
          .$converterunreadMessagesCount
          .toSql(unreadMessagesCount));
    }
    if (!nullToAbsent || isInFavorites != null) {
      map['is_in_favorites'] = Variable<int>(
          $ProfilesTable.$converterisInFavorites.toSql(isInFavorites));
    }
    if (!nullToAbsent || isInMatches != null) {
      map['is_in_matches'] = Variable<int>(
          $ProfilesTable.$converterisInMatches.toSql(isInMatches));
    }
    if (!nullToAbsent || isInReceivedBlocks != null) {
      map['is_in_received_blocks'] = Variable<int>($ProfilesTable
          .$converterisInReceivedBlocks
          .toSql(isInReceivedBlocks));
    }
    if (!nullToAbsent || isInReceivedLikes != null) {
      map['is_in_received_likes'] = Variable<int>(
          $ProfilesTable.$converterisInReceivedLikes.toSql(isInReceivedLikes));
    }
    if (!nullToAbsent || isInSentBlocks != null) {
      map['is_in_sent_blocks'] = Variable<int>(
          $ProfilesTable.$converterisInSentBlocks.toSql(isInSentBlocks));
    }
    if (!nullToAbsent || isInSentLikes != null) {
      map['is_in_sent_likes'] = Variable<int>(
          $ProfilesTable.$converterisInSentLikes.toSql(isInSentLikes));
    }
    if (!nullToAbsent || isInProfileGrid != null) {
      map['is_in_profile_grid'] = Variable<int>(
          $ProfilesTable.$converterisInProfileGrid.toSql(isInProfileGrid));
    }
    return map;
  }

  ProfilesCompanion toCompanion(bool nullToAbsent) {
    return ProfilesCompanion(
      id: Value(id),
      uuidAccountId: Value(uuidAccountId),
      uuidContentId0: uuidContentId0 == null && nullToAbsent
          ? const Value.absent()
          : Value(uuidContentId0),
      uuidContentId1: uuidContentId1 == null && nullToAbsent
          ? const Value.absent()
          : Value(uuidContentId1),
      uuidContentId2: uuidContentId2 == null && nullToAbsent
          ? const Value.absent()
          : Value(uuidContentId2),
      uuidContentId3: uuidContentId3 == null && nullToAbsent
          ? const Value.absent()
          : Value(uuidContentId3),
      uuidContentId4: uuidContentId4 == null && nullToAbsent
          ? const Value.absent()
          : Value(uuidContentId4),
      uuidContentId5: uuidContentId5 == null && nullToAbsent
          ? const Value.absent()
          : Value(uuidContentId5),
      profileContentVersion: profileContentVersion == null && nullToAbsent
          ? const Value.absent()
          : Value(profileContentVersion),
      profileName: profileName == null && nullToAbsent
          ? const Value.absent()
          : Value(profileName),
      profileText: profileText == null && nullToAbsent
          ? const Value.absent()
          : Value(profileText),
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
      publicKeyData: publicKeyData == null && nullToAbsent
          ? const Value.absent()
          : Value(publicKeyData),
      publicKeyId: publicKeyId == null && nullToAbsent
          ? const Value.absent()
          : Value(publicKeyId),
      publicKeyVersion: publicKeyVersion == null && nullToAbsent
          ? const Value.absent()
          : Value(publicKeyVersion),
      conversationNextSenderMessageId:
          conversationNextSenderMessageId == null && nullToAbsent
              ? const Value.absent()
              : Value(conversationNextSenderMessageId),
      unreadMessagesCount: Value(unreadMessagesCount),
      isInFavorites: isInFavorites == null && nullToAbsent
          ? const Value.absent()
          : Value(isInFavorites),
      isInMatches: isInMatches == null && nullToAbsent
          ? const Value.absent()
          : Value(isInMatches),
      isInReceivedBlocks: isInReceivedBlocks == null && nullToAbsent
          ? const Value.absent()
          : Value(isInReceivedBlocks),
      isInReceivedLikes: isInReceivedLikes == null && nullToAbsent
          ? const Value.absent()
          : Value(isInReceivedLikes),
      isInSentBlocks: isInSentBlocks == null && nullToAbsent
          ? const Value.absent()
          : Value(isInSentBlocks),
      isInSentLikes: isInSentLikes == null && nullToAbsent
          ? const Value.absent()
          : Value(isInSentLikes),
      isInProfileGrid: isInProfileGrid == null && nullToAbsent
          ? const Value.absent()
          : Value(isInProfileGrid),
    );
  }

  factory Profile.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Profile(
      id: serializer.fromJson<int>(json['id']),
      uuidAccountId: serializer.fromJson<AccountId>(json['uuidAccountId']),
      uuidContentId0: serializer.fromJson<ContentId?>(json['uuidContentId0']),
      uuidContentId1: serializer.fromJson<ContentId?>(json['uuidContentId1']),
      uuidContentId2: serializer.fromJson<ContentId?>(json['uuidContentId2']),
      uuidContentId3: serializer.fromJson<ContentId?>(json['uuidContentId3']),
      uuidContentId4: serializer.fromJson<ContentId?>(json['uuidContentId4']),
      uuidContentId5: serializer.fromJson<ContentId?>(json['uuidContentId5']),
      profileContentVersion: serializer
          .fromJson<ProfileContentVersion?>(json['profileContentVersion']),
      profileName: serializer.fromJson<String?>(json['profileName']),
      profileText: serializer.fromJson<String?>(json['profileText']),
      profileVersion:
          serializer.fromJson<ProfileVersion?>(json['profileVersion']),
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
      publicKeyData: serializer.fromJson<PublicKeyData?>(json['publicKeyData']),
      publicKeyId: serializer.fromJson<PublicKeyId?>(json['publicKeyId']),
      publicKeyVersion:
          serializer.fromJson<PublicKeyVersion?>(json['publicKeyVersion']),
      conversationNextSenderMessageId: serializer
          .fromJson<SenderMessageId?>(json['conversationNextSenderMessageId']),
      unreadMessagesCount:
          serializer.fromJson<UnreadMessagesCount>(json['unreadMessagesCount']),
      isInFavorites: serializer.fromJson<UtcDateTime?>(json['isInFavorites']),
      isInMatches: serializer.fromJson<UtcDateTime?>(json['isInMatches']),
      isInReceivedBlocks:
          serializer.fromJson<UtcDateTime?>(json['isInReceivedBlocks']),
      isInReceivedLikes:
          serializer.fromJson<UtcDateTime?>(json['isInReceivedLikes']),
      isInSentBlocks: serializer.fromJson<UtcDateTime?>(json['isInSentBlocks']),
      isInSentLikes: serializer.fromJson<UtcDateTime?>(json['isInSentLikes']),
      isInProfileGrid:
          serializer.fromJson<UtcDateTime?>(json['isInProfileGrid']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uuidAccountId': serializer.toJson<AccountId>(uuidAccountId),
      'uuidContentId0': serializer.toJson<ContentId?>(uuidContentId0),
      'uuidContentId1': serializer.toJson<ContentId?>(uuidContentId1),
      'uuidContentId2': serializer.toJson<ContentId?>(uuidContentId2),
      'uuidContentId3': serializer.toJson<ContentId?>(uuidContentId3),
      'uuidContentId4': serializer.toJson<ContentId?>(uuidContentId4),
      'uuidContentId5': serializer.toJson<ContentId?>(uuidContentId5),
      'profileContentVersion':
          serializer.toJson<ProfileContentVersion?>(profileContentVersion),
      'profileName': serializer.toJson<String?>(profileName),
      'profileText': serializer.toJson<String?>(profileText),
      'profileVersion': serializer.toJson<ProfileVersion?>(profileVersion),
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
      'publicKeyData': serializer.toJson<PublicKeyData?>(publicKeyData),
      'publicKeyId': serializer.toJson<PublicKeyId?>(publicKeyId),
      'publicKeyVersion':
          serializer.toJson<PublicKeyVersion?>(publicKeyVersion),
      'conversationNextSenderMessageId':
          serializer.toJson<SenderMessageId?>(conversationNextSenderMessageId),
      'unreadMessagesCount':
          serializer.toJson<UnreadMessagesCount>(unreadMessagesCount),
      'isInFavorites': serializer.toJson<UtcDateTime?>(isInFavorites),
      'isInMatches': serializer.toJson<UtcDateTime?>(isInMatches),
      'isInReceivedBlocks': serializer.toJson<UtcDateTime?>(isInReceivedBlocks),
      'isInReceivedLikes': serializer.toJson<UtcDateTime?>(isInReceivedLikes),
      'isInSentBlocks': serializer.toJson<UtcDateTime?>(isInSentBlocks),
      'isInSentLikes': serializer.toJson<UtcDateTime?>(isInSentLikes),
      'isInProfileGrid': serializer.toJson<UtcDateTime?>(isInProfileGrid),
    };
  }

  Profile copyWith(
          {int? id,
          AccountId? uuidAccountId,
          Value<ContentId?> uuidContentId0 = const Value.absent(),
          Value<ContentId?> uuidContentId1 = const Value.absent(),
          Value<ContentId?> uuidContentId2 = const Value.absent(),
          Value<ContentId?> uuidContentId3 = const Value.absent(),
          Value<ContentId?> uuidContentId4 = const Value.absent(),
          Value<ContentId?> uuidContentId5 = const Value.absent(),
          Value<ProfileContentVersion?> profileContentVersion =
              const Value.absent(),
          Value<String?> profileName = const Value.absent(),
          Value<String?> profileText = const Value.absent(),
          Value<ProfileVersion?> profileVersion = const Value.absent(),
          Value<int?> profileAge = const Value.absent(),
          Value<int?> profileLastSeenTimeValue = const Value.absent(),
          Value<bool?> profileUnlimitedLikes = const Value.absent(),
          Value<JsonList?> jsonProfileAttributes = const Value.absent(),
          Value<double?> primaryContentGridCropSize = const Value.absent(),
          Value<double?> primaryContentGridCropX = const Value.absent(),
          Value<double?> primaryContentGridCropY = const Value.absent(),
          Value<PublicKeyData?> publicKeyData = const Value.absent(),
          Value<PublicKeyId?> publicKeyId = const Value.absent(),
          Value<PublicKeyVersion?> publicKeyVersion = const Value.absent(),
          Value<SenderMessageId?> conversationNextSenderMessageId =
              const Value.absent(),
          UnreadMessagesCount? unreadMessagesCount,
          Value<UtcDateTime?> isInFavorites = const Value.absent(),
          Value<UtcDateTime?> isInMatches = const Value.absent(),
          Value<UtcDateTime?> isInReceivedBlocks = const Value.absent(),
          Value<UtcDateTime?> isInReceivedLikes = const Value.absent(),
          Value<UtcDateTime?> isInSentBlocks = const Value.absent(),
          Value<UtcDateTime?> isInSentLikes = const Value.absent(),
          Value<UtcDateTime?> isInProfileGrid = const Value.absent()}) =>
      Profile(
        id: id ?? this.id,
        uuidAccountId: uuidAccountId ?? this.uuidAccountId,
        uuidContentId0:
            uuidContentId0.present ? uuidContentId0.value : this.uuidContentId0,
        uuidContentId1:
            uuidContentId1.present ? uuidContentId1.value : this.uuidContentId1,
        uuidContentId2:
            uuidContentId2.present ? uuidContentId2.value : this.uuidContentId2,
        uuidContentId3:
            uuidContentId3.present ? uuidContentId3.value : this.uuidContentId3,
        uuidContentId4:
            uuidContentId4.present ? uuidContentId4.value : this.uuidContentId4,
        uuidContentId5:
            uuidContentId5.present ? uuidContentId5.value : this.uuidContentId5,
        profileContentVersion: profileContentVersion.present
            ? profileContentVersion.value
            : this.profileContentVersion,
        profileName: profileName.present ? profileName.value : this.profileName,
        profileText: profileText.present ? profileText.value : this.profileText,
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
        publicKeyData:
            publicKeyData.present ? publicKeyData.value : this.publicKeyData,
        publicKeyId: publicKeyId.present ? publicKeyId.value : this.publicKeyId,
        publicKeyVersion: publicKeyVersion.present
            ? publicKeyVersion.value
            : this.publicKeyVersion,
        conversationNextSenderMessageId: conversationNextSenderMessageId.present
            ? conversationNextSenderMessageId.value
            : this.conversationNextSenderMessageId,
        unreadMessagesCount: unreadMessagesCount ?? this.unreadMessagesCount,
        isInFavorites:
            isInFavorites.present ? isInFavorites.value : this.isInFavorites,
        isInMatches: isInMatches.present ? isInMatches.value : this.isInMatches,
        isInReceivedBlocks: isInReceivedBlocks.present
            ? isInReceivedBlocks.value
            : this.isInReceivedBlocks,
        isInReceivedLikes: isInReceivedLikes.present
            ? isInReceivedLikes.value
            : this.isInReceivedLikes,
        isInSentBlocks:
            isInSentBlocks.present ? isInSentBlocks.value : this.isInSentBlocks,
        isInSentLikes:
            isInSentLikes.present ? isInSentLikes.value : this.isInSentLikes,
        isInProfileGrid: isInProfileGrid.present
            ? isInProfileGrid.value
            : this.isInProfileGrid,
      );
  @override
  String toString() {
    return (StringBuffer('Profile(')
          ..write('id: $id, ')
          ..write('uuidAccountId: $uuidAccountId, ')
          ..write('uuidContentId0: $uuidContentId0, ')
          ..write('uuidContentId1: $uuidContentId1, ')
          ..write('uuidContentId2: $uuidContentId2, ')
          ..write('uuidContentId3: $uuidContentId3, ')
          ..write('uuidContentId4: $uuidContentId4, ')
          ..write('uuidContentId5: $uuidContentId5, ')
          ..write('profileContentVersion: $profileContentVersion, ')
          ..write('profileName: $profileName, ')
          ..write('profileText: $profileText, ')
          ..write('profileVersion: $profileVersion, ')
          ..write('profileAge: $profileAge, ')
          ..write('profileLastSeenTimeValue: $profileLastSeenTimeValue, ')
          ..write('profileUnlimitedLikes: $profileUnlimitedLikes, ')
          ..write('jsonProfileAttributes: $jsonProfileAttributes, ')
          ..write('primaryContentGridCropSize: $primaryContentGridCropSize, ')
          ..write('primaryContentGridCropX: $primaryContentGridCropX, ')
          ..write('primaryContentGridCropY: $primaryContentGridCropY, ')
          ..write('publicKeyData: $publicKeyData, ')
          ..write('publicKeyId: $publicKeyId, ')
          ..write('publicKeyVersion: $publicKeyVersion, ')
          ..write(
              'conversationNextSenderMessageId: $conversationNextSenderMessageId, ')
          ..write('unreadMessagesCount: $unreadMessagesCount, ')
          ..write('isInFavorites: $isInFavorites, ')
          ..write('isInMatches: $isInMatches, ')
          ..write('isInReceivedBlocks: $isInReceivedBlocks, ')
          ..write('isInReceivedLikes: $isInReceivedLikes, ')
          ..write('isInSentBlocks: $isInSentBlocks, ')
          ..write('isInSentLikes: $isInSentLikes, ')
          ..write('isInProfileGrid: $isInProfileGrid')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        id,
        uuidAccountId,
        uuidContentId0,
        uuidContentId1,
        uuidContentId2,
        uuidContentId3,
        uuidContentId4,
        uuidContentId5,
        profileContentVersion,
        profileName,
        profileText,
        profileVersion,
        profileAge,
        profileLastSeenTimeValue,
        profileUnlimitedLikes,
        jsonProfileAttributes,
        primaryContentGridCropSize,
        primaryContentGridCropX,
        primaryContentGridCropY,
        publicKeyData,
        publicKeyId,
        publicKeyVersion,
        conversationNextSenderMessageId,
        unreadMessagesCount,
        isInFavorites,
        isInMatches,
        isInReceivedBlocks,
        isInReceivedLikes,
        isInSentBlocks,
        isInSentLikes,
        isInProfileGrid
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Profile &&
          other.id == this.id &&
          other.uuidAccountId == this.uuidAccountId &&
          other.uuidContentId0 == this.uuidContentId0 &&
          other.uuidContentId1 == this.uuidContentId1 &&
          other.uuidContentId2 == this.uuidContentId2 &&
          other.uuidContentId3 == this.uuidContentId3 &&
          other.uuidContentId4 == this.uuidContentId4 &&
          other.uuidContentId5 == this.uuidContentId5 &&
          other.profileContentVersion == this.profileContentVersion &&
          other.profileName == this.profileName &&
          other.profileText == this.profileText &&
          other.profileVersion == this.profileVersion &&
          other.profileAge == this.profileAge &&
          other.profileLastSeenTimeValue == this.profileLastSeenTimeValue &&
          other.profileUnlimitedLikes == this.profileUnlimitedLikes &&
          other.jsonProfileAttributes == this.jsonProfileAttributes &&
          other.primaryContentGridCropSize == this.primaryContentGridCropSize &&
          other.primaryContentGridCropX == this.primaryContentGridCropX &&
          other.primaryContentGridCropY == this.primaryContentGridCropY &&
          other.publicKeyData == this.publicKeyData &&
          other.publicKeyId == this.publicKeyId &&
          other.publicKeyVersion == this.publicKeyVersion &&
          other.conversationNextSenderMessageId ==
              this.conversationNextSenderMessageId &&
          other.unreadMessagesCount == this.unreadMessagesCount &&
          other.isInFavorites == this.isInFavorites &&
          other.isInMatches == this.isInMatches &&
          other.isInReceivedBlocks == this.isInReceivedBlocks &&
          other.isInReceivedLikes == this.isInReceivedLikes &&
          other.isInSentBlocks == this.isInSentBlocks &&
          other.isInSentLikes == this.isInSentLikes &&
          other.isInProfileGrid == this.isInProfileGrid);
}

class ProfilesCompanion extends UpdateCompanion<Profile> {
  final Value<int> id;
  final Value<AccountId> uuidAccountId;
  final Value<ContentId?> uuidContentId0;
  final Value<ContentId?> uuidContentId1;
  final Value<ContentId?> uuidContentId2;
  final Value<ContentId?> uuidContentId3;
  final Value<ContentId?> uuidContentId4;
  final Value<ContentId?> uuidContentId5;
  final Value<ProfileContentVersion?> profileContentVersion;
  final Value<String?> profileName;
  final Value<String?> profileText;
  final Value<ProfileVersion?> profileVersion;
  final Value<int?> profileAge;
  final Value<int?> profileLastSeenTimeValue;
  final Value<bool?> profileUnlimitedLikes;
  final Value<JsonList?> jsonProfileAttributes;
  final Value<double?> primaryContentGridCropSize;
  final Value<double?> primaryContentGridCropX;
  final Value<double?> primaryContentGridCropY;
  final Value<PublicKeyData?> publicKeyData;
  final Value<PublicKeyId?> publicKeyId;
  final Value<PublicKeyVersion?> publicKeyVersion;
  final Value<SenderMessageId?> conversationNextSenderMessageId;
  final Value<UnreadMessagesCount> unreadMessagesCount;
  final Value<UtcDateTime?> isInFavorites;
  final Value<UtcDateTime?> isInMatches;
  final Value<UtcDateTime?> isInReceivedBlocks;
  final Value<UtcDateTime?> isInReceivedLikes;
  final Value<UtcDateTime?> isInSentBlocks;
  final Value<UtcDateTime?> isInSentLikes;
  final Value<UtcDateTime?> isInProfileGrid;
  const ProfilesCompanion({
    this.id = const Value.absent(),
    this.uuidAccountId = const Value.absent(),
    this.uuidContentId0 = const Value.absent(),
    this.uuidContentId1 = const Value.absent(),
    this.uuidContentId2 = const Value.absent(),
    this.uuidContentId3 = const Value.absent(),
    this.uuidContentId4 = const Value.absent(),
    this.uuidContentId5 = const Value.absent(),
    this.profileContentVersion = const Value.absent(),
    this.profileName = const Value.absent(),
    this.profileText = const Value.absent(),
    this.profileVersion = const Value.absent(),
    this.profileAge = const Value.absent(),
    this.profileLastSeenTimeValue = const Value.absent(),
    this.profileUnlimitedLikes = const Value.absent(),
    this.jsonProfileAttributes = const Value.absent(),
    this.primaryContentGridCropSize = const Value.absent(),
    this.primaryContentGridCropX = const Value.absent(),
    this.primaryContentGridCropY = const Value.absent(),
    this.publicKeyData = const Value.absent(),
    this.publicKeyId = const Value.absent(),
    this.publicKeyVersion = const Value.absent(),
    this.conversationNextSenderMessageId = const Value.absent(),
    this.unreadMessagesCount = const Value.absent(),
    this.isInFavorites = const Value.absent(),
    this.isInMatches = const Value.absent(),
    this.isInReceivedBlocks = const Value.absent(),
    this.isInReceivedLikes = const Value.absent(),
    this.isInSentBlocks = const Value.absent(),
    this.isInSentLikes = const Value.absent(),
    this.isInProfileGrid = const Value.absent(),
  });
  ProfilesCompanion.insert({
    this.id = const Value.absent(),
    required AccountId uuidAccountId,
    this.uuidContentId0 = const Value.absent(),
    this.uuidContentId1 = const Value.absent(),
    this.uuidContentId2 = const Value.absent(),
    this.uuidContentId3 = const Value.absent(),
    this.uuidContentId4 = const Value.absent(),
    this.uuidContentId5 = const Value.absent(),
    this.profileContentVersion = const Value.absent(),
    this.profileName = const Value.absent(),
    this.profileText = const Value.absent(),
    this.profileVersion = const Value.absent(),
    this.profileAge = const Value.absent(),
    this.profileLastSeenTimeValue = const Value.absent(),
    this.profileUnlimitedLikes = const Value.absent(),
    this.jsonProfileAttributes = const Value.absent(),
    this.primaryContentGridCropSize = const Value.absent(),
    this.primaryContentGridCropX = const Value.absent(),
    this.primaryContentGridCropY = const Value.absent(),
    this.publicKeyData = const Value.absent(),
    this.publicKeyId = const Value.absent(),
    this.publicKeyVersion = const Value.absent(),
    this.conversationNextSenderMessageId = const Value.absent(),
    this.unreadMessagesCount = const Value.absent(),
    this.isInFavorites = const Value.absent(),
    this.isInMatches = const Value.absent(),
    this.isInReceivedBlocks = const Value.absent(),
    this.isInReceivedLikes = const Value.absent(),
    this.isInSentBlocks = const Value.absent(),
    this.isInSentLikes = const Value.absent(),
    this.isInProfileGrid = const Value.absent(),
  }) : uuidAccountId = Value(uuidAccountId);
  static Insertable<Profile> custom({
    Expression<int>? id,
    Expression<String>? uuidAccountId,
    Expression<String>? uuidContentId0,
    Expression<String>? uuidContentId1,
    Expression<String>? uuidContentId2,
    Expression<String>? uuidContentId3,
    Expression<String>? uuidContentId4,
    Expression<String>? uuidContentId5,
    Expression<String>? profileContentVersion,
    Expression<String>? profileName,
    Expression<String>? profileText,
    Expression<String>? profileVersion,
    Expression<int>? profileAge,
    Expression<int>? profileLastSeenTimeValue,
    Expression<bool>? profileUnlimitedLikes,
    Expression<String>? jsonProfileAttributes,
    Expression<double>? primaryContentGridCropSize,
    Expression<double>? primaryContentGridCropX,
    Expression<double>? primaryContentGridCropY,
    Expression<String>? publicKeyData,
    Expression<int>? publicKeyId,
    Expression<int>? publicKeyVersion,
    Expression<int>? conversationNextSenderMessageId,
    Expression<int>? unreadMessagesCount,
    Expression<int>? isInFavorites,
    Expression<int>? isInMatches,
    Expression<int>? isInReceivedBlocks,
    Expression<int>? isInReceivedLikes,
    Expression<int>? isInSentBlocks,
    Expression<int>? isInSentLikes,
    Expression<int>? isInProfileGrid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuidAccountId != null) 'uuid_account_id': uuidAccountId,
      if (uuidContentId0 != null) 'uuid_content_id0': uuidContentId0,
      if (uuidContentId1 != null) 'uuid_content_id1': uuidContentId1,
      if (uuidContentId2 != null) 'uuid_content_id2': uuidContentId2,
      if (uuidContentId3 != null) 'uuid_content_id3': uuidContentId3,
      if (uuidContentId4 != null) 'uuid_content_id4': uuidContentId4,
      if (uuidContentId5 != null) 'uuid_content_id5': uuidContentId5,
      if (profileContentVersion != null)
        'profile_content_version': profileContentVersion,
      if (profileName != null) 'profile_name': profileName,
      if (profileText != null) 'profile_text': profileText,
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
      if (publicKeyData != null) 'public_key_data': publicKeyData,
      if (publicKeyId != null) 'public_key_id': publicKeyId,
      if (publicKeyVersion != null) 'public_key_version': publicKeyVersion,
      if (conversationNextSenderMessageId != null)
        'conversation_next_sender_message_id': conversationNextSenderMessageId,
      if (unreadMessagesCount != null)
        'unread_messages_count': unreadMessagesCount,
      if (isInFavorites != null) 'is_in_favorites': isInFavorites,
      if (isInMatches != null) 'is_in_matches': isInMatches,
      if (isInReceivedBlocks != null)
        'is_in_received_blocks': isInReceivedBlocks,
      if (isInReceivedLikes != null) 'is_in_received_likes': isInReceivedLikes,
      if (isInSentBlocks != null) 'is_in_sent_blocks': isInSentBlocks,
      if (isInSentLikes != null) 'is_in_sent_likes': isInSentLikes,
      if (isInProfileGrid != null) 'is_in_profile_grid': isInProfileGrid,
    });
  }

  ProfilesCompanion copyWith(
      {Value<int>? id,
      Value<AccountId>? uuidAccountId,
      Value<ContentId?>? uuidContentId0,
      Value<ContentId?>? uuidContentId1,
      Value<ContentId?>? uuidContentId2,
      Value<ContentId?>? uuidContentId3,
      Value<ContentId?>? uuidContentId4,
      Value<ContentId?>? uuidContentId5,
      Value<ProfileContentVersion?>? profileContentVersion,
      Value<String?>? profileName,
      Value<String?>? profileText,
      Value<ProfileVersion?>? profileVersion,
      Value<int?>? profileAge,
      Value<int?>? profileLastSeenTimeValue,
      Value<bool?>? profileUnlimitedLikes,
      Value<JsonList?>? jsonProfileAttributes,
      Value<double?>? primaryContentGridCropSize,
      Value<double?>? primaryContentGridCropX,
      Value<double?>? primaryContentGridCropY,
      Value<PublicKeyData?>? publicKeyData,
      Value<PublicKeyId?>? publicKeyId,
      Value<PublicKeyVersion?>? publicKeyVersion,
      Value<SenderMessageId?>? conversationNextSenderMessageId,
      Value<UnreadMessagesCount>? unreadMessagesCount,
      Value<UtcDateTime?>? isInFavorites,
      Value<UtcDateTime?>? isInMatches,
      Value<UtcDateTime?>? isInReceivedBlocks,
      Value<UtcDateTime?>? isInReceivedLikes,
      Value<UtcDateTime?>? isInSentBlocks,
      Value<UtcDateTime?>? isInSentLikes,
      Value<UtcDateTime?>? isInProfileGrid}) {
    return ProfilesCompanion(
      id: id ?? this.id,
      uuidAccountId: uuidAccountId ?? this.uuidAccountId,
      uuidContentId0: uuidContentId0 ?? this.uuidContentId0,
      uuidContentId1: uuidContentId1 ?? this.uuidContentId1,
      uuidContentId2: uuidContentId2 ?? this.uuidContentId2,
      uuidContentId3: uuidContentId3 ?? this.uuidContentId3,
      uuidContentId4: uuidContentId4 ?? this.uuidContentId4,
      uuidContentId5: uuidContentId5 ?? this.uuidContentId5,
      profileContentVersion:
          profileContentVersion ?? this.profileContentVersion,
      profileName: profileName ?? this.profileName,
      profileText: profileText ?? this.profileText,
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
      publicKeyData: publicKeyData ?? this.publicKeyData,
      publicKeyId: publicKeyId ?? this.publicKeyId,
      publicKeyVersion: publicKeyVersion ?? this.publicKeyVersion,
      conversationNextSenderMessageId: conversationNextSenderMessageId ??
          this.conversationNextSenderMessageId,
      unreadMessagesCount: unreadMessagesCount ?? this.unreadMessagesCount,
      isInFavorites: isInFavorites ?? this.isInFavorites,
      isInMatches: isInMatches ?? this.isInMatches,
      isInReceivedBlocks: isInReceivedBlocks ?? this.isInReceivedBlocks,
      isInReceivedLikes: isInReceivedLikes ?? this.isInReceivedLikes,
      isInSentBlocks: isInSentBlocks ?? this.isInSentBlocks,
      isInSentLikes: isInSentLikes ?? this.isInSentLikes,
      isInProfileGrid: isInProfileGrid ?? this.isInProfileGrid,
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
    if (uuidContentId0.present) {
      map['uuid_content_id0'] = Variable<String>(
          $ProfilesTable.$converteruuidContentId0.toSql(uuidContentId0.value));
    }
    if (uuidContentId1.present) {
      map['uuid_content_id1'] = Variable<String>(
          $ProfilesTable.$converteruuidContentId1.toSql(uuidContentId1.value));
    }
    if (uuidContentId2.present) {
      map['uuid_content_id2'] = Variable<String>(
          $ProfilesTable.$converteruuidContentId2.toSql(uuidContentId2.value));
    }
    if (uuidContentId3.present) {
      map['uuid_content_id3'] = Variable<String>(
          $ProfilesTable.$converteruuidContentId3.toSql(uuidContentId3.value));
    }
    if (uuidContentId4.present) {
      map['uuid_content_id4'] = Variable<String>(
          $ProfilesTable.$converteruuidContentId4.toSql(uuidContentId4.value));
    }
    if (uuidContentId5.present) {
      map['uuid_content_id5'] = Variable<String>(
          $ProfilesTable.$converteruuidContentId5.toSql(uuidContentId5.value));
    }
    if (profileContentVersion.present) {
      map['profile_content_version'] = Variable<String>($ProfilesTable
          .$converterprofileContentVersion
          .toSql(profileContentVersion.value));
    }
    if (profileName.present) {
      map['profile_name'] = Variable<String>(profileName.value);
    }
    if (profileText.present) {
      map['profile_text'] = Variable<String>(profileText.value);
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
    if (publicKeyData.present) {
      map['public_key_data'] = Variable<String>(
          $ProfilesTable.$converterpublicKeyData.toSql(publicKeyData.value));
    }
    if (publicKeyId.present) {
      map['public_key_id'] = Variable<int>(
          $ProfilesTable.$converterpublicKeyId.toSql(publicKeyId.value));
    }
    if (publicKeyVersion.present) {
      map['public_key_version'] = Variable<int>($ProfilesTable
          .$converterpublicKeyVersion
          .toSql(publicKeyVersion.value));
    }
    if (conversationNextSenderMessageId.present) {
      map['conversation_next_sender_message_id'] = Variable<int>($ProfilesTable
          .$converterconversationNextSenderMessageId
          .toSql(conversationNextSenderMessageId.value));
    }
    if (unreadMessagesCount.present) {
      map['unread_messages_count'] = Variable<int>($ProfilesTable
          .$converterunreadMessagesCount
          .toSql(unreadMessagesCount.value));
    }
    if (isInFavorites.present) {
      map['is_in_favorites'] = Variable<int>(
          $ProfilesTable.$converterisInFavorites.toSql(isInFavorites.value));
    }
    if (isInMatches.present) {
      map['is_in_matches'] = Variable<int>(
          $ProfilesTable.$converterisInMatches.toSql(isInMatches.value));
    }
    if (isInReceivedBlocks.present) {
      map['is_in_received_blocks'] = Variable<int>($ProfilesTable
          .$converterisInReceivedBlocks
          .toSql(isInReceivedBlocks.value));
    }
    if (isInReceivedLikes.present) {
      map['is_in_received_likes'] = Variable<int>($ProfilesTable
          .$converterisInReceivedLikes
          .toSql(isInReceivedLikes.value));
    }
    if (isInSentBlocks.present) {
      map['is_in_sent_blocks'] = Variable<int>(
          $ProfilesTable.$converterisInSentBlocks.toSql(isInSentBlocks.value));
    }
    if (isInSentLikes.present) {
      map['is_in_sent_likes'] = Variable<int>(
          $ProfilesTable.$converterisInSentLikes.toSql(isInSentLikes.value));
    }
    if (isInProfileGrid.present) {
      map['is_in_profile_grid'] = Variable<int>($ProfilesTable
          .$converterisInProfileGrid
          .toSql(isInProfileGrid.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProfilesCompanion(')
          ..write('id: $id, ')
          ..write('uuidAccountId: $uuidAccountId, ')
          ..write('uuidContentId0: $uuidContentId0, ')
          ..write('uuidContentId1: $uuidContentId1, ')
          ..write('uuidContentId2: $uuidContentId2, ')
          ..write('uuidContentId3: $uuidContentId3, ')
          ..write('uuidContentId4: $uuidContentId4, ')
          ..write('uuidContentId5: $uuidContentId5, ')
          ..write('profileContentVersion: $profileContentVersion, ')
          ..write('profileName: $profileName, ')
          ..write('profileText: $profileText, ')
          ..write('profileVersion: $profileVersion, ')
          ..write('profileAge: $profileAge, ')
          ..write('profileLastSeenTimeValue: $profileLastSeenTimeValue, ')
          ..write('profileUnlimitedLikes: $profileUnlimitedLikes, ')
          ..write('jsonProfileAttributes: $jsonProfileAttributes, ')
          ..write('primaryContentGridCropSize: $primaryContentGridCropSize, ')
          ..write('primaryContentGridCropX: $primaryContentGridCropX, ')
          ..write('primaryContentGridCropY: $primaryContentGridCropY, ')
          ..write('publicKeyData: $publicKeyData, ')
          ..write('publicKeyId: $publicKeyId, ')
          ..write('publicKeyVersion: $publicKeyVersion, ')
          ..write(
              'conversationNextSenderMessageId: $conversationNextSenderMessageId, ')
          ..write('unreadMessagesCount: $unreadMessagesCount, ')
          ..write('isInFavorites: $isInFavorites, ')
          ..write('isInMatches: $isInMatches, ')
          ..write('isInReceivedBlocks: $isInReceivedBlocks, ')
          ..write('isInReceivedLikes: $isInReceivedLikes, ')
          ..write('isInSentBlocks: $isInSentBlocks, ')
          ..write('isInSentLikes: $isInSentLikes, ')
          ..write('isInProfileGrid: $isInProfileGrid')
          ..write(')'))
        .toString();
  }
}

class $MessagesTable extends Messages with TableInfo<$MessagesTable, Message> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MessagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _uuidLocalAccountIdMeta =
      const VerificationMeta('uuidLocalAccountId');
  @override
  late final GeneratedColumnWithTypeConverter<AccountId, String>
      uuidLocalAccountId = GeneratedColumn<String>(
              'uuid_local_account_id', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<AccountId>(
              $MessagesTable.$converteruuidLocalAccountId);
  static const VerificationMeta _uuidRemoteAccountIdMeta =
      const VerificationMeta('uuidRemoteAccountId');
  @override
  late final GeneratedColumnWithTypeConverter<AccountId, String>
      uuidRemoteAccountId = GeneratedColumn<String>(
              'uuid_remote_account_id', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<AccountId>(
              $MessagesTable.$converteruuidRemoteAccountId);
  static const VerificationMeta _messageTextMeta =
      const VerificationMeta('messageText');
  @override
  late final GeneratedColumn<String> messageText = GeneratedColumn<String>(
      'message_text', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _localUnixTimeMeta =
      const VerificationMeta('localUnixTime');
  @override
  late final GeneratedColumnWithTypeConverter<UtcDateTime, int> localUnixTime =
      GeneratedColumn<int>('local_unix_time', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<UtcDateTime>($MessagesTable.$converterlocalUnixTime);
  static const VerificationMeta _sentMessageStateMeta =
      const VerificationMeta('sentMessageState');
  @override
  late final GeneratedColumn<int> sentMessageState = GeneratedColumn<int>(
      'sent_message_state', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _receivedMessageStateMeta =
      const VerificationMeta('receivedMessageState');
  @override
  late final GeneratedColumn<int> receivedMessageState = GeneratedColumn<int>(
      'received_message_state', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _senderMessageIdMeta =
      const VerificationMeta('senderMessageId');
  @override
  late final GeneratedColumnWithTypeConverter<SenderMessageId?, int>
      senderMessageId = GeneratedColumn<int>(
              'sender_message_id', aliasedName, true,
              type: DriftSqlType.int, requiredDuringInsert: false)
          .withConverter<SenderMessageId?>(
              $MessagesTable.$convertersenderMessageId);
  static const VerificationMeta _messageNumberMeta =
      const VerificationMeta('messageNumber');
  @override
  late final GeneratedColumnWithTypeConverter<MessageNumber?, int>
      messageNumber = GeneratedColumn<int>('message_number', aliasedName, true,
              type: DriftSqlType.int, requiredDuringInsert: false)
          .withConverter<MessageNumber?>(
              $MessagesTable.$convertermessageNumber);
  static const VerificationMeta _unixTimeMeta =
      const VerificationMeta('unixTime');
  @override
  late final GeneratedColumnWithTypeConverter<UtcDateTime?, int> unixTime =
      GeneratedColumn<int>('unix_time', aliasedName, true,
              type: DriftSqlType.int, requiredDuringInsert: false)
          .withConverter<UtcDateTime?>($MessagesTable.$converterunixTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        uuidLocalAccountId,
        uuidRemoteAccountId,
        messageText,
        localUnixTime,
        sentMessageState,
        receivedMessageState,
        senderMessageId,
        messageNumber,
        unixTime
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'messages';
  @override
  VerificationContext validateIntegrity(Insertable<Message> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    context.handle(_uuidLocalAccountIdMeta, const VerificationResult.success());
    context.handle(
        _uuidRemoteAccountIdMeta, const VerificationResult.success());
    if (data.containsKey('message_text')) {
      context.handle(
          _messageTextMeta,
          messageText.isAcceptableOrUnknown(
              data['message_text']!, _messageTextMeta));
    } else if (isInserting) {
      context.missing(_messageTextMeta);
    }
    context.handle(_localUnixTimeMeta, const VerificationResult.success());
    if (data.containsKey('sent_message_state')) {
      context.handle(
          _sentMessageStateMeta,
          sentMessageState.isAcceptableOrUnknown(
              data['sent_message_state']!, _sentMessageStateMeta));
    }
    if (data.containsKey('received_message_state')) {
      context.handle(
          _receivedMessageStateMeta,
          receivedMessageState.isAcceptableOrUnknown(
              data['received_message_state']!, _receivedMessageStateMeta));
    }
    context.handle(_senderMessageIdMeta, const VerificationResult.success());
    context.handle(_messageNumberMeta, const VerificationResult.success());
    context.handle(_unixTimeMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Message map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Message(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      uuidLocalAccountId: $MessagesTable.$converteruuidLocalAccountId.fromSql(
          attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}uuid_local_account_id'])!),
      uuidRemoteAccountId: $MessagesTable.$converteruuidRemoteAccountId.fromSql(
          attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}uuid_remote_account_id'])!),
      messageText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}message_text'])!,
      localUnixTime: $MessagesTable.$converterlocalUnixTime.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.int, data['${effectivePrefix}local_unix_time'])!),
      sentMessageState: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sent_message_state']),
      receivedMessageState: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}received_message_state']),
      senderMessageId: $MessagesTable.$convertersenderMessageId.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.int, data['${effectivePrefix}sender_message_id'])),
      messageNumber: $MessagesTable.$convertermessageNumber.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.int, data['${effectivePrefix}message_number'])),
      unixTime: $MessagesTable.$converterunixTime.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}unix_time'])),
    );
  }

  @override
  $MessagesTable createAlias(String alias) {
    return $MessagesTable(attachedDatabase, alias);
  }

  static TypeConverter<AccountId, String> $converteruuidLocalAccountId =
      const AccountIdConverter();
  static TypeConverter<AccountId, String> $converteruuidRemoteAccountId =
      const AccountIdConverter();
  static TypeConverter<UtcDateTime, int> $converterlocalUnixTime =
      const UtcDateTimeConverter();
  static TypeConverter<SenderMessageId?, int?> $convertersenderMessageId =
      const NullAwareTypeConverter.wrap(SenderMessageIdConverter());
  static TypeConverter<MessageNumber?, int?> $convertermessageNumber =
      const NullAwareTypeConverter.wrap(MessageNumberConverter());
  static TypeConverter<UtcDateTime?, int?> $converterunixTime =
      const NullAwareTypeConverter.wrap(UtcDateTimeConverter());
}

class Message extends DataClass implements Insertable<Message> {
  final int id;
  final AccountId uuidLocalAccountId;
  final AccountId uuidRemoteAccountId;
  final String messageText;
  final UtcDateTime localUnixTime;
  final int? sentMessageState;
  final int? receivedMessageState;
  final SenderMessageId? senderMessageId;
  final MessageNumber? messageNumber;
  final UtcDateTime? unixTime;
  const Message(
      {required this.id,
      required this.uuidLocalAccountId,
      required this.uuidRemoteAccountId,
      required this.messageText,
      required this.localUnixTime,
      this.sentMessageState,
      this.receivedMessageState,
      this.senderMessageId,
      this.messageNumber,
      this.unixTime});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['uuid_local_account_id'] = Variable<String>($MessagesTable
          .$converteruuidLocalAccountId
          .toSql(uuidLocalAccountId));
    }
    {
      map['uuid_remote_account_id'] = Variable<String>($MessagesTable
          .$converteruuidRemoteAccountId
          .toSql(uuidRemoteAccountId));
    }
    map['message_text'] = Variable<String>(messageText);
    {
      map['local_unix_time'] = Variable<int>(
          $MessagesTable.$converterlocalUnixTime.toSql(localUnixTime));
    }
    if (!nullToAbsent || sentMessageState != null) {
      map['sent_message_state'] = Variable<int>(sentMessageState);
    }
    if (!nullToAbsent || receivedMessageState != null) {
      map['received_message_state'] = Variable<int>(receivedMessageState);
    }
    if (!nullToAbsent || senderMessageId != null) {
      map['sender_message_id'] = Variable<int>(
          $MessagesTable.$convertersenderMessageId.toSql(senderMessageId));
    }
    if (!nullToAbsent || messageNumber != null) {
      map['message_number'] = Variable<int>(
          $MessagesTable.$convertermessageNumber.toSql(messageNumber));
    }
    if (!nullToAbsent || unixTime != null) {
      map['unix_time'] =
          Variable<int>($MessagesTable.$converterunixTime.toSql(unixTime));
    }
    return map;
  }

  MessagesCompanion toCompanion(bool nullToAbsent) {
    return MessagesCompanion(
      id: Value(id),
      uuidLocalAccountId: Value(uuidLocalAccountId),
      uuidRemoteAccountId: Value(uuidRemoteAccountId),
      messageText: Value(messageText),
      localUnixTime: Value(localUnixTime),
      sentMessageState: sentMessageState == null && nullToAbsent
          ? const Value.absent()
          : Value(sentMessageState),
      receivedMessageState: receivedMessageState == null && nullToAbsent
          ? const Value.absent()
          : Value(receivedMessageState),
      senderMessageId: senderMessageId == null && nullToAbsent
          ? const Value.absent()
          : Value(senderMessageId),
      messageNumber: messageNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(messageNumber),
      unixTime: unixTime == null && nullToAbsent
          ? const Value.absent()
          : Value(unixTime),
    );
  }

  factory Message.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Message(
      id: serializer.fromJson<int>(json['id']),
      uuidLocalAccountId:
          serializer.fromJson<AccountId>(json['uuidLocalAccountId']),
      uuidRemoteAccountId:
          serializer.fromJson<AccountId>(json['uuidRemoteAccountId']),
      messageText: serializer.fromJson<String>(json['messageText']),
      localUnixTime: serializer.fromJson<UtcDateTime>(json['localUnixTime']),
      sentMessageState: serializer.fromJson<int?>(json['sentMessageState']),
      receivedMessageState:
          serializer.fromJson<int?>(json['receivedMessageState']),
      senderMessageId:
          serializer.fromJson<SenderMessageId?>(json['senderMessageId']),
      messageNumber: serializer.fromJson<MessageNumber?>(json['messageNumber']),
      unixTime: serializer.fromJson<UtcDateTime?>(json['unixTime']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uuidLocalAccountId': serializer.toJson<AccountId>(uuidLocalAccountId),
      'uuidRemoteAccountId': serializer.toJson<AccountId>(uuidRemoteAccountId),
      'messageText': serializer.toJson<String>(messageText),
      'localUnixTime': serializer.toJson<UtcDateTime>(localUnixTime),
      'sentMessageState': serializer.toJson<int?>(sentMessageState),
      'receivedMessageState': serializer.toJson<int?>(receivedMessageState),
      'senderMessageId': serializer.toJson<SenderMessageId?>(senderMessageId),
      'messageNumber': serializer.toJson<MessageNumber?>(messageNumber),
      'unixTime': serializer.toJson<UtcDateTime?>(unixTime),
    };
  }

  Message copyWith(
          {int? id,
          AccountId? uuidLocalAccountId,
          AccountId? uuidRemoteAccountId,
          String? messageText,
          UtcDateTime? localUnixTime,
          Value<int?> sentMessageState = const Value.absent(),
          Value<int?> receivedMessageState = const Value.absent(),
          Value<SenderMessageId?> senderMessageId = const Value.absent(),
          Value<MessageNumber?> messageNumber = const Value.absent(),
          Value<UtcDateTime?> unixTime = const Value.absent()}) =>
      Message(
        id: id ?? this.id,
        uuidLocalAccountId: uuidLocalAccountId ?? this.uuidLocalAccountId,
        uuidRemoteAccountId: uuidRemoteAccountId ?? this.uuidRemoteAccountId,
        messageText: messageText ?? this.messageText,
        localUnixTime: localUnixTime ?? this.localUnixTime,
        sentMessageState: sentMessageState.present
            ? sentMessageState.value
            : this.sentMessageState,
        receivedMessageState: receivedMessageState.present
            ? receivedMessageState.value
            : this.receivedMessageState,
        senderMessageId: senderMessageId.present
            ? senderMessageId.value
            : this.senderMessageId,
        messageNumber:
            messageNumber.present ? messageNumber.value : this.messageNumber,
        unixTime: unixTime.present ? unixTime.value : this.unixTime,
      );
  @override
  String toString() {
    return (StringBuffer('Message(')
          ..write('id: $id, ')
          ..write('uuidLocalAccountId: $uuidLocalAccountId, ')
          ..write('uuidRemoteAccountId: $uuidRemoteAccountId, ')
          ..write('messageText: $messageText, ')
          ..write('localUnixTime: $localUnixTime, ')
          ..write('sentMessageState: $sentMessageState, ')
          ..write('receivedMessageState: $receivedMessageState, ')
          ..write('senderMessageId: $senderMessageId, ')
          ..write('messageNumber: $messageNumber, ')
          ..write('unixTime: $unixTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      uuidLocalAccountId,
      uuidRemoteAccountId,
      messageText,
      localUnixTime,
      sentMessageState,
      receivedMessageState,
      senderMessageId,
      messageNumber,
      unixTime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Message &&
          other.id == this.id &&
          other.uuidLocalAccountId == this.uuidLocalAccountId &&
          other.uuidRemoteAccountId == this.uuidRemoteAccountId &&
          other.messageText == this.messageText &&
          other.localUnixTime == this.localUnixTime &&
          other.sentMessageState == this.sentMessageState &&
          other.receivedMessageState == this.receivedMessageState &&
          other.senderMessageId == this.senderMessageId &&
          other.messageNumber == this.messageNumber &&
          other.unixTime == this.unixTime);
}

class MessagesCompanion extends UpdateCompanion<Message> {
  final Value<int> id;
  final Value<AccountId> uuidLocalAccountId;
  final Value<AccountId> uuidRemoteAccountId;
  final Value<String> messageText;
  final Value<UtcDateTime> localUnixTime;
  final Value<int?> sentMessageState;
  final Value<int?> receivedMessageState;
  final Value<SenderMessageId?> senderMessageId;
  final Value<MessageNumber?> messageNumber;
  final Value<UtcDateTime?> unixTime;
  const MessagesCompanion({
    this.id = const Value.absent(),
    this.uuidLocalAccountId = const Value.absent(),
    this.uuidRemoteAccountId = const Value.absent(),
    this.messageText = const Value.absent(),
    this.localUnixTime = const Value.absent(),
    this.sentMessageState = const Value.absent(),
    this.receivedMessageState = const Value.absent(),
    this.senderMessageId = const Value.absent(),
    this.messageNumber = const Value.absent(),
    this.unixTime = const Value.absent(),
  });
  MessagesCompanion.insert({
    this.id = const Value.absent(),
    required AccountId uuidLocalAccountId,
    required AccountId uuidRemoteAccountId,
    required String messageText,
    required UtcDateTime localUnixTime,
    this.sentMessageState = const Value.absent(),
    this.receivedMessageState = const Value.absent(),
    this.senderMessageId = const Value.absent(),
    this.messageNumber = const Value.absent(),
    this.unixTime = const Value.absent(),
  })  : uuidLocalAccountId = Value(uuidLocalAccountId),
        uuidRemoteAccountId = Value(uuidRemoteAccountId),
        messageText = Value(messageText),
        localUnixTime = Value(localUnixTime);
  static Insertable<Message> custom({
    Expression<int>? id,
    Expression<String>? uuidLocalAccountId,
    Expression<String>? uuidRemoteAccountId,
    Expression<String>? messageText,
    Expression<int>? localUnixTime,
    Expression<int>? sentMessageState,
    Expression<int>? receivedMessageState,
    Expression<int>? senderMessageId,
    Expression<int>? messageNumber,
    Expression<int>? unixTime,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuidLocalAccountId != null)
        'uuid_local_account_id': uuidLocalAccountId,
      if (uuidRemoteAccountId != null)
        'uuid_remote_account_id': uuidRemoteAccountId,
      if (messageText != null) 'message_text': messageText,
      if (localUnixTime != null) 'local_unix_time': localUnixTime,
      if (sentMessageState != null) 'sent_message_state': sentMessageState,
      if (receivedMessageState != null)
        'received_message_state': receivedMessageState,
      if (senderMessageId != null) 'sender_message_id': senderMessageId,
      if (messageNumber != null) 'message_number': messageNumber,
      if (unixTime != null) 'unix_time': unixTime,
    });
  }

  MessagesCompanion copyWith(
      {Value<int>? id,
      Value<AccountId>? uuidLocalAccountId,
      Value<AccountId>? uuidRemoteAccountId,
      Value<String>? messageText,
      Value<UtcDateTime>? localUnixTime,
      Value<int?>? sentMessageState,
      Value<int?>? receivedMessageState,
      Value<SenderMessageId?>? senderMessageId,
      Value<MessageNumber?>? messageNumber,
      Value<UtcDateTime?>? unixTime}) {
    return MessagesCompanion(
      id: id ?? this.id,
      uuidLocalAccountId: uuidLocalAccountId ?? this.uuidLocalAccountId,
      uuidRemoteAccountId: uuidRemoteAccountId ?? this.uuidRemoteAccountId,
      messageText: messageText ?? this.messageText,
      localUnixTime: localUnixTime ?? this.localUnixTime,
      sentMessageState: sentMessageState ?? this.sentMessageState,
      receivedMessageState: receivedMessageState ?? this.receivedMessageState,
      senderMessageId: senderMessageId ?? this.senderMessageId,
      messageNumber: messageNumber ?? this.messageNumber,
      unixTime: unixTime ?? this.unixTime,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uuidLocalAccountId.present) {
      map['uuid_local_account_id'] = Variable<String>($MessagesTable
          .$converteruuidLocalAccountId
          .toSql(uuidLocalAccountId.value));
    }
    if (uuidRemoteAccountId.present) {
      map['uuid_remote_account_id'] = Variable<String>($MessagesTable
          .$converteruuidRemoteAccountId
          .toSql(uuidRemoteAccountId.value));
    }
    if (messageText.present) {
      map['message_text'] = Variable<String>(messageText.value);
    }
    if (localUnixTime.present) {
      map['local_unix_time'] = Variable<int>(
          $MessagesTable.$converterlocalUnixTime.toSql(localUnixTime.value));
    }
    if (sentMessageState.present) {
      map['sent_message_state'] = Variable<int>(sentMessageState.value);
    }
    if (receivedMessageState.present) {
      map['received_message_state'] = Variable<int>(receivedMessageState.value);
    }
    if (senderMessageId.present) {
      map['sender_message_id'] = Variable<int>($MessagesTable
          .$convertersenderMessageId
          .toSql(senderMessageId.value));
    }
    if (messageNumber.present) {
      map['message_number'] = Variable<int>(
          $MessagesTable.$convertermessageNumber.toSql(messageNumber.value));
    }
    if (unixTime.present) {
      map['unix_time'] = Variable<int>(
          $MessagesTable.$converterunixTime.toSql(unixTime.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MessagesCompanion(')
          ..write('id: $id, ')
          ..write('uuidLocalAccountId: $uuidLocalAccountId, ')
          ..write('uuidRemoteAccountId: $uuidRemoteAccountId, ')
          ..write('messageText: $messageText, ')
          ..write('localUnixTime: $localUnixTime, ')
          ..write('sentMessageState: $sentMessageState, ')
          ..write('receivedMessageState: $receivedMessageState, ')
          ..write('senderMessageId: $senderMessageId, ')
          ..write('messageNumber: $messageNumber, ')
          ..write('unixTime: $unixTime')
          ..write(')'))
        .toString();
  }
}

abstract class _$AccountDatabase extends GeneratedDatabase {
  _$AccountDatabase(QueryExecutor e) : super(e);
  late final $AccountTable account = $AccountTable(this);
  late final $ProfilesTable profiles = $ProfilesTable(this);
  late final $MessagesTable messages = $MessagesTable(this);
  late final DaoCurrentContent daoCurrentContent =
      DaoCurrentContent(this as AccountDatabase);
  late final DaoPendingContent daoPendingContent =
      DaoPendingContent(this as AccountDatabase);
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
  late final DaoMessages daoMessages = DaoMessages(this as AccountDatabase);
  late final DaoProfiles daoProfiles = DaoProfiles(this as AccountDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [account, profiles, messages];
}
