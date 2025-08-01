// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $AccountIdTable extends schema.AccountId
    with TableInfo<$AccountIdTable, AccountIdData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AccountIdTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<AccountId?, String> accountId =
      GeneratedColumn<String>(
        'account_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<AccountId?>($AccountIdTable.$converteraccountId);
  @override
  List<GeneratedColumn> get $columns => [id, accountId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'account_id';
  @override
  VerificationContext validateIntegrity(
    Insertable<AccountIdData> instance, {
    bool isInserting = false,
  }) {
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
  AccountIdData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AccountIdData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      accountId: $AccountIdTable.$converteraccountId.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}account_id'],
        ),
      ),
    );
  }

  @override
  $AccountIdTable createAlias(String alias) {
    return $AccountIdTable(attachedDatabase, alias);
  }

  static TypeConverter<AccountId?, String?> $converteraccountId =
      const NullAwareTypeConverter.wrap(AccountIdConverter());
}

class AccountIdData extends DataClass implements Insertable<AccountIdData> {
  final int id;
  final AccountId? accountId;
  const AccountIdData({required this.id, this.accountId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || accountId != null) {
      map['account_id'] = Variable<String>(
        $AccountIdTable.$converteraccountId.toSql(accountId),
      );
    }
    return map;
  }

  AccountIdCompanion toCompanion(bool nullToAbsent) {
    return AccountIdCompanion(
      id: Value(id),
      accountId: accountId == null && nullToAbsent
          ? const Value.absent()
          : Value(accountId),
    );
  }

  factory AccountIdData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AccountIdData(
      id: serializer.fromJson<int>(json['id']),
      accountId: serializer.fromJson<AccountId?>(json['accountId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'accountId': serializer.toJson<AccountId?>(accountId),
    };
  }

  AccountIdData copyWith({
    int? id,
    Value<AccountId?> accountId = const Value.absent(),
  }) => AccountIdData(
    id: id ?? this.id,
    accountId: accountId.present ? accountId.value : this.accountId,
  );
  AccountIdData copyWithCompanion(AccountIdCompanion data) {
    return AccountIdData(
      id: data.id.present ? data.id.value : this.id,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AccountIdData(')
          ..write('id: $id, ')
          ..write('accountId: $accountId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, accountId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AccountIdData &&
          other.id == this.id &&
          other.accountId == this.accountId);
}

class AccountIdCompanion extends UpdateCompanion<AccountIdData> {
  final Value<int> id;
  final Value<AccountId?> accountId;
  const AccountIdCompanion({
    this.id = const Value.absent(),
    this.accountId = const Value.absent(),
  });
  AccountIdCompanion.insert({
    this.id = const Value.absent(),
    this.accountId = const Value.absent(),
  });
  static Insertable<AccountIdData> custom({
    Expression<int>? id,
    Expression<String>? accountId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (accountId != null) 'account_id': accountId,
    });
  }

  AccountIdCompanion copyWith({Value<int>? id, Value<AccountId?>? accountId}) {
    return AccountIdCompanion(
      id: id ?? this.id,
      accountId: accountId ?? this.accountId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<String>(
        $AccountIdTable.$converteraccountId.toSql(accountId.value),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AccountIdCompanion(')
          ..write('id: $id, ')
          ..write('accountId: $accountId')
          ..write(')'))
        .toString();
  }
}

class $ServerUrlTable extends schema.ServerUrl
    with TableInfo<$ServerUrlTable, ServerUrlData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ServerUrlTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _serverUrlMeta = const VerificationMeta(
    'serverUrl',
  );
  @override
  late final GeneratedColumn<String> serverUrl = GeneratedColumn<String>(
    'server_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, serverUrl];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'server_url';
  @override
  VerificationContext validateIntegrity(
    Insertable<ServerUrlData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('server_url')) {
      context.handle(
        _serverUrlMeta,
        serverUrl.isAcceptableOrUnknown(data['server_url']!, _serverUrlMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ServerUrlData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ServerUrlData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      serverUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}server_url'],
      ),
    );
  }

  @override
  $ServerUrlTable createAlias(String alias) {
    return $ServerUrlTable(attachedDatabase, alias);
  }
}

class ServerUrlData extends DataClass implements Insertable<ServerUrlData> {
  final int id;
  final String? serverUrl;
  const ServerUrlData({required this.id, this.serverUrl});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || serverUrl != null) {
      map['server_url'] = Variable<String>(serverUrl);
    }
    return map;
  }

  ServerUrlCompanion toCompanion(bool nullToAbsent) {
    return ServerUrlCompanion(
      id: Value(id),
      serverUrl: serverUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(serverUrl),
    );
  }

  factory ServerUrlData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ServerUrlData(
      id: serializer.fromJson<int>(json['id']),
      serverUrl: serializer.fromJson<String?>(json['serverUrl']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'serverUrl': serializer.toJson<String?>(serverUrl),
    };
  }

  ServerUrlData copyWith({
    int? id,
    Value<String?> serverUrl = const Value.absent(),
  }) => ServerUrlData(
    id: id ?? this.id,
    serverUrl: serverUrl.present ? serverUrl.value : this.serverUrl,
  );
  ServerUrlData copyWithCompanion(ServerUrlCompanion data) {
    return ServerUrlData(
      id: data.id.present ? data.id.value : this.id,
      serverUrl: data.serverUrl.present ? data.serverUrl.value : this.serverUrl,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ServerUrlData(')
          ..write('id: $id, ')
          ..write('serverUrl: $serverUrl')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, serverUrl);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ServerUrlData &&
          other.id == this.id &&
          other.serverUrl == this.serverUrl);
}

class ServerUrlCompanion extends UpdateCompanion<ServerUrlData> {
  final Value<int> id;
  final Value<String?> serverUrl;
  const ServerUrlCompanion({
    this.id = const Value.absent(),
    this.serverUrl = const Value.absent(),
  });
  ServerUrlCompanion.insert({
    this.id = const Value.absent(),
    this.serverUrl = const Value.absent(),
  });
  static Insertable<ServerUrlData> custom({
    Expression<int>? id,
    Expression<String>? serverUrl,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (serverUrl != null) 'server_url': serverUrl,
    });
  }

  ServerUrlCompanion copyWith({Value<int>? id, Value<String?>? serverUrl}) {
    return ServerUrlCompanion(
      id: id ?? this.id,
      serverUrl: serverUrl ?? this.serverUrl,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (serverUrl.present) {
      map['server_url'] = Variable<String>(serverUrl.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ServerUrlCompanion(')
          ..write('id: $id, ')
          ..write('serverUrl: $serverUrl')
          ..write(')'))
        .toString();
  }
}

class $PushNotificationTable extends schema.PushNotification
    with TableInfo<$PushNotificationTable, PushNotificationData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PushNotificationTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<FcmDeviceToken?, String>
  fcmDeviceToken =
      GeneratedColumn<String>(
        'fcm_device_token',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<FcmDeviceToken?>(
        $PushNotificationTable.$converterfcmDeviceToken,
      );
  @override
  late final GeneratedColumnWithTypeConverter<PendingNotificationToken?, String>
  pendingNotificationToken =
      GeneratedColumn<String>(
        'pending_notification_token',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<PendingNotificationToken?>(
        $PushNotificationTable.$converterpendingNotificationToken,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    fcmDeviceToken,
    pendingNotificationToken,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'push_notification';
  @override
  VerificationContext validateIntegrity(
    Insertable<PushNotificationData> instance, {
    bool isInserting = false,
  }) {
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
  PushNotificationData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PushNotificationData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      fcmDeviceToken: $PushNotificationTable.$converterfcmDeviceToken.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}fcm_device_token'],
        ),
      ),
      pendingNotificationToken: $PushNotificationTable
          .$converterpendingNotificationToken
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}pending_notification_token'],
            ),
          ),
    );
  }

  @override
  $PushNotificationTable createAlias(String alias) {
    return $PushNotificationTable(attachedDatabase, alias);
  }

  static TypeConverter<FcmDeviceToken?, String?> $converterfcmDeviceToken =
      const NullAwareTypeConverter.wrap(FcmDeviceTokenConverter());
  static TypeConverter<PendingNotificationToken?, String?>
  $converterpendingNotificationToken = const NullAwareTypeConverter.wrap(
    PendingNotificationTokenConverter(),
  );
}

class PushNotificationData extends DataClass
    implements Insertable<PushNotificationData> {
  final int id;
  final FcmDeviceToken? fcmDeviceToken;
  final PendingNotificationToken? pendingNotificationToken;
  const PushNotificationData({
    required this.id,
    this.fcmDeviceToken,
    this.pendingNotificationToken,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || fcmDeviceToken != null) {
      map['fcm_device_token'] = Variable<String>(
        $PushNotificationTable.$converterfcmDeviceToken.toSql(fcmDeviceToken),
      );
    }
    if (!nullToAbsent || pendingNotificationToken != null) {
      map['pending_notification_token'] = Variable<String>(
        $PushNotificationTable.$converterpendingNotificationToken.toSql(
          pendingNotificationToken,
        ),
      );
    }
    return map;
  }

  PushNotificationCompanion toCompanion(bool nullToAbsent) {
    return PushNotificationCompanion(
      id: Value(id),
      fcmDeviceToken: fcmDeviceToken == null && nullToAbsent
          ? const Value.absent()
          : Value(fcmDeviceToken),
      pendingNotificationToken: pendingNotificationToken == null && nullToAbsent
          ? const Value.absent()
          : Value(pendingNotificationToken),
    );
  }

  factory PushNotificationData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PushNotificationData(
      id: serializer.fromJson<int>(json['id']),
      fcmDeviceToken: serializer.fromJson<FcmDeviceToken?>(
        json['fcmDeviceToken'],
      ),
      pendingNotificationToken: serializer.fromJson<PendingNotificationToken?>(
        json['pendingNotificationToken'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'fcmDeviceToken': serializer.toJson<FcmDeviceToken?>(fcmDeviceToken),
      'pendingNotificationToken': serializer.toJson<PendingNotificationToken?>(
        pendingNotificationToken,
      ),
    };
  }

  PushNotificationData copyWith({
    int? id,
    Value<FcmDeviceToken?> fcmDeviceToken = const Value.absent(),
    Value<PendingNotificationToken?> pendingNotificationToken =
        const Value.absent(),
  }) => PushNotificationData(
    id: id ?? this.id,
    fcmDeviceToken: fcmDeviceToken.present
        ? fcmDeviceToken.value
        : this.fcmDeviceToken,
    pendingNotificationToken: pendingNotificationToken.present
        ? pendingNotificationToken.value
        : this.pendingNotificationToken,
  );
  PushNotificationData copyWithCompanion(PushNotificationCompanion data) {
    return PushNotificationData(
      id: data.id.present ? data.id.value : this.id,
      fcmDeviceToken: data.fcmDeviceToken.present
          ? data.fcmDeviceToken.value
          : this.fcmDeviceToken,
      pendingNotificationToken: data.pendingNotificationToken.present
          ? data.pendingNotificationToken.value
          : this.pendingNotificationToken,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PushNotificationData(')
          ..write('id: $id, ')
          ..write('fcmDeviceToken: $fcmDeviceToken, ')
          ..write('pendingNotificationToken: $pendingNotificationToken')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, fcmDeviceToken, pendingNotificationToken);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PushNotificationData &&
          other.id == this.id &&
          other.fcmDeviceToken == this.fcmDeviceToken &&
          other.pendingNotificationToken == this.pendingNotificationToken);
}

class PushNotificationCompanion extends UpdateCompanion<PushNotificationData> {
  final Value<int> id;
  final Value<FcmDeviceToken?> fcmDeviceToken;
  final Value<PendingNotificationToken?> pendingNotificationToken;
  const PushNotificationCompanion({
    this.id = const Value.absent(),
    this.fcmDeviceToken = const Value.absent(),
    this.pendingNotificationToken = const Value.absent(),
  });
  PushNotificationCompanion.insert({
    this.id = const Value.absent(),
    this.fcmDeviceToken = const Value.absent(),
    this.pendingNotificationToken = const Value.absent(),
  });
  static Insertable<PushNotificationData> custom({
    Expression<int>? id,
    Expression<String>? fcmDeviceToken,
    Expression<String>? pendingNotificationToken,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fcmDeviceToken != null) 'fcm_device_token': fcmDeviceToken,
      if (pendingNotificationToken != null)
        'pending_notification_token': pendingNotificationToken,
    });
  }

  PushNotificationCompanion copyWith({
    Value<int>? id,
    Value<FcmDeviceToken?>? fcmDeviceToken,
    Value<PendingNotificationToken?>? pendingNotificationToken,
  }) {
    return PushNotificationCompanion(
      id: id ?? this.id,
      fcmDeviceToken: fcmDeviceToken ?? this.fcmDeviceToken,
      pendingNotificationToken:
          pendingNotificationToken ?? this.pendingNotificationToken,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (fcmDeviceToken.present) {
      map['fcm_device_token'] = Variable<String>(
        $PushNotificationTable.$converterfcmDeviceToken.toSql(
          fcmDeviceToken.value,
        ),
      );
    }
    if (pendingNotificationToken.present) {
      map['pending_notification_token'] = Variable<String>(
        $PushNotificationTable.$converterpendingNotificationToken.toSql(
          pendingNotificationToken.value,
        ),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PushNotificationCompanion(')
          ..write('id: $id, ')
          ..write('fcmDeviceToken: $fcmDeviceToken, ')
          ..write('pendingNotificationToken: $pendingNotificationToken')
          ..write(')'))
        .toString();
  }
}

class $CurrentLocaleTable extends schema.CurrentLocale
    with TableInfo<$CurrentLocaleTable, CurrentLocaleData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CurrentLocaleTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _currentLocaleMeta = const VerificationMeta(
    'currentLocale',
  );
  @override
  late final GeneratedColumn<String> currentLocale = GeneratedColumn<String>(
    'current_locale',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, currentLocale];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'current_locale';
  @override
  VerificationContext validateIntegrity(
    Insertable<CurrentLocaleData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('current_locale')) {
      context.handle(
        _currentLocaleMeta,
        currentLocale.isAcceptableOrUnknown(
          data['current_locale']!,
          _currentLocaleMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CurrentLocaleData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CurrentLocaleData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      currentLocale: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}current_locale'],
      ),
    );
  }

  @override
  $CurrentLocaleTable createAlias(String alias) {
    return $CurrentLocaleTable(attachedDatabase, alias);
  }
}

class CurrentLocaleData extends DataClass
    implements Insertable<CurrentLocaleData> {
  final int id;
  final String? currentLocale;
  const CurrentLocaleData({required this.id, this.currentLocale});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || currentLocale != null) {
      map['current_locale'] = Variable<String>(currentLocale);
    }
    return map;
  }

  CurrentLocaleCompanion toCompanion(bool nullToAbsent) {
    return CurrentLocaleCompanion(
      id: Value(id),
      currentLocale: currentLocale == null && nullToAbsent
          ? const Value.absent()
          : Value(currentLocale),
    );
  }

  factory CurrentLocaleData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CurrentLocaleData(
      id: serializer.fromJson<int>(json['id']),
      currentLocale: serializer.fromJson<String?>(json['currentLocale']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'currentLocale': serializer.toJson<String?>(currentLocale),
    };
  }

  CurrentLocaleData copyWith({
    int? id,
    Value<String?> currentLocale = const Value.absent(),
  }) => CurrentLocaleData(
    id: id ?? this.id,
    currentLocale: currentLocale.present
        ? currentLocale.value
        : this.currentLocale,
  );
  CurrentLocaleData copyWithCompanion(CurrentLocaleCompanion data) {
    return CurrentLocaleData(
      id: data.id.present ? data.id.value : this.id,
      currentLocale: data.currentLocale.present
          ? data.currentLocale.value
          : this.currentLocale,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CurrentLocaleData(')
          ..write('id: $id, ')
          ..write('currentLocale: $currentLocale')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, currentLocale);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CurrentLocaleData &&
          other.id == this.id &&
          other.currentLocale == this.currentLocale);
}

class CurrentLocaleCompanion extends UpdateCompanion<CurrentLocaleData> {
  final Value<int> id;
  final Value<String?> currentLocale;
  const CurrentLocaleCompanion({
    this.id = const Value.absent(),
    this.currentLocale = const Value.absent(),
  });
  CurrentLocaleCompanion.insert({
    this.id = const Value.absent(),
    this.currentLocale = const Value.absent(),
  });
  static Insertable<CurrentLocaleData> custom({
    Expression<int>? id,
    Expression<String>? currentLocale,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (currentLocale != null) 'current_locale': currentLocale,
    });
  }

  CurrentLocaleCompanion copyWith({
    Value<int>? id,
    Value<String?>? currentLocale,
  }) {
    return CurrentLocaleCompanion(
      id: id ?? this.id,
      currentLocale: currentLocale ?? this.currentLocale,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (currentLocale.present) {
      map['current_locale'] = Variable<String>(currentLocale.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CurrentLocaleCompanion(')
          ..write('id: $id, ')
          ..write('currentLocale: $currentLocale')
          ..write(')'))
        .toString();
  }
}

abstract class _$CommonBackgroundDatabase extends GeneratedDatabase {
  _$CommonBackgroundDatabase(QueryExecutor e) : super(e);
  late final $AccountIdTable accountId = $AccountIdTable(this);
  late final $ServerUrlTable serverUrl = $ServerUrlTable(this);
  late final $PushNotificationTable pushNotification = $PushNotificationTable(
    this,
  );
  late final $CurrentLocaleTable currentLocale = $CurrentLocaleTable(this);
  late final DaoReadApp daoReadApp = DaoReadApp(
    this as CommonBackgroundDatabase,
  );
  late final DaoReadLoginSession daoReadLoginSession = DaoReadLoginSession(
    this as CommonBackgroundDatabase,
  );
  late final DaoWriteApp daoWriteApp = DaoWriteApp(
    this as CommonBackgroundDatabase,
  );
  late final DaoWriteLoginSession daoWriteLoginSession = DaoWriteLoginSession(
    this as CommonBackgroundDatabase,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    accountId,
    serverUrl,
    pushNotification,
    currentLocale,
  ];
}
