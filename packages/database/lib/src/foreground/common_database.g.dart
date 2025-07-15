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
  static const VerificationMeta _demoAccountUserIdMeta = const VerificationMeta(
    'demoAccountUserId',
  );
  @override
  late final GeneratedColumn<String> demoAccountUserId =
      GeneratedColumn<String>(
        'demo_account_user_id',
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
        defaultValue: const Constant(NOTIFICATION_PERMISSION_ASKED_DEFAULT),
      );
  static const VerificationMeta _chatInfoDialogShownMeta =
      const VerificationMeta('chatInfoDialogShown');
  @override
  late final GeneratedColumn<bool> chatInfoDialogShown = GeneratedColumn<bool>(
    'chat_info_dialog_shown',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("chat_info_dialog_shown" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    demoAccountUserId,
    demoAccountPassword,
    demoAccountToken,
    imageEncryptionKey,
    notificationPermissionAsked,
    chatInfoDialogShown,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'common';
  @override
  VerificationContext validateIntegrity(
    Insertable<CommonData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('demo_account_user_id')) {
      context.handle(
        _demoAccountUserIdMeta,
        demoAccountUserId.isAcceptableOrUnknown(
          data['demo_account_user_id']!,
          _demoAccountUserIdMeta,
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
    if (data.containsKey('image_encryption_key')) {
      context.handle(
        _imageEncryptionKeyMeta,
        imageEncryptionKey.isAcceptableOrUnknown(
          data['image_encryption_key']!,
          _imageEncryptionKeyMeta,
        ),
      );
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
    if (data.containsKey('chat_info_dialog_shown')) {
      context.handle(
        _chatInfoDialogShownMeta,
        chatInfoDialogShown.isAcceptableOrUnknown(
          data['chat_info_dialog_shown']!,
          _chatInfoDialogShownMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CommonData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CommonData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      demoAccountUserId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}demo_account_user_id'],
      ),
      demoAccountPassword: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}demo_account_password'],
      ),
      demoAccountToken: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}demo_account_token'],
      ),
      imageEncryptionKey: attachedDatabase.typeMapping.read(
        DriftSqlType.blob,
        data['${effectivePrefix}image_encryption_key'],
      ),
      notificationPermissionAsked: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}notification_permission_asked'],
      )!,
      chatInfoDialogShown: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}chat_info_dialog_shown'],
      )!,
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
  final Uint8List? imageEncryptionKey;

  /// If true don't show notification permission asking dialog when
  /// app main view (bottom navigation is visible) is opened.
  final bool notificationPermissionAsked;

  /// If true info dialog about chat has been shown when
  /// chat list screen (bottom navigation is visible) is opened.
  final bool chatInfoDialogShown;
  const CommonData({
    required this.id,
    this.demoAccountUserId,
    this.demoAccountPassword,
    this.demoAccountToken,
    this.imageEncryptionKey,
    required this.notificationPermissionAsked,
    required this.chatInfoDialogShown,
  });
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
    if (!nullToAbsent || imageEncryptionKey != null) {
      map['image_encryption_key'] = Variable<Uint8List>(imageEncryptionKey);
    }
    map['notification_permission_asked'] = Variable<bool>(
      notificationPermissionAsked,
    );
    map['chat_info_dialog_shown'] = Variable<bool>(chatInfoDialogShown);
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
      imageEncryptionKey: imageEncryptionKey == null && nullToAbsent
          ? const Value.absent()
          : Value(imageEncryptionKey),
      notificationPermissionAsked: Value(notificationPermissionAsked),
      chatInfoDialogShown: Value(chatInfoDialogShown),
    );
  }

  factory CommonData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CommonData(
      id: serializer.fromJson<int>(json['id']),
      demoAccountUserId: serializer.fromJson<String?>(
        json['demoAccountUserId'],
      ),
      demoAccountPassword: serializer.fromJson<String?>(
        json['demoAccountPassword'],
      ),
      demoAccountToken: serializer.fromJson<String?>(json['demoAccountToken']),
      imageEncryptionKey: serializer.fromJson<Uint8List?>(
        json['imageEncryptionKey'],
      ),
      notificationPermissionAsked: serializer.fromJson<bool>(
        json['notificationPermissionAsked'],
      ),
      chatInfoDialogShown: serializer.fromJson<bool>(
        json['chatInfoDialogShown'],
      ),
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
      'imageEncryptionKey': serializer.toJson<Uint8List?>(imageEncryptionKey),
      'notificationPermissionAsked': serializer.toJson<bool>(
        notificationPermissionAsked,
      ),
      'chatInfoDialogShown': serializer.toJson<bool>(chatInfoDialogShown),
    };
  }

  CommonData copyWith({
    int? id,
    Value<String?> demoAccountUserId = const Value.absent(),
    Value<String?> demoAccountPassword = const Value.absent(),
    Value<String?> demoAccountToken = const Value.absent(),
    Value<Uint8List?> imageEncryptionKey = const Value.absent(),
    bool? notificationPermissionAsked,
    bool? chatInfoDialogShown,
  }) => CommonData(
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
    imageEncryptionKey: imageEncryptionKey.present
        ? imageEncryptionKey.value
        : this.imageEncryptionKey,
    notificationPermissionAsked:
        notificationPermissionAsked ?? this.notificationPermissionAsked,
    chatInfoDialogShown: chatInfoDialogShown ?? this.chatInfoDialogShown,
  );
  CommonData copyWithCompanion(CommonCompanion data) {
    return CommonData(
      id: data.id.present ? data.id.value : this.id,
      demoAccountUserId: data.demoAccountUserId.present
          ? data.demoAccountUserId.value
          : this.demoAccountUserId,
      demoAccountPassword: data.demoAccountPassword.present
          ? data.demoAccountPassword.value
          : this.demoAccountPassword,
      demoAccountToken: data.demoAccountToken.present
          ? data.demoAccountToken.value
          : this.demoAccountToken,
      imageEncryptionKey: data.imageEncryptionKey.present
          ? data.imageEncryptionKey.value
          : this.imageEncryptionKey,
      notificationPermissionAsked: data.notificationPermissionAsked.present
          ? data.notificationPermissionAsked.value
          : this.notificationPermissionAsked,
      chatInfoDialogShown: data.chatInfoDialogShown.present
          ? data.chatInfoDialogShown.value
          : this.chatInfoDialogShown,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CommonData(')
          ..write('id: $id, ')
          ..write('demoAccountUserId: $demoAccountUserId, ')
          ..write('demoAccountPassword: $demoAccountPassword, ')
          ..write('demoAccountToken: $demoAccountToken, ')
          ..write('imageEncryptionKey: $imageEncryptionKey, ')
          ..write('notificationPermissionAsked: $notificationPermissionAsked, ')
          ..write('chatInfoDialogShown: $chatInfoDialogShown')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    demoAccountUserId,
    demoAccountPassword,
    demoAccountToken,
    $driftBlobEquality.hash(imageEncryptionKey),
    notificationPermissionAsked,
    chatInfoDialogShown,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CommonData &&
          other.id == this.id &&
          other.demoAccountUserId == this.demoAccountUserId &&
          other.demoAccountPassword == this.demoAccountPassword &&
          other.demoAccountToken == this.demoAccountToken &&
          $driftBlobEquality.equals(
            other.imageEncryptionKey,
            this.imageEncryptionKey,
          ) &&
          other.notificationPermissionAsked ==
              this.notificationPermissionAsked &&
          other.chatInfoDialogShown == this.chatInfoDialogShown);
}

class CommonCompanion extends UpdateCompanion<CommonData> {
  final Value<int> id;
  final Value<String?> demoAccountUserId;
  final Value<String?> demoAccountPassword;
  final Value<String?> demoAccountToken;
  final Value<Uint8List?> imageEncryptionKey;
  final Value<bool> notificationPermissionAsked;
  final Value<bool> chatInfoDialogShown;
  const CommonCompanion({
    this.id = const Value.absent(),
    this.demoAccountUserId = const Value.absent(),
    this.demoAccountPassword = const Value.absent(),
    this.demoAccountToken = const Value.absent(),
    this.imageEncryptionKey = const Value.absent(),
    this.notificationPermissionAsked = const Value.absent(),
    this.chatInfoDialogShown = const Value.absent(),
  });
  CommonCompanion.insert({
    this.id = const Value.absent(),
    this.demoAccountUserId = const Value.absent(),
    this.demoAccountPassword = const Value.absent(),
    this.demoAccountToken = const Value.absent(),
    this.imageEncryptionKey = const Value.absent(),
    this.notificationPermissionAsked = const Value.absent(),
    this.chatInfoDialogShown = const Value.absent(),
  });
  static Insertable<CommonData> custom({
    Expression<int>? id,
    Expression<String>? demoAccountUserId,
    Expression<String>? demoAccountPassword,
    Expression<String>? demoAccountToken,
    Expression<Uint8List>? imageEncryptionKey,
    Expression<bool>? notificationPermissionAsked,
    Expression<bool>? chatInfoDialogShown,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (demoAccountUserId != null) 'demo_account_user_id': demoAccountUserId,
      if (demoAccountPassword != null)
        'demo_account_password': demoAccountPassword,
      if (demoAccountToken != null) 'demo_account_token': demoAccountToken,
      if (imageEncryptionKey != null)
        'image_encryption_key': imageEncryptionKey,
      if (notificationPermissionAsked != null)
        'notification_permission_asked': notificationPermissionAsked,
      if (chatInfoDialogShown != null)
        'chat_info_dialog_shown': chatInfoDialogShown,
    });
  }

  CommonCompanion copyWith({
    Value<int>? id,
    Value<String?>? demoAccountUserId,
    Value<String?>? demoAccountPassword,
    Value<String?>? demoAccountToken,
    Value<Uint8List?>? imageEncryptionKey,
    Value<bool>? notificationPermissionAsked,
    Value<bool>? chatInfoDialogShown,
  }) {
    return CommonCompanion(
      id: id ?? this.id,
      demoAccountUserId: demoAccountUserId ?? this.demoAccountUserId,
      demoAccountPassword: demoAccountPassword ?? this.demoAccountPassword,
      demoAccountToken: demoAccountToken ?? this.demoAccountToken,
      imageEncryptionKey: imageEncryptionKey ?? this.imageEncryptionKey,
      notificationPermissionAsked:
          notificationPermissionAsked ?? this.notificationPermissionAsked,
      chatInfoDialogShown: chatInfoDialogShown ?? this.chatInfoDialogShown,
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
      map['demo_account_password'] = Variable<String>(
        demoAccountPassword.value,
      );
    }
    if (demoAccountToken.present) {
      map['demo_account_token'] = Variable<String>(demoAccountToken.value);
    }
    if (imageEncryptionKey.present) {
      map['image_encryption_key'] = Variable<Uint8List>(
        imageEncryptionKey.value,
      );
    }
    if (notificationPermissionAsked.present) {
      map['notification_permission_asked'] = Variable<bool>(
        notificationPermissionAsked.value,
      );
    }
    if (chatInfoDialogShown.present) {
      map['chat_info_dialog_shown'] = Variable<bool>(chatInfoDialogShown.value);
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
          ..write('imageEncryptionKey: $imageEncryptionKey, ')
          ..write('notificationPermissionAsked: $notificationPermissionAsked, ')
          ..write('chatInfoDialogShown: $chatInfoDialogShown')
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
