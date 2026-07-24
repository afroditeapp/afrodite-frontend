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
  static const VerificationMeta _lastAccessedMeta = const VerificationMeta(
    'lastAccessed',
  );
  @override
  late final GeneratedColumn<DateTime> lastAccessed = GeneratedColumn<DateTime>(
    'last_accessed',
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
    lastAccessed,
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
    if (data.containsKey('last_accessed')) {
      context.handle(
        _lastAccessedMeta,
        lastAccessed.isAcceptableOrUnknown(
          data['last_accessed']!,
          _lastAccessedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastAccessedMeta);
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
      lastAccessed: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_accessed'],
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

  /// Last accessed timestamp
  final DateTime lastAccessed;
  const CacheEntryData({
    required this.id,
    required this.entryKey,
    required this.savedSuccessfully,
    required this.lastAccessed,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['entry_key'] = Variable<String>(entryKey);
    map['saved_successfully'] = Variable<bool>(savedSuccessfully);
    map['last_accessed'] = Variable<DateTime>(lastAccessed);
    return map;
  }

  CacheEntryCompanion toCompanion(bool nullToAbsent) {
    return CacheEntryCompanion(
      id: Value(id),
      entryKey: Value(entryKey),
      savedSuccessfully: Value(savedSuccessfully),
      lastAccessed: Value(lastAccessed),
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
      lastAccessed: serializer.fromJson<DateTime>(json['lastAccessed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'entryKey': serializer.toJson<String>(entryKey),
      'savedSuccessfully': serializer.toJson<bool>(savedSuccessfully),
      'lastAccessed': serializer.toJson<DateTime>(lastAccessed),
    };
  }

  CacheEntryData copyWith({
    int? id,
    String? entryKey,
    bool? savedSuccessfully,
    DateTime? lastAccessed,
  }) => CacheEntryData(
    id: id ?? this.id,
    entryKey: entryKey ?? this.entryKey,
    savedSuccessfully: savedSuccessfully ?? this.savedSuccessfully,
    lastAccessed: lastAccessed ?? this.lastAccessed,
  );
  CacheEntryData copyWithCompanion(CacheEntryCompanion data) {
    return CacheEntryData(
      id: data.id.present ? data.id.value : this.id,
      entryKey: data.entryKey.present ? data.entryKey.value : this.entryKey,
      savedSuccessfully: data.savedSuccessfully.present
          ? data.savedSuccessfully.value
          : this.savedSuccessfully,
      lastAccessed: data.lastAccessed.present
          ? data.lastAccessed.value
          : this.lastAccessed,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CacheEntryData(')
          ..write('id: $id, ')
          ..write('entryKey: $entryKey, ')
          ..write('savedSuccessfully: $savedSuccessfully, ')
          ..write('lastAccessed: $lastAccessed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, entryKey, savedSuccessfully, lastAccessed);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CacheEntryData &&
          other.id == this.id &&
          other.entryKey == this.entryKey &&
          other.savedSuccessfully == this.savedSuccessfully &&
          other.lastAccessed == this.lastAccessed);
}

class CacheEntryCompanion extends UpdateCompanion<CacheEntryData> {
  final Value<int> id;
  final Value<String> entryKey;
  final Value<bool> savedSuccessfully;
  final Value<DateTime> lastAccessed;
  const CacheEntryCompanion({
    this.id = const Value.absent(),
    this.entryKey = const Value.absent(),
    this.savedSuccessfully = const Value.absent(),
    this.lastAccessed = const Value.absent(),
  });
  CacheEntryCompanion.insert({
    this.id = const Value.absent(),
    required String entryKey,
    this.savedSuccessfully = const Value.absent(),
    required DateTime lastAccessed,
  }) : entryKey = Value(entryKey),
       lastAccessed = Value(lastAccessed);
  static Insertable<CacheEntryData> custom({
    Expression<int>? id,
    Expression<String>? entryKey,
    Expression<bool>? savedSuccessfully,
    Expression<DateTime>? lastAccessed,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (entryKey != null) 'entry_key': entryKey,
      if (savedSuccessfully != null) 'saved_successfully': savedSuccessfully,
      if (lastAccessed != null) 'last_accessed': lastAccessed,
    });
  }

  CacheEntryCompanion copyWith({
    Value<int>? id,
    Value<String>? entryKey,
    Value<bool>? savedSuccessfully,
    Value<DateTime>? lastAccessed,
  }) {
    return CacheEntryCompanion(
      id: id ?? this.id,
      entryKey: entryKey ?? this.entryKey,
      savedSuccessfully: savedSuccessfully ?? this.savedSuccessfully,
      lastAccessed: lastAccessed ?? this.lastAccessed,
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
    if (lastAccessed.present) {
      map['last_accessed'] = Variable<DateTime>(lastAccessed.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CacheEntryCompanion(')
          ..write('id: $id, ')
          ..write('entryKey: $entryKey, ')
          ..write('savedSuccessfully: $savedSuccessfully, ')
          ..write('lastAccessed: $lastAccessed')
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
