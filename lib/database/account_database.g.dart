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
  static const VerificationMeta _jsonProfileVisibilityMeta =
      const VerificationMeta('jsonProfileVisibility');
  @override
  late final GeneratedColumnWithTypeConverter<EnumString?, String>
      jsonProfileVisibility = GeneratedColumn<String>(
              'json_profile_visibility', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<EnumString?>(
              $AccountTable.$converterjsonProfileVisibility);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        refreshTokenAccount,
        refreshTokenMedia,
        refreshTokenProfile,
        refreshTokenChat,
        accessTokenAccount,
        accessTokenMedia,
        accessTokenProfile,
        accessTokenChat,
        profileFilterFavorites,
        profileLocationLatitude,
        profileLocationLongitude,
        jsonAccountState,
        jsonCapabilities,
        jsonAvailableProfileAttributes,
        jsonProfileVisibility
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
    if (data.containsKey('profile_filter_favorites')) {
      context.handle(
          _profileFilterFavoritesMeta,
          profileFilterFavorites.isAcceptableOrUnknown(
              data['profile_filter_favorites']!, _profileFilterFavoritesMeta));
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
    context.handle(_jsonAccountStateMeta, const VerificationResult.success());
    context.handle(_jsonCapabilitiesMeta, const VerificationResult.success());
    context.handle(_jsonAvailableProfileAttributesMeta,
        const VerificationResult.success());
    context.handle(
        _jsonProfileVisibilityMeta, const VerificationResult.success());
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
      profileFilterFavorites: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}profile_filter_favorites'])!,
      profileLocationLatitude: attachedDatabase.typeMapping.read(
          DriftSqlType.double,
          data['${effectivePrefix}profile_location_latitude']),
      profileLocationLongitude: attachedDatabase.typeMapping.read(
          DriftSqlType.double,
          data['${effectivePrefix}profile_location_longitude']),
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
      jsonProfileVisibility: $AccountTable.$converterjsonProfileVisibility
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}json_profile_visibility'])),
    );
  }

  @override
  $AccountTable createAlias(String alias) {
    return $AccountTable(attachedDatabase, alias);
  }

  static TypeConverter<EnumString?, String?> $converterjsonAccountState =
      NullAwareTypeConverter.wrap(EnumString.driftConverter);
  static TypeConverter<JsonString?, String?> $converterjsonCapabilities =
      NullAwareTypeConverter.wrap(JsonString.driftConverter);
  static TypeConverter<JsonString?, String?>
      $converterjsonAvailableProfileAttributes =
      NullAwareTypeConverter.wrap(JsonString.driftConverter);
  static TypeConverter<EnumString?, String?> $converterjsonProfileVisibility =
      NullAwareTypeConverter.wrap(EnumString.driftConverter);
}

class AccountData extends DataClass implements Insertable<AccountData> {
  final int id;
  final String? refreshTokenAccount;
  final String? refreshTokenMedia;
  final String? refreshTokenProfile;
  final String? refreshTokenChat;
  final String? accessTokenAccount;
  final String? accessTokenMedia;
  final String? accessTokenProfile;
  final String? accessTokenChat;

  /// If true show only favorite profiles
  final bool profileFilterFavorites;
  final double? profileLocationLatitude;
  final double? profileLocationLongitude;
  final EnumString? jsonAccountState;
  final JsonString? jsonCapabilities;
  final JsonString? jsonAvailableProfileAttributes;
  final EnumString? jsonProfileVisibility;
  const AccountData(
      {required this.id,
      this.refreshTokenAccount,
      this.refreshTokenMedia,
      this.refreshTokenProfile,
      this.refreshTokenChat,
      this.accessTokenAccount,
      this.accessTokenMedia,
      this.accessTokenProfile,
      this.accessTokenChat,
      required this.profileFilterFavorites,
      this.profileLocationLatitude,
      this.profileLocationLongitude,
      this.jsonAccountState,
      this.jsonCapabilities,
      this.jsonAvailableProfileAttributes,
      this.jsonProfileVisibility});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
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
    map['profile_filter_favorites'] = Variable<bool>(profileFilterFavorites);
    if (!nullToAbsent || profileLocationLatitude != null) {
      map['profile_location_latitude'] =
          Variable<double>(profileLocationLatitude);
    }
    if (!nullToAbsent || profileLocationLongitude != null) {
      map['profile_location_longitude'] =
          Variable<double>(profileLocationLongitude);
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
    if (!nullToAbsent || jsonProfileVisibility != null) {
      map['json_profile_visibility'] = Variable<String>($AccountTable
          .$converterjsonProfileVisibility
          .toSql(jsonProfileVisibility));
    }
    return map;
  }

  AccountCompanion toCompanion(bool nullToAbsent) {
    return AccountCompanion(
      id: Value(id),
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
      profileFilterFavorites: Value(profileFilterFavorites),
      profileLocationLatitude: profileLocationLatitude == null && nullToAbsent
          ? const Value.absent()
          : Value(profileLocationLatitude),
      profileLocationLongitude: profileLocationLongitude == null && nullToAbsent
          ? const Value.absent()
          : Value(profileLocationLongitude),
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
      jsonProfileVisibility: jsonProfileVisibility == null && nullToAbsent
          ? const Value.absent()
          : Value(jsonProfileVisibility),
    );
  }

  factory AccountData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AccountData(
      id: serializer.fromJson<int>(json['id']),
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
      profileFilterFavorites:
          serializer.fromJson<bool>(json['profileFilterFavorites']),
      profileLocationLatitude:
          serializer.fromJson<double?>(json['profileLocationLatitude']),
      profileLocationLongitude:
          serializer.fromJson<double?>(json['profileLocationLongitude']),
      jsonAccountState:
          serializer.fromJson<EnumString?>(json['jsonAccountState']),
      jsonCapabilities:
          serializer.fromJson<JsonString?>(json['jsonCapabilities']),
      jsonAvailableProfileAttributes: serializer
          .fromJson<JsonString?>(json['jsonAvailableProfileAttributes']),
      jsonProfileVisibility:
          serializer.fromJson<EnumString?>(json['jsonProfileVisibility']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'refreshTokenAccount': serializer.toJson<String?>(refreshTokenAccount),
      'refreshTokenMedia': serializer.toJson<String?>(refreshTokenMedia),
      'refreshTokenProfile': serializer.toJson<String?>(refreshTokenProfile),
      'refreshTokenChat': serializer.toJson<String?>(refreshTokenChat),
      'accessTokenAccount': serializer.toJson<String?>(accessTokenAccount),
      'accessTokenMedia': serializer.toJson<String?>(accessTokenMedia),
      'accessTokenProfile': serializer.toJson<String?>(accessTokenProfile),
      'accessTokenChat': serializer.toJson<String?>(accessTokenChat),
      'profileFilterFavorites': serializer.toJson<bool>(profileFilterFavorites),
      'profileLocationLatitude':
          serializer.toJson<double?>(profileLocationLatitude),
      'profileLocationLongitude':
          serializer.toJson<double?>(profileLocationLongitude),
      'jsonAccountState': serializer.toJson<EnumString?>(jsonAccountState),
      'jsonCapabilities': serializer.toJson<JsonString?>(jsonCapabilities),
      'jsonAvailableProfileAttributes':
          serializer.toJson<JsonString?>(jsonAvailableProfileAttributes),
      'jsonProfileVisibility':
          serializer.toJson<EnumString?>(jsonProfileVisibility),
    };
  }

  AccountData copyWith(
          {int? id,
          Value<String?> refreshTokenAccount = const Value.absent(),
          Value<String?> refreshTokenMedia = const Value.absent(),
          Value<String?> refreshTokenProfile = const Value.absent(),
          Value<String?> refreshTokenChat = const Value.absent(),
          Value<String?> accessTokenAccount = const Value.absent(),
          Value<String?> accessTokenMedia = const Value.absent(),
          Value<String?> accessTokenProfile = const Value.absent(),
          Value<String?> accessTokenChat = const Value.absent(),
          bool? profileFilterFavorites,
          Value<double?> profileLocationLatitude = const Value.absent(),
          Value<double?> profileLocationLongitude = const Value.absent(),
          Value<EnumString?> jsonAccountState = const Value.absent(),
          Value<JsonString?> jsonCapabilities = const Value.absent(),
          Value<JsonString?> jsonAvailableProfileAttributes =
              const Value.absent(),
          Value<EnumString?> jsonProfileVisibility = const Value.absent()}) =>
      AccountData(
        id: id ?? this.id,
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
        profileFilterFavorites:
            profileFilterFavorites ?? this.profileFilterFavorites,
        profileLocationLatitude: profileLocationLatitude.present
            ? profileLocationLatitude.value
            : this.profileLocationLatitude,
        profileLocationLongitude: profileLocationLongitude.present
            ? profileLocationLongitude.value
            : this.profileLocationLongitude,
        jsonAccountState: jsonAccountState.present
            ? jsonAccountState.value
            : this.jsonAccountState,
        jsonCapabilities: jsonCapabilities.present
            ? jsonCapabilities.value
            : this.jsonCapabilities,
        jsonAvailableProfileAttributes: jsonAvailableProfileAttributes.present
            ? jsonAvailableProfileAttributes.value
            : this.jsonAvailableProfileAttributes,
        jsonProfileVisibility: jsonProfileVisibility.present
            ? jsonProfileVisibility.value
            : this.jsonProfileVisibility,
      );
  @override
  String toString() {
    return (StringBuffer('AccountData(')
          ..write('id: $id, ')
          ..write('refreshTokenAccount: $refreshTokenAccount, ')
          ..write('refreshTokenMedia: $refreshTokenMedia, ')
          ..write('refreshTokenProfile: $refreshTokenProfile, ')
          ..write('refreshTokenChat: $refreshTokenChat, ')
          ..write('accessTokenAccount: $accessTokenAccount, ')
          ..write('accessTokenMedia: $accessTokenMedia, ')
          ..write('accessTokenProfile: $accessTokenProfile, ')
          ..write('accessTokenChat: $accessTokenChat, ')
          ..write('profileFilterFavorites: $profileFilterFavorites, ')
          ..write('profileLocationLatitude: $profileLocationLatitude, ')
          ..write('profileLocationLongitude: $profileLocationLongitude, ')
          ..write('jsonAccountState: $jsonAccountState, ')
          ..write('jsonCapabilities: $jsonCapabilities, ')
          ..write(
              'jsonAvailableProfileAttributes: $jsonAvailableProfileAttributes, ')
          ..write('jsonProfileVisibility: $jsonProfileVisibility')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      refreshTokenAccount,
      refreshTokenMedia,
      refreshTokenProfile,
      refreshTokenChat,
      accessTokenAccount,
      accessTokenMedia,
      accessTokenProfile,
      accessTokenChat,
      profileFilterFavorites,
      profileLocationLatitude,
      profileLocationLongitude,
      jsonAccountState,
      jsonCapabilities,
      jsonAvailableProfileAttributes,
      jsonProfileVisibility);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AccountData &&
          other.id == this.id &&
          other.refreshTokenAccount == this.refreshTokenAccount &&
          other.refreshTokenMedia == this.refreshTokenMedia &&
          other.refreshTokenProfile == this.refreshTokenProfile &&
          other.refreshTokenChat == this.refreshTokenChat &&
          other.accessTokenAccount == this.accessTokenAccount &&
          other.accessTokenMedia == this.accessTokenMedia &&
          other.accessTokenProfile == this.accessTokenProfile &&
          other.accessTokenChat == this.accessTokenChat &&
          other.profileFilterFavorites == this.profileFilterFavorites &&
          other.profileLocationLatitude == this.profileLocationLatitude &&
          other.profileLocationLongitude == this.profileLocationLongitude &&
          other.jsonAccountState == this.jsonAccountState &&
          other.jsonCapabilities == this.jsonCapabilities &&
          other.jsonAvailableProfileAttributes ==
              this.jsonAvailableProfileAttributes &&
          other.jsonProfileVisibility == this.jsonProfileVisibility);
}

class AccountCompanion extends UpdateCompanion<AccountData> {
  final Value<int> id;
  final Value<String?> refreshTokenAccount;
  final Value<String?> refreshTokenMedia;
  final Value<String?> refreshTokenProfile;
  final Value<String?> refreshTokenChat;
  final Value<String?> accessTokenAccount;
  final Value<String?> accessTokenMedia;
  final Value<String?> accessTokenProfile;
  final Value<String?> accessTokenChat;
  final Value<bool> profileFilterFavorites;
  final Value<double?> profileLocationLatitude;
  final Value<double?> profileLocationLongitude;
  final Value<EnumString?> jsonAccountState;
  final Value<JsonString?> jsonCapabilities;
  final Value<JsonString?> jsonAvailableProfileAttributes;
  final Value<EnumString?> jsonProfileVisibility;
  const AccountCompanion({
    this.id = const Value.absent(),
    this.refreshTokenAccount = const Value.absent(),
    this.refreshTokenMedia = const Value.absent(),
    this.refreshTokenProfile = const Value.absent(),
    this.refreshTokenChat = const Value.absent(),
    this.accessTokenAccount = const Value.absent(),
    this.accessTokenMedia = const Value.absent(),
    this.accessTokenProfile = const Value.absent(),
    this.accessTokenChat = const Value.absent(),
    this.profileFilterFavorites = const Value.absent(),
    this.profileLocationLatitude = const Value.absent(),
    this.profileLocationLongitude = const Value.absent(),
    this.jsonAccountState = const Value.absent(),
    this.jsonCapabilities = const Value.absent(),
    this.jsonAvailableProfileAttributes = const Value.absent(),
    this.jsonProfileVisibility = const Value.absent(),
  });
  AccountCompanion.insert({
    this.id = const Value.absent(),
    this.refreshTokenAccount = const Value.absent(),
    this.refreshTokenMedia = const Value.absent(),
    this.refreshTokenProfile = const Value.absent(),
    this.refreshTokenChat = const Value.absent(),
    this.accessTokenAccount = const Value.absent(),
    this.accessTokenMedia = const Value.absent(),
    this.accessTokenProfile = const Value.absent(),
    this.accessTokenChat = const Value.absent(),
    this.profileFilterFavorites = const Value.absent(),
    this.profileLocationLatitude = const Value.absent(),
    this.profileLocationLongitude = const Value.absent(),
    this.jsonAccountState = const Value.absent(),
    this.jsonCapabilities = const Value.absent(),
    this.jsonAvailableProfileAttributes = const Value.absent(),
    this.jsonProfileVisibility = const Value.absent(),
  });
  static Insertable<AccountData> custom({
    Expression<int>? id,
    Expression<String>? refreshTokenAccount,
    Expression<String>? refreshTokenMedia,
    Expression<String>? refreshTokenProfile,
    Expression<String>? refreshTokenChat,
    Expression<String>? accessTokenAccount,
    Expression<String>? accessTokenMedia,
    Expression<String>? accessTokenProfile,
    Expression<String>? accessTokenChat,
    Expression<bool>? profileFilterFavorites,
    Expression<double>? profileLocationLatitude,
    Expression<double>? profileLocationLongitude,
    Expression<String>? jsonAccountState,
    Expression<String>? jsonCapabilities,
    Expression<String>? jsonAvailableProfileAttributes,
    Expression<String>? jsonProfileVisibility,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
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
      if (profileFilterFavorites != null)
        'profile_filter_favorites': profileFilterFavorites,
      if (profileLocationLatitude != null)
        'profile_location_latitude': profileLocationLatitude,
      if (profileLocationLongitude != null)
        'profile_location_longitude': profileLocationLongitude,
      if (jsonAccountState != null) 'json_account_state': jsonAccountState,
      if (jsonCapabilities != null) 'json_capabilities': jsonCapabilities,
      if (jsonAvailableProfileAttributes != null)
        'json_available_profile_attributes': jsonAvailableProfileAttributes,
      if (jsonProfileVisibility != null)
        'json_profile_visibility': jsonProfileVisibility,
    });
  }

  AccountCompanion copyWith(
      {Value<int>? id,
      Value<String?>? refreshTokenAccount,
      Value<String?>? refreshTokenMedia,
      Value<String?>? refreshTokenProfile,
      Value<String?>? refreshTokenChat,
      Value<String?>? accessTokenAccount,
      Value<String?>? accessTokenMedia,
      Value<String?>? accessTokenProfile,
      Value<String?>? accessTokenChat,
      Value<bool>? profileFilterFavorites,
      Value<double?>? profileLocationLatitude,
      Value<double?>? profileLocationLongitude,
      Value<EnumString?>? jsonAccountState,
      Value<JsonString?>? jsonCapabilities,
      Value<JsonString?>? jsonAvailableProfileAttributes,
      Value<EnumString?>? jsonProfileVisibility}) {
    return AccountCompanion(
      id: id ?? this.id,
      refreshTokenAccount: refreshTokenAccount ?? this.refreshTokenAccount,
      refreshTokenMedia: refreshTokenMedia ?? this.refreshTokenMedia,
      refreshTokenProfile: refreshTokenProfile ?? this.refreshTokenProfile,
      refreshTokenChat: refreshTokenChat ?? this.refreshTokenChat,
      accessTokenAccount: accessTokenAccount ?? this.accessTokenAccount,
      accessTokenMedia: accessTokenMedia ?? this.accessTokenMedia,
      accessTokenProfile: accessTokenProfile ?? this.accessTokenProfile,
      accessTokenChat: accessTokenChat ?? this.accessTokenChat,
      profileFilterFavorites:
          profileFilterFavorites ?? this.profileFilterFavorites,
      profileLocationLatitude:
          profileLocationLatitude ?? this.profileLocationLatitude,
      profileLocationLongitude:
          profileLocationLongitude ?? this.profileLocationLongitude,
      jsonAccountState: jsonAccountState ?? this.jsonAccountState,
      jsonCapabilities: jsonCapabilities ?? this.jsonCapabilities,
      jsonAvailableProfileAttributes:
          jsonAvailableProfileAttributes ?? this.jsonAvailableProfileAttributes,
      jsonProfileVisibility:
          jsonProfileVisibility ?? this.jsonProfileVisibility,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
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
    if (profileFilterFavorites.present) {
      map['profile_filter_favorites'] =
          Variable<bool>(profileFilterFavorites.value);
    }
    if (profileLocationLatitude.present) {
      map['profile_location_latitude'] =
          Variable<double>(profileLocationLatitude.value);
    }
    if (profileLocationLongitude.present) {
      map['profile_location_longitude'] =
          Variable<double>(profileLocationLongitude.value);
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
    if (jsonProfileVisibility.present) {
      map['json_profile_visibility'] = Variable<String>($AccountTable
          .$converterjsonProfileVisibility
          .toSql(jsonProfileVisibility.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AccountCompanion(')
          ..write('id: $id, ')
          ..write('refreshTokenAccount: $refreshTokenAccount, ')
          ..write('refreshTokenMedia: $refreshTokenMedia, ')
          ..write('refreshTokenProfile: $refreshTokenProfile, ')
          ..write('refreshTokenChat: $refreshTokenChat, ')
          ..write('accessTokenAccount: $accessTokenAccount, ')
          ..write('accessTokenMedia: $accessTokenMedia, ')
          ..write('accessTokenProfile: $accessTokenProfile, ')
          ..write('accessTokenChat: $accessTokenChat, ')
          ..write('profileFilterFavorites: $profileFilterFavorites, ')
          ..write('profileLocationLatitude: $profileLocationLatitude, ')
          ..write('profileLocationLongitude: $profileLocationLongitude, ')
          ..write('jsonAccountState: $jsonAccountState, ')
          ..write('jsonCapabilities: $jsonCapabilities, ')
          ..write(
              'jsonAvailableProfileAttributes: $jsonAvailableProfileAttributes, ')
          ..write('jsonProfileVisibility: $jsonProfileVisibility')
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
  late final GeneratedColumn<String> profileVersion = GeneratedColumn<String>(
      'profile_version', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _profileAgeMeta =
      const VerificationMeta('profileAge');
  @override
  late final GeneratedColumn<int> profileAge = GeneratedColumn<int>(
      'profile_age', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
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
        profileName,
        profileText,
        profileVersion,
        profileAge,
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
    if (data.containsKey('profile_version')) {
      context.handle(
          _profileVersionMeta,
          profileVersion.isAcceptableOrUnknown(
              data['profile_version']!, _profileVersionMeta));
    }
    if (data.containsKey('profile_age')) {
      context.handle(
          _profileAgeMeta,
          profileAge.isAcceptableOrUnknown(
              data['profile_age']!, _profileAgeMeta));
    }
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
      profileName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}profile_name']),
      profileText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}profile_text']),
      profileVersion: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}profile_version']),
      profileAge: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}profile_age']),
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
  final String? profileName;
  final String? profileText;
  final String? profileVersion;
  final int? profileAge;
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
      this.profileName,
      this.profileText,
      this.profileVersion,
      this.profileAge,
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
    if (!nullToAbsent || profileName != null) {
      map['profile_name'] = Variable<String>(profileName);
    }
    if (!nullToAbsent || profileText != null) {
      map['profile_text'] = Variable<String>(profileText);
    }
    if (!nullToAbsent || profileVersion != null) {
      map['profile_version'] = Variable<String>(profileVersion);
    }
    if (!nullToAbsent || profileAge != null) {
      map['profile_age'] = Variable<int>(profileAge);
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
      profileName: serializer.fromJson<String?>(json['profileName']),
      profileText: serializer.fromJson<String?>(json['profileText']),
      profileVersion: serializer.fromJson<String?>(json['profileVersion']),
      profileAge: serializer.fromJson<int?>(json['profileAge']),
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
      'profileName': serializer.toJson<String?>(profileName),
      'profileText': serializer.toJson<String?>(profileText),
      'profileVersion': serializer.toJson<String?>(profileVersion),
      'profileAge': serializer.toJson<int?>(profileAge),
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
          Value<String?> profileName = const Value.absent(),
          Value<String?> profileText = const Value.absent(),
          Value<String?> profileVersion = const Value.absent(),
          Value<int?> profileAge = const Value.absent(),
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
        profileName: profileName.present ? profileName.value : this.profileName,
        profileText: profileText.present ? profileText.value : this.profileText,
        profileVersion:
            profileVersion.present ? profileVersion.value : this.profileVersion,
        profileAge: profileAge.present ? profileAge.value : this.profileAge,
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
          ..write('profileName: $profileName, ')
          ..write('profileText: $profileText, ')
          ..write('profileVersion: $profileVersion, ')
          ..write('profileAge: $profileAge, ')
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
  int get hashCode => Object.hash(
      id,
      uuidAccountId,
      uuidContentId0,
      uuidContentId1,
      uuidContentId2,
      uuidContentId3,
      uuidContentId4,
      uuidContentId5,
      profileName,
      profileText,
      profileVersion,
      profileAge,
      isInFavorites,
      isInMatches,
      isInReceivedBlocks,
      isInReceivedLikes,
      isInSentBlocks,
      isInSentLikes,
      isInProfileGrid);
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
          other.profileName == this.profileName &&
          other.profileText == this.profileText &&
          other.profileVersion == this.profileVersion &&
          other.profileAge == this.profileAge &&
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
  final Value<String?> profileName;
  final Value<String?> profileText;
  final Value<String?> profileVersion;
  final Value<int?> profileAge;
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
    this.profileName = const Value.absent(),
    this.profileText = const Value.absent(),
    this.profileVersion = const Value.absent(),
    this.profileAge = const Value.absent(),
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
    this.profileName = const Value.absent(),
    this.profileText = const Value.absent(),
    this.profileVersion = const Value.absent(),
    this.profileAge = const Value.absent(),
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
    Expression<String>? profileName,
    Expression<String>? profileText,
    Expression<String>? profileVersion,
    Expression<int>? profileAge,
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
      if (profileName != null) 'profile_name': profileName,
      if (profileText != null) 'profile_text': profileText,
      if (profileVersion != null) 'profile_version': profileVersion,
      if (profileAge != null) 'profile_age': profileAge,
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
      Value<String?>? profileName,
      Value<String?>? profileText,
      Value<String?>? profileVersion,
      Value<int?>? profileAge,
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
      profileName: profileName ?? this.profileName,
      profileText: profileText ?? this.profileText,
      profileVersion: profileVersion ?? this.profileVersion,
      profileAge: profileAge ?? this.profileAge,
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
    if (profileName.present) {
      map['profile_name'] = Variable<String>(profileName.value);
    }
    if (profileText.present) {
      map['profile_text'] = Variable<String>(profileText.value);
    }
    if (profileVersion.present) {
      map['profile_version'] = Variable<String>(profileVersion.value);
    }
    if (profileAge.present) {
      map['profile_age'] = Variable<int>(profileAge.value);
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
          ..write('profileName: $profileName, ')
          ..write('profileText: $profileText, ')
          ..write('profileVersion: $profileVersion, ')
          ..write('profileAge: $profileAge, ')
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
        sentMessageState,
        receivedMessageState,
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
      sentMessageState: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sent_message_state']),
      receivedMessageState: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}received_message_state']),
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
  final int? sentMessageState;
  final int? receivedMessageState;
  final MessageNumber? messageNumber;
  final UtcDateTime? unixTime;
  const Message(
      {required this.id,
      required this.uuidLocalAccountId,
      required this.uuidRemoteAccountId,
      required this.messageText,
      this.sentMessageState,
      this.receivedMessageState,
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
    if (!nullToAbsent || sentMessageState != null) {
      map['sent_message_state'] = Variable<int>(sentMessageState);
    }
    if (!nullToAbsent || receivedMessageState != null) {
      map['received_message_state'] = Variable<int>(receivedMessageState);
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
      sentMessageState: sentMessageState == null && nullToAbsent
          ? const Value.absent()
          : Value(sentMessageState),
      receivedMessageState: receivedMessageState == null && nullToAbsent
          ? const Value.absent()
          : Value(receivedMessageState),
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
      sentMessageState: serializer.fromJson<int?>(json['sentMessageState']),
      receivedMessageState:
          serializer.fromJson<int?>(json['receivedMessageState']),
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
      'sentMessageState': serializer.toJson<int?>(sentMessageState),
      'receivedMessageState': serializer.toJson<int?>(receivedMessageState),
      'messageNumber': serializer.toJson<MessageNumber?>(messageNumber),
      'unixTime': serializer.toJson<UtcDateTime?>(unixTime),
    };
  }

  Message copyWith(
          {int? id,
          AccountId? uuidLocalAccountId,
          AccountId? uuidRemoteAccountId,
          String? messageText,
          Value<int?> sentMessageState = const Value.absent(),
          Value<int?> receivedMessageState = const Value.absent(),
          Value<MessageNumber?> messageNumber = const Value.absent(),
          Value<UtcDateTime?> unixTime = const Value.absent()}) =>
      Message(
        id: id ?? this.id,
        uuidLocalAccountId: uuidLocalAccountId ?? this.uuidLocalAccountId,
        uuidRemoteAccountId: uuidRemoteAccountId ?? this.uuidRemoteAccountId,
        messageText: messageText ?? this.messageText,
        sentMessageState: sentMessageState.present
            ? sentMessageState.value
            : this.sentMessageState,
        receivedMessageState: receivedMessageState.present
            ? receivedMessageState.value
            : this.receivedMessageState,
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
          ..write('sentMessageState: $sentMessageState, ')
          ..write('receivedMessageState: $receivedMessageState, ')
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
      sentMessageState,
      receivedMessageState,
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
          other.sentMessageState == this.sentMessageState &&
          other.receivedMessageState == this.receivedMessageState &&
          other.messageNumber == this.messageNumber &&
          other.unixTime == this.unixTime);
}

class MessagesCompanion extends UpdateCompanion<Message> {
  final Value<int> id;
  final Value<AccountId> uuidLocalAccountId;
  final Value<AccountId> uuidRemoteAccountId;
  final Value<String> messageText;
  final Value<int?> sentMessageState;
  final Value<int?> receivedMessageState;
  final Value<MessageNumber?> messageNumber;
  final Value<UtcDateTime?> unixTime;
  const MessagesCompanion({
    this.id = const Value.absent(),
    this.uuidLocalAccountId = const Value.absent(),
    this.uuidRemoteAccountId = const Value.absent(),
    this.messageText = const Value.absent(),
    this.sentMessageState = const Value.absent(),
    this.receivedMessageState = const Value.absent(),
    this.messageNumber = const Value.absent(),
    this.unixTime = const Value.absent(),
  });
  MessagesCompanion.insert({
    this.id = const Value.absent(),
    required AccountId uuidLocalAccountId,
    required AccountId uuidRemoteAccountId,
    required String messageText,
    this.sentMessageState = const Value.absent(),
    this.receivedMessageState = const Value.absent(),
    this.messageNumber = const Value.absent(),
    this.unixTime = const Value.absent(),
  })  : uuidLocalAccountId = Value(uuidLocalAccountId),
        uuidRemoteAccountId = Value(uuidRemoteAccountId),
        messageText = Value(messageText);
  static Insertable<Message> custom({
    Expression<int>? id,
    Expression<String>? uuidLocalAccountId,
    Expression<String>? uuidRemoteAccountId,
    Expression<String>? messageText,
    Expression<int>? sentMessageState,
    Expression<int>? receivedMessageState,
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
      if (sentMessageState != null) 'sent_message_state': sentMessageState,
      if (receivedMessageState != null)
        'received_message_state': receivedMessageState,
      if (messageNumber != null) 'message_number': messageNumber,
      if (unixTime != null) 'unix_time': unixTime,
    });
  }

  MessagesCompanion copyWith(
      {Value<int>? id,
      Value<AccountId>? uuidLocalAccountId,
      Value<AccountId>? uuidRemoteAccountId,
      Value<String>? messageText,
      Value<int?>? sentMessageState,
      Value<int?>? receivedMessageState,
      Value<MessageNumber?>? messageNumber,
      Value<UtcDateTime?>? unixTime}) {
    return MessagesCompanion(
      id: id ?? this.id,
      uuidLocalAccountId: uuidLocalAccountId ?? this.uuidLocalAccountId,
      uuidRemoteAccountId: uuidRemoteAccountId ?? this.uuidRemoteAccountId,
      messageText: messageText ?? this.messageText,
      sentMessageState: sentMessageState ?? this.sentMessageState,
      receivedMessageState: receivedMessageState ?? this.receivedMessageState,
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
    if (sentMessageState.present) {
      map['sent_message_state'] = Variable<int>(sentMessageState.value);
    }
    if (receivedMessageState.present) {
      map['received_message_state'] = Variable<int>(receivedMessageState.value);
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
          ..write('sentMessageState: $sentMessageState, ')
          ..write('receivedMessageState: $receivedMessageState, ')
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
  late final DaoProfiles daoProfiles = DaoProfiles(this as AccountDatabase);
  late final DaoMessages daoMessages = DaoMessages(this as AccountDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [account, profiles, messages];
}
