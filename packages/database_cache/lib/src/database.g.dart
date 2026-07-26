// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $CacheEntryTable extends schema.CacheEntry
    with TableInfo<$CacheEntryTable, CacheEntryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CacheEntryTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _entryKeyMeta = const VerificationMeta(
    'entryKey',
  );
  @override
  late final GeneratedColumn<String> entryKey = GeneratedColumn<String>(
    'entry_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _savedSuccessfullyMeta = const VerificationMeta(
    'savedSuccessfully',
  );
  @override
  late final GeneratedColumn<bool> savedSuccessfully = GeneratedColumn<bool>(
    'saved_successfully',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("saved_successfully" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _etagMeta = const VerificationMeta('etag');
  @override
  late final GeneratedColumn<String> etag = GeneratedColumn<String>(
    'etag',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _staleAtMeta = const VerificationMeta(
    'staleAt',
  );
  @override
  late final GeneratedColumn<DateTime> staleAt = GeneratedColumn<DateTime>(
    'stale_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _expireAtMeta = const VerificationMeta(
    'expireAt',
  );
  @override
  late final GeneratedColumn<DateTime> expireAt = GeneratedColumn<DateTime>(
    'expire_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    entryKey,
    savedSuccessfully,
    etag,
    staleAt,
    expireAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cache_entry';
  @override
  VerificationContext validateIntegrity(
    Insertable<CacheEntryData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('entry_key')) {
      context.handle(
        _entryKeyMeta,
        entryKey.isAcceptableOrUnknown(data['entry_key']!, _entryKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_entryKeyMeta);
    }
    if (data.containsKey('saved_successfully')) {
      context.handle(
        _savedSuccessfullyMeta,
        savedSuccessfully.isAcceptableOrUnknown(
          data['saved_successfully']!,
          _savedSuccessfullyMeta,
        ),
      );
    }
    if (data.containsKey('etag')) {
      context.handle(
        _etagMeta,
        etag.isAcceptableOrUnknown(data['etag']!, _etagMeta),
      );
    }
    if (data.containsKey('stale_at')) {
      context.handle(
        _staleAtMeta,
        staleAt.isAcceptableOrUnknown(data['stale_at']!, _staleAtMeta),
      );
    } else if (isInserting) {
      context.missing(_staleAtMeta);
    }
    if (data.containsKey('expire_at')) {
      context.handle(
        _expireAtMeta,
        expireAt.isAcceptableOrUnknown(data['expire_at']!, _expireAtMeta),
      );
    } else if (isInserting) {
      context.missing(_expireAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CacheEntryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CacheEntryData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      entryKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entry_key'],
      )!,
      savedSuccessfully: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}saved_successfully'],
      )!,
      etag: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}etag'],
      ),
      staleAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}stale_at'],
      )!,
      expireAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}expire_at'],
      )!,
    );
  }

  @override
  $CacheEntryTable createAlias(String alias) {
    return $CacheEntryTable(attachedDatabase, alias);
  }
}

class CacheEntryData extends DataClass implements Insertable<CacheEntryData> {
  final int id;

  /// Unique entry key within the cache
  final String entryKey;

  /// Whether the file was saved successfully to disk
  final bool savedSuccessfully;

  /// Server ETag for conditional requests
  final String? etag;

  /// When this entry becomes stale and should be revalidated
  final DateTime staleAt;

  /// When this entry should be deleted unconditionally
  final DateTime expireAt;
  const CacheEntryData({
    required this.id,
    required this.entryKey,
    required this.savedSuccessfully,
    this.etag,
    required this.staleAt,
    required this.expireAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['entry_key'] = Variable<String>(entryKey);
    map['saved_successfully'] = Variable<bool>(savedSuccessfully);
    if (!nullToAbsent || etag != null) {
      map['etag'] = Variable<String>(etag);
    }
    map['stale_at'] = Variable<DateTime>(staleAt);
    map['expire_at'] = Variable<DateTime>(expireAt);
    return map;
  }

  CacheEntryCompanion toCompanion(bool nullToAbsent) {
    return CacheEntryCompanion(
      id: Value(id),
      entryKey: Value(entryKey),
      savedSuccessfully: Value(savedSuccessfully),
      etag: etag == null && nullToAbsent ? const Value.absent() : Value(etag),
      staleAt: Value(staleAt),
      expireAt: Value(expireAt),
    );
  }

  factory CacheEntryData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CacheEntryData(
      id: serializer.fromJson<int>(json['id']),
      entryKey: serializer.fromJson<String>(json['entryKey']),
      savedSuccessfully: serializer.fromJson<bool>(json['savedSuccessfully']),
      etag: serializer.fromJson<String?>(json['etag']),
      staleAt: serializer.fromJson<DateTime>(json['staleAt']),
      expireAt: serializer.fromJson<DateTime>(json['expireAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'entryKey': serializer.toJson<String>(entryKey),
      'savedSuccessfully': serializer.toJson<bool>(savedSuccessfully),
      'etag': serializer.toJson<String?>(etag),
      'staleAt': serializer.toJson<DateTime>(staleAt),
      'expireAt': serializer.toJson<DateTime>(expireAt),
    };
  }

  CacheEntryData copyWith({
    int? id,
    String? entryKey,
    bool? savedSuccessfully,
    Value<String?> etag = const Value.absent(),
    DateTime? staleAt,
    DateTime? expireAt,
  }) => CacheEntryData(
    id: id ?? this.id,
    entryKey: entryKey ?? this.entryKey,
    savedSuccessfully: savedSuccessfully ?? this.savedSuccessfully,
    etag: etag.present ? etag.value : this.etag,
    staleAt: staleAt ?? this.staleAt,
    expireAt: expireAt ?? this.expireAt,
  );
  CacheEntryData copyWithCompanion(CacheEntryCompanion data) {
    return CacheEntryData(
      id: data.id.present ? data.id.value : this.id,
      entryKey: data.entryKey.present ? data.entryKey.value : this.entryKey,
      savedSuccessfully: data.savedSuccessfully.present
          ? data.savedSuccessfully.value
          : this.savedSuccessfully,
      etag: data.etag.present ? data.etag.value : this.etag,
      staleAt: data.staleAt.present ? data.staleAt.value : this.staleAt,
      expireAt: data.expireAt.present ? data.expireAt.value : this.expireAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CacheEntryData(')
          ..write('id: $id, ')
          ..write('entryKey: $entryKey, ')
          ..write('savedSuccessfully: $savedSuccessfully, ')
          ..write('etag: $etag, ')
          ..write('staleAt: $staleAt, ')
          ..write('expireAt: $expireAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, entryKey, savedSuccessfully, etag, staleAt, expireAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CacheEntryData &&
          other.id == this.id &&
          other.entryKey == this.entryKey &&
          other.savedSuccessfully == this.savedSuccessfully &&
          other.etag == this.etag &&
          other.staleAt == this.staleAt &&
          other.expireAt == this.expireAt);
}

class CacheEntryCompanion extends UpdateCompanion<CacheEntryData> {
  final Value<int> id;
  final Value<String> entryKey;
  final Value<bool> savedSuccessfully;
  final Value<String?> etag;
  final Value<DateTime> staleAt;
  final Value<DateTime> expireAt;
  const CacheEntryCompanion({
    this.id = const Value.absent(),
    this.entryKey = const Value.absent(),
    this.savedSuccessfully = const Value.absent(),
    this.etag = const Value.absent(),
    this.staleAt = const Value.absent(),
    this.expireAt = const Value.absent(),
  });
  CacheEntryCompanion.insert({
    this.id = const Value.absent(),
    required String entryKey,
    this.savedSuccessfully = const Value.absent(),
    this.etag = const Value.absent(),
    required DateTime staleAt,
    required DateTime expireAt,
  }) : entryKey = Value(entryKey),
       staleAt = Value(staleAt),
       expireAt = Value(expireAt);
  static Insertable<CacheEntryData> custom({
    Expression<int>? id,
    Expression<String>? entryKey,
    Expression<bool>? savedSuccessfully,
    Expression<String>? etag,
    Expression<DateTime>? staleAt,
    Expression<DateTime>? expireAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (entryKey != null) 'entry_key': entryKey,
      if (savedSuccessfully != null) 'saved_successfully': savedSuccessfully,
      if (etag != null) 'etag': etag,
      if (staleAt != null) 'stale_at': staleAt,
      if (expireAt != null) 'expire_at': expireAt,
    });
  }

  CacheEntryCompanion copyWith({
    Value<int>? id,
    Value<String>? entryKey,
    Value<bool>? savedSuccessfully,
    Value<String?>? etag,
    Value<DateTime>? staleAt,
    Value<DateTime>? expireAt,
  }) {
    return CacheEntryCompanion(
      id: id ?? this.id,
      entryKey: entryKey ?? this.entryKey,
      savedSuccessfully: savedSuccessfully ?? this.savedSuccessfully,
      etag: etag ?? this.etag,
      staleAt: staleAt ?? this.staleAt,
      expireAt: expireAt ?? this.expireAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (entryKey.present) {
      map['entry_key'] = Variable<String>(entryKey.value);
    }
    if (savedSuccessfully.present) {
      map['saved_successfully'] = Variable<bool>(savedSuccessfully.value);
    }
    if (etag.present) {
      map['etag'] = Variable<String>(etag.value);
    }
    if (staleAt.present) {
      map['stale_at'] = Variable<DateTime>(staleAt.value);
    }
    if (expireAt.present) {
      map['expire_at'] = Variable<DateTime>(expireAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CacheEntryCompanion(')
          ..write('id: $id, ')
          ..write('entryKey: $entryKey, ')
          ..write('savedSuccessfully: $savedSuccessfully, ')
          ..write('etag: $etag, ')
          ..write('staleAt: $staleAt, ')
          ..write('expireAt: $expireAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$CacheDatabase extends GeneratedDatabase {
  _$CacheDatabase(QueryExecutor e) : super(e);
  late final $CacheEntryTable cacheEntry = $CacheEntryTable(this);
  late final DaoReadCacheEntry daoReadCacheEntry = DaoReadCacheEntry(
    this as CacheDatabase,
  );
  late final DaoWriteCacheEntry daoWriteCacheEntry = DaoWriteCacheEntry(
    this as CacheDatabase,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [cacheEntry];
}
