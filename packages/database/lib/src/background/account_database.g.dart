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
  @override
  late final GeneratedColumnWithTypeConverter<AccountId?, String>
      uuidAccountId = GeneratedColumn<String>(
              'uuid_account_id', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<AccountId?>(
              $AccountBackgroundTable.$converteruuidAccountId);
  @override
  List<GeneratedColumn> get $columns => [id, uuidAccountId];
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
  const AccountBackgroundData({required this.id, this.uuidAccountId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || uuidAccountId != null) {
      map['uuid_account_id'] = Variable<String>(
          $AccountBackgroundTable.$converteruuidAccountId.toSql(uuidAccountId));
    }
    return map;
  }

  AccountBackgroundCompanion toCompanion(bool nullToAbsent) {
    return AccountBackgroundCompanion(
      id: Value(id),
      uuidAccountId: uuidAccountId == null && nullToAbsent
          ? const Value.absent()
          : Value(uuidAccountId),
    );
  }

  factory AccountBackgroundData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AccountBackgroundData(
      id: serializer.fromJson<int>(json['id']),
      uuidAccountId: serializer.fromJson<AccountId?>(json['uuidAccountId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uuidAccountId': serializer.toJson<AccountId?>(uuidAccountId),
    };
  }

  AccountBackgroundData copyWith(
          {int? id, Value<AccountId?> uuidAccountId = const Value.absent()}) =>
      AccountBackgroundData(
        id: id ?? this.id,
        uuidAccountId:
            uuidAccountId.present ? uuidAccountId.value : this.uuidAccountId,
      );
  AccountBackgroundData copyWithCompanion(AccountBackgroundCompanion data) {
    return AccountBackgroundData(
      id: data.id.present ? data.id.value : this.id,
      uuidAccountId: data.uuidAccountId.present
          ? data.uuidAccountId.value
          : this.uuidAccountId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AccountBackgroundData(')
          ..write('id: $id, ')
          ..write('uuidAccountId: $uuidAccountId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, uuidAccountId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AccountBackgroundData &&
          other.id == this.id &&
          other.uuidAccountId == this.uuidAccountId);
}

class AccountBackgroundCompanion
    extends UpdateCompanion<AccountBackgroundData> {
  final Value<int> id;
  final Value<AccountId?> uuidAccountId;
  const AccountBackgroundCompanion({
    this.id = const Value.absent(),
    this.uuidAccountId = const Value.absent(),
  });
  AccountBackgroundCompanion.insert({
    this.id = const Value.absent(),
    this.uuidAccountId = const Value.absent(),
  });
  static Insertable<AccountBackgroundData> custom({
    Expression<int>? id,
    Expression<String>? uuidAccountId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuidAccountId != null) 'uuid_account_id': uuidAccountId,
    });
  }

  AccountBackgroundCompanion copyWith(
      {Value<int>? id, Value<AccountId?>? uuidAccountId}) {
    return AccountBackgroundCompanion(
      id: id ?? this.id,
      uuidAccountId: uuidAccountId ?? this.uuidAccountId,
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AccountBackgroundCompanion(')
          ..write('id: $id, ')
          ..write('uuidAccountId: $uuidAccountId')
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
  List<GeneratedColumn> get $columns =>
      [id, uuidAccountId, profileName, profileNameAccepted];
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
      profileNameAccepted: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}profile_name_accepted']),
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
  final bool? profileNameAccepted;
  const ProfilesBackgroundData(
      {required this.id,
      required this.uuidAccountId,
      this.profileName,
      this.profileNameAccepted});
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
    if (!nullToAbsent || profileNameAccepted != null) {
      map['profile_name_accepted'] = Variable<bool>(profileNameAccepted);
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
      profileNameAccepted: profileNameAccepted == null && nullToAbsent
          ? const Value.absent()
          : Value(profileNameAccepted),
    );
  }

  factory ProfilesBackgroundData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProfilesBackgroundData(
      id: serializer.fromJson<int>(json['id']),
      uuidAccountId: serializer.fromJson<AccountId>(json['uuidAccountId']),
      profileName: serializer.fromJson<String?>(json['profileName']),
      profileNameAccepted:
          serializer.fromJson<bool?>(json['profileNameAccepted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uuidAccountId': serializer.toJson<AccountId>(uuidAccountId),
      'profileName': serializer.toJson<String?>(profileName),
      'profileNameAccepted': serializer.toJson<bool?>(profileNameAccepted),
    };
  }

  ProfilesBackgroundData copyWith(
          {int? id,
          AccountId? uuidAccountId,
          Value<String?> profileName = const Value.absent(),
          Value<bool?> profileNameAccepted = const Value.absent()}) =>
      ProfilesBackgroundData(
        id: id ?? this.id,
        uuidAccountId: uuidAccountId ?? this.uuidAccountId,
        profileName: profileName.present ? profileName.value : this.profileName,
        profileNameAccepted: profileNameAccepted.present
            ? profileNameAccepted.value
            : this.profileNameAccepted,
      );
  ProfilesBackgroundData copyWithCompanion(ProfilesBackgroundCompanion data) {
    return ProfilesBackgroundData(
      id: data.id.present ? data.id.value : this.id,
      uuidAccountId: data.uuidAccountId.present
          ? data.uuidAccountId.value
          : this.uuidAccountId,
      profileName:
          data.profileName.present ? data.profileName.value : this.profileName,
      profileNameAccepted: data.profileNameAccepted.present
          ? data.profileNameAccepted.value
          : this.profileNameAccepted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProfilesBackgroundData(')
          ..write('id: $id, ')
          ..write('uuidAccountId: $uuidAccountId, ')
          ..write('profileName: $profileName, ')
          ..write('profileNameAccepted: $profileNameAccepted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, uuidAccountId, profileName, profileNameAccepted);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProfilesBackgroundData &&
          other.id == this.id &&
          other.uuidAccountId == this.uuidAccountId &&
          other.profileName == this.profileName &&
          other.profileNameAccepted == this.profileNameAccepted);
}

class ProfilesBackgroundCompanion
    extends UpdateCompanion<ProfilesBackgroundData> {
  final Value<int> id;
  final Value<AccountId> uuidAccountId;
  final Value<String?> profileName;
  final Value<bool?> profileNameAccepted;
  const ProfilesBackgroundCompanion({
    this.id = const Value.absent(),
    this.uuidAccountId = const Value.absent(),
    this.profileName = const Value.absent(),
    this.profileNameAccepted = const Value.absent(),
  });
  ProfilesBackgroundCompanion.insert({
    this.id = const Value.absent(),
    required AccountId uuidAccountId,
    this.profileName = const Value.absent(),
    this.profileNameAccepted = const Value.absent(),
  }) : uuidAccountId = Value(uuidAccountId);
  static Insertable<ProfilesBackgroundData> custom({
    Expression<int>? id,
    Expression<String>? uuidAccountId,
    Expression<String>? profileName,
    Expression<bool>? profileNameAccepted,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuidAccountId != null) 'uuid_account_id': uuidAccountId,
      if (profileName != null) 'profile_name': profileName,
      if (profileNameAccepted != null)
        'profile_name_accepted': profileNameAccepted,
    });
  }

  ProfilesBackgroundCompanion copyWith(
      {Value<int>? id,
      Value<AccountId>? uuidAccountId,
      Value<String?>? profileName,
      Value<bool?>? profileNameAccepted}) {
    return ProfilesBackgroundCompanion(
      id: id ?? this.id,
      uuidAccountId: uuidAccountId ?? this.uuidAccountId,
      profileName: profileName ?? this.profileName,
      profileNameAccepted: profileNameAccepted ?? this.profileNameAccepted,
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
    if (profileNameAccepted.present) {
      map['profile_name_accepted'] = Variable<bool>(profileNameAccepted.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProfilesBackgroundCompanion(')
          ..write('id: $id, ')
          ..write('uuidAccountId: $uuidAccountId, ')
          ..write('profileName: $profileName, ')
          ..write('profileNameAccepted: $profileNameAccepted')
          ..write(')'))
        .toString();
  }
}

class $ConversationsBackgroundTable extends ConversationsBackground
    with TableInfo<$ConversationsBackgroundTable, ConversationsBackgroundData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ConversationsBackgroundTable(this.attachedDatabase, [this._alias]);
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
  late final GeneratedColumnWithTypeConverter<AccountId, String> uuidAccountId =
      GeneratedColumn<String>('uuid_account_id', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: true,
              defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'))
          .withConverter<AccountId>(
              $ConversationsBackgroundTable.$converteruuidAccountId);
  @override
  late final GeneratedColumnWithTypeConverter<UnreadMessagesCount, int>
      conversationUnreadMessagesCount = GeneratedColumn<int>(
              'conversation_unread_messages_count', aliasedName, false,
              type: DriftSqlType.int,
              requiredDuringInsert: false,
              defaultValue: const Constant(0))
          .withConverter<UnreadMessagesCount>($ConversationsBackgroundTable
              .$converterconversationUnreadMessagesCount);
  @override
  List<GeneratedColumn> get $columns =>
      [id, uuidAccountId, conversationUnreadMessagesCount];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'conversations_background';
  @override
  VerificationContext validateIntegrity(
      Insertable<ConversationsBackgroundData> instance,
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
  ConversationsBackgroundData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ConversationsBackgroundData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      uuidAccountId: $ConversationsBackgroundTable.$converteruuidAccountId
          .fromSql(attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}uuid_account_id'])!),
      conversationUnreadMessagesCount: $ConversationsBackgroundTable
          .$converterconversationUnreadMessagesCount
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.int,
              data['${effectivePrefix}conversation_unread_messages_count'])!),
    );
  }

  @override
  $ConversationsBackgroundTable createAlias(String alias) {
    return $ConversationsBackgroundTable(attachedDatabase, alias);
  }

  static TypeConverter<AccountId, String> $converteruuidAccountId =
      const AccountIdConverter();
  static TypeConverter<UnreadMessagesCount, int>
      $converterconversationUnreadMessagesCount =
      UnreadMessagesCountConverter();
}

class ConversationsBackgroundData extends DataClass
    implements Insertable<ConversationsBackgroundData> {
  final int id;
  final AccountId uuidAccountId;
  final UnreadMessagesCount conversationUnreadMessagesCount;
  const ConversationsBackgroundData(
      {required this.id,
      required this.uuidAccountId,
      required this.conversationUnreadMessagesCount});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['uuid_account_id'] = Variable<String>($ConversationsBackgroundTable
          .$converteruuidAccountId
          .toSql(uuidAccountId));
    }
    {
      map['conversation_unread_messages_count'] = Variable<int>(
          $ConversationsBackgroundTable
              .$converterconversationUnreadMessagesCount
              .toSql(conversationUnreadMessagesCount));
    }
    return map;
  }

  ConversationsBackgroundCompanion toCompanion(bool nullToAbsent) {
    return ConversationsBackgroundCompanion(
      id: Value(id),
      uuidAccountId: Value(uuidAccountId),
      conversationUnreadMessagesCount: Value(conversationUnreadMessagesCount),
    );
  }

  factory ConversationsBackgroundData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ConversationsBackgroundData(
      id: serializer.fromJson<int>(json['id']),
      uuidAccountId: serializer.fromJson<AccountId>(json['uuidAccountId']),
      conversationUnreadMessagesCount: serializer.fromJson<UnreadMessagesCount>(
          json['conversationUnreadMessagesCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uuidAccountId': serializer.toJson<AccountId>(uuidAccountId),
      'conversationUnreadMessagesCount': serializer
          .toJson<UnreadMessagesCount>(conversationUnreadMessagesCount),
    };
  }

  ConversationsBackgroundData copyWith(
          {int? id,
          AccountId? uuidAccountId,
          UnreadMessagesCount? conversationUnreadMessagesCount}) =>
      ConversationsBackgroundData(
        id: id ?? this.id,
        uuidAccountId: uuidAccountId ?? this.uuidAccountId,
        conversationUnreadMessagesCount: conversationUnreadMessagesCount ??
            this.conversationUnreadMessagesCount,
      );
  ConversationsBackgroundData copyWithCompanion(
      ConversationsBackgroundCompanion data) {
    return ConversationsBackgroundData(
      id: data.id.present ? data.id.value : this.id,
      uuidAccountId: data.uuidAccountId.present
          ? data.uuidAccountId.value
          : this.uuidAccountId,
      conversationUnreadMessagesCount:
          data.conversationUnreadMessagesCount.present
              ? data.conversationUnreadMessagesCount.value
              : this.conversationUnreadMessagesCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ConversationsBackgroundData(')
          ..write('id: $id, ')
          ..write('uuidAccountId: $uuidAccountId, ')
          ..write(
              'conversationUnreadMessagesCount: $conversationUnreadMessagesCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, uuidAccountId, conversationUnreadMessagesCount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ConversationsBackgroundData &&
          other.id == this.id &&
          other.uuidAccountId == this.uuidAccountId &&
          other.conversationUnreadMessagesCount ==
              this.conversationUnreadMessagesCount);
}

class ConversationsBackgroundCompanion
    extends UpdateCompanion<ConversationsBackgroundData> {
  final Value<int> id;
  final Value<AccountId> uuidAccountId;
  final Value<UnreadMessagesCount> conversationUnreadMessagesCount;
  const ConversationsBackgroundCompanion({
    this.id = const Value.absent(),
    this.uuidAccountId = const Value.absent(),
    this.conversationUnreadMessagesCount = const Value.absent(),
  });
  ConversationsBackgroundCompanion.insert({
    this.id = const Value.absent(),
    required AccountId uuidAccountId,
    this.conversationUnreadMessagesCount = const Value.absent(),
  }) : uuidAccountId = Value(uuidAccountId);
  static Insertable<ConversationsBackgroundData> custom({
    Expression<int>? id,
    Expression<String>? uuidAccountId,
    Expression<int>? conversationUnreadMessagesCount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuidAccountId != null) 'uuid_account_id': uuidAccountId,
      if (conversationUnreadMessagesCount != null)
        'conversation_unread_messages_count': conversationUnreadMessagesCount,
    });
  }

  ConversationsBackgroundCompanion copyWith(
      {Value<int>? id,
      Value<AccountId>? uuidAccountId,
      Value<UnreadMessagesCount>? conversationUnreadMessagesCount}) {
    return ConversationsBackgroundCompanion(
      id: id ?? this.id,
      uuidAccountId: uuidAccountId ?? this.uuidAccountId,
      conversationUnreadMessagesCount: conversationUnreadMessagesCount ??
          this.conversationUnreadMessagesCount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uuidAccountId.present) {
      map['uuid_account_id'] = Variable<String>($ConversationsBackgroundTable
          .$converteruuidAccountId
          .toSql(uuidAccountId.value));
    }
    if (conversationUnreadMessagesCount.present) {
      map['conversation_unread_messages_count'] = Variable<int>(
          $ConversationsBackgroundTable
              .$converterconversationUnreadMessagesCount
              .toSql(conversationUnreadMessagesCount.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ConversationsBackgroundCompanion(')
          ..write('id: $id, ')
          ..write('uuidAccountId: $uuidAccountId, ')
          ..write(
              'conversationUnreadMessagesCount: $conversationUnreadMessagesCount')
          ..write(')'))
        .toString();
  }
}

class $NewMessageNotificationTable extends NewMessageNotification
    with TableInfo<$NewMessageNotificationTable, NewMessageNotificationData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NewMessageNotificationTable(this.attachedDatabase, [this._alias]);
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
  late final GeneratedColumnWithTypeConverter<AccountId, String> uuidAccountId =
      GeneratedColumn<String>('uuid_account_id', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: true,
              defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'))
          .withConverter<AccountId>(
              $NewMessageNotificationTable.$converteruuidAccountId);
  static const VerificationMeta _notificationShownMeta =
      const VerificationMeta('notificationShown');
  @override
  late final GeneratedColumn<bool> notificationShown = GeneratedColumn<bool>(
      'notification_shown', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("notification_shown" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [id, uuidAccountId, notificationShown];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'new_message_notification';
  @override
  VerificationContext validateIntegrity(
      Insertable<NewMessageNotificationData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('notification_shown')) {
      context.handle(
          _notificationShownMeta,
          notificationShown.isAcceptableOrUnknown(
              data['notification_shown']!, _notificationShownMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NewMessageNotificationData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NewMessageNotificationData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      uuidAccountId: $NewMessageNotificationTable.$converteruuidAccountId
          .fromSql(attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}uuid_account_id'])!),
      notificationShown: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}notification_shown'])!,
    );
  }

  @override
  $NewMessageNotificationTable createAlias(String alias) {
    return $NewMessageNotificationTable(attachedDatabase, alias);
  }

  static TypeConverter<AccountId, String> $converteruuidAccountId =
      const AccountIdConverter();
}

class NewMessageNotificationData extends DataClass
    implements Insertable<NewMessageNotificationData> {
  final int id;
  final AccountId uuidAccountId;
  final bool notificationShown;
  const NewMessageNotificationData(
      {required this.id,
      required this.uuidAccountId,
      required this.notificationShown});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['uuid_account_id'] = Variable<String>($NewMessageNotificationTable
          .$converteruuidAccountId
          .toSql(uuidAccountId));
    }
    map['notification_shown'] = Variable<bool>(notificationShown);
    return map;
  }

  NewMessageNotificationCompanion toCompanion(bool nullToAbsent) {
    return NewMessageNotificationCompanion(
      id: Value(id),
      uuidAccountId: Value(uuidAccountId),
      notificationShown: Value(notificationShown),
    );
  }

  factory NewMessageNotificationData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NewMessageNotificationData(
      id: serializer.fromJson<int>(json['id']),
      uuidAccountId: serializer.fromJson<AccountId>(json['uuidAccountId']),
      notificationShown: serializer.fromJson<bool>(json['notificationShown']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uuidAccountId': serializer.toJson<AccountId>(uuidAccountId),
      'notificationShown': serializer.toJson<bool>(notificationShown),
    };
  }

  NewMessageNotificationData copyWith(
          {int? id, AccountId? uuidAccountId, bool? notificationShown}) =>
      NewMessageNotificationData(
        id: id ?? this.id,
        uuidAccountId: uuidAccountId ?? this.uuidAccountId,
        notificationShown: notificationShown ?? this.notificationShown,
      );
  NewMessageNotificationData copyWithCompanion(
      NewMessageNotificationCompanion data) {
    return NewMessageNotificationData(
      id: data.id.present ? data.id.value : this.id,
      uuidAccountId: data.uuidAccountId.present
          ? data.uuidAccountId.value
          : this.uuidAccountId,
      notificationShown: data.notificationShown.present
          ? data.notificationShown.value
          : this.notificationShown,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NewMessageNotificationData(')
          ..write('id: $id, ')
          ..write('uuidAccountId: $uuidAccountId, ')
          ..write('notificationShown: $notificationShown')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, uuidAccountId, notificationShown);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NewMessageNotificationData &&
          other.id == this.id &&
          other.uuidAccountId == this.uuidAccountId &&
          other.notificationShown == this.notificationShown);
}

class NewMessageNotificationCompanion
    extends UpdateCompanion<NewMessageNotificationData> {
  final Value<int> id;
  final Value<AccountId> uuidAccountId;
  final Value<bool> notificationShown;
  const NewMessageNotificationCompanion({
    this.id = const Value.absent(),
    this.uuidAccountId = const Value.absent(),
    this.notificationShown = const Value.absent(),
  });
  NewMessageNotificationCompanion.insert({
    this.id = const Value.absent(),
    required AccountId uuidAccountId,
    this.notificationShown = const Value.absent(),
  }) : uuidAccountId = Value(uuidAccountId);
  static Insertable<NewMessageNotificationData> custom({
    Expression<int>? id,
    Expression<String>? uuidAccountId,
    Expression<bool>? notificationShown,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuidAccountId != null) 'uuid_account_id': uuidAccountId,
      if (notificationShown != null) 'notification_shown': notificationShown,
    });
  }

  NewMessageNotificationCompanion copyWith(
      {Value<int>? id,
      Value<AccountId>? uuidAccountId,
      Value<bool>? notificationShown}) {
    return NewMessageNotificationCompanion(
      id: id ?? this.id,
      uuidAccountId: uuidAccountId ?? this.uuidAccountId,
      notificationShown: notificationShown ?? this.notificationShown,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uuidAccountId.present) {
      map['uuid_account_id'] = Variable<String>($NewMessageNotificationTable
          .$converteruuidAccountId
          .toSql(uuidAccountId.value));
    }
    if (notificationShown.present) {
      map['notification_shown'] = Variable<bool>(notificationShown.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NewMessageNotificationCompanion(')
          ..write('id: $id, ')
          ..write('uuidAccountId: $uuidAccountId, ')
          ..write('notificationShown: $notificationShown')
          ..write(')'))
        .toString();
  }
}

class $NewReceivedLikesAvailableTable extends NewReceivedLikesAvailable
    with
        TableInfo<$NewReceivedLikesAvailableTable,
            NewReceivedLikesAvailableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NewReceivedLikesAvailableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _syncVersionReceivedLikesMeta =
      const VerificationMeta('syncVersionReceivedLikes');
  @override
  late final GeneratedColumn<int> syncVersionReceivedLikes =
      GeneratedColumn<int>('sync_version_received_likes', aliasedName, true,
          type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  late final GeneratedColumnWithTypeConverter<NewReceivedLikesCount?, int>
      newReceivedLikesCount = GeneratedColumn<int>(
              'new_received_likes_count', aliasedName, true,
              type: DriftSqlType.int, requiredDuringInsert: false)
          .withConverter<NewReceivedLikesCount?>(
              $NewReceivedLikesAvailableTable.$converternewReceivedLikesCount);
  @override
  late final GeneratedColumnWithTypeConverter<NewReceivedLikesCount?, int>
      newReceivedLikesCountNotViewed = GeneratedColumn<int>(
              'new_received_likes_count_not_viewed', aliasedName, true,
              type: DriftSqlType.int, requiredDuringInsert: false)
          .withConverter<NewReceivedLikesCount?>($NewReceivedLikesAvailableTable
              .$converternewReceivedLikesCountNotViewed);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        syncVersionReceivedLikes,
        newReceivedLikesCount,
        newReceivedLikesCountNotViewed
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'new_received_likes_available';
  @override
  VerificationContext validateIntegrity(
      Insertable<NewReceivedLikesAvailableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('sync_version_received_likes')) {
      context.handle(
          _syncVersionReceivedLikesMeta,
          syncVersionReceivedLikes.isAcceptableOrUnknown(
              data['sync_version_received_likes']!,
              _syncVersionReceivedLikesMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NewReceivedLikesAvailableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NewReceivedLikesAvailableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      syncVersionReceivedLikes: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}sync_version_received_likes']),
      newReceivedLikesCount: $NewReceivedLikesAvailableTable
          .$converternewReceivedLikesCount
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.int,
              data['${effectivePrefix}new_received_likes_count'])),
      newReceivedLikesCountNotViewed: $NewReceivedLikesAvailableTable
          .$converternewReceivedLikesCountNotViewed
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.int,
              data['${effectivePrefix}new_received_likes_count_not_viewed'])),
    );
  }

  @override
  $NewReceivedLikesAvailableTable createAlias(String alias) {
    return $NewReceivedLikesAvailableTable(attachedDatabase, alias);
  }

  static TypeConverter<NewReceivedLikesCount?, int?>
      $converternewReceivedLikesCount =
      const NullAwareTypeConverter.wrap(NewReceivedLikesCountConverter());
  static TypeConverter<NewReceivedLikesCount?, int?>
      $converternewReceivedLikesCountNotViewed =
      const NullAwareTypeConverter.wrap(NewReceivedLikesCountConverter());
}

class NewReceivedLikesAvailableData extends DataClass
    implements Insertable<NewReceivedLikesAvailableData> {
  final int id;
  final int? syncVersionReceivedLikes;
  final NewReceivedLikesCount? newReceivedLikesCount;

  /// Count which will be reset once user views received likes screen
  final NewReceivedLikesCount? newReceivedLikesCountNotViewed;
  const NewReceivedLikesAvailableData(
      {required this.id,
      this.syncVersionReceivedLikes,
      this.newReceivedLikesCount,
      this.newReceivedLikesCountNotViewed});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || syncVersionReceivedLikes != null) {
      map['sync_version_received_likes'] =
          Variable<int>(syncVersionReceivedLikes);
    }
    if (!nullToAbsent || newReceivedLikesCount != null) {
      map['new_received_likes_count'] = Variable<int>(
          $NewReceivedLikesAvailableTable.$converternewReceivedLikesCount
              .toSql(newReceivedLikesCount));
    }
    if (!nullToAbsent || newReceivedLikesCountNotViewed != null) {
      map['new_received_likes_count_not_viewed'] = Variable<int>(
          $NewReceivedLikesAvailableTable
              .$converternewReceivedLikesCountNotViewed
              .toSql(newReceivedLikesCountNotViewed));
    }
    return map;
  }

  NewReceivedLikesAvailableCompanion toCompanion(bool nullToAbsent) {
    return NewReceivedLikesAvailableCompanion(
      id: Value(id),
      syncVersionReceivedLikes: syncVersionReceivedLikes == null && nullToAbsent
          ? const Value.absent()
          : Value(syncVersionReceivedLikes),
      newReceivedLikesCount: newReceivedLikesCount == null && nullToAbsent
          ? const Value.absent()
          : Value(newReceivedLikesCount),
      newReceivedLikesCountNotViewed:
          newReceivedLikesCountNotViewed == null && nullToAbsent
              ? const Value.absent()
              : Value(newReceivedLikesCountNotViewed),
    );
  }

  factory NewReceivedLikesAvailableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NewReceivedLikesAvailableData(
      id: serializer.fromJson<int>(json['id']),
      syncVersionReceivedLikes:
          serializer.fromJson<int?>(json['syncVersionReceivedLikes']),
      newReceivedLikesCount: serializer
          .fromJson<NewReceivedLikesCount?>(json['newReceivedLikesCount']),
      newReceivedLikesCountNotViewed:
          serializer.fromJson<NewReceivedLikesCount?>(
              json['newReceivedLikesCountNotViewed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'syncVersionReceivedLikes':
          serializer.toJson<int?>(syncVersionReceivedLikes),
      'newReceivedLikesCount':
          serializer.toJson<NewReceivedLikesCount?>(newReceivedLikesCount),
      'newReceivedLikesCountNotViewed': serializer
          .toJson<NewReceivedLikesCount?>(newReceivedLikesCountNotViewed),
    };
  }

  NewReceivedLikesAvailableData copyWith(
          {int? id,
          Value<int?> syncVersionReceivedLikes = const Value.absent(),
          Value<NewReceivedLikesCount?> newReceivedLikesCount =
              const Value.absent(),
          Value<NewReceivedLikesCount?> newReceivedLikesCountNotViewed =
              const Value.absent()}) =>
      NewReceivedLikesAvailableData(
        id: id ?? this.id,
        syncVersionReceivedLikes: syncVersionReceivedLikes.present
            ? syncVersionReceivedLikes.value
            : this.syncVersionReceivedLikes,
        newReceivedLikesCount: newReceivedLikesCount.present
            ? newReceivedLikesCount.value
            : this.newReceivedLikesCount,
        newReceivedLikesCountNotViewed: newReceivedLikesCountNotViewed.present
            ? newReceivedLikesCountNotViewed.value
            : this.newReceivedLikesCountNotViewed,
      );
  NewReceivedLikesAvailableData copyWithCompanion(
      NewReceivedLikesAvailableCompanion data) {
    return NewReceivedLikesAvailableData(
      id: data.id.present ? data.id.value : this.id,
      syncVersionReceivedLikes: data.syncVersionReceivedLikes.present
          ? data.syncVersionReceivedLikes.value
          : this.syncVersionReceivedLikes,
      newReceivedLikesCount: data.newReceivedLikesCount.present
          ? data.newReceivedLikesCount.value
          : this.newReceivedLikesCount,
      newReceivedLikesCountNotViewed:
          data.newReceivedLikesCountNotViewed.present
              ? data.newReceivedLikesCountNotViewed.value
              : this.newReceivedLikesCountNotViewed,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NewReceivedLikesAvailableData(')
          ..write('id: $id, ')
          ..write('syncVersionReceivedLikes: $syncVersionReceivedLikes, ')
          ..write('newReceivedLikesCount: $newReceivedLikesCount, ')
          ..write(
              'newReceivedLikesCountNotViewed: $newReceivedLikesCountNotViewed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, syncVersionReceivedLikes,
      newReceivedLikesCount, newReceivedLikesCountNotViewed);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NewReceivedLikesAvailableData &&
          other.id == this.id &&
          other.syncVersionReceivedLikes == this.syncVersionReceivedLikes &&
          other.newReceivedLikesCount == this.newReceivedLikesCount &&
          other.newReceivedLikesCountNotViewed ==
              this.newReceivedLikesCountNotViewed);
}

class NewReceivedLikesAvailableCompanion
    extends UpdateCompanion<NewReceivedLikesAvailableData> {
  final Value<int> id;
  final Value<int?> syncVersionReceivedLikes;
  final Value<NewReceivedLikesCount?> newReceivedLikesCount;
  final Value<NewReceivedLikesCount?> newReceivedLikesCountNotViewed;
  const NewReceivedLikesAvailableCompanion({
    this.id = const Value.absent(),
    this.syncVersionReceivedLikes = const Value.absent(),
    this.newReceivedLikesCount = const Value.absent(),
    this.newReceivedLikesCountNotViewed = const Value.absent(),
  });
  NewReceivedLikesAvailableCompanion.insert({
    this.id = const Value.absent(),
    this.syncVersionReceivedLikes = const Value.absent(),
    this.newReceivedLikesCount = const Value.absent(),
    this.newReceivedLikesCountNotViewed = const Value.absent(),
  });
  static Insertable<NewReceivedLikesAvailableData> custom({
    Expression<int>? id,
    Expression<int>? syncVersionReceivedLikes,
    Expression<int>? newReceivedLikesCount,
    Expression<int>? newReceivedLikesCountNotViewed,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (syncVersionReceivedLikes != null)
        'sync_version_received_likes': syncVersionReceivedLikes,
      if (newReceivedLikesCount != null)
        'new_received_likes_count': newReceivedLikesCount,
      if (newReceivedLikesCountNotViewed != null)
        'new_received_likes_count_not_viewed': newReceivedLikesCountNotViewed,
    });
  }

  NewReceivedLikesAvailableCompanion copyWith(
      {Value<int>? id,
      Value<int?>? syncVersionReceivedLikes,
      Value<NewReceivedLikesCount?>? newReceivedLikesCount,
      Value<NewReceivedLikesCount?>? newReceivedLikesCountNotViewed}) {
    return NewReceivedLikesAvailableCompanion(
      id: id ?? this.id,
      syncVersionReceivedLikes:
          syncVersionReceivedLikes ?? this.syncVersionReceivedLikes,
      newReceivedLikesCount:
          newReceivedLikesCount ?? this.newReceivedLikesCount,
      newReceivedLikesCountNotViewed:
          newReceivedLikesCountNotViewed ?? this.newReceivedLikesCountNotViewed,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (syncVersionReceivedLikes.present) {
      map['sync_version_received_likes'] =
          Variable<int>(syncVersionReceivedLikes.value);
    }
    if (newReceivedLikesCount.present) {
      map['new_received_likes_count'] = Variable<int>(
          $NewReceivedLikesAvailableTable.$converternewReceivedLikesCount
              .toSql(newReceivedLikesCount.value));
    }
    if (newReceivedLikesCountNotViewed.present) {
      map['new_received_likes_count_not_viewed'] = Variable<int>(
          $NewReceivedLikesAvailableTable
              .$converternewReceivedLikesCountNotViewed
              .toSql(newReceivedLikesCountNotViewed.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NewReceivedLikesAvailableCompanion(')
          ..write('id: $id, ')
          ..write('syncVersionReceivedLikes: $syncVersionReceivedLikes, ')
          ..write('newReceivedLikesCount: $newReceivedLikesCount, ')
          ..write(
              'newReceivedLikesCountNotViewed: $newReceivedLikesCountNotViewed')
          ..write(')'))
        .toString();
  }
}

class $NewsTable extends News with TableInfo<$NewsTable, New> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NewsTable(this.attachedDatabase, [this._alias]);
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
  late final GeneratedColumnWithTypeConverter<UnreadNewsCount?, int> newsCount =
      GeneratedColumn<int>('news_count', aliasedName, true,
              type: DriftSqlType.int, requiredDuringInsert: false)
          .withConverter<UnreadNewsCount?>($NewsTable.$converternewsCount);
  static const VerificationMeta _syncVersionNewsMeta =
      const VerificationMeta('syncVersionNews');
  @override
  late final GeneratedColumn<int> syncVersionNews = GeneratedColumn<int>(
      'sync_version_news', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, newsCount, syncVersionNews];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'news';
  @override
  VerificationContext validateIntegrity(Insertable<New> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('sync_version_news')) {
      context.handle(
          _syncVersionNewsMeta,
          syncVersionNews.isAcceptableOrUnknown(
              data['sync_version_news']!, _syncVersionNewsMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  New map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return New(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      newsCount: $NewsTable.$converternewsCount.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}news_count'])),
      syncVersionNews: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sync_version_news']),
    );
  }

  @override
  $NewsTable createAlias(String alias) {
    return $NewsTable(attachedDatabase, alias);
  }

  static TypeConverter<UnreadNewsCount?, int?> $converternewsCount =
      const NullAwareTypeConverter.wrap(UnreadNewsCountConverter());
}

class New extends DataClass implements Insertable<New> {
  final int id;
  final UnreadNewsCount? newsCount;
  final int? syncVersionNews;
  const New({required this.id, this.newsCount, this.syncVersionNews});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || newsCount != null) {
      map['news_count'] =
          Variable<int>($NewsTable.$converternewsCount.toSql(newsCount));
    }
    if (!nullToAbsent || syncVersionNews != null) {
      map['sync_version_news'] = Variable<int>(syncVersionNews);
    }
    return map;
  }

  NewsCompanion toCompanion(bool nullToAbsent) {
    return NewsCompanion(
      id: Value(id),
      newsCount: newsCount == null && nullToAbsent
          ? const Value.absent()
          : Value(newsCount),
      syncVersionNews: syncVersionNews == null && nullToAbsent
          ? const Value.absent()
          : Value(syncVersionNews),
    );
  }

  factory New.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return New(
      id: serializer.fromJson<int>(json['id']),
      newsCount: serializer.fromJson<UnreadNewsCount?>(json['newsCount']),
      syncVersionNews: serializer.fromJson<int?>(json['syncVersionNews']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'newsCount': serializer.toJson<UnreadNewsCount?>(newsCount),
      'syncVersionNews': serializer.toJson<int?>(syncVersionNews),
    };
  }

  New copyWith(
          {int? id,
          Value<UnreadNewsCount?> newsCount = const Value.absent(),
          Value<int?> syncVersionNews = const Value.absent()}) =>
      New(
        id: id ?? this.id,
        newsCount: newsCount.present ? newsCount.value : this.newsCount,
        syncVersionNews: syncVersionNews.present
            ? syncVersionNews.value
            : this.syncVersionNews,
      );
  New copyWithCompanion(NewsCompanion data) {
    return New(
      id: data.id.present ? data.id.value : this.id,
      newsCount: data.newsCount.present ? data.newsCount.value : this.newsCount,
      syncVersionNews: data.syncVersionNews.present
          ? data.syncVersionNews.value
          : this.syncVersionNews,
    );
  }

  @override
  String toString() {
    return (StringBuffer('New(')
          ..write('id: $id, ')
          ..write('newsCount: $newsCount, ')
          ..write('syncVersionNews: $syncVersionNews')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, newsCount, syncVersionNews);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is New &&
          other.id == this.id &&
          other.newsCount == this.newsCount &&
          other.syncVersionNews == this.syncVersionNews);
}

class NewsCompanion extends UpdateCompanion<New> {
  final Value<int> id;
  final Value<UnreadNewsCount?> newsCount;
  final Value<int?> syncVersionNews;
  const NewsCompanion({
    this.id = const Value.absent(),
    this.newsCount = const Value.absent(),
    this.syncVersionNews = const Value.absent(),
  });
  NewsCompanion.insert({
    this.id = const Value.absent(),
    this.newsCount = const Value.absent(),
    this.syncVersionNews = const Value.absent(),
  });
  static Insertable<New> custom({
    Expression<int>? id,
    Expression<int>? newsCount,
    Expression<int>? syncVersionNews,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (newsCount != null) 'news_count': newsCount,
      if (syncVersionNews != null) 'sync_version_news': syncVersionNews,
    });
  }

  NewsCompanion copyWith(
      {Value<int>? id,
      Value<UnreadNewsCount?>? newsCount,
      Value<int?>? syncVersionNews}) {
    return NewsCompanion(
      id: id ?? this.id,
      newsCount: newsCount ?? this.newsCount,
      syncVersionNews: syncVersionNews ?? this.syncVersionNews,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (newsCount.present) {
      map['news_count'] =
          Variable<int>($NewsTable.$converternewsCount.toSql(newsCount.value));
    }
    if (syncVersionNews.present) {
      map['sync_version_news'] = Variable<int>(syncVersionNews.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NewsCompanion(')
          ..write('id: $id, ')
          ..write('newsCount: $newsCount, ')
          ..write('syncVersionNews: $syncVersionNews')
          ..write(')'))
        .toString();
  }
}

class $MediaContentModerationCompletedNotificationTableTable
    extends MediaContentModerationCompletedNotificationTable
    with
        TableInfo<$MediaContentModerationCompletedNotificationTableTable,
            MediaContentModerationCompletedNotificationTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MediaContentModerationCompletedNotificationTableTable(this.attachedDatabase,
      [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _acceptedMeta =
      const VerificationMeta('accepted');
  @override
  late final GeneratedColumn<int> accepted = GeneratedColumn<int>(
      'accepted', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _acceptedViewedMeta =
      const VerificationMeta('acceptedViewed');
  @override
  late final GeneratedColumn<int> acceptedViewed = GeneratedColumn<int>(
      'accepted_viewed', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _rejectedMeta =
      const VerificationMeta('rejected');
  @override
  late final GeneratedColumn<int> rejected = GeneratedColumn<int>(
      'rejected', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _rejectedViewedMeta =
      const VerificationMeta('rejectedViewed');
  @override
  late final GeneratedColumn<int> rejectedViewed = GeneratedColumn<int>(
      'rejected_viewed', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns =>
      [id, accepted, acceptedViewed, rejected, rejectedViewed];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name =
      'media_content_moderation_completed_notification_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<MediaContentModerationCompletedNotificationTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('accepted')) {
      context.handle(_acceptedMeta,
          accepted.isAcceptableOrUnknown(data['accepted']!, _acceptedMeta));
    }
    if (data.containsKey('accepted_viewed')) {
      context.handle(
          _acceptedViewedMeta,
          acceptedViewed.isAcceptableOrUnknown(
              data['accepted_viewed']!, _acceptedViewedMeta));
    }
    if (data.containsKey('rejected')) {
      context.handle(_rejectedMeta,
          rejected.isAcceptableOrUnknown(data['rejected']!, _rejectedMeta));
    }
    if (data.containsKey('rejected_viewed')) {
      context.handle(
          _rejectedViewedMeta,
          rejectedViewed.isAcceptableOrUnknown(
              data['rejected_viewed']!, _rejectedViewedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MediaContentModerationCompletedNotificationTableData map(
      Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MediaContentModerationCompletedNotificationTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      accepted: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}accepted'])!,
      acceptedViewed: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}accepted_viewed'])!,
      rejected: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}rejected'])!,
      rejectedViewed: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}rejected_viewed'])!,
    );
  }

  @override
  $MediaContentModerationCompletedNotificationTableTable createAlias(
      String alias) {
    return $MediaContentModerationCompletedNotificationTableTable(
        attachedDatabase, alias);
  }
}

class MediaContentModerationCompletedNotificationTableData extends DataClass
    implements
        Insertable<MediaContentModerationCompletedNotificationTableData> {
  final int id;
  final int accepted;
  final int acceptedViewed;
  final int rejected;
  final int rejectedViewed;
  const MediaContentModerationCompletedNotificationTableData(
      {required this.id,
      required this.accepted,
      required this.acceptedViewed,
      required this.rejected,
      required this.rejectedViewed});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['accepted'] = Variable<int>(accepted);
    map['accepted_viewed'] = Variable<int>(acceptedViewed);
    map['rejected'] = Variable<int>(rejected);
    map['rejected_viewed'] = Variable<int>(rejectedViewed);
    return map;
  }

  MediaContentModerationCompletedNotificationTableCompanion toCompanion(
      bool nullToAbsent) {
    return MediaContentModerationCompletedNotificationTableCompanion(
      id: Value(id),
      accepted: Value(accepted),
      acceptedViewed: Value(acceptedViewed),
      rejected: Value(rejected),
      rejectedViewed: Value(rejectedViewed),
    );
  }

  factory MediaContentModerationCompletedNotificationTableData.fromJson(
      Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MediaContentModerationCompletedNotificationTableData(
      id: serializer.fromJson<int>(json['id']),
      accepted: serializer.fromJson<int>(json['accepted']),
      acceptedViewed: serializer.fromJson<int>(json['acceptedViewed']),
      rejected: serializer.fromJson<int>(json['rejected']),
      rejectedViewed: serializer.fromJson<int>(json['rejectedViewed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'accepted': serializer.toJson<int>(accepted),
      'acceptedViewed': serializer.toJson<int>(acceptedViewed),
      'rejected': serializer.toJson<int>(rejected),
      'rejectedViewed': serializer.toJson<int>(rejectedViewed),
    };
  }

  MediaContentModerationCompletedNotificationTableData copyWith(
          {int? id,
          int? accepted,
          int? acceptedViewed,
          int? rejected,
          int? rejectedViewed}) =>
      MediaContentModerationCompletedNotificationTableData(
        id: id ?? this.id,
        accepted: accepted ?? this.accepted,
        acceptedViewed: acceptedViewed ?? this.acceptedViewed,
        rejected: rejected ?? this.rejected,
        rejectedViewed: rejectedViewed ?? this.rejectedViewed,
      );
  MediaContentModerationCompletedNotificationTableData copyWithCompanion(
      MediaContentModerationCompletedNotificationTableCompanion data) {
    return MediaContentModerationCompletedNotificationTableData(
      id: data.id.present ? data.id.value : this.id,
      accepted: data.accepted.present ? data.accepted.value : this.accepted,
      acceptedViewed: data.acceptedViewed.present
          ? data.acceptedViewed.value
          : this.acceptedViewed,
      rejected: data.rejected.present ? data.rejected.value : this.rejected,
      rejectedViewed: data.rejectedViewed.present
          ? data.rejectedViewed.value
          : this.rejectedViewed,
    );
  }

  @override
  String toString() {
    return (StringBuffer(
            'MediaContentModerationCompletedNotificationTableData(')
          ..write('id: $id, ')
          ..write('accepted: $accepted, ')
          ..write('acceptedViewed: $acceptedViewed, ')
          ..write('rejected: $rejected, ')
          ..write('rejectedViewed: $rejectedViewed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, accepted, acceptedViewed, rejected, rejectedViewed);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MediaContentModerationCompletedNotificationTableData &&
          other.id == this.id &&
          other.accepted == this.accepted &&
          other.acceptedViewed == this.acceptedViewed &&
          other.rejected == this.rejected &&
          other.rejectedViewed == this.rejectedViewed);
}

class MediaContentModerationCompletedNotificationTableCompanion
    extends UpdateCompanion<
        MediaContentModerationCompletedNotificationTableData> {
  final Value<int> id;
  final Value<int> accepted;
  final Value<int> acceptedViewed;
  final Value<int> rejected;
  final Value<int> rejectedViewed;
  const MediaContentModerationCompletedNotificationTableCompanion({
    this.id = const Value.absent(),
    this.accepted = const Value.absent(),
    this.acceptedViewed = const Value.absent(),
    this.rejected = const Value.absent(),
    this.rejectedViewed = const Value.absent(),
  });
  MediaContentModerationCompletedNotificationTableCompanion.insert({
    this.id = const Value.absent(),
    this.accepted = const Value.absent(),
    this.acceptedViewed = const Value.absent(),
    this.rejected = const Value.absent(),
    this.rejectedViewed = const Value.absent(),
  });
  static Insertable<MediaContentModerationCompletedNotificationTableData>
      custom({
    Expression<int>? id,
    Expression<int>? accepted,
    Expression<int>? acceptedViewed,
    Expression<int>? rejected,
    Expression<int>? rejectedViewed,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (accepted != null) 'accepted': accepted,
      if (acceptedViewed != null) 'accepted_viewed': acceptedViewed,
      if (rejected != null) 'rejected': rejected,
      if (rejectedViewed != null) 'rejected_viewed': rejectedViewed,
    });
  }

  MediaContentModerationCompletedNotificationTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? accepted,
      Value<int>? acceptedViewed,
      Value<int>? rejected,
      Value<int>? rejectedViewed}) {
    return MediaContentModerationCompletedNotificationTableCompanion(
      id: id ?? this.id,
      accepted: accepted ?? this.accepted,
      acceptedViewed: acceptedViewed ?? this.acceptedViewed,
      rejected: rejected ?? this.rejected,
      rejectedViewed: rejectedViewed ?? this.rejectedViewed,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (accepted.present) {
      map['accepted'] = Variable<int>(accepted.value);
    }
    if (acceptedViewed.present) {
      map['accepted_viewed'] = Variable<int>(acceptedViewed.value);
    }
    if (rejected.present) {
      map['rejected'] = Variable<int>(rejected.value);
    }
    if (rejectedViewed.present) {
      map['rejected_viewed'] = Variable<int>(rejectedViewed.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer(
            'MediaContentModerationCompletedNotificationTableCompanion(')
          ..write('id: $id, ')
          ..write('accepted: $accepted, ')
          ..write('acceptedViewed: $acceptedViewed, ')
          ..write('rejected: $rejected, ')
          ..write('rejectedViewed: $rejectedViewed')
          ..write(')'))
        .toString();
  }
}

class $ProfileTextModerationCompletedNotificationTableTable
    extends ProfileTextModerationCompletedNotificationTable
    with
        TableInfo<$ProfileTextModerationCompletedNotificationTableTable,
            ProfileTextModerationCompletedNotificationTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProfileTextModerationCompletedNotificationTableTable(this.attachedDatabase,
      [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _acceptedMeta =
      const VerificationMeta('accepted');
  @override
  late final GeneratedColumn<int> accepted = GeneratedColumn<int>(
      'accepted', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _acceptedViewedMeta =
      const VerificationMeta('acceptedViewed');
  @override
  late final GeneratedColumn<int> acceptedViewed = GeneratedColumn<int>(
      'accepted_viewed', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _rejectedMeta =
      const VerificationMeta('rejected');
  @override
  late final GeneratedColumn<int> rejected = GeneratedColumn<int>(
      'rejected', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _rejectedViewedMeta =
      const VerificationMeta('rejectedViewed');
  @override
  late final GeneratedColumn<int> rejectedViewed = GeneratedColumn<int>(
      'rejected_viewed', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns =>
      [id, accepted, acceptedViewed, rejected, rejectedViewed];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name =
      'profile_text_moderation_completed_notification_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<ProfileTextModerationCompletedNotificationTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('accepted')) {
      context.handle(_acceptedMeta,
          accepted.isAcceptableOrUnknown(data['accepted']!, _acceptedMeta));
    }
    if (data.containsKey('accepted_viewed')) {
      context.handle(
          _acceptedViewedMeta,
          acceptedViewed.isAcceptableOrUnknown(
              data['accepted_viewed']!, _acceptedViewedMeta));
    }
    if (data.containsKey('rejected')) {
      context.handle(_rejectedMeta,
          rejected.isAcceptableOrUnknown(data['rejected']!, _rejectedMeta));
    }
    if (data.containsKey('rejected_viewed')) {
      context.handle(
          _rejectedViewedMeta,
          rejectedViewed.isAcceptableOrUnknown(
              data['rejected_viewed']!, _rejectedViewedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProfileTextModerationCompletedNotificationTableData map(
      Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProfileTextModerationCompletedNotificationTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      accepted: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}accepted'])!,
      acceptedViewed: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}accepted_viewed'])!,
      rejected: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}rejected'])!,
      rejectedViewed: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}rejected_viewed'])!,
    );
  }

  @override
  $ProfileTextModerationCompletedNotificationTableTable createAlias(
      String alias) {
    return $ProfileTextModerationCompletedNotificationTableTable(
        attachedDatabase, alias);
  }
}

class ProfileTextModerationCompletedNotificationTableData extends DataClass
    implements Insertable<ProfileTextModerationCompletedNotificationTableData> {
  final int id;
  final int accepted;
  final int acceptedViewed;
  final int rejected;
  final int rejectedViewed;
  const ProfileTextModerationCompletedNotificationTableData(
      {required this.id,
      required this.accepted,
      required this.acceptedViewed,
      required this.rejected,
      required this.rejectedViewed});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['accepted'] = Variable<int>(accepted);
    map['accepted_viewed'] = Variable<int>(acceptedViewed);
    map['rejected'] = Variable<int>(rejected);
    map['rejected_viewed'] = Variable<int>(rejectedViewed);
    return map;
  }

  ProfileTextModerationCompletedNotificationTableCompanion toCompanion(
      bool nullToAbsent) {
    return ProfileTextModerationCompletedNotificationTableCompanion(
      id: Value(id),
      accepted: Value(accepted),
      acceptedViewed: Value(acceptedViewed),
      rejected: Value(rejected),
      rejectedViewed: Value(rejectedViewed),
    );
  }

  factory ProfileTextModerationCompletedNotificationTableData.fromJson(
      Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProfileTextModerationCompletedNotificationTableData(
      id: serializer.fromJson<int>(json['id']),
      accepted: serializer.fromJson<int>(json['accepted']),
      acceptedViewed: serializer.fromJson<int>(json['acceptedViewed']),
      rejected: serializer.fromJson<int>(json['rejected']),
      rejectedViewed: serializer.fromJson<int>(json['rejectedViewed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'accepted': serializer.toJson<int>(accepted),
      'acceptedViewed': serializer.toJson<int>(acceptedViewed),
      'rejected': serializer.toJson<int>(rejected),
      'rejectedViewed': serializer.toJson<int>(rejectedViewed),
    };
  }

  ProfileTextModerationCompletedNotificationTableData copyWith(
          {int? id,
          int? accepted,
          int? acceptedViewed,
          int? rejected,
          int? rejectedViewed}) =>
      ProfileTextModerationCompletedNotificationTableData(
        id: id ?? this.id,
        accepted: accepted ?? this.accepted,
        acceptedViewed: acceptedViewed ?? this.acceptedViewed,
        rejected: rejected ?? this.rejected,
        rejectedViewed: rejectedViewed ?? this.rejectedViewed,
      );
  ProfileTextModerationCompletedNotificationTableData copyWithCompanion(
      ProfileTextModerationCompletedNotificationTableCompanion data) {
    return ProfileTextModerationCompletedNotificationTableData(
      id: data.id.present ? data.id.value : this.id,
      accepted: data.accepted.present ? data.accepted.value : this.accepted,
      acceptedViewed: data.acceptedViewed.present
          ? data.acceptedViewed.value
          : this.acceptedViewed,
      rejected: data.rejected.present ? data.rejected.value : this.rejected,
      rejectedViewed: data.rejectedViewed.present
          ? data.rejectedViewed.value
          : this.rejectedViewed,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProfileTextModerationCompletedNotificationTableData(')
          ..write('id: $id, ')
          ..write('accepted: $accepted, ')
          ..write('acceptedViewed: $acceptedViewed, ')
          ..write('rejected: $rejected, ')
          ..write('rejectedViewed: $rejectedViewed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, accepted, acceptedViewed, rejected, rejectedViewed);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProfileTextModerationCompletedNotificationTableData &&
          other.id == this.id &&
          other.accepted == this.accepted &&
          other.acceptedViewed == this.acceptedViewed &&
          other.rejected == this.rejected &&
          other.rejectedViewed == this.rejectedViewed);
}

class ProfileTextModerationCompletedNotificationTableCompanion
    extends UpdateCompanion<
        ProfileTextModerationCompletedNotificationTableData> {
  final Value<int> id;
  final Value<int> accepted;
  final Value<int> acceptedViewed;
  final Value<int> rejected;
  final Value<int> rejectedViewed;
  const ProfileTextModerationCompletedNotificationTableCompanion({
    this.id = const Value.absent(),
    this.accepted = const Value.absent(),
    this.acceptedViewed = const Value.absent(),
    this.rejected = const Value.absent(),
    this.rejectedViewed = const Value.absent(),
  });
  ProfileTextModerationCompletedNotificationTableCompanion.insert({
    this.id = const Value.absent(),
    this.accepted = const Value.absent(),
    this.acceptedViewed = const Value.absent(),
    this.rejected = const Value.absent(),
    this.rejectedViewed = const Value.absent(),
  });
  static Insertable<ProfileTextModerationCompletedNotificationTableData>
      custom({
    Expression<int>? id,
    Expression<int>? accepted,
    Expression<int>? acceptedViewed,
    Expression<int>? rejected,
    Expression<int>? rejectedViewed,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (accepted != null) 'accepted': accepted,
      if (acceptedViewed != null) 'accepted_viewed': acceptedViewed,
      if (rejected != null) 'rejected': rejected,
      if (rejectedViewed != null) 'rejected_viewed': rejectedViewed,
    });
  }

  ProfileTextModerationCompletedNotificationTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? accepted,
      Value<int>? acceptedViewed,
      Value<int>? rejected,
      Value<int>? rejectedViewed}) {
    return ProfileTextModerationCompletedNotificationTableCompanion(
      id: id ?? this.id,
      accepted: accepted ?? this.accepted,
      acceptedViewed: acceptedViewed ?? this.acceptedViewed,
      rejected: rejected ?? this.rejected,
      rejectedViewed: rejectedViewed ?? this.rejectedViewed,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (accepted.present) {
      map['accepted'] = Variable<int>(accepted.value);
    }
    if (acceptedViewed.present) {
      map['accepted_viewed'] = Variable<int>(acceptedViewed.value);
    }
    if (rejected.present) {
      map['rejected'] = Variable<int>(rejected.value);
    }
    if (rejectedViewed.present) {
      map['rejected_viewed'] = Variable<int>(rejectedViewed.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer(
            'ProfileTextModerationCompletedNotificationTableCompanion(')
          ..write('id: $id, ')
          ..write('accepted: $accepted, ')
          ..write('acceptedViewed: $acceptedViewed, ')
          ..write('rejected: $rejected, ')
          ..write('rejectedViewed: $rejectedViewed')
          ..write(')'))
        .toString();
  }
}

class $AutomaticProfileSearchCompletedNotificationTableTable
    extends AutomaticProfileSearchCompletedNotificationTable
    with
        TableInfo<$AutomaticProfileSearchCompletedNotificationTableTable,
            AutomaticProfileSearchCompletedNotificationTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AutomaticProfileSearchCompletedNotificationTableTable(this.attachedDatabase,
      [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _profilesFoundMeta =
      const VerificationMeta('profilesFound');
  @override
  late final GeneratedColumn<int> profilesFound = GeneratedColumn<int>(
      'profiles_found', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _profilesFoundViewedMeta =
      const VerificationMeta('profilesFoundViewed');
  @override
  late final GeneratedColumn<int> profilesFoundViewed = GeneratedColumn<int>(
      'profiles_found_viewed', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns =>
      [id, profilesFound, profilesFoundViewed];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name =
      'automatic_profile_search_completed_notification_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<AutomaticProfileSearchCompletedNotificationTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('profiles_found')) {
      context.handle(
          _profilesFoundMeta,
          profilesFound.isAcceptableOrUnknown(
              data['profiles_found']!, _profilesFoundMeta));
    }
    if (data.containsKey('profiles_found_viewed')) {
      context.handle(
          _profilesFoundViewedMeta,
          profilesFoundViewed.isAcceptableOrUnknown(
              data['profiles_found_viewed']!, _profilesFoundViewedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AutomaticProfileSearchCompletedNotificationTableData map(
      Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AutomaticProfileSearchCompletedNotificationTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      profilesFound: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}profiles_found'])!,
      profilesFoundViewed: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}profiles_found_viewed'])!,
    );
  }

  @override
  $AutomaticProfileSearchCompletedNotificationTableTable createAlias(
      String alias) {
    return $AutomaticProfileSearchCompletedNotificationTableTable(
        attachedDatabase, alias);
  }
}

class AutomaticProfileSearchCompletedNotificationTableData extends DataClass
    implements
        Insertable<AutomaticProfileSearchCompletedNotificationTableData> {
  final int id;
  final int profilesFound;
  final int profilesFoundViewed;
  const AutomaticProfileSearchCompletedNotificationTableData(
      {required this.id,
      required this.profilesFound,
      required this.profilesFoundViewed});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['profiles_found'] = Variable<int>(profilesFound);
    map['profiles_found_viewed'] = Variable<int>(profilesFoundViewed);
    return map;
  }

  AutomaticProfileSearchCompletedNotificationTableCompanion toCompanion(
      bool nullToAbsent) {
    return AutomaticProfileSearchCompletedNotificationTableCompanion(
      id: Value(id),
      profilesFound: Value(profilesFound),
      profilesFoundViewed: Value(profilesFoundViewed),
    );
  }

  factory AutomaticProfileSearchCompletedNotificationTableData.fromJson(
      Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AutomaticProfileSearchCompletedNotificationTableData(
      id: serializer.fromJson<int>(json['id']),
      profilesFound: serializer.fromJson<int>(json['profilesFound']),
      profilesFoundViewed:
          serializer.fromJson<int>(json['profilesFoundViewed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'profilesFound': serializer.toJson<int>(profilesFound),
      'profilesFoundViewed': serializer.toJson<int>(profilesFoundViewed),
    };
  }

  AutomaticProfileSearchCompletedNotificationTableData copyWith(
          {int? id, int? profilesFound, int? profilesFoundViewed}) =>
      AutomaticProfileSearchCompletedNotificationTableData(
        id: id ?? this.id,
        profilesFound: profilesFound ?? this.profilesFound,
        profilesFoundViewed: profilesFoundViewed ?? this.profilesFoundViewed,
      );
  AutomaticProfileSearchCompletedNotificationTableData copyWithCompanion(
      AutomaticProfileSearchCompletedNotificationTableCompanion data) {
    return AutomaticProfileSearchCompletedNotificationTableData(
      id: data.id.present ? data.id.value : this.id,
      profilesFound: data.profilesFound.present
          ? data.profilesFound.value
          : this.profilesFound,
      profilesFoundViewed: data.profilesFoundViewed.present
          ? data.profilesFoundViewed.value
          : this.profilesFoundViewed,
    );
  }

  @override
  String toString() {
    return (StringBuffer(
            'AutomaticProfileSearchCompletedNotificationTableData(')
          ..write('id: $id, ')
          ..write('profilesFound: $profilesFound, ')
          ..write('profilesFoundViewed: $profilesFoundViewed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, profilesFound, profilesFoundViewed);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AutomaticProfileSearchCompletedNotificationTableData &&
          other.id == this.id &&
          other.profilesFound == this.profilesFound &&
          other.profilesFoundViewed == this.profilesFoundViewed);
}

class AutomaticProfileSearchCompletedNotificationTableCompanion
    extends UpdateCompanion<
        AutomaticProfileSearchCompletedNotificationTableData> {
  final Value<int> id;
  final Value<int> profilesFound;
  final Value<int> profilesFoundViewed;
  const AutomaticProfileSearchCompletedNotificationTableCompanion({
    this.id = const Value.absent(),
    this.profilesFound = const Value.absent(),
    this.profilesFoundViewed = const Value.absent(),
  });
  AutomaticProfileSearchCompletedNotificationTableCompanion.insert({
    this.id = const Value.absent(),
    this.profilesFound = const Value.absent(),
    this.profilesFoundViewed = const Value.absent(),
  });
  static Insertable<AutomaticProfileSearchCompletedNotificationTableData>
      custom({
    Expression<int>? id,
    Expression<int>? profilesFound,
    Expression<int>? profilesFoundViewed,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (profilesFound != null) 'profiles_found': profilesFound,
      if (profilesFoundViewed != null)
        'profiles_found_viewed': profilesFoundViewed,
    });
  }

  AutomaticProfileSearchCompletedNotificationTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? profilesFound,
      Value<int>? profilesFoundViewed}) {
    return AutomaticProfileSearchCompletedNotificationTableCompanion(
      id: id ?? this.id,
      profilesFound: profilesFound ?? this.profilesFound,
      profilesFoundViewed: profilesFoundViewed ?? this.profilesFoundViewed,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (profilesFound.present) {
      map['profiles_found'] = Variable<int>(profilesFound.value);
    }
    if (profilesFoundViewed.present) {
      map['profiles_found_viewed'] = Variable<int>(profilesFoundViewed.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer(
            'AutomaticProfileSearchCompletedNotificationTableCompanion(')
          ..write('id: $id, ')
          ..write('profilesFound: $profilesFound, ')
          ..write('profilesFoundViewed: $profilesFoundViewed')
          ..write(')'))
        .toString();
  }
}

class $AdminNotificationTableTable extends AdminNotificationTable
    with TableInfo<$AdminNotificationTableTable, AdminNotificationTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AdminNotificationTableTable(this.attachedDatabase, [this._alias]);
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
  late final GeneratedColumnWithTypeConverter<JsonString?, String>
      jsonViewedNotification = GeneratedColumn<String>(
              'json_viewed_notification', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<JsonString?>(
              $AdminNotificationTableTable.$converterjsonViewedNotification);
  @override
  List<GeneratedColumn> get $columns => [id, jsonViewedNotification];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'admin_notification_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<AdminNotificationTableData> instance,
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
  AdminNotificationTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AdminNotificationTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      jsonViewedNotification: $AdminNotificationTableTable
          .$converterjsonViewedNotification
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}json_viewed_notification'])),
    );
  }

  @override
  $AdminNotificationTableTable createAlias(String alias) {
    return $AdminNotificationTableTable(attachedDatabase, alias);
  }

  static TypeConverter<JsonString?, String?> $converterjsonViewedNotification =
      NullAwareTypeConverter.wrap(JsonString.driftConverter);
}

class AdminNotificationTableData extends DataClass
    implements Insertable<AdminNotificationTableData> {
  final int id;
  final JsonString? jsonViewedNotification;
  const AdminNotificationTableData(
      {required this.id, this.jsonViewedNotification});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || jsonViewedNotification != null) {
      map['json_viewed_notification'] = Variable<String>(
          $AdminNotificationTableTable.$converterjsonViewedNotification
              .toSql(jsonViewedNotification));
    }
    return map;
  }

  AdminNotificationTableCompanion toCompanion(bool nullToAbsent) {
    return AdminNotificationTableCompanion(
      id: Value(id),
      jsonViewedNotification: jsonViewedNotification == null && nullToAbsent
          ? const Value.absent()
          : Value(jsonViewedNotification),
    );
  }

  factory AdminNotificationTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AdminNotificationTableData(
      id: serializer.fromJson<int>(json['id']),
      jsonViewedNotification:
          serializer.fromJson<JsonString?>(json['jsonViewedNotification']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'jsonViewedNotification':
          serializer.toJson<JsonString?>(jsonViewedNotification),
    };
  }

  AdminNotificationTableData copyWith(
          {int? id,
          Value<JsonString?> jsonViewedNotification = const Value.absent()}) =>
      AdminNotificationTableData(
        id: id ?? this.id,
        jsonViewedNotification: jsonViewedNotification.present
            ? jsonViewedNotification.value
            : this.jsonViewedNotification,
      );
  AdminNotificationTableData copyWithCompanion(
      AdminNotificationTableCompanion data) {
    return AdminNotificationTableData(
      id: data.id.present ? data.id.value : this.id,
      jsonViewedNotification: data.jsonViewedNotification.present
          ? data.jsonViewedNotification.value
          : this.jsonViewedNotification,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AdminNotificationTableData(')
          ..write('id: $id, ')
          ..write('jsonViewedNotification: $jsonViewedNotification')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, jsonViewedNotification);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AdminNotificationTableData &&
          other.id == this.id &&
          other.jsonViewedNotification == this.jsonViewedNotification);
}

class AdminNotificationTableCompanion
    extends UpdateCompanion<AdminNotificationTableData> {
  final Value<int> id;
  final Value<JsonString?> jsonViewedNotification;
  const AdminNotificationTableCompanion({
    this.id = const Value.absent(),
    this.jsonViewedNotification = const Value.absent(),
  });
  AdminNotificationTableCompanion.insert({
    this.id = const Value.absent(),
    this.jsonViewedNotification = const Value.absent(),
  });
  static Insertable<AdminNotificationTableData> custom({
    Expression<int>? id,
    Expression<String>? jsonViewedNotification,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (jsonViewedNotification != null)
        'json_viewed_notification': jsonViewedNotification,
    });
  }

  AdminNotificationTableCompanion copyWith(
      {Value<int>? id, Value<JsonString?>? jsonViewedNotification}) {
    return AdminNotificationTableCompanion(
      id: id ?? this.id,
      jsonViewedNotification:
          jsonViewedNotification ?? this.jsonViewedNotification,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (jsonViewedNotification.present) {
      map['json_viewed_notification'] = Variable<String>(
          $AdminNotificationTableTable.$converterjsonViewedNotification
              .toSql(jsonViewedNotification.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AdminNotificationTableCompanion(')
          ..write('id: $id, ')
          ..write('jsonViewedNotification: $jsonViewedNotification')
          ..write(')'))
        .toString();
  }
}

class $AppNotificationSettingsTableTable extends AppNotificationSettingsTable
    with
        TableInfo<$AppNotificationSettingsTableTable,
            AppNotificationSettingsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppNotificationSettingsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _messagesMeta =
      const VerificationMeta('messages');
  @override
  late final GeneratedColumn<bool> messages = GeneratedColumn<bool>(
      'messages', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("messages" IN (0, 1))'));
  static const VerificationMeta _likesMeta = const VerificationMeta('likes');
  @override
  late final GeneratedColumn<bool> likes = GeneratedColumn<bool>(
      'likes', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("likes" IN (0, 1))'));
  static const VerificationMeta _mediaContentModerationCompletedMeta =
      const VerificationMeta('mediaContentModerationCompleted');
  @override
  late final GeneratedColumn<bool> mediaContentModerationCompleted =
      GeneratedColumn<bool>(
          'media_content_moderation_completed', aliasedName, true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("media_content_moderation_completed" IN (0, 1))'));
  static const VerificationMeta _profileTextModerationCompletedMeta =
      const VerificationMeta('profileTextModerationCompleted');
  @override
  late final GeneratedColumn<bool> profileTextModerationCompleted =
      GeneratedColumn<bool>(
          'profile_text_moderation_completed', aliasedName, true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("profile_text_moderation_completed" IN (0, 1))'));
  static const VerificationMeta _newsMeta = const VerificationMeta('news');
  @override
  late final GeneratedColumn<bool> news = GeneratedColumn<bool>(
      'news', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("news" IN (0, 1))'));
  static const VerificationMeta _automaticProfileSearchMeta =
      const VerificationMeta('automaticProfileSearch');
  @override
  late final GeneratedColumn<bool> automaticProfileSearch =
      GeneratedColumn<bool>('automatic_profile_search', aliasedName, true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("automatic_profile_search" IN (0, 1))'));
  static const VerificationMeta _automaticProfileSearchDistanceMeta =
      const VerificationMeta('automaticProfileSearchDistance');
  @override
  late final GeneratedColumn<bool> automaticProfileSearchDistance =
      GeneratedColumn<bool>(
          'automatic_profile_search_distance', aliasedName, true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("automatic_profile_search_distance" IN (0, 1))'));
  static const VerificationMeta _automaticProfileSearchFiltersMeta =
      const VerificationMeta('automaticProfileSearchFilters');
  @override
  late final GeneratedColumn<bool> automaticProfileSearchFilters =
      GeneratedColumn<bool>(
          'automatic_profile_search_filters', aliasedName, true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("automatic_profile_search_filters" IN (0, 1))'));
  static const VerificationMeta _automaticProfileSearchNewProfilesMeta =
      const VerificationMeta('automaticProfileSearchNewProfiles');
  @override
  late final GeneratedColumn<bool> automaticProfileSearchNewProfiles =
      GeneratedColumn<bool>(
          'automatic_profile_search_new_profiles', aliasedName, true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("automatic_profile_search_new_profiles" IN (0, 1))'));
  static const VerificationMeta _automaticProfileSearchWeekdaysMeta =
      const VerificationMeta('automaticProfileSearchWeekdays');
  @override
  late final GeneratedColumn<int> automaticProfileSearchWeekdays =
      GeneratedColumn<int>(
          'automatic_profile_search_weekdays', aliasedName, true,
          type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        messages,
        likes,
        mediaContentModerationCompleted,
        profileTextModerationCompleted,
        news,
        automaticProfileSearch,
        automaticProfileSearchDistance,
        automaticProfileSearchFilters,
        automaticProfileSearchNewProfiles,
        automaticProfileSearchWeekdays
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_notification_settings_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<AppNotificationSettingsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('messages')) {
      context.handle(_messagesMeta,
          messages.isAcceptableOrUnknown(data['messages']!, _messagesMeta));
    }
    if (data.containsKey('likes')) {
      context.handle(
          _likesMeta, likes.isAcceptableOrUnknown(data['likes']!, _likesMeta));
    }
    if (data.containsKey('media_content_moderation_completed')) {
      context.handle(
          _mediaContentModerationCompletedMeta,
          mediaContentModerationCompleted.isAcceptableOrUnknown(
              data['media_content_moderation_completed']!,
              _mediaContentModerationCompletedMeta));
    }
    if (data.containsKey('profile_text_moderation_completed')) {
      context.handle(
          _profileTextModerationCompletedMeta,
          profileTextModerationCompleted.isAcceptableOrUnknown(
              data['profile_text_moderation_completed']!,
              _profileTextModerationCompletedMeta));
    }
    if (data.containsKey('news')) {
      context.handle(
          _newsMeta, news.isAcceptableOrUnknown(data['news']!, _newsMeta));
    }
    if (data.containsKey('automatic_profile_search')) {
      context.handle(
          _automaticProfileSearchMeta,
          automaticProfileSearch.isAcceptableOrUnknown(
              data['automatic_profile_search']!, _automaticProfileSearchMeta));
    }
    if (data.containsKey('automatic_profile_search_distance')) {
      context.handle(
          _automaticProfileSearchDistanceMeta,
          automaticProfileSearchDistance.isAcceptableOrUnknown(
              data['automatic_profile_search_distance']!,
              _automaticProfileSearchDistanceMeta));
    }
    if (data.containsKey('automatic_profile_search_filters')) {
      context.handle(
          _automaticProfileSearchFiltersMeta,
          automaticProfileSearchFilters.isAcceptableOrUnknown(
              data['automatic_profile_search_filters']!,
              _automaticProfileSearchFiltersMeta));
    }
    if (data.containsKey('automatic_profile_search_new_profiles')) {
      context.handle(
          _automaticProfileSearchNewProfilesMeta,
          automaticProfileSearchNewProfiles.isAcceptableOrUnknown(
              data['automatic_profile_search_new_profiles']!,
              _automaticProfileSearchNewProfilesMeta));
    }
    if (data.containsKey('automatic_profile_search_weekdays')) {
      context.handle(
          _automaticProfileSearchWeekdaysMeta,
          automaticProfileSearchWeekdays.isAcceptableOrUnknown(
              data['automatic_profile_search_weekdays']!,
              _automaticProfileSearchWeekdaysMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppNotificationSettingsTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppNotificationSettingsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      messages: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}messages']),
      likes: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}likes']),
      mediaContentModerationCompleted: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}media_content_moderation_completed']),
      profileTextModerationCompleted: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}profile_text_moderation_completed']),
      news: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}news']),
      automaticProfileSearch: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}automatic_profile_search']),
      automaticProfileSearchDistance: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}automatic_profile_search_distance']),
      automaticProfileSearchFilters: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}automatic_profile_search_filters']),
      automaticProfileSearchNewProfiles: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}automatic_profile_search_new_profiles']),
      automaticProfileSearchWeekdays: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}automatic_profile_search_weekdays']),
    );
  }

  @override
  $AppNotificationSettingsTableTable createAlias(String alias) {
    return $AppNotificationSettingsTableTable(attachedDatabase, alias);
  }
}

class AppNotificationSettingsTableData extends DataClass
    implements Insertable<AppNotificationSettingsTableData> {
  final int id;
  final bool? messages;
  final bool? likes;
  final bool? mediaContentModerationCompleted;
  final bool? profileTextModerationCompleted;
  final bool? news;
  final bool? automaticProfileSearch;
  final bool? automaticProfileSearchDistance;
  final bool? automaticProfileSearchFilters;
  final bool? automaticProfileSearchNewProfiles;
  final int? automaticProfileSearchWeekdays;
  const AppNotificationSettingsTableData(
      {required this.id,
      this.messages,
      this.likes,
      this.mediaContentModerationCompleted,
      this.profileTextModerationCompleted,
      this.news,
      this.automaticProfileSearch,
      this.automaticProfileSearchDistance,
      this.automaticProfileSearchFilters,
      this.automaticProfileSearchNewProfiles,
      this.automaticProfileSearchWeekdays});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || messages != null) {
      map['messages'] = Variable<bool>(messages);
    }
    if (!nullToAbsent || likes != null) {
      map['likes'] = Variable<bool>(likes);
    }
    if (!nullToAbsent || mediaContentModerationCompleted != null) {
      map['media_content_moderation_completed'] =
          Variable<bool>(mediaContentModerationCompleted);
    }
    if (!nullToAbsent || profileTextModerationCompleted != null) {
      map['profile_text_moderation_completed'] =
          Variable<bool>(profileTextModerationCompleted);
    }
    if (!nullToAbsent || news != null) {
      map['news'] = Variable<bool>(news);
    }
    if (!nullToAbsent || automaticProfileSearch != null) {
      map['automatic_profile_search'] = Variable<bool>(automaticProfileSearch);
    }
    if (!nullToAbsent || automaticProfileSearchDistance != null) {
      map['automatic_profile_search_distance'] =
          Variable<bool>(automaticProfileSearchDistance);
    }
    if (!nullToAbsent || automaticProfileSearchFilters != null) {
      map['automatic_profile_search_filters'] =
          Variable<bool>(automaticProfileSearchFilters);
    }
    if (!nullToAbsent || automaticProfileSearchNewProfiles != null) {
      map['automatic_profile_search_new_profiles'] =
          Variable<bool>(automaticProfileSearchNewProfiles);
    }
    if (!nullToAbsent || automaticProfileSearchWeekdays != null) {
      map['automatic_profile_search_weekdays'] =
          Variable<int>(automaticProfileSearchWeekdays);
    }
    return map;
  }

  AppNotificationSettingsTableCompanion toCompanion(bool nullToAbsent) {
    return AppNotificationSettingsTableCompanion(
      id: Value(id),
      messages: messages == null && nullToAbsent
          ? const Value.absent()
          : Value(messages),
      likes:
          likes == null && nullToAbsent ? const Value.absent() : Value(likes),
      mediaContentModerationCompleted:
          mediaContentModerationCompleted == null && nullToAbsent
              ? const Value.absent()
              : Value(mediaContentModerationCompleted),
      profileTextModerationCompleted:
          profileTextModerationCompleted == null && nullToAbsent
              ? const Value.absent()
              : Value(profileTextModerationCompleted),
      news: news == null && nullToAbsent ? const Value.absent() : Value(news),
      automaticProfileSearch: automaticProfileSearch == null && nullToAbsent
          ? const Value.absent()
          : Value(automaticProfileSearch),
      automaticProfileSearchDistance:
          automaticProfileSearchDistance == null && nullToAbsent
              ? const Value.absent()
              : Value(automaticProfileSearchDistance),
      automaticProfileSearchFilters:
          automaticProfileSearchFilters == null && nullToAbsent
              ? const Value.absent()
              : Value(automaticProfileSearchFilters),
      automaticProfileSearchNewProfiles:
          automaticProfileSearchNewProfiles == null && nullToAbsent
              ? const Value.absent()
              : Value(automaticProfileSearchNewProfiles),
      automaticProfileSearchWeekdays:
          automaticProfileSearchWeekdays == null && nullToAbsent
              ? const Value.absent()
              : Value(automaticProfileSearchWeekdays),
    );
  }

  factory AppNotificationSettingsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppNotificationSettingsTableData(
      id: serializer.fromJson<int>(json['id']),
      messages: serializer.fromJson<bool?>(json['messages']),
      likes: serializer.fromJson<bool?>(json['likes']),
      mediaContentModerationCompleted:
          serializer.fromJson<bool?>(json['mediaContentModerationCompleted']),
      profileTextModerationCompleted:
          serializer.fromJson<bool?>(json['profileTextModerationCompleted']),
      news: serializer.fromJson<bool?>(json['news']),
      automaticProfileSearch:
          serializer.fromJson<bool?>(json['automaticProfileSearch']),
      automaticProfileSearchDistance:
          serializer.fromJson<bool?>(json['automaticProfileSearchDistance']),
      automaticProfileSearchFilters:
          serializer.fromJson<bool?>(json['automaticProfileSearchFilters']),
      automaticProfileSearchNewProfiles:
          serializer.fromJson<bool?>(json['automaticProfileSearchNewProfiles']),
      automaticProfileSearchWeekdays:
          serializer.fromJson<int?>(json['automaticProfileSearchWeekdays']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'messages': serializer.toJson<bool?>(messages),
      'likes': serializer.toJson<bool?>(likes),
      'mediaContentModerationCompleted':
          serializer.toJson<bool?>(mediaContentModerationCompleted),
      'profileTextModerationCompleted':
          serializer.toJson<bool?>(profileTextModerationCompleted),
      'news': serializer.toJson<bool?>(news),
      'automaticProfileSearch':
          serializer.toJson<bool?>(automaticProfileSearch),
      'automaticProfileSearchDistance':
          serializer.toJson<bool?>(automaticProfileSearchDistance),
      'automaticProfileSearchFilters':
          serializer.toJson<bool?>(automaticProfileSearchFilters),
      'automaticProfileSearchNewProfiles':
          serializer.toJson<bool?>(automaticProfileSearchNewProfiles),
      'automaticProfileSearchWeekdays':
          serializer.toJson<int?>(automaticProfileSearchWeekdays),
    };
  }

  AppNotificationSettingsTableData copyWith(
          {int? id,
          Value<bool?> messages = const Value.absent(),
          Value<bool?> likes = const Value.absent(),
          Value<bool?> mediaContentModerationCompleted = const Value.absent(),
          Value<bool?> profileTextModerationCompleted = const Value.absent(),
          Value<bool?> news = const Value.absent(),
          Value<bool?> automaticProfileSearch = const Value.absent(),
          Value<bool?> automaticProfileSearchDistance = const Value.absent(),
          Value<bool?> automaticProfileSearchFilters = const Value.absent(),
          Value<bool?> automaticProfileSearchNewProfiles = const Value.absent(),
          Value<int?> automaticProfileSearchWeekdays = const Value.absent()}) =>
      AppNotificationSettingsTableData(
        id: id ?? this.id,
        messages: messages.present ? messages.value : this.messages,
        likes: likes.present ? likes.value : this.likes,
        mediaContentModerationCompleted: mediaContentModerationCompleted.present
            ? mediaContentModerationCompleted.value
            : this.mediaContentModerationCompleted,
        profileTextModerationCompleted: profileTextModerationCompleted.present
            ? profileTextModerationCompleted.value
            : this.profileTextModerationCompleted,
        news: news.present ? news.value : this.news,
        automaticProfileSearch: automaticProfileSearch.present
            ? automaticProfileSearch.value
            : this.automaticProfileSearch,
        automaticProfileSearchDistance: automaticProfileSearchDistance.present
            ? automaticProfileSearchDistance.value
            : this.automaticProfileSearchDistance,
        automaticProfileSearchFilters: automaticProfileSearchFilters.present
            ? automaticProfileSearchFilters.value
            : this.automaticProfileSearchFilters,
        automaticProfileSearchNewProfiles:
            automaticProfileSearchNewProfiles.present
                ? automaticProfileSearchNewProfiles.value
                : this.automaticProfileSearchNewProfiles,
        automaticProfileSearchWeekdays: automaticProfileSearchWeekdays.present
            ? automaticProfileSearchWeekdays.value
            : this.automaticProfileSearchWeekdays,
      );
  AppNotificationSettingsTableData copyWithCompanion(
      AppNotificationSettingsTableCompanion data) {
    return AppNotificationSettingsTableData(
      id: data.id.present ? data.id.value : this.id,
      messages: data.messages.present ? data.messages.value : this.messages,
      likes: data.likes.present ? data.likes.value : this.likes,
      mediaContentModerationCompleted:
          data.mediaContentModerationCompleted.present
              ? data.mediaContentModerationCompleted.value
              : this.mediaContentModerationCompleted,
      profileTextModerationCompleted:
          data.profileTextModerationCompleted.present
              ? data.profileTextModerationCompleted.value
              : this.profileTextModerationCompleted,
      news: data.news.present ? data.news.value : this.news,
      automaticProfileSearch: data.automaticProfileSearch.present
          ? data.automaticProfileSearch.value
          : this.automaticProfileSearch,
      automaticProfileSearchDistance:
          data.automaticProfileSearchDistance.present
              ? data.automaticProfileSearchDistance.value
              : this.automaticProfileSearchDistance,
      automaticProfileSearchFilters: data.automaticProfileSearchFilters.present
          ? data.automaticProfileSearchFilters.value
          : this.automaticProfileSearchFilters,
      automaticProfileSearchNewProfiles:
          data.automaticProfileSearchNewProfiles.present
              ? data.automaticProfileSearchNewProfiles.value
              : this.automaticProfileSearchNewProfiles,
      automaticProfileSearchWeekdays:
          data.automaticProfileSearchWeekdays.present
              ? data.automaticProfileSearchWeekdays.value
              : this.automaticProfileSearchWeekdays,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppNotificationSettingsTableData(')
          ..write('id: $id, ')
          ..write('messages: $messages, ')
          ..write('likes: $likes, ')
          ..write(
              'mediaContentModerationCompleted: $mediaContentModerationCompleted, ')
          ..write(
              'profileTextModerationCompleted: $profileTextModerationCompleted, ')
          ..write('news: $news, ')
          ..write('automaticProfileSearch: $automaticProfileSearch, ')
          ..write(
              'automaticProfileSearchDistance: $automaticProfileSearchDistance, ')
          ..write(
              'automaticProfileSearchFilters: $automaticProfileSearchFilters, ')
          ..write(
              'automaticProfileSearchNewProfiles: $automaticProfileSearchNewProfiles, ')
          ..write(
              'automaticProfileSearchWeekdays: $automaticProfileSearchWeekdays')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      messages,
      likes,
      mediaContentModerationCompleted,
      profileTextModerationCompleted,
      news,
      automaticProfileSearch,
      automaticProfileSearchDistance,
      automaticProfileSearchFilters,
      automaticProfileSearchNewProfiles,
      automaticProfileSearchWeekdays);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppNotificationSettingsTableData &&
          other.id == this.id &&
          other.messages == this.messages &&
          other.likes == this.likes &&
          other.mediaContentModerationCompleted ==
              this.mediaContentModerationCompleted &&
          other.profileTextModerationCompleted ==
              this.profileTextModerationCompleted &&
          other.news == this.news &&
          other.automaticProfileSearch == this.automaticProfileSearch &&
          other.automaticProfileSearchDistance ==
              this.automaticProfileSearchDistance &&
          other.automaticProfileSearchFilters ==
              this.automaticProfileSearchFilters &&
          other.automaticProfileSearchNewProfiles ==
              this.automaticProfileSearchNewProfiles &&
          other.automaticProfileSearchWeekdays ==
              this.automaticProfileSearchWeekdays);
}

class AppNotificationSettingsTableCompanion
    extends UpdateCompanion<AppNotificationSettingsTableData> {
  final Value<int> id;
  final Value<bool?> messages;
  final Value<bool?> likes;
  final Value<bool?> mediaContentModerationCompleted;
  final Value<bool?> profileTextModerationCompleted;
  final Value<bool?> news;
  final Value<bool?> automaticProfileSearch;
  final Value<bool?> automaticProfileSearchDistance;
  final Value<bool?> automaticProfileSearchFilters;
  final Value<bool?> automaticProfileSearchNewProfiles;
  final Value<int?> automaticProfileSearchWeekdays;
  const AppNotificationSettingsTableCompanion({
    this.id = const Value.absent(),
    this.messages = const Value.absent(),
    this.likes = const Value.absent(),
    this.mediaContentModerationCompleted = const Value.absent(),
    this.profileTextModerationCompleted = const Value.absent(),
    this.news = const Value.absent(),
    this.automaticProfileSearch = const Value.absent(),
    this.automaticProfileSearchDistance = const Value.absent(),
    this.automaticProfileSearchFilters = const Value.absent(),
    this.automaticProfileSearchNewProfiles = const Value.absent(),
    this.automaticProfileSearchWeekdays = const Value.absent(),
  });
  AppNotificationSettingsTableCompanion.insert({
    this.id = const Value.absent(),
    this.messages = const Value.absent(),
    this.likes = const Value.absent(),
    this.mediaContentModerationCompleted = const Value.absent(),
    this.profileTextModerationCompleted = const Value.absent(),
    this.news = const Value.absent(),
    this.automaticProfileSearch = const Value.absent(),
    this.automaticProfileSearchDistance = const Value.absent(),
    this.automaticProfileSearchFilters = const Value.absent(),
    this.automaticProfileSearchNewProfiles = const Value.absent(),
    this.automaticProfileSearchWeekdays = const Value.absent(),
  });
  static Insertable<AppNotificationSettingsTableData> custom({
    Expression<int>? id,
    Expression<bool>? messages,
    Expression<bool>? likes,
    Expression<bool>? mediaContentModerationCompleted,
    Expression<bool>? profileTextModerationCompleted,
    Expression<bool>? news,
    Expression<bool>? automaticProfileSearch,
    Expression<bool>? automaticProfileSearchDistance,
    Expression<bool>? automaticProfileSearchFilters,
    Expression<bool>? automaticProfileSearchNewProfiles,
    Expression<int>? automaticProfileSearchWeekdays,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (messages != null) 'messages': messages,
      if (likes != null) 'likes': likes,
      if (mediaContentModerationCompleted != null)
        'media_content_moderation_completed': mediaContentModerationCompleted,
      if (profileTextModerationCompleted != null)
        'profile_text_moderation_completed': profileTextModerationCompleted,
      if (news != null) 'news': news,
      if (automaticProfileSearch != null)
        'automatic_profile_search': automaticProfileSearch,
      if (automaticProfileSearchDistance != null)
        'automatic_profile_search_distance': automaticProfileSearchDistance,
      if (automaticProfileSearchFilters != null)
        'automatic_profile_search_filters': automaticProfileSearchFilters,
      if (automaticProfileSearchNewProfiles != null)
        'automatic_profile_search_new_profiles':
            automaticProfileSearchNewProfiles,
      if (automaticProfileSearchWeekdays != null)
        'automatic_profile_search_weekdays': automaticProfileSearchWeekdays,
    });
  }

  AppNotificationSettingsTableCompanion copyWith(
      {Value<int>? id,
      Value<bool?>? messages,
      Value<bool?>? likes,
      Value<bool?>? mediaContentModerationCompleted,
      Value<bool?>? profileTextModerationCompleted,
      Value<bool?>? news,
      Value<bool?>? automaticProfileSearch,
      Value<bool?>? automaticProfileSearchDistance,
      Value<bool?>? automaticProfileSearchFilters,
      Value<bool?>? automaticProfileSearchNewProfiles,
      Value<int?>? automaticProfileSearchWeekdays}) {
    return AppNotificationSettingsTableCompanion(
      id: id ?? this.id,
      messages: messages ?? this.messages,
      likes: likes ?? this.likes,
      mediaContentModerationCompleted: mediaContentModerationCompleted ??
          this.mediaContentModerationCompleted,
      profileTextModerationCompleted:
          profileTextModerationCompleted ?? this.profileTextModerationCompleted,
      news: news ?? this.news,
      automaticProfileSearch:
          automaticProfileSearch ?? this.automaticProfileSearch,
      automaticProfileSearchDistance:
          automaticProfileSearchDistance ?? this.automaticProfileSearchDistance,
      automaticProfileSearchFilters:
          automaticProfileSearchFilters ?? this.automaticProfileSearchFilters,
      automaticProfileSearchNewProfiles: automaticProfileSearchNewProfiles ??
          this.automaticProfileSearchNewProfiles,
      automaticProfileSearchWeekdays:
          automaticProfileSearchWeekdays ?? this.automaticProfileSearchWeekdays,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (messages.present) {
      map['messages'] = Variable<bool>(messages.value);
    }
    if (likes.present) {
      map['likes'] = Variable<bool>(likes.value);
    }
    if (mediaContentModerationCompleted.present) {
      map['media_content_moderation_completed'] =
          Variable<bool>(mediaContentModerationCompleted.value);
    }
    if (profileTextModerationCompleted.present) {
      map['profile_text_moderation_completed'] =
          Variable<bool>(profileTextModerationCompleted.value);
    }
    if (news.present) {
      map['news'] = Variable<bool>(news.value);
    }
    if (automaticProfileSearch.present) {
      map['automatic_profile_search'] =
          Variable<bool>(automaticProfileSearch.value);
    }
    if (automaticProfileSearchDistance.present) {
      map['automatic_profile_search_distance'] =
          Variable<bool>(automaticProfileSearchDistance.value);
    }
    if (automaticProfileSearchFilters.present) {
      map['automatic_profile_search_filters'] =
          Variable<bool>(automaticProfileSearchFilters.value);
    }
    if (automaticProfileSearchNewProfiles.present) {
      map['automatic_profile_search_new_profiles'] =
          Variable<bool>(automaticProfileSearchNewProfiles.value);
    }
    if (automaticProfileSearchWeekdays.present) {
      map['automatic_profile_search_weekdays'] =
          Variable<int>(automaticProfileSearchWeekdays.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppNotificationSettingsTableCompanion(')
          ..write('id: $id, ')
          ..write('messages: $messages, ')
          ..write('likes: $likes, ')
          ..write(
              'mediaContentModerationCompleted: $mediaContentModerationCompleted, ')
          ..write(
              'profileTextModerationCompleted: $profileTextModerationCompleted, ')
          ..write('news: $news, ')
          ..write('automaticProfileSearch: $automaticProfileSearch, ')
          ..write(
              'automaticProfileSearchDistance: $automaticProfileSearchDistance, ')
          ..write(
              'automaticProfileSearchFilters: $automaticProfileSearchFilters, ')
          ..write(
              'automaticProfileSearchNewProfiles: $automaticProfileSearchNewProfiles, ')
          ..write(
              'automaticProfileSearchWeekdays: $automaticProfileSearchWeekdays')
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
  late final $ConversationsBackgroundTable conversationsBackground =
      $ConversationsBackgroundTable(this);
  late final $NewMessageNotificationTable newMessageNotification =
      $NewMessageNotificationTable(this);
  late final $NewReceivedLikesAvailableTable newReceivedLikesAvailable =
      $NewReceivedLikesAvailableTable(this);
  late final $NewsTable news = $NewsTable(this);
  late final $MediaContentModerationCompletedNotificationTableTable
      mediaContentModerationCompletedNotificationTable =
      $MediaContentModerationCompletedNotificationTableTable(this);
  late final $ProfileTextModerationCompletedNotificationTableTable
      profileTextModerationCompletedNotificationTable =
      $ProfileTextModerationCompletedNotificationTableTable(this);
  late final $AutomaticProfileSearchCompletedNotificationTableTable
      automaticProfileSearchCompletedNotificationTable =
      $AutomaticProfileSearchCompletedNotificationTableTable(this);
  late final $AdminNotificationTableTable adminNotificationTable =
      $AdminNotificationTableTable(this);
  late final $AppNotificationSettingsTableTable appNotificationSettingsTable =
      $AppNotificationSettingsTableTable(this);
  late final DaoProfilesBackground daoProfilesBackground =
      DaoProfilesBackground(this as AccountBackgroundDatabase);
  late final DaoConversationsBackground daoConversationsBackground =
      DaoConversationsBackground(this as AccountBackgroundDatabase);
  late final DaoNewMessageNotification daoNewMessageNotification =
      DaoNewMessageNotification(this as AccountBackgroundDatabase);
  late final DaoNewReceivedLikesAvailable daoNewReceivedLikesAvailable =
      DaoNewReceivedLikesAvailable(this as AccountBackgroundDatabase);
  late final DaoNews daoNews = DaoNews(this as AccountBackgroundDatabase);
  late final DaoMediaContentModerationCompletedNotificationTable
      daoMediaContentModerationCompletedNotificationTable =
      DaoMediaContentModerationCompletedNotificationTable(
          this as AccountBackgroundDatabase);
  late final DaoProfileTextModerationCompletedNotificationTable
      daoProfileTextModerationCompletedNotificationTable =
      DaoProfileTextModerationCompletedNotificationTable(
          this as AccountBackgroundDatabase);
  late final DaoAutomaticProfileSearchCompletedNotificationTable
      daoAutomaticProfileSearchCompletedNotificationTable =
      DaoAutomaticProfileSearchCompletedNotificationTable(
          this as AccountBackgroundDatabase);
  late final DaoAdminNotificationTable daoAdminNotificationTable =
      DaoAdminNotificationTable(this as AccountBackgroundDatabase);
  late final DaoAppNotificationSettingsTable daoAppNotificationSettingsTable =
      DaoAppNotificationSettingsTable(this as AccountBackgroundDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        accountBackground,
        profilesBackground,
        conversationsBackground,
        newMessageNotification,
        newReceivedLikesAvailable,
        news,
        mediaContentModerationCompletedNotificationTable,
        profileTextModerationCompletedNotificationTable,
        automaticProfileSearchCompletedNotificationTable,
        adminNotificationTable,
        appNotificationSettingsTable
      ];
}
