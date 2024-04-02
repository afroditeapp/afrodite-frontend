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
  @override
  List<GeneratedColumn> get $columns =>
      [id, demoAccountUserId, demoAccountPassword, demoAccountToken];
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
  const CommonData(
      {required this.id,
      this.demoAccountUserId,
      this.demoAccountPassword,
      this.demoAccountToken});
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
    };
  }

  CommonData copyWith(
          {int? id,
          Value<String?> demoAccountUserId = const Value.absent(),
          Value<String?> demoAccountPassword = const Value.absent(),
          Value<String?> demoAccountToken = const Value.absent()}) =>
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
      );
  @override
  String toString() {
    return (StringBuffer('CommonData(')
          ..write('id: $id, ')
          ..write('demoAccountUserId: $demoAccountUserId, ')
          ..write('demoAccountPassword: $demoAccountPassword, ')
          ..write('demoAccountToken: $demoAccountToken')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, demoAccountUserId, demoAccountPassword, demoAccountToken);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CommonData &&
          other.id == this.id &&
          other.demoAccountUserId == this.demoAccountUserId &&
          other.demoAccountPassword == this.demoAccountPassword &&
          other.demoAccountToken == this.demoAccountToken);
}

class CommonCompanion extends UpdateCompanion<CommonData> {
  final Value<int> id;
  final Value<String?> demoAccountUserId;
  final Value<String?> demoAccountPassword;
  final Value<String?> demoAccountToken;
  const CommonCompanion({
    this.id = const Value.absent(),
    this.demoAccountUserId = const Value.absent(),
    this.demoAccountPassword = const Value.absent(),
    this.demoAccountToken = const Value.absent(),
  });
  CommonCompanion.insert({
    this.id = const Value.absent(),
    this.demoAccountUserId = const Value.absent(),
    this.demoAccountPassword = const Value.absent(),
    this.demoAccountToken = const Value.absent(),
  });
  static Insertable<CommonData> custom({
    Expression<int>? id,
    Expression<String>? demoAccountUserId,
    Expression<String>? demoAccountPassword,
    Expression<String>? demoAccountToken,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (demoAccountUserId != null) 'demo_account_user_id': demoAccountUserId,
      if (demoAccountPassword != null)
        'demo_account_password': demoAccountPassword,
      if (demoAccountToken != null) 'demo_account_token': demoAccountToken,
    });
  }

  CommonCompanion copyWith(
      {Value<int>? id,
      Value<String?>? demoAccountUserId,
      Value<String?>? demoAccountPassword,
      Value<String?>? demoAccountToken}) {
    return CommonCompanion(
      id: id ?? this.id,
      demoAccountUserId: demoAccountUserId ?? this.demoAccountUserId,
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CommonCompanion(')
          ..write('id: $id, ')
          ..write('demoAccountUserId: $demoAccountUserId, ')
          ..write('demoAccountPassword: $demoAccountPassword, ')
          ..write('demoAccountToken: $demoAccountToken')
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
