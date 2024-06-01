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
  static const VerificationMeta _notificationSessionIdMeta =
      const VerificationMeta('notificationSessionId');
  @override
  late final GeneratedColumnWithTypeConverter<NotificationSessionId?, int>
      notificationSessionId = GeneratedColumn<int>(
              'notification_session_id', aliasedName, true,
              type: DriftSqlType.int, requiredDuringInsert: false)
          .withConverter<NotificationSessionId?>(
              $CommonBackgroundTable.$converternotificationSessionId);
  static const VerificationMeta _fcmDeviceTokenMeta =
      const VerificationMeta('fcmDeviceToken');
  @override
  late final GeneratedColumnWithTypeConverter<FcmDeviceToken?, String>
      fcmDeviceToken = GeneratedColumn<String>(
              'fcm_device_token', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<FcmDeviceToken?>(
              $CommonBackgroundTable.$converterfcmDeviceToken);
  static const VerificationMeta _pendingNotificationTokenMeta =
      const VerificationMeta('pendingNotificationToken');
  @override
  late final GeneratedColumnWithTypeConverter<PendingNotificationToken?, String>
      pendingNotificationToken = GeneratedColumn<String>(
              'pending_notification_token', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<PendingNotificationToken?>(
              $CommonBackgroundTable.$converterpendingNotificationToken);
  static const VerificationMeta _currentLocaleMeta =
      const VerificationMeta('currentLocale');
  @override
  late final GeneratedColumn<String> currentLocale = GeneratedColumn<String>(
      'current_locale', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        serverUrlAccount,
        serverUrlMedia,
        serverUrlProfile,
        serverUrlChat,
        uuidAccountId,
        notificationSessionId,
        fcmDeviceToken,
        pendingNotificationToken,
        currentLocale
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
    context.handle(
        _notificationSessionIdMeta, const VerificationResult.success());
    context.handle(_fcmDeviceTokenMeta, const VerificationResult.success());
    context.handle(
        _pendingNotificationTokenMeta, const VerificationResult.success());
    if (data.containsKey('current_locale')) {
      context.handle(
          _currentLocaleMeta,
          currentLocale.isAcceptableOrUnknown(
              data['current_locale']!, _currentLocaleMeta));
    }
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
      notificationSessionId: $CommonBackgroundTable
          .$converternotificationSessionId
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.int,
              data['${effectivePrefix}notification_session_id'])),
      fcmDeviceToken: $CommonBackgroundTable.$converterfcmDeviceToken.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}fcm_device_token'])),
      pendingNotificationToken: $CommonBackgroundTable
          .$converterpendingNotificationToken
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}pending_notification_token'])),
      currentLocale: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}current_locale']),
    );
  }

  @override
  $CommonBackgroundTable createAlias(String alias) {
    return $CommonBackgroundTable(attachedDatabase, alias);
  }

  static TypeConverter<AccountId?, String?> $converteruuidAccountId =
      const NullAwareTypeConverter.wrap(AccountIdConverter());
  static TypeConverter<NotificationSessionId?, int?>
      $converternotificationSessionId =
      const NullAwareTypeConverter.wrap(NotificationSessionIdConverter());
  static TypeConverter<FcmDeviceToken?, String?> $converterfcmDeviceToken =
      const NullAwareTypeConverter.wrap(FcmDeviceTokenConverter());
  static TypeConverter<PendingNotificationToken?, String?>
      $converterpendingNotificationToken =
      const NullAwareTypeConverter.wrap(PendingNotificationTokenConverter());
}

class CommonBackgroundData extends DataClass
    implements Insertable<CommonBackgroundData> {
  final int id;
  final String? serverUrlAccount;
  final String? serverUrlMedia;
  final String? serverUrlProfile;
  final String? serverUrlChat;
  final AccountId? uuidAccountId;

  /// Notification session ID prevents running notification payloads related to
  /// other accounts.
  final NotificationSessionId? notificationSessionId;
  final FcmDeviceToken? fcmDeviceToken;
  final PendingNotificationToken? pendingNotificationToken;
  final String? currentLocale;
  const CommonBackgroundData(
      {required this.id,
      this.serverUrlAccount,
      this.serverUrlMedia,
      this.serverUrlProfile,
      this.serverUrlChat,
      this.uuidAccountId,
      this.notificationSessionId,
      this.fcmDeviceToken,
      this.pendingNotificationToken,
      this.currentLocale});
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
    if (!nullToAbsent || notificationSessionId != null) {
      map['notification_session_id'] = Variable<int>($CommonBackgroundTable
          .$converternotificationSessionId
          .toSql(notificationSessionId));
    }
    if (!nullToAbsent || fcmDeviceToken != null) {
      map['fcm_device_token'] = Variable<String>($CommonBackgroundTable
          .$converterfcmDeviceToken
          .toSql(fcmDeviceToken));
    }
    if (!nullToAbsent || pendingNotificationToken != null) {
      map['pending_notification_token'] = Variable<String>(
          $CommonBackgroundTable.$converterpendingNotificationToken
              .toSql(pendingNotificationToken));
    }
    if (!nullToAbsent || currentLocale != null) {
      map['current_locale'] = Variable<String>(currentLocale);
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
      notificationSessionId: notificationSessionId == null && nullToAbsent
          ? const Value.absent()
          : Value(notificationSessionId),
      fcmDeviceToken: fcmDeviceToken == null && nullToAbsent
          ? const Value.absent()
          : Value(fcmDeviceToken),
      pendingNotificationToken: pendingNotificationToken == null && nullToAbsent
          ? const Value.absent()
          : Value(pendingNotificationToken),
      currentLocale: currentLocale == null && nullToAbsent
          ? const Value.absent()
          : Value(currentLocale),
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
      notificationSessionId: serializer
          .fromJson<NotificationSessionId?>(json['notificationSessionId']),
      fcmDeviceToken:
          serializer.fromJson<FcmDeviceToken?>(json['fcmDeviceToken']),
      pendingNotificationToken: serializer.fromJson<PendingNotificationToken?>(
          json['pendingNotificationToken']),
      currentLocale: serializer.fromJson<String?>(json['currentLocale']),
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
      'notificationSessionId':
          serializer.toJson<NotificationSessionId?>(notificationSessionId),
      'fcmDeviceToken': serializer.toJson<FcmDeviceToken?>(fcmDeviceToken),
      'pendingNotificationToken': serializer
          .toJson<PendingNotificationToken?>(pendingNotificationToken),
      'currentLocale': serializer.toJson<String?>(currentLocale),
    };
  }

  CommonBackgroundData copyWith(
          {int? id,
          Value<String?> serverUrlAccount = const Value.absent(),
          Value<String?> serverUrlMedia = const Value.absent(),
          Value<String?> serverUrlProfile = const Value.absent(),
          Value<String?> serverUrlChat = const Value.absent(),
          Value<AccountId?> uuidAccountId = const Value.absent(),
          Value<NotificationSessionId?> notificationSessionId =
              const Value.absent(),
          Value<FcmDeviceToken?> fcmDeviceToken = const Value.absent(),
          Value<PendingNotificationToken?> pendingNotificationToken =
              const Value.absent(),
          Value<String?> currentLocale = const Value.absent()}) =>
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
        notificationSessionId: notificationSessionId.present
            ? notificationSessionId.value
            : this.notificationSessionId,
        fcmDeviceToken:
            fcmDeviceToken.present ? fcmDeviceToken.value : this.fcmDeviceToken,
        pendingNotificationToken: pendingNotificationToken.present
            ? pendingNotificationToken.value
            : this.pendingNotificationToken,
        currentLocale:
            currentLocale.present ? currentLocale.value : this.currentLocale,
      );
  @override
  String toString() {
    return (StringBuffer('CommonBackgroundData(')
          ..write('id: $id, ')
          ..write('serverUrlAccount: $serverUrlAccount, ')
          ..write('serverUrlMedia: $serverUrlMedia, ')
          ..write('serverUrlProfile: $serverUrlProfile, ')
          ..write('serverUrlChat: $serverUrlChat, ')
          ..write('uuidAccountId: $uuidAccountId, ')
          ..write('notificationSessionId: $notificationSessionId, ')
          ..write('fcmDeviceToken: $fcmDeviceToken, ')
          ..write('pendingNotificationToken: $pendingNotificationToken, ')
          ..write('currentLocale: $currentLocale')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      serverUrlAccount,
      serverUrlMedia,
      serverUrlProfile,
      serverUrlChat,
      uuidAccountId,
      notificationSessionId,
      fcmDeviceToken,
      pendingNotificationToken,
      currentLocale);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CommonBackgroundData &&
          other.id == this.id &&
          other.serverUrlAccount == this.serverUrlAccount &&
          other.serverUrlMedia == this.serverUrlMedia &&
          other.serverUrlProfile == this.serverUrlProfile &&
          other.serverUrlChat == this.serverUrlChat &&
          other.uuidAccountId == this.uuidAccountId &&
          other.notificationSessionId == this.notificationSessionId &&
          other.fcmDeviceToken == this.fcmDeviceToken &&
          other.pendingNotificationToken == this.pendingNotificationToken &&
          other.currentLocale == this.currentLocale);
}

class CommonBackgroundCompanion extends UpdateCompanion<CommonBackgroundData> {
  final Value<int> id;
  final Value<String?> serverUrlAccount;
  final Value<String?> serverUrlMedia;
  final Value<String?> serverUrlProfile;
  final Value<String?> serverUrlChat;
  final Value<AccountId?> uuidAccountId;
  final Value<NotificationSessionId?> notificationSessionId;
  final Value<FcmDeviceToken?> fcmDeviceToken;
  final Value<PendingNotificationToken?> pendingNotificationToken;
  final Value<String?> currentLocale;
  const CommonBackgroundCompanion({
    this.id = const Value.absent(),
    this.serverUrlAccount = const Value.absent(),
    this.serverUrlMedia = const Value.absent(),
    this.serverUrlProfile = const Value.absent(),
    this.serverUrlChat = const Value.absent(),
    this.uuidAccountId = const Value.absent(),
    this.notificationSessionId = const Value.absent(),
    this.fcmDeviceToken = const Value.absent(),
    this.pendingNotificationToken = const Value.absent(),
    this.currentLocale = const Value.absent(),
  });
  CommonBackgroundCompanion.insert({
    this.id = const Value.absent(),
    this.serverUrlAccount = const Value.absent(),
    this.serverUrlMedia = const Value.absent(),
    this.serverUrlProfile = const Value.absent(),
    this.serverUrlChat = const Value.absent(),
    this.uuidAccountId = const Value.absent(),
    this.notificationSessionId = const Value.absent(),
    this.fcmDeviceToken = const Value.absent(),
    this.pendingNotificationToken = const Value.absent(),
    this.currentLocale = const Value.absent(),
  });
  static Insertable<CommonBackgroundData> custom({
    Expression<int>? id,
    Expression<String>? serverUrlAccount,
    Expression<String>? serverUrlMedia,
    Expression<String>? serverUrlProfile,
    Expression<String>? serverUrlChat,
    Expression<String>? uuidAccountId,
    Expression<int>? notificationSessionId,
    Expression<String>? fcmDeviceToken,
    Expression<String>? pendingNotificationToken,
    Expression<String>? currentLocale,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (serverUrlAccount != null) 'server_url_account': serverUrlAccount,
      if (serverUrlMedia != null) 'server_url_media': serverUrlMedia,
      if (serverUrlProfile != null) 'server_url_profile': serverUrlProfile,
      if (serverUrlChat != null) 'server_url_chat': serverUrlChat,
      if (uuidAccountId != null) 'uuid_account_id': uuidAccountId,
      if (notificationSessionId != null)
        'notification_session_id': notificationSessionId,
      if (fcmDeviceToken != null) 'fcm_device_token': fcmDeviceToken,
      if (pendingNotificationToken != null)
        'pending_notification_token': pendingNotificationToken,
      if (currentLocale != null) 'current_locale': currentLocale,
    });
  }

  CommonBackgroundCompanion copyWith(
      {Value<int>? id,
      Value<String?>? serverUrlAccount,
      Value<String?>? serverUrlMedia,
      Value<String?>? serverUrlProfile,
      Value<String?>? serverUrlChat,
      Value<AccountId?>? uuidAccountId,
      Value<NotificationSessionId?>? notificationSessionId,
      Value<FcmDeviceToken?>? fcmDeviceToken,
      Value<PendingNotificationToken?>? pendingNotificationToken,
      Value<String?>? currentLocale}) {
    return CommonBackgroundCompanion(
      id: id ?? this.id,
      serverUrlAccount: serverUrlAccount ?? this.serverUrlAccount,
      serverUrlMedia: serverUrlMedia ?? this.serverUrlMedia,
      serverUrlProfile: serverUrlProfile ?? this.serverUrlProfile,
      serverUrlChat: serverUrlChat ?? this.serverUrlChat,
      uuidAccountId: uuidAccountId ?? this.uuidAccountId,
      notificationSessionId:
          notificationSessionId ?? this.notificationSessionId,
      fcmDeviceToken: fcmDeviceToken ?? this.fcmDeviceToken,
      pendingNotificationToken:
          pendingNotificationToken ?? this.pendingNotificationToken,
      currentLocale: currentLocale ?? this.currentLocale,
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
    if (notificationSessionId.present) {
      map['notification_session_id'] = Variable<int>($CommonBackgroundTable
          .$converternotificationSessionId
          .toSql(notificationSessionId.value));
    }
    if (fcmDeviceToken.present) {
      map['fcm_device_token'] = Variable<String>($CommonBackgroundTable
          .$converterfcmDeviceToken
          .toSql(fcmDeviceToken.value));
    }
    if (pendingNotificationToken.present) {
      map['pending_notification_token'] = Variable<String>(
          $CommonBackgroundTable.$converterpendingNotificationToken
              .toSql(pendingNotificationToken.value));
    }
    if (currentLocale.present) {
      map['current_locale'] = Variable<String>(currentLocale.value);
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
          ..write('uuidAccountId: $uuidAccountId, ')
          ..write('notificationSessionId: $notificationSessionId, ')
          ..write('fcmDeviceToken: $fcmDeviceToken, ')
          ..write('pendingNotificationToken: $pendingNotificationToken, ')
          ..write('currentLocale: $currentLocale')
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
