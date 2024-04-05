// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common_database.dart';

// ignore_for_file: type=lint
class $CommonTable extends Common with TableInfo<$CommonTable, CommonData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CommonTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _demoAccountUserIdMeta =
      const VerificationMeta('demoAccountUserId');
  @override
  late final GeneratedColumn<String> demoAccountUserId =
      GeneratedColumn<String>('demo_account_user_id', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _demoAccountPasswordMeta =
      const VerificationMeta('demoAccountPassword');
  @override
  late final GeneratedColumn<String> demoAccountPassword =
      GeneratedColumn<String>('demo_account_password', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _demoAccountTokenMeta =
      const VerificationMeta('demoAccountToken');
  @override
  late final GeneratedColumn<String> demoAccountToken = GeneratedColumn<String>(
      'demo_account_token', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
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
  static const VerificationMeta _accountIdMeta =
      const VerificationMeta('accountId');
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
      'account_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _imageEncryptionKeyMeta =
      const VerificationMeta('imageEncryptionKey');
  @override
  late final GeneratedColumn<String> imageEncryptionKey =
      GeneratedColumn<String>('image_encryption_key', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notificationPermissionAskedMeta =
      const VerificationMeta('notificationPermissionAsked');
  @override
  late final GeneratedColumn<bool> notificationPermissionAsked =
      GeneratedColumn<bool>('notification_permission_asked', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("notification_permission_asked" IN (0, 1))'),
          defaultValue: const Constant(NOTIFICATION_PERMISSION_ASKED_DEFAULT));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        demoAccountUserId,
        demoAccountPassword,
        demoAccountToken,
        serverUrlAccount,
        serverUrlMedia,
        serverUrlProfile,
        serverUrlChat,
        accountId,
        imageEncryptionKey,
        notificationPermissionAsked
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'common';
  @override
  VerificationContext validateIntegrity(Insertable<CommonData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('demo_account_user_id')) {
      context.handle(
          _demoAccountUserIdMeta,
          demoAccountUserId.isAcceptableOrUnknown(
              data['demo_account_user_id']!, _demoAccountUserIdMeta));
    }
    if (data.containsKey('demo_account_password')) {
      context.handle(
          _demoAccountPasswordMeta,
          demoAccountPassword.isAcceptableOrUnknown(
              data['demo_account_password']!, _demoAccountPasswordMeta));
    }
    if (data.containsKey('demo_account_token')) {
      context.handle(
          _demoAccountTokenMeta,
          demoAccountToken.isAcceptableOrUnknown(
              data['demo_account_token']!, _demoAccountTokenMeta));
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
    if (data.containsKey('account_id')) {
      context.handle(_accountIdMeta,
          accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta));
    }
    if (data.containsKey('image_encryption_key')) {
      context.handle(
          _imageEncryptionKeyMeta,
          imageEncryptionKey.isAcceptableOrUnknown(
              data['image_encryption_key']!, _imageEncryptionKeyMeta));
    }
    if (data.containsKey('notification_permission_asked')) {
      context.handle(
          _notificationPermissionAskedMeta,
          notificationPermissionAsked.isAcceptableOrUnknown(
              data['notification_permission_asked']!,
              _notificationPermissionAskedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CommonData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CommonData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      demoAccountUserId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}demo_account_user_id']),
      demoAccountPassword: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}demo_account_password']),
      demoAccountToken: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}demo_account_token']),
      serverUrlAccount: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}server_url_account']),
      serverUrlMedia: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}server_url_media']),
      serverUrlProfile: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}server_url_profile']),
      serverUrlChat: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}server_url_chat']),
      accountId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}account_id']),
      imageEncryptionKey: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}image_encryption_key']),
      notificationPermissionAsked: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}notification_permission_asked'])!,
    );
  }

  @override
  $CommonTable createAlias(String alias) {
    return $CommonTable(attachedDatabase, alias);
  }
}

class CommonData extends DataClass implements Insertable<CommonData> {
  final int id;
  final String? demoAccountUserId;
  final String? demoAccountPassword;
  final String? demoAccountToken;
  final String? serverUrlAccount;
  final String? serverUrlMedia;
  final String? serverUrlProfile;
  final String? serverUrlChat;
  final String? accountId;
  final String? imageEncryptionKey;

  /// If true don't show notification permission asking dialog when
  /// app main view (bottom navigation is visible) is opened.
  final bool notificationPermissionAsked;
  const CommonData(
      {required this.id,
      this.demoAccountUserId,
      this.demoAccountPassword,
      this.demoAccountToken,
      this.serverUrlAccount,
      this.serverUrlMedia,
      this.serverUrlProfile,
      this.serverUrlChat,
      this.accountId,
      this.imageEncryptionKey,
      required this.notificationPermissionAsked});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || demoAccountUserId != null) {
      map['demo_account_user_id'] = Variable<String>(demoAccountUserId);
    }
    if (!nullToAbsent || demoAccountPassword != null) {
      map['demo_account_password'] = Variable<String>(demoAccountPassword);
    }
    if (!nullToAbsent || demoAccountToken != null) {
      map['demo_account_token'] = Variable<String>(demoAccountToken);
    }
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
    if (!nullToAbsent || accountId != null) {
      map['account_id'] = Variable<String>(accountId);
    }
    if (!nullToAbsent || imageEncryptionKey != null) {
      map['image_encryption_key'] = Variable<String>(imageEncryptionKey);
    }
    map['notification_permission_asked'] =
        Variable<bool>(notificationPermissionAsked);
    return map;
  }

  CommonCompanion toCompanion(bool nullToAbsent) {
    return CommonCompanion(
      id: Value(id),
      demoAccountUserId: demoAccountUserId == null && nullToAbsent
          ? const Value.absent()
          : Value(demoAccountUserId),
      demoAccountPassword: demoAccountPassword == null && nullToAbsent
          ? const Value.absent()
          : Value(demoAccountPassword),
      demoAccountToken: demoAccountToken == null && nullToAbsent
          ? const Value.absent()
          : Value(demoAccountToken),
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
      accountId: accountId == null && nullToAbsent
          ? const Value.absent()
          : Value(accountId),
      imageEncryptionKey: imageEncryptionKey == null && nullToAbsent
          ? const Value.absent()
          : Value(imageEncryptionKey),
      notificationPermissionAsked: Value(notificationPermissionAsked),
    );
  }

  factory CommonData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CommonData(
      id: serializer.fromJson<int>(json['id']),
      demoAccountUserId:
          serializer.fromJson<String?>(json['demoAccountUserId']),
      demoAccountPassword:
          serializer.fromJson<String?>(json['demoAccountPassword']),
      demoAccountToken: serializer.fromJson<String?>(json['demoAccountToken']),
      serverUrlAccount: serializer.fromJson<String?>(json['serverUrlAccount']),
      serverUrlMedia: serializer.fromJson<String?>(json['serverUrlMedia']),
      serverUrlProfile: serializer.fromJson<String?>(json['serverUrlProfile']),
      serverUrlChat: serializer.fromJson<String?>(json['serverUrlChat']),
      accountId: serializer.fromJson<String?>(json['accountId']),
      imageEncryptionKey:
          serializer.fromJson<String?>(json['imageEncryptionKey']),
      notificationPermissionAsked:
          serializer.fromJson<bool>(json['notificationPermissionAsked']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'demoAccountUserId': serializer.toJson<String?>(demoAccountUserId),
      'demoAccountPassword': serializer.toJson<String?>(demoAccountPassword),
      'demoAccountToken': serializer.toJson<String?>(demoAccountToken),
      'serverUrlAccount': serializer.toJson<String?>(serverUrlAccount),
      'serverUrlMedia': serializer.toJson<String?>(serverUrlMedia),
      'serverUrlProfile': serializer.toJson<String?>(serverUrlProfile),
      'serverUrlChat': serializer.toJson<String?>(serverUrlChat),
      'accountId': serializer.toJson<String?>(accountId),
      'imageEncryptionKey': serializer.toJson<String?>(imageEncryptionKey),
      'notificationPermissionAsked':
          serializer.toJson<bool>(notificationPermissionAsked),
    };
  }

  CommonData copyWith(
          {int? id,
          Value<String?> demoAccountUserId = const Value.absent(),
          Value<String?> demoAccountPassword = const Value.absent(),
          Value<String?> demoAccountToken = const Value.absent(),
          Value<String?> serverUrlAccount = const Value.absent(),
          Value<String?> serverUrlMedia = const Value.absent(),
          Value<String?> serverUrlProfile = const Value.absent(),
          Value<String?> serverUrlChat = const Value.absent(),
          Value<String?> accountId = const Value.absent(),
          Value<String?> imageEncryptionKey = const Value.absent(),
          bool? notificationPermissionAsked}) =>
      CommonData(
        id: id ?? this.id,
        demoAccountUserId: demoAccountUserId.present
            ? demoAccountUserId.value
            : this.demoAccountUserId,
        demoAccountPassword: demoAccountPassword.present
            ? demoAccountPassword.value
            : this.demoAccountPassword,
        demoAccountToken: demoAccountToken.present
            ? demoAccountToken.value
            : this.demoAccountToken,
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
        accountId: accountId.present ? accountId.value : this.accountId,
        imageEncryptionKey: imageEncryptionKey.present
            ? imageEncryptionKey.value
            : this.imageEncryptionKey,
        notificationPermissionAsked:
            notificationPermissionAsked ?? this.notificationPermissionAsked,
      );
  @override
  String toString() {
    return (StringBuffer('CommonData(')
          ..write('id: $id, ')
          ..write('demoAccountUserId: $demoAccountUserId, ')
          ..write('demoAccountPassword: $demoAccountPassword, ')
          ..write('demoAccountToken: $demoAccountToken, ')
          ..write('serverUrlAccount: $serverUrlAccount, ')
          ..write('serverUrlMedia: $serverUrlMedia, ')
          ..write('serverUrlProfile: $serverUrlProfile, ')
          ..write('serverUrlChat: $serverUrlChat, ')
          ..write('accountId: $accountId, ')
          ..write('imageEncryptionKey: $imageEncryptionKey, ')
          ..write('notificationPermissionAsked: $notificationPermissionAsked')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      demoAccountUserId,
      demoAccountPassword,
      demoAccountToken,
      serverUrlAccount,
      serverUrlMedia,
      serverUrlProfile,
      serverUrlChat,
      accountId,
      imageEncryptionKey,
      notificationPermissionAsked);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CommonData &&
          other.id == this.id &&
          other.demoAccountUserId == this.demoAccountUserId &&
          other.demoAccountPassword == this.demoAccountPassword &&
          other.demoAccountToken == this.demoAccountToken &&
          other.serverUrlAccount == this.serverUrlAccount &&
          other.serverUrlMedia == this.serverUrlMedia &&
          other.serverUrlProfile == this.serverUrlProfile &&
          other.serverUrlChat == this.serverUrlChat &&
          other.accountId == this.accountId &&
          other.imageEncryptionKey == this.imageEncryptionKey &&
          other.notificationPermissionAsked ==
              this.notificationPermissionAsked);
}

class CommonCompanion extends UpdateCompanion<CommonData> {
  final Value<int> id;
  final Value<String?> demoAccountUserId;
  final Value<String?> demoAccountPassword;
  final Value<String?> demoAccountToken;
  final Value<String?> serverUrlAccount;
  final Value<String?> serverUrlMedia;
  final Value<String?> serverUrlProfile;
  final Value<String?> serverUrlChat;
  final Value<String?> accountId;
  final Value<String?> imageEncryptionKey;
  final Value<bool> notificationPermissionAsked;
  const CommonCompanion({
    this.id = const Value.absent(),
    this.demoAccountUserId = const Value.absent(),
    this.demoAccountPassword = const Value.absent(),
    this.demoAccountToken = const Value.absent(),
    this.serverUrlAccount = const Value.absent(),
    this.serverUrlMedia = const Value.absent(),
    this.serverUrlProfile = const Value.absent(),
    this.serverUrlChat = const Value.absent(),
    this.accountId = const Value.absent(),
    this.imageEncryptionKey = const Value.absent(),
    this.notificationPermissionAsked = const Value.absent(),
  });
  CommonCompanion.insert({
    this.id = const Value.absent(),
    this.demoAccountUserId = const Value.absent(),
    this.demoAccountPassword = const Value.absent(),
    this.demoAccountToken = const Value.absent(),
    this.serverUrlAccount = const Value.absent(),
    this.serverUrlMedia = const Value.absent(),
    this.serverUrlProfile = const Value.absent(),
    this.serverUrlChat = const Value.absent(),
    this.accountId = const Value.absent(),
    this.imageEncryptionKey = const Value.absent(),
    this.notificationPermissionAsked = const Value.absent(),
  });
  static Insertable<CommonData> custom({
    Expression<int>? id,
    Expression<String>? demoAccountUserId,
    Expression<String>? demoAccountPassword,
    Expression<String>? demoAccountToken,
    Expression<String>? serverUrlAccount,
    Expression<String>? serverUrlMedia,
    Expression<String>? serverUrlProfile,
    Expression<String>? serverUrlChat,
    Expression<String>? accountId,
    Expression<String>? imageEncryptionKey,
    Expression<bool>? notificationPermissionAsked,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (demoAccountUserId != null) 'demo_account_user_id': demoAccountUserId,
      if (demoAccountPassword != null)
        'demo_account_password': demoAccountPassword,
      if (demoAccountToken != null) 'demo_account_token': demoAccountToken,
      if (serverUrlAccount != null) 'server_url_account': serverUrlAccount,
      if (serverUrlMedia != null) 'server_url_media': serverUrlMedia,
      if (serverUrlProfile != null) 'server_url_profile': serverUrlProfile,
      if (serverUrlChat != null) 'server_url_chat': serverUrlChat,
      if (accountId != null) 'account_id': accountId,
      if (imageEncryptionKey != null)
        'image_encryption_key': imageEncryptionKey,
      if (notificationPermissionAsked != null)
        'notification_permission_asked': notificationPermissionAsked,
    });
  }

  CommonCompanion copyWith(
      {Value<int>? id,
      Value<String?>? demoAccountUserId,
      Value<String?>? demoAccountPassword,
      Value<String?>? demoAccountToken,
      Value<String?>? serverUrlAccount,
      Value<String?>? serverUrlMedia,
      Value<String?>? serverUrlProfile,
      Value<String?>? serverUrlChat,
      Value<String?>? accountId,
      Value<String?>? imageEncryptionKey,
      Value<bool>? notificationPermissionAsked}) {
    return CommonCompanion(
      id: id ?? this.id,
      demoAccountUserId: demoAccountUserId ?? this.demoAccountUserId,
      demoAccountPassword: demoAccountPassword ?? this.demoAccountPassword,
      demoAccountToken: demoAccountToken ?? this.demoAccountToken,
      serverUrlAccount: serverUrlAccount ?? this.serverUrlAccount,
      serverUrlMedia: serverUrlMedia ?? this.serverUrlMedia,
      serverUrlProfile: serverUrlProfile ?? this.serverUrlProfile,
      serverUrlChat: serverUrlChat ?? this.serverUrlChat,
      accountId: accountId ?? this.accountId,
      imageEncryptionKey: imageEncryptionKey ?? this.imageEncryptionKey,
      notificationPermissionAsked:
          notificationPermissionAsked ?? this.notificationPermissionAsked,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (demoAccountUserId.present) {
      map['demo_account_user_id'] = Variable<String>(demoAccountUserId.value);
    }
    if (demoAccountPassword.present) {
      map['demo_account_password'] =
          Variable<String>(demoAccountPassword.value);
    }
    if (demoAccountToken.present) {
      map['demo_account_token'] = Variable<String>(demoAccountToken.value);
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
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (imageEncryptionKey.present) {
      map['image_encryption_key'] = Variable<String>(imageEncryptionKey.value);
    }
    if (notificationPermissionAsked.present) {
      map['notification_permission_asked'] =
          Variable<bool>(notificationPermissionAsked.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CommonCompanion(')
          ..write('id: $id, ')
          ..write('demoAccountUserId: $demoAccountUserId, ')
          ..write('demoAccountPassword: $demoAccountPassword, ')
          ..write('demoAccountToken: $demoAccountToken, ')
          ..write('serverUrlAccount: $serverUrlAccount, ')
          ..write('serverUrlMedia: $serverUrlMedia, ')
          ..write('serverUrlProfile: $serverUrlProfile, ')
          ..write('serverUrlChat: $serverUrlChat, ')
          ..write('accountId: $accountId, ')
          ..write('imageEncryptionKey: $imageEncryptionKey, ')
          ..write('notificationPermissionAsked: $notificationPermissionAsked')
          ..write(')'))
        .toString();
  }
}

abstract class _$CommonDatabase extends GeneratedDatabase {
  _$CommonDatabase(QueryExecutor e) : super(e);
  late final $CommonTable common = $CommonTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [common];
}
