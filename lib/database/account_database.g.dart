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
  static const VerificationMeta _uuidPrimaryImageMeta =
      const VerificationMeta('uuidPrimaryImage');
  @override
  late final GeneratedColumnWithTypeConverter<ContentId?, String>
      uuidPrimaryImage = GeneratedColumn<String>(
              'uuid_primary_image', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<ContentId?>($ProfilesTable.$converteruuidPrimaryImage);
  static const VerificationMeta _profileNameMeta =
      const VerificationMeta('profileName');
  @override
  late final GeneratedColumnWithTypeConverter<ContentId?, String> profileName =
      GeneratedColumn<String>('profile_name', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<ContentId?>($ProfilesTable.$converterprofileName);
  static const VerificationMeta _profileTextMeta =
      const VerificationMeta('profileText');
  @override
  late final GeneratedColumnWithTypeConverter<ContentId?, String> profileText =
      GeneratedColumn<String>('profile_text', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<ContentId?>($ProfilesTable.$converterprofileText);
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
  @override
  List<GeneratedColumn> get $columns => [
        id,
        uuidAccountId,
        uuidPrimaryImage,
        profileName,
        profileText,
        isInFavorites,
        isInMatches,
        isInReceivedBlocks,
        isInReceivedLikes,
        isInSentBlocks,
        isInSentLikes
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
    context.handle(_uuidPrimaryImageMeta, const VerificationResult.success());
    context.handle(_profileNameMeta, const VerificationResult.success());
    context.handle(_profileTextMeta, const VerificationResult.success());
    context.handle(_isInFavoritesMeta, const VerificationResult.success());
    context.handle(_isInMatchesMeta, const VerificationResult.success());
    context.handle(_isInReceivedBlocksMeta, const VerificationResult.success());
    context.handle(_isInReceivedLikesMeta, const VerificationResult.success());
    context.handle(_isInSentBlocksMeta, const VerificationResult.success());
    context.handle(_isInSentLikesMeta, const VerificationResult.success());
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
      uuidPrimaryImage: $ProfilesTable.$converteruuidPrimaryImage.fromSql(
          attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}uuid_primary_image'])),
      profileName: $ProfilesTable.$converterprofileName.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}profile_name'])),
      profileText: $ProfilesTable.$converterprofileText.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}profile_text'])),
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
    );
  }

  @override
  $ProfilesTable createAlias(String alias) {
    return $ProfilesTable(attachedDatabase, alias);
  }

  static TypeConverter<AccountId, String> $converteruuidAccountId =
      const AccountIdConverter();
  static TypeConverter<ContentId?, String?> $converteruuidPrimaryImage =
      const NullAwareTypeConverter.wrap(ContentIdConverter());
  static TypeConverter<ContentId?, String?> $converterprofileName =
      const NullAwareTypeConverter.wrap(ContentIdConverter());
  static TypeConverter<ContentId?, String?> $converterprofileText =
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
}

class Profile extends DataClass implements Insertable<Profile> {
  final int id;
  final AccountId uuidAccountId;
  final ContentId? uuidPrimaryImage;
  final ContentId? profileName;
  final ContentId? profileText;
  final UtcDateTime? isInFavorites;
  final UtcDateTime? isInMatches;
  final UtcDateTime? isInReceivedBlocks;
  final UtcDateTime? isInReceivedLikes;
  final UtcDateTime? isInSentBlocks;
  final UtcDateTime? isInSentLikes;
  const Profile(
      {required this.id,
      required this.uuidAccountId,
      this.uuidPrimaryImage,
      this.profileName,
      this.profileText,
      this.isInFavorites,
      this.isInMatches,
      this.isInReceivedBlocks,
      this.isInReceivedLikes,
      this.isInSentBlocks,
      this.isInSentLikes});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['uuid_account_id'] = Variable<String>(
          $ProfilesTable.$converteruuidAccountId.toSql(uuidAccountId));
    }
    if (!nullToAbsent || uuidPrimaryImage != null) {
      map['uuid_primary_image'] = Variable<String>(
          $ProfilesTable.$converteruuidPrimaryImage.toSql(uuidPrimaryImage));
    }
    if (!nullToAbsent || profileName != null) {
      map['profile_name'] = Variable<String>(
          $ProfilesTable.$converterprofileName.toSql(profileName));
    }
    if (!nullToAbsent || profileText != null) {
      map['profile_text'] = Variable<String>(
          $ProfilesTable.$converterprofileText.toSql(profileText));
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
    return map;
  }

  ProfilesCompanion toCompanion(bool nullToAbsent) {
    return ProfilesCompanion(
      id: Value(id),
      uuidAccountId: Value(uuidAccountId),
      uuidPrimaryImage: uuidPrimaryImage == null && nullToAbsent
          ? const Value.absent()
          : Value(uuidPrimaryImage),
      profileName: profileName == null && nullToAbsent
          ? const Value.absent()
          : Value(profileName),
      profileText: profileText == null && nullToAbsent
          ? const Value.absent()
          : Value(profileText),
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
    );
  }

  factory Profile.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Profile(
      id: serializer.fromJson<int>(json['id']),
      uuidAccountId: serializer.fromJson<AccountId>(json['uuidAccountId']),
      uuidPrimaryImage:
          serializer.fromJson<ContentId?>(json['uuidPrimaryImage']),
      profileName: serializer.fromJson<ContentId?>(json['profileName']),
      profileText: serializer.fromJson<ContentId?>(json['profileText']),
      isInFavorites: serializer.fromJson<UtcDateTime?>(json['isInFavorites']),
      isInMatches: serializer.fromJson<UtcDateTime?>(json['isInMatches']),
      isInReceivedBlocks:
          serializer.fromJson<UtcDateTime?>(json['isInReceivedBlocks']),
      isInReceivedLikes:
          serializer.fromJson<UtcDateTime?>(json['isInReceivedLikes']),
      isInSentBlocks: serializer.fromJson<UtcDateTime?>(json['isInSentBlocks']),
      isInSentLikes: serializer.fromJson<UtcDateTime?>(json['isInSentLikes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uuidAccountId': serializer.toJson<AccountId>(uuidAccountId),
      'uuidPrimaryImage': serializer.toJson<ContentId?>(uuidPrimaryImage),
      'profileName': serializer.toJson<ContentId?>(profileName),
      'profileText': serializer.toJson<ContentId?>(profileText),
      'isInFavorites': serializer.toJson<UtcDateTime?>(isInFavorites),
      'isInMatches': serializer.toJson<UtcDateTime?>(isInMatches),
      'isInReceivedBlocks': serializer.toJson<UtcDateTime?>(isInReceivedBlocks),
      'isInReceivedLikes': serializer.toJson<UtcDateTime?>(isInReceivedLikes),
      'isInSentBlocks': serializer.toJson<UtcDateTime?>(isInSentBlocks),
      'isInSentLikes': serializer.toJson<UtcDateTime?>(isInSentLikes),
    };
  }

  Profile copyWith(
          {int? id,
          AccountId? uuidAccountId,
          Value<ContentId?> uuidPrimaryImage = const Value.absent(),
          Value<ContentId?> profileName = const Value.absent(),
          Value<ContentId?> profileText = const Value.absent(),
          Value<UtcDateTime?> isInFavorites = const Value.absent(),
          Value<UtcDateTime?> isInMatches = const Value.absent(),
          Value<UtcDateTime?> isInReceivedBlocks = const Value.absent(),
          Value<UtcDateTime?> isInReceivedLikes = const Value.absent(),
          Value<UtcDateTime?> isInSentBlocks = const Value.absent(),
          Value<UtcDateTime?> isInSentLikes = const Value.absent()}) =>
      Profile(
        id: id ?? this.id,
        uuidAccountId: uuidAccountId ?? this.uuidAccountId,
        uuidPrimaryImage: uuidPrimaryImage.present
            ? uuidPrimaryImage.value
            : this.uuidPrimaryImage,
        profileName: profileName.present ? profileName.value : this.profileName,
        profileText: profileText.present ? profileText.value : this.profileText,
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
      );
  @override
  String toString() {
    return (StringBuffer('Profile(')
          ..write('id: $id, ')
          ..write('uuidAccountId: $uuidAccountId, ')
          ..write('uuidPrimaryImage: $uuidPrimaryImage, ')
          ..write('profileName: $profileName, ')
          ..write('profileText: $profileText, ')
          ..write('isInFavorites: $isInFavorites, ')
          ..write('isInMatches: $isInMatches, ')
          ..write('isInReceivedBlocks: $isInReceivedBlocks, ')
          ..write('isInReceivedLikes: $isInReceivedLikes, ')
          ..write('isInSentBlocks: $isInSentBlocks, ')
          ..write('isInSentLikes: $isInSentLikes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      uuidAccountId,
      uuidPrimaryImage,
      profileName,
      profileText,
      isInFavorites,
      isInMatches,
      isInReceivedBlocks,
      isInReceivedLikes,
      isInSentBlocks,
      isInSentLikes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Profile &&
          other.id == this.id &&
          other.uuidAccountId == this.uuidAccountId &&
          other.uuidPrimaryImage == this.uuidPrimaryImage &&
          other.profileName == this.profileName &&
          other.profileText == this.profileText &&
          other.isInFavorites == this.isInFavorites &&
          other.isInMatches == this.isInMatches &&
          other.isInReceivedBlocks == this.isInReceivedBlocks &&
          other.isInReceivedLikes == this.isInReceivedLikes &&
          other.isInSentBlocks == this.isInSentBlocks &&
          other.isInSentLikes == this.isInSentLikes);
}

class ProfilesCompanion extends UpdateCompanion<Profile> {
  final Value<int> id;
  final Value<AccountId> uuidAccountId;
  final Value<ContentId?> uuidPrimaryImage;
  final Value<ContentId?> profileName;
  final Value<ContentId?> profileText;
  final Value<UtcDateTime?> isInFavorites;
  final Value<UtcDateTime?> isInMatches;
  final Value<UtcDateTime?> isInReceivedBlocks;
  final Value<UtcDateTime?> isInReceivedLikes;
  final Value<UtcDateTime?> isInSentBlocks;
  final Value<UtcDateTime?> isInSentLikes;
  const ProfilesCompanion({
    this.id = const Value.absent(),
    this.uuidAccountId = const Value.absent(),
    this.uuidPrimaryImage = const Value.absent(),
    this.profileName = const Value.absent(),
    this.profileText = const Value.absent(),
    this.isInFavorites = const Value.absent(),
    this.isInMatches = const Value.absent(),
    this.isInReceivedBlocks = const Value.absent(),
    this.isInReceivedLikes = const Value.absent(),
    this.isInSentBlocks = const Value.absent(),
    this.isInSentLikes = const Value.absent(),
  });
  ProfilesCompanion.insert({
    this.id = const Value.absent(),
    required AccountId uuidAccountId,
    this.uuidPrimaryImage = const Value.absent(),
    this.profileName = const Value.absent(),
    this.profileText = const Value.absent(),
    this.isInFavorites = const Value.absent(),
    this.isInMatches = const Value.absent(),
    this.isInReceivedBlocks = const Value.absent(),
    this.isInReceivedLikes = const Value.absent(),
    this.isInSentBlocks = const Value.absent(),
    this.isInSentLikes = const Value.absent(),
  }) : uuidAccountId = Value(uuidAccountId);
  static Insertable<Profile> custom({
    Expression<int>? id,
    Expression<String>? uuidAccountId,
    Expression<String>? uuidPrimaryImage,
    Expression<String>? profileName,
    Expression<String>? profileText,
    Expression<int>? isInFavorites,
    Expression<int>? isInMatches,
    Expression<int>? isInReceivedBlocks,
    Expression<int>? isInReceivedLikes,
    Expression<int>? isInSentBlocks,
    Expression<int>? isInSentLikes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuidAccountId != null) 'uuid_account_id': uuidAccountId,
      if (uuidPrimaryImage != null) 'uuid_primary_image': uuidPrimaryImage,
      if (profileName != null) 'profile_name': profileName,
      if (profileText != null) 'profile_text': profileText,
      if (isInFavorites != null) 'is_in_favorites': isInFavorites,
      if (isInMatches != null) 'is_in_matches': isInMatches,
      if (isInReceivedBlocks != null)
        'is_in_received_blocks': isInReceivedBlocks,
      if (isInReceivedLikes != null) 'is_in_received_likes': isInReceivedLikes,
      if (isInSentBlocks != null) 'is_in_sent_blocks': isInSentBlocks,
      if (isInSentLikes != null) 'is_in_sent_likes': isInSentLikes,
    });
  }

  ProfilesCompanion copyWith(
      {Value<int>? id,
      Value<AccountId>? uuidAccountId,
      Value<ContentId?>? uuidPrimaryImage,
      Value<ContentId?>? profileName,
      Value<ContentId?>? profileText,
      Value<UtcDateTime?>? isInFavorites,
      Value<UtcDateTime?>? isInMatches,
      Value<UtcDateTime?>? isInReceivedBlocks,
      Value<UtcDateTime?>? isInReceivedLikes,
      Value<UtcDateTime?>? isInSentBlocks,
      Value<UtcDateTime?>? isInSentLikes}) {
    return ProfilesCompanion(
      id: id ?? this.id,
      uuidAccountId: uuidAccountId ?? this.uuidAccountId,
      uuidPrimaryImage: uuidPrimaryImage ?? this.uuidPrimaryImage,
      profileName: profileName ?? this.profileName,
      profileText: profileText ?? this.profileText,
      isInFavorites: isInFavorites ?? this.isInFavorites,
      isInMatches: isInMatches ?? this.isInMatches,
      isInReceivedBlocks: isInReceivedBlocks ?? this.isInReceivedBlocks,
      isInReceivedLikes: isInReceivedLikes ?? this.isInReceivedLikes,
      isInSentBlocks: isInSentBlocks ?? this.isInSentBlocks,
      isInSentLikes: isInSentLikes ?? this.isInSentLikes,
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
    if (uuidPrimaryImage.present) {
      map['uuid_primary_image'] = Variable<String>($ProfilesTable
          .$converteruuidPrimaryImage
          .toSql(uuidPrimaryImage.value));
    }
    if (profileName.present) {
      map['profile_name'] = Variable<String>(
          $ProfilesTable.$converterprofileName.toSql(profileName.value));
    }
    if (profileText.present) {
      map['profile_text'] = Variable<String>(
          $ProfilesTable.$converterprofileText.toSql(profileText.value));
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProfilesCompanion(')
          ..write('id: $id, ')
          ..write('uuidAccountId: $uuidAccountId, ')
          ..write('uuidPrimaryImage: $uuidPrimaryImage, ')
          ..write('profileName: $profileName, ')
          ..write('profileText: $profileText, ')
          ..write('isInFavorites: $isInFavorites, ')
          ..write('isInMatches: $isInMatches, ')
          ..write('isInReceivedBlocks: $isInReceivedBlocks, ')
          ..write('isInReceivedLikes: $isInReceivedLikes, ')
          ..write('isInSentBlocks: $isInSentBlocks, ')
          ..write('isInSentLikes: $isInSentLikes')
          ..write(')'))
        .toString();
  }
}

abstract class _$AccountDatabase extends GeneratedDatabase {
  _$AccountDatabase(QueryExecutor e) : super(e);
  late final $AccountTable account = $AccountTable(this);
  late final $ProfilesTable profiles = $ProfilesTable(this);
  late final DaoProfiles daoProfiles = DaoProfiles(this as AccountDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [account, profiles];
}
