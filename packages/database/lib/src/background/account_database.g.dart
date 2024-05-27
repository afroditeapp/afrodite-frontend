// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_database.dart';

// ignore_for_file: type=lint
class $AccountBackgroundTable extends AccountBackground
    with TableInfo<$AccountBackgroundTable, AccountBackgroundData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AccountBackgroundTable(this.attachedDatabase, [this._alias]);
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
          .withConverter<AccountId?>(
              $AccountBackgroundTable.$converteruuidAccountId);
  static const VerificationMeta _localNotificationSettingMessagesMeta =
      const VerificationMeta('localNotificationSettingMessages');
  @override
  late final GeneratedColumn<bool> localNotificationSettingMessages =
      GeneratedColumn<bool>(
          'local_notification_setting_messages', aliasedName, true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("local_notification_setting_messages" IN (0, 1))'));
  static const VerificationMeta _localNotificationSettingLikesMeta =
      const VerificationMeta('localNotificationSettingLikes');
  @override
  late final GeneratedColumn<bool> localNotificationSettingLikes =
      GeneratedColumn<bool>(
          'local_notification_setting_likes', aliasedName, true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("local_notification_setting_likes" IN (0, 1))'));
  static const VerificationMeta
      _localNotificationSettingModerationRequestStatusMeta =
      const VerificationMeta('localNotificationSettingModerationRequestStatus');
  @override
  late final GeneratedColumn<
      bool> localNotificationSettingModerationRequestStatus = GeneratedColumn<
          bool>(
      'local_notification_setting_moderation_request_status', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("local_notification_setting_moderation_request_status" IN (0, 1))'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        uuidAccountId,
        localNotificationSettingMessages,
        localNotificationSettingLikes,
        localNotificationSettingModerationRequestStatus
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'account_background';
  @override
  VerificationContext validateIntegrity(
      Insertable<AccountBackgroundData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    context.handle(_uuidAccountIdMeta, const VerificationResult.success());
    if (data.containsKey('local_notification_setting_messages')) {
      context.handle(
          _localNotificationSettingMessagesMeta,
          localNotificationSettingMessages.isAcceptableOrUnknown(
              data['local_notification_setting_messages']!,
              _localNotificationSettingMessagesMeta));
    }
    if (data.containsKey('local_notification_setting_likes')) {
      context.handle(
          _localNotificationSettingLikesMeta,
          localNotificationSettingLikes.isAcceptableOrUnknown(
              data['local_notification_setting_likes']!,
              _localNotificationSettingLikesMeta));
    }
    if (data
        .containsKey('local_notification_setting_moderation_request_status')) {
      context.handle(
          _localNotificationSettingModerationRequestStatusMeta,
          localNotificationSettingModerationRequestStatus.isAcceptableOrUnknown(
              data['local_notification_setting_moderation_request_status']!,
              _localNotificationSettingModerationRequestStatusMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AccountBackgroundData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AccountBackgroundData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      uuidAccountId: $AccountBackgroundTable.$converteruuidAccountId.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}uuid_account_id'])),
      localNotificationSettingMessages: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}local_notification_setting_messages']),
      localNotificationSettingLikes: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}local_notification_setting_likes']),
      localNotificationSettingModerationRequestStatus:
          attachedDatabase.typeMapping.read(
              DriftSqlType.bool,
              data[
                  '${effectivePrefix}local_notification_setting_moderation_request_status']),
    );
  }

  @override
  $AccountBackgroundTable createAlias(String alias) {
    return $AccountBackgroundTable(attachedDatabase, alias);
  }

  static TypeConverter<AccountId?, String?> $converteruuidAccountId =
      const NullAwareTypeConverter.wrap(AccountIdConverter());
}

class AccountBackgroundData extends DataClass
    implements Insertable<AccountBackgroundData> {
  final int id;
  final AccountId? uuidAccountId;
  final bool? localNotificationSettingMessages;
  final bool? localNotificationSettingLikes;
  final bool? localNotificationSettingModerationRequestStatus;
  const AccountBackgroundData(
      {required this.id,
      this.uuidAccountId,
      this.localNotificationSettingMessages,
      this.localNotificationSettingLikes,
      this.localNotificationSettingModerationRequestStatus});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || uuidAccountId != null) {
      map['uuid_account_id'] = Variable<String>(
          $AccountBackgroundTable.$converteruuidAccountId.toSql(uuidAccountId));
    }
    if (!nullToAbsent || localNotificationSettingMessages != null) {
      map['local_notification_setting_messages'] =
          Variable<bool>(localNotificationSettingMessages);
    }
    if (!nullToAbsent || localNotificationSettingLikes != null) {
      map['local_notification_setting_likes'] =
          Variable<bool>(localNotificationSettingLikes);
    }
    if (!nullToAbsent ||
        localNotificationSettingModerationRequestStatus != null) {
      map['local_notification_setting_moderation_request_status'] =
          Variable<bool>(localNotificationSettingModerationRequestStatus);
    }
    return map;
  }

  AccountBackgroundCompanion toCompanion(bool nullToAbsent) {
    return AccountBackgroundCompanion(
      id: Value(id),
      uuidAccountId: uuidAccountId == null && nullToAbsent
          ? const Value.absent()
          : Value(uuidAccountId),
      localNotificationSettingMessages:
          localNotificationSettingMessages == null && nullToAbsent
              ? const Value.absent()
              : Value(localNotificationSettingMessages),
      localNotificationSettingLikes:
          localNotificationSettingLikes == null && nullToAbsent
              ? const Value.absent()
              : Value(localNotificationSettingLikes),
      localNotificationSettingModerationRequestStatus:
          localNotificationSettingModerationRequestStatus == null &&
                  nullToAbsent
              ? const Value.absent()
              : Value(localNotificationSettingModerationRequestStatus),
    );
  }

  factory AccountBackgroundData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AccountBackgroundData(
      id: serializer.fromJson<int>(json['id']),
      uuidAccountId: serializer.fromJson<AccountId?>(json['uuidAccountId']),
      localNotificationSettingMessages:
          serializer.fromJson<bool?>(json['localNotificationSettingMessages']),
      localNotificationSettingLikes:
          serializer.fromJson<bool?>(json['localNotificationSettingLikes']),
      localNotificationSettingModerationRequestStatus:
          serializer.fromJson<bool?>(
              json['localNotificationSettingModerationRequestStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uuidAccountId': serializer.toJson<AccountId?>(uuidAccountId),
      'localNotificationSettingMessages':
          serializer.toJson<bool?>(localNotificationSettingMessages),
      'localNotificationSettingLikes':
          serializer.toJson<bool?>(localNotificationSettingLikes),
      'localNotificationSettingModerationRequestStatus': serializer
          .toJson<bool?>(localNotificationSettingModerationRequestStatus),
    };
  }

  AccountBackgroundData copyWith(
          {int? id,
          Value<AccountId?> uuidAccountId = const Value.absent(),
          Value<bool?> localNotificationSettingMessages = const Value.absent(),
          Value<bool?> localNotificationSettingLikes = const Value.absent(),
          Value<bool?> localNotificationSettingModerationRequestStatus =
              const Value.absent()}) =>
      AccountBackgroundData(
        id: id ?? this.id,
        uuidAccountId:
            uuidAccountId.present ? uuidAccountId.value : this.uuidAccountId,
        localNotificationSettingMessages:
            localNotificationSettingMessages.present
                ? localNotificationSettingMessages.value
                : this.localNotificationSettingMessages,
        localNotificationSettingLikes: localNotificationSettingLikes.present
            ? localNotificationSettingLikes.value
            : this.localNotificationSettingLikes,
        localNotificationSettingModerationRequestStatus:
            localNotificationSettingModerationRequestStatus.present
                ? localNotificationSettingModerationRequestStatus.value
                : this.localNotificationSettingModerationRequestStatus,
      );
  @override
  String toString() {
    return (StringBuffer('AccountBackgroundData(')
          ..write('id: $id, ')
          ..write('uuidAccountId: $uuidAccountId, ')
          ..write(
              'localNotificationSettingMessages: $localNotificationSettingMessages, ')
          ..write(
              'localNotificationSettingLikes: $localNotificationSettingLikes, ')
          ..write(
              'localNotificationSettingModerationRequestStatus: $localNotificationSettingModerationRequestStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      uuidAccountId,
      localNotificationSettingMessages,
      localNotificationSettingLikes,
      localNotificationSettingModerationRequestStatus);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AccountBackgroundData &&
          other.id == this.id &&
          other.uuidAccountId == this.uuidAccountId &&
          other.localNotificationSettingMessages ==
              this.localNotificationSettingMessages &&
          other.localNotificationSettingLikes ==
              this.localNotificationSettingLikes &&
          other.localNotificationSettingModerationRequestStatus ==
              this.localNotificationSettingModerationRequestStatus);
}

class AccountBackgroundCompanion
    extends UpdateCompanion<AccountBackgroundData> {
  final Value<int> id;
  final Value<AccountId?> uuidAccountId;
  final Value<bool?> localNotificationSettingMessages;
  final Value<bool?> localNotificationSettingLikes;
  final Value<bool?> localNotificationSettingModerationRequestStatus;
  const AccountBackgroundCompanion({
    this.id = const Value.absent(),
    this.uuidAccountId = const Value.absent(),
    this.localNotificationSettingMessages = const Value.absent(),
    this.localNotificationSettingLikes = const Value.absent(),
    this.localNotificationSettingModerationRequestStatus = const Value.absent(),
  });
  AccountBackgroundCompanion.insert({
    this.id = const Value.absent(),
    this.uuidAccountId = const Value.absent(),
    this.localNotificationSettingMessages = const Value.absent(),
    this.localNotificationSettingLikes = const Value.absent(),
    this.localNotificationSettingModerationRequestStatus = const Value.absent(),
  });
  static Insertable<AccountBackgroundData> custom({
    Expression<int>? id,
    Expression<String>? uuidAccountId,
    Expression<bool>? localNotificationSettingMessages,
    Expression<bool>? localNotificationSettingLikes,
    Expression<bool>? localNotificationSettingModerationRequestStatus,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuidAccountId != null) 'uuid_account_id': uuidAccountId,
      if (localNotificationSettingMessages != null)
        'local_notification_setting_messages': localNotificationSettingMessages,
      if (localNotificationSettingLikes != null)
        'local_notification_setting_likes': localNotificationSettingLikes,
      if (localNotificationSettingModerationRequestStatus != null)
        'local_notification_setting_moderation_request_status':
            localNotificationSettingModerationRequestStatus,
    });
  }

  AccountBackgroundCompanion copyWith(
      {Value<int>? id,
      Value<AccountId?>? uuidAccountId,
      Value<bool?>? localNotificationSettingMessages,
      Value<bool?>? localNotificationSettingLikes,
      Value<bool?>? localNotificationSettingModerationRequestStatus}) {
    return AccountBackgroundCompanion(
      id: id ?? this.id,
      uuidAccountId: uuidAccountId ?? this.uuidAccountId,
      localNotificationSettingMessages: localNotificationSettingMessages ??
          this.localNotificationSettingMessages,
      localNotificationSettingLikes:
          localNotificationSettingLikes ?? this.localNotificationSettingLikes,
      localNotificationSettingModerationRequestStatus:
          localNotificationSettingModerationRequestStatus ??
              this.localNotificationSettingModerationRequestStatus,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uuidAccountId.present) {
      map['uuid_account_id'] = Variable<String>($AccountBackgroundTable
          .$converteruuidAccountId
          .toSql(uuidAccountId.value));
    }
    if (localNotificationSettingMessages.present) {
      map['local_notification_setting_messages'] =
          Variable<bool>(localNotificationSettingMessages.value);
    }
    if (localNotificationSettingLikes.present) {
      map['local_notification_setting_likes'] =
          Variable<bool>(localNotificationSettingLikes.value);
    }
    if (localNotificationSettingModerationRequestStatus.present) {
      map['local_notification_setting_moderation_request_status'] =
          Variable<bool>(localNotificationSettingModerationRequestStatus.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AccountBackgroundCompanion(')
          ..write('id: $id, ')
          ..write('uuidAccountId: $uuidAccountId, ')
          ..write(
              'localNotificationSettingMessages: $localNotificationSettingMessages, ')
          ..write(
              'localNotificationSettingLikes: $localNotificationSettingLikes, ')
          ..write(
              'localNotificationSettingModerationRequestStatus: $localNotificationSettingModerationRequestStatus')
          ..write(')'))
        .toString();
  }
}

class $ProfilesBackgroundTable extends ProfilesBackground
    with TableInfo<$ProfilesBackgroundTable, ProfilesBackgroundData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProfilesBackgroundTable(this.attachedDatabase, [this._alias]);
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
          .withConverter<AccountId>(
              $ProfilesBackgroundTable.$converteruuidAccountId);
  static const VerificationMeta _profileNameMeta =
      const VerificationMeta('profileName');
  @override
  late final GeneratedColumn<String> profileName = GeneratedColumn<String>(
      'profile_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _profileAgeMeta =
      const VerificationMeta('profileAge');
  @override
  late final GeneratedColumn<int> profileAge = GeneratedColumn<int>(
      'profile_age', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, uuidAccountId, profileName, profileAge];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'profiles_background';
  @override
  VerificationContext validateIntegrity(
      Insertable<ProfilesBackgroundData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    context.handle(_uuidAccountIdMeta, const VerificationResult.success());
    if (data.containsKey('profile_name')) {
      context.handle(
          _profileNameMeta,
          profileName.isAcceptableOrUnknown(
              data['profile_name']!, _profileNameMeta));
    }
    if (data.containsKey('profile_age')) {
      context.handle(
          _profileAgeMeta,
          profileAge.isAcceptableOrUnknown(
              data['profile_age']!, _profileAgeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProfilesBackgroundData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProfilesBackgroundData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      uuidAccountId: $ProfilesBackgroundTable.$converteruuidAccountId.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}uuid_account_id'])!),
      profileName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}profile_name']),
      profileAge: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}profile_age']),
    );
  }

  @override
  $ProfilesBackgroundTable createAlias(String alias) {
    return $ProfilesBackgroundTable(attachedDatabase, alias);
  }

  static TypeConverter<AccountId, String> $converteruuidAccountId =
      const AccountIdConverter();
}

class ProfilesBackgroundData extends DataClass
    implements Insertable<ProfilesBackgroundData> {
  final int id;
  final AccountId uuidAccountId;
  final String? profileName;
  final int? profileAge;
  const ProfilesBackgroundData(
      {required this.id,
      required this.uuidAccountId,
      this.profileName,
      this.profileAge});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['uuid_account_id'] = Variable<String>($ProfilesBackgroundTable
          .$converteruuidAccountId
          .toSql(uuidAccountId));
    }
    if (!nullToAbsent || profileName != null) {
      map['profile_name'] = Variable<String>(profileName);
    }
    if (!nullToAbsent || profileAge != null) {
      map['profile_age'] = Variable<int>(profileAge);
    }
    return map;
  }

  ProfilesBackgroundCompanion toCompanion(bool nullToAbsent) {
    return ProfilesBackgroundCompanion(
      id: Value(id),
      uuidAccountId: Value(uuidAccountId),
      profileName: profileName == null && nullToAbsent
          ? const Value.absent()
          : Value(profileName),
      profileAge: profileAge == null && nullToAbsent
          ? const Value.absent()
          : Value(profileAge),
    );
  }

  factory ProfilesBackgroundData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProfilesBackgroundData(
      id: serializer.fromJson<int>(json['id']),
      uuidAccountId: serializer.fromJson<AccountId>(json['uuidAccountId']),
      profileName: serializer.fromJson<String?>(json['profileName']),
      profileAge: serializer.fromJson<int?>(json['profileAge']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uuidAccountId': serializer.toJson<AccountId>(uuidAccountId),
      'profileName': serializer.toJson<String?>(profileName),
      'profileAge': serializer.toJson<int?>(profileAge),
    };
  }

  ProfilesBackgroundData copyWith(
          {int? id,
          AccountId? uuidAccountId,
          Value<String?> profileName = const Value.absent(),
          Value<int?> profileAge = const Value.absent()}) =>
      ProfilesBackgroundData(
        id: id ?? this.id,
        uuidAccountId: uuidAccountId ?? this.uuidAccountId,
        profileName: profileName.present ? profileName.value : this.profileName,
        profileAge: profileAge.present ? profileAge.value : this.profileAge,
      );
  @override
  String toString() {
    return (StringBuffer('ProfilesBackgroundData(')
          ..write('id: $id, ')
          ..write('uuidAccountId: $uuidAccountId, ')
          ..write('profileName: $profileName, ')
          ..write('profileAge: $profileAge')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, uuidAccountId, profileName, profileAge);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProfilesBackgroundData &&
          other.id == this.id &&
          other.uuidAccountId == this.uuidAccountId &&
          other.profileName == this.profileName &&
          other.profileAge == this.profileAge);
}

class ProfilesBackgroundCompanion
    extends UpdateCompanion<ProfilesBackgroundData> {
  final Value<int> id;
  final Value<AccountId> uuidAccountId;
  final Value<String?> profileName;
  final Value<int?> profileAge;
  const ProfilesBackgroundCompanion({
    this.id = const Value.absent(),
    this.uuidAccountId = const Value.absent(),
    this.profileName = const Value.absent(),
    this.profileAge = const Value.absent(),
  });
  ProfilesBackgroundCompanion.insert({
    this.id = const Value.absent(),
    required AccountId uuidAccountId,
    this.profileName = const Value.absent(),
    this.profileAge = const Value.absent(),
  }) : uuidAccountId = Value(uuidAccountId);
  static Insertable<ProfilesBackgroundData> custom({
    Expression<int>? id,
    Expression<String>? uuidAccountId,
    Expression<String>? profileName,
    Expression<int>? profileAge,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuidAccountId != null) 'uuid_account_id': uuidAccountId,
      if (profileName != null) 'profile_name': profileName,
      if (profileAge != null) 'profile_age': profileAge,
    });
  }

  ProfilesBackgroundCompanion copyWith(
      {Value<int>? id,
      Value<AccountId>? uuidAccountId,
      Value<String?>? profileName,
      Value<int?>? profileAge}) {
    return ProfilesBackgroundCompanion(
      id: id ?? this.id,
      uuidAccountId: uuidAccountId ?? this.uuidAccountId,
      profileName: profileName ?? this.profileName,
      profileAge: profileAge ?? this.profileAge,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uuidAccountId.present) {
      map['uuid_account_id'] = Variable<String>($ProfilesBackgroundTable
          .$converteruuidAccountId
          .toSql(uuidAccountId.value));
    }
    if (profileName.present) {
      map['profile_name'] = Variable<String>(profileName.value);
    }
    if (profileAge.present) {
      map['profile_age'] = Variable<int>(profileAge.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProfilesBackgroundCompanion(')
          ..write('id: $id, ')
          ..write('uuidAccountId: $uuidAccountId, ')
          ..write('profileName: $profileName, ')
          ..write('profileAge: $profileAge')
          ..write(')'))
        .toString();
  }
}

abstract class _$AccountBackgroundDatabase extends GeneratedDatabase {
  _$AccountBackgroundDatabase(QueryExecutor e) : super(e);
  late final $AccountBackgroundTable accountBackground =
      $AccountBackgroundTable(this);
  late final $ProfilesBackgroundTable profilesBackground =
      $ProfilesBackgroundTable(this);
  late final DaoLocalNotificationSettings daoLocalNotificationSettings =
      DaoLocalNotificationSettings(this as AccountBackgroundDatabase);
  late final DaoProfilesBackground daoProfilesBackground =
      DaoProfilesBackground(this as AccountBackgroundDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [accountBackground, profilesBackground];
}
