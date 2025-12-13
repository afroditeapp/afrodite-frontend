// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $DemoAccountTable extends schema.DemoAccount
    with TableInfo<$DemoAccountTable, DemoAccountData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DemoAccountTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _demoAccountUsernameMeta =
      const VerificationMeta('demoAccountUsername');
  @override
  late final GeneratedColumn<String> demoAccountUsername =
      GeneratedColumn<String>(
        'demo_account_username',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _demoAccountPasswordMeta =
      const VerificationMeta('demoAccountPassword');
  @override
  late final GeneratedColumn<String> demoAccountPassword =
      GeneratedColumn<String>(
        'demo_account_password',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _demoAccountTokenMeta = const VerificationMeta(
    'demoAccountToken',
  );
  @override
  late final GeneratedColumn<String> demoAccountToken = GeneratedColumn<String>(
    'demo_account_token',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    demoAccountUsername,
    demoAccountPassword,
    demoAccountToken,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'demo_account';
  @override
  VerificationContext validateIntegrity(
    Insertable<DemoAccountData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('demo_account_username')) {
      context.handle(
        _demoAccountUsernameMeta,
        demoAccountUsername.isAcceptableOrUnknown(
          data['demo_account_username']!,
          _demoAccountUsernameMeta,
        ),
      );
    }
    if (data.containsKey('demo_account_password')) {
      context.handle(
        _demoAccountPasswordMeta,
        demoAccountPassword.isAcceptableOrUnknown(
          data['demo_account_password']!,
          _demoAccountPasswordMeta,
        ),
      );
    }
    if (data.containsKey('demo_account_token')) {
      context.handle(
        _demoAccountTokenMeta,
        demoAccountToken.isAcceptableOrUnknown(
          data['demo_account_token']!,
          _demoAccountTokenMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DemoAccountData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DemoAccountData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      demoAccountUsername: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}demo_account_username'],
      ),
      demoAccountPassword: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}demo_account_password'],
      ),
      demoAccountToken: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}demo_account_token'],
      ),
    );
  }

  @override
  $DemoAccountTable createAlias(String alias) {
    return $DemoAccountTable(attachedDatabase, alias);
  }
}

class DemoAccountData extends DataClass implements Insertable<DemoAccountData> {
  final int id;
  final String? demoAccountUsername;
  final String? demoAccountPassword;
  final String? demoAccountToken;
  const DemoAccountData({
    required this.id,
    this.demoAccountUsername,
    this.demoAccountPassword,
    this.demoAccountToken,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || demoAccountUsername != null) {
      map['demo_account_username'] = Variable<String>(demoAccountUsername);
    }
    if (!nullToAbsent || demoAccountPassword != null) {
      map['demo_account_password'] = Variable<String>(demoAccountPassword);
    }
    if (!nullToAbsent || demoAccountToken != null) {
      map['demo_account_token'] = Variable<String>(demoAccountToken);
    }
    return map;
  }

  DemoAccountCompanion toCompanion(bool nullToAbsent) {
    return DemoAccountCompanion(
      id: Value(id),
      demoAccountUsername: demoAccountUsername == null && nullToAbsent
          ? const Value.absent()
          : Value(demoAccountUsername),
      demoAccountPassword: demoAccountPassword == null && nullToAbsent
          ? const Value.absent()
          : Value(demoAccountPassword),
      demoAccountToken: demoAccountToken == null && nullToAbsent
          ? const Value.absent()
          : Value(demoAccountToken),
    );
  }

  factory DemoAccountData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DemoAccountData(
      id: serializer.fromJson<int>(json['id']),
      demoAccountUsername: serializer.fromJson<String?>(
        json['demoAccountUsername'],
      ),
      demoAccountPassword: serializer.fromJson<String?>(
        json['demoAccountPassword'],
      ),
      demoAccountToken: serializer.fromJson<String?>(json['demoAccountToken']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'demoAccountUsername': serializer.toJson<String?>(demoAccountUsername),
      'demoAccountPassword': serializer.toJson<String?>(demoAccountPassword),
      'demoAccountToken': serializer.toJson<String?>(demoAccountToken),
    };
  }

  DemoAccountData copyWith({
    int? id,
    Value<String?> demoAccountUsername = const Value.absent(),
    Value<String?> demoAccountPassword = const Value.absent(),
    Value<String?> demoAccountToken = const Value.absent(),
  }) => DemoAccountData(
    id: id ?? this.id,
    demoAccountUsername: demoAccountUsername.present
        ? demoAccountUsername.value
        : this.demoAccountUsername,
    demoAccountPassword: demoAccountPassword.present
        ? demoAccountPassword.value
        : this.demoAccountPassword,
    demoAccountToken: demoAccountToken.present
        ? demoAccountToken.value
        : this.demoAccountToken,
  );
  DemoAccountData copyWithCompanion(DemoAccountCompanion data) {
    return DemoAccountData(
      id: data.id.present ? data.id.value : this.id,
      demoAccountUsername: data.demoAccountUsername.present
          ? data.demoAccountUsername.value
          : this.demoAccountUsername,
      demoAccountPassword: data.demoAccountPassword.present
          ? data.demoAccountPassword.value
          : this.demoAccountPassword,
      demoAccountToken: data.demoAccountToken.present
          ? data.demoAccountToken.value
          : this.demoAccountToken,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DemoAccountData(')
          ..write('id: $id, ')
          ..write('demoAccountUsername: $demoAccountUsername, ')
          ..write('demoAccountPassword: $demoAccountPassword, ')
          ..write('demoAccountToken: $demoAccountToken')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    demoAccountUsername,
    demoAccountPassword,
    demoAccountToken,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DemoAccountData &&
          other.id == this.id &&
          other.demoAccountUsername == this.demoAccountUsername &&
          other.demoAccountPassword == this.demoAccountPassword &&
          other.demoAccountToken == this.demoAccountToken);
}

class DemoAccountCompanion extends UpdateCompanion<DemoAccountData> {
  final Value<int> id;
  final Value<String?> demoAccountUsername;
  final Value<String?> demoAccountPassword;
  final Value<String?> demoAccountToken;
  const DemoAccountCompanion({
    this.id = const Value.absent(),
    this.demoAccountUsername = const Value.absent(),
    this.demoAccountPassword = const Value.absent(),
    this.demoAccountToken = const Value.absent(),
  });
  DemoAccountCompanion.insert({
    this.id = const Value.absent(),
    this.demoAccountUsername = const Value.absent(),
    this.demoAccountPassword = const Value.absent(),
    this.demoAccountToken = const Value.absent(),
  });
  static Insertable<DemoAccountData> custom({
    Expression<int>? id,
    Expression<String>? demoAccountUsername,
    Expression<String>? demoAccountPassword,
    Expression<String>? demoAccountToken,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (demoAccountUsername != null)
        'demo_account_username': demoAccountUsername,
      if (demoAccountPassword != null)
        'demo_account_password': demoAccountPassword,
      if (demoAccountToken != null) 'demo_account_token': demoAccountToken,
    });
  }

  DemoAccountCompanion copyWith({
    Value<int>? id,
    Value<String?>? demoAccountUsername,
    Value<String?>? demoAccountPassword,
    Value<String?>? demoAccountToken,
  }) {
    return DemoAccountCompanion(
      id: id ?? this.id,
      demoAccountUsername: demoAccountUsername ?? this.demoAccountUsername,
      demoAccountPassword: demoAccountPassword ?? this.demoAccountPassword,
      demoAccountToken: demoAccountToken ?? this.demoAccountToken,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (demoAccountUsername.present) {
      map['demo_account_username'] = Variable<String>(
        demoAccountUsername.value,
      );
    }
    if (demoAccountPassword.present) {
      map['demo_account_password'] = Variable<String>(
        demoAccountPassword.value,
      );
    }
    if (demoAccountToken.present) {
      map['demo_account_token'] = Variable<String>(demoAccountToken.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DemoAccountCompanion(')
          ..write('id: $id, ')
          ..write('demoAccountUsername: $demoAccountUsername, ')
          ..write('demoAccountPassword: $demoAccountPassword, ')
          ..write('demoAccountToken: $demoAccountToken')
          ..write(')'))
        .toString();
  }
}

class $ImageEncryptionKeyTable extends schema.ImageEncryptionKey
    with TableInfo<$ImageEncryptionKeyTable, ImageEncryptionKeyData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ImageEncryptionKeyTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _imageEncryptionKeyMeta =
      const VerificationMeta('imageEncryptionKey');
  @override
  late final GeneratedColumn<Uint8List> imageEncryptionKey =
      GeneratedColumn<Uint8List>(
        'image_encryption_key',
        aliasedName,
        true,
        type: DriftSqlType.blob,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [id, imageEncryptionKey];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'image_encryption_key';
  @override
  VerificationContext validateIntegrity(
    Insertable<ImageEncryptionKeyData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('image_encryption_key')) {
      context.handle(
        _imageEncryptionKeyMeta,
        imageEncryptionKey.isAcceptableOrUnknown(
          data['image_encryption_key']!,
          _imageEncryptionKeyMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ImageEncryptionKeyData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ImageEncryptionKeyData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      imageEncryptionKey: attachedDatabase.typeMapping.read(
        DriftSqlType.blob,
        data['${effectivePrefix}image_encryption_key'],
      ),
    );
  }

  @override
  $ImageEncryptionKeyTable createAlias(String alias) {
    return $ImageEncryptionKeyTable(attachedDatabase, alias);
  }
}

class ImageEncryptionKeyData extends DataClass
    implements Insertable<ImageEncryptionKeyData> {
  final int id;
  final Uint8List? imageEncryptionKey;
  const ImageEncryptionKeyData({required this.id, this.imageEncryptionKey});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || imageEncryptionKey != null) {
      map['image_encryption_key'] = Variable<Uint8List>(imageEncryptionKey);
    }
    return map;
  }

  ImageEncryptionKeyCompanion toCompanion(bool nullToAbsent) {
    return ImageEncryptionKeyCompanion(
      id: Value(id),
      imageEncryptionKey: imageEncryptionKey == null && nullToAbsent
          ? const Value.absent()
          : Value(imageEncryptionKey),
    );
  }

  factory ImageEncryptionKeyData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ImageEncryptionKeyData(
      id: serializer.fromJson<int>(json['id']),
      imageEncryptionKey: serializer.fromJson<Uint8List?>(
        json['imageEncryptionKey'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'imageEncryptionKey': serializer.toJson<Uint8List?>(imageEncryptionKey),
    };
  }

  ImageEncryptionKeyData copyWith({
    int? id,
    Value<Uint8List?> imageEncryptionKey = const Value.absent(),
  }) => ImageEncryptionKeyData(
    id: id ?? this.id,
    imageEncryptionKey: imageEncryptionKey.present
        ? imageEncryptionKey.value
        : this.imageEncryptionKey,
  );
  ImageEncryptionKeyData copyWithCompanion(ImageEncryptionKeyCompanion data) {
    return ImageEncryptionKeyData(
      id: data.id.present ? data.id.value : this.id,
      imageEncryptionKey: data.imageEncryptionKey.present
          ? data.imageEncryptionKey.value
          : this.imageEncryptionKey,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ImageEncryptionKeyData(')
          ..write('id: $id, ')
          ..write('imageEncryptionKey: $imageEncryptionKey')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, $driftBlobEquality.hash(imageEncryptionKey));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ImageEncryptionKeyData &&
          other.id == this.id &&
          $driftBlobEquality.equals(
            other.imageEncryptionKey,
            this.imageEncryptionKey,
          ));
}

class ImageEncryptionKeyCompanion
    extends UpdateCompanion<ImageEncryptionKeyData> {
  final Value<int> id;
  final Value<Uint8List?> imageEncryptionKey;
  const ImageEncryptionKeyCompanion({
    this.id = const Value.absent(),
    this.imageEncryptionKey = const Value.absent(),
  });
  ImageEncryptionKeyCompanion.insert({
    this.id = const Value.absent(),
    this.imageEncryptionKey = const Value.absent(),
  });
  static Insertable<ImageEncryptionKeyData> custom({
    Expression<int>? id,
    Expression<Uint8List>? imageEncryptionKey,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (imageEncryptionKey != null)
        'image_encryption_key': imageEncryptionKey,
    });
  }

  ImageEncryptionKeyCompanion copyWith({
    Value<int>? id,
    Value<Uint8List?>? imageEncryptionKey,
  }) {
    return ImageEncryptionKeyCompanion(
      id: id ?? this.id,
      imageEncryptionKey: imageEncryptionKey ?? this.imageEncryptionKey,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (imageEncryptionKey.present) {
      map['image_encryption_key'] = Variable<Uint8List>(
        imageEncryptionKey.value,
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ImageEncryptionKeyCompanion(')
          ..write('id: $id, ')
          ..write('imageEncryptionKey: $imageEncryptionKey')
          ..write(')'))
        .toString();
  }
}

class $NotificationPermissionAskedTable
    extends schema.NotificationPermissionAsked
    with
        TableInfo<
          $NotificationPermissionAskedTable,
          NotificationPermissionAskedData
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotificationPermissionAskedTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _notificationPermissionAskedMeta =
      const VerificationMeta('notificationPermissionAsked');
  @override
  late final GeneratedColumn<bool> notificationPermissionAsked =
      GeneratedColumn<bool>(
        'notification_permission_asked',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("notification_permission_asked" IN (0, 1))',
        ),
        defaultValue: const Constant(false),
      );
  @override
  List<GeneratedColumn> get $columns => [id, notificationPermissionAsked];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notification_permission_asked';
  @override
  VerificationContext validateIntegrity(
    Insertable<NotificationPermissionAskedData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('notification_permission_asked')) {
      context.handle(
        _notificationPermissionAskedMeta,
        notificationPermissionAsked.isAcceptableOrUnknown(
          data['notification_permission_asked']!,
          _notificationPermissionAskedMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NotificationPermissionAskedData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NotificationPermissionAskedData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      notificationPermissionAsked: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}notification_permission_asked'],
      )!,
    );
  }

  @override
  $NotificationPermissionAskedTable createAlias(String alias) {
    return $NotificationPermissionAskedTable(attachedDatabase, alias);
  }
}

class NotificationPermissionAskedData extends DataClass
    implements Insertable<NotificationPermissionAskedData> {
  final int id;

  /// If true don't show notification permission asking dialog when
  /// app main view (bottom navigation is visible) is opened.
  final bool notificationPermissionAsked;
  const NotificationPermissionAskedData({
    required this.id,
    required this.notificationPermissionAsked,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['notification_permission_asked'] = Variable<bool>(
      notificationPermissionAsked,
    );
    return map;
  }

  NotificationPermissionAskedCompanion toCompanion(bool nullToAbsent) {
    return NotificationPermissionAskedCompanion(
      id: Value(id),
      notificationPermissionAsked: Value(notificationPermissionAsked),
    );
  }

  factory NotificationPermissionAskedData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NotificationPermissionAskedData(
      id: serializer.fromJson<int>(json['id']),
      notificationPermissionAsked: serializer.fromJson<bool>(
        json['notificationPermissionAsked'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'notificationPermissionAsked': serializer.toJson<bool>(
        notificationPermissionAsked,
      ),
    };
  }

  NotificationPermissionAskedData copyWith({
    int? id,
    bool? notificationPermissionAsked,
  }) => NotificationPermissionAskedData(
    id: id ?? this.id,
    notificationPermissionAsked:
        notificationPermissionAsked ?? this.notificationPermissionAsked,
  );
  NotificationPermissionAskedData copyWithCompanion(
    NotificationPermissionAskedCompanion data,
  ) {
    return NotificationPermissionAskedData(
      id: data.id.present ? data.id.value : this.id,
      notificationPermissionAsked: data.notificationPermissionAsked.present
          ? data.notificationPermissionAsked.value
          : this.notificationPermissionAsked,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NotificationPermissionAskedData(')
          ..write('id: $id, ')
          ..write('notificationPermissionAsked: $notificationPermissionAsked')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, notificationPermissionAsked);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NotificationPermissionAskedData &&
          other.id == this.id &&
          other.notificationPermissionAsked ==
              this.notificationPermissionAsked);
}

class NotificationPermissionAskedCompanion
    extends UpdateCompanion<NotificationPermissionAskedData> {
  final Value<int> id;
  final Value<bool> notificationPermissionAsked;
  const NotificationPermissionAskedCompanion({
    this.id = const Value.absent(),
    this.notificationPermissionAsked = const Value.absent(),
  });
  NotificationPermissionAskedCompanion.insert({
    this.id = const Value.absent(),
    this.notificationPermissionAsked = const Value.absent(),
  });
  static Insertable<NotificationPermissionAskedData> custom({
    Expression<int>? id,
    Expression<bool>? notificationPermissionAsked,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (notificationPermissionAsked != null)
        'notification_permission_asked': notificationPermissionAsked,
    });
  }

  NotificationPermissionAskedCompanion copyWith({
    Value<int>? id,
    Value<bool>? notificationPermissionAsked,
  }) {
    return NotificationPermissionAskedCompanion(
      id: id ?? this.id,
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
    if (notificationPermissionAsked.present) {
      map['notification_permission_asked'] = Variable<bool>(
        notificationPermissionAsked.value,
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotificationPermissionAskedCompanion(')
          ..write('id: $id, ')
          ..write('notificationPermissionAsked: $notificationPermissionAsked')
          ..write(')'))
        .toString();
  }
}

abstract class _$CommonForegroundDatabase extends GeneratedDatabase {
  _$CommonForegroundDatabase(QueryExecutor e) : super(e);
  late final $DemoAccountTable demoAccount = $DemoAccountTable(this);
  late final $ImageEncryptionKeyTable imageEncryptionKey =
      $ImageEncryptionKeyTable(this);
  late final $NotificationPermissionAskedTable notificationPermissionAsked =
      $NotificationPermissionAskedTable(this);
  late final DaoReadApp daoReadApp = DaoReadApp(
    this as CommonForegroundDatabase,
  );
  late final DaoReadDemoAccount daoReadDemoAccount = DaoReadDemoAccount(
    this as CommonForegroundDatabase,
  );
  late final DaoWriteApp daoWriteApp = DaoWriteApp(
    this as CommonForegroundDatabase,
  );
  late final DaoWriteDemoAccount daoWriteDemoAccount = DaoWriteDemoAccount(
    this as CommonForegroundDatabase,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    demoAccount,
    imageEncryptionKey,
    notificationPermissionAsked,
  ];
}
