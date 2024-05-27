// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common_database.dart';

// ignore_for_file: type=lint
class $CommonBackgroundTable extends CommonBackground
    with TableInfo<$CommonBackgroundTable, CommonBackgroundData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CommonBackgroundTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _serverUrlAccountMeta =
      const VerificationMeta('serverUrlAccount');
  @override
  late final GeneratedColumn<String> serverUrlAccount = GeneratedColumn<String>(
      'server_url_account', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _serverUrlMediaMeta =
      const VerificationMeta('serverUrlMedia');
  @override
  late final GeneratedColumn<String> serverUrlMedia = GeneratedColumn<String>(
      'server_url_media', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _serverUrlProfileMeta =
      const VerificationMeta('serverUrlProfile');
  @override
  late final GeneratedColumn<String> serverUrlProfile = GeneratedColumn<String>(
      'server_url_profile', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _serverUrlChatMeta =
      const VerificationMeta('serverUrlChat');
  @override
  late final GeneratedColumn<String> serverUrlChat = GeneratedColumn<String>(
      'server_url_chat', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _uuidAccountIdMeta =
      const VerificationMeta('uuidAccountId');
  @override
  late final GeneratedColumnWithTypeConverter<AccountId?, String>
      uuidAccountId = GeneratedColumn<String>(
              'uuid_account_id', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<AccountId?>(
              $CommonBackgroundTable.$converteruuidAccountId);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        serverUrlAccount,
        serverUrlMedia,
        serverUrlProfile,
        serverUrlChat,
        uuidAccountId
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'common_background';
  @override
  VerificationContext validateIntegrity(
      Insertable<CommonBackgroundData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('server_url_account')) {
      context.handle(
          _serverUrlAccountMeta,
          serverUrlAccount.isAcceptableOrUnknown(
              data['server_url_account']!, _serverUrlAccountMeta));
    }
    if (data.containsKey('server_url_media')) {
      context.handle(
          _serverUrlMediaMeta,
          serverUrlMedia.isAcceptableOrUnknown(
              data['server_url_media']!, _serverUrlMediaMeta));
    }
    if (data.containsKey('server_url_profile')) {
      context.handle(
          _serverUrlProfileMeta,
          serverUrlProfile.isAcceptableOrUnknown(
              data['server_url_profile']!, _serverUrlProfileMeta));
    }
    if (data.containsKey('server_url_chat')) {
      context.handle(
          _serverUrlChatMeta,
          serverUrlChat.isAcceptableOrUnknown(
              data['server_url_chat']!, _serverUrlChatMeta));
    }
    context.handle(_uuidAccountIdMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CommonBackgroundData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CommonBackgroundData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      serverUrlAccount: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}server_url_account']),
      serverUrlMedia: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}server_url_media']),
      serverUrlProfile: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}server_url_profile']),
      serverUrlChat: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}server_url_chat']),
      uuidAccountId: $CommonBackgroundTable.$converteruuidAccountId.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}uuid_account_id'])),
    );
  }

  @override
  $CommonBackgroundTable createAlias(String alias) {
    return $CommonBackgroundTable(attachedDatabase, alias);
  }

  static TypeConverter<AccountId?, String?> $converteruuidAccountId =
      const NullAwareTypeConverter.wrap(AccountIdConverter());
}

class CommonBackgroundData extends DataClass
    implements Insertable<CommonBackgroundData> {
  final int id;
  final String? serverUrlAccount;
  final String? serverUrlMedia;
  final String? serverUrlProfile;
  final String? serverUrlChat;
  final AccountId? uuidAccountId;
  const CommonBackgroundData(
      {required this.id,
      this.serverUrlAccount,
      this.serverUrlMedia,
      this.serverUrlProfile,
      this.serverUrlChat,
      this.uuidAccountId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || serverUrlAccount != null) {
      map['server_url_account'] = Variable<String>(serverUrlAccount);
    }
    if (!nullToAbsent || serverUrlMedia != null) {
      map['server_url_media'] = Variable<String>(serverUrlMedia);
    }
    if (!nullToAbsent || serverUrlProfile != null) {
      map['server_url_profile'] = Variable<String>(serverUrlProfile);
    }
    if (!nullToAbsent || serverUrlChat != null) {
      map['server_url_chat'] = Variable<String>(serverUrlChat);
    }
    if (!nullToAbsent || uuidAccountId != null) {
      map['uuid_account_id'] = Variable<String>(
          $CommonBackgroundTable.$converteruuidAccountId.toSql(uuidAccountId));
    }
    return map;
  }

  CommonBackgroundCompanion toCompanion(bool nullToAbsent) {
    return CommonBackgroundCompanion(
      id: Value(id),
      serverUrlAccount: serverUrlAccount == null && nullToAbsent
          ? const Value.absent()
          : Value(serverUrlAccount),
      serverUrlMedia: serverUrlMedia == null && nullToAbsent
          ? const Value.absent()
          : Value(serverUrlMedia),
      serverUrlProfile: serverUrlProfile == null && nullToAbsent
          ? const Value.absent()
          : Value(serverUrlProfile),
      serverUrlChat: serverUrlChat == null && nullToAbsent
          ? const Value.absent()
          : Value(serverUrlChat),
      uuidAccountId: uuidAccountId == null && nullToAbsent
          ? const Value.absent()
          : Value(uuidAccountId),
    );
  }

  factory CommonBackgroundData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CommonBackgroundData(
      id: serializer.fromJson<int>(json['id']),
      serverUrlAccount: serializer.fromJson<String?>(json['serverUrlAccount']),
      serverUrlMedia: serializer.fromJson<String?>(json['serverUrlMedia']),
      serverUrlProfile: serializer.fromJson<String?>(json['serverUrlProfile']),
      serverUrlChat: serializer.fromJson<String?>(json['serverUrlChat']),
      uuidAccountId: serializer.fromJson<AccountId?>(json['uuidAccountId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'serverUrlAccount': serializer.toJson<String?>(serverUrlAccount),
      'serverUrlMedia': serializer.toJson<String?>(serverUrlMedia),
      'serverUrlProfile': serializer.toJson<String?>(serverUrlProfile),
      'serverUrlChat': serializer.toJson<String?>(serverUrlChat),
      'uuidAccountId': serializer.toJson<AccountId?>(uuidAccountId),
    };
  }

  CommonBackgroundData copyWith(
          {int? id,
          Value<String?> serverUrlAccount = const Value.absent(),
          Value<String?> serverUrlMedia = const Value.absent(),
          Value<String?> serverUrlProfile = const Value.absent(),
          Value<String?> serverUrlChat = const Value.absent(),
          Value<AccountId?> uuidAccountId = const Value.absent()}) =>
      CommonBackgroundData(
        id: id ?? this.id,
        serverUrlAccount: serverUrlAccount.present
            ? serverUrlAccount.value
            : this.serverUrlAccount,
        serverUrlMedia:
            serverUrlMedia.present ? serverUrlMedia.value : this.serverUrlMedia,
        serverUrlProfile: serverUrlProfile.present
            ? serverUrlProfile.value
            : this.serverUrlProfile,
        serverUrlChat:
            serverUrlChat.present ? serverUrlChat.value : this.serverUrlChat,
        uuidAccountId:
            uuidAccountId.present ? uuidAccountId.value : this.uuidAccountId,
      );
  @override
  String toString() {
    return (StringBuffer('CommonBackgroundData(')
          ..write('id: $id, ')
          ..write('serverUrlAccount: $serverUrlAccount, ')
          ..write('serverUrlMedia: $serverUrlMedia, ')
          ..write('serverUrlProfile: $serverUrlProfile, ')
          ..write('serverUrlChat: $serverUrlChat, ')
          ..write('uuidAccountId: $uuidAccountId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, serverUrlAccount, serverUrlMedia,
      serverUrlProfile, serverUrlChat, uuidAccountId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CommonBackgroundData &&
          other.id == this.id &&
          other.serverUrlAccount == this.serverUrlAccount &&
          other.serverUrlMedia == this.serverUrlMedia &&
          other.serverUrlProfile == this.serverUrlProfile &&
          other.serverUrlChat == this.serverUrlChat &&
          other.uuidAccountId == this.uuidAccountId);
}

class CommonBackgroundCompanion extends UpdateCompanion<CommonBackgroundData> {
  final Value<int> id;
  final Value<String?> serverUrlAccount;
  final Value<String?> serverUrlMedia;
  final Value<String?> serverUrlProfile;
  final Value<String?> serverUrlChat;
  final Value<AccountId?> uuidAccountId;
  const CommonBackgroundCompanion({
    this.id = const Value.absent(),
    this.serverUrlAccount = const Value.absent(),
    this.serverUrlMedia = const Value.absent(),
    this.serverUrlProfile = const Value.absent(),
    this.serverUrlChat = const Value.absent(),
    this.uuidAccountId = const Value.absent(),
  });
  CommonBackgroundCompanion.insert({
    this.id = const Value.absent(),
    this.serverUrlAccount = const Value.absent(),
    this.serverUrlMedia = const Value.absent(),
    this.serverUrlProfile = const Value.absent(),
    this.serverUrlChat = const Value.absent(),
    this.uuidAccountId = const Value.absent(),
  });
  static Insertable<CommonBackgroundData> custom({
    Expression<int>? id,
    Expression<String>? serverUrlAccount,
    Expression<String>? serverUrlMedia,
    Expression<String>? serverUrlProfile,
    Expression<String>? serverUrlChat,
    Expression<String>? uuidAccountId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (serverUrlAccount != null) 'server_url_account': serverUrlAccount,
      if (serverUrlMedia != null) 'server_url_media': serverUrlMedia,
      if (serverUrlProfile != null) 'server_url_profile': serverUrlProfile,
      if (serverUrlChat != null) 'server_url_chat': serverUrlChat,
      if (uuidAccountId != null) 'uuid_account_id': uuidAccountId,
    });
  }

  CommonBackgroundCompanion copyWith(
      {Value<int>? id,
      Value<String?>? serverUrlAccount,
      Value<String?>? serverUrlMedia,
      Value<String?>? serverUrlProfile,
      Value<String?>? serverUrlChat,
      Value<AccountId?>? uuidAccountId}) {
    return CommonBackgroundCompanion(
      id: id ?? this.id,
      serverUrlAccount: serverUrlAccount ?? this.serverUrlAccount,
      serverUrlMedia: serverUrlMedia ?? this.serverUrlMedia,
      serverUrlProfile: serverUrlProfile ?? this.serverUrlProfile,
      serverUrlChat: serverUrlChat ?? this.serverUrlChat,
      uuidAccountId: uuidAccountId ?? this.uuidAccountId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (serverUrlAccount.present) {
      map['server_url_account'] = Variable<String>(serverUrlAccount.value);
    }
    if (serverUrlMedia.present) {
      map['server_url_media'] = Variable<String>(serverUrlMedia.value);
    }
    if (serverUrlProfile.present) {
      map['server_url_profile'] = Variable<String>(serverUrlProfile.value);
    }
    if (serverUrlChat.present) {
      map['server_url_chat'] = Variable<String>(serverUrlChat.value);
    }
    if (uuidAccountId.present) {
      map['uuid_account_id'] = Variable<String>($CommonBackgroundTable
          .$converteruuidAccountId
          .toSql(uuidAccountId.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CommonBackgroundCompanion(')
          ..write('id: $id, ')
          ..write('serverUrlAccount: $serverUrlAccount, ')
          ..write('serverUrlMedia: $serverUrlMedia, ')
          ..write('serverUrlProfile: $serverUrlProfile, ')
          ..write('serverUrlChat: $serverUrlChat, ')
          ..write('uuidAccountId: $uuidAccountId')
          ..write(')'))
        .toString();
  }
}

abstract class _$CommonBackgroundDatabase extends GeneratedDatabase {
  _$CommonBackgroundDatabase(QueryExecutor e) : super(e);
  late final $CommonBackgroundTable commonBackground =
      $CommonBackgroundTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [commonBackground];
}
