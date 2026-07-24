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

class $ContentQualityTable extends schema.ContentQuality
    with TableInfo<$ContentQualityTable, ContentQualityData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ContentQualityTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
    'account_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentIdMeta = const VerificationMeta(
    'contentId',
  );
  @override
  late final GeneratedColumn<String> contentId = GeneratedColumn<String>(
    'content_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _qualityMeta = const VerificationMeta(
    'quality',
  );
  @override
  late final GeneratedColumn<String> quality = GeneratedColumn<String>(
    'quality',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<UtcDateTime, int>
  lastRequestTime = GeneratedColumn<int>(
    'last_request_time',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  ).withConverter<UtcDateTime>($ContentQualityTable.$converterlastRequestTime);
  @override
  List<GeneratedColumn> get $columns => [
    accountId,
    contentId,
    quality,
    lastRequestTime,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'content_quality';
  @override
  VerificationContext validateIntegrity(
    Insertable<ContentQualityData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('content_id')) {
      context.handle(
        _contentIdMeta,
        contentId.isAcceptableOrUnknown(data['content_id']!, _contentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_contentIdMeta);
    }
    if (data.containsKey('quality')) {
      context.handle(
        _qualityMeta,
        quality.isAcceptableOrUnknown(data['quality']!, _qualityMeta),
      );
    } else if (isInserting) {
      context.missing(_qualityMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {accountId, contentId};
  @override
  ContentQualityData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ContentQualityData(
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_id'],
      )!,
      contentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_id'],
      )!,
      quality: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}quality'],
      )!,
      lastRequestTime: $ContentQualityTable.$converterlastRequestTime.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}last_request_time'],
        )!,
      ),
    );
  }

  @override
  $ContentQualityTable createAlias(String alias) {
    return $ContentQualityTable(attachedDatabase, alias);
  }

  static TypeConverter<UtcDateTime, int> $converterlastRequestTime =
      const UtcDateTimeConverter();
}

class ContentQualityData extends DataClass
    implements Insertable<ContentQualityData> {
  final String accountId;
  final String contentId;

  /// Quality returned by server: "h", "m", or "l"
  final String quality;

  /// Timestamp when the request was made
  final UtcDateTime lastRequestTime;
  const ContentQualityData({
    required this.accountId,
    required this.contentId,
    required this.quality,
    required this.lastRequestTime,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['account_id'] = Variable<String>(accountId);
    map['content_id'] = Variable<String>(contentId);
    map['quality'] = Variable<String>(quality);
    {
      map['last_request_time'] = Variable<int>(
        $ContentQualityTable.$converterlastRequestTime.toSql(lastRequestTime),
      );
    }
    return map;
  }

  ContentQualityCompanion toCompanion(bool nullToAbsent) {
    return ContentQualityCompanion(
      accountId: Value(accountId),
      contentId: Value(contentId),
      quality: Value(quality),
      lastRequestTime: Value(lastRequestTime),
    );
  }

  factory ContentQualityData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ContentQualityData(
      accountId: serializer.fromJson<String>(json['accountId']),
      contentId: serializer.fromJson<String>(json['contentId']),
      quality: serializer.fromJson<String>(json['quality']),
      lastRequestTime: serializer.fromJson<UtcDateTime>(
        json['lastRequestTime'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'accountId': serializer.toJson<String>(accountId),
      'contentId': serializer.toJson<String>(contentId),
      'quality': serializer.toJson<String>(quality),
      'lastRequestTime': serializer.toJson<UtcDateTime>(lastRequestTime),
    };
  }

  ContentQualityData copyWith({
    String? accountId,
    String? contentId,
    String? quality,
    UtcDateTime? lastRequestTime,
  }) => ContentQualityData(
    accountId: accountId ?? this.accountId,
    contentId: contentId ?? this.contentId,
    quality: quality ?? this.quality,
    lastRequestTime: lastRequestTime ?? this.lastRequestTime,
  );
  ContentQualityData copyWithCompanion(ContentQualityCompanion data) {
    return ContentQualityData(
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      contentId: data.contentId.present ? data.contentId.value : this.contentId,
      quality: data.quality.present ? data.quality.value : this.quality,
      lastRequestTime: data.lastRequestTime.present
          ? data.lastRequestTime.value
          : this.lastRequestTime,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ContentQualityData(')
          ..write('accountId: $accountId, ')
          ..write('contentId: $contentId, ')
          ..write('quality: $quality, ')
          ..write('lastRequestTime: $lastRequestTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(accountId, contentId, quality, lastRequestTime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ContentQualityData &&
          other.accountId == this.accountId &&
          other.contentId == this.contentId &&
          other.quality == this.quality &&
          other.lastRequestTime == this.lastRequestTime);
}

class ContentQualityCompanion extends UpdateCompanion<ContentQualityData> {
  final Value<String> accountId;
  final Value<String> contentId;
  final Value<String> quality;
  final Value<UtcDateTime> lastRequestTime;
  final Value<int> rowid;
  const ContentQualityCompanion({
    this.accountId = const Value.absent(),
    this.contentId = const Value.absent(),
    this.quality = const Value.absent(),
    this.lastRequestTime = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ContentQualityCompanion.insert({
    required String accountId,
    required String contentId,
    required String quality,
    required UtcDateTime lastRequestTime,
    this.rowid = const Value.absent(),
  }) : accountId = Value(accountId),
       contentId = Value(contentId),
       quality = Value(quality),
       lastRequestTime = Value(lastRequestTime);
  static Insertable<ContentQualityData> custom({
    Expression<String>? accountId,
    Expression<String>? contentId,
    Expression<String>? quality,
    Expression<int>? lastRequestTime,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (accountId != null) 'account_id': accountId,
      if (contentId != null) 'content_id': contentId,
      if (quality != null) 'quality': quality,
      if (lastRequestTime != null) 'last_request_time': lastRequestTime,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ContentQualityCompanion copyWith({
    Value<String>? accountId,
    Value<String>? contentId,
    Value<String>? quality,
    Value<UtcDateTime>? lastRequestTime,
    Value<int>? rowid,
  }) {
    return ContentQualityCompanion(
      accountId: accountId ?? this.accountId,
      contentId: contentId ?? this.contentId,
      quality: quality ?? this.quality,
      lastRequestTime: lastRequestTime ?? this.lastRequestTime,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (contentId.present) {
      map['content_id'] = Variable<String>(contentId.value);
    }
    if (quality.present) {
      map['quality'] = Variable<String>(quality.value);
    }
    if (lastRequestTime.present) {
      map['last_request_time'] = Variable<int>(
        $ContentQualityTable.$converterlastRequestTime.toSql(
          lastRequestTime.value,
        ),
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContentQualityCompanion(')
          ..write('accountId: $accountId, ')
          ..write('contentId: $contentId, ')
          ..write('quality: $quality, ')
          ..write('lastRequestTime: $lastRequestTime, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ContentQualityCleanupStateTable extends schema.ContentQualityCleanupState
    with
        TableInfo<
          $ContentQualityCleanupStateTable,
          ContentQualityCleanupStateData
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ContentQualityCleanupStateTable(this.attachedDatabase, [this._alias]);
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
  late final GeneratedColumnWithTypeConverter<UtcDateTime?, int>
  lastCleanupTime =
      GeneratedColumn<int>(
        'last_cleanup_time',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      ).withConverter<UtcDateTime?>(
        $ContentQualityCleanupStateTable.$converterlastCleanupTime,
      );
  @override
  List<GeneratedColumn> get $columns => [id, lastCleanupTime];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'content_quality_cleanup_state';
  @override
  VerificationContext validateIntegrity(
    Insertable<ContentQualityCleanupStateData> instance, {
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
  ContentQualityCleanupStateData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ContentQualityCleanupStateData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      lastCleanupTime: $ContentQualityCleanupStateTable
          .$converterlastCleanupTime
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.int,
              data['${effectivePrefix}last_cleanup_time'],
            ),
          ),
    );
  }

  @override
  $ContentQualityCleanupStateTable createAlias(String alias) {
    return $ContentQualityCleanupStateTable(attachedDatabase, alias);
  }

  static TypeConverter<UtcDateTime?, int?> $converterlastCleanupTime =
      NullAwareTypeConverter.wrap(const UtcDateTimeConverter());
}

class ContentQualityCleanupStateData extends DataClass
    implements Insertable<ContentQualityCleanupStateData> {
  final int id;
  final UtcDateTime? lastCleanupTime;
  const ContentQualityCleanupStateData({
    required this.id,
    this.lastCleanupTime,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || lastCleanupTime != null) {
      map['last_cleanup_time'] = Variable<int>(
        $ContentQualityCleanupStateTable.$converterlastCleanupTime.toSql(
          lastCleanupTime,
        ),
      );
    }
    return map;
  }

  ContentQualityCleanupStateCompanion toCompanion(bool nullToAbsent) {
    return ContentQualityCleanupStateCompanion(
      id: Value(id),
      lastCleanupTime: lastCleanupTime == null && nullToAbsent
          ? const Value.absent()
          : Value(lastCleanupTime),
    );
  }

  factory ContentQualityCleanupStateData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ContentQualityCleanupStateData(
      id: serializer.fromJson<int>(json['id']),
      lastCleanupTime: serializer.fromJson<UtcDateTime?>(
        json['lastCleanupTime'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'lastCleanupTime': serializer.toJson<UtcDateTime?>(lastCleanupTime),
    };
  }

  ContentQualityCleanupStateData copyWith({
    int? id,
    Value<UtcDateTime?> lastCleanupTime = const Value.absent(),
  }) => ContentQualityCleanupStateData(
    id: id ?? this.id,
    lastCleanupTime: lastCleanupTime.present
        ? lastCleanupTime.value
        : this.lastCleanupTime,
  );
  ContentQualityCleanupStateData copyWithCompanion(
    ContentQualityCleanupStateCompanion data,
  ) {
    return ContentQualityCleanupStateData(
      id: data.id.present ? data.id.value : this.id,
      lastCleanupTime: data.lastCleanupTime.present
          ? data.lastCleanupTime.value
          : this.lastCleanupTime,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ContentQualityCleanupStateData(')
          ..write('id: $id, ')
          ..write('lastCleanupTime: $lastCleanupTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, lastCleanupTime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ContentQualityCleanupStateData &&
          other.id == this.id &&
          other.lastCleanupTime == this.lastCleanupTime);
}

class ContentQualityCleanupStateCompanion
    extends UpdateCompanion<ContentQualityCleanupStateData> {
  final Value<int> id;
  final Value<UtcDateTime?> lastCleanupTime;
  const ContentQualityCleanupStateCompanion({
    this.id = const Value.absent(),
    this.lastCleanupTime = const Value.absent(),
  });
  ContentQualityCleanupStateCompanion.insert({
    this.id = const Value.absent(),
    this.lastCleanupTime = const Value.absent(),
  });
  static Insertable<ContentQualityCleanupStateData> custom({
    Expression<int>? id,
    Expression<int>? lastCleanupTime,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (lastCleanupTime != null) 'last_cleanup_time': lastCleanupTime,
    });
  }

  ContentQualityCleanupStateCompanion copyWith({
    Value<int>? id,
    Value<UtcDateTime?>? lastCleanupTime,
  }) {
    return ContentQualityCleanupStateCompanion(
      id: id ?? this.id,
      lastCleanupTime: lastCleanupTime ?? this.lastCleanupTime,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (lastCleanupTime.present) {
      map['last_cleanup_time'] = Variable<int>(
        $ContentQualityCleanupStateTable.$converterlastCleanupTime.toSql(
          lastCleanupTime.value,
        ),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContentQualityCleanupStateCompanion(')
          ..write('id: $id, ')
          ..write('lastCleanupTime: $lastCleanupTime')
          ..write(')'))
        .toString();
  }
}

abstract class _$CacheDatabase extends GeneratedDatabase {
  _$CacheDatabase(QueryExecutor e) : super(e);
  late final $CacheEntryTable cacheEntry = $CacheEntryTable(this);
  late final $ContentQualityTable contentQuality = $ContentQualityTable(this);
  late final $ContentQualityCleanupStateTable contentQualityCleanupState =
      $ContentQualityCleanupStateTable(this);
  late final DaoReadCacheEntry daoReadCacheEntry = DaoReadCacheEntry(
    this as CacheDatabase,
  );
  late final DaoReadContentQuality daoReadContentQuality =
      DaoReadContentQuality(this as CacheDatabase);
  late final DaoWriteCacheEntry daoWriteCacheEntry = DaoWriteCacheEntry(
    this as CacheDatabase,
  );
  late final DaoWriteContentQuality daoWriteContentQuality =
      DaoWriteContentQuality(this as CacheDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    cacheEntry,
    contentQuality,
    contentQualityCleanupState,
  ];
}
