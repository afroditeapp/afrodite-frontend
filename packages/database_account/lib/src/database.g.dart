// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ProfileFilterFavoritesTable extends schema.ProfileFilterFavorites
    with TableInfo<$ProfileFilterFavoritesTable, ProfileFilterFavorite> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProfileFilterFavoritesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _profileFilterFavoritesMeta =
      const VerificationMeta('profileFilterFavorites');
  @override
  late final GeneratedColumn<bool> profileFilterFavorites =
      GeneratedColumn<bool>(
        'profile_filter_favorites',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("profile_filter_favorites" IN (0, 1))',
        ),
        defaultValue: const Constant(false),
      );
  @override
  List<GeneratedColumn> get $columns => [id, profileFilterFavorites];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'profile_filter_favorites';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProfileFilterFavorite> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('profile_filter_favorites')) {
      context.handle(
        _profileFilterFavoritesMeta,
        profileFilterFavorites.isAcceptableOrUnknown(
          data['profile_filter_favorites']!,
          _profileFilterFavoritesMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProfileFilterFavorite map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProfileFilterFavorite(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      profileFilterFavorites: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}profile_filter_favorites'],
      )!,
    );
  }

  @override
  $ProfileFilterFavoritesTable createAlias(String alias) {
    return $ProfileFilterFavoritesTable(attachedDatabase, alias);
  }
}

class ProfileFilterFavorite extends DataClass
    implements Insertable<ProfileFilterFavorite> {
  final int id;

  /// If true show only favorite profiles
  final bool profileFilterFavorites;
  const ProfileFilterFavorite({
    required this.id,
    required this.profileFilterFavorites,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['profile_filter_favorites'] = Variable<bool>(profileFilterFavorites);
    return map;
  }

  ProfileFilterFavoritesCompanion toCompanion(bool nullToAbsent) {
    return ProfileFilterFavoritesCompanion(
      id: Value(id),
      profileFilterFavorites: Value(profileFilterFavorites),
    );
  }

  factory ProfileFilterFavorite.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProfileFilterFavorite(
      id: serializer.fromJson<int>(json['id']),
      profileFilterFavorites: serializer.fromJson<bool>(
        json['profileFilterFavorites'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'profileFilterFavorites': serializer.toJson<bool>(profileFilterFavorites),
    };
  }

  ProfileFilterFavorite copyWith({int? id, bool? profileFilterFavorites}) =>
      ProfileFilterFavorite(
        id: id ?? this.id,
        profileFilterFavorites:
            profileFilterFavorites ?? this.profileFilterFavorites,
      );
  ProfileFilterFavorite copyWithCompanion(
    ProfileFilterFavoritesCompanion data,
  ) {
    return ProfileFilterFavorite(
      id: data.id.present ? data.id.value : this.id,
      profileFilterFavorites: data.profileFilterFavorites.present
          ? data.profileFilterFavorites.value
          : this.profileFilterFavorites,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProfileFilterFavorite(')
          ..write('id: $id, ')
          ..write('profileFilterFavorites: $profileFilterFavorites')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, profileFilterFavorites);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProfileFilterFavorite &&
          other.id == this.id &&
          other.profileFilterFavorites == this.profileFilterFavorites);
}

class ProfileFilterFavoritesCompanion
    extends UpdateCompanion<ProfileFilterFavorite> {
  final Value<int> id;
  final Value<bool> profileFilterFavorites;
  const ProfileFilterFavoritesCompanion({
    this.id = const Value.absent(),
    this.profileFilterFavorites = const Value.absent(),
  });
  ProfileFilterFavoritesCompanion.insert({
    this.id = const Value.absent(),
    this.profileFilterFavorites = const Value.absent(),
  });
  static Insertable<ProfileFilterFavorite> custom({
    Expression<int>? id,
    Expression<bool>? profileFilterFavorites,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (profileFilterFavorites != null)
        'profile_filter_favorites': profileFilterFavorites,
    });
  }

  ProfileFilterFavoritesCompanion copyWith({
    Value<int>? id,
    Value<bool>? profileFilterFavorites,
  }) {
    return ProfileFilterFavoritesCompanion(
      id: id ?? this.id,
      profileFilterFavorites:
          profileFilterFavorites ?? this.profileFilterFavorites,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (profileFilterFavorites.present) {
      map['profile_filter_favorites'] = Variable<bool>(
        profileFilterFavorites.value,
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProfileFilterFavoritesCompanion(')
          ..write('id: $id, ')
          ..write('profileFilterFavorites: $profileFilterFavorites')
          ..write(')'))
        .toString();
  }
}

class $ShowAdvancedProfileFiltersTable extends schema.ShowAdvancedProfileFilters
    with
        TableInfo<$ShowAdvancedProfileFiltersTable, ShowAdvancedProfileFilter> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ShowAdvancedProfileFiltersTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _advancedFiltersMeta = const VerificationMeta(
    'advancedFilters',
  );
  @override
  late final GeneratedColumn<bool> advancedFilters = GeneratedColumn<bool>(
    'advanced_filters',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("advanced_filters" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [id, advancedFilters];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'show_advanced_profile_filters';
  @override
  VerificationContext validateIntegrity(
    Insertable<ShowAdvancedProfileFilter> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('advanced_filters')) {
      context.handle(
        _advancedFiltersMeta,
        advancedFilters.isAcceptableOrUnknown(
          data['advanced_filters']!,
          _advancedFiltersMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ShowAdvancedProfileFilter map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ShowAdvancedProfileFilter(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      advancedFilters: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}advanced_filters'],
      )!,
    );
  }

  @override
  $ShowAdvancedProfileFiltersTable createAlias(String alias) {
    return $ShowAdvancedProfileFiltersTable(attachedDatabase, alias);
  }
}

class ShowAdvancedProfileFilter extends DataClass
    implements Insertable<ShowAdvancedProfileFilter> {
  final int id;
  final bool advancedFilters;
  const ShowAdvancedProfileFilter({
    required this.id,
    required this.advancedFilters,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['advanced_filters'] = Variable<bool>(advancedFilters);
    return map;
  }

  ShowAdvancedProfileFiltersCompanion toCompanion(bool nullToAbsent) {
    return ShowAdvancedProfileFiltersCompanion(
      id: Value(id),
      advancedFilters: Value(advancedFilters),
    );
  }

  factory ShowAdvancedProfileFilter.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ShowAdvancedProfileFilter(
      id: serializer.fromJson<int>(json['id']),
      advancedFilters: serializer.fromJson<bool>(json['advancedFilters']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'advancedFilters': serializer.toJson<bool>(advancedFilters),
    };
  }

  ShowAdvancedProfileFilter copyWith({int? id, bool? advancedFilters}) =>
      ShowAdvancedProfileFilter(
        id: id ?? this.id,
        advancedFilters: advancedFilters ?? this.advancedFilters,
      );
  ShowAdvancedProfileFilter copyWithCompanion(
    ShowAdvancedProfileFiltersCompanion data,
  ) {
    return ShowAdvancedProfileFilter(
      id: data.id.present ? data.id.value : this.id,
      advancedFilters: data.advancedFilters.present
          ? data.advancedFilters.value
          : this.advancedFilters,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ShowAdvancedProfileFilter(')
          ..write('id: $id, ')
          ..write('advancedFilters: $advancedFilters')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, advancedFilters);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ShowAdvancedProfileFilter &&
          other.id == this.id &&
          other.advancedFilters == this.advancedFilters);
}

class ShowAdvancedProfileFiltersCompanion
    extends UpdateCompanion<ShowAdvancedProfileFilter> {
  final Value<int> id;
  final Value<bool> advancedFilters;
  const ShowAdvancedProfileFiltersCompanion({
    this.id = const Value.absent(),
    this.advancedFilters = const Value.absent(),
  });
  ShowAdvancedProfileFiltersCompanion.insert({
    this.id = const Value.absent(),
    this.advancedFilters = const Value.absent(),
  });
  static Insertable<ShowAdvancedProfileFilter> custom({
    Expression<int>? id,
    Expression<bool>? advancedFilters,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (advancedFilters != null) 'advanced_filters': advancedFilters,
    });
  }

  ShowAdvancedProfileFiltersCompanion copyWith({
    Value<int>? id,
    Value<bool>? advancedFilters,
  }) {
    return ShowAdvancedProfileFiltersCompanion(
      id: id ?? this.id,
      advancedFilters: advancedFilters ?? this.advancedFilters,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (advancedFilters.present) {
      map['advanced_filters'] = Variable<bool>(advancedFilters.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ShowAdvancedProfileFiltersCompanion(')
          ..write('id: $id, ')
          ..write('advancedFilters: $advancedFilters')
          ..write(')'))
        .toString();
  }
}

class $InitialSyncTable extends schema.InitialSync
    with TableInfo<$InitialSyncTable, InitialSyncData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InitialSyncTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _initialSyncDoneLoginRepositoryMeta =
      const VerificationMeta('initialSyncDoneLoginRepository');
  @override
  late final GeneratedColumn<bool> initialSyncDoneLoginRepository =
      GeneratedColumn<bool>(
        'initial_sync_done_login_repository',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("initial_sync_done_login_repository" IN (0, 1))',
        ),
        defaultValue: const Constant(false),
      );
  static const VerificationMeta _initialSyncDoneAccountRepositoryMeta =
      const VerificationMeta('initialSyncDoneAccountRepository');
  @override
  late final GeneratedColumn<bool> initialSyncDoneAccountRepository =
      GeneratedColumn<bool>(
        'initial_sync_done_account_repository',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("initial_sync_done_account_repository" IN (0, 1))',
        ),
        defaultValue: const Constant(false),
      );
  static const VerificationMeta _initialSyncDoneMediaRepositoryMeta =
      const VerificationMeta('initialSyncDoneMediaRepository');
  @override
  late final GeneratedColumn<bool> initialSyncDoneMediaRepository =
      GeneratedColumn<bool>(
        'initial_sync_done_media_repository',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("initial_sync_done_media_repository" IN (0, 1))',
        ),
        defaultValue: const Constant(false),
      );
  static const VerificationMeta _initialSyncDoneProfileRepositoryMeta =
      const VerificationMeta('initialSyncDoneProfileRepository');
  @override
  late final GeneratedColumn<bool> initialSyncDoneProfileRepository =
      GeneratedColumn<bool>(
        'initial_sync_done_profile_repository',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("initial_sync_done_profile_repository" IN (0, 1))',
        ),
        defaultValue: const Constant(false),
      );
  static const VerificationMeta _initialSyncDoneChatRepositoryMeta =
      const VerificationMeta('initialSyncDoneChatRepository');
  @override
  late final GeneratedColumn<bool> initialSyncDoneChatRepository =
      GeneratedColumn<bool>(
        'initial_sync_done_chat_repository',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("initial_sync_done_chat_repository" IN (0, 1))',
        ),
        defaultValue: const Constant(false),
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    initialSyncDoneLoginRepository,
    initialSyncDoneAccountRepository,
    initialSyncDoneMediaRepository,
    initialSyncDoneProfileRepository,
    initialSyncDoneChatRepository,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'initial_sync';
  @override
  VerificationContext validateIntegrity(
    Insertable<InitialSyncData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('initial_sync_done_login_repository')) {
      context.handle(
        _initialSyncDoneLoginRepositoryMeta,
        initialSyncDoneLoginRepository.isAcceptableOrUnknown(
          data['initial_sync_done_login_repository']!,
          _initialSyncDoneLoginRepositoryMeta,
        ),
      );
    }
    if (data.containsKey('initial_sync_done_account_repository')) {
      context.handle(
        _initialSyncDoneAccountRepositoryMeta,
        initialSyncDoneAccountRepository.isAcceptableOrUnknown(
          data['initial_sync_done_account_repository']!,
          _initialSyncDoneAccountRepositoryMeta,
        ),
      );
    }
    if (data.containsKey('initial_sync_done_media_repository')) {
      context.handle(
        _initialSyncDoneMediaRepositoryMeta,
        initialSyncDoneMediaRepository.isAcceptableOrUnknown(
          data['initial_sync_done_media_repository']!,
          _initialSyncDoneMediaRepositoryMeta,
        ),
      );
    }
    if (data.containsKey('initial_sync_done_profile_repository')) {
      context.handle(
        _initialSyncDoneProfileRepositoryMeta,
        initialSyncDoneProfileRepository.isAcceptableOrUnknown(
          data['initial_sync_done_profile_repository']!,
          _initialSyncDoneProfileRepositoryMeta,
        ),
      );
    }
    if (data.containsKey('initial_sync_done_chat_repository')) {
      context.handle(
        _initialSyncDoneChatRepositoryMeta,
        initialSyncDoneChatRepository.isAcceptableOrUnknown(
          data['initial_sync_done_chat_repository']!,
          _initialSyncDoneChatRepositoryMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InitialSyncData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InitialSyncData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      initialSyncDoneLoginRepository: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}initial_sync_done_login_repository'],
      )!,
      initialSyncDoneAccountRepository: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}initial_sync_done_account_repository'],
      )!,
      initialSyncDoneMediaRepository: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}initial_sync_done_media_repository'],
      )!,
      initialSyncDoneProfileRepository: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}initial_sync_done_profile_repository'],
      )!,
      initialSyncDoneChatRepository: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}initial_sync_done_chat_repository'],
      )!,
    );
  }

  @override
  $InitialSyncTable createAlias(String alias) {
    return $InitialSyncTable(attachedDatabase, alias);
  }
}

class InitialSyncData extends DataClass implements Insertable<InitialSyncData> {
  final int id;
  final bool initialSyncDoneLoginRepository;
  final bool initialSyncDoneAccountRepository;
  final bool initialSyncDoneMediaRepository;
  final bool initialSyncDoneProfileRepository;
  final bool initialSyncDoneChatRepository;
  const InitialSyncData({
    required this.id,
    required this.initialSyncDoneLoginRepository,
    required this.initialSyncDoneAccountRepository,
    required this.initialSyncDoneMediaRepository,
    required this.initialSyncDoneProfileRepository,
    required this.initialSyncDoneChatRepository,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['initial_sync_done_login_repository'] = Variable<bool>(
      initialSyncDoneLoginRepository,
    );
    map['initial_sync_done_account_repository'] = Variable<bool>(
      initialSyncDoneAccountRepository,
    );
    map['initial_sync_done_media_repository'] = Variable<bool>(
      initialSyncDoneMediaRepository,
    );
    map['initial_sync_done_profile_repository'] = Variable<bool>(
      initialSyncDoneProfileRepository,
    );
    map['initial_sync_done_chat_repository'] = Variable<bool>(
      initialSyncDoneChatRepository,
    );
    return map;
  }

  InitialSyncCompanion toCompanion(bool nullToAbsent) {
    return InitialSyncCompanion(
      id: Value(id),
      initialSyncDoneLoginRepository: Value(initialSyncDoneLoginRepository),
      initialSyncDoneAccountRepository: Value(initialSyncDoneAccountRepository),
      initialSyncDoneMediaRepository: Value(initialSyncDoneMediaRepository),
      initialSyncDoneProfileRepository: Value(initialSyncDoneProfileRepository),
      initialSyncDoneChatRepository: Value(initialSyncDoneChatRepository),
    );
  }

  factory InitialSyncData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InitialSyncData(
      id: serializer.fromJson<int>(json['id']),
      initialSyncDoneLoginRepository: serializer.fromJson<bool>(
        json['initialSyncDoneLoginRepository'],
      ),
      initialSyncDoneAccountRepository: serializer.fromJson<bool>(
        json['initialSyncDoneAccountRepository'],
      ),
      initialSyncDoneMediaRepository: serializer.fromJson<bool>(
        json['initialSyncDoneMediaRepository'],
      ),
      initialSyncDoneProfileRepository: serializer.fromJson<bool>(
        json['initialSyncDoneProfileRepository'],
      ),
      initialSyncDoneChatRepository: serializer.fromJson<bool>(
        json['initialSyncDoneChatRepository'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'initialSyncDoneLoginRepository': serializer.toJson<bool>(
        initialSyncDoneLoginRepository,
      ),
      'initialSyncDoneAccountRepository': serializer.toJson<bool>(
        initialSyncDoneAccountRepository,
      ),
      'initialSyncDoneMediaRepository': serializer.toJson<bool>(
        initialSyncDoneMediaRepository,
      ),
      'initialSyncDoneProfileRepository': serializer.toJson<bool>(
        initialSyncDoneProfileRepository,
      ),
      'initialSyncDoneChatRepository': serializer.toJson<bool>(
        initialSyncDoneChatRepository,
      ),
    };
  }

  InitialSyncData copyWith({
    int? id,
    bool? initialSyncDoneLoginRepository,
    bool? initialSyncDoneAccountRepository,
    bool? initialSyncDoneMediaRepository,
    bool? initialSyncDoneProfileRepository,
    bool? initialSyncDoneChatRepository,
  }) => InitialSyncData(
    id: id ?? this.id,
    initialSyncDoneLoginRepository:
        initialSyncDoneLoginRepository ?? this.initialSyncDoneLoginRepository,
    initialSyncDoneAccountRepository:
        initialSyncDoneAccountRepository ??
        this.initialSyncDoneAccountRepository,
    initialSyncDoneMediaRepository:
        initialSyncDoneMediaRepository ?? this.initialSyncDoneMediaRepository,
    initialSyncDoneProfileRepository:
        initialSyncDoneProfileRepository ??
        this.initialSyncDoneProfileRepository,
    initialSyncDoneChatRepository:
        initialSyncDoneChatRepository ?? this.initialSyncDoneChatRepository,
  );
  InitialSyncData copyWithCompanion(InitialSyncCompanion data) {
    return InitialSyncData(
      id: data.id.present ? data.id.value : this.id,
      initialSyncDoneLoginRepository:
          data.initialSyncDoneLoginRepository.present
          ? data.initialSyncDoneLoginRepository.value
          : this.initialSyncDoneLoginRepository,
      initialSyncDoneAccountRepository:
          data.initialSyncDoneAccountRepository.present
          ? data.initialSyncDoneAccountRepository.value
          : this.initialSyncDoneAccountRepository,
      initialSyncDoneMediaRepository:
          data.initialSyncDoneMediaRepository.present
          ? data.initialSyncDoneMediaRepository.value
          : this.initialSyncDoneMediaRepository,
      initialSyncDoneProfileRepository:
          data.initialSyncDoneProfileRepository.present
          ? data.initialSyncDoneProfileRepository.value
          : this.initialSyncDoneProfileRepository,
      initialSyncDoneChatRepository: data.initialSyncDoneChatRepository.present
          ? data.initialSyncDoneChatRepository.value
          : this.initialSyncDoneChatRepository,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InitialSyncData(')
          ..write('id: $id, ')
          ..write(
            'initialSyncDoneLoginRepository: $initialSyncDoneLoginRepository, ',
          )
          ..write(
            'initialSyncDoneAccountRepository: $initialSyncDoneAccountRepository, ',
          )
          ..write(
            'initialSyncDoneMediaRepository: $initialSyncDoneMediaRepository, ',
          )
          ..write(
            'initialSyncDoneProfileRepository: $initialSyncDoneProfileRepository, ',
          )
          ..write(
            'initialSyncDoneChatRepository: $initialSyncDoneChatRepository',
          )
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    initialSyncDoneLoginRepository,
    initialSyncDoneAccountRepository,
    initialSyncDoneMediaRepository,
    initialSyncDoneProfileRepository,
    initialSyncDoneChatRepository,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InitialSyncData &&
          other.id == this.id &&
          other.initialSyncDoneLoginRepository ==
              this.initialSyncDoneLoginRepository &&
          other.initialSyncDoneAccountRepository ==
              this.initialSyncDoneAccountRepository &&
          other.initialSyncDoneMediaRepository ==
              this.initialSyncDoneMediaRepository &&
          other.initialSyncDoneProfileRepository ==
              this.initialSyncDoneProfileRepository &&
          other.initialSyncDoneChatRepository ==
              this.initialSyncDoneChatRepository);
}

class InitialSyncCompanion extends UpdateCompanion<InitialSyncData> {
  final Value<int> id;
  final Value<bool> initialSyncDoneLoginRepository;
  final Value<bool> initialSyncDoneAccountRepository;
  final Value<bool> initialSyncDoneMediaRepository;
  final Value<bool> initialSyncDoneProfileRepository;
  final Value<bool> initialSyncDoneChatRepository;
  const InitialSyncCompanion({
    this.id = const Value.absent(),
    this.initialSyncDoneLoginRepository = const Value.absent(),
    this.initialSyncDoneAccountRepository = const Value.absent(),
    this.initialSyncDoneMediaRepository = const Value.absent(),
    this.initialSyncDoneProfileRepository = const Value.absent(),
    this.initialSyncDoneChatRepository = const Value.absent(),
  });
  InitialSyncCompanion.insert({
    this.id = const Value.absent(),
    this.initialSyncDoneLoginRepository = const Value.absent(),
    this.initialSyncDoneAccountRepository = const Value.absent(),
    this.initialSyncDoneMediaRepository = const Value.absent(),
    this.initialSyncDoneProfileRepository = const Value.absent(),
    this.initialSyncDoneChatRepository = const Value.absent(),
  });
  static Insertable<InitialSyncData> custom({
    Expression<int>? id,
    Expression<bool>? initialSyncDoneLoginRepository,
    Expression<bool>? initialSyncDoneAccountRepository,
    Expression<bool>? initialSyncDoneMediaRepository,
    Expression<bool>? initialSyncDoneProfileRepository,
    Expression<bool>? initialSyncDoneChatRepository,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (initialSyncDoneLoginRepository != null)
        'initial_sync_done_login_repository': initialSyncDoneLoginRepository,
      if (initialSyncDoneAccountRepository != null)
        'initial_sync_done_account_repository':
            initialSyncDoneAccountRepository,
      if (initialSyncDoneMediaRepository != null)
        'initial_sync_done_media_repository': initialSyncDoneMediaRepository,
      if (initialSyncDoneProfileRepository != null)
        'initial_sync_done_profile_repository':
            initialSyncDoneProfileRepository,
      if (initialSyncDoneChatRepository != null)
        'initial_sync_done_chat_repository': initialSyncDoneChatRepository,
    });
  }

  InitialSyncCompanion copyWith({
    Value<int>? id,
    Value<bool>? initialSyncDoneLoginRepository,
    Value<bool>? initialSyncDoneAccountRepository,
    Value<bool>? initialSyncDoneMediaRepository,
    Value<bool>? initialSyncDoneProfileRepository,
    Value<bool>? initialSyncDoneChatRepository,
  }) {
    return InitialSyncCompanion(
      id: id ?? this.id,
      initialSyncDoneLoginRepository:
          initialSyncDoneLoginRepository ?? this.initialSyncDoneLoginRepository,
      initialSyncDoneAccountRepository:
          initialSyncDoneAccountRepository ??
          this.initialSyncDoneAccountRepository,
      initialSyncDoneMediaRepository:
          initialSyncDoneMediaRepository ?? this.initialSyncDoneMediaRepository,
      initialSyncDoneProfileRepository:
          initialSyncDoneProfileRepository ??
          this.initialSyncDoneProfileRepository,
      initialSyncDoneChatRepository:
          initialSyncDoneChatRepository ?? this.initialSyncDoneChatRepository,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (initialSyncDoneLoginRepository.present) {
      map['initial_sync_done_login_repository'] = Variable<bool>(
        initialSyncDoneLoginRepository.value,
      );
    }
    if (initialSyncDoneAccountRepository.present) {
      map['initial_sync_done_account_repository'] = Variable<bool>(
        initialSyncDoneAccountRepository.value,
      );
    }
    if (initialSyncDoneMediaRepository.present) {
      map['initial_sync_done_media_repository'] = Variable<bool>(
        initialSyncDoneMediaRepository.value,
      );
    }
    if (initialSyncDoneProfileRepository.present) {
      map['initial_sync_done_profile_repository'] = Variable<bool>(
        initialSyncDoneProfileRepository.value,
      );
    }
    if (initialSyncDoneChatRepository.present) {
      map['initial_sync_done_chat_repository'] = Variable<bool>(
        initialSyncDoneChatRepository.value,
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InitialSyncCompanion(')
          ..write('id: $id, ')
          ..write(
            'initialSyncDoneLoginRepository: $initialSyncDoneLoginRepository, ',
          )
          ..write(
            'initialSyncDoneAccountRepository: $initialSyncDoneAccountRepository, ',
          )
          ..write(
            'initialSyncDoneMediaRepository: $initialSyncDoneMediaRepository, ',
          )
          ..write(
            'initialSyncDoneProfileRepository: $initialSyncDoneProfileRepository, ',
          )
          ..write(
            'initialSyncDoneChatRepository: $initialSyncDoneChatRepository',
          )
          ..write(')'))
        .toString();
  }
}

class $InitialSetupSkippedTable extends schema.InitialSetupSkipped
    with TableInfo<$InitialSetupSkippedTable, InitialSetupSkippedData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InitialSetupSkippedTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _initialSetupSkippedMeta =
      const VerificationMeta('initialSetupSkipped');
  @override
  late final GeneratedColumn<bool> initialSetupSkipped = GeneratedColumn<bool>(
    'initial_setup_skipped',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("initial_setup_skipped" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [id, initialSetupSkipped];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'initial_setup_skipped';
  @override
  VerificationContext validateIntegrity(
    Insertable<InitialSetupSkippedData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('initial_setup_skipped')) {
      context.handle(
        _initialSetupSkippedMeta,
        initialSetupSkipped.isAcceptableOrUnknown(
          data['initial_setup_skipped']!,
          _initialSetupSkippedMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InitialSetupSkippedData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InitialSetupSkippedData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      initialSetupSkipped: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}initial_setup_skipped'],
      )!,
    );
  }

  @override
  $InitialSetupSkippedTable createAlias(String alias) {
    return $InitialSetupSkippedTable(attachedDatabase, alias);
  }
}

class InitialSetupSkippedData extends DataClass
    implements Insertable<InitialSetupSkippedData> {
  final int id;
  final bool initialSetupSkipped;
  const InitialSetupSkippedData({
    required this.id,
    required this.initialSetupSkipped,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['initial_setup_skipped'] = Variable<bool>(initialSetupSkipped);
    return map;
  }

  InitialSetupSkippedCompanion toCompanion(bool nullToAbsent) {
    return InitialSetupSkippedCompanion(
      id: Value(id),
      initialSetupSkipped: Value(initialSetupSkipped),
    );
  }

  factory InitialSetupSkippedData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InitialSetupSkippedData(
      id: serializer.fromJson<int>(json['id']),
      initialSetupSkipped: serializer.fromJson<bool>(
        json['initialSetupSkipped'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'initialSetupSkipped': serializer.toJson<bool>(initialSetupSkipped),
    };
  }

  InitialSetupSkippedData copyWith({int? id, bool? initialSetupSkipped}) =>
      InitialSetupSkippedData(
        id: id ?? this.id,
        initialSetupSkipped: initialSetupSkipped ?? this.initialSetupSkipped,
      );
  InitialSetupSkippedData copyWithCompanion(InitialSetupSkippedCompanion data) {
    return InitialSetupSkippedData(
      id: data.id.present ? data.id.value : this.id,
      initialSetupSkipped: data.initialSetupSkipped.present
          ? data.initialSetupSkipped.value
          : this.initialSetupSkipped,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InitialSetupSkippedData(')
          ..write('id: $id, ')
          ..write('initialSetupSkipped: $initialSetupSkipped')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, initialSetupSkipped);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InitialSetupSkippedData &&
          other.id == this.id &&
          other.initialSetupSkipped == this.initialSetupSkipped);
}

class InitialSetupSkippedCompanion
    extends UpdateCompanion<InitialSetupSkippedData> {
  final Value<int> id;
  final Value<bool> initialSetupSkipped;
  const InitialSetupSkippedCompanion({
    this.id = const Value.absent(),
    this.initialSetupSkipped = const Value.absent(),
  });
  InitialSetupSkippedCompanion.insert({
    this.id = const Value.absent(),
    this.initialSetupSkipped = const Value.absent(),
  });
  static Insertable<InitialSetupSkippedData> custom({
    Expression<int>? id,
    Expression<bool>? initialSetupSkipped,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (initialSetupSkipped != null)
        'initial_setup_skipped': initialSetupSkipped,
    });
  }

  InitialSetupSkippedCompanion copyWith({
    Value<int>? id,
    Value<bool>? initialSetupSkipped,
  }) {
    return InitialSetupSkippedCompanion(
      id: id ?? this.id,
      initialSetupSkipped: initialSetupSkipped ?? this.initialSetupSkipped,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (initialSetupSkipped.present) {
      map['initial_setup_skipped'] = Variable<bool>(initialSetupSkipped.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InitialSetupSkippedCompanion(')
          ..write('id: $id, ')
          ..write('initialSetupSkipped: $initialSetupSkipped')
          ..write(')'))
        .toString();
  }
}

class $GridSettingsTable extends schema.GridSettings
    with TableInfo<$GridSettingsTable, GridSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GridSettingsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _gridItemSizeModeMeta = const VerificationMeta(
    'gridItemSizeMode',
  );
  @override
  late final GeneratedColumn<int> gridItemSizeMode = GeneratedColumn<int>(
    'grid_item_size_mode',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _gridPaddingModeMeta = const VerificationMeta(
    'gridPaddingMode',
  );
  @override
  late final GeneratedColumn<int> gridPaddingMode = GeneratedColumn<int>(
    'grid_padding_mode',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, gridItemSizeMode, gridPaddingMode];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'grid_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<GridSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('grid_item_size_mode')) {
      context.handle(
        _gridItemSizeModeMeta,
        gridItemSizeMode.isAcceptableOrUnknown(
          data['grid_item_size_mode']!,
          _gridItemSizeModeMeta,
        ),
      );
    }
    if (data.containsKey('grid_padding_mode')) {
      context.handle(
        _gridPaddingModeMeta,
        gridPaddingMode.isAcceptableOrUnknown(
          data['grid_padding_mode']!,
          _gridPaddingModeMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GridSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GridSetting(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      gridItemSizeMode: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}grid_item_size_mode'],
      ),
      gridPaddingMode: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}grid_padding_mode'],
      ),
    );
  }

  @override
  $GridSettingsTable createAlias(String alias) {
    return $GridSettingsTable(attachedDatabase, alias);
  }
}

class GridSetting extends DataClass implements Insertable<GridSetting> {
  final int id;

  /// - 0 = Small
  /// - 1 = Medium
  /// - 2 = Large
  final int? gridItemSizeMode;

  /// - 0 = Small
  /// - 1 = Medium
  /// - 2 = Large
  /// - 3 = Disabled
  final int? gridPaddingMode;
  const GridSetting({
    required this.id,
    this.gridItemSizeMode,
    this.gridPaddingMode,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || gridItemSizeMode != null) {
      map['grid_item_size_mode'] = Variable<int>(gridItemSizeMode);
    }
    if (!nullToAbsent || gridPaddingMode != null) {
      map['grid_padding_mode'] = Variable<int>(gridPaddingMode);
    }
    return map;
  }

  GridSettingsCompanion toCompanion(bool nullToAbsent) {
    return GridSettingsCompanion(
      id: Value(id),
      gridItemSizeMode: gridItemSizeMode == null && nullToAbsent
          ? const Value.absent()
          : Value(gridItemSizeMode),
      gridPaddingMode: gridPaddingMode == null && nullToAbsent
          ? const Value.absent()
          : Value(gridPaddingMode),
    );
  }

  factory GridSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GridSetting(
      id: serializer.fromJson<int>(json['id']),
      gridItemSizeMode: serializer.fromJson<int?>(json['gridItemSizeMode']),
      gridPaddingMode: serializer.fromJson<int?>(json['gridPaddingMode']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'gridItemSizeMode': serializer.toJson<int?>(gridItemSizeMode),
      'gridPaddingMode': serializer.toJson<int?>(gridPaddingMode),
    };
  }

  GridSetting copyWith({
    int? id,
    Value<int?> gridItemSizeMode = const Value.absent(),
    Value<int?> gridPaddingMode = const Value.absent(),
  }) => GridSetting(
    id: id ?? this.id,
    gridItemSizeMode: gridItemSizeMode.present
        ? gridItemSizeMode.value
        : this.gridItemSizeMode,
    gridPaddingMode: gridPaddingMode.present
        ? gridPaddingMode.value
        : this.gridPaddingMode,
  );
  GridSetting copyWithCompanion(GridSettingsCompanion data) {
    return GridSetting(
      id: data.id.present ? data.id.value : this.id,
      gridItemSizeMode: data.gridItemSizeMode.present
          ? data.gridItemSizeMode.value
          : this.gridItemSizeMode,
      gridPaddingMode: data.gridPaddingMode.present
          ? data.gridPaddingMode.value
          : this.gridPaddingMode,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GridSetting(')
          ..write('id: $id, ')
          ..write('gridItemSizeMode: $gridItemSizeMode, ')
          ..write('gridPaddingMode: $gridPaddingMode')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, gridItemSizeMode, gridPaddingMode);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GridSetting &&
          other.id == this.id &&
          other.gridItemSizeMode == this.gridItemSizeMode &&
          other.gridPaddingMode == this.gridPaddingMode);
}

class GridSettingsCompanion extends UpdateCompanion<GridSetting> {
  final Value<int> id;
  final Value<int?> gridItemSizeMode;
  final Value<int?> gridPaddingMode;
  const GridSettingsCompanion({
    this.id = const Value.absent(),
    this.gridItemSizeMode = const Value.absent(),
    this.gridPaddingMode = const Value.absent(),
  });
  GridSettingsCompanion.insert({
    this.id = const Value.absent(),
    this.gridItemSizeMode = const Value.absent(),
    this.gridPaddingMode = const Value.absent(),
  });
  static Insertable<GridSetting> custom({
    Expression<int>? id,
    Expression<int>? gridItemSizeMode,
    Expression<int>? gridPaddingMode,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (gridItemSizeMode != null) 'grid_item_size_mode': gridItemSizeMode,
      if (gridPaddingMode != null) 'grid_padding_mode': gridPaddingMode,
    });
  }

  GridSettingsCompanion copyWith({
    Value<int>? id,
    Value<int?>? gridItemSizeMode,
    Value<int?>? gridPaddingMode,
  }) {
    return GridSettingsCompanion(
      id: id ?? this.id,
      gridItemSizeMode: gridItemSizeMode ?? this.gridItemSizeMode,
      gridPaddingMode: gridPaddingMode ?? this.gridPaddingMode,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (gridItemSizeMode.present) {
      map['grid_item_size_mode'] = Variable<int>(gridItemSizeMode.value);
    }
    if (gridPaddingMode.present) {
      map['grid_padding_mode'] = Variable<int>(gridPaddingMode.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GridSettingsCompanion(')
          ..write('id: $id, ')
          ..write('gridItemSizeMode: $gridItemSizeMode, ')
          ..write('gridPaddingMode: $gridPaddingMode')
          ..write(')'))
        .toString();
  }
}

class $ChatBackupReminderTable extends schema.ChatBackupReminder
    with TableInfo<$ChatBackupReminderTable, ChatBackupReminderData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChatBackupReminderTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _reminderIntervalDaysMeta =
      const VerificationMeta('reminderIntervalDays');
  @override
  late final GeneratedColumn<int> reminderIntervalDays = GeneratedColumn<int>(
    'reminder_interval_days',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<UtcDateTime?, int>
  lastBackupTime =
      GeneratedColumn<int>(
        'last_backup_time',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      ).withConverter<UtcDateTime?>(
        $ChatBackupReminderTable.$converterlastBackupTime,
      );
  @override
  late final GeneratedColumnWithTypeConverter<UtcDateTime?, int>
  lastDialogOpenedTime =
      GeneratedColumn<int>(
        'last_dialog_opened_time',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      ).withConverter<UtcDateTime?>(
        $ChatBackupReminderTable.$converterlastDialogOpenedTime,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    reminderIntervalDays,
    lastBackupTime,
    lastDialogOpenedTime,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chat_backup_reminder';
  @override
  VerificationContext validateIntegrity(
    Insertable<ChatBackupReminderData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('reminder_interval_days')) {
      context.handle(
        _reminderIntervalDaysMeta,
        reminderIntervalDays.isAcceptableOrUnknown(
          data['reminder_interval_days']!,
          _reminderIntervalDaysMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChatBackupReminderData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChatBackupReminderData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      reminderIntervalDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reminder_interval_days'],
      ),
      lastBackupTime: $ChatBackupReminderTable.$converterlastBackupTime.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}last_backup_time'],
        ),
      ),
      lastDialogOpenedTime: $ChatBackupReminderTable
          .$converterlastDialogOpenedTime
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.int,
              data['${effectivePrefix}last_dialog_opened_time'],
            ),
          ),
    );
  }

  @override
  $ChatBackupReminderTable createAlias(String alias) {
    return $ChatBackupReminderTable(attachedDatabase, alias);
  }

  static TypeConverter<UtcDateTime?, int?> $converterlastBackupTime =
      NullAwareTypeConverter.wrap(const UtcDateTimeConverter());
  static TypeConverter<UtcDateTime?, int?> $converterlastDialogOpenedTime =
      NullAwareTypeConverter.wrap(const UtcDateTimeConverter());
}

class ChatBackupReminderData extends DataClass
    implements Insertable<ChatBackupReminderData> {
  final int id;

  /// Backup reminder interval in days. 0 = disabled, null = use default value
  final int? reminderIntervalDays;

  /// Last time a backup was created
  final UtcDateTime? lastBackupTime;

  /// Last time the reminder dialog was opened
  final UtcDateTime? lastDialogOpenedTime;
  const ChatBackupReminderData({
    required this.id,
    this.reminderIntervalDays,
    this.lastBackupTime,
    this.lastDialogOpenedTime,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || reminderIntervalDays != null) {
      map['reminder_interval_days'] = Variable<int>(reminderIntervalDays);
    }
    if (!nullToAbsent || lastBackupTime != null) {
      map['last_backup_time'] = Variable<int>(
        $ChatBackupReminderTable.$converterlastBackupTime.toSql(lastBackupTime),
      );
    }
    if (!nullToAbsent || lastDialogOpenedTime != null) {
      map['last_dialog_opened_time'] = Variable<int>(
        $ChatBackupReminderTable.$converterlastDialogOpenedTime.toSql(
          lastDialogOpenedTime,
        ),
      );
    }
    return map;
  }

  ChatBackupReminderCompanion toCompanion(bool nullToAbsent) {
    return ChatBackupReminderCompanion(
      id: Value(id),
      reminderIntervalDays: reminderIntervalDays == null && nullToAbsent
          ? const Value.absent()
          : Value(reminderIntervalDays),
      lastBackupTime: lastBackupTime == null && nullToAbsent
          ? const Value.absent()
          : Value(lastBackupTime),
      lastDialogOpenedTime: lastDialogOpenedTime == null && nullToAbsent
          ? const Value.absent()
          : Value(lastDialogOpenedTime),
    );
  }

  factory ChatBackupReminderData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChatBackupReminderData(
      id: serializer.fromJson<int>(json['id']),
      reminderIntervalDays: serializer.fromJson<int?>(
        json['reminderIntervalDays'],
      ),
      lastBackupTime: serializer.fromJson<UtcDateTime?>(json['lastBackupTime']),
      lastDialogOpenedTime: serializer.fromJson<UtcDateTime?>(
        json['lastDialogOpenedTime'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'reminderIntervalDays': serializer.toJson<int?>(reminderIntervalDays),
      'lastBackupTime': serializer.toJson<UtcDateTime?>(lastBackupTime),
      'lastDialogOpenedTime': serializer.toJson<UtcDateTime?>(
        lastDialogOpenedTime,
      ),
    };
  }

  ChatBackupReminderData copyWith({
    int? id,
    Value<int?> reminderIntervalDays = const Value.absent(),
    Value<UtcDateTime?> lastBackupTime = const Value.absent(),
    Value<UtcDateTime?> lastDialogOpenedTime = const Value.absent(),
  }) => ChatBackupReminderData(
    id: id ?? this.id,
    reminderIntervalDays: reminderIntervalDays.present
        ? reminderIntervalDays.value
        : this.reminderIntervalDays,
    lastBackupTime: lastBackupTime.present
        ? lastBackupTime.value
        : this.lastBackupTime,
    lastDialogOpenedTime: lastDialogOpenedTime.present
        ? lastDialogOpenedTime.value
        : this.lastDialogOpenedTime,
  );
  ChatBackupReminderData copyWithCompanion(ChatBackupReminderCompanion data) {
    return ChatBackupReminderData(
      id: data.id.present ? data.id.value : this.id,
      reminderIntervalDays: data.reminderIntervalDays.present
          ? data.reminderIntervalDays.value
          : this.reminderIntervalDays,
      lastBackupTime: data.lastBackupTime.present
          ? data.lastBackupTime.value
          : this.lastBackupTime,
      lastDialogOpenedTime: data.lastDialogOpenedTime.present
          ? data.lastDialogOpenedTime.value
          : this.lastDialogOpenedTime,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChatBackupReminderData(')
          ..write('id: $id, ')
          ..write('reminderIntervalDays: $reminderIntervalDays, ')
          ..write('lastBackupTime: $lastBackupTime, ')
          ..write('lastDialogOpenedTime: $lastDialogOpenedTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    reminderIntervalDays,
    lastBackupTime,
    lastDialogOpenedTime,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChatBackupReminderData &&
          other.id == this.id &&
          other.reminderIntervalDays == this.reminderIntervalDays &&
          other.lastBackupTime == this.lastBackupTime &&
          other.lastDialogOpenedTime == this.lastDialogOpenedTime);
}

class ChatBackupReminderCompanion
    extends UpdateCompanion<ChatBackupReminderData> {
  final Value<int> id;
  final Value<int?> reminderIntervalDays;
  final Value<UtcDateTime?> lastBackupTime;
  final Value<UtcDateTime?> lastDialogOpenedTime;
  const ChatBackupReminderCompanion({
    this.id = const Value.absent(),
    this.reminderIntervalDays = const Value.absent(),
    this.lastBackupTime = const Value.absent(),
    this.lastDialogOpenedTime = const Value.absent(),
  });
  ChatBackupReminderCompanion.insert({
    this.id = const Value.absent(),
    this.reminderIntervalDays = const Value.absent(),
    this.lastBackupTime = const Value.absent(),
    this.lastDialogOpenedTime = const Value.absent(),
  });
  static Insertable<ChatBackupReminderData> custom({
    Expression<int>? id,
    Expression<int>? reminderIntervalDays,
    Expression<int>? lastBackupTime,
    Expression<int>? lastDialogOpenedTime,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (reminderIntervalDays != null)
        'reminder_interval_days': reminderIntervalDays,
      if (lastBackupTime != null) 'last_backup_time': lastBackupTime,
      if (lastDialogOpenedTime != null)
        'last_dialog_opened_time': lastDialogOpenedTime,
    });
  }

  ChatBackupReminderCompanion copyWith({
    Value<int>? id,
    Value<int?>? reminderIntervalDays,
    Value<UtcDateTime?>? lastBackupTime,
    Value<UtcDateTime?>? lastDialogOpenedTime,
  }) {
    return ChatBackupReminderCompanion(
      id: id ?? this.id,
      reminderIntervalDays: reminderIntervalDays ?? this.reminderIntervalDays,
      lastBackupTime: lastBackupTime ?? this.lastBackupTime,
      lastDialogOpenedTime: lastDialogOpenedTime ?? this.lastDialogOpenedTime,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (reminderIntervalDays.present) {
      map['reminder_interval_days'] = Variable<int>(reminderIntervalDays.value);
    }
    if (lastBackupTime.present) {
      map['last_backup_time'] = Variable<int>(
        $ChatBackupReminderTable.$converterlastBackupTime.toSql(
          lastBackupTime.value,
        ),
      );
    }
    if (lastDialogOpenedTime.present) {
      map['last_dialog_opened_time'] = Variable<int>(
        $ChatBackupReminderTable.$converterlastDialogOpenedTime.toSql(
          lastDialogOpenedTime.value,
        ),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChatBackupReminderCompanion(')
          ..write('id: $id, ')
          ..write('reminderIntervalDays: $reminderIntervalDays, ')
          ..write('lastBackupTime: $lastBackupTime, ')
          ..write('lastDialogOpenedTime: $lastDialogOpenedTime')
          ..write(')'))
        .toString();
  }
}

class $AdminNotificationTable extends schema.AdminNotification
    with TableInfo<$AdminNotificationTable, AdminNotificationData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AdminNotificationTable(this.attachedDatabase, [this._alias]);
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
  late final GeneratedColumnWithTypeConverter<
    JsonObject<AdminNotification>?,
    String
  >
  jsonViewedNotification =
      GeneratedColumn<String>(
        'json_viewed_notification',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<JsonObject<AdminNotification>?>(
        $AdminNotificationTable.$converterjsonViewedNotification,
      );
  @override
  List<GeneratedColumn> get $columns => [id, jsonViewedNotification];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'admin_notification';
  @override
  VerificationContext validateIntegrity(
    Insertable<AdminNotificationData> instance, {
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
  AdminNotificationData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AdminNotificationData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      jsonViewedNotification: $AdminNotificationTable
          .$converterjsonViewedNotification
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}json_viewed_notification'],
            ),
          ),
    );
  }

  @override
  $AdminNotificationTable createAlias(String alias) {
    return $AdminNotificationTable(attachedDatabase, alias);
  }

  static TypeConverter<JsonObject<AdminNotification>?, String?>
  $converterjsonViewedNotification = NullAwareTypeConverter.wrap(
    const AdminNotificationConverter(),
  );
}

class AdminNotificationData extends DataClass
    implements Insertable<AdminNotificationData> {
  final int id;
  final JsonObject<AdminNotification>? jsonViewedNotification;
  const AdminNotificationData({required this.id, this.jsonViewedNotification});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || jsonViewedNotification != null) {
      map['json_viewed_notification'] = Variable<String>(
        $AdminNotificationTable.$converterjsonViewedNotification.toSql(
          jsonViewedNotification,
        ),
      );
    }
    return map;
  }

  AdminNotificationCompanion toCompanion(bool nullToAbsent) {
    return AdminNotificationCompanion(
      id: Value(id),
      jsonViewedNotification: jsonViewedNotification == null && nullToAbsent
          ? const Value.absent()
          : Value(jsonViewedNotification),
    );
  }

  factory AdminNotificationData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AdminNotificationData(
      id: serializer.fromJson<int>(json['id']),
      jsonViewedNotification: serializer
          .fromJson<JsonObject<AdminNotification>?>(
            json['jsonViewedNotification'],
          ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'jsonViewedNotification': serializer
          .toJson<JsonObject<AdminNotification>?>(jsonViewedNotification),
    };
  }

  AdminNotificationData copyWith({
    int? id,
    Value<JsonObject<AdminNotification>?> jsonViewedNotification =
        const Value.absent(),
  }) => AdminNotificationData(
    id: id ?? this.id,
    jsonViewedNotification: jsonViewedNotification.present
        ? jsonViewedNotification.value
        : this.jsonViewedNotification,
  );
  AdminNotificationData copyWithCompanion(AdminNotificationCompanion data) {
    return AdminNotificationData(
      id: data.id.present ? data.id.value : this.id,
      jsonViewedNotification: data.jsonViewedNotification.present
          ? data.jsonViewedNotification.value
          : this.jsonViewedNotification,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AdminNotificationData(')
          ..write('id: $id, ')
          ..write('jsonViewedNotification: $jsonViewedNotification')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, jsonViewedNotification);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AdminNotificationData &&
          other.id == this.id &&
          other.jsonViewedNotification == this.jsonViewedNotification);
}

class AdminNotificationCompanion
    extends UpdateCompanion<AdminNotificationData> {
  final Value<int> id;
  final Value<JsonObject<AdminNotification>?> jsonViewedNotification;
  const AdminNotificationCompanion({
    this.id = const Value.absent(),
    this.jsonViewedNotification = const Value.absent(),
  });
  AdminNotificationCompanion.insert({
    this.id = const Value.absent(),
    this.jsonViewedNotification = const Value.absent(),
  });
  static Insertable<AdminNotificationData> custom({
    Expression<int>? id,
    Expression<String>? jsonViewedNotification,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (jsonViewedNotification != null)
        'json_viewed_notification': jsonViewedNotification,
    });
  }

  AdminNotificationCompanion copyWith({
    Value<int>? id,
    Value<JsonObject<AdminNotification>?>? jsonViewedNotification,
  }) {
    return AdminNotificationCompanion(
      id: id ?? this.id,
      jsonViewedNotification:
          jsonViewedNotification ?? this.jsonViewedNotification,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (jsonViewedNotification.present) {
      map['json_viewed_notification'] = Variable<String>(
        $AdminNotificationTable.$converterjsonViewedNotification.toSql(
          jsonViewedNotification.value,
        ),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AdminNotificationCompanion(')
          ..write('id: $id, ')
          ..write('jsonViewedNotification: $jsonViewedNotification')
          ..write(')'))
        .toString();
  }
}

class $AppNotificationSettingsTable extends schema.AppNotificationSettings
    with TableInfo<$AppNotificationSettingsTable, AppNotificationSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppNotificationSettingsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _messagesMeta = const VerificationMeta(
    'messages',
  );
  @override
  late final GeneratedColumn<bool> messages = GeneratedColumn<bool>(
    'messages',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("messages" IN (0, 1))',
    ),
  );
  static const VerificationMeta _likesMeta = const VerificationMeta('likes');
  @override
  late final GeneratedColumn<bool> likes = GeneratedColumn<bool>(
    'likes',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("likes" IN (0, 1))',
    ),
  );
  static const VerificationMeta _mediaContentModerationCompletedMeta =
      const VerificationMeta('mediaContentModerationCompleted');
  @override
  late final GeneratedColumn<bool> mediaContentModerationCompleted =
      GeneratedColumn<bool>(
        'media_content_moderation_completed',
        aliasedName,
        true,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("media_content_moderation_completed" IN (0, 1))',
        ),
      );
  static const VerificationMeta _profileStringModerationCompletedMeta =
      const VerificationMeta('profileStringModerationCompleted');
  @override
  late final GeneratedColumn<bool> profileStringModerationCompleted =
      GeneratedColumn<bool>(
        'profile_string_moderation_completed',
        aliasedName,
        true,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("profile_string_moderation_completed" IN (0, 1))',
        ),
      );
  static const VerificationMeta _newsMeta = const VerificationMeta('news');
  @override
  late final GeneratedColumn<bool> news = GeneratedColumn<bool>(
    'news',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("news" IN (0, 1))',
    ),
  );
  static const VerificationMeta _automaticProfileSearchMeta =
      const VerificationMeta('automaticProfileSearch');
  @override
  late final GeneratedColumn<bool> automaticProfileSearch =
      GeneratedColumn<bool>(
        'automatic_profile_search',
        aliasedName,
        true,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("automatic_profile_search" IN (0, 1))',
        ),
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    messages,
    likes,
    mediaContentModerationCompleted,
    profileStringModerationCompleted,
    news,
    automaticProfileSearch,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_notification_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppNotificationSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('messages')) {
      context.handle(
        _messagesMeta,
        messages.isAcceptableOrUnknown(data['messages']!, _messagesMeta),
      );
    }
    if (data.containsKey('likes')) {
      context.handle(
        _likesMeta,
        likes.isAcceptableOrUnknown(data['likes']!, _likesMeta),
      );
    }
    if (data.containsKey('media_content_moderation_completed')) {
      context.handle(
        _mediaContentModerationCompletedMeta,
        mediaContentModerationCompleted.isAcceptableOrUnknown(
          data['media_content_moderation_completed']!,
          _mediaContentModerationCompletedMeta,
        ),
      );
    }
    if (data.containsKey('profile_string_moderation_completed')) {
      context.handle(
        _profileStringModerationCompletedMeta,
        profileStringModerationCompleted.isAcceptableOrUnknown(
          data['profile_string_moderation_completed']!,
          _profileStringModerationCompletedMeta,
        ),
      );
    }
    if (data.containsKey('news')) {
      context.handle(
        _newsMeta,
        news.isAcceptableOrUnknown(data['news']!, _newsMeta),
      );
    }
    if (data.containsKey('automatic_profile_search')) {
      context.handle(
        _automaticProfileSearchMeta,
        automaticProfileSearch.isAcceptableOrUnknown(
          data['automatic_profile_search']!,
          _automaticProfileSearchMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppNotificationSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppNotificationSetting(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      messages: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}messages'],
      ),
      likes: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}likes'],
      ),
      mediaContentModerationCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}media_content_moderation_completed'],
      ),
      profileStringModerationCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}profile_string_moderation_completed'],
      ),
      news: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}news'],
      ),
      automaticProfileSearch: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}automatic_profile_search'],
      ),
    );
  }

  @override
  $AppNotificationSettingsTable createAlias(String alias) {
    return $AppNotificationSettingsTable(attachedDatabase, alias);
  }
}

class AppNotificationSetting extends DataClass
    implements Insertable<AppNotificationSetting> {
  final int id;
  final bool? messages;
  final bool? likes;
  final bool? mediaContentModerationCompleted;
  final bool? profileStringModerationCompleted;
  final bool? news;
  final bool? automaticProfileSearch;
  const AppNotificationSetting({
    required this.id,
    this.messages,
    this.likes,
    this.mediaContentModerationCompleted,
    this.profileStringModerationCompleted,
    this.news,
    this.automaticProfileSearch,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || messages != null) {
      map['messages'] = Variable<bool>(messages);
    }
    if (!nullToAbsent || likes != null) {
      map['likes'] = Variable<bool>(likes);
    }
    if (!nullToAbsent || mediaContentModerationCompleted != null) {
      map['media_content_moderation_completed'] = Variable<bool>(
        mediaContentModerationCompleted,
      );
    }
    if (!nullToAbsent || profileStringModerationCompleted != null) {
      map['profile_string_moderation_completed'] = Variable<bool>(
        profileStringModerationCompleted,
      );
    }
    if (!nullToAbsent || news != null) {
      map['news'] = Variable<bool>(news);
    }
    if (!nullToAbsent || automaticProfileSearch != null) {
      map['automatic_profile_search'] = Variable<bool>(automaticProfileSearch);
    }
    return map;
  }

  AppNotificationSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppNotificationSettingsCompanion(
      id: Value(id),
      messages: messages == null && nullToAbsent
          ? const Value.absent()
          : Value(messages),
      likes: likes == null && nullToAbsent
          ? const Value.absent()
          : Value(likes),
      mediaContentModerationCompleted:
          mediaContentModerationCompleted == null && nullToAbsent
          ? const Value.absent()
          : Value(mediaContentModerationCompleted),
      profileStringModerationCompleted:
          profileStringModerationCompleted == null && nullToAbsent
          ? const Value.absent()
          : Value(profileStringModerationCompleted),
      news: news == null && nullToAbsent ? const Value.absent() : Value(news),
      automaticProfileSearch: automaticProfileSearch == null && nullToAbsent
          ? const Value.absent()
          : Value(automaticProfileSearch),
    );
  }

  factory AppNotificationSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppNotificationSetting(
      id: serializer.fromJson<int>(json['id']),
      messages: serializer.fromJson<bool?>(json['messages']),
      likes: serializer.fromJson<bool?>(json['likes']),
      mediaContentModerationCompleted: serializer.fromJson<bool?>(
        json['mediaContentModerationCompleted'],
      ),
      profileStringModerationCompleted: serializer.fromJson<bool?>(
        json['profileStringModerationCompleted'],
      ),
      news: serializer.fromJson<bool?>(json['news']),
      automaticProfileSearch: serializer.fromJson<bool?>(
        json['automaticProfileSearch'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'messages': serializer.toJson<bool?>(messages),
      'likes': serializer.toJson<bool?>(likes),
      'mediaContentModerationCompleted': serializer.toJson<bool?>(
        mediaContentModerationCompleted,
      ),
      'profileStringModerationCompleted': serializer.toJson<bool?>(
        profileStringModerationCompleted,
      ),
      'news': serializer.toJson<bool?>(news),
      'automaticProfileSearch': serializer.toJson<bool?>(
        automaticProfileSearch,
      ),
    };
  }

  AppNotificationSetting copyWith({
    int? id,
    Value<bool?> messages = const Value.absent(),
    Value<bool?> likes = const Value.absent(),
    Value<bool?> mediaContentModerationCompleted = const Value.absent(),
    Value<bool?> profileStringModerationCompleted = const Value.absent(),
    Value<bool?> news = const Value.absent(),
    Value<bool?> automaticProfileSearch = const Value.absent(),
  }) => AppNotificationSetting(
    id: id ?? this.id,
    messages: messages.present ? messages.value : this.messages,
    likes: likes.present ? likes.value : this.likes,
    mediaContentModerationCompleted: mediaContentModerationCompleted.present
        ? mediaContentModerationCompleted.value
        : this.mediaContentModerationCompleted,
    profileStringModerationCompleted: profileStringModerationCompleted.present
        ? profileStringModerationCompleted.value
        : this.profileStringModerationCompleted,
    news: news.present ? news.value : this.news,
    automaticProfileSearch: automaticProfileSearch.present
        ? automaticProfileSearch.value
        : this.automaticProfileSearch,
  );
  AppNotificationSetting copyWithCompanion(
    AppNotificationSettingsCompanion data,
  ) {
    return AppNotificationSetting(
      id: data.id.present ? data.id.value : this.id,
      messages: data.messages.present ? data.messages.value : this.messages,
      likes: data.likes.present ? data.likes.value : this.likes,
      mediaContentModerationCompleted:
          data.mediaContentModerationCompleted.present
          ? data.mediaContentModerationCompleted.value
          : this.mediaContentModerationCompleted,
      profileStringModerationCompleted:
          data.profileStringModerationCompleted.present
          ? data.profileStringModerationCompleted.value
          : this.profileStringModerationCompleted,
      news: data.news.present ? data.news.value : this.news,
      automaticProfileSearch: data.automaticProfileSearch.present
          ? data.automaticProfileSearch.value
          : this.automaticProfileSearch,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppNotificationSetting(')
          ..write('id: $id, ')
          ..write('messages: $messages, ')
          ..write('likes: $likes, ')
          ..write(
            'mediaContentModerationCompleted: $mediaContentModerationCompleted, ',
          )
          ..write(
            'profileStringModerationCompleted: $profileStringModerationCompleted, ',
          )
          ..write('news: $news, ')
          ..write('automaticProfileSearch: $automaticProfileSearch')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    messages,
    likes,
    mediaContentModerationCompleted,
    profileStringModerationCompleted,
    news,
    automaticProfileSearch,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppNotificationSetting &&
          other.id == this.id &&
          other.messages == this.messages &&
          other.likes == this.likes &&
          other.mediaContentModerationCompleted ==
              this.mediaContentModerationCompleted &&
          other.profileStringModerationCompleted ==
              this.profileStringModerationCompleted &&
          other.news == this.news &&
          other.automaticProfileSearch == this.automaticProfileSearch);
}

class AppNotificationSettingsCompanion
    extends UpdateCompanion<AppNotificationSetting> {
  final Value<int> id;
  final Value<bool?> messages;
  final Value<bool?> likes;
  final Value<bool?> mediaContentModerationCompleted;
  final Value<bool?> profileStringModerationCompleted;
  final Value<bool?> news;
  final Value<bool?> automaticProfileSearch;
  const AppNotificationSettingsCompanion({
    this.id = const Value.absent(),
    this.messages = const Value.absent(),
    this.likes = const Value.absent(),
    this.mediaContentModerationCompleted = const Value.absent(),
    this.profileStringModerationCompleted = const Value.absent(),
    this.news = const Value.absent(),
    this.automaticProfileSearch = const Value.absent(),
  });
  AppNotificationSettingsCompanion.insert({
    this.id = const Value.absent(),
    this.messages = const Value.absent(),
    this.likes = const Value.absent(),
    this.mediaContentModerationCompleted = const Value.absent(),
    this.profileStringModerationCompleted = const Value.absent(),
    this.news = const Value.absent(),
    this.automaticProfileSearch = const Value.absent(),
  });
  static Insertable<AppNotificationSetting> custom({
    Expression<int>? id,
    Expression<bool>? messages,
    Expression<bool>? likes,
    Expression<bool>? mediaContentModerationCompleted,
    Expression<bool>? profileStringModerationCompleted,
    Expression<bool>? news,
    Expression<bool>? automaticProfileSearch,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (messages != null) 'messages': messages,
      if (likes != null) 'likes': likes,
      if (mediaContentModerationCompleted != null)
        'media_content_moderation_completed': mediaContentModerationCompleted,
      if (profileStringModerationCompleted != null)
        'profile_string_moderation_completed': profileStringModerationCompleted,
      if (news != null) 'news': news,
      if (automaticProfileSearch != null)
        'automatic_profile_search': automaticProfileSearch,
    });
  }

  AppNotificationSettingsCompanion copyWith({
    Value<int>? id,
    Value<bool?>? messages,
    Value<bool?>? likes,
    Value<bool?>? mediaContentModerationCompleted,
    Value<bool?>? profileStringModerationCompleted,
    Value<bool?>? news,
    Value<bool?>? automaticProfileSearch,
  }) {
    return AppNotificationSettingsCompanion(
      id: id ?? this.id,
      messages: messages ?? this.messages,
      likes: likes ?? this.likes,
      mediaContentModerationCompleted:
          mediaContentModerationCompleted ??
          this.mediaContentModerationCompleted,
      profileStringModerationCompleted:
          profileStringModerationCompleted ??
          this.profileStringModerationCompleted,
      news: news ?? this.news,
      automaticProfileSearch:
          automaticProfileSearch ?? this.automaticProfileSearch,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (messages.present) {
      map['messages'] = Variable<bool>(messages.value);
    }
    if (likes.present) {
      map['likes'] = Variable<bool>(likes.value);
    }
    if (mediaContentModerationCompleted.present) {
      map['media_content_moderation_completed'] = Variable<bool>(
        mediaContentModerationCompleted.value,
      );
    }
    if (profileStringModerationCompleted.present) {
      map['profile_string_moderation_completed'] = Variable<bool>(
        profileStringModerationCompleted.value,
      );
    }
    if (news.present) {
      map['news'] = Variable<bool>(news.value);
    }
    if (automaticProfileSearch.present) {
      map['automatic_profile_search'] = Variable<bool>(
        automaticProfileSearch.value,
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppNotificationSettingsCompanion(')
          ..write('id: $id, ')
          ..write('messages: $messages, ')
          ..write('likes: $likes, ')
          ..write(
            'mediaContentModerationCompleted: $mediaContentModerationCompleted, ',
          )
          ..write(
            'profileStringModerationCompleted: $profileStringModerationCompleted, ',
          )
          ..write('news: $news, ')
          ..write('automaticProfileSearch: $automaticProfileSearch')
          ..write(')'))
        .toString();
  }
}

class $NotificationStatusTable extends schema.NotificationStatus
    with TableInfo<$NotificationStatusTable, NotificationStatusData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotificationStatusTable(this.attachedDatabase, [this._alias]);
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
  late final GeneratedColumnWithTypeConverter<
    JsonObject<NotificationStatus>?,
    String
  >
  jsonAutomaticProfileSearchFoundProfiles =
      GeneratedColumn<String>(
        'json_automatic_profile_search_found_profiles',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<JsonObject<NotificationStatus>?>(
        $NotificationStatusTable
            .$converterjsonAutomaticProfileSearchFoundProfiles,
      );
  @override
  late final GeneratedColumnWithTypeConverter<
    JsonObject<NotificationStatus>?,
    String
  >
  jsonMediaContentAccepted =
      GeneratedColumn<String>(
        'json_media_content_accepted',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<JsonObject<NotificationStatus>?>(
        $NotificationStatusTable.$converterjsonMediaContentAccepted,
      );
  @override
  late final GeneratedColumnWithTypeConverter<
    JsonObject<NotificationStatus>?,
    String
  >
  jsonMediaContentRejected =
      GeneratedColumn<String>(
        'json_media_content_rejected',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<JsonObject<NotificationStatus>?>(
        $NotificationStatusTable.$converterjsonMediaContentRejected,
      );
  @override
  late final GeneratedColumnWithTypeConverter<
    JsonObject<NotificationStatus>?,
    String
  >
  jsonMediaContentDeleted =
      GeneratedColumn<String>(
        'json_media_content_deleted',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<JsonObject<NotificationStatus>?>(
        $NotificationStatusTable.$converterjsonMediaContentDeleted,
      );
  @override
  late final GeneratedColumnWithTypeConverter<
    JsonObject<NotificationStatus>?,
    String
  >
  jsonProfileNameAccepted =
      GeneratedColumn<String>(
        'json_profile_name_accepted',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<JsonObject<NotificationStatus>?>(
        $NotificationStatusTable.$converterjsonProfileNameAccepted,
      );
  @override
  late final GeneratedColumnWithTypeConverter<
    JsonObject<NotificationStatus>?,
    String
  >
  jsonProfileNameRejected =
      GeneratedColumn<String>(
        'json_profile_name_rejected',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<JsonObject<NotificationStatus>?>(
        $NotificationStatusTable.$converterjsonProfileNameRejected,
      );
  @override
  late final GeneratedColumnWithTypeConverter<
    JsonObject<NotificationStatus>?,
    String
  >
  jsonProfileTextAccepted =
      GeneratedColumn<String>(
        'json_profile_text_accepted',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<JsonObject<NotificationStatus>?>(
        $NotificationStatusTable.$converterjsonProfileTextAccepted,
      );
  @override
  late final GeneratedColumnWithTypeConverter<
    JsonObject<NotificationStatus>?,
    String
  >
  jsonProfileTextRejected =
      GeneratedColumn<String>(
        'json_profile_text_rejected',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<JsonObject<NotificationStatus>?>(
        $NotificationStatusTable.$converterjsonProfileTextRejected,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    jsonAutomaticProfileSearchFoundProfiles,
    jsonMediaContentAccepted,
    jsonMediaContentRejected,
    jsonMediaContentDeleted,
    jsonProfileNameAccepted,
    jsonProfileNameRejected,
    jsonProfileTextAccepted,
    jsonProfileTextRejected,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notification_status';
  @override
  VerificationContext validateIntegrity(
    Insertable<NotificationStatusData> instance, {
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
  NotificationStatusData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NotificationStatusData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      jsonAutomaticProfileSearchFoundProfiles: $NotificationStatusTable
          .$converterjsonAutomaticProfileSearchFoundProfiles
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}json_automatic_profile_search_found_profiles'],
            ),
          ),
      jsonMediaContentAccepted: $NotificationStatusTable
          .$converterjsonMediaContentAccepted
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}json_media_content_accepted'],
            ),
          ),
      jsonMediaContentRejected: $NotificationStatusTable
          .$converterjsonMediaContentRejected
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}json_media_content_rejected'],
            ),
          ),
      jsonMediaContentDeleted: $NotificationStatusTable
          .$converterjsonMediaContentDeleted
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}json_media_content_deleted'],
            ),
          ),
      jsonProfileNameAccepted: $NotificationStatusTable
          .$converterjsonProfileNameAccepted
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}json_profile_name_accepted'],
            ),
          ),
      jsonProfileNameRejected: $NotificationStatusTable
          .$converterjsonProfileNameRejected
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}json_profile_name_rejected'],
            ),
          ),
      jsonProfileTextAccepted: $NotificationStatusTable
          .$converterjsonProfileTextAccepted
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}json_profile_text_accepted'],
            ),
          ),
      jsonProfileTextRejected: $NotificationStatusTable
          .$converterjsonProfileTextRejected
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}json_profile_text_rejected'],
            ),
          ),
    );
  }

  @override
  $NotificationStatusTable createAlias(String alias) {
    return $NotificationStatusTable(attachedDatabase, alias);
  }

  static TypeConverter<JsonObject<NotificationStatus>?, String?>
  $converterjsonAutomaticProfileSearchFoundProfiles =
      NullAwareTypeConverter.wrap(const NotificationStatusConverter());
  static TypeConverter<JsonObject<NotificationStatus>?, String?>
  $converterjsonMediaContentAccepted = NullAwareTypeConverter.wrap(
    const NotificationStatusConverter(),
  );
  static TypeConverter<JsonObject<NotificationStatus>?, String?>
  $converterjsonMediaContentRejected = NullAwareTypeConverter.wrap(
    const NotificationStatusConverter(),
  );
  static TypeConverter<JsonObject<NotificationStatus>?, String?>
  $converterjsonMediaContentDeleted = NullAwareTypeConverter.wrap(
    const NotificationStatusConverter(),
  );
  static TypeConverter<JsonObject<NotificationStatus>?, String?>
  $converterjsonProfileNameAccepted = NullAwareTypeConverter.wrap(
    const NotificationStatusConverter(),
  );
  static TypeConverter<JsonObject<NotificationStatus>?, String?>
  $converterjsonProfileNameRejected = NullAwareTypeConverter.wrap(
    const NotificationStatusConverter(),
  );
  static TypeConverter<JsonObject<NotificationStatus>?, String?>
  $converterjsonProfileTextAccepted = NullAwareTypeConverter.wrap(
    const NotificationStatusConverter(),
  );
  static TypeConverter<JsonObject<NotificationStatus>?, String?>
  $converterjsonProfileTextRejected = NullAwareTypeConverter.wrap(
    const NotificationStatusConverter(),
  );
}

class NotificationStatusData extends DataClass
    implements Insertable<NotificationStatusData> {
  final int id;
  final JsonObject<NotificationStatus>? jsonAutomaticProfileSearchFoundProfiles;
  final JsonObject<NotificationStatus>? jsonMediaContentAccepted;
  final JsonObject<NotificationStatus>? jsonMediaContentRejected;
  final JsonObject<NotificationStatus>? jsonMediaContentDeleted;
  final JsonObject<NotificationStatus>? jsonProfileNameAccepted;
  final JsonObject<NotificationStatus>? jsonProfileNameRejected;
  final JsonObject<NotificationStatus>? jsonProfileTextAccepted;
  final JsonObject<NotificationStatus>? jsonProfileTextRejected;
  const NotificationStatusData({
    required this.id,
    this.jsonAutomaticProfileSearchFoundProfiles,
    this.jsonMediaContentAccepted,
    this.jsonMediaContentRejected,
    this.jsonMediaContentDeleted,
    this.jsonProfileNameAccepted,
    this.jsonProfileNameRejected,
    this.jsonProfileTextAccepted,
    this.jsonProfileTextRejected,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || jsonAutomaticProfileSearchFoundProfiles != null) {
      map['json_automatic_profile_search_found_profiles'] = Variable<String>(
        $NotificationStatusTable
            .$converterjsonAutomaticProfileSearchFoundProfiles
            .toSql(jsonAutomaticProfileSearchFoundProfiles),
      );
    }
    if (!nullToAbsent || jsonMediaContentAccepted != null) {
      map['json_media_content_accepted'] = Variable<String>(
        $NotificationStatusTable.$converterjsonMediaContentAccepted.toSql(
          jsonMediaContentAccepted,
        ),
      );
    }
    if (!nullToAbsent || jsonMediaContentRejected != null) {
      map['json_media_content_rejected'] = Variable<String>(
        $NotificationStatusTable.$converterjsonMediaContentRejected.toSql(
          jsonMediaContentRejected,
        ),
      );
    }
    if (!nullToAbsent || jsonMediaContentDeleted != null) {
      map['json_media_content_deleted'] = Variable<String>(
        $NotificationStatusTable.$converterjsonMediaContentDeleted.toSql(
          jsonMediaContentDeleted,
        ),
      );
    }
    if (!nullToAbsent || jsonProfileNameAccepted != null) {
      map['json_profile_name_accepted'] = Variable<String>(
        $NotificationStatusTable.$converterjsonProfileNameAccepted.toSql(
          jsonProfileNameAccepted,
        ),
      );
    }
    if (!nullToAbsent || jsonProfileNameRejected != null) {
      map['json_profile_name_rejected'] = Variable<String>(
        $NotificationStatusTable.$converterjsonProfileNameRejected.toSql(
          jsonProfileNameRejected,
        ),
      );
    }
    if (!nullToAbsent || jsonProfileTextAccepted != null) {
      map['json_profile_text_accepted'] = Variable<String>(
        $NotificationStatusTable.$converterjsonProfileTextAccepted.toSql(
          jsonProfileTextAccepted,
        ),
      );
    }
    if (!nullToAbsent || jsonProfileTextRejected != null) {
      map['json_profile_text_rejected'] = Variable<String>(
        $NotificationStatusTable.$converterjsonProfileTextRejected.toSql(
          jsonProfileTextRejected,
        ),
      );
    }
    return map;
  }

  NotificationStatusCompanion toCompanion(bool nullToAbsent) {
    return NotificationStatusCompanion(
      id: Value(id),
      jsonAutomaticProfileSearchFoundProfiles:
          jsonAutomaticProfileSearchFoundProfiles == null && nullToAbsent
          ? const Value.absent()
          : Value(jsonAutomaticProfileSearchFoundProfiles),
      jsonMediaContentAccepted: jsonMediaContentAccepted == null && nullToAbsent
          ? const Value.absent()
          : Value(jsonMediaContentAccepted),
      jsonMediaContentRejected: jsonMediaContentRejected == null && nullToAbsent
          ? const Value.absent()
          : Value(jsonMediaContentRejected),
      jsonMediaContentDeleted: jsonMediaContentDeleted == null && nullToAbsent
          ? const Value.absent()
          : Value(jsonMediaContentDeleted),
      jsonProfileNameAccepted: jsonProfileNameAccepted == null && nullToAbsent
          ? const Value.absent()
          : Value(jsonProfileNameAccepted),
      jsonProfileNameRejected: jsonProfileNameRejected == null && nullToAbsent
          ? const Value.absent()
          : Value(jsonProfileNameRejected),
      jsonProfileTextAccepted: jsonProfileTextAccepted == null && nullToAbsent
          ? const Value.absent()
          : Value(jsonProfileTextAccepted),
      jsonProfileTextRejected: jsonProfileTextRejected == null && nullToAbsent
          ? const Value.absent()
          : Value(jsonProfileTextRejected),
    );
  }

  factory NotificationStatusData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NotificationStatusData(
      id: serializer.fromJson<int>(json['id']),
      jsonAutomaticProfileSearchFoundProfiles: serializer
          .fromJson<JsonObject<NotificationStatus>?>(
            json['jsonAutomaticProfileSearchFoundProfiles'],
          ),
      jsonMediaContentAccepted: serializer
          .fromJson<JsonObject<NotificationStatus>?>(
            json['jsonMediaContentAccepted'],
          ),
      jsonMediaContentRejected: serializer
          .fromJson<JsonObject<NotificationStatus>?>(
            json['jsonMediaContentRejected'],
          ),
      jsonMediaContentDeleted: serializer
          .fromJson<JsonObject<NotificationStatus>?>(
            json['jsonMediaContentDeleted'],
          ),
      jsonProfileNameAccepted: serializer
          .fromJson<JsonObject<NotificationStatus>?>(
            json['jsonProfileNameAccepted'],
          ),
      jsonProfileNameRejected: serializer
          .fromJson<JsonObject<NotificationStatus>?>(
            json['jsonProfileNameRejected'],
          ),
      jsonProfileTextAccepted: serializer
          .fromJson<JsonObject<NotificationStatus>?>(
            json['jsonProfileTextAccepted'],
          ),
      jsonProfileTextRejected: serializer
          .fromJson<JsonObject<NotificationStatus>?>(
            json['jsonProfileTextRejected'],
          ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'jsonAutomaticProfileSearchFoundProfiles': serializer
          .toJson<JsonObject<NotificationStatus>?>(
            jsonAutomaticProfileSearchFoundProfiles,
          ),
      'jsonMediaContentAccepted': serializer
          .toJson<JsonObject<NotificationStatus>?>(jsonMediaContentAccepted),
      'jsonMediaContentRejected': serializer
          .toJson<JsonObject<NotificationStatus>?>(jsonMediaContentRejected),
      'jsonMediaContentDeleted': serializer
          .toJson<JsonObject<NotificationStatus>?>(jsonMediaContentDeleted),
      'jsonProfileNameAccepted': serializer
          .toJson<JsonObject<NotificationStatus>?>(jsonProfileNameAccepted),
      'jsonProfileNameRejected': serializer
          .toJson<JsonObject<NotificationStatus>?>(jsonProfileNameRejected),
      'jsonProfileTextAccepted': serializer
          .toJson<JsonObject<NotificationStatus>?>(jsonProfileTextAccepted),
      'jsonProfileTextRejected': serializer
          .toJson<JsonObject<NotificationStatus>?>(jsonProfileTextRejected),
    };
  }

  NotificationStatusData copyWith({
    int? id,
    Value<JsonObject<NotificationStatus>?>
        jsonAutomaticProfileSearchFoundProfiles =
        const Value.absent(),
    Value<JsonObject<NotificationStatus>?> jsonMediaContentAccepted =
        const Value.absent(),
    Value<JsonObject<NotificationStatus>?> jsonMediaContentRejected =
        const Value.absent(),
    Value<JsonObject<NotificationStatus>?> jsonMediaContentDeleted =
        const Value.absent(),
    Value<JsonObject<NotificationStatus>?> jsonProfileNameAccepted =
        const Value.absent(),
    Value<JsonObject<NotificationStatus>?> jsonProfileNameRejected =
        const Value.absent(),
    Value<JsonObject<NotificationStatus>?> jsonProfileTextAccepted =
        const Value.absent(),
    Value<JsonObject<NotificationStatus>?> jsonProfileTextRejected =
        const Value.absent(),
  }) => NotificationStatusData(
    id: id ?? this.id,
    jsonAutomaticProfileSearchFoundProfiles:
        jsonAutomaticProfileSearchFoundProfiles.present
        ? jsonAutomaticProfileSearchFoundProfiles.value
        : this.jsonAutomaticProfileSearchFoundProfiles,
    jsonMediaContentAccepted: jsonMediaContentAccepted.present
        ? jsonMediaContentAccepted.value
        : this.jsonMediaContentAccepted,
    jsonMediaContentRejected: jsonMediaContentRejected.present
        ? jsonMediaContentRejected.value
        : this.jsonMediaContentRejected,
    jsonMediaContentDeleted: jsonMediaContentDeleted.present
        ? jsonMediaContentDeleted.value
        : this.jsonMediaContentDeleted,
    jsonProfileNameAccepted: jsonProfileNameAccepted.present
        ? jsonProfileNameAccepted.value
        : this.jsonProfileNameAccepted,
    jsonProfileNameRejected: jsonProfileNameRejected.present
        ? jsonProfileNameRejected.value
        : this.jsonProfileNameRejected,
    jsonProfileTextAccepted: jsonProfileTextAccepted.present
        ? jsonProfileTextAccepted.value
        : this.jsonProfileTextAccepted,
    jsonProfileTextRejected: jsonProfileTextRejected.present
        ? jsonProfileTextRejected.value
        : this.jsonProfileTextRejected,
  );
  NotificationStatusData copyWithCompanion(NotificationStatusCompanion data) {
    return NotificationStatusData(
      id: data.id.present ? data.id.value : this.id,
      jsonAutomaticProfileSearchFoundProfiles:
          data.jsonAutomaticProfileSearchFoundProfiles.present
          ? data.jsonAutomaticProfileSearchFoundProfiles.value
          : this.jsonAutomaticProfileSearchFoundProfiles,
      jsonMediaContentAccepted: data.jsonMediaContentAccepted.present
          ? data.jsonMediaContentAccepted.value
          : this.jsonMediaContentAccepted,
      jsonMediaContentRejected: data.jsonMediaContentRejected.present
          ? data.jsonMediaContentRejected.value
          : this.jsonMediaContentRejected,
      jsonMediaContentDeleted: data.jsonMediaContentDeleted.present
          ? data.jsonMediaContentDeleted.value
          : this.jsonMediaContentDeleted,
      jsonProfileNameAccepted: data.jsonProfileNameAccepted.present
          ? data.jsonProfileNameAccepted.value
          : this.jsonProfileNameAccepted,
      jsonProfileNameRejected: data.jsonProfileNameRejected.present
          ? data.jsonProfileNameRejected.value
          : this.jsonProfileNameRejected,
      jsonProfileTextAccepted: data.jsonProfileTextAccepted.present
          ? data.jsonProfileTextAccepted.value
          : this.jsonProfileTextAccepted,
      jsonProfileTextRejected: data.jsonProfileTextRejected.present
          ? data.jsonProfileTextRejected.value
          : this.jsonProfileTextRejected,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NotificationStatusData(')
          ..write('id: $id, ')
          ..write(
            'jsonAutomaticProfileSearchFoundProfiles: $jsonAutomaticProfileSearchFoundProfiles, ',
          )
          ..write('jsonMediaContentAccepted: $jsonMediaContentAccepted, ')
          ..write('jsonMediaContentRejected: $jsonMediaContentRejected, ')
          ..write('jsonMediaContentDeleted: $jsonMediaContentDeleted, ')
          ..write('jsonProfileNameAccepted: $jsonProfileNameAccepted, ')
          ..write('jsonProfileNameRejected: $jsonProfileNameRejected, ')
          ..write('jsonProfileTextAccepted: $jsonProfileTextAccepted, ')
          ..write('jsonProfileTextRejected: $jsonProfileTextRejected')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    jsonAutomaticProfileSearchFoundProfiles,
    jsonMediaContentAccepted,
    jsonMediaContentRejected,
    jsonMediaContentDeleted,
    jsonProfileNameAccepted,
    jsonProfileNameRejected,
    jsonProfileTextAccepted,
    jsonProfileTextRejected,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NotificationStatusData &&
          other.id == this.id &&
          other.jsonAutomaticProfileSearchFoundProfiles ==
              this.jsonAutomaticProfileSearchFoundProfiles &&
          other.jsonMediaContentAccepted == this.jsonMediaContentAccepted &&
          other.jsonMediaContentRejected == this.jsonMediaContentRejected &&
          other.jsonMediaContentDeleted == this.jsonMediaContentDeleted &&
          other.jsonProfileNameAccepted == this.jsonProfileNameAccepted &&
          other.jsonProfileNameRejected == this.jsonProfileNameRejected &&
          other.jsonProfileTextAccepted == this.jsonProfileTextAccepted &&
          other.jsonProfileTextRejected == this.jsonProfileTextRejected);
}

class NotificationStatusCompanion
    extends UpdateCompanion<NotificationStatusData> {
  final Value<int> id;
  final Value<JsonObject<NotificationStatus>?>
  jsonAutomaticProfileSearchFoundProfiles;
  final Value<JsonObject<NotificationStatus>?> jsonMediaContentAccepted;
  final Value<JsonObject<NotificationStatus>?> jsonMediaContentRejected;
  final Value<JsonObject<NotificationStatus>?> jsonMediaContentDeleted;
  final Value<JsonObject<NotificationStatus>?> jsonProfileNameAccepted;
  final Value<JsonObject<NotificationStatus>?> jsonProfileNameRejected;
  final Value<JsonObject<NotificationStatus>?> jsonProfileTextAccepted;
  final Value<JsonObject<NotificationStatus>?> jsonProfileTextRejected;
  const NotificationStatusCompanion({
    this.id = const Value.absent(),
    this.jsonAutomaticProfileSearchFoundProfiles = const Value.absent(),
    this.jsonMediaContentAccepted = const Value.absent(),
    this.jsonMediaContentRejected = const Value.absent(),
    this.jsonMediaContentDeleted = const Value.absent(),
    this.jsonProfileNameAccepted = const Value.absent(),
    this.jsonProfileNameRejected = const Value.absent(),
    this.jsonProfileTextAccepted = const Value.absent(),
    this.jsonProfileTextRejected = const Value.absent(),
  });
  NotificationStatusCompanion.insert({
    this.id = const Value.absent(),
    this.jsonAutomaticProfileSearchFoundProfiles = const Value.absent(),
    this.jsonMediaContentAccepted = const Value.absent(),
    this.jsonMediaContentRejected = const Value.absent(),
    this.jsonMediaContentDeleted = const Value.absent(),
    this.jsonProfileNameAccepted = const Value.absent(),
    this.jsonProfileNameRejected = const Value.absent(),
    this.jsonProfileTextAccepted = const Value.absent(),
    this.jsonProfileTextRejected = const Value.absent(),
  });
  static Insertable<NotificationStatusData> custom({
    Expression<int>? id,
    Expression<String>? jsonAutomaticProfileSearchFoundProfiles,
    Expression<String>? jsonMediaContentAccepted,
    Expression<String>? jsonMediaContentRejected,
    Expression<String>? jsonMediaContentDeleted,
    Expression<String>? jsonProfileNameAccepted,
    Expression<String>? jsonProfileNameRejected,
    Expression<String>? jsonProfileTextAccepted,
    Expression<String>? jsonProfileTextRejected,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (jsonAutomaticProfileSearchFoundProfiles != null)
        'json_automatic_profile_search_found_profiles':
            jsonAutomaticProfileSearchFoundProfiles,
      if (jsonMediaContentAccepted != null)
        'json_media_content_accepted': jsonMediaContentAccepted,
      if (jsonMediaContentRejected != null)
        'json_media_content_rejected': jsonMediaContentRejected,
      if (jsonMediaContentDeleted != null)
        'json_media_content_deleted': jsonMediaContentDeleted,
      if (jsonProfileNameAccepted != null)
        'json_profile_name_accepted': jsonProfileNameAccepted,
      if (jsonProfileNameRejected != null)
        'json_profile_name_rejected': jsonProfileNameRejected,
      if (jsonProfileTextAccepted != null)
        'json_profile_text_accepted': jsonProfileTextAccepted,
      if (jsonProfileTextRejected != null)
        'json_profile_text_rejected': jsonProfileTextRejected,
    });
  }

  NotificationStatusCompanion copyWith({
    Value<int>? id,
    Value<JsonObject<NotificationStatus>?>?
    jsonAutomaticProfileSearchFoundProfiles,
    Value<JsonObject<NotificationStatus>?>? jsonMediaContentAccepted,
    Value<JsonObject<NotificationStatus>?>? jsonMediaContentRejected,
    Value<JsonObject<NotificationStatus>?>? jsonMediaContentDeleted,
    Value<JsonObject<NotificationStatus>?>? jsonProfileNameAccepted,
    Value<JsonObject<NotificationStatus>?>? jsonProfileNameRejected,
    Value<JsonObject<NotificationStatus>?>? jsonProfileTextAccepted,
    Value<JsonObject<NotificationStatus>?>? jsonProfileTextRejected,
  }) {
    return NotificationStatusCompanion(
      id: id ?? this.id,
      jsonAutomaticProfileSearchFoundProfiles:
          jsonAutomaticProfileSearchFoundProfiles ??
          this.jsonAutomaticProfileSearchFoundProfiles,
      jsonMediaContentAccepted:
          jsonMediaContentAccepted ?? this.jsonMediaContentAccepted,
      jsonMediaContentRejected:
          jsonMediaContentRejected ?? this.jsonMediaContentRejected,
      jsonMediaContentDeleted:
          jsonMediaContentDeleted ?? this.jsonMediaContentDeleted,
      jsonProfileNameAccepted:
          jsonProfileNameAccepted ?? this.jsonProfileNameAccepted,
      jsonProfileNameRejected:
          jsonProfileNameRejected ?? this.jsonProfileNameRejected,
      jsonProfileTextAccepted:
          jsonProfileTextAccepted ?? this.jsonProfileTextAccepted,
      jsonProfileTextRejected:
          jsonProfileTextRejected ?? this.jsonProfileTextRejected,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (jsonAutomaticProfileSearchFoundProfiles.present) {
      map['json_automatic_profile_search_found_profiles'] = Variable<String>(
        $NotificationStatusTable
            .$converterjsonAutomaticProfileSearchFoundProfiles
            .toSql(jsonAutomaticProfileSearchFoundProfiles.value),
      );
    }
    if (jsonMediaContentAccepted.present) {
      map['json_media_content_accepted'] = Variable<String>(
        $NotificationStatusTable.$converterjsonMediaContentAccepted.toSql(
          jsonMediaContentAccepted.value,
        ),
      );
    }
    if (jsonMediaContentRejected.present) {
      map['json_media_content_rejected'] = Variable<String>(
        $NotificationStatusTable.$converterjsonMediaContentRejected.toSql(
          jsonMediaContentRejected.value,
        ),
      );
    }
    if (jsonMediaContentDeleted.present) {
      map['json_media_content_deleted'] = Variable<String>(
        $NotificationStatusTable.$converterjsonMediaContentDeleted.toSql(
          jsonMediaContentDeleted.value,
        ),
      );
    }
    if (jsonProfileNameAccepted.present) {
      map['json_profile_name_accepted'] = Variable<String>(
        $NotificationStatusTable.$converterjsonProfileNameAccepted.toSql(
          jsonProfileNameAccepted.value,
        ),
      );
    }
    if (jsonProfileNameRejected.present) {
      map['json_profile_name_rejected'] = Variable<String>(
        $NotificationStatusTable.$converterjsonProfileNameRejected.toSql(
          jsonProfileNameRejected.value,
        ),
      );
    }
    if (jsonProfileTextAccepted.present) {
      map['json_profile_text_accepted'] = Variable<String>(
        $NotificationStatusTable.$converterjsonProfileTextAccepted.toSql(
          jsonProfileTextAccepted.value,
        ),
      );
    }
    if (jsonProfileTextRejected.present) {
      map['json_profile_text_rejected'] = Variable<String>(
        $NotificationStatusTable.$converterjsonProfileTextRejected.toSql(
          jsonProfileTextRejected.value,
        ),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotificationStatusCompanion(')
          ..write('id: $id, ')
          ..write(
            'jsonAutomaticProfileSearchFoundProfiles: $jsonAutomaticProfileSearchFoundProfiles, ',
          )
          ..write('jsonMediaContentAccepted: $jsonMediaContentAccepted, ')
          ..write('jsonMediaContentRejected: $jsonMediaContentRejected, ')
          ..write('jsonMediaContentDeleted: $jsonMediaContentDeleted, ')
          ..write('jsonProfileNameAccepted: $jsonProfileNameAccepted, ')
          ..write('jsonProfileNameRejected: $jsonProfileNameRejected, ')
          ..write('jsonProfileTextAccepted: $jsonProfileTextAccepted, ')
          ..write('jsonProfileTextRejected: $jsonProfileTextRejected')
          ..write(')'))
        .toString();
  }
}

class $NewsTable extends schema.News with TableInfo<$NewsTable, New> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NewsTable(this.attachedDatabase, [this._alias]);
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
  late final GeneratedColumnWithTypeConverter<UnreadNewsCount?, int> newsCount =
      GeneratedColumn<int>(
        'news_count',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      ).withConverter<UnreadNewsCount?>($NewsTable.$converternewsCount);
  static const VerificationMeta _syncVersionNewsMeta = const VerificationMeta(
    'syncVersionNews',
  );
  @override
  late final GeneratedColumn<int> syncVersionNews = GeneratedColumn<int>(
    'sync_version_news',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, newsCount, syncVersionNews];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'news';
  @override
  VerificationContext validateIntegrity(
    Insertable<New> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('sync_version_news')) {
      context.handle(
        _syncVersionNewsMeta,
        syncVersionNews.isAcceptableOrUnknown(
          data['sync_version_news']!,
          _syncVersionNewsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  New map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return New(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      newsCount: $NewsTable.$converternewsCount.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}news_count'],
        ),
      ),
      syncVersionNews: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sync_version_news'],
      ),
    );
  }

  @override
  $NewsTable createAlias(String alias) {
    return $NewsTable(attachedDatabase, alias);
  }

  static TypeConverter<UnreadNewsCount?, int?> $converternewsCount =
      const NullAwareTypeConverter.wrap(UnreadNewsCountConverter());
}

class New extends DataClass implements Insertable<New> {
  final int id;
  final UnreadNewsCount? newsCount;
  final int? syncVersionNews;
  const New({required this.id, this.newsCount, this.syncVersionNews});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || newsCount != null) {
      map['news_count'] = Variable<int>(
        $NewsTable.$converternewsCount.toSql(newsCount),
      );
    }
    if (!nullToAbsent || syncVersionNews != null) {
      map['sync_version_news'] = Variable<int>(syncVersionNews);
    }
    return map;
  }

  NewsCompanion toCompanion(bool nullToAbsent) {
    return NewsCompanion(
      id: Value(id),
      newsCount: newsCount == null && nullToAbsent
          ? const Value.absent()
          : Value(newsCount),
      syncVersionNews: syncVersionNews == null && nullToAbsent
          ? const Value.absent()
          : Value(syncVersionNews),
    );
  }

  factory New.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return New(
      id: serializer.fromJson<int>(json['id']),
      newsCount: serializer.fromJson<UnreadNewsCount?>(json['newsCount']),
      syncVersionNews: serializer.fromJson<int?>(json['syncVersionNews']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'newsCount': serializer.toJson<UnreadNewsCount?>(newsCount),
      'syncVersionNews': serializer.toJson<int?>(syncVersionNews),
    };
  }

  New copyWith({
    int? id,
    Value<UnreadNewsCount?> newsCount = const Value.absent(),
    Value<int?> syncVersionNews = const Value.absent(),
  }) => New(
    id: id ?? this.id,
    newsCount: newsCount.present ? newsCount.value : this.newsCount,
    syncVersionNews: syncVersionNews.present
        ? syncVersionNews.value
        : this.syncVersionNews,
  );
  New copyWithCompanion(NewsCompanion data) {
    return New(
      id: data.id.present ? data.id.value : this.id,
      newsCount: data.newsCount.present ? data.newsCount.value : this.newsCount,
      syncVersionNews: data.syncVersionNews.present
          ? data.syncVersionNews.value
          : this.syncVersionNews,
    );
  }

  @override
  String toString() {
    return (StringBuffer('New(')
          ..write('id: $id, ')
          ..write('newsCount: $newsCount, ')
          ..write('syncVersionNews: $syncVersionNews')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, newsCount, syncVersionNews);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is New &&
          other.id == this.id &&
          other.newsCount == this.newsCount &&
          other.syncVersionNews == this.syncVersionNews);
}

class NewsCompanion extends UpdateCompanion<New> {
  final Value<int> id;
  final Value<UnreadNewsCount?> newsCount;
  final Value<int?> syncVersionNews;
  const NewsCompanion({
    this.id = const Value.absent(),
    this.newsCount = const Value.absent(),
    this.syncVersionNews = const Value.absent(),
  });
  NewsCompanion.insert({
    this.id = const Value.absent(),
    this.newsCount = const Value.absent(),
    this.syncVersionNews = const Value.absent(),
  });
  static Insertable<New> custom({
    Expression<int>? id,
    Expression<int>? newsCount,
    Expression<int>? syncVersionNews,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (newsCount != null) 'news_count': newsCount,
      if (syncVersionNews != null) 'sync_version_news': syncVersionNews,
    });
  }

  NewsCompanion copyWith({
    Value<int>? id,
    Value<UnreadNewsCount?>? newsCount,
    Value<int?>? syncVersionNews,
  }) {
    return NewsCompanion(
      id: id ?? this.id,
      newsCount: newsCount ?? this.newsCount,
      syncVersionNews: syncVersionNews ?? this.syncVersionNews,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (newsCount.present) {
      map['news_count'] = Variable<int>(
        $NewsTable.$converternewsCount.toSql(newsCount.value),
      );
    }
    if (syncVersionNews.present) {
      map['sync_version_news'] = Variable<int>(syncVersionNews.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NewsCompanion(')
          ..write('id: $id, ')
          ..write('newsCount: $newsCount, ')
          ..write('syncVersionNews: $syncVersionNews')
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
  late final GeneratedColumnWithTypeConverter<
    PushNotificationDeviceToken?,
    String
  >
  pushNotificationDeviceToken =
      GeneratedColumn<String>(
        'push_notification_device_token',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<PushNotificationDeviceToken?>(
        $PushNotificationTable.$converterpushNotificationDeviceToken,
      );
  @override
  late final GeneratedColumnWithTypeConverter<VapidPublicKey?, String>
  vapidPublicKey =
      GeneratedColumn<String>(
        'vapid_public_key',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<VapidPublicKey?>(
        $PushNotificationTable.$convertervapidPublicKey,
      );
  static const VerificationMeta _syncVersionPushNotificationInfoMeta =
      const VerificationMeta('syncVersionPushNotificationInfo');
  @override
  late final GeneratedColumn<int> syncVersionPushNotificationInfo =
      GeneratedColumn<int>(
        'sync_version_push_notification_info',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    pushNotificationDeviceToken,
    vapidPublicKey,
    syncVersionPushNotificationInfo,
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
    if (data.containsKey('sync_version_push_notification_info')) {
      context.handle(
        _syncVersionPushNotificationInfoMeta,
        syncVersionPushNotificationInfo.isAcceptableOrUnknown(
          data['sync_version_push_notification_info']!,
          _syncVersionPushNotificationInfoMeta,
        ),
      );
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
      pushNotificationDeviceToken: $PushNotificationTable
          .$converterpushNotificationDeviceToken
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}push_notification_device_token'],
            ),
          ),
      vapidPublicKey: $PushNotificationTable.$convertervapidPublicKey.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}vapid_public_key'],
        ),
      ),
      syncVersionPushNotificationInfo: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sync_version_push_notification_info'],
      ),
    );
  }

  @override
  $PushNotificationTable createAlias(String alias) {
    return $PushNotificationTable(attachedDatabase, alias);
  }

  static TypeConverter<PushNotificationDeviceToken?, String?>
  $converterpushNotificationDeviceToken = const NullAwareTypeConverter.wrap(
    PushNotificationDeviceTokenConverter(),
  );
  static TypeConverter<VapidPublicKey?, String?> $convertervapidPublicKey =
      const NullAwareTypeConverter.wrap(VapidPublicKeyConverter());
}

class PushNotificationData extends DataClass
    implements Insertable<PushNotificationData> {
  final int id;
  final PushNotificationDeviceToken? pushNotificationDeviceToken;
  final VapidPublicKey? vapidPublicKey;
  final int? syncVersionPushNotificationInfo;
  const PushNotificationData({
    required this.id,
    this.pushNotificationDeviceToken,
    this.vapidPublicKey,
    this.syncVersionPushNotificationInfo,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || pushNotificationDeviceToken != null) {
      map['push_notification_device_token'] = Variable<String>(
        $PushNotificationTable.$converterpushNotificationDeviceToken.toSql(
          pushNotificationDeviceToken,
        ),
      );
    }
    if (!nullToAbsent || vapidPublicKey != null) {
      map['vapid_public_key'] = Variable<String>(
        $PushNotificationTable.$convertervapidPublicKey.toSql(vapidPublicKey),
      );
    }
    if (!nullToAbsent || syncVersionPushNotificationInfo != null) {
      map['sync_version_push_notification_info'] = Variable<int>(
        syncVersionPushNotificationInfo,
      );
    }
    return map;
  }

  PushNotificationCompanion toCompanion(bool nullToAbsent) {
    return PushNotificationCompanion(
      id: Value(id),
      pushNotificationDeviceToken:
          pushNotificationDeviceToken == null && nullToAbsent
          ? const Value.absent()
          : Value(pushNotificationDeviceToken),
      vapidPublicKey: vapidPublicKey == null && nullToAbsent
          ? const Value.absent()
          : Value(vapidPublicKey),
      syncVersionPushNotificationInfo:
          syncVersionPushNotificationInfo == null && nullToAbsent
          ? const Value.absent()
          : Value(syncVersionPushNotificationInfo),
    );
  }

  factory PushNotificationData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PushNotificationData(
      id: serializer.fromJson<int>(json['id']),
      pushNotificationDeviceToken: serializer
          .fromJson<PushNotificationDeviceToken?>(
            json['pushNotificationDeviceToken'],
          ),
      vapidPublicKey: serializer.fromJson<VapidPublicKey?>(
        json['vapidPublicKey'],
      ),
      syncVersionPushNotificationInfo: serializer.fromJson<int?>(
        json['syncVersionPushNotificationInfo'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'pushNotificationDeviceToken': serializer
          .toJson<PushNotificationDeviceToken?>(pushNotificationDeviceToken),
      'vapidPublicKey': serializer.toJson<VapidPublicKey?>(vapidPublicKey),
      'syncVersionPushNotificationInfo': serializer.toJson<int?>(
        syncVersionPushNotificationInfo,
      ),
    };
  }

  PushNotificationData copyWith({
    int? id,
    Value<PushNotificationDeviceToken?> pushNotificationDeviceToken =
        const Value.absent(),
    Value<VapidPublicKey?> vapidPublicKey = const Value.absent(),
    Value<int?> syncVersionPushNotificationInfo = const Value.absent(),
  }) => PushNotificationData(
    id: id ?? this.id,
    pushNotificationDeviceToken: pushNotificationDeviceToken.present
        ? pushNotificationDeviceToken.value
        : this.pushNotificationDeviceToken,
    vapidPublicKey: vapidPublicKey.present
        ? vapidPublicKey.value
        : this.vapidPublicKey,
    syncVersionPushNotificationInfo: syncVersionPushNotificationInfo.present
        ? syncVersionPushNotificationInfo.value
        : this.syncVersionPushNotificationInfo,
  );
  PushNotificationData copyWithCompanion(PushNotificationCompanion data) {
    return PushNotificationData(
      id: data.id.present ? data.id.value : this.id,
      pushNotificationDeviceToken: data.pushNotificationDeviceToken.present
          ? data.pushNotificationDeviceToken.value
          : this.pushNotificationDeviceToken,
      vapidPublicKey: data.vapidPublicKey.present
          ? data.vapidPublicKey.value
          : this.vapidPublicKey,
      syncVersionPushNotificationInfo:
          data.syncVersionPushNotificationInfo.present
          ? data.syncVersionPushNotificationInfo.value
          : this.syncVersionPushNotificationInfo,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PushNotificationData(')
          ..write('id: $id, ')
          ..write('pushNotificationDeviceToken: $pushNotificationDeviceToken, ')
          ..write('vapidPublicKey: $vapidPublicKey, ')
          ..write(
            'syncVersionPushNotificationInfo: $syncVersionPushNotificationInfo',
          )
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    pushNotificationDeviceToken,
    vapidPublicKey,
    syncVersionPushNotificationInfo,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PushNotificationData &&
          other.id == this.id &&
          other.pushNotificationDeviceToken ==
              this.pushNotificationDeviceToken &&
          other.vapidPublicKey == this.vapidPublicKey &&
          other.syncVersionPushNotificationInfo ==
              this.syncVersionPushNotificationInfo);
}

class PushNotificationCompanion extends UpdateCompanion<PushNotificationData> {
  final Value<int> id;
  final Value<PushNotificationDeviceToken?> pushNotificationDeviceToken;
  final Value<VapidPublicKey?> vapidPublicKey;
  final Value<int?> syncVersionPushNotificationInfo;
  const PushNotificationCompanion({
    this.id = const Value.absent(),
    this.pushNotificationDeviceToken = const Value.absent(),
    this.vapidPublicKey = const Value.absent(),
    this.syncVersionPushNotificationInfo = const Value.absent(),
  });
  PushNotificationCompanion.insert({
    this.id = const Value.absent(),
    this.pushNotificationDeviceToken = const Value.absent(),
    this.vapidPublicKey = const Value.absent(),
    this.syncVersionPushNotificationInfo = const Value.absent(),
  });
  static Insertable<PushNotificationData> custom({
    Expression<int>? id,
    Expression<String>? pushNotificationDeviceToken,
    Expression<String>? vapidPublicKey,
    Expression<int>? syncVersionPushNotificationInfo,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (pushNotificationDeviceToken != null)
        'push_notification_device_token': pushNotificationDeviceToken,
      if (vapidPublicKey != null) 'vapid_public_key': vapidPublicKey,
      if (syncVersionPushNotificationInfo != null)
        'sync_version_push_notification_info': syncVersionPushNotificationInfo,
    });
  }

  PushNotificationCompanion copyWith({
    Value<int>? id,
    Value<PushNotificationDeviceToken?>? pushNotificationDeviceToken,
    Value<VapidPublicKey?>? vapidPublicKey,
    Value<int?>? syncVersionPushNotificationInfo,
  }) {
    return PushNotificationCompanion(
      id: id ?? this.id,
      pushNotificationDeviceToken:
          pushNotificationDeviceToken ?? this.pushNotificationDeviceToken,
      vapidPublicKey: vapidPublicKey ?? this.vapidPublicKey,
      syncVersionPushNotificationInfo:
          syncVersionPushNotificationInfo ??
          this.syncVersionPushNotificationInfo,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (pushNotificationDeviceToken.present) {
      map['push_notification_device_token'] = Variable<String>(
        $PushNotificationTable.$converterpushNotificationDeviceToken.toSql(
          pushNotificationDeviceToken.value,
        ),
      );
    }
    if (vapidPublicKey.present) {
      map['vapid_public_key'] = Variable<String>(
        $PushNotificationTable.$convertervapidPublicKey.toSql(
          vapidPublicKey.value,
        ),
      );
    }
    if (syncVersionPushNotificationInfo.present) {
      map['sync_version_push_notification_info'] = Variable<int>(
        syncVersionPushNotificationInfo.value,
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PushNotificationCompanion(')
          ..write('id: $id, ')
          ..write('pushNotificationDeviceToken: $pushNotificationDeviceToken, ')
          ..write('vapidPublicKey: $vapidPublicKey, ')
          ..write(
            'syncVersionPushNotificationInfo: $syncVersionPushNotificationInfo',
          )
          ..write(')'))
        .toString();
  }
}

class $ServerMaintenanceTable extends schema.ServerMaintenance
    with TableInfo<$ServerMaintenanceTable, ServerMaintenanceData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ServerMaintenanceTable(this.attachedDatabase, [this._alias]);
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
  late final GeneratedColumnWithTypeConverter<UtcDateTime?, int> startTime =
      GeneratedColumn<int>(
        'start_time',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      ).withConverter<UtcDateTime?>(
        $ServerMaintenanceTable.$converterstartTime,
      );
  @override
  late final GeneratedColumnWithTypeConverter<UtcDateTime?, int> endTime =
      GeneratedColumn<int>(
        'end_time',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      ).withConverter<UtcDateTime?>($ServerMaintenanceTable.$converterendTime);
  @override
  late final GeneratedColumnWithTypeConverter<UtcDateTime?, int> infoViewed =
      GeneratedColumn<int>(
        'info_viewed',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      ).withConverter<UtcDateTime?>(
        $ServerMaintenanceTable.$converterinfoViewed,
      );
  @override
  List<GeneratedColumn> get $columns => [id, startTime, endTime, infoViewed];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'server_maintenance';
  @override
  VerificationContext validateIntegrity(
    Insertable<ServerMaintenanceData> instance, {
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
  ServerMaintenanceData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ServerMaintenanceData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      startTime: $ServerMaintenanceTable.$converterstartTime.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}start_time'],
        ),
      ),
      endTime: $ServerMaintenanceTable.$converterendTime.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}end_time'],
        ),
      ),
      infoViewed: $ServerMaintenanceTable.$converterinfoViewed.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}info_viewed'],
        ),
      ),
    );
  }

  @override
  $ServerMaintenanceTable createAlias(String alias) {
    return $ServerMaintenanceTable(attachedDatabase, alias);
  }

  static TypeConverter<UtcDateTime?, int?> $converterstartTime =
      const NullAwareTypeConverter.wrap(UtcDateTimeConverter());
  static TypeConverter<UtcDateTime?, int?> $converterendTime =
      const NullAwareTypeConverter.wrap(UtcDateTimeConverter());
  static TypeConverter<UtcDateTime?, int?> $converterinfoViewed =
      const NullAwareTypeConverter.wrap(UtcDateTimeConverter());
}

class ServerMaintenanceData extends DataClass
    implements Insertable<ServerMaintenanceData> {
  final int id;
  final UtcDateTime? startTime;
  final UtcDateTime? endTime;
  final UtcDateTime? infoViewed;
  const ServerMaintenanceData({
    required this.id,
    this.startTime,
    this.endTime,
    this.infoViewed,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || startTime != null) {
      map['start_time'] = Variable<int>(
        $ServerMaintenanceTable.$converterstartTime.toSql(startTime),
      );
    }
    if (!nullToAbsent || endTime != null) {
      map['end_time'] = Variable<int>(
        $ServerMaintenanceTable.$converterendTime.toSql(endTime),
      );
    }
    if (!nullToAbsent || infoViewed != null) {
      map['info_viewed'] = Variable<int>(
        $ServerMaintenanceTable.$converterinfoViewed.toSql(infoViewed),
      );
    }
    return map;
  }

  ServerMaintenanceCompanion toCompanion(bool nullToAbsent) {
    return ServerMaintenanceCompanion(
      id: Value(id),
      startTime: startTime == null && nullToAbsent
          ? const Value.absent()
          : Value(startTime),
      endTime: endTime == null && nullToAbsent
          ? const Value.absent()
          : Value(endTime),
      infoViewed: infoViewed == null && nullToAbsent
          ? const Value.absent()
          : Value(infoViewed),
    );
  }

  factory ServerMaintenanceData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ServerMaintenanceData(
      id: serializer.fromJson<int>(json['id']),
      startTime: serializer.fromJson<UtcDateTime?>(json['startTime']),
      endTime: serializer.fromJson<UtcDateTime?>(json['endTime']),
      infoViewed: serializer.fromJson<UtcDateTime?>(json['infoViewed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'startTime': serializer.toJson<UtcDateTime?>(startTime),
      'endTime': serializer.toJson<UtcDateTime?>(endTime),
      'infoViewed': serializer.toJson<UtcDateTime?>(infoViewed),
    };
  }

  ServerMaintenanceData copyWith({
    int? id,
    Value<UtcDateTime?> startTime = const Value.absent(),
    Value<UtcDateTime?> endTime = const Value.absent(),
    Value<UtcDateTime?> infoViewed = const Value.absent(),
  }) => ServerMaintenanceData(
    id: id ?? this.id,
    startTime: startTime.present ? startTime.value : this.startTime,
    endTime: endTime.present ? endTime.value : this.endTime,
    infoViewed: infoViewed.present ? infoViewed.value : this.infoViewed,
  );
  ServerMaintenanceData copyWithCompanion(ServerMaintenanceCompanion data) {
    return ServerMaintenanceData(
      id: data.id.present ? data.id.value : this.id,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
      infoViewed: data.infoViewed.present
          ? data.infoViewed.value
          : this.infoViewed,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ServerMaintenanceData(')
          ..write('id: $id, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('infoViewed: $infoViewed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, startTime, endTime, infoViewed);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ServerMaintenanceData &&
          other.id == this.id &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.infoViewed == this.infoViewed);
}

class ServerMaintenanceCompanion
    extends UpdateCompanion<ServerMaintenanceData> {
  final Value<int> id;
  final Value<UtcDateTime?> startTime;
  final Value<UtcDateTime?> endTime;
  final Value<UtcDateTime?> infoViewed;
  const ServerMaintenanceCompanion({
    this.id = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.infoViewed = const Value.absent(),
  });
  ServerMaintenanceCompanion.insert({
    this.id = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.infoViewed = const Value.absent(),
  });
  static Insertable<ServerMaintenanceData> custom({
    Expression<int>? id,
    Expression<int>? startTime,
    Expression<int>? endTime,
    Expression<int>? infoViewed,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (infoViewed != null) 'info_viewed': infoViewed,
    });
  }

  ServerMaintenanceCompanion copyWith({
    Value<int>? id,
    Value<UtcDateTime?>? startTime,
    Value<UtcDateTime?>? endTime,
    Value<UtcDateTime?>? infoViewed,
  }) {
    return ServerMaintenanceCompanion(
      id: id ?? this.id,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      infoViewed: infoViewed ?? this.infoViewed,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<int>(
        $ServerMaintenanceTable.$converterstartTime.toSql(startTime.value),
      );
    }
    if (endTime.present) {
      map['end_time'] = Variable<int>(
        $ServerMaintenanceTable.$converterendTime.toSql(endTime.value),
      );
    }
    if (infoViewed.present) {
      map['info_viewed'] = Variable<int>(
        $ServerMaintenanceTable.$converterinfoViewed.toSql(infoViewed.value),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ServerMaintenanceCompanion(')
          ..write('id: $id, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('infoViewed: $infoViewed')
          ..write(')'))
        .toString();
  }
}

class $SyncVersionTable extends schema.SyncVersion
    with TableInfo<$SyncVersionTable, SyncVersionData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncVersionTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _syncVersionAccountMeta =
      const VerificationMeta('syncVersionAccount');
  @override
  late final GeneratedColumn<int> syncVersionAccount = GeneratedColumn<int>(
    'sync_version_account',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncVersionProfileMeta =
      const VerificationMeta('syncVersionProfile');
  @override
  late final GeneratedColumn<int> syncVersionProfile = GeneratedColumn<int>(
    'sync_version_profile',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncVersionMediaContentMeta =
      const VerificationMeta('syncVersionMediaContent');
  @override
  late final GeneratedColumn<int> syncVersionMediaContent =
      GeneratedColumn<int>(
        'sync_version_media_content',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _syncVersionClientConfigMeta =
      const VerificationMeta('syncVersionClientConfig');
  @override
  late final GeneratedColumn<int> syncVersionClientConfig =
      GeneratedColumn<int>(
        'sync_version_client_config',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    syncVersionAccount,
    syncVersionProfile,
    syncVersionMediaContent,
    syncVersionClientConfig,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_version';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncVersionData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('sync_version_account')) {
      context.handle(
        _syncVersionAccountMeta,
        syncVersionAccount.isAcceptableOrUnknown(
          data['sync_version_account']!,
          _syncVersionAccountMeta,
        ),
      );
    }
    if (data.containsKey('sync_version_profile')) {
      context.handle(
        _syncVersionProfileMeta,
        syncVersionProfile.isAcceptableOrUnknown(
          data['sync_version_profile']!,
          _syncVersionProfileMeta,
        ),
      );
    }
    if (data.containsKey('sync_version_media_content')) {
      context.handle(
        _syncVersionMediaContentMeta,
        syncVersionMediaContent.isAcceptableOrUnknown(
          data['sync_version_media_content']!,
          _syncVersionMediaContentMeta,
        ),
      );
    }
    if (data.containsKey('sync_version_client_config')) {
      context.handle(
        _syncVersionClientConfigMeta,
        syncVersionClientConfig.isAcceptableOrUnknown(
          data['sync_version_client_config']!,
          _syncVersionClientConfigMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncVersionData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncVersionData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      syncVersionAccount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sync_version_account'],
      ),
      syncVersionProfile: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sync_version_profile'],
      ),
      syncVersionMediaContent: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sync_version_media_content'],
      ),
      syncVersionClientConfig: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sync_version_client_config'],
      ),
    );
  }

  @override
  $SyncVersionTable createAlias(String alias) {
    return $SyncVersionTable(attachedDatabase, alias);
  }
}

class SyncVersionData extends DataClass implements Insertable<SyncVersionData> {
  final int id;
  final int? syncVersionAccount;
  final int? syncVersionProfile;
  final int? syncVersionMediaContent;
  final int? syncVersionClientConfig;
  const SyncVersionData({
    required this.id,
    this.syncVersionAccount,
    this.syncVersionProfile,
    this.syncVersionMediaContent,
    this.syncVersionClientConfig,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || syncVersionAccount != null) {
      map['sync_version_account'] = Variable<int>(syncVersionAccount);
    }
    if (!nullToAbsent || syncVersionProfile != null) {
      map['sync_version_profile'] = Variable<int>(syncVersionProfile);
    }
    if (!nullToAbsent || syncVersionMediaContent != null) {
      map['sync_version_media_content'] = Variable<int>(
        syncVersionMediaContent,
      );
    }
    if (!nullToAbsent || syncVersionClientConfig != null) {
      map['sync_version_client_config'] = Variable<int>(
        syncVersionClientConfig,
      );
    }
    return map;
  }

  SyncVersionCompanion toCompanion(bool nullToAbsent) {
    return SyncVersionCompanion(
      id: Value(id),
      syncVersionAccount: syncVersionAccount == null && nullToAbsent
          ? const Value.absent()
          : Value(syncVersionAccount),
      syncVersionProfile: syncVersionProfile == null && nullToAbsent
          ? const Value.absent()
          : Value(syncVersionProfile),
      syncVersionMediaContent: syncVersionMediaContent == null && nullToAbsent
          ? const Value.absent()
          : Value(syncVersionMediaContent),
      syncVersionClientConfig: syncVersionClientConfig == null && nullToAbsent
          ? const Value.absent()
          : Value(syncVersionClientConfig),
    );
  }

  factory SyncVersionData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncVersionData(
      id: serializer.fromJson<int>(json['id']),
      syncVersionAccount: serializer.fromJson<int?>(json['syncVersionAccount']),
      syncVersionProfile: serializer.fromJson<int?>(json['syncVersionProfile']),
      syncVersionMediaContent: serializer.fromJson<int?>(
        json['syncVersionMediaContent'],
      ),
      syncVersionClientConfig: serializer.fromJson<int?>(
        json['syncVersionClientConfig'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'syncVersionAccount': serializer.toJson<int?>(syncVersionAccount),
      'syncVersionProfile': serializer.toJson<int?>(syncVersionProfile),
      'syncVersionMediaContent': serializer.toJson<int?>(
        syncVersionMediaContent,
      ),
      'syncVersionClientConfig': serializer.toJson<int?>(
        syncVersionClientConfig,
      ),
    };
  }

  SyncVersionData copyWith({
    int? id,
    Value<int?> syncVersionAccount = const Value.absent(),
    Value<int?> syncVersionProfile = const Value.absent(),
    Value<int?> syncVersionMediaContent = const Value.absent(),
    Value<int?> syncVersionClientConfig = const Value.absent(),
  }) => SyncVersionData(
    id: id ?? this.id,
    syncVersionAccount: syncVersionAccount.present
        ? syncVersionAccount.value
        : this.syncVersionAccount,
    syncVersionProfile: syncVersionProfile.present
        ? syncVersionProfile.value
        : this.syncVersionProfile,
    syncVersionMediaContent: syncVersionMediaContent.present
        ? syncVersionMediaContent.value
        : this.syncVersionMediaContent,
    syncVersionClientConfig: syncVersionClientConfig.present
        ? syncVersionClientConfig.value
        : this.syncVersionClientConfig,
  );
  SyncVersionData copyWithCompanion(SyncVersionCompanion data) {
    return SyncVersionData(
      id: data.id.present ? data.id.value : this.id,
      syncVersionAccount: data.syncVersionAccount.present
          ? data.syncVersionAccount.value
          : this.syncVersionAccount,
      syncVersionProfile: data.syncVersionProfile.present
          ? data.syncVersionProfile.value
          : this.syncVersionProfile,
      syncVersionMediaContent: data.syncVersionMediaContent.present
          ? data.syncVersionMediaContent.value
          : this.syncVersionMediaContent,
      syncVersionClientConfig: data.syncVersionClientConfig.present
          ? data.syncVersionClientConfig.value
          : this.syncVersionClientConfig,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncVersionData(')
          ..write('id: $id, ')
          ..write('syncVersionAccount: $syncVersionAccount, ')
          ..write('syncVersionProfile: $syncVersionProfile, ')
          ..write('syncVersionMediaContent: $syncVersionMediaContent, ')
          ..write('syncVersionClientConfig: $syncVersionClientConfig')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    syncVersionAccount,
    syncVersionProfile,
    syncVersionMediaContent,
    syncVersionClientConfig,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncVersionData &&
          other.id == this.id &&
          other.syncVersionAccount == this.syncVersionAccount &&
          other.syncVersionProfile == this.syncVersionProfile &&
          other.syncVersionMediaContent == this.syncVersionMediaContent &&
          other.syncVersionClientConfig == this.syncVersionClientConfig);
}

class SyncVersionCompanion extends UpdateCompanion<SyncVersionData> {
  final Value<int> id;
  final Value<int?> syncVersionAccount;
  final Value<int?> syncVersionProfile;
  final Value<int?> syncVersionMediaContent;
  final Value<int?> syncVersionClientConfig;
  const SyncVersionCompanion({
    this.id = const Value.absent(),
    this.syncVersionAccount = const Value.absent(),
    this.syncVersionProfile = const Value.absent(),
    this.syncVersionMediaContent = const Value.absent(),
    this.syncVersionClientConfig = const Value.absent(),
  });
  SyncVersionCompanion.insert({
    this.id = const Value.absent(),
    this.syncVersionAccount = const Value.absent(),
    this.syncVersionProfile = const Value.absent(),
    this.syncVersionMediaContent = const Value.absent(),
    this.syncVersionClientConfig = const Value.absent(),
  });
  static Insertable<SyncVersionData> custom({
    Expression<int>? id,
    Expression<int>? syncVersionAccount,
    Expression<int>? syncVersionProfile,
    Expression<int>? syncVersionMediaContent,
    Expression<int>? syncVersionClientConfig,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (syncVersionAccount != null)
        'sync_version_account': syncVersionAccount,
      if (syncVersionProfile != null)
        'sync_version_profile': syncVersionProfile,
      if (syncVersionMediaContent != null)
        'sync_version_media_content': syncVersionMediaContent,
      if (syncVersionClientConfig != null)
        'sync_version_client_config': syncVersionClientConfig,
    });
  }

  SyncVersionCompanion copyWith({
    Value<int>? id,
    Value<int?>? syncVersionAccount,
    Value<int?>? syncVersionProfile,
    Value<int?>? syncVersionMediaContent,
    Value<int?>? syncVersionClientConfig,
  }) {
    return SyncVersionCompanion(
      id: id ?? this.id,
      syncVersionAccount: syncVersionAccount ?? this.syncVersionAccount,
      syncVersionProfile: syncVersionProfile ?? this.syncVersionProfile,
      syncVersionMediaContent:
          syncVersionMediaContent ?? this.syncVersionMediaContent,
      syncVersionClientConfig:
          syncVersionClientConfig ?? this.syncVersionClientConfig,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (syncVersionAccount.present) {
      map['sync_version_account'] = Variable<int>(syncVersionAccount.value);
    }
    if (syncVersionProfile.present) {
      map['sync_version_profile'] = Variable<int>(syncVersionProfile.value);
    }
    if (syncVersionMediaContent.present) {
      map['sync_version_media_content'] = Variable<int>(
        syncVersionMediaContent.value,
      );
    }
    if (syncVersionClientConfig.present) {
      map['sync_version_client_config'] = Variable<int>(
        syncVersionClientConfig.value,
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncVersionCompanion(')
          ..write('id: $id, ')
          ..write('syncVersionAccount: $syncVersionAccount, ')
          ..write('syncVersionProfile: $syncVersionProfile, ')
          ..write('syncVersionMediaContent: $syncVersionMediaContent, ')
          ..write('syncVersionClientConfig: $syncVersionClientConfig')
          ..write(')'))
        .toString();
  }
}

class $ReceivedLikesIteratorStateTable extends schema.ReceivedLikesIteratorState
    with
        TableInfo<
          $ReceivedLikesIteratorStateTable,
          ReceivedLikesIteratorStateData
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReceivedLikesIteratorStateTable(this.attachedDatabase, [this._alias]);
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
  late final GeneratedColumnWithTypeConverter<ReceivedLikeId?, int> idAtReset =
      GeneratedColumn<int>(
        'id_at_reset',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      ).withConverter<ReceivedLikeId?>(
        $ReceivedLikesIteratorStateTable.$converteridAtReset,
      );
  static const VerificationMeta _pageMeta = const VerificationMeta('page');
  @override
  late final GeneratedColumn<int> page = GeneratedColumn<int>(
    'page',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [id, idAtReset, page];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'received_likes_iterator_state';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReceivedLikesIteratorStateData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('page')) {
      context.handle(
        _pageMeta,
        page.isAcceptableOrUnknown(data['page']!, _pageMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReceivedLikesIteratorStateData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReceivedLikesIteratorStateData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      idAtReset: $ReceivedLikesIteratorStateTable.$converteridAtReset.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}id_at_reset'],
        ),
      ),
      page: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}page'],
      )!,
    );
  }

  @override
  $ReceivedLikesIteratorStateTable createAlias(String alias) {
    return $ReceivedLikesIteratorStateTable(attachedDatabase, alias);
  }

  static TypeConverter<ReceivedLikeId?, int?> $converteridAtReset =
      const NullAwareTypeConverter.wrap(ReceivedLikeIdConverter());
}

class ReceivedLikesIteratorStateData extends DataClass
    implements Insertable<ReceivedLikesIteratorStateData> {
  final int id;
  final ReceivedLikeId? idAtReset;
  final int page;
  const ReceivedLikesIteratorStateData({
    required this.id,
    this.idAtReset,
    required this.page,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || idAtReset != null) {
      map['id_at_reset'] = Variable<int>(
        $ReceivedLikesIteratorStateTable.$converteridAtReset.toSql(idAtReset),
      );
    }
    map['page'] = Variable<int>(page);
    return map;
  }

  ReceivedLikesIteratorStateCompanion toCompanion(bool nullToAbsent) {
    return ReceivedLikesIteratorStateCompanion(
      id: Value(id),
      idAtReset: idAtReset == null && nullToAbsent
          ? const Value.absent()
          : Value(idAtReset),
      page: Value(page),
    );
  }

  factory ReceivedLikesIteratorStateData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReceivedLikesIteratorStateData(
      id: serializer.fromJson<int>(json['id']),
      idAtReset: serializer.fromJson<ReceivedLikeId?>(json['idAtReset']),
      page: serializer.fromJson<int>(json['page']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'idAtReset': serializer.toJson<ReceivedLikeId?>(idAtReset),
      'page': serializer.toJson<int>(page),
    };
  }

  ReceivedLikesIteratorStateData copyWith({
    int? id,
    Value<ReceivedLikeId?> idAtReset = const Value.absent(),
    int? page,
  }) => ReceivedLikesIteratorStateData(
    id: id ?? this.id,
    idAtReset: idAtReset.present ? idAtReset.value : this.idAtReset,
    page: page ?? this.page,
  );
  ReceivedLikesIteratorStateData copyWithCompanion(
    ReceivedLikesIteratorStateCompanion data,
  ) {
    return ReceivedLikesIteratorStateData(
      id: data.id.present ? data.id.value : this.id,
      idAtReset: data.idAtReset.present ? data.idAtReset.value : this.idAtReset,
      page: data.page.present ? data.page.value : this.page,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReceivedLikesIteratorStateData(')
          ..write('id: $id, ')
          ..write('idAtReset: $idAtReset, ')
          ..write('page: $page')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, idAtReset, page);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReceivedLikesIteratorStateData &&
          other.id == this.id &&
          other.idAtReset == this.idAtReset &&
          other.page == this.page);
}

class ReceivedLikesIteratorStateCompanion
    extends UpdateCompanion<ReceivedLikesIteratorStateData> {
  final Value<int> id;
  final Value<ReceivedLikeId?> idAtReset;
  final Value<int> page;
  const ReceivedLikesIteratorStateCompanion({
    this.id = const Value.absent(),
    this.idAtReset = const Value.absent(),
    this.page = const Value.absent(),
  });
  ReceivedLikesIteratorStateCompanion.insert({
    this.id = const Value.absent(),
    this.idAtReset = const Value.absent(),
    this.page = const Value.absent(),
  });
  static Insertable<ReceivedLikesIteratorStateData> custom({
    Expression<int>? id,
    Expression<int>? idAtReset,
    Expression<int>? page,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (idAtReset != null) 'id_at_reset': idAtReset,
      if (page != null) 'page': page,
    });
  }

  ReceivedLikesIteratorStateCompanion copyWith({
    Value<int>? id,
    Value<ReceivedLikeId?>? idAtReset,
    Value<int>? page,
  }) {
    return ReceivedLikesIteratorStateCompanion(
      id: id ?? this.id,
      idAtReset: idAtReset ?? this.idAtReset,
      page: page ?? this.page,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (idAtReset.present) {
      map['id_at_reset'] = Variable<int>(
        $ReceivedLikesIteratorStateTable.$converteridAtReset.toSql(
          idAtReset.value,
        ),
      );
    }
    if (page.present) {
      map['page'] = Variable<int>(page.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReceivedLikesIteratorStateCompanion(')
          ..write('id: $id, ')
          ..write('idAtReset: $idAtReset, ')
          ..write('page: $page')
          ..write(')'))
        .toString();
  }
}

class $ClientFeaturesConfigTable extends schema.ClientFeaturesConfig
    with TableInfo<$ClientFeaturesConfigTable, ClientFeaturesConfigData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClientFeaturesConfigTable(this.attachedDatabase, [this._alias]);
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
  late final GeneratedColumnWithTypeConverter<ClientFeaturesConfigHash?, String>
  clientFeaturesConfigHash =
      GeneratedColumn<String>(
        'client_features_config_hash',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<ClientFeaturesConfigHash?>(
        $ClientFeaturesConfigTable.$converterclientFeaturesConfigHash,
      );
  @override
  late final GeneratedColumnWithTypeConverter<
    JsonObject<ClientFeaturesConfig>?,
    String
  >
  clientFeaturesConfig =
      GeneratedColumn<String>(
        'client_features_config',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<JsonObject<ClientFeaturesConfig>?>(
        $ClientFeaturesConfigTable.$converterclientFeaturesConfig,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    clientFeaturesConfigHash,
    clientFeaturesConfig,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'client_features_config';
  @override
  VerificationContext validateIntegrity(
    Insertable<ClientFeaturesConfigData> instance, {
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
  ClientFeaturesConfigData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ClientFeaturesConfigData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      clientFeaturesConfigHash: $ClientFeaturesConfigTable
          .$converterclientFeaturesConfigHash
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}client_features_config_hash'],
            ),
          ),
      clientFeaturesConfig: $ClientFeaturesConfigTable
          .$converterclientFeaturesConfig
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}client_features_config'],
            ),
          ),
    );
  }

  @override
  $ClientFeaturesConfigTable createAlias(String alias) {
    return $ClientFeaturesConfigTable(attachedDatabase, alias);
  }

  static TypeConverter<ClientFeaturesConfigHash?, String?>
  $converterclientFeaturesConfigHash = const NullAwareTypeConverter.wrap(
    ClientFeaturesConfigHashConverter(),
  );
  static TypeConverter<JsonObject<ClientFeaturesConfig>?, String?>
  $converterclientFeaturesConfig = NullAwareTypeConverter.wrap(
    const ClientFeaturesConfigConverter(),
  );
}

class ClientFeaturesConfigData extends DataClass
    implements Insertable<ClientFeaturesConfigData> {
  final int id;
  final ClientFeaturesConfigHash? clientFeaturesConfigHash;
  final JsonObject<ClientFeaturesConfig>? clientFeaturesConfig;
  const ClientFeaturesConfigData({
    required this.id,
    this.clientFeaturesConfigHash,
    this.clientFeaturesConfig,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || clientFeaturesConfigHash != null) {
      map['client_features_config_hash'] = Variable<String>(
        $ClientFeaturesConfigTable.$converterclientFeaturesConfigHash.toSql(
          clientFeaturesConfigHash,
        ),
      );
    }
    if (!nullToAbsent || clientFeaturesConfig != null) {
      map['client_features_config'] = Variable<String>(
        $ClientFeaturesConfigTable.$converterclientFeaturesConfig.toSql(
          clientFeaturesConfig,
        ),
      );
    }
    return map;
  }

  ClientFeaturesConfigCompanion toCompanion(bool nullToAbsent) {
    return ClientFeaturesConfigCompanion(
      id: Value(id),
      clientFeaturesConfigHash: clientFeaturesConfigHash == null && nullToAbsent
          ? const Value.absent()
          : Value(clientFeaturesConfigHash),
      clientFeaturesConfig: clientFeaturesConfig == null && nullToAbsent
          ? const Value.absent()
          : Value(clientFeaturesConfig),
    );
  }

  factory ClientFeaturesConfigData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ClientFeaturesConfigData(
      id: serializer.fromJson<int>(json['id']),
      clientFeaturesConfigHash: serializer.fromJson<ClientFeaturesConfigHash?>(
        json['clientFeaturesConfigHash'],
      ),
      clientFeaturesConfig: serializer
          .fromJson<JsonObject<ClientFeaturesConfig>?>(
            json['clientFeaturesConfig'],
          ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'clientFeaturesConfigHash': serializer.toJson<ClientFeaturesConfigHash?>(
        clientFeaturesConfigHash,
      ),
      'clientFeaturesConfig': serializer
          .toJson<JsonObject<ClientFeaturesConfig>?>(clientFeaturesConfig),
    };
  }

  ClientFeaturesConfigData copyWith({
    int? id,
    Value<ClientFeaturesConfigHash?> clientFeaturesConfigHash =
        const Value.absent(),
    Value<JsonObject<ClientFeaturesConfig>?> clientFeaturesConfig =
        const Value.absent(),
  }) => ClientFeaturesConfigData(
    id: id ?? this.id,
    clientFeaturesConfigHash: clientFeaturesConfigHash.present
        ? clientFeaturesConfigHash.value
        : this.clientFeaturesConfigHash,
    clientFeaturesConfig: clientFeaturesConfig.present
        ? clientFeaturesConfig.value
        : this.clientFeaturesConfig,
  );
  ClientFeaturesConfigData copyWithCompanion(
    ClientFeaturesConfigCompanion data,
  ) {
    return ClientFeaturesConfigData(
      id: data.id.present ? data.id.value : this.id,
      clientFeaturesConfigHash: data.clientFeaturesConfigHash.present
          ? data.clientFeaturesConfigHash.value
          : this.clientFeaturesConfigHash,
      clientFeaturesConfig: data.clientFeaturesConfig.present
          ? data.clientFeaturesConfig.value
          : this.clientFeaturesConfig,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ClientFeaturesConfigData(')
          ..write('id: $id, ')
          ..write('clientFeaturesConfigHash: $clientFeaturesConfigHash, ')
          ..write('clientFeaturesConfig: $clientFeaturesConfig')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, clientFeaturesConfigHash, clientFeaturesConfig);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ClientFeaturesConfigData &&
          other.id == this.id &&
          other.clientFeaturesConfigHash == this.clientFeaturesConfigHash &&
          other.clientFeaturesConfig == this.clientFeaturesConfig);
}

class ClientFeaturesConfigCompanion
    extends UpdateCompanion<ClientFeaturesConfigData> {
  final Value<int> id;
  final Value<ClientFeaturesConfigHash?> clientFeaturesConfigHash;
  final Value<JsonObject<ClientFeaturesConfig>?> clientFeaturesConfig;
  const ClientFeaturesConfigCompanion({
    this.id = const Value.absent(),
    this.clientFeaturesConfigHash = const Value.absent(),
    this.clientFeaturesConfig = const Value.absent(),
  });
  ClientFeaturesConfigCompanion.insert({
    this.id = const Value.absent(),
    this.clientFeaturesConfigHash = const Value.absent(),
    this.clientFeaturesConfig = const Value.absent(),
  });
  static Insertable<ClientFeaturesConfigData> custom({
    Expression<int>? id,
    Expression<String>? clientFeaturesConfigHash,
    Expression<String>? clientFeaturesConfig,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (clientFeaturesConfigHash != null)
        'client_features_config_hash': clientFeaturesConfigHash,
      if (clientFeaturesConfig != null)
        'client_features_config': clientFeaturesConfig,
    });
  }

  ClientFeaturesConfigCompanion copyWith({
    Value<int>? id,
    Value<ClientFeaturesConfigHash?>? clientFeaturesConfigHash,
    Value<JsonObject<ClientFeaturesConfig>?>? clientFeaturesConfig,
  }) {
    return ClientFeaturesConfigCompanion(
      id: id ?? this.id,
      clientFeaturesConfigHash:
          clientFeaturesConfigHash ?? this.clientFeaturesConfigHash,
      clientFeaturesConfig: clientFeaturesConfig ?? this.clientFeaturesConfig,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (clientFeaturesConfigHash.present) {
      map['client_features_config_hash'] = Variable<String>(
        $ClientFeaturesConfigTable.$converterclientFeaturesConfigHash.toSql(
          clientFeaturesConfigHash.value,
        ),
      );
    }
    if (clientFeaturesConfig.present) {
      map['client_features_config'] = Variable<String>(
        $ClientFeaturesConfigTable.$converterclientFeaturesConfig.toSql(
          clientFeaturesConfig.value,
        ),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClientFeaturesConfigCompanion(')
          ..write('id: $id, ')
          ..write('clientFeaturesConfigHash: $clientFeaturesConfigHash, ')
          ..write('clientFeaturesConfig: $clientFeaturesConfig')
          ..write(')'))
        .toString();
  }
}

class $CustomReportsConfigTable extends schema.CustomReportsConfig
    with TableInfo<$CustomReportsConfigTable, CustomReportsConfigData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomReportsConfigTable(this.attachedDatabase, [this._alias]);
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
  late final GeneratedColumnWithTypeConverter<CustomReportsConfigHash?, String>
  customReportsConfigHash =
      GeneratedColumn<String>(
        'custom_reports_config_hash',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<CustomReportsConfigHash?>(
        $CustomReportsConfigTable.$convertercustomReportsConfigHash,
      );
  @override
  late final GeneratedColumnWithTypeConverter<
    JsonObject<CustomReportsConfig>?,
    String
  >
  customReportsConfig =
      GeneratedColumn<String>(
        'custom_reports_config',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<JsonObject<CustomReportsConfig>?>(
        $CustomReportsConfigTable.$convertercustomReportsConfig,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    customReportsConfigHash,
    customReportsConfig,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'custom_reports_config';
  @override
  VerificationContext validateIntegrity(
    Insertable<CustomReportsConfigData> instance, {
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
  CustomReportsConfigData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CustomReportsConfigData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      customReportsConfigHash: $CustomReportsConfigTable
          .$convertercustomReportsConfigHash
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}custom_reports_config_hash'],
            ),
          ),
      customReportsConfig: $CustomReportsConfigTable
          .$convertercustomReportsConfig
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}custom_reports_config'],
            ),
          ),
    );
  }

  @override
  $CustomReportsConfigTable createAlias(String alias) {
    return $CustomReportsConfigTable(attachedDatabase, alias);
  }

  static TypeConverter<CustomReportsConfigHash?, String?>
  $convertercustomReportsConfigHash = const NullAwareTypeConverter.wrap(
    CustomReportsConfigHashConverter(),
  );
  static TypeConverter<JsonObject<CustomReportsConfig>?, String?>
  $convertercustomReportsConfig = NullAwareTypeConverter.wrap(
    const CustomReportsConfigConverter(),
  );
}

class CustomReportsConfigData extends DataClass
    implements Insertable<CustomReportsConfigData> {
  final int id;
  final CustomReportsConfigHash? customReportsConfigHash;
  final JsonObject<CustomReportsConfig>? customReportsConfig;
  const CustomReportsConfigData({
    required this.id,
    this.customReportsConfigHash,
    this.customReportsConfig,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || customReportsConfigHash != null) {
      map['custom_reports_config_hash'] = Variable<String>(
        $CustomReportsConfigTable.$convertercustomReportsConfigHash.toSql(
          customReportsConfigHash,
        ),
      );
    }
    if (!nullToAbsent || customReportsConfig != null) {
      map['custom_reports_config'] = Variable<String>(
        $CustomReportsConfigTable.$convertercustomReportsConfig.toSql(
          customReportsConfig,
        ),
      );
    }
    return map;
  }

  CustomReportsConfigCompanion toCompanion(bool nullToAbsent) {
    return CustomReportsConfigCompanion(
      id: Value(id),
      customReportsConfigHash: customReportsConfigHash == null && nullToAbsent
          ? const Value.absent()
          : Value(customReportsConfigHash),
      customReportsConfig: customReportsConfig == null && nullToAbsent
          ? const Value.absent()
          : Value(customReportsConfig),
    );
  }

  factory CustomReportsConfigData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CustomReportsConfigData(
      id: serializer.fromJson<int>(json['id']),
      customReportsConfigHash: serializer.fromJson<CustomReportsConfigHash?>(
        json['customReportsConfigHash'],
      ),
      customReportsConfig: serializer
          .fromJson<JsonObject<CustomReportsConfig>?>(
            json['customReportsConfig'],
          ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'customReportsConfigHash': serializer.toJson<CustomReportsConfigHash?>(
        customReportsConfigHash,
      ),
      'customReportsConfig': serializer
          .toJson<JsonObject<CustomReportsConfig>?>(customReportsConfig),
    };
  }

  CustomReportsConfigData copyWith({
    int? id,
    Value<CustomReportsConfigHash?> customReportsConfigHash =
        const Value.absent(),
    Value<JsonObject<CustomReportsConfig>?> customReportsConfig =
        const Value.absent(),
  }) => CustomReportsConfigData(
    id: id ?? this.id,
    customReportsConfigHash: customReportsConfigHash.present
        ? customReportsConfigHash.value
        : this.customReportsConfigHash,
    customReportsConfig: customReportsConfig.present
        ? customReportsConfig.value
        : this.customReportsConfig,
  );
  CustomReportsConfigData copyWithCompanion(CustomReportsConfigCompanion data) {
    return CustomReportsConfigData(
      id: data.id.present ? data.id.value : this.id,
      customReportsConfigHash: data.customReportsConfigHash.present
          ? data.customReportsConfigHash.value
          : this.customReportsConfigHash,
      customReportsConfig: data.customReportsConfig.present
          ? data.customReportsConfig.value
          : this.customReportsConfig,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CustomReportsConfigData(')
          ..write('id: $id, ')
          ..write('customReportsConfigHash: $customReportsConfigHash, ')
          ..write('customReportsConfig: $customReportsConfig')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, customReportsConfigHash, customReportsConfig);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CustomReportsConfigData &&
          other.id == this.id &&
          other.customReportsConfigHash == this.customReportsConfigHash &&
          other.customReportsConfig == this.customReportsConfig);
}

class CustomReportsConfigCompanion
    extends UpdateCompanion<CustomReportsConfigData> {
  final Value<int> id;
  final Value<CustomReportsConfigHash?> customReportsConfigHash;
  final Value<JsonObject<CustomReportsConfig>?> customReportsConfig;
  const CustomReportsConfigCompanion({
    this.id = const Value.absent(),
    this.customReportsConfigHash = const Value.absent(),
    this.customReportsConfig = const Value.absent(),
  });
  CustomReportsConfigCompanion.insert({
    this.id = const Value.absent(),
    this.customReportsConfigHash = const Value.absent(),
    this.customReportsConfig = const Value.absent(),
  });
  static Insertable<CustomReportsConfigData> custom({
    Expression<int>? id,
    Expression<String>? customReportsConfigHash,
    Expression<String>? customReportsConfig,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (customReportsConfigHash != null)
        'custom_reports_config_hash': customReportsConfigHash,
      if (customReportsConfig != null)
        'custom_reports_config': customReportsConfig,
    });
  }

  CustomReportsConfigCompanion copyWith({
    Value<int>? id,
    Value<CustomReportsConfigHash?>? customReportsConfigHash,
    Value<JsonObject<CustomReportsConfig>?>? customReportsConfig,
  }) {
    return CustomReportsConfigCompanion(
      id: id ?? this.id,
      customReportsConfigHash:
          customReportsConfigHash ?? this.customReportsConfigHash,
      customReportsConfig: customReportsConfig ?? this.customReportsConfig,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (customReportsConfigHash.present) {
      map['custom_reports_config_hash'] = Variable<String>(
        $CustomReportsConfigTable.$convertercustomReportsConfigHash.toSql(
          customReportsConfigHash.value,
        ),
      );
    }
    if (customReportsConfig.present) {
      map['custom_reports_config'] = Variable<String>(
        $CustomReportsConfigTable.$convertercustomReportsConfig.toSql(
          customReportsConfig.value,
        ),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomReportsConfigCompanion(')
          ..write('id: $id, ')
          ..write('customReportsConfigHash: $customReportsConfigHash, ')
          ..write('customReportsConfig: $customReportsConfig')
          ..write(')'))
        .toString();
  }
}

class $ProfileAttributesConfigTable extends schema.ProfileAttributesConfig
    with TableInfo<$ProfileAttributesConfigTable, ProfileAttributesConfigData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProfileAttributesConfigTable(this.attachedDatabase, [this._alias]);
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
  late final GeneratedColumnWithTypeConverter<
    EnumString<AttributeOrderMode>?,
    String
  >
  jsonAvailableProfileAttributesOrderMode =
      GeneratedColumn<String>(
        'json_available_profile_attributes_order_mode',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<EnumString<AttributeOrderMode>?>(
        $ProfileAttributesConfigTable
            .$converterjsonAvailableProfileAttributesOrderMode,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    jsonAvailableProfileAttributesOrderMode,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'profile_attributes_config';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProfileAttributesConfigData> instance, {
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
  ProfileAttributesConfigData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProfileAttributesConfigData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      jsonAvailableProfileAttributesOrderMode: $ProfileAttributesConfigTable
          .$converterjsonAvailableProfileAttributesOrderMode
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}json_available_profile_attributes_order_mode'],
            ),
          ),
    );
  }

  @override
  $ProfileAttributesConfigTable createAlias(String alias) {
    return $ProfileAttributesConfigTable(attachedDatabase, alias);
  }

  static TypeConverter<EnumString<AttributeOrderMode>?, String?>
  $converterjsonAvailableProfileAttributesOrderMode =
      NullAwareTypeConverter.wrap(const AttributeOrderModeConverter());
}

class ProfileAttributesConfigData extends DataClass
    implements Insertable<ProfileAttributesConfigData> {
  final int id;
  final EnumString<AttributeOrderMode>? jsonAvailableProfileAttributesOrderMode;
  const ProfileAttributesConfigData({
    required this.id,
    this.jsonAvailableProfileAttributesOrderMode,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || jsonAvailableProfileAttributesOrderMode != null) {
      map['json_available_profile_attributes_order_mode'] = Variable<String>(
        $ProfileAttributesConfigTable
            .$converterjsonAvailableProfileAttributesOrderMode
            .toSql(jsonAvailableProfileAttributesOrderMode),
      );
    }
    return map;
  }

  ProfileAttributesConfigCompanion toCompanion(bool nullToAbsent) {
    return ProfileAttributesConfigCompanion(
      id: Value(id),
      jsonAvailableProfileAttributesOrderMode:
          jsonAvailableProfileAttributesOrderMode == null && nullToAbsent
          ? const Value.absent()
          : Value(jsonAvailableProfileAttributesOrderMode),
    );
  }

  factory ProfileAttributesConfigData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProfileAttributesConfigData(
      id: serializer.fromJson<int>(json['id']),
      jsonAvailableProfileAttributesOrderMode: serializer
          .fromJson<EnumString<AttributeOrderMode>?>(
            json['jsonAvailableProfileAttributesOrderMode'],
          ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'jsonAvailableProfileAttributesOrderMode': serializer
          .toJson<EnumString<AttributeOrderMode>?>(
            jsonAvailableProfileAttributesOrderMode,
          ),
    };
  }

  ProfileAttributesConfigData copyWith({
    int? id,
    Value<EnumString<AttributeOrderMode>?>
        jsonAvailableProfileAttributesOrderMode =
        const Value.absent(),
  }) => ProfileAttributesConfigData(
    id: id ?? this.id,
    jsonAvailableProfileAttributesOrderMode:
        jsonAvailableProfileAttributesOrderMode.present
        ? jsonAvailableProfileAttributesOrderMode.value
        : this.jsonAvailableProfileAttributesOrderMode,
  );
  ProfileAttributesConfigData copyWithCompanion(
    ProfileAttributesConfigCompanion data,
  ) {
    return ProfileAttributesConfigData(
      id: data.id.present ? data.id.value : this.id,
      jsonAvailableProfileAttributesOrderMode:
          data.jsonAvailableProfileAttributesOrderMode.present
          ? data.jsonAvailableProfileAttributesOrderMode.value
          : this.jsonAvailableProfileAttributesOrderMode,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProfileAttributesConfigData(')
          ..write('id: $id, ')
          ..write(
            'jsonAvailableProfileAttributesOrderMode: $jsonAvailableProfileAttributesOrderMode',
          )
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, jsonAvailableProfileAttributesOrderMode);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProfileAttributesConfigData &&
          other.id == this.id &&
          other.jsonAvailableProfileAttributesOrderMode ==
              this.jsonAvailableProfileAttributesOrderMode);
}

class ProfileAttributesConfigCompanion
    extends UpdateCompanion<ProfileAttributesConfigData> {
  final Value<int> id;
  final Value<EnumString<AttributeOrderMode>?>
  jsonAvailableProfileAttributesOrderMode;
  const ProfileAttributesConfigCompanion({
    this.id = const Value.absent(),
    this.jsonAvailableProfileAttributesOrderMode = const Value.absent(),
  });
  ProfileAttributesConfigCompanion.insert({
    this.id = const Value.absent(),
    this.jsonAvailableProfileAttributesOrderMode = const Value.absent(),
  });
  static Insertable<ProfileAttributesConfigData> custom({
    Expression<int>? id,
    Expression<String>? jsonAvailableProfileAttributesOrderMode,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (jsonAvailableProfileAttributesOrderMode != null)
        'json_available_profile_attributes_order_mode':
            jsonAvailableProfileAttributesOrderMode,
    });
  }

  ProfileAttributesConfigCompanion copyWith({
    Value<int>? id,
    Value<EnumString<AttributeOrderMode>?>?
    jsonAvailableProfileAttributesOrderMode,
  }) {
    return ProfileAttributesConfigCompanion(
      id: id ?? this.id,
      jsonAvailableProfileAttributesOrderMode:
          jsonAvailableProfileAttributesOrderMode ??
          this.jsonAvailableProfileAttributesOrderMode,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (jsonAvailableProfileAttributesOrderMode.present) {
      map['json_available_profile_attributes_order_mode'] = Variable<String>(
        $ProfileAttributesConfigTable
            .$converterjsonAvailableProfileAttributesOrderMode
            .toSql(jsonAvailableProfileAttributesOrderMode.value),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProfileAttributesConfigCompanion(')
          ..write('id: $id, ')
          ..write(
            'jsonAvailableProfileAttributesOrderMode: $jsonAvailableProfileAttributesOrderMode',
          )
          ..write(')'))
        .toString();
  }
}

class $ProfileAttributesConfigAttributesTable
    extends schema.ProfileAttributesConfigAttributes
    with
        TableInfo<
          $ProfileAttributesConfigAttributesTable,
          ProfileAttributesConfigAttribute
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProfileAttributesConfigAttributesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _attributeIdMeta = const VerificationMeta(
    'attributeId',
  );
  @override
  late final GeneratedColumn<int> attributeId = GeneratedColumn<int>(
    'attribute_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<JsonObject<Attribute>, String>
  jsonAttribute =
      GeneratedColumn<String>(
        'json_attribute',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<JsonObject<Attribute>>(
        $ProfileAttributesConfigAttributesTable.$converterjsonAttribute,
      );
  @override
  late final GeneratedColumnWithTypeConverter<AttributeHash, String>
  attributeHash =
      GeneratedColumn<String>(
        'attribute_hash',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<AttributeHash>(
        $ProfileAttributesConfigAttributesTable.$converterattributeHash,
      );
  @override
  List<GeneratedColumn> get $columns => [
    attributeId,
    jsonAttribute,
    attributeHash,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'profile_attributes_config_attributes';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProfileAttributesConfigAttribute> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('attribute_id')) {
      context.handle(
        _attributeIdMeta,
        attributeId.isAcceptableOrUnknown(
          data['attribute_id']!,
          _attributeIdMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {attributeId};
  @override
  ProfileAttributesConfigAttribute map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProfileAttributesConfigAttribute(
      attributeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}attribute_id'],
      )!,
      jsonAttribute: $ProfileAttributesConfigAttributesTable
          .$converterjsonAttribute
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}json_attribute'],
            )!,
          ),
      attributeHash: $ProfileAttributesConfigAttributesTable
          .$converterattributeHash
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}attribute_hash'],
            )!,
          ),
    );
  }

  @override
  $ProfileAttributesConfigAttributesTable createAlias(String alias) {
    return $ProfileAttributesConfigAttributesTable(attachedDatabase, alias);
  }

  static TypeConverter<JsonObject<Attribute>, String> $converterjsonAttribute =
      const AttributeConverter();
  static TypeConverter<AttributeHash, String> $converterattributeHash =
      const AttributeHashConverter();
}

class ProfileAttributesConfigAttribute extends DataClass
    implements Insertable<ProfileAttributesConfigAttribute> {
  /// Attribute ID
  final int attributeId;
  final JsonObject<Attribute> jsonAttribute;
  final AttributeHash attributeHash;
  const ProfileAttributesConfigAttribute({
    required this.attributeId,
    required this.jsonAttribute,
    required this.attributeHash,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['attribute_id'] = Variable<int>(attributeId);
    {
      map['json_attribute'] = Variable<String>(
        $ProfileAttributesConfigAttributesTable.$converterjsonAttribute.toSql(
          jsonAttribute,
        ),
      );
    }
    {
      map['attribute_hash'] = Variable<String>(
        $ProfileAttributesConfigAttributesTable.$converterattributeHash.toSql(
          attributeHash,
        ),
      );
    }
    return map;
  }

  ProfileAttributesConfigAttributesCompanion toCompanion(bool nullToAbsent) {
    return ProfileAttributesConfigAttributesCompanion(
      attributeId: Value(attributeId),
      jsonAttribute: Value(jsonAttribute),
      attributeHash: Value(attributeHash),
    );
  }

  factory ProfileAttributesConfigAttribute.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProfileAttributesConfigAttribute(
      attributeId: serializer.fromJson<int>(json['attributeId']),
      jsonAttribute: serializer.fromJson<JsonObject<Attribute>>(
        json['jsonAttribute'],
      ),
      attributeHash: serializer.fromJson<AttributeHash>(json['attributeHash']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'attributeId': serializer.toJson<int>(attributeId),
      'jsonAttribute': serializer.toJson<JsonObject<Attribute>>(jsonAttribute),
      'attributeHash': serializer.toJson<AttributeHash>(attributeHash),
    };
  }

  ProfileAttributesConfigAttribute copyWith({
    int? attributeId,
    JsonObject<Attribute>? jsonAttribute,
    AttributeHash? attributeHash,
  }) => ProfileAttributesConfigAttribute(
    attributeId: attributeId ?? this.attributeId,
    jsonAttribute: jsonAttribute ?? this.jsonAttribute,
    attributeHash: attributeHash ?? this.attributeHash,
  );
  ProfileAttributesConfigAttribute copyWithCompanion(
    ProfileAttributesConfigAttributesCompanion data,
  ) {
    return ProfileAttributesConfigAttribute(
      attributeId: data.attributeId.present
          ? data.attributeId.value
          : this.attributeId,
      jsonAttribute: data.jsonAttribute.present
          ? data.jsonAttribute.value
          : this.jsonAttribute,
      attributeHash: data.attributeHash.present
          ? data.attributeHash.value
          : this.attributeHash,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProfileAttributesConfigAttribute(')
          ..write('attributeId: $attributeId, ')
          ..write('jsonAttribute: $jsonAttribute, ')
          ..write('attributeHash: $attributeHash')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(attributeId, jsonAttribute, attributeHash);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProfileAttributesConfigAttribute &&
          other.attributeId == this.attributeId &&
          other.jsonAttribute == this.jsonAttribute &&
          other.attributeHash == this.attributeHash);
}

class ProfileAttributesConfigAttributesCompanion
    extends UpdateCompanion<ProfileAttributesConfigAttribute> {
  final Value<int> attributeId;
  final Value<JsonObject<Attribute>> jsonAttribute;
  final Value<AttributeHash> attributeHash;
  const ProfileAttributesConfigAttributesCompanion({
    this.attributeId = const Value.absent(),
    this.jsonAttribute = const Value.absent(),
    this.attributeHash = const Value.absent(),
  });
  ProfileAttributesConfigAttributesCompanion.insert({
    this.attributeId = const Value.absent(),
    required JsonObject<Attribute> jsonAttribute,
    required AttributeHash attributeHash,
  }) : jsonAttribute = Value(jsonAttribute),
       attributeHash = Value(attributeHash);
  static Insertable<ProfileAttributesConfigAttribute> custom({
    Expression<int>? attributeId,
    Expression<String>? jsonAttribute,
    Expression<String>? attributeHash,
  }) {
    return RawValuesInsertable({
      if (attributeId != null) 'attribute_id': attributeId,
      if (jsonAttribute != null) 'json_attribute': jsonAttribute,
      if (attributeHash != null) 'attribute_hash': attributeHash,
    });
  }

  ProfileAttributesConfigAttributesCompanion copyWith({
    Value<int>? attributeId,
    Value<JsonObject<Attribute>>? jsonAttribute,
    Value<AttributeHash>? attributeHash,
  }) {
    return ProfileAttributesConfigAttributesCompanion(
      attributeId: attributeId ?? this.attributeId,
      jsonAttribute: jsonAttribute ?? this.jsonAttribute,
      attributeHash: attributeHash ?? this.attributeHash,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (attributeId.present) {
      map['attribute_id'] = Variable<int>(attributeId.value);
    }
    if (jsonAttribute.present) {
      map['json_attribute'] = Variable<String>(
        $ProfileAttributesConfigAttributesTable.$converterjsonAttribute.toSql(
          jsonAttribute.value,
        ),
      );
    }
    if (attributeHash.present) {
      map['attribute_hash'] = Variable<String>(
        $ProfileAttributesConfigAttributesTable.$converterattributeHash.toSql(
          attributeHash.value,
        ),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProfileAttributesConfigAttributesCompanion(')
          ..write('attributeId: $attributeId, ')
          ..write('jsonAttribute: $jsonAttribute, ')
          ..write('attributeHash: $attributeHash')
          ..write(')'))
        .toString();
  }
}

class $ClientLanguageOnServerTable extends schema.ClientLanguageOnServer
    with TableInfo<$ClientLanguageOnServerTable, ClientLanguageOnServerData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClientLanguageOnServerTable(this.attachedDatabase, [this._alias]);
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
  late final GeneratedColumnWithTypeConverter<ClientLanguage?, String>
  clientLanguageOnServer =
      GeneratedColumn<String>(
        'client_language_on_server',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<ClientLanguage?>(
        $ClientLanguageOnServerTable.$converterclientLanguageOnServer,
      );
  @override
  List<GeneratedColumn> get $columns => [id, clientLanguageOnServer];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'client_language_on_server';
  @override
  VerificationContext validateIntegrity(
    Insertable<ClientLanguageOnServerData> instance, {
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
  ClientLanguageOnServerData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ClientLanguageOnServerData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      clientLanguageOnServer: $ClientLanguageOnServerTable
          .$converterclientLanguageOnServer
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}client_language_on_server'],
            ),
          ),
    );
  }

  @override
  $ClientLanguageOnServerTable createAlias(String alias) {
    return $ClientLanguageOnServerTable(attachedDatabase, alias);
  }

  static TypeConverter<ClientLanguage?, String?>
  $converterclientLanguageOnServer = const NullAwareTypeConverter.wrap(
    ClientLanguageConverter(),
  );
}

class ClientLanguageOnServerData extends DataClass
    implements Insertable<ClientLanguageOnServerData> {
  final int id;
  final ClientLanguage? clientLanguageOnServer;
  const ClientLanguageOnServerData({
    required this.id,
    this.clientLanguageOnServer,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || clientLanguageOnServer != null) {
      map['client_language_on_server'] = Variable<String>(
        $ClientLanguageOnServerTable.$converterclientLanguageOnServer.toSql(
          clientLanguageOnServer,
        ),
      );
    }
    return map;
  }

  ClientLanguageOnServerCompanion toCompanion(bool nullToAbsent) {
    return ClientLanguageOnServerCompanion(
      id: Value(id),
      clientLanguageOnServer: clientLanguageOnServer == null && nullToAbsent
          ? const Value.absent()
          : Value(clientLanguageOnServer),
    );
  }

  factory ClientLanguageOnServerData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ClientLanguageOnServerData(
      id: serializer.fromJson<int>(json['id']),
      clientLanguageOnServer: serializer.fromJson<ClientLanguage?>(
        json['clientLanguageOnServer'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'clientLanguageOnServer': serializer.toJson<ClientLanguage?>(
        clientLanguageOnServer,
      ),
    };
  }

  ClientLanguageOnServerData copyWith({
    int? id,
    Value<ClientLanguage?> clientLanguageOnServer = const Value.absent(),
  }) => ClientLanguageOnServerData(
    id: id ?? this.id,
    clientLanguageOnServer: clientLanguageOnServer.present
        ? clientLanguageOnServer.value
        : this.clientLanguageOnServer,
  );
  ClientLanguageOnServerData copyWithCompanion(
    ClientLanguageOnServerCompanion data,
  ) {
    return ClientLanguageOnServerData(
      id: data.id.present ? data.id.value : this.id,
      clientLanguageOnServer: data.clientLanguageOnServer.present
          ? data.clientLanguageOnServer.value
          : this.clientLanguageOnServer,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ClientLanguageOnServerData(')
          ..write('id: $id, ')
          ..write('clientLanguageOnServer: $clientLanguageOnServer')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, clientLanguageOnServer);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ClientLanguageOnServerData &&
          other.id == this.id &&
          other.clientLanguageOnServer == this.clientLanguageOnServer);
}

class ClientLanguageOnServerCompanion
    extends UpdateCompanion<ClientLanguageOnServerData> {
  final Value<int> id;
  final Value<ClientLanguage?> clientLanguageOnServer;
  const ClientLanguageOnServerCompanion({
    this.id = const Value.absent(),
    this.clientLanguageOnServer = const Value.absent(),
  });
  ClientLanguageOnServerCompanion.insert({
    this.id = const Value.absent(),
    this.clientLanguageOnServer = const Value.absent(),
  });
  static Insertable<ClientLanguageOnServerData> custom({
    Expression<int>? id,
    Expression<String>? clientLanguageOnServer,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (clientLanguageOnServer != null)
        'client_language_on_server': clientLanguageOnServer,
    });
  }

  ClientLanguageOnServerCompanion copyWith({
    Value<int>? id,
    Value<ClientLanguage?>? clientLanguageOnServer,
  }) {
    return ClientLanguageOnServerCompanion(
      id: id ?? this.id,
      clientLanguageOnServer:
          clientLanguageOnServer ?? this.clientLanguageOnServer,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (clientLanguageOnServer.present) {
      map['client_language_on_server'] = Variable<String>(
        $ClientLanguageOnServerTable.$converterclientLanguageOnServer.toSql(
          clientLanguageOnServer.value,
        ),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClientLanguageOnServerCompanion(')
          ..write('id: $id, ')
          ..write('clientLanguageOnServer: $clientLanguageOnServer')
          ..write(')'))
        .toString();
  }
}

class $NewReceivedLikesCountTable extends schema.NewReceivedLikesCount
    with TableInfo<$NewReceivedLikesCountTable, NewReceivedLikesCountData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NewReceivedLikesCountTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _syncVersionReceivedLikesMeta =
      const VerificationMeta('syncVersionReceivedLikes');
  @override
  late final GeneratedColumn<int> syncVersionReceivedLikes =
      GeneratedColumn<int>(
        'sync_version_received_likes',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      );
  @override
  late final GeneratedColumnWithTypeConverter<NewReceivedLikesCount?, int>
  newReceivedLikesCount =
      GeneratedColumn<int>(
        'new_received_likes_count',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      ).withConverter<NewReceivedLikesCount?>(
        $NewReceivedLikesCountTable.$converternewReceivedLikesCount,
      );
  @override
  late final GeneratedColumnWithTypeConverter<ReceivedLikeId?, int>
  latestReceivedLikeId =
      GeneratedColumn<int>(
        'latest_received_like_id',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      ).withConverter<ReceivedLikeId?>(
        $NewReceivedLikesCountTable.$converterlatestReceivedLikeId,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    syncVersionReceivedLikes,
    newReceivedLikesCount,
    latestReceivedLikeId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'new_received_likes_count';
  @override
  VerificationContext validateIntegrity(
    Insertable<NewReceivedLikesCountData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('sync_version_received_likes')) {
      context.handle(
        _syncVersionReceivedLikesMeta,
        syncVersionReceivedLikes.isAcceptableOrUnknown(
          data['sync_version_received_likes']!,
          _syncVersionReceivedLikesMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NewReceivedLikesCountData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NewReceivedLikesCountData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      syncVersionReceivedLikes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sync_version_received_likes'],
      ),
      newReceivedLikesCount: $NewReceivedLikesCountTable
          .$converternewReceivedLikesCount
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.int,
              data['${effectivePrefix}new_received_likes_count'],
            ),
          ),
      latestReceivedLikeId: $NewReceivedLikesCountTable
          .$converterlatestReceivedLikeId
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.int,
              data['${effectivePrefix}latest_received_like_id'],
            ),
          ),
    );
  }

  @override
  $NewReceivedLikesCountTable createAlias(String alias) {
    return $NewReceivedLikesCountTable(attachedDatabase, alias);
  }

  static TypeConverter<NewReceivedLikesCount?, int?>
  $converternewReceivedLikesCount = const NullAwareTypeConverter.wrap(
    NewReceivedLikesCountConverter(),
  );
  static TypeConverter<ReceivedLikeId?, int?> $converterlatestReceivedLikeId =
      const NullAwareTypeConverter.wrap(ReceivedLikeIdConverter());
}

class NewReceivedLikesCountData extends DataClass
    implements Insertable<NewReceivedLikesCountData> {
  final int id;
  final int? syncVersionReceivedLikes;
  final NewReceivedLikesCount? newReceivedLikesCount;
  final ReceivedLikeId? latestReceivedLikeId;
  const NewReceivedLikesCountData({
    required this.id,
    this.syncVersionReceivedLikes,
    this.newReceivedLikesCount,
    this.latestReceivedLikeId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || syncVersionReceivedLikes != null) {
      map['sync_version_received_likes'] = Variable<int>(
        syncVersionReceivedLikes,
      );
    }
    if (!nullToAbsent || newReceivedLikesCount != null) {
      map['new_received_likes_count'] = Variable<int>(
        $NewReceivedLikesCountTable.$converternewReceivedLikesCount.toSql(
          newReceivedLikesCount,
        ),
      );
    }
    if (!nullToAbsent || latestReceivedLikeId != null) {
      map['latest_received_like_id'] = Variable<int>(
        $NewReceivedLikesCountTable.$converterlatestReceivedLikeId.toSql(
          latestReceivedLikeId,
        ),
      );
    }
    return map;
  }

  NewReceivedLikesCountCompanion toCompanion(bool nullToAbsent) {
    return NewReceivedLikesCountCompanion(
      id: Value(id),
      syncVersionReceivedLikes: syncVersionReceivedLikes == null && nullToAbsent
          ? const Value.absent()
          : Value(syncVersionReceivedLikes),
      newReceivedLikesCount: newReceivedLikesCount == null && nullToAbsent
          ? const Value.absent()
          : Value(newReceivedLikesCount),
      latestReceivedLikeId: latestReceivedLikeId == null && nullToAbsent
          ? const Value.absent()
          : Value(latestReceivedLikeId),
    );
  }

  factory NewReceivedLikesCountData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NewReceivedLikesCountData(
      id: serializer.fromJson<int>(json['id']),
      syncVersionReceivedLikes: serializer.fromJson<int?>(
        json['syncVersionReceivedLikes'],
      ),
      newReceivedLikesCount: serializer.fromJson<NewReceivedLikesCount?>(
        json['newReceivedLikesCount'],
      ),
      latestReceivedLikeId: serializer.fromJson<ReceivedLikeId?>(
        json['latestReceivedLikeId'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'syncVersionReceivedLikes': serializer.toJson<int?>(
        syncVersionReceivedLikes,
      ),
      'newReceivedLikesCount': serializer.toJson<NewReceivedLikesCount?>(
        newReceivedLikesCount,
      ),
      'latestReceivedLikeId': serializer.toJson<ReceivedLikeId?>(
        latestReceivedLikeId,
      ),
    };
  }

  NewReceivedLikesCountData copyWith({
    int? id,
    Value<int?> syncVersionReceivedLikes = const Value.absent(),
    Value<NewReceivedLikesCount?> newReceivedLikesCount = const Value.absent(),
    Value<ReceivedLikeId?> latestReceivedLikeId = const Value.absent(),
  }) => NewReceivedLikesCountData(
    id: id ?? this.id,
    syncVersionReceivedLikes: syncVersionReceivedLikes.present
        ? syncVersionReceivedLikes.value
        : this.syncVersionReceivedLikes,
    newReceivedLikesCount: newReceivedLikesCount.present
        ? newReceivedLikesCount.value
        : this.newReceivedLikesCount,
    latestReceivedLikeId: latestReceivedLikeId.present
        ? latestReceivedLikeId.value
        : this.latestReceivedLikeId,
  );
  NewReceivedLikesCountData copyWithCompanion(
    NewReceivedLikesCountCompanion data,
  ) {
    return NewReceivedLikesCountData(
      id: data.id.present ? data.id.value : this.id,
      syncVersionReceivedLikes: data.syncVersionReceivedLikes.present
          ? data.syncVersionReceivedLikes.value
          : this.syncVersionReceivedLikes,
      newReceivedLikesCount: data.newReceivedLikesCount.present
          ? data.newReceivedLikesCount.value
          : this.newReceivedLikesCount,
      latestReceivedLikeId: data.latestReceivedLikeId.present
          ? data.latestReceivedLikeId.value
          : this.latestReceivedLikeId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NewReceivedLikesCountData(')
          ..write('id: $id, ')
          ..write('syncVersionReceivedLikes: $syncVersionReceivedLikes, ')
          ..write('newReceivedLikesCount: $newReceivedLikesCount, ')
          ..write('latestReceivedLikeId: $latestReceivedLikeId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    syncVersionReceivedLikes,
    newReceivedLikesCount,
    latestReceivedLikeId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NewReceivedLikesCountData &&
          other.id == this.id &&
          other.syncVersionReceivedLikes == this.syncVersionReceivedLikes &&
          other.newReceivedLikesCount == this.newReceivedLikesCount &&
          other.latestReceivedLikeId == this.latestReceivedLikeId);
}

class NewReceivedLikesCountCompanion
    extends UpdateCompanion<NewReceivedLikesCountData> {
  final Value<int> id;
  final Value<int?> syncVersionReceivedLikes;
  final Value<NewReceivedLikesCount?> newReceivedLikesCount;
  final Value<ReceivedLikeId?> latestReceivedLikeId;
  const NewReceivedLikesCountCompanion({
    this.id = const Value.absent(),
    this.syncVersionReceivedLikes = const Value.absent(),
    this.newReceivedLikesCount = const Value.absent(),
    this.latestReceivedLikeId = const Value.absent(),
  });
  NewReceivedLikesCountCompanion.insert({
    this.id = const Value.absent(),
    this.syncVersionReceivedLikes = const Value.absent(),
    this.newReceivedLikesCount = const Value.absent(),
    this.latestReceivedLikeId = const Value.absent(),
  });
  static Insertable<NewReceivedLikesCountData> custom({
    Expression<int>? id,
    Expression<int>? syncVersionReceivedLikes,
    Expression<int>? newReceivedLikesCount,
    Expression<int>? latestReceivedLikeId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (syncVersionReceivedLikes != null)
        'sync_version_received_likes': syncVersionReceivedLikes,
      if (newReceivedLikesCount != null)
        'new_received_likes_count': newReceivedLikesCount,
      if (latestReceivedLikeId != null)
        'latest_received_like_id': latestReceivedLikeId,
    });
  }

  NewReceivedLikesCountCompanion copyWith({
    Value<int>? id,
    Value<int?>? syncVersionReceivedLikes,
    Value<NewReceivedLikesCount?>? newReceivedLikesCount,
    Value<ReceivedLikeId?>? latestReceivedLikeId,
  }) {
    return NewReceivedLikesCountCompanion(
      id: id ?? this.id,
      syncVersionReceivedLikes:
          syncVersionReceivedLikes ?? this.syncVersionReceivedLikes,
      newReceivedLikesCount:
          newReceivedLikesCount ?? this.newReceivedLikesCount,
      latestReceivedLikeId: latestReceivedLikeId ?? this.latestReceivedLikeId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (syncVersionReceivedLikes.present) {
      map['sync_version_received_likes'] = Variable<int>(
        syncVersionReceivedLikes.value,
      );
    }
    if (newReceivedLikesCount.present) {
      map['new_received_likes_count'] = Variable<int>(
        $NewReceivedLikesCountTable.$converternewReceivedLikesCount.toSql(
          newReceivedLikesCount.value,
        ),
      );
    }
    if (latestReceivedLikeId.present) {
      map['latest_received_like_id'] = Variable<int>(
        $NewReceivedLikesCountTable.$converterlatestReceivedLikeId.toSql(
          latestReceivedLikeId.value,
        ),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NewReceivedLikesCountCompanion(')
          ..write('id: $id, ')
          ..write('syncVersionReceivedLikes: $syncVersionReceivedLikes, ')
          ..write('newReceivedLikesCount: $newReceivedLikesCount, ')
          ..write('latestReceivedLikeId: $latestReceivedLikeId')
          ..write(')'))
        .toString();
  }
}

class $LocalAccountIdTable extends schema.LocalAccountId
    with TableInfo<$LocalAccountIdTable, LocalAccountIdData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalAccountIdTable(this.attachedDatabase, [this._alias]);
  @override
  late final GeneratedColumnWithTypeConverter<LocalAccountId, int> id =
      GeneratedColumn<int>(
        'id',
        aliasedName,
        false,
        hasAutoIncrement: true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'PRIMARY KEY AUTOINCREMENT',
        ),
      ).withConverter<LocalAccountId>($LocalAccountIdTable.$converterid);
  @override
  late final GeneratedColumnWithTypeConverter<AccountId, String> uuid =
      GeneratedColumn<String>(
        'uuid',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
        defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
      ).withConverter<AccountId>($LocalAccountIdTable.$converteruuid);
  @override
  List<GeneratedColumn> get $columns => [id, uuid];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_account_id';
  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalAccountIdData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalAccountIdData(
      id: $LocalAccountIdTable.$converterid.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}id'],
        )!,
      ),
      uuid: $LocalAccountIdTable.$converteruuid.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}uuid'],
        )!,
      ),
    );
  }

  @override
  $LocalAccountIdTable createAlias(String alias) {
    return $LocalAccountIdTable(attachedDatabase, alias);
  }

  static TypeConverter<LocalAccountId, int> $converterid =
      const LocalAccountIdConverter();
  static TypeConverter<AccountId, String> $converteruuid =
      const AccountIdConverter();
}

class LocalAccountIdData extends DataClass
    implements Insertable<LocalAccountIdData> {
  final LocalAccountId id;
  final AccountId uuid;
  const LocalAccountIdData({required this.id, required this.uuid});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    {
      map['id'] = Variable<int>($LocalAccountIdTable.$converterid.toSql(id));
    }
    {
      map['uuid'] = Variable<String>(
        $LocalAccountIdTable.$converteruuid.toSql(uuid),
      );
    }
    return map;
  }

  LocalAccountIdCompanion toCompanion(bool nullToAbsent) {
    return LocalAccountIdCompanion(id: Value(id), uuid: Value(uuid));
  }

  factory LocalAccountIdData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalAccountIdData(
      id: serializer.fromJson<LocalAccountId>(json['id']),
      uuid: serializer.fromJson<AccountId>(json['uuid']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<LocalAccountId>(id),
      'uuid': serializer.toJson<AccountId>(uuid),
    };
  }

  LocalAccountIdData copyWith({LocalAccountId? id, AccountId? uuid}) =>
      LocalAccountIdData(id: id ?? this.id, uuid: uuid ?? this.uuid);
  LocalAccountIdData copyWithCompanion(LocalAccountIdCompanion data) {
    return LocalAccountIdData(
      id: data.id.present ? data.id.value : this.id,
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalAccountIdData(')
          ..write('id: $id, ')
          ..write('uuid: $uuid')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, uuid);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalAccountIdData &&
          other.id == this.id &&
          other.uuid == this.uuid);
}

class LocalAccountIdCompanion extends UpdateCompanion<LocalAccountIdData> {
  final Value<LocalAccountId> id;
  final Value<AccountId> uuid;
  const LocalAccountIdCompanion({
    this.id = const Value.absent(),
    this.uuid = const Value.absent(),
  });
  LocalAccountIdCompanion.insert({
    this.id = const Value.absent(),
    required AccountId uuid,
  }) : uuid = Value(uuid);
  static Insertable<LocalAccountIdData> custom({
    Expression<int>? id,
    Expression<String>? uuid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuid != null) 'uuid': uuid,
    });
  }

  LocalAccountIdCompanion copyWith({
    Value<LocalAccountId>? id,
    Value<AccountId>? uuid,
  }) {
    return LocalAccountIdCompanion(id: id ?? this.id, uuid: uuid ?? this.uuid);
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(
        $LocalAccountIdTable.$converterid.toSql(id.value),
      );
    }
    if (uuid.present) {
      map['uuid'] = Variable<String>(
        $LocalAccountIdTable.$converteruuid.toSql(uuid.value),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalAccountIdCompanion(')
          ..write('id: $id, ')
          ..write('uuid: $uuid')
          ..write(')'))
        .toString();
  }
}

class $AccountStateTable extends schema.AccountState
    with TableInfo<$AccountStateTable, AccountStateData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AccountStateTable(this.attachedDatabase, [this._alias]);
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
  late final GeneratedColumnWithTypeConverter<
    JsonObject<AccountStateContainer>?,
    String
  >
  jsonAccountState =
      GeneratedColumn<String>(
        'json_account_state',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<JsonObject<AccountStateContainer>?>(
        $AccountStateTable.$converterjsonAccountState,
      );
  @override
  List<GeneratedColumn> get $columns => [id, jsonAccountState];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'account_state';
  @override
  VerificationContext validateIntegrity(
    Insertable<AccountStateData> instance, {
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
  AccountStateData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AccountStateData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      jsonAccountState: $AccountStateTable.$converterjsonAccountState.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}json_account_state'],
        ),
      ),
    );
  }

  @override
  $AccountStateTable createAlias(String alias) {
    return $AccountStateTable(attachedDatabase, alias);
  }

  static TypeConverter<JsonObject<AccountStateContainer>?, String?>
  $converterjsonAccountState = NullAwareTypeConverter.wrap(
    const AccountStateContainerConverter(),
  );
}

class AccountStateData extends DataClass
    implements Insertable<AccountStateData> {
  final int id;
  final JsonObject<AccountStateContainer>? jsonAccountState;
  const AccountStateData({required this.id, this.jsonAccountState});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || jsonAccountState != null) {
      map['json_account_state'] = Variable<String>(
        $AccountStateTable.$converterjsonAccountState.toSql(jsonAccountState),
      );
    }
    return map;
  }

  AccountStateCompanion toCompanion(bool nullToAbsent) {
    return AccountStateCompanion(
      id: Value(id),
      jsonAccountState: jsonAccountState == null && nullToAbsent
          ? const Value.absent()
          : Value(jsonAccountState),
    );
  }

  factory AccountStateData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AccountStateData(
      id: serializer.fromJson<int>(json['id']),
      jsonAccountState: serializer.fromJson<JsonObject<AccountStateContainer>?>(
        json['jsonAccountState'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'jsonAccountState': serializer.toJson<JsonObject<AccountStateContainer>?>(
        jsonAccountState,
      ),
    };
  }

  AccountStateData copyWith({
    int? id,
    Value<JsonObject<AccountStateContainer>?> jsonAccountState =
        const Value.absent(),
  }) => AccountStateData(
    id: id ?? this.id,
    jsonAccountState: jsonAccountState.present
        ? jsonAccountState.value
        : this.jsonAccountState,
  );
  AccountStateData copyWithCompanion(AccountStateCompanion data) {
    return AccountStateData(
      id: data.id.present ? data.id.value : this.id,
      jsonAccountState: data.jsonAccountState.present
          ? data.jsonAccountState.value
          : this.jsonAccountState,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AccountStateData(')
          ..write('id: $id, ')
          ..write('jsonAccountState: $jsonAccountState')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, jsonAccountState);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AccountStateData &&
          other.id == this.id &&
          other.jsonAccountState == this.jsonAccountState);
}

class AccountStateCompanion extends UpdateCompanion<AccountStateData> {
  final Value<int> id;
  final Value<JsonObject<AccountStateContainer>?> jsonAccountState;
  const AccountStateCompanion({
    this.id = const Value.absent(),
    this.jsonAccountState = const Value.absent(),
  });
  AccountStateCompanion.insert({
    this.id = const Value.absent(),
    this.jsonAccountState = const Value.absent(),
  });
  static Insertable<AccountStateData> custom({
    Expression<int>? id,
    Expression<String>? jsonAccountState,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (jsonAccountState != null) 'json_account_state': jsonAccountState,
    });
  }

  AccountStateCompanion copyWith({
    Value<int>? id,
    Value<JsonObject<AccountStateContainer>?>? jsonAccountState,
  }) {
    return AccountStateCompanion(
      id: id ?? this.id,
      jsonAccountState: jsonAccountState ?? this.jsonAccountState,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (jsonAccountState.present) {
      map['json_account_state'] = Variable<String>(
        $AccountStateTable.$converterjsonAccountState.toSql(
          jsonAccountState.value,
        ),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AccountStateCompanion(')
          ..write('id: $id, ')
          ..write('jsonAccountState: $jsonAccountState')
          ..write(')'))
        .toString();
  }
}

class $PermissionsTable extends schema.Permissions
    with TableInfo<$PermissionsTable, Permission> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PermissionsTable(this.attachedDatabase, [this._alias]);
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
  late final GeneratedColumnWithTypeConverter<JsonObject<Permissions>?, String>
  jsonPermissions =
      GeneratedColumn<String>(
        'json_permissions',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<JsonObject<Permissions>?>(
        $PermissionsTable.$converterjsonPermissions,
      );
  @override
  List<GeneratedColumn> get $columns => [id, jsonPermissions];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'permissions';
  @override
  VerificationContext validateIntegrity(
    Insertable<Permission> instance, {
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
  Permission map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Permission(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      jsonPermissions: $PermissionsTable.$converterjsonPermissions.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}json_permissions'],
        ),
      ),
    );
  }

  @override
  $PermissionsTable createAlias(String alias) {
    return $PermissionsTable(attachedDatabase, alias);
  }

  static TypeConverter<JsonObject<Permissions>?, String?>
  $converterjsonPermissions = NullAwareTypeConverter.wrap(
    const PermissionsConverter(),
  );
}

class Permission extends DataClass implements Insertable<Permission> {
  final int id;
  final JsonObject<Permissions>? jsonPermissions;
  const Permission({required this.id, this.jsonPermissions});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || jsonPermissions != null) {
      map['json_permissions'] = Variable<String>(
        $PermissionsTable.$converterjsonPermissions.toSql(jsonPermissions),
      );
    }
    return map;
  }

  PermissionsCompanion toCompanion(bool nullToAbsent) {
    return PermissionsCompanion(
      id: Value(id),
      jsonPermissions: jsonPermissions == null && nullToAbsent
          ? const Value.absent()
          : Value(jsonPermissions),
    );
  }

  factory Permission.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Permission(
      id: serializer.fromJson<int>(json['id']),
      jsonPermissions: serializer.fromJson<JsonObject<Permissions>?>(
        json['jsonPermissions'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'jsonPermissions': serializer.toJson<JsonObject<Permissions>?>(
        jsonPermissions,
      ),
    };
  }

  Permission copyWith({
    int? id,
    Value<JsonObject<Permissions>?> jsonPermissions = const Value.absent(),
  }) => Permission(
    id: id ?? this.id,
    jsonPermissions: jsonPermissions.present
        ? jsonPermissions.value
        : this.jsonPermissions,
  );
  Permission copyWithCompanion(PermissionsCompanion data) {
    return Permission(
      id: data.id.present ? data.id.value : this.id,
      jsonPermissions: data.jsonPermissions.present
          ? data.jsonPermissions.value
          : this.jsonPermissions,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Permission(')
          ..write('id: $id, ')
          ..write('jsonPermissions: $jsonPermissions')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, jsonPermissions);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Permission &&
          other.id == this.id &&
          other.jsonPermissions == this.jsonPermissions);
}

class PermissionsCompanion extends UpdateCompanion<Permission> {
  final Value<int> id;
  final Value<JsonObject<Permissions>?> jsonPermissions;
  const PermissionsCompanion({
    this.id = const Value.absent(),
    this.jsonPermissions = const Value.absent(),
  });
  PermissionsCompanion.insert({
    this.id = const Value.absent(),
    this.jsonPermissions = const Value.absent(),
  });
  static Insertable<Permission> custom({
    Expression<int>? id,
    Expression<String>? jsonPermissions,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (jsonPermissions != null) 'json_permissions': jsonPermissions,
    });
  }

  PermissionsCompanion copyWith({
    Value<int>? id,
    Value<JsonObject<Permissions>?>? jsonPermissions,
  }) {
    return PermissionsCompanion(
      id: id ?? this.id,
      jsonPermissions: jsonPermissions ?? this.jsonPermissions,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (jsonPermissions.present) {
      map['json_permissions'] = Variable<String>(
        $PermissionsTable.$converterjsonPermissions.toSql(
          jsonPermissions.value,
        ),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PermissionsCompanion(')
          ..write('id: $id, ')
          ..write('jsonPermissions: $jsonPermissions')
          ..write(')'))
        .toString();
  }
}

class $ProfileVisibilityTable extends schema.ProfileVisibility
    with TableInfo<$ProfileVisibilityTable, ProfileVisibilityData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProfileVisibilityTable(this.attachedDatabase, [this._alias]);
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
  late final GeneratedColumnWithTypeConverter<
    EnumString<ProfileVisibility>?,
    String
  >
  jsonProfileVisibility =
      GeneratedColumn<String>(
        'json_profile_visibility',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<EnumString<ProfileVisibility>?>(
        $ProfileVisibilityTable.$converterjsonProfileVisibility,
      );
  @override
  List<GeneratedColumn> get $columns => [id, jsonProfileVisibility];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'profile_visibility';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProfileVisibilityData> instance, {
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
  ProfileVisibilityData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProfileVisibilityData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      jsonProfileVisibility: $ProfileVisibilityTable
          .$converterjsonProfileVisibility
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}json_profile_visibility'],
            ),
          ),
    );
  }

  @override
  $ProfileVisibilityTable createAlias(String alias) {
    return $ProfileVisibilityTable(attachedDatabase, alias);
  }

  static TypeConverter<EnumString<ProfileVisibility>?, String?>
  $converterjsonProfileVisibility = NullAwareTypeConverter.wrap(
    const ProfileVisibilityConverter(),
  );
}

class ProfileVisibilityData extends DataClass
    implements Insertable<ProfileVisibilityData> {
  final int id;
  final EnumString<ProfileVisibility>? jsonProfileVisibility;
  const ProfileVisibilityData({required this.id, this.jsonProfileVisibility});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || jsonProfileVisibility != null) {
      map['json_profile_visibility'] = Variable<String>(
        $ProfileVisibilityTable.$converterjsonProfileVisibility.toSql(
          jsonProfileVisibility,
        ),
      );
    }
    return map;
  }

  ProfileVisibilityCompanion toCompanion(bool nullToAbsent) {
    return ProfileVisibilityCompanion(
      id: Value(id),
      jsonProfileVisibility: jsonProfileVisibility == null && nullToAbsent
          ? const Value.absent()
          : Value(jsonProfileVisibility),
    );
  }

  factory ProfileVisibilityData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProfileVisibilityData(
      id: serializer.fromJson<int>(json['id']),
      jsonProfileVisibility: serializer
          .fromJson<EnumString<ProfileVisibility>?>(
            json['jsonProfileVisibility'],
          ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'jsonProfileVisibility': serializer
          .toJson<EnumString<ProfileVisibility>?>(jsonProfileVisibility),
    };
  }

  ProfileVisibilityData copyWith({
    int? id,
    Value<EnumString<ProfileVisibility>?> jsonProfileVisibility =
        const Value.absent(),
  }) => ProfileVisibilityData(
    id: id ?? this.id,
    jsonProfileVisibility: jsonProfileVisibility.present
        ? jsonProfileVisibility.value
        : this.jsonProfileVisibility,
  );
  ProfileVisibilityData copyWithCompanion(ProfileVisibilityCompanion data) {
    return ProfileVisibilityData(
      id: data.id.present ? data.id.value : this.id,
      jsonProfileVisibility: data.jsonProfileVisibility.present
          ? data.jsonProfileVisibility.value
          : this.jsonProfileVisibility,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProfileVisibilityData(')
          ..write('id: $id, ')
          ..write('jsonProfileVisibility: $jsonProfileVisibility')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, jsonProfileVisibility);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProfileVisibilityData &&
          other.id == this.id &&
          other.jsonProfileVisibility == this.jsonProfileVisibility);
}

class ProfileVisibilityCompanion
    extends UpdateCompanion<ProfileVisibilityData> {
  final Value<int> id;
  final Value<EnumString<ProfileVisibility>?> jsonProfileVisibility;
  const ProfileVisibilityCompanion({
    this.id = const Value.absent(),
    this.jsonProfileVisibility = const Value.absent(),
  });
  ProfileVisibilityCompanion.insert({
    this.id = const Value.absent(),
    this.jsonProfileVisibility = const Value.absent(),
  });
  static Insertable<ProfileVisibilityData> custom({
    Expression<int>? id,
    Expression<String>? jsonProfileVisibility,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (jsonProfileVisibility != null)
        'json_profile_visibility': jsonProfileVisibility,
    });
  }

  ProfileVisibilityCompanion copyWith({
    Value<int>? id,
    Value<EnumString<ProfileVisibility>?>? jsonProfileVisibility,
  }) {
    return ProfileVisibilityCompanion(
      id: id ?? this.id,
      jsonProfileVisibility:
          jsonProfileVisibility ?? this.jsonProfileVisibility,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (jsonProfileVisibility.present) {
      map['json_profile_visibility'] = Variable<String>(
        $ProfileVisibilityTable.$converterjsonProfileVisibility.toSql(
          jsonProfileVisibility.value,
        ),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProfileVisibilityCompanion(')
          ..write('id: $id, ')
          ..write('jsonProfileVisibility: $jsonProfileVisibility')
          ..write(')'))
        .toString();
  }
}

class $EmailAddressTable extends schema.EmailAddress
    with TableInfo<$EmailAddressTable, EmailAddressData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EmailAddressTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _emailAddressMeta = const VerificationMeta(
    'emailAddress',
  );
  @override
  late final GeneratedColumn<String> emailAddress = GeneratedColumn<String>(
    'email_address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, emailAddress];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'email_address';
  @override
  VerificationContext validateIntegrity(
    Insertable<EmailAddressData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('email_address')) {
      context.handle(
        _emailAddressMeta,
        emailAddress.isAcceptableOrUnknown(
          data['email_address']!,
          _emailAddressMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EmailAddressData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EmailAddressData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      emailAddress: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email_address'],
      ),
    );
  }

  @override
  $EmailAddressTable createAlias(String alias) {
    return $EmailAddressTable(attachedDatabase, alias);
  }
}

class EmailAddressData extends DataClass
    implements Insertable<EmailAddressData> {
  final int id;
  final String? emailAddress;
  const EmailAddressData({required this.id, this.emailAddress});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || emailAddress != null) {
      map['email_address'] = Variable<String>(emailAddress);
    }
    return map;
  }

  EmailAddressCompanion toCompanion(bool nullToAbsent) {
    return EmailAddressCompanion(
      id: Value(id),
      emailAddress: emailAddress == null && nullToAbsent
          ? const Value.absent()
          : Value(emailAddress),
    );
  }

  factory EmailAddressData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EmailAddressData(
      id: serializer.fromJson<int>(json['id']),
      emailAddress: serializer.fromJson<String?>(json['emailAddress']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'emailAddress': serializer.toJson<String?>(emailAddress),
    };
  }

  EmailAddressData copyWith({
    int? id,
    Value<String?> emailAddress = const Value.absent(),
  }) => EmailAddressData(
    id: id ?? this.id,
    emailAddress: emailAddress.present ? emailAddress.value : this.emailAddress,
  );
  EmailAddressData copyWithCompanion(EmailAddressCompanion data) {
    return EmailAddressData(
      id: data.id.present ? data.id.value : this.id,
      emailAddress: data.emailAddress.present
          ? data.emailAddress.value
          : this.emailAddress,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EmailAddressData(')
          ..write('id: $id, ')
          ..write('emailAddress: $emailAddress')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, emailAddress);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EmailAddressData &&
          other.id == this.id &&
          other.emailAddress == this.emailAddress);
}

class EmailAddressCompanion extends UpdateCompanion<EmailAddressData> {
  final Value<int> id;
  final Value<String?> emailAddress;
  const EmailAddressCompanion({
    this.id = const Value.absent(),
    this.emailAddress = const Value.absent(),
  });
  EmailAddressCompanion.insert({
    this.id = const Value.absent(),
    this.emailAddress = const Value.absent(),
  });
  static Insertable<EmailAddressData> custom({
    Expression<int>? id,
    Expression<String>? emailAddress,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (emailAddress != null) 'email_address': emailAddress,
    });
  }

  EmailAddressCompanion copyWith({
    Value<int>? id,
    Value<String?>? emailAddress,
  }) {
    return EmailAddressCompanion(
      id: id ?? this.id,
      emailAddress: emailAddress ?? this.emailAddress,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (emailAddress.present) {
      map['email_address'] = Variable<String>(emailAddress.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EmailAddressCompanion(')
          ..write('id: $id, ')
          ..write('emailAddress: $emailAddress')
          ..write(')'))
        .toString();
  }
}

class $EmailVerifiedTable extends schema.EmailVerified
    with TableInfo<$EmailVerifiedTable, EmailVerifiedData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EmailVerifiedTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _emailVerifiedMeta = const VerificationMeta(
    'emailVerified',
  );
  @override
  late final GeneratedColumn<bool> emailVerified = GeneratedColumn<bool>(
    'email_verified',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("email_verified" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [id, emailVerified];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'email_verified';
  @override
  VerificationContext validateIntegrity(
    Insertable<EmailVerifiedData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('email_verified')) {
      context.handle(
        _emailVerifiedMeta,
        emailVerified.isAcceptableOrUnknown(
          data['email_verified']!,
          _emailVerifiedMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EmailVerifiedData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EmailVerifiedData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      emailVerified: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}email_verified'],
      )!,
    );
  }

  @override
  $EmailVerifiedTable createAlias(String alias) {
    return $EmailVerifiedTable(attachedDatabase, alias);
  }
}

class EmailVerifiedData extends DataClass
    implements Insertable<EmailVerifiedData> {
  final int id;
  final bool emailVerified;
  const EmailVerifiedData({required this.id, required this.emailVerified});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['email_verified'] = Variable<bool>(emailVerified);
    return map;
  }

  EmailVerifiedCompanion toCompanion(bool nullToAbsent) {
    return EmailVerifiedCompanion(
      id: Value(id),
      emailVerified: Value(emailVerified),
    );
  }

  factory EmailVerifiedData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EmailVerifiedData(
      id: serializer.fromJson<int>(json['id']),
      emailVerified: serializer.fromJson<bool>(json['emailVerified']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'emailVerified': serializer.toJson<bool>(emailVerified),
    };
  }

  EmailVerifiedData copyWith({int? id, bool? emailVerified}) =>
      EmailVerifiedData(
        id: id ?? this.id,
        emailVerified: emailVerified ?? this.emailVerified,
      );
  EmailVerifiedData copyWithCompanion(EmailVerifiedCompanion data) {
    return EmailVerifiedData(
      id: data.id.present ? data.id.value : this.id,
      emailVerified: data.emailVerified.present
          ? data.emailVerified.value
          : this.emailVerified,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EmailVerifiedData(')
          ..write('id: $id, ')
          ..write('emailVerified: $emailVerified')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, emailVerified);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EmailVerifiedData &&
          other.id == this.id &&
          other.emailVerified == this.emailVerified);
}

class EmailVerifiedCompanion extends UpdateCompanion<EmailVerifiedData> {
  final Value<int> id;
  final Value<bool> emailVerified;
  const EmailVerifiedCompanion({
    this.id = const Value.absent(),
    this.emailVerified = const Value.absent(),
  });
  EmailVerifiedCompanion.insert({
    this.id = const Value.absent(),
    this.emailVerified = const Value.absent(),
  });
  static Insertable<EmailVerifiedData> custom({
    Expression<int>? id,
    Expression<bool>? emailVerified,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (emailVerified != null) 'email_verified': emailVerified,
    });
  }

  EmailVerifiedCompanion copyWith({
    Value<int>? id,
    Value<bool>? emailVerified,
  }) {
    return EmailVerifiedCompanion(
      id: id ?? this.id,
      emailVerified: emailVerified ?? this.emailVerified,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (emailVerified.present) {
      map['email_verified'] = Variable<bool>(emailVerified.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EmailVerifiedCompanion(')
          ..write('id: $id, ')
          ..write('emailVerified: $emailVerified')
          ..write(')'))
        .toString();
  }
}

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
  late final GeneratedColumnWithTypeConverter<AccountId, String> accountId =
      GeneratedColumn<String>(
        'account_id',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<AccountId>($AccountIdTable.$converteraccountId);
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
        )!,
      ),
    );
  }

  @override
  $AccountIdTable createAlias(String alias) {
    return $AccountIdTable(attachedDatabase, alias);
  }

  static TypeConverter<AccountId, String> $converteraccountId =
      const AccountIdConverter();
}

class AccountIdData extends DataClass implements Insertable<AccountIdData> {
  final int id;
  final AccountId accountId;
  const AccountIdData({required this.id, required this.accountId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['account_id'] = Variable<String>(
        $AccountIdTable.$converteraccountId.toSql(accountId),
      );
    }
    return map;
  }

  AccountIdCompanion toCompanion(bool nullToAbsent) {
    return AccountIdCompanion(id: Value(id), accountId: Value(accountId));
  }

  factory AccountIdData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AccountIdData(
      id: serializer.fromJson<int>(json['id']),
      accountId: serializer.fromJson<AccountId>(json['accountId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'accountId': serializer.toJson<AccountId>(accountId),
    };
  }

  AccountIdData copyWith({int? id, AccountId? accountId}) =>
      AccountIdData(id: id ?? this.id, accountId: accountId ?? this.accountId);
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
  final Value<AccountId> accountId;
  const AccountIdCompanion({
    this.id = const Value.absent(),
    this.accountId = const Value.absent(),
  });
  AccountIdCompanion.insert({
    this.id = const Value.absent(),
    required AccountId accountId,
  }) : accountId = Value(accountId);
  static Insertable<AccountIdData> custom({
    Expression<int>? id,
    Expression<String>? accountId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (accountId != null) 'account_id': accountId,
    });
  }

  AccountIdCompanion copyWith({Value<int>? id, Value<AccountId>? accountId}) {
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

class $LoginSessionTokensTable extends schema.LoginSessionTokens
    with TableInfo<$LoginSessionTokensTable, LoginSessionToken> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LoginSessionTokensTable(this.attachedDatabase, [this._alias]);
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
  late final GeneratedColumnWithTypeConverter<RefreshToken?, String>
  refreshToken =
      GeneratedColumn<String>(
        'refresh_token',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<RefreshToken?>(
        $LoginSessionTokensTable.$converterrefreshToken,
      );
  @override
  late final GeneratedColumnWithTypeConverter<AccessToken?, String>
  accessToken = GeneratedColumn<String>(
    'access_token',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  ).withConverter<AccessToken?>($LoginSessionTokensTable.$converteraccessToken);
  @override
  List<GeneratedColumn> get $columns => [id, refreshToken, accessToken];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'login_session_tokens';
  @override
  VerificationContext validateIntegrity(
    Insertable<LoginSessionToken> instance, {
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
  LoginSessionToken map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LoginSessionToken(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      refreshToken: $LoginSessionTokensTable.$converterrefreshToken.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}refresh_token'],
        ),
      ),
      accessToken: $LoginSessionTokensTable.$converteraccessToken.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}access_token'],
        ),
      ),
    );
  }

  @override
  $LoginSessionTokensTable createAlias(String alias) {
    return $LoginSessionTokensTable(attachedDatabase, alias);
  }

  static TypeConverter<RefreshToken?, String?> $converterrefreshToken =
      NullAwareTypeConverter.wrap(RefreshTokenConverter());
  static TypeConverter<AccessToken?, String?> $converteraccessToken =
      NullAwareTypeConverter.wrap(AccessTokenConverter());
}

class LoginSessionToken extends DataClass
    implements Insertable<LoginSessionToken> {
  final int id;
  final RefreshToken? refreshToken;
  final AccessToken? accessToken;
  const LoginSessionToken({
    required this.id,
    this.refreshToken,
    this.accessToken,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || refreshToken != null) {
      map['refresh_token'] = Variable<String>(
        $LoginSessionTokensTable.$converterrefreshToken.toSql(refreshToken),
      );
    }
    if (!nullToAbsent || accessToken != null) {
      map['access_token'] = Variable<String>(
        $LoginSessionTokensTable.$converteraccessToken.toSql(accessToken),
      );
    }
    return map;
  }

  LoginSessionTokensCompanion toCompanion(bool nullToAbsent) {
    return LoginSessionTokensCompanion(
      id: Value(id),
      refreshToken: refreshToken == null && nullToAbsent
          ? const Value.absent()
          : Value(refreshToken),
      accessToken: accessToken == null && nullToAbsent
          ? const Value.absent()
          : Value(accessToken),
    );
  }

  factory LoginSessionToken.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LoginSessionToken(
      id: serializer.fromJson<int>(json['id']),
      refreshToken: serializer.fromJson<RefreshToken?>(json['refreshToken']),
      accessToken: serializer.fromJson<AccessToken?>(json['accessToken']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'refreshToken': serializer.toJson<RefreshToken?>(refreshToken),
      'accessToken': serializer.toJson<AccessToken?>(accessToken),
    };
  }

  LoginSessionToken copyWith({
    int? id,
    Value<RefreshToken?> refreshToken = const Value.absent(),
    Value<AccessToken?> accessToken = const Value.absent(),
  }) => LoginSessionToken(
    id: id ?? this.id,
    refreshToken: refreshToken.present ? refreshToken.value : this.refreshToken,
    accessToken: accessToken.present ? accessToken.value : this.accessToken,
  );
  LoginSessionToken copyWithCompanion(LoginSessionTokensCompanion data) {
    return LoginSessionToken(
      id: data.id.present ? data.id.value : this.id,
      refreshToken: data.refreshToken.present
          ? data.refreshToken.value
          : this.refreshToken,
      accessToken: data.accessToken.present
          ? data.accessToken.value
          : this.accessToken,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LoginSessionToken(')
          ..write('id: $id, ')
          ..write('refreshToken: $refreshToken, ')
          ..write('accessToken: $accessToken')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, refreshToken, accessToken);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LoginSessionToken &&
          other.id == this.id &&
          other.refreshToken == this.refreshToken &&
          other.accessToken == this.accessToken);
}

class LoginSessionTokensCompanion extends UpdateCompanion<LoginSessionToken> {
  final Value<int> id;
  final Value<RefreshToken?> refreshToken;
  final Value<AccessToken?> accessToken;
  const LoginSessionTokensCompanion({
    this.id = const Value.absent(),
    this.refreshToken = const Value.absent(),
    this.accessToken = const Value.absent(),
  });
  LoginSessionTokensCompanion.insert({
    this.id = const Value.absent(),
    this.refreshToken = const Value.absent(),
    this.accessToken = const Value.absent(),
  });
  static Insertable<LoginSessionToken> custom({
    Expression<int>? id,
    Expression<String>? refreshToken,
    Expression<String>? accessToken,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (refreshToken != null) 'refresh_token': refreshToken,
      if (accessToken != null) 'access_token': accessToken,
    });
  }

  LoginSessionTokensCompanion copyWith({
    Value<int>? id,
    Value<RefreshToken?>? refreshToken,
    Value<AccessToken?>? accessToken,
  }) {
    return LoginSessionTokensCompanion(
      id: id ?? this.id,
      refreshToken: refreshToken ?? this.refreshToken,
      accessToken: accessToken ?? this.accessToken,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (refreshToken.present) {
      map['refresh_token'] = Variable<String>(
        $LoginSessionTokensTable.$converterrefreshToken.toSql(
          refreshToken.value,
        ),
      );
    }
    if (accessToken.present) {
      map['access_token'] = Variable<String>(
        $LoginSessionTokensTable.$converteraccessToken.toSql(accessToken.value),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LoginSessionTokensCompanion(')
          ..write('id: $id, ')
          ..write('refreshToken: $refreshToken, ')
          ..write('accessToken: $accessToken')
          ..write(')'))
        .toString();
  }
}

class $MyMediaContentTable extends schema.MyMediaContent
    with TableInfo<$MyMediaContentTable, MyMediaContentData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MyMediaContentTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _contentIndexMeta = const VerificationMeta(
    'contentIndex',
  );
  @override
  late final GeneratedColumn<int> contentIndex = GeneratedColumn<int>(
    'content_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<ContentId, String> contentId =
      GeneratedColumn<String>(
        'content_id',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<ContentId>($MyMediaContentTable.$convertercontentId);
  static const VerificationMeta _faceDetectedMeta = const VerificationMeta(
    'faceDetected',
  );
  @override
  late final GeneratedColumn<bool> faceDetected = GeneratedColumn<bool>(
    'face_detected',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("face_detected" IN (0, 1))',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<
    EnumString<ContentModerationState>?,
    String
  >
  moderationState =
      GeneratedColumn<String>(
        'moderation_state',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<EnumString<ContentModerationState>?>(
        $MyMediaContentTable.$convertermoderationState,
      );
  @override
  late final GeneratedColumnWithTypeConverter<
    MediaContentModerationRejectedReasonCategory?,
    int
  >
  contentModerationRejectedCategory =
      GeneratedColumn<int>(
        'content_moderation_rejected_category',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      ).withConverter<MediaContentModerationRejectedReasonCategory?>(
        $MyMediaContentTable.$convertercontentModerationRejectedCategory,
      );
  @override
  late final GeneratedColumnWithTypeConverter<
    MediaContentModerationRejectedReasonDetails?,
    String
  >
  contentModerationRejectedDetails =
      GeneratedColumn<String>(
        'content_moderation_rejected_details',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<MediaContentModerationRejectedReasonDetails?>(
        $MyMediaContentTable.$convertercontentModerationRejectedDetails,
      );
  @override
  List<GeneratedColumn> get $columns => [
    contentIndex,
    contentId,
    faceDetected,
    moderationState,
    contentModerationRejectedCategory,
    contentModerationRejectedDetails,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'my_media_content';
  @override
  VerificationContext validateIntegrity(
    Insertable<MyMediaContentData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('content_index')) {
      context.handle(
        _contentIndexMeta,
        contentIndex.isAcceptableOrUnknown(
          data['content_index']!,
          _contentIndexMeta,
        ),
      );
    }
    if (data.containsKey('face_detected')) {
      context.handle(
        _faceDetectedMeta,
        faceDetected.isAcceptableOrUnknown(
          data['face_detected']!,
          _faceDetectedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_faceDetectedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {contentIndex};
  @override
  MyMediaContentData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MyMediaContentData(
      contentIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}content_index'],
      )!,
      contentId: $MyMediaContentTable.$convertercontentId.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}content_id'],
        )!,
      ),
      faceDetected: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}face_detected'],
      )!,
      moderationState: $MyMediaContentTable.$convertermoderationState.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}moderation_state'],
        ),
      ),
      contentModerationRejectedCategory: $MyMediaContentTable
          .$convertercontentModerationRejectedCategory
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.int,
              data['${effectivePrefix}content_moderation_rejected_category'],
            ),
          ),
      contentModerationRejectedDetails: $MyMediaContentTable
          .$convertercontentModerationRejectedDetails
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}content_moderation_rejected_details'],
            ),
          ),
    );
  }

  @override
  $MyMediaContentTable createAlias(String alias) {
    return $MyMediaContentTable(attachedDatabase, alias);
  }

  static TypeConverter<ContentId, String> $convertercontentId =
      const ContentIdConverter();
  static TypeConverter<EnumString<ContentModerationState>?, String?>
  $convertermoderationState = NullAwareTypeConverter.wrap(
    const ContentModerationStateConverter(),
  );
  static TypeConverter<MediaContentModerationRejectedReasonCategory?, int?>
  $convertercontentModerationRejectedCategory =
      const NullAwareTypeConverter.wrap(
        MediaContentModerationRejectedReasonCategoryConverter(),
      );
  static TypeConverter<MediaContentModerationRejectedReasonDetails?, String?>
  $convertercontentModerationRejectedDetails =
      const NullAwareTypeConverter.wrap(
        MediaContentModerationRejectedReasonDetailsConverter(),
      );
}

class MyMediaContentData extends DataClass
    implements Insertable<MyMediaContentData> {
  /// Security content has index -1. Profile content indexes start from 0.
  final int contentIndex;
  final ContentId contentId;
  final bool faceDetected;
  final EnumString<ContentModerationState>? moderationState;
  final MediaContentModerationRejectedReasonCategory?
  contentModerationRejectedCategory;
  final MediaContentModerationRejectedReasonDetails?
  contentModerationRejectedDetails;
  const MyMediaContentData({
    required this.contentIndex,
    required this.contentId,
    required this.faceDetected,
    this.moderationState,
    this.contentModerationRejectedCategory,
    this.contentModerationRejectedDetails,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['content_index'] = Variable<int>(contentIndex);
    {
      map['content_id'] = Variable<String>(
        $MyMediaContentTable.$convertercontentId.toSql(contentId),
      );
    }
    map['face_detected'] = Variable<bool>(faceDetected);
    if (!nullToAbsent || moderationState != null) {
      map['moderation_state'] = Variable<String>(
        $MyMediaContentTable.$convertermoderationState.toSql(moderationState),
      );
    }
    if (!nullToAbsent || contentModerationRejectedCategory != null) {
      map['content_moderation_rejected_category'] = Variable<int>(
        $MyMediaContentTable.$convertercontentModerationRejectedCategory.toSql(
          contentModerationRejectedCategory,
        ),
      );
    }
    if (!nullToAbsent || contentModerationRejectedDetails != null) {
      map['content_moderation_rejected_details'] = Variable<String>(
        $MyMediaContentTable.$convertercontentModerationRejectedDetails.toSql(
          contentModerationRejectedDetails,
        ),
      );
    }
    return map;
  }

  MyMediaContentCompanion toCompanion(bool nullToAbsent) {
    return MyMediaContentCompanion(
      contentIndex: Value(contentIndex),
      contentId: Value(contentId),
      faceDetected: Value(faceDetected),
      moderationState: moderationState == null && nullToAbsent
          ? const Value.absent()
          : Value(moderationState),
      contentModerationRejectedCategory:
          contentModerationRejectedCategory == null && nullToAbsent
          ? const Value.absent()
          : Value(contentModerationRejectedCategory),
      contentModerationRejectedDetails:
          contentModerationRejectedDetails == null && nullToAbsent
          ? const Value.absent()
          : Value(contentModerationRejectedDetails),
    );
  }

  factory MyMediaContentData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MyMediaContentData(
      contentIndex: serializer.fromJson<int>(json['contentIndex']),
      contentId: serializer.fromJson<ContentId>(json['contentId']),
      faceDetected: serializer.fromJson<bool>(json['faceDetected']),
      moderationState: serializer.fromJson<EnumString<ContentModerationState>?>(
        json['moderationState'],
      ),
      contentModerationRejectedCategory: serializer
          .fromJson<MediaContentModerationRejectedReasonCategory?>(
            json['contentModerationRejectedCategory'],
          ),
      contentModerationRejectedDetails: serializer
          .fromJson<MediaContentModerationRejectedReasonDetails?>(
            json['contentModerationRejectedDetails'],
          ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'contentIndex': serializer.toJson<int>(contentIndex),
      'contentId': serializer.toJson<ContentId>(contentId),
      'faceDetected': serializer.toJson<bool>(faceDetected),
      'moderationState': serializer.toJson<EnumString<ContentModerationState>?>(
        moderationState,
      ),
      'contentModerationRejectedCategory': serializer
          .toJson<MediaContentModerationRejectedReasonCategory?>(
            contentModerationRejectedCategory,
          ),
      'contentModerationRejectedDetails': serializer
          .toJson<MediaContentModerationRejectedReasonDetails?>(
            contentModerationRejectedDetails,
          ),
    };
  }

  MyMediaContentData copyWith({
    int? contentIndex,
    ContentId? contentId,
    bool? faceDetected,
    Value<EnumString<ContentModerationState>?> moderationState =
        const Value.absent(),
    Value<MediaContentModerationRejectedReasonCategory?>
        contentModerationRejectedCategory =
        const Value.absent(),
    Value<MediaContentModerationRejectedReasonDetails?>
        contentModerationRejectedDetails =
        const Value.absent(),
  }) => MyMediaContentData(
    contentIndex: contentIndex ?? this.contentIndex,
    contentId: contentId ?? this.contentId,
    faceDetected: faceDetected ?? this.faceDetected,
    moderationState: moderationState.present
        ? moderationState.value
        : this.moderationState,
    contentModerationRejectedCategory: contentModerationRejectedCategory.present
        ? contentModerationRejectedCategory.value
        : this.contentModerationRejectedCategory,
    contentModerationRejectedDetails: contentModerationRejectedDetails.present
        ? contentModerationRejectedDetails.value
        : this.contentModerationRejectedDetails,
  );
  MyMediaContentData copyWithCompanion(MyMediaContentCompanion data) {
    return MyMediaContentData(
      contentIndex: data.contentIndex.present
          ? data.contentIndex.value
          : this.contentIndex,
      contentId: data.contentId.present ? data.contentId.value : this.contentId,
      faceDetected: data.faceDetected.present
          ? data.faceDetected.value
          : this.faceDetected,
      moderationState: data.moderationState.present
          ? data.moderationState.value
          : this.moderationState,
      contentModerationRejectedCategory:
          data.contentModerationRejectedCategory.present
          ? data.contentModerationRejectedCategory.value
          : this.contentModerationRejectedCategory,
      contentModerationRejectedDetails:
          data.contentModerationRejectedDetails.present
          ? data.contentModerationRejectedDetails.value
          : this.contentModerationRejectedDetails,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MyMediaContentData(')
          ..write('contentIndex: $contentIndex, ')
          ..write('contentId: $contentId, ')
          ..write('faceDetected: $faceDetected, ')
          ..write('moderationState: $moderationState, ')
          ..write(
            'contentModerationRejectedCategory: $contentModerationRejectedCategory, ',
          )
          ..write(
            'contentModerationRejectedDetails: $contentModerationRejectedDetails',
          )
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    contentIndex,
    contentId,
    faceDetected,
    moderationState,
    contentModerationRejectedCategory,
    contentModerationRejectedDetails,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MyMediaContentData &&
          other.contentIndex == this.contentIndex &&
          other.contentId == this.contentId &&
          other.faceDetected == this.faceDetected &&
          other.moderationState == this.moderationState &&
          other.contentModerationRejectedCategory ==
              this.contentModerationRejectedCategory &&
          other.contentModerationRejectedDetails ==
              this.contentModerationRejectedDetails);
}

class MyMediaContentCompanion extends UpdateCompanion<MyMediaContentData> {
  final Value<int> contentIndex;
  final Value<ContentId> contentId;
  final Value<bool> faceDetected;
  final Value<EnumString<ContentModerationState>?> moderationState;
  final Value<MediaContentModerationRejectedReasonCategory?>
  contentModerationRejectedCategory;
  final Value<MediaContentModerationRejectedReasonDetails?>
  contentModerationRejectedDetails;
  const MyMediaContentCompanion({
    this.contentIndex = const Value.absent(),
    this.contentId = const Value.absent(),
    this.faceDetected = const Value.absent(),
    this.moderationState = const Value.absent(),
    this.contentModerationRejectedCategory = const Value.absent(),
    this.contentModerationRejectedDetails = const Value.absent(),
  });
  MyMediaContentCompanion.insert({
    this.contentIndex = const Value.absent(),
    required ContentId contentId,
    required bool faceDetected,
    this.moderationState = const Value.absent(),
    this.contentModerationRejectedCategory = const Value.absent(),
    this.contentModerationRejectedDetails = const Value.absent(),
  }) : contentId = Value(contentId),
       faceDetected = Value(faceDetected);
  static Insertable<MyMediaContentData> custom({
    Expression<int>? contentIndex,
    Expression<String>? contentId,
    Expression<bool>? faceDetected,
    Expression<String>? moderationState,
    Expression<int>? contentModerationRejectedCategory,
    Expression<String>? contentModerationRejectedDetails,
  }) {
    return RawValuesInsertable({
      if (contentIndex != null) 'content_index': contentIndex,
      if (contentId != null) 'content_id': contentId,
      if (faceDetected != null) 'face_detected': faceDetected,
      if (moderationState != null) 'moderation_state': moderationState,
      if (contentModerationRejectedCategory != null)
        'content_moderation_rejected_category':
            contentModerationRejectedCategory,
      if (contentModerationRejectedDetails != null)
        'content_moderation_rejected_details': contentModerationRejectedDetails,
    });
  }

  MyMediaContentCompanion copyWith({
    Value<int>? contentIndex,
    Value<ContentId>? contentId,
    Value<bool>? faceDetected,
    Value<EnumString<ContentModerationState>?>? moderationState,
    Value<MediaContentModerationRejectedReasonCategory?>?
    contentModerationRejectedCategory,
    Value<MediaContentModerationRejectedReasonDetails?>?
    contentModerationRejectedDetails,
  }) {
    return MyMediaContentCompanion(
      contentIndex: contentIndex ?? this.contentIndex,
      contentId: contentId ?? this.contentId,
      faceDetected: faceDetected ?? this.faceDetected,
      moderationState: moderationState ?? this.moderationState,
      contentModerationRejectedCategory:
          contentModerationRejectedCategory ??
          this.contentModerationRejectedCategory,
      contentModerationRejectedDetails:
          contentModerationRejectedDetails ??
          this.contentModerationRejectedDetails,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (contentIndex.present) {
      map['content_index'] = Variable<int>(contentIndex.value);
    }
    if (contentId.present) {
      map['content_id'] = Variable<String>(
        $MyMediaContentTable.$convertercontentId.toSql(contentId.value),
      );
    }
    if (faceDetected.present) {
      map['face_detected'] = Variable<bool>(faceDetected.value);
    }
    if (moderationState.present) {
      map['moderation_state'] = Variable<String>(
        $MyMediaContentTable.$convertermoderationState.toSql(
          moderationState.value,
        ),
      );
    }
    if (contentModerationRejectedCategory.present) {
      map['content_moderation_rejected_category'] = Variable<int>(
        $MyMediaContentTable.$convertercontentModerationRejectedCategory.toSql(
          contentModerationRejectedCategory.value,
        ),
      );
    }
    if (contentModerationRejectedDetails.present) {
      map['content_moderation_rejected_details'] = Variable<String>(
        $MyMediaContentTable.$convertercontentModerationRejectedDetails.toSql(
          contentModerationRejectedDetails.value,
        ),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MyMediaContentCompanion(')
          ..write('contentIndex: $contentIndex, ')
          ..write('contentId: $contentId, ')
          ..write('faceDetected: $faceDetected, ')
          ..write('moderationState: $moderationState, ')
          ..write(
            'contentModerationRejectedCategory: $contentModerationRejectedCategory, ',
          )
          ..write(
            'contentModerationRejectedDetails: $contentModerationRejectedDetails',
          )
          ..write(')'))
        .toString();
  }
}

class $ProfileContentTable extends schema.ProfileContent
    with TableInfo<$ProfileContentTable, ProfileContentData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProfileContentTable(this.attachedDatabase, [this._alias]);
  @override
  late final GeneratedColumnWithTypeConverter<AccountId, String> accountId =
      GeneratedColumn<String>(
        'account_id',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<AccountId>($ProfileContentTable.$converteraccountId);
  static const VerificationMeta _contentIndexMeta = const VerificationMeta(
    'contentIndex',
  );
  @override
  late final GeneratedColumn<int> contentIndex = GeneratedColumn<int>(
    'content_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<ContentId, String> contentId =
      GeneratedColumn<String>(
        'content_id',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<ContentId>($ProfileContentTable.$convertercontentId);
  static const VerificationMeta _contentAcceptedMeta = const VerificationMeta(
    'contentAccepted',
  );
  @override
  late final GeneratedColumn<bool> contentAccepted = GeneratedColumn<bool>(
    'content_accepted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("content_accepted" IN (0, 1))',
    ),
  );
  static const VerificationMeta _primaryContentMeta = const VerificationMeta(
    'primaryContent',
  );
  @override
  late final GeneratedColumn<bool> primaryContent = GeneratedColumn<bool>(
    'primary_content',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("primary_content" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    accountId,
    contentIndex,
    contentId,
    contentAccepted,
    primaryContent,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'profile_content';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProfileContentData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('content_index')) {
      context.handle(
        _contentIndexMeta,
        contentIndex.isAcceptableOrUnknown(
          data['content_index']!,
          _contentIndexMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_contentIndexMeta);
    }
    if (data.containsKey('content_accepted')) {
      context.handle(
        _contentAcceptedMeta,
        contentAccepted.isAcceptableOrUnknown(
          data['content_accepted']!,
          _contentAcceptedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_contentAcceptedMeta);
    }
    if (data.containsKey('primary_content')) {
      context.handle(
        _primaryContentMeta,
        primaryContent.isAcceptableOrUnknown(
          data['primary_content']!,
          _primaryContentMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_primaryContentMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {accountId, contentIndex};
  @override
  ProfileContentData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProfileContentData(
      accountId: $ProfileContentTable.$converteraccountId.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}account_id'],
        )!,
      ),
      contentIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}content_index'],
      )!,
      contentId: $ProfileContentTable.$convertercontentId.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}content_id'],
        )!,
      ),
      contentAccepted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}content_accepted'],
      )!,
      primaryContent: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}primary_content'],
      )!,
    );
  }

  @override
  $ProfileContentTable createAlias(String alias) {
    return $ProfileContentTable(attachedDatabase, alias);
  }

  static TypeConverter<AccountId, String> $converteraccountId =
      const AccountIdConverter();
  static TypeConverter<ContentId, String> $convertercontentId =
      const ContentIdConverter();
}

class ProfileContentData extends DataClass
    implements Insertable<ProfileContentData> {
  final AccountId accountId;
  final int contentIndex;
  final ContentId contentId;
  final bool contentAccepted;
  final bool primaryContent;
  const ProfileContentData({
    required this.accountId,
    required this.contentIndex,
    required this.contentId,
    required this.contentAccepted,
    required this.primaryContent,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    {
      map['account_id'] = Variable<String>(
        $ProfileContentTable.$converteraccountId.toSql(accountId),
      );
    }
    map['content_index'] = Variable<int>(contentIndex);
    {
      map['content_id'] = Variable<String>(
        $ProfileContentTable.$convertercontentId.toSql(contentId),
      );
    }
    map['content_accepted'] = Variable<bool>(contentAccepted);
    map['primary_content'] = Variable<bool>(primaryContent);
    return map;
  }

  ProfileContentCompanion toCompanion(bool nullToAbsent) {
    return ProfileContentCompanion(
      accountId: Value(accountId),
      contentIndex: Value(contentIndex),
      contentId: Value(contentId),
      contentAccepted: Value(contentAccepted),
      primaryContent: Value(primaryContent),
    );
  }

  factory ProfileContentData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProfileContentData(
      accountId: serializer.fromJson<AccountId>(json['accountId']),
      contentIndex: serializer.fromJson<int>(json['contentIndex']),
      contentId: serializer.fromJson<ContentId>(json['contentId']),
      contentAccepted: serializer.fromJson<bool>(json['contentAccepted']),
      primaryContent: serializer.fromJson<bool>(json['primaryContent']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'accountId': serializer.toJson<AccountId>(accountId),
      'contentIndex': serializer.toJson<int>(contentIndex),
      'contentId': serializer.toJson<ContentId>(contentId),
      'contentAccepted': serializer.toJson<bool>(contentAccepted),
      'primaryContent': serializer.toJson<bool>(primaryContent),
    };
  }

  ProfileContentData copyWith({
    AccountId? accountId,
    int? contentIndex,
    ContentId? contentId,
    bool? contentAccepted,
    bool? primaryContent,
  }) => ProfileContentData(
    accountId: accountId ?? this.accountId,
    contentIndex: contentIndex ?? this.contentIndex,
    contentId: contentId ?? this.contentId,
    contentAccepted: contentAccepted ?? this.contentAccepted,
    primaryContent: primaryContent ?? this.primaryContent,
  );
  ProfileContentData copyWithCompanion(ProfileContentCompanion data) {
    return ProfileContentData(
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      contentIndex: data.contentIndex.present
          ? data.contentIndex.value
          : this.contentIndex,
      contentId: data.contentId.present ? data.contentId.value : this.contentId,
      contentAccepted: data.contentAccepted.present
          ? data.contentAccepted.value
          : this.contentAccepted,
      primaryContent: data.primaryContent.present
          ? data.primaryContent.value
          : this.primaryContent,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProfileContentData(')
          ..write('accountId: $accountId, ')
          ..write('contentIndex: $contentIndex, ')
          ..write('contentId: $contentId, ')
          ..write('contentAccepted: $contentAccepted, ')
          ..write('primaryContent: $primaryContent')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    accountId,
    contentIndex,
    contentId,
    contentAccepted,
    primaryContent,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProfileContentData &&
          other.accountId == this.accountId &&
          other.contentIndex == this.contentIndex &&
          other.contentId == this.contentId &&
          other.contentAccepted == this.contentAccepted &&
          other.primaryContent == this.primaryContent);
}

class ProfileContentCompanion extends UpdateCompanion<ProfileContentData> {
  final Value<AccountId> accountId;
  final Value<int> contentIndex;
  final Value<ContentId> contentId;
  final Value<bool> contentAccepted;
  final Value<bool> primaryContent;
  final Value<int> rowid;
  const ProfileContentCompanion({
    this.accountId = const Value.absent(),
    this.contentIndex = const Value.absent(),
    this.contentId = const Value.absent(),
    this.contentAccepted = const Value.absent(),
    this.primaryContent = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProfileContentCompanion.insert({
    required AccountId accountId,
    required int contentIndex,
    required ContentId contentId,
    required bool contentAccepted,
    required bool primaryContent,
    this.rowid = const Value.absent(),
  }) : accountId = Value(accountId),
       contentIndex = Value(contentIndex),
       contentId = Value(contentId),
       contentAccepted = Value(contentAccepted),
       primaryContent = Value(primaryContent);
  static Insertable<ProfileContentData> custom({
    Expression<String>? accountId,
    Expression<int>? contentIndex,
    Expression<String>? contentId,
    Expression<bool>? contentAccepted,
    Expression<bool>? primaryContent,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (accountId != null) 'account_id': accountId,
      if (contentIndex != null) 'content_index': contentIndex,
      if (contentId != null) 'content_id': contentId,
      if (contentAccepted != null) 'content_accepted': contentAccepted,
      if (primaryContent != null) 'primary_content': primaryContent,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProfileContentCompanion copyWith({
    Value<AccountId>? accountId,
    Value<int>? contentIndex,
    Value<ContentId>? contentId,
    Value<bool>? contentAccepted,
    Value<bool>? primaryContent,
    Value<int>? rowid,
  }) {
    return ProfileContentCompanion(
      accountId: accountId ?? this.accountId,
      contentIndex: contentIndex ?? this.contentIndex,
      contentId: contentId ?? this.contentId,
      contentAccepted: contentAccepted ?? this.contentAccepted,
      primaryContent: primaryContent ?? this.primaryContent,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (accountId.present) {
      map['account_id'] = Variable<String>(
        $ProfileContentTable.$converteraccountId.toSql(accountId.value),
      );
    }
    if (contentIndex.present) {
      map['content_index'] = Variable<int>(contentIndex.value);
    }
    if (contentId.present) {
      map['content_id'] = Variable<String>(
        $ProfileContentTable.$convertercontentId.toSql(contentId.value),
      );
    }
    if (contentAccepted.present) {
      map['content_accepted'] = Variable<bool>(contentAccepted.value);
    }
    if (primaryContent.present) {
      map['primary_content'] = Variable<bool>(primaryContent.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProfileContentCompanion(')
          ..write('accountId: $accountId, ')
          ..write('contentIndex: $contentIndex, ')
          ..write('contentId: $contentId, ')
          ..write('contentAccepted: $contentAccepted, ')
          ..write('primaryContent: $primaryContent, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MyProfileTable extends schema.MyProfile
    with TableInfo<$MyProfileTable, MyProfileData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MyProfileTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _profileNameMeta = const VerificationMeta(
    'profileName',
  );
  @override
  late final GeneratedColumn<String> profileName = GeneratedColumn<String>(
    'profile_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _profileNameAcceptedMeta =
      const VerificationMeta('profileNameAccepted');
  @override
  late final GeneratedColumn<bool> profileNameAccepted = GeneratedColumn<bool>(
    'profile_name_accepted',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("profile_name_accepted" IN (0, 1))',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<
    EnumString<ProfileStringModerationState>?,
    String
  >
  profileNameModerationState =
      GeneratedColumn<String>(
        'profile_name_moderation_state',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<EnumString<ProfileStringModerationState>?>(
        $MyProfileTable.$converterprofileNameModerationState,
      );
  @override
  late final GeneratedColumnWithTypeConverter<
    ProfileStringModerationRejectedReasonCategory?,
    int
  >
  profileNameModerationRejectedCategory =
      GeneratedColumn<int>(
        'profile_name_moderation_rejected_category',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      ).withConverter<ProfileStringModerationRejectedReasonCategory?>(
        $MyProfileTable.$converterprofileNameModerationRejectedCategory,
      );
  @override
  late final GeneratedColumnWithTypeConverter<
    ProfileStringModerationRejectedReasonDetails?,
    String
  >
  profileNameModerationRejectedDetails =
      GeneratedColumn<String>(
        'profile_name_moderation_rejected_details',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<ProfileStringModerationRejectedReasonDetails?>(
        $MyProfileTable.$converterprofileNameModerationRejectedDetails,
      );
  static const VerificationMeta _profileTextMeta = const VerificationMeta(
    'profileText',
  );
  @override
  late final GeneratedColumn<String> profileText = GeneratedColumn<String>(
    'profile_text',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _profileTextAcceptedMeta =
      const VerificationMeta('profileTextAccepted');
  @override
  late final GeneratedColumn<bool> profileTextAccepted = GeneratedColumn<bool>(
    'profile_text_accepted',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("profile_text_accepted" IN (0, 1))',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<
    EnumString<ProfileStringModerationState>?,
    String
  >
  profileTextModerationState =
      GeneratedColumn<String>(
        'profile_text_moderation_state',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<EnumString<ProfileStringModerationState>?>(
        $MyProfileTable.$converterprofileTextModerationState,
      );
  @override
  late final GeneratedColumnWithTypeConverter<
    ProfileStringModerationRejectedReasonCategory?,
    int
  >
  profileTextModerationRejectedCategory =
      GeneratedColumn<int>(
        'profile_text_moderation_rejected_category',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      ).withConverter<ProfileStringModerationRejectedReasonCategory?>(
        $MyProfileTable.$converterprofileTextModerationRejectedCategory,
      );
  @override
  late final GeneratedColumnWithTypeConverter<
    ProfileStringModerationRejectedReasonDetails?,
    String
  >
  profileTextModerationRejectedDetails =
      GeneratedColumn<String>(
        'profile_text_moderation_rejected_details',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<ProfileStringModerationRejectedReasonDetails?>(
        $MyProfileTable.$converterprofileTextModerationRejectedDetails,
      );
  static const VerificationMeta _profileAgeMeta = const VerificationMeta(
    'profileAge',
  );
  @override
  late final GeneratedColumn<int> profileAge = GeneratedColumn<int>(
    'profile_age',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _profileUnlimitedLikesMeta =
      const VerificationMeta('profileUnlimitedLikes');
  @override
  late final GeneratedColumn<bool> profileUnlimitedLikes =
      GeneratedColumn<bool>(
        'profile_unlimited_likes',
        aliasedName,
        true,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("profile_unlimited_likes" IN (0, 1))',
        ),
      );
  @override
  late final GeneratedColumnWithTypeConverter<ProfileVersion?, String>
  profileVersion = GeneratedColumn<String>(
    'profile_version',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  ).withConverter<ProfileVersion?>($MyProfileTable.$converterprofileVersion);
  @override
  late final GeneratedColumnWithTypeConverter<
    JsonList<ProfileAttributeValue>?,
    String
  >
  jsonProfileAttributes =
      GeneratedColumn<String>(
        'json_profile_attributes',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<JsonList<ProfileAttributeValue>?>(
        $MyProfileTable.$converterjsonProfileAttributes,
      );
  static const VerificationMeta _primaryContentGridCropSizeMeta =
      const VerificationMeta('primaryContentGridCropSize');
  @override
  late final GeneratedColumn<double> primaryContentGridCropSize =
      GeneratedColumn<double>(
        'primary_content_grid_crop_size',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _primaryContentGridCropXMeta =
      const VerificationMeta('primaryContentGridCropX');
  @override
  late final GeneratedColumn<double> primaryContentGridCropX =
      GeneratedColumn<double>(
        'primary_content_grid_crop_x',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _primaryContentGridCropYMeta =
      const VerificationMeta('primaryContentGridCropY');
  @override
  late final GeneratedColumn<double> primaryContentGridCropY =
      GeneratedColumn<double>(
        'primary_content_grid_crop_y',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  @override
  late final GeneratedColumnWithTypeConverter<ProfileContentVersion?, String>
  profileContentVersion =
      GeneratedColumn<String>(
        'profile_content_version',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<ProfileContentVersion?>(
        $MyProfileTable.$converterprofileContentVersion,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    profileName,
    profileNameAccepted,
    profileNameModerationState,
    profileNameModerationRejectedCategory,
    profileNameModerationRejectedDetails,
    profileText,
    profileTextAccepted,
    profileTextModerationState,
    profileTextModerationRejectedCategory,
    profileTextModerationRejectedDetails,
    profileAge,
    profileUnlimitedLikes,
    profileVersion,
    jsonProfileAttributes,
    primaryContentGridCropSize,
    primaryContentGridCropX,
    primaryContentGridCropY,
    profileContentVersion,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'my_profile';
  @override
  VerificationContext validateIntegrity(
    Insertable<MyProfileData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('profile_name')) {
      context.handle(
        _profileNameMeta,
        profileName.isAcceptableOrUnknown(
          data['profile_name']!,
          _profileNameMeta,
        ),
      );
    }
    if (data.containsKey('profile_name_accepted')) {
      context.handle(
        _profileNameAcceptedMeta,
        profileNameAccepted.isAcceptableOrUnknown(
          data['profile_name_accepted']!,
          _profileNameAcceptedMeta,
        ),
      );
    }
    if (data.containsKey('profile_text')) {
      context.handle(
        _profileTextMeta,
        profileText.isAcceptableOrUnknown(
          data['profile_text']!,
          _profileTextMeta,
        ),
      );
    }
    if (data.containsKey('profile_text_accepted')) {
      context.handle(
        _profileTextAcceptedMeta,
        profileTextAccepted.isAcceptableOrUnknown(
          data['profile_text_accepted']!,
          _profileTextAcceptedMeta,
        ),
      );
    }
    if (data.containsKey('profile_age')) {
      context.handle(
        _profileAgeMeta,
        profileAge.isAcceptableOrUnknown(data['profile_age']!, _profileAgeMeta),
      );
    }
    if (data.containsKey('profile_unlimited_likes')) {
      context.handle(
        _profileUnlimitedLikesMeta,
        profileUnlimitedLikes.isAcceptableOrUnknown(
          data['profile_unlimited_likes']!,
          _profileUnlimitedLikesMeta,
        ),
      );
    }
    if (data.containsKey('primary_content_grid_crop_size')) {
      context.handle(
        _primaryContentGridCropSizeMeta,
        primaryContentGridCropSize.isAcceptableOrUnknown(
          data['primary_content_grid_crop_size']!,
          _primaryContentGridCropSizeMeta,
        ),
      );
    }
    if (data.containsKey('primary_content_grid_crop_x')) {
      context.handle(
        _primaryContentGridCropXMeta,
        primaryContentGridCropX.isAcceptableOrUnknown(
          data['primary_content_grid_crop_x']!,
          _primaryContentGridCropXMeta,
        ),
      );
    }
    if (data.containsKey('primary_content_grid_crop_y')) {
      context.handle(
        _primaryContentGridCropYMeta,
        primaryContentGridCropY.isAcceptableOrUnknown(
          data['primary_content_grid_crop_y']!,
          _primaryContentGridCropYMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MyProfileData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MyProfileData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      profileName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_name'],
      ),
      profileNameAccepted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}profile_name_accepted'],
      ),
      profileNameModerationState: $MyProfileTable
          .$converterprofileNameModerationState
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}profile_name_moderation_state'],
            ),
          ),
      profileNameModerationRejectedCategory: $MyProfileTable
          .$converterprofileNameModerationRejectedCategory
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.int,
              data['${effectivePrefix}profile_name_moderation_rejected_category'],
            ),
          ),
      profileNameModerationRejectedDetails: $MyProfileTable
          .$converterprofileNameModerationRejectedDetails
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}profile_name_moderation_rejected_details'],
            ),
          ),
      profileText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_text'],
      ),
      profileTextAccepted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}profile_text_accepted'],
      ),
      profileTextModerationState: $MyProfileTable
          .$converterprofileTextModerationState
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}profile_text_moderation_state'],
            ),
          ),
      profileTextModerationRejectedCategory: $MyProfileTable
          .$converterprofileTextModerationRejectedCategory
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.int,
              data['${effectivePrefix}profile_text_moderation_rejected_category'],
            ),
          ),
      profileTextModerationRejectedDetails: $MyProfileTable
          .$converterprofileTextModerationRejectedDetails
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}profile_text_moderation_rejected_details'],
            ),
          ),
      profileAge: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}profile_age'],
      ),
      profileUnlimitedLikes: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}profile_unlimited_likes'],
      ),
      profileVersion: $MyProfileTable.$converterprofileVersion.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}profile_version'],
        ),
      ),
      jsonProfileAttributes: $MyProfileTable.$converterjsonProfileAttributes
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}json_profile_attributes'],
            ),
          ),
      primaryContentGridCropSize: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}primary_content_grid_crop_size'],
      ),
      primaryContentGridCropX: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}primary_content_grid_crop_x'],
      ),
      primaryContentGridCropY: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}primary_content_grid_crop_y'],
      ),
      profileContentVersion: $MyProfileTable.$converterprofileContentVersion
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}profile_content_version'],
            ),
          ),
    );
  }

  @override
  $MyProfileTable createAlias(String alias) {
    return $MyProfileTable(attachedDatabase, alias);
  }

  static TypeConverter<EnumString<ProfileStringModerationState>?, String?>
  $converterprofileNameModerationState = NullAwareTypeConverter.wrap(
    const ProfileStringModerationStateConverter(),
  );
  static TypeConverter<ProfileStringModerationRejectedReasonCategory?, int?>
  $converterprofileNameModerationRejectedCategory =
      const NullAwareTypeConverter.wrap(
        ProfileStringModerationRejectedReasonCategoryConverter(),
      );
  static TypeConverter<ProfileStringModerationRejectedReasonDetails?, String?>
  $converterprofileNameModerationRejectedDetails =
      const NullAwareTypeConverter.wrap(
        ProfileStringModerationRejectedReasonDetailsConverter(),
      );
  static TypeConverter<EnumString<ProfileStringModerationState>?, String?>
  $converterprofileTextModerationState = NullAwareTypeConverter.wrap(
    const ProfileStringModerationStateConverter(),
  );
  static TypeConverter<ProfileStringModerationRejectedReasonCategory?, int?>
  $converterprofileTextModerationRejectedCategory =
      const NullAwareTypeConverter.wrap(
        ProfileStringModerationRejectedReasonCategoryConverter(),
      );
  static TypeConverter<ProfileStringModerationRejectedReasonDetails?, String?>
  $converterprofileTextModerationRejectedDetails =
      const NullAwareTypeConverter.wrap(
        ProfileStringModerationRejectedReasonDetailsConverter(),
      );
  static TypeConverter<ProfileVersion?, String?> $converterprofileVersion =
      const NullAwareTypeConverter.wrap(ProfileVersionConverter());
  static TypeConverter<JsonList<ProfileAttributeValue>?, String?>
  $converterjsonProfileAttributes = NullAwareTypeConverter.wrap(
    const ProfileAttributeValueConverter(),
  );
  static TypeConverter<ProfileContentVersion?, String?>
  $converterprofileContentVersion = const NullAwareTypeConverter.wrap(
    ProfileContentVersionConverter(),
  );
}

class MyProfileData extends DataClass implements Insertable<MyProfileData> {
  final int id;
  final String? profileName;
  final bool? profileNameAccepted;
  final EnumString<ProfileStringModerationState>? profileNameModerationState;
  final ProfileStringModerationRejectedReasonCategory?
  profileNameModerationRejectedCategory;
  final ProfileStringModerationRejectedReasonDetails?
  profileNameModerationRejectedDetails;
  final String? profileText;
  final bool? profileTextAccepted;
  final EnumString<ProfileStringModerationState>? profileTextModerationState;
  final ProfileStringModerationRejectedReasonCategory?
  profileTextModerationRejectedCategory;
  final ProfileStringModerationRejectedReasonDetails?
  profileTextModerationRejectedDetails;
  final int? profileAge;
  final bool? profileUnlimitedLikes;
  final ProfileVersion? profileVersion;
  final JsonList<ProfileAttributeValue>? jsonProfileAttributes;
  final double? primaryContentGridCropSize;
  final double? primaryContentGridCropX;
  final double? primaryContentGridCropY;
  final ProfileContentVersion? profileContentVersion;
  const MyProfileData({
    required this.id,
    this.profileName,
    this.profileNameAccepted,
    this.profileNameModerationState,
    this.profileNameModerationRejectedCategory,
    this.profileNameModerationRejectedDetails,
    this.profileText,
    this.profileTextAccepted,
    this.profileTextModerationState,
    this.profileTextModerationRejectedCategory,
    this.profileTextModerationRejectedDetails,
    this.profileAge,
    this.profileUnlimitedLikes,
    this.profileVersion,
    this.jsonProfileAttributes,
    this.primaryContentGridCropSize,
    this.primaryContentGridCropX,
    this.primaryContentGridCropY,
    this.profileContentVersion,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || profileName != null) {
      map['profile_name'] = Variable<String>(profileName);
    }
    if (!nullToAbsent || profileNameAccepted != null) {
      map['profile_name_accepted'] = Variable<bool>(profileNameAccepted);
    }
    if (!nullToAbsent || profileNameModerationState != null) {
      map['profile_name_moderation_state'] = Variable<String>(
        $MyProfileTable.$converterprofileNameModerationState.toSql(
          profileNameModerationState,
        ),
      );
    }
    if (!nullToAbsent || profileNameModerationRejectedCategory != null) {
      map['profile_name_moderation_rejected_category'] = Variable<int>(
        $MyProfileTable.$converterprofileNameModerationRejectedCategory.toSql(
          profileNameModerationRejectedCategory,
        ),
      );
    }
    if (!nullToAbsent || profileNameModerationRejectedDetails != null) {
      map['profile_name_moderation_rejected_details'] = Variable<String>(
        $MyProfileTable.$converterprofileNameModerationRejectedDetails.toSql(
          profileNameModerationRejectedDetails,
        ),
      );
    }
    if (!nullToAbsent || profileText != null) {
      map['profile_text'] = Variable<String>(profileText);
    }
    if (!nullToAbsent || profileTextAccepted != null) {
      map['profile_text_accepted'] = Variable<bool>(profileTextAccepted);
    }
    if (!nullToAbsent || profileTextModerationState != null) {
      map['profile_text_moderation_state'] = Variable<String>(
        $MyProfileTable.$converterprofileTextModerationState.toSql(
          profileTextModerationState,
        ),
      );
    }
    if (!nullToAbsent || profileTextModerationRejectedCategory != null) {
      map['profile_text_moderation_rejected_category'] = Variable<int>(
        $MyProfileTable.$converterprofileTextModerationRejectedCategory.toSql(
          profileTextModerationRejectedCategory,
        ),
      );
    }
    if (!nullToAbsent || profileTextModerationRejectedDetails != null) {
      map['profile_text_moderation_rejected_details'] = Variable<String>(
        $MyProfileTable.$converterprofileTextModerationRejectedDetails.toSql(
          profileTextModerationRejectedDetails,
        ),
      );
    }
    if (!nullToAbsent || profileAge != null) {
      map['profile_age'] = Variable<int>(profileAge);
    }
    if (!nullToAbsent || profileUnlimitedLikes != null) {
      map['profile_unlimited_likes'] = Variable<bool>(profileUnlimitedLikes);
    }
    if (!nullToAbsent || profileVersion != null) {
      map['profile_version'] = Variable<String>(
        $MyProfileTable.$converterprofileVersion.toSql(profileVersion),
      );
    }
    if (!nullToAbsent || jsonProfileAttributes != null) {
      map['json_profile_attributes'] = Variable<String>(
        $MyProfileTable.$converterjsonProfileAttributes.toSql(
          jsonProfileAttributes,
        ),
      );
    }
    if (!nullToAbsent || primaryContentGridCropSize != null) {
      map['primary_content_grid_crop_size'] = Variable<double>(
        primaryContentGridCropSize,
      );
    }
    if (!nullToAbsent || primaryContentGridCropX != null) {
      map['primary_content_grid_crop_x'] = Variable<double>(
        primaryContentGridCropX,
      );
    }
    if (!nullToAbsent || primaryContentGridCropY != null) {
      map['primary_content_grid_crop_y'] = Variable<double>(
        primaryContentGridCropY,
      );
    }
    if (!nullToAbsent || profileContentVersion != null) {
      map['profile_content_version'] = Variable<String>(
        $MyProfileTable.$converterprofileContentVersion.toSql(
          profileContentVersion,
        ),
      );
    }
    return map;
  }

  MyProfileCompanion toCompanion(bool nullToAbsent) {
    return MyProfileCompanion(
      id: Value(id),
      profileName: profileName == null && nullToAbsent
          ? const Value.absent()
          : Value(profileName),
      profileNameAccepted: profileNameAccepted == null && nullToAbsent
          ? const Value.absent()
          : Value(profileNameAccepted),
      profileNameModerationState:
          profileNameModerationState == null && nullToAbsent
          ? const Value.absent()
          : Value(profileNameModerationState),
      profileNameModerationRejectedCategory:
          profileNameModerationRejectedCategory == null && nullToAbsent
          ? const Value.absent()
          : Value(profileNameModerationRejectedCategory),
      profileNameModerationRejectedDetails:
          profileNameModerationRejectedDetails == null && nullToAbsent
          ? const Value.absent()
          : Value(profileNameModerationRejectedDetails),
      profileText: profileText == null && nullToAbsent
          ? const Value.absent()
          : Value(profileText),
      profileTextAccepted: profileTextAccepted == null && nullToAbsent
          ? const Value.absent()
          : Value(profileTextAccepted),
      profileTextModerationState:
          profileTextModerationState == null && nullToAbsent
          ? const Value.absent()
          : Value(profileTextModerationState),
      profileTextModerationRejectedCategory:
          profileTextModerationRejectedCategory == null && nullToAbsent
          ? const Value.absent()
          : Value(profileTextModerationRejectedCategory),
      profileTextModerationRejectedDetails:
          profileTextModerationRejectedDetails == null && nullToAbsent
          ? const Value.absent()
          : Value(profileTextModerationRejectedDetails),
      profileAge: profileAge == null && nullToAbsent
          ? const Value.absent()
          : Value(profileAge),
      profileUnlimitedLikes: profileUnlimitedLikes == null && nullToAbsent
          ? const Value.absent()
          : Value(profileUnlimitedLikes),
      profileVersion: profileVersion == null && nullToAbsent
          ? const Value.absent()
          : Value(profileVersion),
      jsonProfileAttributes: jsonProfileAttributes == null && nullToAbsent
          ? const Value.absent()
          : Value(jsonProfileAttributes),
      primaryContentGridCropSize:
          primaryContentGridCropSize == null && nullToAbsent
          ? const Value.absent()
          : Value(primaryContentGridCropSize),
      primaryContentGridCropX: primaryContentGridCropX == null && nullToAbsent
          ? const Value.absent()
          : Value(primaryContentGridCropX),
      primaryContentGridCropY: primaryContentGridCropY == null && nullToAbsent
          ? const Value.absent()
          : Value(primaryContentGridCropY),
      profileContentVersion: profileContentVersion == null && nullToAbsent
          ? const Value.absent()
          : Value(profileContentVersion),
    );
  }

  factory MyProfileData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MyProfileData(
      id: serializer.fromJson<int>(json['id']),
      profileName: serializer.fromJson<String?>(json['profileName']),
      profileNameAccepted: serializer.fromJson<bool?>(
        json['profileNameAccepted'],
      ),
      profileNameModerationState: serializer
          .fromJson<EnumString<ProfileStringModerationState>?>(
            json['profileNameModerationState'],
          ),
      profileNameModerationRejectedCategory: serializer
          .fromJson<ProfileStringModerationRejectedReasonCategory?>(
            json['profileNameModerationRejectedCategory'],
          ),
      profileNameModerationRejectedDetails: serializer
          .fromJson<ProfileStringModerationRejectedReasonDetails?>(
            json['profileNameModerationRejectedDetails'],
          ),
      profileText: serializer.fromJson<String?>(json['profileText']),
      profileTextAccepted: serializer.fromJson<bool?>(
        json['profileTextAccepted'],
      ),
      profileTextModerationState: serializer
          .fromJson<EnumString<ProfileStringModerationState>?>(
            json['profileTextModerationState'],
          ),
      profileTextModerationRejectedCategory: serializer
          .fromJson<ProfileStringModerationRejectedReasonCategory?>(
            json['profileTextModerationRejectedCategory'],
          ),
      profileTextModerationRejectedDetails: serializer
          .fromJson<ProfileStringModerationRejectedReasonDetails?>(
            json['profileTextModerationRejectedDetails'],
          ),
      profileAge: serializer.fromJson<int?>(json['profileAge']),
      profileUnlimitedLikes: serializer.fromJson<bool?>(
        json['profileUnlimitedLikes'],
      ),
      profileVersion: serializer.fromJson<ProfileVersion?>(
        json['profileVersion'],
      ),
      jsonProfileAttributes: serializer
          .fromJson<JsonList<ProfileAttributeValue>?>(
            json['jsonProfileAttributes'],
          ),
      primaryContentGridCropSize: serializer.fromJson<double?>(
        json['primaryContentGridCropSize'],
      ),
      primaryContentGridCropX: serializer.fromJson<double?>(
        json['primaryContentGridCropX'],
      ),
      primaryContentGridCropY: serializer.fromJson<double?>(
        json['primaryContentGridCropY'],
      ),
      profileContentVersion: serializer.fromJson<ProfileContentVersion?>(
        json['profileContentVersion'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'profileName': serializer.toJson<String?>(profileName),
      'profileNameAccepted': serializer.toJson<bool?>(profileNameAccepted),
      'profileNameModerationState': serializer
          .toJson<EnumString<ProfileStringModerationState>?>(
            profileNameModerationState,
          ),
      'profileNameModerationRejectedCategory': serializer
          .toJson<ProfileStringModerationRejectedReasonCategory?>(
            profileNameModerationRejectedCategory,
          ),
      'profileNameModerationRejectedDetails': serializer
          .toJson<ProfileStringModerationRejectedReasonDetails?>(
            profileNameModerationRejectedDetails,
          ),
      'profileText': serializer.toJson<String?>(profileText),
      'profileTextAccepted': serializer.toJson<bool?>(profileTextAccepted),
      'profileTextModerationState': serializer
          .toJson<EnumString<ProfileStringModerationState>?>(
            profileTextModerationState,
          ),
      'profileTextModerationRejectedCategory': serializer
          .toJson<ProfileStringModerationRejectedReasonCategory?>(
            profileTextModerationRejectedCategory,
          ),
      'profileTextModerationRejectedDetails': serializer
          .toJson<ProfileStringModerationRejectedReasonDetails?>(
            profileTextModerationRejectedDetails,
          ),
      'profileAge': serializer.toJson<int?>(profileAge),
      'profileUnlimitedLikes': serializer.toJson<bool?>(profileUnlimitedLikes),
      'profileVersion': serializer.toJson<ProfileVersion?>(profileVersion),
      'jsonProfileAttributes': serializer
          .toJson<JsonList<ProfileAttributeValue>?>(jsonProfileAttributes),
      'primaryContentGridCropSize': serializer.toJson<double?>(
        primaryContentGridCropSize,
      ),
      'primaryContentGridCropX': serializer.toJson<double?>(
        primaryContentGridCropX,
      ),
      'primaryContentGridCropY': serializer.toJson<double?>(
        primaryContentGridCropY,
      ),
      'profileContentVersion': serializer.toJson<ProfileContentVersion?>(
        profileContentVersion,
      ),
    };
  }

  MyProfileData copyWith({
    int? id,
    Value<String?> profileName = const Value.absent(),
    Value<bool?> profileNameAccepted = const Value.absent(),
    Value<EnumString<ProfileStringModerationState>?>
        profileNameModerationState =
        const Value.absent(),
    Value<ProfileStringModerationRejectedReasonCategory?>
        profileNameModerationRejectedCategory =
        const Value.absent(),
    Value<ProfileStringModerationRejectedReasonDetails?>
        profileNameModerationRejectedDetails =
        const Value.absent(),
    Value<String?> profileText = const Value.absent(),
    Value<bool?> profileTextAccepted = const Value.absent(),
    Value<EnumString<ProfileStringModerationState>?>
        profileTextModerationState =
        const Value.absent(),
    Value<ProfileStringModerationRejectedReasonCategory?>
        profileTextModerationRejectedCategory =
        const Value.absent(),
    Value<ProfileStringModerationRejectedReasonDetails?>
        profileTextModerationRejectedDetails =
        const Value.absent(),
    Value<int?> profileAge = const Value.absent(),
    Value<bool?> profileUnlimitedLikes = const Value.absent(),
    Value<ProfileVersion?> profileVersion = const Value.absent(),
    Value<JsonList<ProfileAttributeValue>?> jsonProfileAttributes =
        const Value.absent(),
    Value<double?> primaryContentGridCropSize = const Value.absent(),
    Value<double?> primaryContentGridCropX = const Value.absent(),
    Value<double?> primaryContentGridCropY = const Value.absent(),
    Value<ProfileContentVersion?> profileContentVersion = const Value.absent(),
  }) => MyProfileData(
    id: id ?? this.id,
    profileName: profileName.present ? profileName.value : this.profileName,
    profileNameAccepted: profileNameAccepted.present
        ? profileNameAccepted.value
        : this.profileNameAccepted,
    profileNameModerationState: profileNameModerationState.present
        ? profileNameModerationState.value
        : this.profileNameModerationState,
    profileNameModerationRejectedCategory:
        profileNameModerationRejectedCategory.present
        ? profileNameModerationRejectedCategory.value
        : this.profileNameModerationRejectedCategory,
    profileNameModerationRejectedDetails:
        profileNameModerationRejectedDetails.present
        ? profileNameModerationRejectedDetails.value
        : this.profileNameModerationRejectedDetails,
    profileText: profileText.present ? profileText.value : this.profileText,
    profileTextAccepted: profileTextAccepted.present
        ? profileTextAccepted.value
        : this.profileTextAccepted,
    profileTextModerationState: profileTextModerationState.present
        ? profileTextModerationState.value
        : this.profileTextModerationState,
    profileTextModerationRejectedCategory:
        profileTextModerationRejectedCategory.present
        ? profileTextModerationRejectedCategory.value
        : this.profileTextModerationRejectedCategory,
    profileTextModerationRejectedDetails:
        profileTextModerationRejectedDetails.present
        ? profileTextModerationRejectedDetails.value
        : this.profileTextModerationRejectedDetails,
    profileAge: profileAge.present ? profileAge.value : this.profileAge,
    profileUnlimitedLikes: profileUnlimitedLikes.present
        ? profileUnlimitedLikes.value
        : this.profileUnlimitedLikes,
    profileVersion: profileVersion.present
        ? profileVersion.value
        : this.profileVersion,
    jsonProfileAttributes: jsonProfileAttributes.present
        ? jsonProfileAttributes.value
        : this.jsonProfileAttributes,
    primaryContentGridCropSize: primaryContentGridCropSize.present
        ? primaryContentGridCropSize.value
        : this.primaryContentGridCropSize,
    primaryContentGridCropX: primaryContentGridCropX.present
        ? primaryContentGridCropX.value
        : this.primaryContentGridCropX,
    primaryContentGridCropY: primaryContentGridCropY.present
        ? primaryContentGridCropY.value
        : this.primaryContentGridCropY,
    profileContentVersion: profileContentVersion.present
        ? profileContentVersion.value
        : this.profileContentVersion,
  );
  MyProfileData copyWithCompanion(MyProfileCompanion data) {
    return MyProfileData(
      id: data.id.present ? data.id.value : this.id,
      profileName: data.profileName.present
          ? data.profileName.value
          : this.profileName,
      profileNameAccepted: data.profileNameAccepted.present
          ? data.profileNameAccepted.value
          : this.profileNameAccepted,
      profileNameModerationState: data.profileNameModerationState.present
          ? data.profileNameModerationState.value
          : this.profileNameModerationState,
      profileNameModerationRejectedCategory:
          data.profileNameModerationRejectedCategory.present
          ? data.profileNameModerationRejectedCategory.value
          : this.profileNameModerationRejectedCategory,
      profileNameModerationRejectedDetails:
          data.profileNameModerationRejectedDetails.present
          ? data.profileNameModerationRejectedDetails.value
          : this.profileNameModerationRejectedDetails,
      profileText: data.profileText.present
          ? data.profileText.value
          : this.profileText,
      profileTextAccepted: data.profileTextAccepted.present
          ? data.profileTextAccepted.value
          : this.profileTextAccepted,
      profileTextModerationState: data.profileTextModerationState.present
          ? data.profileTextModerationState.value
          : this.profileTextModerationState,
      profileTextModerationRejectedCategory:
          data.profileTextModerationRejectedCategory.present
          ? data.profileTextModerationRejectedCategory.value
          : this.profileTextModerationRejectedCategory,
      profileTextModerationRejectedDetails:
          data.profileTextModerationRejectedDetails.present
          ? data.profileTextModerationRejectedDetails.value
          : this.profileTextModerationRejectedDetails,
      profileAge: data.profileAge.present
          ? data.profileAge.value
          : this.profileAge,
      profileUnlimitedLikes: data.profileUnlimitedLikes.present
          ? data.profileUnlimitedLikes.value
          : this.profileUnlimitedLikes,
      profileVersion: data.profileVersion.present
          ? data.profileVersion.value
          : this.profileVersion,
      jsonProfileAttributes: data.jsonProfileAttributes.present
          ? data.jsonProfileAttributes.value
          : this.jsonProfileAttributes,
      primaryContentGridCropSize: data.primaryContentGridCropSize.present
          ? data.primaryContentGridCropSize.value
          : this.primaryContentGridCropSize,
      primaryContentGridCropX: data.primaryContentGridCropX.present
          ? data.primaryContentGridCropX.value
          : this.primaryContentGridCropX,
      primaryContentGridCropY: data.primaryContentGridCropY.present
          ? data.primaryContentGridCropY.value
          : this.primaryContentGridCropY,
      profileContentVersion: data.profileContentVersion.present
          ? data.profileContentVersion.value
          : this.profileContentVersion,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MyProfileData(')
          ..write('id: $id, ')
          ..write('profileName: $profileName, ')
          ..write('profileNameAccepted: $profileNameAccepted, ')
          ..write('profileNameModerationState: $profileNameModerationState, ')
          ..write(
            'profileNameModerationRejectedCategory: $profileNameModerationRejectedCategory, ',
          )
          ..write(
            'profileNameModerationRejectedDetails: $profileNameModerationRejectedDetails, ',
          )
          ..write('profileText: $profileText, ')
          ..write('profileTextAccepted: $profileTextAccepted, ')
          ..write('profileTextModerationState: $profileTextModerationState, ')
          ..write(
            'profileTextModerationRejectedCategory: $profileTextModerationRejectedCategory, ',
          )
          ..write(
            'profileTextModerationRejectedDetails: $profileTextModerationRejectedDetails, ',
          )
          ..write('profileAge: $profileAge, ')
          ..write('profileUnlimitedLikes: $profileUnlimitedLikes, ')
          ..write('profileVersion: $profileVersion, ')
          ..write('jsonProfileAttributes: $jsonProfileAttributes, ')
          ..write('primaryContentGridCropSize: $primaryContentGridCropSize, ')
          ..write('primaryContentGridCropX: $primaryContentGridCropX, ')
          ..write('primaryContentGridCropY: $primaryContentGridCropY, ')
          ..write('profileContentVersion: $profileContentVersion')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    profileName,
    profileNameAccepted,
    profileNameModerationState,
    profileNameModerationRejectedCategory,
    profileNameModerationRejectedDetails,
    profileText,
    profileTextAccepted,
    profileTextModerationState,
    profileTextModerationRejectedCategory,
    profileTextModerationRejectedDetails,
    profileAge,
    profileUnlimitedLikes,
    profileVersion,
    jsonProfileAttributes,
    primaryContentGridCropSize,
    primaryContentGridCropX,
    primaryContentGridCropY,
    profileContentVersion,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MyProfileData &&
          other.id == this.id &&
          other.profileName == this.profileName &&
          other.profileNameAccepted == this.profileNameAccepted &&
          other.profileNameModerationState == this.profileNameModerationState &&
          other.profileNameModerationRejectedCategory ==
              this.profileNameModerationRejectedCategory &&
          other.profileNameModerationRejectedDetails ==
              this.profileNameModerationRejectedDetails &&
          other.profileText == this.profileText &&
          other.profileTextAccepted == this.profileTextAccepted &&
          other.profileTextModerationState == this.profileTextModerationState &&
          other.profileTextModerationRejectedCategory ==
              this.profileTextModerationRejectedCategory &&
          other.profileTextModerationRejectedDetails ==
              this.profileTextModerationRejectedDetails &&
          other.profileAge == this.profileAge &&
          other.profileUnlimitedLikes == this.profileUnlimitedLikes &&
          other.profileVersion == this.profileVersion &&
          other.jsonProfileAttributes == this.jsonProfileAttributes &&
          other.primaryContentGridCropSize == this.primaryContentGridCropSize &&
          other.primaryContentGridCropX == this.primaryContentGridCropX &&
          other.primaryContentGridCropY == this.primaryContentGridCropY &&
          other.profileContentVersion == this.profileContentVersion);
}

class MyProfileCompanion extends UpdateCompanion<MyProfileData> {
  final Value<int> id;
  final Value<String?> profileName;
  final Value<bool?> profileNameAccepted;
  final Value<EnumString<ProfileStringModerationState>?>
  profileNameModerationState;
  final Value<ProfileStringModerationRejectedReasonCategory?>
  profileNameModerationRejectedCategory;
  final Value<ProfileStringModerationRejectedReasonDetails?>
  profileNameModerationRejectedDetails;
  final Value<String?> profileText;
  final Value<bool?> profileTextAccepted;
  final Value<EnumString<ProfileStringModerationState>?>
  profileTextModerationState;
  final Value<ProfileStringModerationRejectedReasonCategory?>
  profileTextModerationRejectedCategory;
  final Value<ProfileStringModerationRejectedReasonDetails?>
  profileTextModerationRejectedDetails;
  final Value<int?> profileAge;
  final Value<bool?> profileUnlimitedLikes;
  final Value<ProfileVersion?> profileVersion;
  final Value<JsonList<ProfileAttributeValue>?> jsonProfileAttributes;
  final Value<double?> primaryContentGridCropSize;
  final Value<double?> primaryContentGridCropX;
  final Value<double?> primaryContentGridCropY;
  final Value<ProfileContentVersion?> profileContentVersion;
  const MyProfileCompanion({
    this.id = const Value.absent(),
    this.profileName = const Value.absent(),
    this.profileNameAccepted = const Value.absent(),
    this.profileNameModerationState = const Value.absent(),
    this.profileNameModerationRejectedCategory = const Value.absent(),
    this.profileNameModerationRejectedDetails = const Value.absent(),
    this.profileText = const Value.absent(),
    this.profileTextAccepted = const Value.absent(),
    this.profileTextModerationState = const Value.absent(),
    this.profileTextModerationRejectedCategory = const Value.absent(),
    this.profileTextModerationRejectedDetails = const Value.absent(),
    this.profileAge = const Value.absent(),
    this.profileUnlimitedLikes = const Value.absent(),
    this.profileVersion = const Value.absent(),
    this.jsonProfileAttributes = const Value.absent(),
    this.primaryContentGridCropSize = const Value.absent(),
    this.primaryContentGridCropX = const Value.absent(),
    this.primaryContentGridCropY = const Value.absent(),
    this.profileContentVersion = const Value.absent(),
  });
  MyProfileCompanion.insert({
    this.id = const Value.absent(),
    this.profileName = const Value.absent(),
    this.profileNameAccepted = const Value.absent(),
    this.profileNameModerationState = const Value.absent(),
    this.profileNameModerationRejectedCategory = const Value.absent(),
    this.profileNameModerationRejectedDetails = const Value.absent(),
    this.profileText = const Value.absent(),
    this.profileTextAccepted = const Value.absent(),
    this.profileTextModerationState = const Value.absent(),
    this.profileTextModerationRejectedCategory = const Value.absent(),
    this.profileTextModerationRejectedDetails = const Value.absent(),
    this.profileAge = const Value.absent(),
    this.profileUnlimitedLikes = const Value.absent(),
    this.profileVersion = const Value.absent(),
    this.jsonProfileAttributes = const Value.absent(),
    this.primaryContentGridCropSize = const Value.absent(),
    this.primaryContentGridCropX = const Value.absent(),
    this.primaryContentGridCropY = const Value.absent(),
    this.profileContentVersion = const Value.absent(),
  });
  static Insertable<MyProfileData> custom({
    Expression<int>? id,
    Expression<String>? profileName,
    Expression<bool>? profileNameAccepted,
    Expression<String>? profileNameModerationState,
    Expression<int>? profileNameModerationRejectedCategory,
    Expression<String>? profileNameModerationRejectedDetails,
    Expression<String>? profileText,
    Expression<bool>? profileTextAccepted,
    Expression<String>? profileTextModerationState,
    Expression<int>? profileTextModerationRejectedCategory,
    Expression<String>? profileTextModerationRejectedDetails,
    Expression<int>? profileAge,
    Expression<bool>? profileUnlimitedLikes,
    Expression<String>? profileVersion,
    Expression<String>? jsonProfileAttributes,
    Expression<double>? primaryContentGridCropSize,
    Expression<double>? primaryContentGridCropX,
    Expression<double>? primaryContentGridCropY,
    Expression<String>? profileContentVersion,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (profileName != null) 'profile_name': profileName,
      if (profileNameAccepted != null)
        'profile_name_accepted': profileNameAccepted,
      if (profileNameModerationState != null)
        'profile_name_moderation_state': profileNameModerationState,
      if (profileNameModerationRejectedCategory != null)
        'profile_name_moderation_rejected_category':
            profileNameModerationRejectedCategory,
      if (profileNameModerationRejectedDetails != null)
        'profile_name_moderation_rejected_details':
            profileNameModerationRejectedDetails,
      if (profileText != null) 'profile_text': profileText,
      if (profileTextAccepted != null)
        'profile_text_accepted': profileTextAccepted,
      if (profileTextModerationState != null)
        'profile_text_moderation_state': profileTextModerationState,
      if (profileTextModerationRejectedCategory != null)
        'profile_text_moderation_rejected_category':
            profileTextModerationRejectedCategory,
      if (profileTextModerationRejectedDetails != null)
        'profile_text_moderation_rejected_details':
            profileTextModerationRejectedDetails,
      if (profileAge != null) 'profile_age': profileAge,
      if (profileUnlimitedLikes != null)
        'profile_unlimited_likes': profileUnlimitedLikes,
      if (profileVersion != null) 'profile_version': profileVersion,
      if (jsonProfileAttributes != null)
        'json_profile_attributes': jsonProfileAttributes,
      if (primaryContentGridCropSize != null)
        'primary_content_grid_crop_size': primaryContentGridCropSize,
      if (primaryContentGridCropX != null)
        'primary_content_grid_crop_x': primaryContentGridCropX,
      if (primaryContentGridCropY != null)
        'primary_content_grid_crop_y': primaryContentGridCropY,
      if (profileContentVersion != null)
        'profile_content_version': profileContentVersion,
    });
  }

  MyProfileCompanion copyWith({
    Value<int>? id,
    Value<String?>? profileName,
    Value<bool?>? profileNameAccepted,
    Value<EnumString<ProfileStringModerationState>?>?
    profileNameModerationState,
    Value<ProfileStringModerationRejectedReasonCategory?>?
    profileNameModerationRejectedCategory,
    Value<ProfileStringModerationRejectedReasonDetails?>?
    profileNameModerationRejectedDetails,
    Value<String?>? profileText,
    Value<bool?>? profileTextAccepted,
    Value<EnumString<ProfileStringModerationState>?>?
    profileTextModerationState,
    Value<ProfileStringModerationRejectedReasonCategory?>?
    profileTextModerationRejectedCategory,
    Value<ProfileStringModerationRejectedReasonDetails?>?
    profileTextModerationRejectedDetails,
    Value<int?>? profileAge,
    Value<bool?>? profileUnlimitedLikes,
    Value<ProfileVersion?>? profileVersion,
    Value<JsonList<ProfileAttributeValue>?>? jsonProfileAttributes,
    Value<double?>? primaryContentGridCropSize,
    Value<double?>? primaryContentGridCropX,
    Value<double?>? primaryContentGridCropY,
    Value<ProfileContentVersion?>? profileContentVersion,
  }) {
    return MyProfileCompanion(
      id: id ?? this.id,
      profileName: profileName ?? this.profileName,
      profileNameAccepted: profileNameAccepted ?? this.profileNameAccepted,
      profileNameModerationState:
          profileNameModerationState ?? this.profileNameModerationState,
      profileNameModerationRejectedCategory:
          profileNameModerationRejectedCategory ??
          this.profileNameModerationRejectedCategory,
      profileNameModerationRejectedDetails:
          profileNameModerationRejectedDetails ??
          this.profileNameModerationRejectedDetails,
      profileText: profileText ?? this.profileText,
      profileTextAccepted: profileTextAccepted ?? this.profileTextAccepted,
      profileTextModerationState:
          profileTextModerationState ?? this.profileTextModerationState,
      profileTextModerationRejectedCategory:
          profileTextModerationRejectedCategory ??
          this.profileTextModerationRejectedCategory,
      profileTextModerationRejectedDetails:
          profileTextModerationRejectedDetails ??
          this.profileTextModerationRejectedDetails,
      profileAge: profileAge ?? this.profileAge,
      profileUnlimitedLikes:
          profileUnlimitedLikes ?? this.profileUnlimitedLikes,
      profileVersion: profileVersion ?? this.profileVersion,
      jsonProfileAttributes:
          jsonProfileAttributes ?? this.jsonProfileAttributes,
      primaryContentGridCropSize:
          primaryContentGridCropSize ?? this.primaryContentGridCropSize,
      primaryContentGridCropX:
          primaryContentGridCropX ?? this.primaryContentGridCropX,
      primaryContentGridCropY:
          primaryContentGridCropY ?? this.primaryContentGridCropY,
      profileContentVersion:
          profileContentVersion ?? this.profileContentVersion,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (profileName.present) {
      map['profile_name'] = Variable<String>(profileName.value);
    }
    if (profileNameAccepted.present) {
      map['profile_name_accepted'] = Variable<bool>(profileNameAccepted.value);
    }
    if (profileNameModerationState.present) {
      map['profile_name_moderation_state'] = Variable<String>(
        $MyProfileTable.$converterprofileNameModerationState.toSql(
          profileNameModerationState.value,
        ),
      );
    }
    if (profileNameModerationRejectedCategory.present) {
      map['profile_name_moderation_rejected_category'] = Variable<int>(
        $MyProfileTable.$converterprofileNameModerationRejectedCategory.toSql(
          profileNameModerationRejectedCategory.value,
        ),
      );
    }
    if (profileNameModerationRejectedDetails.present) {
      map['profile_name_moderation_rejected_details'] = Variable<String>(
        $MyProfileTable.$converterprofileNameModerationRejectedDetails.toSql(
          profileNameModerationRejectedDetails.value,
        ),
      );
    }
    if (profileText.present) {
      map['profile_text'] = Variable<String>(profileText.value);
    }
    if (profileTextAccepted.present) {
      map['profile_text_accepted'] = Variable<bool>(profileTextAccepted.value);
    }
    if (profileTextModerationState.present) {
      map['profile_text_moderation_state'] = Variable<String>(
        $MyProfileTable.$converterprofileTextModerationState.toSql(
          profileTextModerationState.value,
        ),
      );
    }
    if (profileTextModerationRejectedCategory.present) {
      map['profile_text_moderation_rejected_category'] = Variable<int>(
        $MyProfileTable.$converterprofileTextModerationRejectedCategory.toSql(
          profileTextModerationRejectedCategory.value,
        ),
      );
    }
    if (profileTextModerationRejectedDetails.present) {
      map['profile_text_moderation_rejected_details'] = Variable<String>(
        $MyProfileTable.$converterprofileTextModerationRejectedDetails.toSql(
          profileTextModerationRejectedDetails.value,
        ),
      );
    }
    if (profileAge.present) {
      map['profile_age'] = Variable<int>(profileAge.value);
    }
    if (profileUnlimitedLikes.present) {
      map['profile_unlimited_likes'] = Variable<bool>(
        profileUnlimitedLikes.value,
      );
    }
    if (profileVersion.present) {
      map['profile_version'] = Variable<String>(
        $MyProfileTable.$converterprofileVersion.toSql(profileVersion.value),
      );
    }
    if (jsonProfileAttributes.present) {
      map['json_profile_attributes'] = Variable<String>(
        $MyProfileTable.$converterjsonProfileAttributes.toSql(
          jsonProfileAttributes.value,
        ),
      );
    }
    if (primaryContentGridCropSize.present) {
      map['primary_content_grid_crop_size'] = Variable<double>(
        primaryContentGridCropSize.value,
      );
    }
    if (primaryContentGridCropX.present) {
      map['primary_content_grid_crop_x'] = Variable<double>(
        primaryContentGridCropX.value,
      );
    }
    if (primaryContentGridCropY.present) {
      map['primary_content_grid_crop_y'] = Variable<double>(
        primaryContentGridCropY.value,
      );
    }
    if (profileContentVersion.present) {
      map['profile_content_version'] = Variable<String>(
        $MyProfileTable.$converterprofileContentVersion.toSql(
          profileContentVersion.value,
        ),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MyProfileCompanion(')
          ..write('id: $id, ')
          ..write('profileName: $profileName, ')
          ..write('profileNameAccepted: $profileNameAccepted, ')
          ..write('profileNameModerationState: $profileNameModerationState, ')
          ..write(
            'profileNameModerationRejectedCategory: $profileNameModerationRejectedCategory, ',
          )
          ..write(
            'profileNameModerationRejectedDetails: $profileNameModerationRejectedDetails, ',
          )
          ..write('profileText: $profileText, ')
          ..write('profileTextAccepted: $profileTextAccepted, ')
          ..write('profileTextModerationState: $profileTextModerationState, ')
          ..write(
            'profileTextModerationRejectedCategory: $profileTextModerationRejectedCategory, ',
          )
          ..write(
            'profileTextModerationRejectedDetails: $profileTextModerationRejectedDetails, ',
          )
          ..write('profileAge: $profileAge, ')
          ..write('profileUnlimitedLikes: $profileUnlimitedLikes, ')
          ..write('profileVersion: $profileVersion, ')
          ..write('jsonProfileAttributes: $jsonProfileAttributes, ')
          ..write('primaryContentGridCropSize: $primaryContentGridCropSize, ')
          ..write('primaryContentGridCropX: $primaryContentGridCropX, ')
          ..write('primaryContentGridCropY: $primaryContentGridCropY, ')
          ..write('profileContentVersion: $profileContentVersion')
          ..write(')'))
        .toString();
  }
}

class $ProfileTable extends schema.Profile
    with TableInfo<$ProfileTable, ProfileData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProfileTable(this.attachedDatabase, [this._alias]);
  @override
  late final GeneratedColumnWithTypeConverter<AccountId, String> accountId =
      GeneratedColumn<String>(
        'account_id',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<AccountId>($ProfileTable.$converteraccountId);
  @override
  late final GeneratedColumnWithTypeConverter<ProfileContentVersion?, String>
  profileContentVersion =
      GeneratedColumn<String>(
        'profile_content_version',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<ProfileContentVersion?>(
        $ProfileTable.$converterprofileContentVersion,
      );
  static const VerificationMeta _profileNameMeta = const VerificationMeta(
    'profileName',
  );
  @override
  late final GeneratedColumn<String> profileName = GeneratedColumn<String>(
    'profile_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _profileNameAcceptedMeta =
      const VerificationMeta('profileNameAccepted');
  @override
  late final GeneratedColumn<bool> profileNameAccepted = GeneratedColumn<bool>(
    'profile_name_accepted',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("profile_name_accepted" IN (0, 1))',
    ),
  );
  static const VerificationMeta _profileTextMeta = const VerificationMeta(
    'profileText',
  );
  @override
  late final GeneratedColumn<String> profileText = GeneratedColumn<String>(
    'profile_text',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _profileTextAcceptedMeta =
      const VerificationMeta('profileTextAccepted');
  @override
  late final GeneratedColumn<bool> profileTextAccepted = GeneratedColumn<bool>(
    'profile_text_accepted',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("profile_text_accepted" IN (0, 1))',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<ProfileVersion?, String>
  profileVersion = GeneratedColumn<String>(
    'profile_version',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  ).withConverter<ProfileVersion?>($ProfileTable.$converterprofileVersion);
  static const VerificationMeta _profileAgeMeta = const VerificationMeta(
    'profileAge',
  );
  @override
  late final GeneratedColumn<int> profileAge = GeneratedColumn<int>(
    'profile_age',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _profileLastSeenTimeValueMeta =
      const VerificationMeta('profileLastSeenTimeValue');
  @override
  late final GeneratedColumn<int> profileLastSeenTimeValue =
      GeneratedColumn<int>(
        'profile_last_seen_time_value',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _profileUnlimitedLikesMeta =
      const VerificationMeta('profileUnlimitedLikes');
  @override
  late final GeneratedColumn<bool> profileUnlimitedLikes =
      GeneratedColumn<bool>(
        'profile_unlimited_likes',
        aliasedName,
        true,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("profile_unlimited_likes" IN (0, 1))',
        ),
      );
  @override
  late final GeneratedColumnWithTypeConverter<
    JsonList<ProfileAttributeValue>?,
    String
  >
  jsonProfileAttributes =
      GeneratedColumn<String>(
        'json_profile_attributes',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<JsonList<ProfileAttributeValue>?>(
        $ProfileTable.$converterjsonProfileAttributes,
      );
  static const VerificationMeta _primaryContentGridCropSizeMeta =
      const VerificationMeta('primaryContentGridCropSize');
  @override
  late final GeneratedColumn<double> primaryContentGridCropSize =
      GeneratedColumn<double>(
        'primary_content_grid_crop_size',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _primaryContentGridCropXMeta =
      const VerificationMeta('primaryContentGridCropX');
  @override
  late final GeneratedColumn<double> primaryContentGridCropX =
      GeneratedColumn<double>(
        'primary_content_grid_crop_x',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _primaryContentGridCropYMeta =
      const VerificationMeta('primaryContentGridCropY');
  @override
  late final GeneratedColumn<double> primaryContentGridCropY =
      GeneratedColumn<double>(
        'primary_content_grid_crop_y',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  @override
  late final GeneratedColumnWithTypeConverter<UtcDateTime?, int>
  profileDataRefreshTime = GeneratedColumn<int>(
    'profile_data_refresh_time',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  ).withConverter<UtcDateTime?>($ProfileTable.$converterprofileDataRefreshTime);
  @override
  late final GeneratedColumnWithTypeConverter<UtcDateTime?, int>
  newLikeInfoReceivedTime =
      GeneratedColumn<int>(
        'new_like_info_received_time',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      ).withConverter<UtcDateTime?>(
        $ProfileTable.$converternewLikeInfoReceivedTime,
      );
  @override
  List<GeneratedColumn> get $columns => [
    accountId,
    profileContentVersion,
    profileName,
    profileNameAccepted,
    profileText,
    profileTextAccepted,
    profileVersion,
    profileAge,
    profileLastSeenTimeValue,
    profileUnlimitedLikes,
    jsonProfileAttributes,
    primaryContentGridCropSize,
    primaryContentGridCropX,
    primaryContentGridCropY,
    profileDataRefreshTime,
    newLikeInfoReceivedTime,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'profile';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProfileData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('profile_name')) {
      context.handle(
        _profileNameMeta,
        profileName.isAcceptableOrUnknown(
          data['profile_name']!,
          _profileNameMeta,
        ),
      );
    }
    if (data.containsKey('profile_name_accepted')) {
      context.handle(
        _profileNameAcceptedMeta,
        profileNameAccepted.isAcceptableOrUnknown(
          data['profile_name_accepted']!,
          _profileNameAcceptedMeta,
        ),
      );
    }
    if (data.containsKey('profile_text')) {
      context.handle(
        _profileTextMeta,
        profileText.isAcceptableOrUnknown(
          data['profile_text']!,
          _profileTextMeta,
        ),
      );
    }
    if (data.containsKey('profile_text_accepted')) {
      context.handle(
        _profileTextAcceptedMeta,
        profileTextAccepted.isAcceptableOrUnknown(
          data['profile_text_accepted']!,
          _profileTextAcceptedMeta,
        ),
      );
    }
    if (data.containsKey('profile_age')) {
      context.handle(
        _profileAgeMeta,
        profileAge.isAcceptableOrUnknown(data['profile_age']!, _profileAgeMeta),
      );
    }
    if (data.containsKey('profile_last_seen_time_value')) {
      context.handle(
        _profileLastSeenTimeValueMeta,
        profileLastSeenTimeValue.isAcceptableOrUnknown(
          data['profile_last_seen_time_value']!,
          _profileLastSeenTimeValueMeta,
        ),
      );
    }
    if (data.containsKey('profile_unlimited_likes')) {
      context.handle(
        _profileUnlimitedLikesMeta,
        profileUnlimitedLikes.isAcceptableOrUnknown(
          data['profile_unlimited_likes']!,
          _profileUnlimitedLikesMeta,
        ),
      );
    }
    if (data.containsKey('primary_content_grid_crop_size')) {
      context.handle(
        _primaryContentGridCropSizeMeta,
        primaryContentGridCropSize.isAcceptableOrUnknown(
          data['primary_content_grid_crop_size']!,
          _primaryContentGridCropSizeMeta,
        ),
      );
    }
    if (data.containsKey('primary_content_grid_crop_x')) {
      context.handle(
        _primaryContentGridCropXMeta,
        primaryContentGridCropX.isAcceptableOrUnknown(
          data['primary_content_grid_crop_x']!,
          _primaryContentGridCropXMeta,
        ),
      );
    }
    if (data.containsKey('primary_content_grid_crop_y')) {
      context.handle(
        _primaryContentGridCropYMeta,
        primaryContentGridCropY.isAcceptableOrUnknown(
          data['primary_content_grid_crop_y']!,
          _primaryContentGridCropYMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {accountId};
  @override
  ProfileData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProfileData(
      accountId: $ProfileTable.$converteraccountId.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}account_id'],
        )!,
      ),
      profileContentVersion: $ProfileTable.$converterprofileContentVersion
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}profile_content_version'],
            ),
          ),
      profileName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_name'],
      ),
      profileNameAccepted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}profile_name_accepted'],
      ),
      profileText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_text'],
      ),
      profileTextAccepted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}profile_text_accepted'],
      ),
      profileVersion: $ProfileTable.$converterprofileVersion.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}profile_version'],
        ),
      ),
      profileAge: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}profile_age'],
      ),
      profileLastSeenTimeValue: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}profile_last_seen_time_value'],
      ),
      profileUnlimitedLikes: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}profile_unlimited_likes'],
      ),
      jsonProfileAttributes: $ProfileTable.$converterjsonProfileAttributes
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}json_profile_attributes'],
            ),
          ),
      primaryContentGridCropSize: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}primary_content_grid_crop_size'],
      ),
      primaryContentGridCropX: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}primary_content_grid_crop_x'],
      ),
      primaryContentGridCropY: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}primary_content_grid_crop_y'],
      ),
      profileDataRefreshTime: $ProfileTable.$converterprofileDataRefreshTime
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.int,
              data['${effectivePrefix}profile_data_refresh_time'],
            ),
          ),
      newLikeInfoReceivedTime: $ProfileTable.$converternewLikeInfoReceivedTime
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.int,
              data['${effectivePrefix}new_like_info_received_time'],
            ),
          ),
    );
  }

  @override
  $ProfileTable createAlias(String alias) {
    return $ProfileTable(attachedDatabase, alias);
  }

  static TypeConverter<AccountId, String> $converteraccountId =
      const AccountIdConverter();
  static TypeConverter<ProfileContentVersion?, String?>
  $converterprofileContentVersion = const NullAwareTypeConverter.wrap(
    ProfileContentVersionConverter(),
  );
  static TypeConverter<ProfileVersion?, String?> $converterprofileVersion =
      const NullAwareTypeConverter.wrap(ProfileVersionConverter());
  static TypeConverter<JsonList<ProfileAttributeValue>?, String?>
  $converterjsonProfileAttributes = NullAwareTypeConverter.wrap(
    const ProfileAttributeValueConverter(),
  );
  static TypeConverter<UtcDateTime?, int?> $converterprofileDataRefreshTime =
      const NullAwareTypeConverter.wrap(UtcDateTimeConverter());
  static TypeConverter<UtcDateTime?, int?> $converternewLikeInfoReceivedTime =
      const NullAwareTypeConverter.wrap(UtcDateTimeConverter());
}

class ProfileData extends DataClass implements Insertable<ProfileData> {
  final AccountId accountId;
  final ProfileContentVersion? profileContentVersion;
  final String? profileName;
  final bool? profileNameAccepted;
  final String? profileText;
  final bool? profileTextAccepted;
  final ProfileVersion? profileVersion;
  final int? profileAge;
  final int? profileLastSeenTimeValue;
  final bool? profileUnlimitedLikes;
  final JsonList<ProfileAttributeValue>? jsonProfileAttributes;
  final double? primaryContentGridCropSize;
  final double? primaryContentGridCropX;
  final double? primaryContentGridCropY;
  final UtcDateTime? profileDataRefreshTime;
  final UtcDateTime? newLikeInfoReceivedTime;
  const ProfileData({
    required this.accountId,
    this.profileContentVersion,
    this.profileName,
    this.profileNameAccepted,
    this.profileText,
    this.profileTextAccepted,
    this.profileVersion,
    this.profileAge,
    this.profileLastSeenTimeValue,
    this.profileUnlimitedLikes,
    this.jsonProfileAttributes,
    this.primaryContentGridCropSize,
    this.primaryContentGridCropX,
    this.primaryContentGridCropY,
    this.profileDataRefreshTime,
    this.newLikeInfoReceivedTime,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    {
      map['account_id'] = Variable<String>(
        $ProfileTable.$converteraccountId.toSql(accountId),
      );
    }
    if (!nullToAbsent || profileContentVersion != null) {
      map['profile_content_version'] = Variable<String>(
        $ProfileTable.$converterprofileContentVersion.toSql(
          profileContentVersion,
        ),
      );
    }
    if (!nullToAbsent || profileName != null) {
      map['profile_name'] = Variable<String>(profileName);
    }
    if (!nullToAbsent || profileNameAccepted != null) {
      map['profile_name_accepted'] = Variable<bool>(profileNameAccepted);
    }
    if (!nullToAbsent || profileText != null) {
      map['profile_text'] = Variable<String>(profileText);
    }
    if (!nullToAbsent || profileTextAccepted != null) {
      map['profile_text_accepted'] = Variable<bool>(profileTextAccepted);
    }
    if (!nullToAbsent || profileVersion != null) {
      map['profile_version'] = Variable<String>(
        $ProfileTable.$converterprofileVersion.toSql(profileVersion),
      );
    }
    if (!nullToAbsent || profileAge != null) {
      map['profile_age'] = Variable<int>(profileAge);
    }
    if (!nullToAbsent || profileLastSeenTimeValue != null) {
      map['profile_last_seen_time_value'] = Variable<int>(
        profileLastSeenTimeValue,
      );
    }
    if (!nullToAbsent || profileUnlimitedLikes != null) {
      map['profile_unlimited_likes'] = Variable<bool>(profileUnlimitedLikes);
    }
    if (!nullToAbsent || jsonProfileAttributes != null) {
      map['json_profile_attributes'] = Variable<String>(
        $ProfileTable.$converterjsonProfileAttributes.toSql(
          jsonProfileAttributes,
        ),
      );
    }
    if (!nullToAbsent || primaryContentGridCropSize != null) {
      map['primary_content_grid_crop_size'] = Variable<double>(
        primaryContentGridCropSize,
      );
    }
    if (!nullToAbsent || primaryContentGridCropX != null) {
      map['primary_content_grid_crop_x'] = Variable<double>(
        primaryContentGridCropX,
      );
    }
    if (!nullToAbsent || primaryContentGridCropY != null) {
      map['primary_content_grid_crop_y'] = Variable<double>(
        primaryContentGridCropY,
      );
    }
    if (!nullToAbsent || profileDataRefreshTime != null) {
      map['profile_data_refresh_time'] = Variable<int>(
        $ProfileTable.$converterprofileDataRefreshTime.toSql(
          profileDataRefreshTime,
        ),
      );
    }
    if (!nullToAbsent || newLikeInfoReceivedTime != null) {
      map['new_like_info_received_time'] = Variable<int>(
        $ProfileTable.$converternewLikeInfoReceivedTime.toSql(
          newLikeInfoReceivedTime,
        ),
      );
    }
    return map;
  }

  ProfileCompanion toCompanion(bool nullToAbsent) {
    return ProfileCompanion(
      accountId: Value(accountId),
      profileContentVersion: profileContentVersion == null && nullToAbsent
          ? const Value.absent()
          : Value(profileContentVersion),
      profileName: profileName == null && nullToAbsent
          ? const Value.absent()
          : Value(profileName),
      profileNameAccepted: profileNameAccepted == null && nullToAbsent
          ? const Value.absent()
          : Value(profileNameAccepted),
      profileText: profileText == null && nullToAbsent
          ? const Value.absent()
          : Value(profileText),
      profileTextAccepted: profileTextAccepted == null && nullToAbsent
          ? const Value.absent()
          : Value(profileTextAccepted),
      profileVersion: profileVersion == null && nullToAbsent
          ? const Value.absent()
          : Value(profileVersion),
      profileAge: profileAge == null && nullToAbsent
          ? const Value.absent()
          : Value(profileAge),
      profileLastSeenTimeValue: profileLastSeenTimeValue == null && nullToAbsent
          ? const Value.absent()
          : Value(profileLastSeenTimeValue),
      profileUnlimitedLikes: profileUnlimitedLikes == null && nullToAbsent
          ? const Value.absent()
          : Value(profileUnlimitedLikes),
      jsonProfileAttributes: jsonProfileAttributes == null && nullToAbsent
          ? const Value.absent()
          : Value(jsonProfileAttributes),
      primaryContentGridCropSize:
          primaryContentGridCropSize == null && nullToAbsent
          ? const Value.absent()
          : Value(primaryContentGridCropSize),
      primaryContentGridCropX: primaryContentGridCropX == null && nullToAbsent
          ? const Value.absent()
          : Value(primaryContentGridCropX),
      primaryContentGridCropY: primaryContentGridCropY == null && nullToAbsent
          ? const Value.absent()
          : Value(primaryContentGridCropY),
      profileDataRefreshTime: profileDataRefreshTime == null && nullToAbsent
          ? const Value.absent()
          : Value(profileDataRefreshTime),
      newLikeInfoReceivedTime: newLikeInfoReceivedTime == null && nullToAbsent
          ? const Value.absent()
          : Value(newLikeInfoReceivedTime),
    );
  }

  factory ProfileData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProfileData(
      accountId: serializer.fromJson<AccountId>(json['accountId']),
      profileContentVersion: serializer.fromJson<ProfileContentVersion?>(
        json['profileContentVersion'],
      ),
      profileName: serializer.fromJson<String?>(json['profileName']),
      profileNameAccepted: serializer.fromJson<bool?>(
        json['profileNameAccepted'],
      ),
      profileText: serializer.fromJson<String?>(json['profileText']),
      profileTextAccepted: serializer.fromJson<bool?>(
        json['profileTextAccepted'],
      ),
      profileVersion: serializer.fromJson<ProfileVersion?>(
        json['profileVersion'],
      ),
      profileAge: serializer.fromJson<int?>(json['profileAge']),
      profileLastSeenTimeValue: serializer.fromJson<int?>(
        json['profileLastSeenTimeValue'],
      ),
      profileUnlimitedLikes: serializer.fromJson<bool?>(
        json['profileUnlimitedLikes'],
      ),
      jsonProfileAttributes: serializer
          .fromJson<JsonList<ProfileAttributeValue>?>(
            json['jsonProfileAttributes'],
          ),
      primaryContentGridCropSize: serializer.fromJson<double?>(
        json['primaryContentGridCropSize'],
      ),
      primaryContentGridCropX: serializer.fromJson<double?>(
        json['primaryContentGridCropX'],
      ),
      primaryContentGridCropY: serializer.fromJson<double?>(
        json['primaryContentGridCropY'],
      ),
      profileDataRefreshTime: serializer.fromJson<UtcDateTime?>(
        json['profileDataRefreshTime'],
      ),
      newLikeInfoReceivedTime: serializer.fromJson<UtcDateTime?>(
        json['newLikeInfoReceivedTime'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'accountId': serializer.toJson<AccountId>(accountId),
      'profileContentVersion': serializer.toJson<ProfileContentVersion?>(
        profileContentVersion,
      ),
      'profileName': serializer.toJson<String?>(profileName),
      'profileNameAccepted': serializer.toJson<bool?>(profileNameAccepted),
      'profileText': serializer.toJson<String?>(profileText),
      'profileTextAccepted': serializer.toJson<bool?>(profileTextAccepted),
      'profileVersion': serializer.toJson<ProfileVersion?>(profileVersion),
      'profileAge': serializer.toJson<int?>(profileAge),
      'profileLastSeenTimeValue': serializer.toJson<int?>(
        profileLastSeenTimeValue,
      ),
      'profileUnlimitedLikes': serializer.toJson<bool?>(profileUnlimitedLikes),
      'jsonProfileAttributes': serializer
          .toJson<JsonList<ProfileAttributeValue>?>(jsonProfileAttributes),
      'primaryContentGridCropSize': serializer.toJson<double?>(
        primaryContentGridCropSize,
      ),
      'primaryContentGridCropX': serializer.toJson<double?>(
        primaryContentGridCropX,
      ),
      'primaryContentGridCropY': serializer.toJson<double?>(
        primaryContentGridCropY,
      ),
      'profileDataRefreshTime': serializer.toJson<UtcDateTime?>(
        profileDataRefreshTime,
      ),
      'newLikeInfoReceivedTime': serializer.toJson<UtcDateTime?>(
        newLikeInfoReceivedTime,
      ),
    };
  }

  ProfileData copyWith({
    AccountId? accountId,
    Value<ProfileContentVersion?> profileContentVersion = const Value.absent(),
    Value<String?> profileName = const Value.absent(),
    Value<bool?> profileNameAccepted = const Value.absent(),
    Value<String?> profileText = const Value.absent(),
    Value<bool?> profileTextAccepted = const Value.absent(),
    Value<ProfileVersion?> profileVersion = const Value.absent(),
    Value<int?> profileAge = const Value.absent(),
    Value<int?> profileLastSeenTimeValue = const Value.absent(),
    Value<bool?> profileUnlimitedLikes = const Value.absent(),
    Value<JsonList<ProfileAttributeValue>?> jsonProfileAttributes =
        const Value.absent(),
    Value<double?> primaryContentGridCropSize = const Value.absent(),
    Value<double?> primaryContentGridCropX = const Value.absent(),
    Value<double?> primaryContentGridCropY = const Value.absent(),
    Value<UtcDateTime?> profileDataRefreshTime = const Value.absent(),
    Value<UtcDateTime?> newLikeInfoReceivedTime = const Value.absent(),
  }) => ProfileData(
    accountId: accountId ?? this.accountId,
    profileContentVersion: profileContentVersion.present
        ? profileContentVersion.value
        : this.profileContentVersion,
    profileName: profileName.present ? profileName.value : this.profileName,
    profileNameAccepted: profileNameAccepted.present
        ? profileNameAccepted.value
        : this.profileNameAccepted,
    profileText: profileText.present ? profileText.value : this.profileText,
    profileTextAccepted: profileTextAccepted.present
        ? profileTextAccepted.value
        : this.profileTextAccepted,
    profileVersion: profileVersion.present
        ? profileVersion.value
        : this.profileVersion,
    profileAge: profileAge.present ? profileAge.value : this.profileAge,
    profileLastSeenTimeValue: profileLastSeenTimeValue.present
        ? profileLastSeenTimeValue.value
        : this.profileLastSeenTimeValue,
    profileUnlimitedLikes: profileUnlimitedLikes.present
        ? profileUnlimitedLikes.value
        : this.profileUnlimitedLikes,
    jsonProfileAttributes: jsonProfileAttributes.present
        ? jsonProfileAttributes.value
        : this.jsonProfileAttributes,
    primaryContentGridCropSize: primaryContentGridCropSize.present
        ? primaryContentGridCropSize.value
        : this.primaryContentGridCropSize,
    primaryContentGridCropX: primaryContentGridCropX.present
        ? primaryContentGridCropX.value
        : this.primaryContentGridCropX,
    primaryContentGridCropY: primaryContentGridCropY.present
        ? primaryContentGridCropY.value
        : this.primaryContentGridCropY,
    profileDataRefreshTime: profileDataRefreshTime.present
        ? profileDataRefreshTime.value
        : this.profileDataRefreshTime,
    newLikeInfoReceivedTime: newLikeInfoReceivedTime.present
        ? newLikeInfoReceivedTime.value
        : this.newLikeInfoReceivedTime,
  );
  ProfileData copyWithCompanion(ProfileCompanion data) {
    return ProfileData(
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      profileContentVersion: data.profileContentVersion.present
          ? data.profileContentVersion.value
          : this.profileContentVersion,
      profileName: data.profileName.present
          ? data.profileName.value
          : this.profileName,
      profileNameAccepted: data.profileNameAccepted.present
          ? data.profileNameAccepted.value
          : this.profileNameAccepted,
      profileText: data.profileText.present
          ? data.profileText.value
          : this.profileText,
      profileTextAccepted: data.profileTextAccepted.present
          ? data.profileTextAccepted.value
          : this.profileTextAccepted,
      profileVersion: data.profileVersion.present
          ? data.profileVersion.value
          : this.profileVersion,
      profileAge: data.profileAge.present
          ? data.profileAge.value
          : this.profileAge,
      profileLastSeenTimeValue: data.profileLastSeenTimeValue.present
          ? data.profileLastSeenTimeValue.value
          : this.profileLastSeenTimeValue,
      profileUnlimitedLikes: data.profileUnlimitedLikes.present
          ? data.profileUnlimitedLikes.value
          : this.profileUnlimitedLikes,
      jsonProfileAttributes: data.jsonProfileAttributes.present
          ? data.jsonProfileAttributes.value
          : this.jsonProfileAttributes,
      primaryContentGridCropSize: data.primaryContentGridCropSize.present
          ? data.primaryContentGridCropSize.value
          : this.primaryContentGridCropSize,
      primaryContentGridCropX: data.primaryContentGridCropX.present
          ? data.primaryContentGridCropX.value
          : this.primaryContentGridCropX,
      primaryContentGridCropY: data.primaryContentGridCropY.present
          ? data.primaryContentGridCropY.value
          : this.primaryContentGridCropY,
      profileDataRefreshTime: data.profileDataRefreshTime.present
          ? data.profileDataRefreshTime.value
          : this.profileDataRefreshTime,
      newLikeInfoReceivedTime: data.newLikeInfoReceivedTime.present
          ? data.newLikeInfoReceivedTime.value
          : this.newLikeInfoReceivedTime,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProfileData(')
          ..write('accountId: $accountId, ')
          ..write('profileContentVersion: $profileContentVersion, ')
          ..write('profileName: $profileName, ')
          ..write('profileNameAccepted: $profileNameAccepted, ')
          ..write('profileText: $profileText, ')
          ..write('profileTextAccepted: $profileTextAccepted, ')
          ..write('profileVersion: $profileVersion, ')
          ..write('profileAge: $profileAge, ')
          ..write('profileLastSeenTimeValue: $profileLastSeenTimeValue, ')
          ..write('profileUnlimitedLikes: $profileUnlimitedLikes, ')
          ..write('jsonProfileAttributes: $jsonProfileAttributes, ')
          ..write('primaryContentGridCropSize: $primaryContentGridCropSize, ')
          ..write('primaryContentGridCropX: $primaryContentGridCropX, ')
          ..write('primaryContentGridCropY: $primaryContentGridCropY, ')
          ..write('profileDataRefreshTime: $profileDataRefreshTime, ')
          ..write('newLikeInfoReceivedTime: $newLikeInfoReceivedTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    accountId,
    profileContentVersion,
    profileName,
    profileNameAccepted,
    profileText,
    profileTextAccepted,
    profileVersion,
    profileAge,
    profileLastSeenTimeValue,
    profileUnlimitedLikes,
    jsonProfileAttributes,
    primaryContentGridCropSize,
    primaryContentGridCropX,
    primaryContentGridCropY,
    profileDataRefreshTime,
    newLikeInfoReceivedTime,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProfileData &&
          other.accountId == this.accountId &&
          other.profileContentVersion == this.profileContentVersion &&
          other.profileName == this.profileName &&
          other.profileNameAccepted == this.profileNameAccepted &&
          other.profileText == this.profileText &&
          other.profileTextAccepted == this.profileTextAccepted &&
          other.profileVersion == this.profileVersion &&
          other.profileAge == this.profileAge &&
          other.profileLastSeenTimeValue == this.profileLastSeenTimeValue &&
          other.profileUnlimitedLikes == this.profileUnlimitedLikes &&
          other.jsonProfileAttributes == this.jsonProfileAttributes &&
          other.primaryContentGridCropSize == this.primaryContentGridCropSize &&
          other.primaryContentGridCropX == this.primaryContentGridCropX &&
          other.primaryContentGridCropY == this.primaryContentGridCropY &&
          other.profileDataRefreshTime == this.profileDataRefreshTime &&
          other.newLikeInfoReceivedTime == this.newLikeInfoReceivedTime);
}

class ProfileCompanion extends UpdateCompanion<ProfileData> {
  final Value<AccountId> accountId;
  final Value<ProfileContentVersion?> profileContentVersion;
  final Value<String?> profileName;
  final Value<bool?> profileNameAccepted;
  final Value<String?> profileText;
  final Value<bool?> profileTextAccepted;
  final Value<ProfileVersion?> profileVersion;
  final Value<int?> profileAge;
  final Value<int?> profileLastSeenTimeValue;
  final Value<bool?> profileUnlimitedLikes;
  final Value<JsonList<ProfileAttributeValue>?> jsonProfileAttributes;
  final Value<double?> primaryContentGridCropSize;
  final Value<double?> primaryContentGridCropX;
  final Value<double?> primaryContentGridCropY;
  final Value<UtcDateTime?> profileDataRefreshTime;
  final Value<UtcDateTime?> newLikeInfoReceivedTime;
  final Value<int> rowid;
  const ProfileCompanion({
    this.accountId = const Value.absent(),
    this.profileContentVersion = const Value.absent(),
    this.profileName = const Value.absent(),
    this.profileNameAccepted = const Value.absent(),
    this.profileText = const Value.absent(),
    this.profileTextAccepted = const Value.absent(),
    this.profileVersion = const Value.absent(),
    this.profileAge = const Value.absent(),
    this.profileLastSeenTimeValue = const Value.absent(),
    this.profileUnlimitedLikes = const Value.absent(),
    this.jsonProfileAttributes = const Value.absent(),
    this.primaryContentGridCropSize = const Value.absent(),
    this.primaryContentGridCropX = const Value.absent(),
    this.primaryContentGridCropY = const Value.absent(),
    this.profileDataRefreshTime = const Value.absent(),
    this.newLikeInfoReceivedTime = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProfileCompanion.insert({
    required AccountId accountId,
    this.profileContentVersion = const Value.absent(),
    this.profileName = const Value.absent(),
    this.profileNameAccepted = const Value.absent(),
    this.profileText = const Value.absent(),
    this.profileTextAccepted = const Value.absent(),
    this.profileVersion = const Value.absent(),
    this.profileAge = const Value.absent(),
    this.profileLastSeenTimeValue = const Value.absent(),
    this.profileUnlimitedLikes = const Value.absent(),
    this.jsonProfileAttributes = const Value.absent(),
    this.primaryContentGridCropSize = const Value.absent(),
    this.primaryContentGridCropX = const Value.absent(),
    this.primaryContentGridCropY = const Value.absent(),
    this.profileDataRefreshTime = const Value.absent(),
    this.newLikeInfoReceivedTime = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : accountId = Value(accountId);
  static Insertable<ProfileData> custom({
    Expression<String>? accountId,
    Expression<String>? profileContentVersion,
    Expression<String>? profileName,
    Expression<bool>? profileNameAccepted,
    Expression<String>? profileText,
    Expression<bool>? profileTextAccepted,
    Expression<String>? profileVersion,
    Expression<int>? profileAge,
    Expression<int>? profileLastSeenTimeValue,
    Expression<bool>? profileUnlimitedLikes,
    Expression<String>? jsonProfileAttributes,
    Expression<double>? primaryContentGridCropSize,
    Expression<double>? primaryContentGridCropX,
    Expression<double>? primaryContentGridCropY,
    Expression<int>? profileDataRefreshTime,
    Expression<int>? newLikeInfoReceivedTime,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (accountId != null) 'account_id': accountId,
      if (profileContentVersion != null)
        'profile_content_version': profileContentVersion,
      if (profileName != null) 'profile_name': profileName,
      if (profileNameAccepted != null)
        'profile_name_accepted': profileNameAccepted,
      if (profileText != null) 'profile_text': profileText,
      if (profileTextAccepted != null)
        'profile_text_accepted': profileTextAccepted,
      if (profileVersion != null) 'profile_version': profileVersion,
      if (profileAge != null) 'profile_age': profileAge,
      if (profileLastSeenTimeValue != null)
        'profile_last_seen_time_value': profileLastSeenTimeValue,
      if (profileUnlimitedLikes != null)
        'profile_unlimited_likes': profileUnlimitedLikes,
      if (jsonProfileAttributes != null)
        'json_profile_attributes': jsonProfileAttributes,
      if (primaryContentGridCropSize != null)
        'primary_content_grid_crop_size': primaryContentGridCropSize,
      if (primaryContentGridCropX != null)
        'primary_content_grid_crop_x': primaryContentGridCropX,
      if (primaryContentGridCropY != null)
        'primary_content_grid_crop_y': primaryContentGridCropY,
      if (profileDataRefreshTime != null)
        'profile_data_refresh_time': profileDataRefreshTime,
      if (newLikeInfoReceivedTime != null)
        'new_like_info_received_time': newLikeInfoReceivedTime,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProfileCompanion copyWith({
    Value<AccountId>? accountId,
    Value<ProfileContentVersion?>? profileContentVersion,
    Value<String?>? profileName,
    Value<bool?>? profileNameAccepted,
    Value<String?>? profileText,
    Value<bool?>? profileTextAccepted,
    Value<ProfileVersion?>? profileVersion,
    Value<int?>? profileAge,
    Value<int?>? profileLastSeenTimeValue,
    Value<bool?>? profileUnlimitedLikes,
    Value<JsonList<ProfileAttributeValue>?>? jsonProfileAttributes,
    Value<double?>? primaryContentGridCropSize,
    Value<double?>? primaryContentGridCropX,
    Value<double?>? primaryContentGridCropY,
    Value<UtcDateTime?>? profileDataRefreshTime,
    Value<UtcDateTime?>? newLikeInfoReceivedTime,
    Value<int>? rowid,
  }) {
    return ProfileCompanion(
      accountId: accountId ?? this.accountId,
      profileContentVersion:
          profileContentVersion ?? this.profileContentVersion,
      profileName: profileName ?? this.profileName,
      profileNameAccepted: profileNameAccepted ?? this.profileNameAccepted,
      profileText: profileText ?? this.profileText,
      profileTextAccepted: profileTextAccepted ?? this.profileTextAccepted,
      profileVersion: profileVersion ?? this.profileVersion,
      profileAge: profileAge ?? this.profileAge,
      profileLastSeenTimeValue:
          profileLastSeenTimeValue ?? this.profileLastSeenTimeValue,
      profileUnlimitedLikes:
          profileUnlimitedLikes ?? this.profileUnlimitedLikes,
      jsonProfileAttributes:
          jsonProfileAttributes ?? this.jsonProfileAttributes,
      primaryContentGridCropSize:
          primaryContentGridCropSize ?? this.primaryContentGridCropSize,
      primaryContentGridCropX:
          primaryContentGridCropX ?? this.primaryContentGridCropX,
      primaryContentGridCropY:
          primaryContentGridCropY ?? this.primaryContentGridCropY,
      profileDataRefreshTime:
          profileDataRefreshTime ?? this.profileDataRefreshTime,
      newLikeInfoReceivedTime:
          newLikeInfoReceivedTime ?? this.newLikeInfoReceivedTime,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (accountId.present) {
      map['account_id'] = Variable<String>(
        $ProfileTable.$converteraccountId.toSql(accountId.value),
      );
    }
    if (profileContentVersion.present) {
      map['profile_content_version'] = Variable<String>(
        $ProfileTable.$converterprofileContentVersion.toSql(
          profileContentVersion.value,
        ),
      );
    }
    if (profileName.present) {
      map['profile_name'] = Variable<String>(profileName.value);
    }
    if (profileNameAccepted.present) {
      map['profile_name_accepted'] = Variable<bool>(profileNameAccepted.value);
    }
    if (profileText.present) {
      map['profile_text'] = Variable<String>(profileText.value);
    }
    if (profileTextAccepted.present) {
      map['profile_text_accepted'] = Variable<bool>(profileTextAccepted.value);
    }
    if (profileVersion.present) {
      map['profile_version'] = Variable<String>(
        $ProfileTable.$converterprofileVersion.toSql(profileVersion.value),
      );
    }
    if (profileAge.present) {
      map['profile_age'] = Variable<int>(profileAge.value);
    }
    if (profileLastSeenTimeValue.present) {
      map['profile_last_seen_time_value'] = Variable<int>(
        profileLastSeenTimeValue.value,
      );
    }
    if (profileUnlimitedLikes.present) {
      map['profile_unlimited_likes'] = Variable<bool>(
        profileUnlimitedLikes.value,
      );
    }
    if (jsonProfileAttributes.present) {
      map['json_profile_attributes'] = Variable<String>(
        $ProfileTable.$converterjsonProfileAttributes.toSql(
          jsonProfileAttributes.value,
        ),
      );
    }
    if (primaryContentGridCropSize.present) {
      map['primary_content_grid_crop_size'] = Variable<double>(
        primaryContentGridCropSize.value,
      );
    }
    if (primaryContentGridCropX.present) {
      map['primary_content_grid_crop_x'] = Variable<double>(
        primaryContentGridCropX.value,
      );
    }
    if (primaryContentGridCropY.present) {
      map['primary_content_grid_crop_y'] = Variable<double>(
        primaryContentGridCropY.value,
      );
    }
    if (profileDataRefreshTime.present) {
      map['profile_data_refresh_time'] = Variable<int>(
        $ProfileTable.$converterprofileDataRefreshTime.toSql(
          profileDataRefreshTime.value,
        ),
      );
    }
    if (newLikeInfoReceivedTime.present) {
      map['new_like_info_received_time'] = Variable<int>(
        $ProfileTable.$converternewLikeInfoReceivedTime.toSql(
          newLikeInfoReceivedTime.value,
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
    return (StringBuffer('ProfileCompanion(')
          ..write('accountId: $accountId, ')
          ..write('profileContentVersion: $profileContentVersion, ')
          ..write('profileName: $profileName, ')
          ..write('profileNameAccepted: $profileNameAccepted, ')
          ..write('profileText: $profileText, ')
          ..write('profileTextAccepted: $profileTextAccepted, ')
          ..write('profileVersion: $profileVersion, ')
          ..write('profileAge: $profileAge, ')
          ..write('profileLastSeenTimeValue: $profileLastSeenTimeValue, ')
          ..write('profileUnlimitedLikes: $profileUnlimitedLikes, ')
          ..write('jsonProfileAttributes: $jsonProfileAttributes, ')
          ..write('primaryContentGridCropSize: $primaryContentGridCropSize, ')
          ..write('primaryContentGridCropX: $primaryContentGridCropX, ')
          ..write('primaryContentGridCropY: $primaryContentGridCropY, ')
          ..write('profileDataRefreshTime: $profileDataRefreshTime, ')
          ..write('newLikeInfoReceivedTime: $newLikeInfoReceivedTime, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProfileSearchAgeRangeTable extends schema.ProfileSearchAgeRange
    with TableInfo<$ProfileSearchAgeRangeTable, ProfileSearchAgeRangeData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProfileSearchAgeRangeTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _minAgeMeta = const VerificationMeta('minAge');
  @override
  late final GeneratedColumn<int> minAge = GeneratedColumn<int>(
    'min_age',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _maxAgeMeta = const VerificationMeta('maxAge');
  @override
  late final GeneratedColumn<int> maxAge = GeneratedColumn<int>(
    'max_age',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, minAge, maxAge];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'profile_search_age_range';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProfileSearchAgeRangeData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('min_age')) {
      context.handle(
        _minAgeMeta,
        minAge.isAcceptableOrUnknown(data['min_age']!, _minAgeMeta),
      );
    }
    if (data.containsKey('max_age')) {
      context.handle(
        _maxAgeMeta,
        maxAge.isAcceptableOrUnknown(data['max_age']!, _maxAgeMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProfileSearchAgeRangeData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProfileSearchAgeRangeData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      minAge: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}min_age'],
      ),
      maxAge: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_age'],
      ),
    );
  }

  @override
  $ProfileSearchAgeRangeTable createAlias(String alias) {
    return $ProfileSearchAgeRangeTable(attachedDatabase, alias);
  }
}

class ProfileSearchAgeRangeData extends DataClass
    implements Insertable<ProfileSearchAgeRangeData> {
  final int id;
  final int? minAge;
  final int? maxAge;
  const ProfileSearchAgeRangeData({required this.id, this.minAge, this.maxAge});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || minAge != null) {
      map['min_age'] = Variable<int>(minAge);
    }
    if (!nullToAbsent || maxAge != null) {
      map['max_age'] = Variable<int>(maxAge);
    }
    return map;
  }

  ProfileSearchAgeRangeCompanion toCompanion(bool nullToAbsent) {
    return ProfileSearchAgeRangeCompanion(
      id: Value(id),
      minAge: minAge == null && nullToAbsent
          ? const Value.absent()
          : Value(minAge),
      maxAge: maxAge == null && nullToAbsent
          ? const Value.absent()
          : Value(maxAge),
    );
  }

  factory ProfileSearchAgeRangeData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProfileSearchAgeRangeData(
      id: serializer.fromJson<int>(json['id']),
      minAge: serializer.fromJson<int?>(json['minAge']),
      maxAge: serializer.fromJson<int?>(json['maxAge']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'minAge': serializer.toJson<int?>(minAge),
      'maxAge': serializer.toJson<int?>(maxAge),
    };
  }

  ProfileSearchAgeRangeData copyWith({
    int? id,
    Value<int?> minAge = const Value.absent(),
    Value<int?> maxAge = const Value.absent(),
  }) => ProfileSearchAgeRangeData(
    id: id ?? this.id,
    minAge: minAge.present ? minAge.value : this.minAge,
    maxAge: maxAge.present ? maxAge.value : this.maxAge,
  );
  ProfileSearchAgeRangeData copyWithCompanion(
    ProfileSearchAgeRangeCompanion data,
  ) {
    return ProfileSearchAgeRangeData(
      id: data.id.present ? data.id.value : this.id,
      minAge: data.minAge.present ? data.minAge.value : this.minAge,
      maxAge: data.maxAge.present ? data.maxAge.value : this.maxAge,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProfileSearchAgeRangeData(')
          ..write('id: $id, ')
          ..write('minAge: $minAge, ')
          ..write('maxAge: $maxAge')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, minAge, maxAge);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProfileSearchAgeRangeData &&
          other.id == this.id &&
          other.minAge == this.minAge &&
          other.maxAge == this.maxAge);
}

class ProfileSearchAgeRangeCompanion
    extends UpdateCompanion<ProfileSearchAgeRangeData> {
  final Value<int> id;
  final Value<int?> minAge;
  final Value<int?> maxAge;
  const ProfileSearchAgeRangeCompanion({
    this.id = const Value.absent(),
    this.minAge = const Value.absent(),
    this.maxAge = const Value.absent(),
  });
  ProfileSearchAgeRangeCompanion.insert({
    this.id = const Value.absent(),
    this.minAge = const Value.absent(),
    this.maxAge = const Value.absent(),
  });
  static Insertable<ProfileSearchAgeRangeData> custom({
    Expression<int>? id,
    Expression<int>? minAge,
    Expression<int>? maxAge,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (minAge != null) 'min_age': minAge,
      if (maxAge != null) 'max_age': maxAge,
    });
  }

  ProfileSearchAgeRangeCompanion copyWith({
    Value<int>? id,
    Value<int?>? minAge,
    Value<int?>? maxAge,
  }) {
    return ProfileSearchAgeRangeCompanion(
      id: id ?? this.id,
      minAge: minAge ?? this.minAge,
      maxAge: maxAge ?? this.maxAge,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (minAge.present) {
      map['min_age'] = Variable<int>(minAge.value);
    }
    if (maxAge.present) {
      map['max_age'] = Variable<int>(maxAge.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProfileSearchAgeRangeCompanion(')
          ..write('id: $id, ')
          ..write('minAge: $minAge, ')
          ..write('maxAge: $maxAge')
          ..write(')'))
        .toString();
  }
}

class $ProfileSearchGroupsTable extends schema.ProfileSearchGroups
    with TableInfo<$ProfileSearchGroupsTable, ProfileSearchGroup> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProfileSearchGroupsTable(this.attachedDatabase, [this._alias]);
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
  late final GeneratedColumnWithTypeConverter<JsonObject<SearchGroups>?, String>
  jsonProfileSearchGroups =
      GeneratedColumn<String>(
        'json_profile_search_groups',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<JsonObject<SearchGroups>?>(
        $ProfileSearchGroupsTable.$converterjsonProfileSearchGroups,
      );
  @override
  List<GeneratedColumn> get $columns => [id, jsonProfileSearchGroups];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'profile_search_groups';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProfileSearchGroup> instance, {
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
  ProfileSearchGroup map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProfileSearchGroup(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      jsonProfileSearchGroups: $ProfileSearchGroupsTable
          .$converterjsonProfileSearchGroups
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}json_profile_search_groups'],
            ),
          ),
    );
  }

  @override
  $ProfileSearchGroupsTable createAlias(String alias) {
    return $ProfileSearchGroupsTable(attachedDatabase, alias);
  }

  static TypeConverter<JsonObject<SearchGroups>?, String?>
  $converterjsonProfileSearchGroups = NullAwareTypeConverter.wrap(
    const SearchGroupsConverter(),
  );
}

class ProfileSearchGroup extends DataClass
    implements Insertable<ProfileSearchGroup> {
  final int id;
  final JsonObject<SearchGroups>? jsonProfileSearchGroups;
  const ProfileSearchGroup({required this.id, this.jsonProfileSearchGroups});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || jsonProfileSearchGroups != null) {
      map['json_profile_search_groups'] = Variable<String>(
        $ProfileSearchGroupsTable.$converterjsonProfileSearchGroups.toSql(
          jsonProfileSearchGroups,
        ),
      );
    }
    return map;
  }

  ProfileSearchGroupsCompanion toCompanion(bool nullToAbsent) {
    return ProfileSearchGroupsCompanion(
      id: Value(id),
      jsonProfileSearchGroups: jsonProfileSearchGroups == null && nullToAbsent
          ? const Value.absent()
          : Value(jsonProfileSearchGroups),
    );
  }

  factory ProfileSearchGroup.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProfileSearchGroup(
      id: serializer.fromJson<int>(json['id']),
      jsonProfileSearchGroups: serializer.fromJson<JsonObject<SearchGroups>?>(
        json['jsonProfileSearchGroups'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'jsonProfileSearchGroups': serializer.toJson<JsonObject<SearchGroups>?>(
        jsonProfileSearchGroups,
      ),
    };
  }

  ProfileSearchGroup copyWith({
    int? id,
    Value<JsonObject<SearchGroups>?> jsonProfileSearchGroups =
        const Value.absent(),
  }) => ProfileSearchGroup(
    id: id ?? this.id,
    jsonProfileSearchGroups: jsonProfileSearchGroups.present
        ? jsonProfileSearchGroups.value
        : this.jsonProfileSearchGroups,
  );
  ProfileSearchGroup copyWithCompanion(ProfileSearchGroupsCompanion data) {
    return ProfileSearchGroup(
      id: data.id.present ? data.id.value : this.id,
      jsonProfileSearchGroups: data.jsonProfileSearchGroups.present
          ? data.jsonProfileSearchGroups.value
          : this.jsonProfileSearchGroups,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProfileSearchGroup(')
          ..write('id: $id, ')
          ..write('jsonProfileSearchGroups: $jsonProfileSearchGroups')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, jsonProfileSearchGroups);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProfileSearchGroup &&
          other.id == this.id &&
          other.jsonProfileSearchGroups == this.jsonProfileSearchGroups);
}

class ProfileSearchGroupsCompanion extends UpdateCompanion<ProfileSearchGroup> {
  final Value<int> id;
  final Value<JsonObject<SearchGroups>?> jsonProfileSearchGroups;
  const ProfileSearchGroupsCompanion({
    this.id = const Value.absent(),
    this.jsonProfileSearchGroups = const Value.absent(),
  });
  ProfileSearchGroupsCompanion.insert({
    this.id = const Value.absent(),
    this.jsonProfileSearchGroups = const Value.absent(),
  });
  static Insertable<ProfileSearchGroup> custom({
    Expression<int>? id,
    Expression<String>? jsonProfileSearchGroups,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (jsonProfileSearchGroups != null)
        'json_profile_search_groups': jsonProfileSearchGroups,
    });
  }

  ProfileSearchGroupsCompanion copyWith({
    Value<int>? id,
    Value<JsonObject<SearchGroups>?>? jsonProfileSearchGroups,
  }) {
    return ProfileSearchGroupsCompanion(
      id: id ?? this.id,
      jsonProfileSearchGroups:
          jsonProfileSearchGroups ?? this.jsonProfileSearchGroups,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (jsonProfileSearchGroups.present) {
      map['json_profile_search_groups'] = Variable<String>(
        $ProfileSearchGroupsTable.$converterjsonProfileSearchGroups.toSql(
          jsonProfileSearchGroups.value,
        ),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProfileSearchGroupsCompanion(')
          ..write('id: $id, ')
          ..write('jsonProfileSearchGroups: $jsonProfileSearchGroups')
          ..write(')'))
        .toString();
  }
}

class $ProfileFiltersTable extends schema.ProfileFilters
    with TableInfo<$ProfileFiltersTable, ProfileFilter> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProfileFiltersTable(this.attachedDatabase, [this._alias]);
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
  late final GeneratedColumnWithTypeConverter<
    JsonObject<GetProfileFilters>?,
    String
  >
  jsonProfileFilters =
      GeneratedColumn<String>(
        'json_profile_filters',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<JsonObject<GetProfileFilters>?>(
        $ProfileFiltersTable.$converterjsonProfileFilters,
      );
  @override
  List<GeneratedColumn> get $columns => [id, jsonProfileFilters];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'profile_filters';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProfileFilter> instance, {
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
  ProfileFilter map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProfileFilter(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      jsonProfileFilters: $ProfileFiltersTable.$converterjsonProfileFilters
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}json_profile_filters'],
            ),
          ),
    );
  }

  @override
  $ProfileFiltersTable createAlias(String alias) {
    return $ProfileFiltersTable(attachedDatabase, alias);
  }

  static TypeConverter<JsonObject<GetProfileFilters>?, String?>
  $converterjsonProfileFilters = NullAwareTypeConverter.wrap(
    const GetProfileFiltersConverter(),
  );
}

class ProfileFilter extends DataClass implements Insertable<ProfileFilter> {
  final int id;
  final JsonObject<GetProfileFilters>? jsonProfileFilters;
  const ProfileFilter({required this.id, this.jsonProfileFilters});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || jsonProfileFilters != null) {
      map['json_profile_filters'] = Variable<String>(
        $ProfileFiltersTable.$converterjsonProfileFilters.toSql(
          jsonProfileFilters,
        ),
      );
    }
    return map;
  }

  ProfileFiltersCompanion toCompanion(bool nullToAbsent) {
    return ProfileFiltersCompanion(
      id: Value(id),
      jsonProfileFilters: jsonProfileFilters == null && nullToAbsent
          ? const Value.absent()
          : Value(jsonProfileFilters),
    );
  }

  factory ProfileFilter.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProfileFilter(
      id: serializer.fromJson<int>(json['id']),
      jsonProfileFilters: serializer.fromJson<JsonObject<GetProfileFilters>?>(
        json['jsonProfileFilters'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'jsonProfileFilters': serializer.toJson<JsonObject<GetProfileFilters>?>(
        jsonProfileFilters,
      ),
    };
  }

  ProfileFilter copyWith({
    int? id,
    Value<JsonObject<GetProfileFilters>?> jsonProfileFilters =
        const Value.absent(),
  }) => ProfileFilter(
    id: id ?? this.id,
    jsonProfileFilters: jsonProfileFilters.present
        ? jsonProfileFilters.value
        : this.jsonProfileFilters,
  );
  ProfileFilter copyWithCompanion(ProfileFiltersCompanion data) {
    return ProfileFilter(
      id: data.id.present ? data.id.value : this.id,
      jsonProfileFilters: data.jsonProfileFilters.present
          ? data.jsonProfileFilters.value
          : this.jsonProfileFilters,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProfileFilter(')
          ..write('id: $id, ')
          ..write('jsonProfileFilters: $jsonProfileFilters')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, jsonProfileFilters);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProfileFilter &&
          other.id == this.id &&
          other.jsonProfileFilters == this.jsonProfileFilters);
}

class ProfileFiltersCompanion extends UpdateCompanion<ProfileFilter> {
  final Value<int> id;
  final Value<JsonObject<GetProfileFilters>?> jsonProfileFilters;
  const ProfileFiltersCompanion({
    this.id = const Value.absent(),
    this.jsonProfileFilters = const Value.absent(),
  });
  ProfileFiltersCompanion.insert({
    this.id = const Value.absent(),
    this.jsonProfileFilters = const Value.absent(),
  });
  static Insertable<ProfileFilter> custom({
    Expression<int>? id,
    Expression<String>? jsonProfileFilters,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (jsonProfileFilters != null)
        'json_profile_filters': jsonProfileFilters,
    });
  }

  ProfileFiltersCompanion copyWith({
    Value<int>? id,
    Value<JsonObject<GetProfileFilters>?>? jsonProfileFilters,
  }) {
    return ProfileFiltersCompanion(
      id: id ?? this.id,
      jsonProfileFilters: jsonProfileFilters ?? this.jsonProfileFilters,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (jsonProfileFilters.present) {
      map['json_profile_filters'] = Variable<String>(
        $ProfileFiltersTable.$converterjsonProfileFilters.toSql(
          jsonProfileFilters.value,
        ),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProfileFiltersCompanion(')
          ..write('id: $id, ')
          ..write('jsonProfileFilters: $jsonProfileFilters')
          ..write(')'))
        .toString();
  }
}

class $InitialProfileAgeTable extends schema.InitialProfileAge
    with TableInfo<$InitialProfileAgeTable, InitialProfileAgeData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InitialProfileAgeTable(this.attachedDatabase, [this._alias]);
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
  initialProfileAgeSetUnixTime =
      GeneratedColumn<int>(
        'initial_profile_age_set_unix_time',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      ).withConverter<UtcDateTime?>(
        $InitialProfileAgeTable.$converterinitialProfileAgeSetUnixTime,
      );
  static const VerificationMeta _initialProfileAgeMeta = const VerificationMeta(
    'initialProfileAge',
  );
  @override
  late final GeneratedColumn<int> initialProfileAge = GeneratedColumn<int>(
    'initial_profile_age',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    initialProfileAgeSetUnixTime,
    initialProfileAge,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'initial_profile_age';
  @override
  VerificationContext validateIntegrity(
    Insertable<InitialProfileAgeData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('initial_profile_age')) {
      context.handle(
        _initialProfileAgeMeta,
        initialProfileAge.isAcceptableOrUnknown(
          data['initial_profile_age']!,
          _initialProfileAgeMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InitialProfileAgeData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InitialProfileAgeData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      initialProfileAgeSetUnixTime: $InitialProfileAgeTable
          .$converterinitialProfileAgeSetUnixTime
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.int,
              data['${effectivePrefix}initial_profile_age_set_unix_time'],
            ),
          ),
      initialProfileAge: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}initial_profile_age'],
      ),
    );
  }

  @override
  $InitialProfileAgeTable createAlias(String alias) {
    return $InitialProfileAgeTable(attachedDatabase, alias);
  }

  static TypeConverter<UtcDateTime?, int?>
  $converterinitialProfileAgeSetUnixTime = const NullAwareTypeConverter.wrap(
    UtcDateTimeConverter(),
  );
}

class InitialProfileAgeData extends DataClass
    implements Insertable<InitialProfileAgeData> {
  final int id;
  final UtcDateTime? initialProfileAgeSetUnixTime;
  final int? initialProfileAge;
  const InitialProfileAgeData({
    required this.id,
    this.initialProfileAgeSetUnixTime,
    this.initialProfileAge,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || initialProfileAgeSetUnixTime != null) {
      map['initial_profile_age_set_unix_time'] = Variable<int>(
        $InitialProfileAgeTable.$converterinitialProfileAgeSetUnixTime.toSql(
          initialProfileAgeSetUnixTime,
        ),
      );
    }
    if (!nullToAbsent || initialProfileAge != null) {
      map['initial_profile_age'] = Variable<int>(initialProfileAge);
    }
    return map;
  }

  InitialProfileAgeCompanion toCompanion(bool nullToAbsent) {
    return InitialProfileAgeCompanion(
      id: Value(id),
      initialProfileAgeSetUnixTime:
          initialProfileAgeSetUnixTime == null && nullToAbsent
          ? const Value.absent()
          : Value(initialProfileAgeSetUnixTime),
      initialProfileAge: initialProfileAge == null && nullToAbsent
          ? const Value.absent()
          : Value(initialProfileAge),
    );
  }

  factory InitialProfileAgeData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InitialProfileAgeData(
      id: serializer.fromJson<int>(json['id']),
      initialProfileAgeSetUnixTime: serializer.fromJson<UtcDateTime?>(
        json['initialProfileAgeSetUnixTime'],
      ),
      initialProfileAge: serializer.fromJson<int?>(json['initialProfileAge']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'initialProfileAgeSetUnixTime': serializer.toJson<UtcDateTime?>(
        initialProfileAgeSetUnixTime,
      ),
      'initialProfileAge': serializer.toJson<int?>(initialProfileAge),
    };
  }

  InitialProfileAgeData copyWith({
    int? id,
    Value<UtcDateTime?> initialProfileAgeSetUnixTime = const Value.absent(),
    Value<int?> initialProfileAge = const Value.absent(),
  }) => InitialProfileAgeData(
    id: id ?? this.id,
    initialProfileAgeSetUnixTime: initialProfileAgeSetUnixTime.present
        ? initialProfileAgeSetUnixTime.value
        : this.initialProfileAgeSetUnixTime,
    initialProfileAge: initialProfileAge.present
        ? initialProfileAge.value
        : this.initialProfileAge,
  );
  InitialProfileAgeData copyWithCompanion(InitialProfileAgeCompanion data) {
    return InitialProfileAgeData(
      id: data.id.present ? data.id.value : this.id,
      initialProfileAgeSetUnixTime: data.initialProfileAgeSetUnixTime.present
          ? data.initialProfileAgeSetUnixTime.value
          : this.initialProfileAgeSetUnixTime,
      initialProfileAge: data.initialProfileAge.present
          ? data.initialProfileAge.value
          : this.initialProfileAge,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InitialProfileAgeData(')
          ..write('id: $id, ')
          ..write(
            'initialProfileAgeSetUnixTime: $initialProfileAgeSetUnixTime, ',
          )
          ..write('initialProfileAge: $initialProfileAge')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, initialProfileAgeSetUnixTime, initialProfileAge);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InitialProfileAgeData &&
          other.id == this.id &&
          other.initialProfileAgeSetUnixTime ==
              this.initialProfileAgeSetUnixTime &&
          other.initialProfileAge == this.initialProfileAge);
}

class InitialProfileAgeCompanion
    extends UpdateCompanion<InitialProfileAgeData> {
  final Value<int> id;
  final Value<UtcDateTime?> initialProfileAgeSetUnixTime;
  final Value<int?> initialProfileAge;
  const InitialProfileAgeCompanion({
    this.id = const Value.absent(),
    this.initialProfileAgeSetUnixTime = const Value.absent(),
    this.initialProfileAge = const Value.absent(),
  });
  InitialProfileAgeCompanion.insert({
    this.id = const Value.absent(),
    this.initialProfileAgeSetUnixTime = const Value.absent(),
    this.initialProfileAge = const Value.absent(),
  });
  static Insertable<InitialProfileAgeData> custom({
    Expression<int>? id,
    Expression<int>? initialProfileAgeSetUnixTime,
    Expression<int>? initialProfileAge,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (initialProfileAgeSetUnixTime != null)
        'initial_profile_age_set_unix_time': initialProfileAgeSetUnixTime,
      if (initialProfileAge != null) 'initial_profile_age': initialProfileAge,
    });
  }

  InitialProfileAgeCompanion copyWith({
    Value<int>? id,
    Value<UtcDateTime?>? initialProfileAgeSetUnixTime,
    Value<int?>? initialProfileAge,
  }) {
    return InitialProfileAgeCompanion(
      id: id ?? this.id,
      initialProfileAgeSetUnixTime:
          initialProfileAgeSetUnixTime ?? this.initialProfileAgeSetUnixTime,
      initialProfileAge: initialProfileAge ?? this.initialProfileAge,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (initialProfileAgeSetUnixTime.present) {
      map['initial_profile_age_set_unix_time'] = Variable<int>(
        $InitialProfileAgeTable.$converterinitialProfileAgeSetUnixTime.toSql(
          initialProfileAgeSetUnixTime.value,
        ),
      );
    }
    if (initialProfileAge.present) {
      map['initial_profile_age'] = Variable<int>(initialProfileAge.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InitialProfileAgeCompanion(')
          ..write('id: $id, ')
          ..write(
            'initialProfileAgeSetUnixTime: $initialProfileAgeSetUnixTime, ',
          )
          ..write('initialProfileAge: $initialProfileAge')
          ..write(')'))
        .toString();
  }
}

class $ProfileStatesTable extends schema.ProfileStates
    with TableInfo<$ProfileStatesTable, ProfileState> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProfileStatesTable(this.attachedDatabase, [this._alias]);
  @override
  late final GeneratedColumnWithTypeConverter<AccountId, String> accountId =
      GeneratedColumn<String>(
        'account_id',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<AccountId>($ProfileStatesTable.$converteraccountId);
  @override
  late final GeneratedColumnWithTypeConverter<UtcDateTime?, int>
  isInReceivedLikes =
      GeneratedColumn<int>(
        'is_in_received_likes',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      ).withConverter<UtcDateTime?>(
        $ProfileStatesTable.$converterisInReceivedLikes,
      );
  @override
  late final GeneratedColumnWithTypeConverter<UtcDateTime?, int> isInSentLikes =
      GeneratedColumn<int>(
        'is_in_sent_likes',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      ).withConverter<UtcDateTime?>(
        $ProfileStatesTable.$converterisInSentLikes,
      );
  @override
  late final GeneratedColumnWithTypeConverter<UtcDateTime?, int> isInMatches =
      GeneratedColumn<int>(
        'is_in_matches',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      ).withConverter<UtcDateTime?>($ProfileStatesTable.$converterisInMatches);
  @override
  late final GeneratedColumnWithTypeConverter<UtcDateTime?, int>
  isInProfileGrid = GeneratedColumn<int>(
    'is_in_profile_grid',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  ).withConverter<UtcDateTime?>($ProfileStatesTable.$converterisInProfileGrid);
  @override
  late final GeneratedColumnWithTypeConverter<UtcDateTime?, int>
  isInAutomaticProfileSearchGrid =
      GeneratedColumn<int>(
        'is_in_automatic_profile_search_grid',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      ).withConverter<UtcDateTime?>(
        $ProfileStatesTable.$converterisInAutomaticProfileSearchGrid,
      );
  @override
  late final GeneratedColumnWithTypeConverter<UtcDateTime?, int>
  isInReceivedLikesGrid =
      GeneratedColumn<int>(
        'is_in_received_likes_grid',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      ).withConverter<UtcDateTime?>(
        $ProfileStatesTable.$converterisInReceivedLikesGrid,
      );
  @override
  late final GeneratedColumnWithTypeConverter<UtcDateTime?, int>
  isInMatchesGrid = GeneratedColumn<int>(
    'is_in_matches_grid',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  ).withConverter<UtcDateTime?>($ProfileStatesTable.$converterisInMatchesGrid);
  @override
  List<GeneratedColumn> get $columns => [
    accountId,
    isInReceivedLikes,
    isInSentLikes,
    isInMatches,
    isInProfileGrid,
    isInAutomaticProfileSearchGrid,
    isInReceivedLikesGrid,
    isInMatchesGrid,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'profile_states';
  @override
  Set<GeneratedColumn> get $primaryKey => {accountId};
  @override
  ProfileState map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProfileState(
      accountId: $ProfileStatesTable.$converteraccountId.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}account_id'],
        )!,
      ),
      isInReceivedLikes: $ProfileStatesTable.$converterisInReceivedLikes
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.int,
              data['${effectivePrefix}is_in_received_likes'],
            ),
          ),
      isInSentLikes: $ProfileStatesTable.$converterisInSentLikes.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}is_in_sent_likes'],
        ),
      ),
      isInMatches: $ProfileStatesTable.$converterisInMatches.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}is_in_matches'],
        ),
      ),
      isInProfileGrid: $ProfileStatesTable.$converterisInProfileGrid.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}is_in_profile_grid'],
        ),
      ),
      isInAutomaticProfileSearchGrid: $ProfileStatesTable
          .$converterisInAutomaticProfileSearchGrid
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.int,
              data['${effectivePrefix}is_in_automatic_profile_search_grid'],
            ),
          ),
      isInReceivedLikesGrid: $ProfileStatesTable.$converterisInReceivedLikesGrid
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.int,
              data['${effectivePrefix}is_in_received_likes_grid'],
            ),
          ),
      isInMatchesGrid: $ProfileStatesTable.$converterisInMatchesGrid.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}is_in_matches_grid'],
        ),
      ),
    );
  }

  @override
  $ProfileStatesTable createAlias(String alias) {
    return $ProfileStatesTable(attachedDatabase, alias);
  }

  static TypeConverter<AccountId, String> $converteraccountId =
      const AccountIdConverter();
  static TypeConverter<UtcDateTime?, int?> $converterisInReceivedLikes =
      const NullAwareTypeConverter.wrap(UtcDateTimeConverter());
  static TypeConverter<UtcDateTime?, int?> $converterisInSentLikes =
      const NullAwareTypeConverter.wrap(UtcDateTimeConverter());
  static TypeConverter<UtcDateTime?, int?> $converterisInMatches =
      const NullAwareTypeConverter.wrap(UtcDateTimeConverter());
  static TypeConverter<UtcDateTime?, int?> $converterisInProfileGrid =
      const NullAwareTypeConverter.wrap(UtcDateTimeConverter());
  static TypeConverter<UtcDateTime?, int?>
  $converterisInAutomaticProfileSearchGrid = const NullAwareTypeConverter.wrap(
    UtcDateTimeConverter(),
  );
  static TypeConverter<UtcDateTime?, int?> $converterisInReceivedLikesGrid =
      const NullAwareTypeConverter.wrap(UtcDateTimeConverter());
  static TypeConverter<UtcDateTime?, int?> $converterisInMatchesGrid =
      const NullAwareTypeConverter.wrap(UtcDateTimeConverter());
}

class ProfileState extends DataClass implements Insertable<ProfileState> {
  final AccountId accountId;
  final UtcDateTime? isInReceivedLikes;
  final UtcDateTime? isInSentLikes;
  final UtcDateTime? isInMatches;
  final UtcDateTime? isInProfileGrid;
  final UtcDateTime? isInAutomaticProfileSearchGrid;
  final UtcDateTime? isInReceivedLikesGrid;
  final UtcDateTime? isInMatchesGrid;
  const ProfileState({
    required this.accountId,
    this.isInReceivedLikes,
    this.isInSentLikes,
    this.isInMatches,
    this.isInProfileGrid,
    this.isInAutomaticProfileSearchGrid,
    this.isInReceivedLikesGrid,
    this.isInMatchesGrid,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    {
      map['account_id'] = Variable<String>(
        $ProfileStatesTable.$converteraccountId.toSql(accountId),
      );
    }
    if (!nullToAbsent || isInReceivedLikes != null) {
      map['is_in_received_likes'] = Variable<int>(
        $ProfileStatesTable.$converterisInReceivedLikes.toSql(
          isInReceivedLikes,
        ),
      );
    }
    if (!nullToAbsent || isInSentLikes != null) {
      map['is_in_sent_likes'] = Variable<int>(
        $ProfileStatesTable.$converterisInSentLikes.toSql(isInSentLikes),
      );
    }
    if (!nullToAbsent || isInMatches != null) {
      map['is_in_matches'] = Variable<int>(
        $ProfileStatesTable.$converterisInMatches.toSql(isInMatches),
      );
    }
    if (!nullToAbsent || isInProfileGrid != null) {
      map['is_in_profile_grid'] = Variable<int>(
        $ProfileStatesTable.$converterisInProfileGrid.toSql(isInProfileGrid),
      );
    }
    if (!nullToAbsent || isInAutomaticProfileSearchGrid != null) {
      map['is_in_automatic_profile_search_grid'] = Variable<int>(
        $ProfileStatesTable.$converterisInAutomaticProfileSearchGrid.toSql(
          isInAutomaticProfileSearchGrid,
        ),
      );
    }
    if (!nullToAbsent || isInReceivedLikesGrid != null) {
      map['is_in_received_likes_grid'] = Variable<int>(
        $ProfileStatesTable.$converterisInReceivedLikesGrid.toSql(
          isInReceivedLikesGrid,
        ),
      );
    }
    if (!nullToAbsent || isInMatchesGrid != null) {
      map['is_in_matches_grid'] = Variable<int>(
        $ProfileStatesTable.$converterisInMatchesGrid.toSql(isInMatchesGrid),
      );
    }
    return map;
  }

  ProfileStatesCompanion toCompanion(bool nullToAbsent) {
    return ProfileStatesCompanion(
      accountId: Value(accountId),
      isInReceivedLikes: isInReceivedLikes == null && nullToAbsent
          ? const Value.absent()
          : Value(isInReceivedLikes),
      isInSentLikes: isInSentLikes == null && nullToAbsent
          ? const Value.absent()
          : Value(isInSentLikes),
      isInMatches: isInMatches == null && nullToAbsent
          ? const Value.absent()
          : Value(isInMatches),
      isInProfileGrid: isInProfileGrid == null && nullToAbsent
          ? const Value.absent()
          : Value(isInProfileGrid),
      isInAutomaticProfileSearchGrid:
          isInAutomaticProfileSearchGrid == null && nullToAbsent
          ? const Value.absent()
          : Value(isInAutomaticProfileSearchGrid),
      isInReceivedLikesGrid: isInReceivedLikesGrid == null && nullToAbsent
          ? const Value.absent()
          : Value(isInReceivedLikesGrid),
      isInMatchesGrid: isInMatchesGrid == null && nullToAbsent
          ? const Value.absent()
          : Value(isInMatchesGrid),
    );
  }

  factory ProfileState.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProfileState(
      accountId: serializer.fromJson<AccountId>(json['accountId']),
      isInReceivedLikes: serializer.fromJson<UtcDateTime?>(
        json['isInReceivedLikes'],
      ),
      isInSentLikes: serializer.fromJson<UtcDateTime?>(json['isInSentLikes']),
      isInMatches: serializer.fromJson<UtcDateTime?>(json['isInMatches']),
      isInProfileGrid: serializer.fromJson<UtcDateTime?>(
        json['isInProfileGrid'],
      ),
      isInAutomaticProfileSearchGrid: serializer.fromJson<UtcDateTime?>(
        json['isInAutomaticProfileSearchGrid'],
      ),
      isInReceivedLikesGrid: serializer.fromJson<UtcDateTime?>(
        json['isInReceivedLikesGrid'],
      ),
      isInMatchesGrid: serializer.fromJson<UtcDateTime?>(
        json['isInMatchesGrid'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'accountId': serializer.toJson<AccountId>(accountId),
      'isInReceivedLikes': serializer.toJson<UtcDateTime?>(isInReceivedLikes),
      'isInSentLikes': serializer.toJson<UtcDateTime?>(isInSentLikes),
      'isInMatches': serializer.toJson<UtcDateTime?>(isInMatches),
      'isInProfileGrid': serializer.toJson<UtcDateTime?>(isInProfileGrid),
      'isInAutomaticProfileSearchGrid': serializer.toJson<UtcDateTime?>(
        isInAutomaticProfileSearchGrid,
      ),
      'isInReceivedLikesGrid': serializer.toJson<UtcDateTime?>(
        isInReceivedLikesGrid,
      ),
      'isInMatchesGrid': serializer.toJson<UtcDateTime?>(isInMatchesGrid),
    };
  }

  ProfileState copyWith({
    AccountId? accountId,
    Value<UtcDateTime?> isInReceivedLikes = const Value.absent(),
    Value<UtcDateTime?> isInSentLikes = const Value.absent(),
    Value<UtcDateTime?> isInMatches = const Value.absent(),
    Value<UtcDateTime?> isInProfileGrid = const Value.absent(),
    Value<UtcDateTime?> isInAutomaticProfileSearchGrid = const Value.absent(),
    Value<UtcDateTime?> isInReceivedLikesGrid = const Value.absent(),
    Value<UtcDateTime?> isInMatchesGrid = const Value.absent(),
  }) => ProfileState(
    accountId: accountId ?? this.accountId,
    isInReceivedLikes: isInReceivedLikes.present
        ? isInReceivedLikes.value
        : this.isInReceivedLikes,
    isInSentLikes: isInSentLikes.present
        ? isInSentLikes.value
        : this.isInSentLikes,
    isInMatches: isInMatches.present ? isInMatches.value : this.isInMatches,
    isInProfileGrid: isInProfileGrid.present
        ? isInProfileGrid.value
        : this.isInProfileGrid,
    isInAutomaticProfileSearchGrid: isInAutomaticProfileSearchGrid.present
        ? isInAutomaticProfileSearchGrid.value
        : this.isInAutomaticProfileSearchGrid,
    isInReceivedLikesGrid: isInReceivedLikesGrid.present
        ? isInReceivedLikesGrid.value
        : this.isInReceivedLikesGrid,
    isInMatchesGrid: isInMatchesGrid.present
        ? isInMatchesGrid.value
        : this.isInMatchesGrid,
  );
  ProfileState copyWithCompanion(ProfileStatesCompanion data) {
    return ProfileState(
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      isInReceivedLikes: data.isInReceivedLikes.present
          ? data.isInReceivedLikes.value
          : this.isInReceivedLikes,
      isInSentLikes: data.isInSentLikes.present
          ? data.isInSentLikes.value
          : this.isInSentLikes,
      isInMatches: data.isInMatches.present
          ? data.isInMatches.value
          : this.isInMatches,
      isInProfileGrid: data.isInProfileGrid.present
          ? data.isInProfileGrid.value
          : this.isInProfileGrid,
      isInAutomaticProfileSearchGrid:
          data.isInAutomaticProfileSearchGrid.present
          ? data.isInAutomaticProfileSearchGrid.value
          : this.isInAutomaticProfileSearchGrid,
      isInReceivedLikesGrid: data.isInReceivedLikesGrid.present
          ? data.isInReceivedLikesGrid.value
          : this.isInReceivedLikesGrid,
      isInMatchesGrid: data.isInMatchesGrid.present
          ? data.isInMatchesGrid.value
          : this.isInMatchesGrid,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProfileState(')
          ..write('accountId: $accountId, ')
          ..write('isInReceivedLikes: $isInReceivedLikes, ')
          ..write('isInSentLikes: $isInSentLikes, ')
          ..write('isInMatches: $isInMatches, ')
          ..write('isInProfileGrid: $isInProfileGrid, ')
          ..write(
            'isInAutomaticProfileSearchGrid: $isInAutomaticProfileSearchGrid, ',
          )
          ..write('isInReceivedLikesGrid: $isInReceivedLikesGrid, ')
          ..write('isInMatchesGrid: $isInMatchesGrid')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    accountId,
    isInReceivedLikes,
    isInSentLikes,
    isInMatches,
    isInProfileGrid,
    isInAutomaticProfileSearchGrid,
    isInReceivedLikesGrid,
    isInMatchesGrid,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProfileState &&
          other.accountId == this.accountId &&
          other.isInReceivedLikes == this.isInReceivedLikes &&
          other.isInSentLikes == this.isInSentLikes &&
          other.isInMatches == this.isInMatches &&
          other.isInProfileGrid == this.isInProfileGrid &&
          other.isInAutomaticProfileSearchGrid ==
              this.isInAutomaticProfileSearchGrid &&
          other.isInReceivedLikesGrid == this.isInReceivedLikesGrid &&
          other.isInMatchesGrid == this.isInMatchesGrid);
}

class ProfileStatesCompanion extends UpdateCompanion<ProfileState> {
  final Value<AccountId> accountId;
  final Value<UtcDateTime?> isInReceivedLikes;
  final Value<UtcDateTime?> isInSentLikes;
  final Value<UtcDateTime?> isInMatches;
  final Value<UtcDateTime?> isInProfileGrid;
  final Value<UtcDateTime?> isInAutomaticProfileSearchGrid;
  final Value<UtcDateTime?> isInReceivedLikesGrid;
  final Value<UtcDateTime?> isInMatchesGrid;
  final Value<int> rowid;
  const ProfileStatesCompanion({
    this.accountId = const Value.absent(),
    this.isInReceivedLikes = const Value.absent(),
    this.isInSentLikes = const Value.absent(),
    this.isInMatches = const Value.absent(),
    this.isInProfileGrid = const Value.absent(),
    this.isInAutomaticProfileSearchGrid = const Value.absent(),
    this.isInReceivedLikesGrid = const Value.absent(),
    this.isInMatchesGrid = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProfileStatesCompanion.insert({
    required AccountId accountId,
    this.isInReceivedLikes = const Value.absent(),
    this.isInSentLikes = const Value.absent(),
    this.isInMatches = const Value.absent(),
    this.isInProfileGrid = const Value.absent(),
    this.isInAutomaticProfileSearchGrid = const Value.absent(),
    this.isInReceivedLikesGrid = const Value.absent(),
    this.isInMatchesGrid = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : accountId = Value(accountId);
  static Insertable<ProfileState> custom({
    Expression<String>? accountId,
    Expression<int>? isInReceivedLikes,
    Expression<int>? isInSentLikes,
    Expression<int>? isInMatches,
    Expression<int>? isInProfileGrid,
    Expression<int>? isInAutomaticProfileSearchGrid,
    Expression<int>? isInReceivedLikesGrid,
    Expression<int>? isInMatchesGrid,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (accountId != null) 'account_id': accountId,
      if (isInReceivedLikes != null) 'is_in_received_likes': isInReceivedLikes,
      if (isInSentLikes != null) 'is_in_sent_likes': isInSentLikes,
      if (isInMatches != null) 'is_in_matches': isInMatches,
      if (isInProfileGrid != null) 'is_in_profile_grid': isInProfileGrid,
      if (isInAutomaticProfileSearchGrid != null)
        'is_in_automatic_profile_search_grid': isInAutomaticProfileSearchGrid,
      if (isInReceivedLikesGrid != null)
        'is_in_received_likes_grid': isInReceivedLikesGrid,
      if (isInMatchesGrid != null) 'is_in_matches_grid': isInMatchesGrid,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProfileStatesCompanion copyWith({
    Value<AccountId>? accountId,
    Value<UtcDateTime?>? isInReceivedLikes,
    Value<UtcDateTime?>? isInSentLikes,
    Value<UtcDateTime?>? isInMatches,
    Value<UtcDateTime?>? isInProfileGrid,
    Value<UtcDateTime?>? isInAutomaticProfileSearchGrid,
    Value<UtcDateTime?>? isInReceivedLikesGrid,
    Value<UtcDateTime?>? isInMatchesGrid,
    Value<int>? rowid,
  }) {
    return ProfileStatesCompanion(
      accountId: accountId ?? this.accountId,
      isInReceivedLikes: isInReceivedLikes ?? this.isInReceivedLikes,
      isInSentLikes: isInSentLikes ?? this.isInSentLikes,
      isInMatches: isInMatches ?? this.isInMatches,
      isInProfileGrid: isInProfileGrid ?? this.isInProfileGrid,
      isInAutomaticProfileSearchGrid:
          isInAutomaticProfileSearchGrid ?? this.isInAutomaticProfileSearchGrid,
      isInReceivedLikesGrid:
          isInReceivedLikesGrid ?? this.isInReceivedLikesGrid,
      isInMatchesGrid: isInMatchesGrid ?? this.isInMatchesGrid,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (accountId.present) {
      map['account_id'] = Variable<String>(
        $ProfileStatesTable.$converteraccountId.toSql(accountId.value),
      );
    }
    if (isInReceivedLikes.present) {
      map['is_in_received_likes'] = Variable<int>(
        $ProfileStatesTable.$converterisInReceivedLikes.toSql(
          isInReceivedLikes.value,
        ),
      );
    }
    if (isInSentLikes.present) {
      map['is_in_sent_likes'] = Variable<int>(
        $ProfileStatesTable.$converterisInSentLikes.toSql(isInSentLikes.value),
      );
    }
    if (isInMatches.present) {
      map['is_in_matches'] = Variable<int>(
        $ProfileStatesTable.$converterisInMatches.toSql(isInMatches.value),
      );
    }
    if (isInProfileGrid.present) {
      map['is_in_profile_grid'] = Variable<int>(
        $ProfileStatesTable.$converterisInProfileGrid.toSql(
          isInProfileGrid.value,
        ),
      );
    }
    if (isInAutomaticProfileSearchGrid.present) {
      map['is_in_automatic_profile_search_grid'] = Variable<int>(
        $ProfileStatesTable.$converterisInAutomaticProfileSearchGrid.toSql(
          isInAutomaticProfileSearchGrid.value,
        ),
      );
    }
    if (isInReceivedLikesGrid.present) {
      map['is_in_received_likes_grid'] = Variable<int>(
        $ProfileStatesTable.$converterisInReceivedLikesGrid.toSql(
          isInReceivedLikesGrid.value,
        ),
      );
    }
    if (isInMatchesGrid.present) {
      map['is_in_matches_grid'] = Variable<int>(
        $ProfileStatesTable.$converterisInMatchesGrid.toSql(
          isInMatchesGrid.value,
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
    return (StringBuffer('ProfileStatesCompanion(')
          ..write('accountId: $accountId, ')
          ..write('isInReceivedLikes: $isInReceivedLikes, ')
          ..write('isInSentLikes: $isInSentLikes, ')
          ..write('isInMatches: $isInMatches, ')
          ..write('isInProfileGrid: $isInProfileGrid, ')
          ..write(
            'isInAutomaticProfileSearchGrid: $isInAutomaticProfileSearchGrid, ',
          )
          ..write('isInReceivedLikesGrid: $isInReceivedLikesGrid, ')
          ..write('isInMatchesGrid: $isInMatchesGrid, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProfileLocationTable extends schema.ProfileLocation
    with TableInfo<$ProfileLocationTable, ProfileLocationData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProfileLocationTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, latitude, longitude];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'profile_location';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProfileLocationData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProfileLocationData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProfileLocationData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      ),
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      ),
    );
  }

  @override
  $ProfileLocationTable createAlias(String alias) {
    return $ProfileLocationTable(attachedDatabase, alias);
  }
}

class ProfileLocationData extends DataClass
    implements Insertable<ProfileLocationData> {
  final int id;
  final double? latitude;
  final double? longitude;
  const ProfileLocationData({required this.id, this.latitude, this.longitude});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || latitude != null) {
      map['latitude'] = Variable<double>(latitude);
    }
    if (!nullToAbsent || longitude != null) {
      map['longitude'] = Variable<double>(longitude);
    }
    return map;
  }

  ProfileLocationCompanion toCompanion(bool nullToAbsent) {
    return ProfileLocationCompanion(
      id: Value(id),
      latitude: latitude == null && nullToAbsent
          ? const Value.absent()
          : Value(latitude),
      longitude: longitude == null && nullToAbsent
          ? const Value.absent()
          : Value(longitude),
    );
  }

  factory ProfileLocationData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProfileLocationData(
      id: serializer.fromJson<int>(json['id']),
      latitude: serializer.fromJson<double?>(json['latitude']),
      longitude: serializer.fromJson<double?>(json['longitude']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'latitude': serializer.toJson<double?>(latitude),
      'longitude': serializer.toJson<double?>(longitude),
    };
  }

  ProfileLocationData copyWith({
    int? id,
    Value<double?> latitude = const Value.absent(),
    Value<double?> longitude = const Value.absent(),
  }) => ProfileLocationData(
    id: id ?? this.id,
    latitude: latitude.present ? latitude.value : this.latitude,
    longitude: longitude.present ? longitude.value : this.longitude,
  );
  ProfileLocationData copyWithCompanion(ProfileLocationCompanion data) {
    return ProfileLocationData(
      id: data.id.present ? data.id.value : this.id,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProfileLocationData(')
          ..write('id: $id, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, latitude, longitude);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProfileLocationData &&
          other.id == this.id &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude);
}

class ProfileLocationCompanion extends UpdateCompanion<ProfileLocationData> {
  final Value<int> id;
  final Value<double?> latitude;
  final Value<double?> longitude;
  const ProfileLocationCompanion({
    this.id = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
  });
  ProfileLocationCompanion.insert({
    this.id = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
  });
  static Insertable<ProfileLocationData> custom({
    Expression<int>? id,
    Expression<double>? latitude,
    Expression<double>? longitude,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
    });
  }

  ProfileLocationCompanion copyWith({
    Value<int>? id,
    Value<double?>? latitude,
    Value<double?>? longitude,
  }) {
    return ProfileLocationCompanion(
      id: id ?? this.id,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProfileLocationCompanion(')
          ..write('id: $id, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude')
          ..write(')'))
        .toString();
  }
}

class $FavoriteProfilesTable extends schema.FavoriteProfiles
    with TableInfo<$FavoriteProfilesTable, FavoriteProfile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavoriteProfilesTable(this.attachedDatabase, [this._alias]);
  @override
  late final GeneratedColumnWithTypeConverter<AccountId, String> accountId =
      GeneratedColumn<String>(
        'account_id',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<AccountId>($FavoriteProfilesTable.$converteraccountId);
  @override
  late final GeneratedColumnWithTypeConverter<UtcDateTime, int>
  addedToFavoritesUnixTime =
      GeneratedColumn<int>(
        'added_to_favorites_unix_time',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<UtcDateTime>(
        $FavoriteProfilesTable.$converteraddedToFavoritesUnixTime,
      );
  @override
  List<GeneratedColumn> get $columns => [accountId, addedToFavoritesUnixTime];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'favorite_profiles';
  @override
  Set<GeneratedColumn> get $primaryKey => {accountId};
  @override
  FavoriteProfile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FavoriteProfile(
      accountId: $FavoriteProfilesTable.$converteraccountId.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}account_id'],
        )!,
      ),
      addedToFavoritesUnixTime: $FavoriteProfilesTable
          .$converteraddedToFavoritesUnixTime
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.int,
              data['${effectivePrefix}added_to_favorites_unix_time'],
            )!,
          ),
    );
  }

  @override
  $FavoriteProfilesTable createAlias(String alias) {
    return $FavoriteProfilesTable(attachedDatabase, alias);
  }

  static TypeConverter<AccountId, String> $converteraccountId =
      const AccountIdConverter();
  static TypeConverter<UtcDateTime, int> $converteraddedToFavoritesUnixTime =
      UtcDateTimeConverter();
}

class FavoriteProfile extends DataClass implements Insertable<FavoriteProfile> {
  final AccountId accountId;
  final UtcDateTime addedToFavoritesUnixTime;
  const FavoriteProfile({
    required this.accountId,
    required this.addedToFavoritesUnixTime,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    {
      map['account_id'] = Variable<String>(
        $FavoriteProfilesTable.$converteraccountId.toSql(accountId),
      );
    }
    {
      map['added_to_favorites_unix_time'] = Variable<int>(
        $FavoriteProfilesTable.$converteraddedToFavoritesUnixTime.toSql(
          addedToFavoritesUnixTime,
        ),
      );
    }
    return map;
  }

  FavoriteProfilesCompanion toCompanion(bool nullToAbsent) {
    return FavoriteProfilesCompanion(
      accountId: Value(accountId),
      addedToFavoritesUnixTime: Value(addedToFavoritesUnixTime),
    );
  }

  factory FavoriteProfile.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FavoriteProfile(
      accountId: serializer.fromJson<AccountId>(json['accountId']),
      addedToFavoritesUnixTime: serializer.fromJson<UtcDateTime>(
        json['addedToFavoritesUnixTime'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'accountId': serializer.toJson<AccountId>(accountId),
      'addedToFavoritesUnixTime': serializer.toJson<UtcDateTime>(
        addedToFavoritesUnixTime,
      ),
    };
  }

  FavoriteProfile copyWith({
    AccountId? accountId,
    UtcDateTime? addedToFavoritesUnixTime,
  }) => FavoriteProfile(
    accountId: accountId ?? this.accountId,
    addedToFavoritesUnixTime:
        addedToFavoritesUnixTime ?? this.addedToFavoritesUnixTime,
  );
  FavoriteProfile copyWithCompanion(FavoriteProfilesCompanion data) {
    return FavoriteProfile(
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      addedToFavoritesUnixTime: data.addedToFavoritesUnixTime.present
          ? data.addedToFavoritesUnixTime.value
          : this.addedToFavoritesUnixTime,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteProfile(')
          ..write('accountId: $accountId, ')
          ..write('addedToFavoritesUnixTime: $addedToFavoritesUnixTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(accountId, addedToFavoritesUnixTime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FavoriteProfile &&
          other.accountId == this.accountId &&
          other.addedToFavoritesUnixTime == this.addedToFavoritesUnixTime);
}

class FavoriteProfilesCompanion extends UpdateCompanion<FavoriteProfile> {
  final Value<AccountId> accountId;
  final Value<UtcDateTime> addedToFavoritesUnixTime;
  final Value<int> rowid;
  const FavoriteProfilesCompanion({
    this.accountId = const Value.absent(),
    this.addedToFavoritesUnixTime = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FavoriteProfilesCompanion.insert({
    required AccountId accountId,
    required UtcDateTime addedToFavoritesUnixTime,
    this.rowid = const Value.absent(),
  }) : accountId = Value(accountId),
       addedToFavoritesUnixTime = Value(addedToFavoritesUnixTime);
  static Insertable<FavoriteProfile> custom({
    Expression<String>? accountId,
    Expression<int>? addedToFavoritesUnixTime,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (accountId != null) 'account_id': accountId,
      if (addedToFavoritesUnixTime != null)
        'added_to_favorites_unix_time': addedToFavoritesUnixTime,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FavoriteProfilesCompanion copyWith({
    Value<AccountId>? accountId,
    Value<UtcDateTime>? addedToFavoritesUnixTime,
    Value<int>? rowid,
  }) {
    return FavoriteProfilesCompanion(
      accountId: accountId ?? this.accountId,
      addedToFavoritesUnixTime:
          addedToFavoritesUnixTime ?? this.addedToFavoritesUnixTime,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (accountId.present) {
      map['account_id'] = Variable<String>(
        $FavoriteProfilesTable.$converteraccountId.toSql(accountId.value),
      );
    }
    if (addedToFavoritesUnixTime.present) {
      map['added_to_favorites_unix_time'] = Variable<int>(
        $FavoriteProfilesTable.$converteraddedToFavoritesUnixTime.toSql(
          addedToFavoritesUnixTime.value,
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
    return (StringBuffer('FavoriteProfilesCompanion(')
          ..write('accountId: $accountId, ')
          ..write('addedToFavoritesUnixTime: $addedToFavoritesUnixTime, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AutomaticProfileSearchSettingsTable
    extends schema.AutomaticProfileSearchSettings
    with
        TableInfo<
          $AutomaticProfileSearchSettingsTable,
          AutomaticProfileSearchSetting
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AutomaticProfileSearchSettingsTable(this.attachedDatabase, [this._alias]);
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
  late final GeneratedColumnWithTypeConverter<
    JsonObject<AutomaticProfileSearchSettings>?,
    String
  >
  jsonAutomaticProfileSearchSettings =
      GeneratedColumn<String>(
        'json_automatic_profile_search_settings',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<JsonObject<AutomaticProfileSearchSettings>?>(
        $AutomaticProfileSearchSettingsTable
            .$converterjsonAutomaticProfileSearchSettings,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    jsonAutomaticProfileSearchSettings,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'automatic_profile_search_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<AutomaticProfileSearchSetting> instance, {
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
  AutomaticProfileSearchSetting map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AutomaticProfileSearchSetting(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      jsonAutomaticProfileSearchSettings: $AutomaticProfileSearchSettingsTable
          .$converterjsonAutomaticProfileSearchSettings
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}json_automatic_profile_search_settings'],
            ),
          ),
    );
  }

  @override
  $AutomaticProfileSearchSettingsTable createAlias(String alias) {
    return $AutomaticProfileSearchSettingsTable(attachedDatabase, alias);
  }

  static TypeConverter<JsonObject<AutomaticProfileSearchSettings>?, String?>
  $converterjsonAutomaticProfileSearchSettings = NullAwareTypeConverter.wrap(
    const AutomaticProfileSearchSettingsConverter(),
  );
}

class AutomaticProfileSearchSetting extends DataClass
    implements Insertable<AutomaticProfileSearchSetting> {
  final int id;
  final JsonObject<AutomaticProfileSearchSettings>?
  jsonAutomaticProfileSearchSettings;
  const AutomaticProfileSearchSetting({
    required this.id,
    this.jsonAutomaticProfileSearchSettings,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || jsonAutomaticProfileSearchSettings != null) {
      map['json_automatic_profile_search_settings'] = Variable<String>(
        $AutomaticProfileSearchSettingsTable
            .$converterjsonAutomaticProfileSearchSettings
            .toSql(jsonAutomaticProfileSearchSettings),
      );
    }
    return map;
  }

  AutomaticProfileSearchSettingsCompanion toCompanion(bool nullToAbsent) {
    return AutomaticProfileSearchSettingsCompanion(
      id: Value(id),
      jsonAutomaticProfileSearchSettings:
          jsonAutomaticProfileSearchSettings == null && nullToAbsent
          ? const Value.absent()
          : Value(jsonAutomaticProfileSearchSettings),
    );
  }

  factory AutomaticProfileSearchSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AutomaticProfileSearchSetting(
      id: serializer.fromJson<int>(json['id']),
      jsonAutomaticProfileSearchSettings: serializer
          .fromJson<JsonObject<AutomaticProfileSearchSettings>?>(
            json['jsonAutomaticProfileSearchSettings'],
          ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'jsonAutomaticProfileSearchSettings': serializer
          .toJson<JsonObject<AutomaticProfileSearchSettings>?>(
            jsonAutomaticProfileSearchSettings,
          ),
    };
  }

  AutomaticProfileSearchSetting copyWith({
    int? id,
    Value<JsonObject<AutomaticProfileSearchSettings>?>
        jsonAutomaticProfileSearchSettings =
        const Value.absent(),
  }) => AutomaticProfileSearchSetting(
    id: id ?? this.id,
    jsonAutomaticProfileSearchSettings:
        jsonAutomaticProfileSearchSettings.present
        ? jsonAutomaticProfileSearchSettings.value
        : this.jsonAutomaticProfileSearchSettings,
  );
  AutomaticProfileSearchSetting copyWithCompanion(
    AutomaticProfileSearchSettingsCompanion data,
  ) {
    return AutomaticProfileSearchSetting(
      id: data.id.present ? data.id.value : this.id,
      jsonAutomaticProfileSearchSettings:
          data.jsonAutomaticProfileSearchSettings.present
          ? data.jsonAutomaticProfileSearchSettings.value
          : this.jsonAutomaticProfileSearchSettings,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AutomaticProfileSearchSetting(')
          ..write('id: $id, ')
          ..write(
            'jsonAutomaticProfileSearchSettings: $jsonAutomaticProfileSearchSettings',
          )
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, jsonAutomaticProfileSearchSettings);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AutomaticProfileSearchSetting &&
          other.id == this.id &&
          other.jsonAutomaticProfileSearchSettings ==
              this.jsonAutomaticProfileSearchSettings);
}

class AutomaticProfileSearchSettingsCompanion
    extends UpdateCompanion<AutomaticProfileSearchSetting> {
  final Value<int> id;
  final Value<JsonObject<AutomaticProfileSearchSettings>?>
  jsonAutomaticProfileSearchSettings;
  const AutomaticProfileSearchSettingsCompanion({
    this.id = const Value.absent(),
    this.jsonAutomaticProfileSearchSettings = const Value.absent(),
  });
  AutomaticProfileSearchSettingsCompanion.insert({
    this.id = const Value.absent(),
    this.jsonAutomaticProfileSearchSettings = const Value.absent(),
  });
  static Insertable<AutomaticProfileSearchSetting> custom({
    Expression<int>? id,
    Expression<String>? jsonAutomaticProfileSearchSettings,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (jsonAutomaticProfileSearchSettings != null)
        'json_automatic_profile_search_settings':
            jsonAutomaticProfileSearchSettings,
    });
  }

  AutomaticProfileSearchSettingsCompanion copyWith({
    Value<int>? id,
    Value<JsonObject<AutomaticProfileSearchSettings>?>?
    jsonAutomaticProfileSearchSettings,
  }) {
    return AutomaticProfileSearchSettingsCompanion(
      id: id ?? this.id,
      jsonAutomaticProfileSearchSettings:
          jsonAutomaticProfileSearchSettings ??
          this.jsonAutomaticProfileSearchSettings,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (jsonAutomaticProfileSearchSettings.present) {
      map['json_automatic_profile_search_settings'] = Variable<String>(
        $AutomaticProfileSearchSettingsTable
            .$converterjsonAutomaticProfileSearchSettings
            .toSql(jsonAutomaticProfileSearchSettings.value),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AutomaticProfileSearchSettingsCompanion(')
          ..write('id: $id, ')
          ..write(
            'jsonAutomaticProfileSearchSettings: $jsonAutomaticProfileSearchSettings',
          )
          ..write(')'))
        .toString();
  }
}

class $AutomaticProfileSearchBadgeStateTable
    extends schema.AutomaticProfileSearchBadgeState
    with
        TableInfo<
          $AutomaticProfileSearchBadgeStateTable,
          AutomaticProfileSearchBadgeStateData
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AutomaticProfileSearchBadgeStateTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _profileCountMeta = const VerificationMeta(
    'profileCount',
  );
  @override
  late final GeneratedColumn<int> profileCount = GeneratedColumn<int>(
    'profile_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _showBadgeMeta = const VerificationMeta(
    'showBadge',
  );
  @override
  late final GeneratedColumn<bool> showBadge = GeneratedColumn<bool>(
    'show_badge',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("show_badge" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [id, profileCount, showBadge];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'automatic_profile_search_badge_state';
  @override
  VerificationContext validateIntegrity(
    Insertable<AutomaticProfileSearchBadgeStateData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('profile_count')) {
      context.handle(
        _profileCountMeta,
        profileCount.isAcceptableOrUnknown(
          data['profile_count']!,
          _profileCountMeta,
        ),
      );
    }
    if (data.containsKey('show_badge')) {
      context.handle(
        _showBadgeMeta,
        showBadge.isAcceptableOrUnknown(data['show_badge']!, _showBadgeMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AutomaticProfileSearchBadgeStateData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AutomaticProfileSearchBadgeStateData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      profileCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}profile_count'],
      )!,
      showBadge: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}show_badge'],
      )!,
    );
  }

  @override
  $AutomaticProfileSearchBadgeStateTable createAlias(String alias) {
    return $AutomaticProfileSearchBadgeStateTable(attachedDatabase, alias);
  }
}

class AutomaticProfileSearchBadgeStateData extends DataClass
    implements Insertable<AutomaticProfileSearchBadgeStateData> {
  final int id;
  final int profileCount;
  final bool showBadge;
  const AutomaticProfileSearchBadgeStateData({
    required this.id,
    required this.profileCount,
    required this.showBadge,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['profile_count'] = Variable<int>(profileCount);
    map['show_badge'] = Variable<bool>(showBadge);
    return map;
  }

  AutomaticProfileSearchBadgeStateCompanion toCompanion(bool nullToAbsent) {
    return AutomaticProfileSearchBadgeStateCompanion(
      id: Value(id),
      profileCount: Value(profileCount),
      showBadge: Value(showBadge),
    );
  }

  factory AutomaticProfileSearchBadgeStateData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AutomaticProfileSearchBadgeStateData(
      id: serializer.fromJson<int>(json['id']),
      profileCount: serializer.fromJson<int>(json['profileCount']),
      showBadge: serializer.fromJson<bool>(json['showBadge']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'profileCount': serializer.toJson<int>(profileCount),
      'showBadge': serializer.toJson<bool>(showBadge),
    };
  }

  AutomaticProfileSearchBadgeStateData copyWith({
    int? id,
    int? profileCount,
    bool? showBadge,
  }) => AutomaticProfileSearchBadgeStateData(
    id: id ?? this.id,
    profileCount: profileCount ?? this.profileCount,
    showBadge: showBadge ?? this.showBadge,
  );
  AutomaticProfileSearchBadgeStateData copyWithCompanion(
    AutomaticProfileSearchBadgeStateCompanion data,
  ) {
    return AutomaticProfileSearchBadgeStateData(
      id: data.id.present ? data.id.value : this.id,
      profileCount: data.profileCount.present
          ? data.profileCount.value
          : this.profileCount,
      showBadge: data.showBadge.present ? data.showBadge.value : this.showBadge,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AutomaticProfileSearchBadgeStateData(')
          ..write('id: $id, ')
          ..write('profileCount: $profileCount, ')
          ..write('showBadge: $showBadge')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, profileCount, showBadge);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AutomaticProfileSearchBadgeStateData &&
          other.id == this.id &&
          other.profileCount == this.profileCount &&
          other.showBadge == this.showBadge);
}

class AutomaticProfileSearchBadgeStateCompanion
    extends UpdateCompanion<AutomaticProfileSearchBadgeStateData> {
  final Value<int> id;
  final Value<int> profileCount;
  final Value<bool> showBadge;
  const AutomaticProfileSearchBadgeStateCompanion({
    this.id = const Value.absent(),
    this.profileCount = const Value.absent(),
    this.showBadge = const Value.absent(),
  });
  AutomaticProfileSearchBadgeStateCompanion.insert({
    this.id = const Value.absent(),
    this.profileCount = const Value.absent(),
    this.showBadge = const Value.absent(),
  });
  static Insertable<AutomaticProfileSearchBadgeStateData> custom({
    Expression<int>? id,
    Expression<int>? profileCount,
    Expression<bool>? showBadge,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (profileCount != null) 'profile_count': profileCount,
      if (showBadge != null) 'show_badge': showBadge,
    });
  }

  AutomaticProfileSearchBadgeStateCompanion copyWith({
    Value<int>? id,
    Value<int>? profileCount,
    Value<bool>? showBadge,
  }) {
    return AutomaticProfileSearchBadgeStateCompanion(
      id: id ?? this.id,
      profileCount: profileCount ?? this.profileCount,
      showBadge: showBadge ?? this.showBadge,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (profileCount.present) {
      map['profile_count'] = Variable<int>(profileCount.value);
    }
    if (showBadge.present) {
      map['show_badge'] = Variable<bool>(showBadge.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AutomaticProfileSearchBadgeStateCompanion(')
          ..write('id: $id, ')
          ..write('profileCount: $profileCount, ')
          ..write('showBadge: $showBadge')
          ..write(')'))
        .toString();
  }
}

class $ProfilePrivacySettingsTable extends schema.ProfilePrivacySettings
    with TableInfo<$ProfilePrivacySettingsTable, ProfilePrivacySetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProfilePrivacySettingsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _lastSeenTimeMeta = const VerificationMeta(
    'lastSeenTime',
  );
  @override
  late final GeneratedColumn<bool> lastSeenTime = GeneratedColumn<bool>(
    'last_seen_time',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("last_seen_time" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _onlineStatusMeta = const VerificationMeta(
    'onlineStatus',
  );
  @override
  late final GeneratedColumn<bool> onlineStatus = GeneratedColumn<bool>(
    'online_status',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("online_status" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [id, lastSeenTime, onlineStatus];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'profile_privacy_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProfilePrivacySetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('last_seen_time')) {
      context.handle(
        _lastSeenTimeMeta,
        lastSeenTime.isAcceptableOrUnknown(
          data['last_seen_time']!,
          _lastSeenTimeMeta,
        ),
      );
    }
    if (data.containsKey('online_status')) {
      context.handle(
        _onlineStatusMeta,
        onlineStatus.isAcceptableOrUnknown(
          data['online_status']!,
          _onlineStatusMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProfilePrivacySetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProfilePrivacySetting(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      lastSeenTime: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}last_seen_time'],
      )!,
      onlineStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}online_status'],
      )!,
    );
  }

  @override
  $ProfilePrivacySettingsTable createAlias(String alias) {
    return $ProfilePrivacySettingsTable(attachedDatabase, alias);
  }
}

class ProfilePrivacySetting extends DataClass
    implements Insertable<ProfilePrivacySetting> {
  final int id;
  final bool lastSeenTime;
  final bool onlineStatus;
  const ProfilePrivacySetting({
    required this.id,
    required this.lastSeenTime,
    required this.onlineStatus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['last_seen_time'] = Variable<bool>(lastSeenTime);
    map['online_status'] = Variable<bool>(onlineStatus);
    return map;
  }

  ProfilePrivacySettingsCompanion toCompanion(bool nullToAbsent) {
    return ProfilePrivacySettingsCompanion(
      id: Value(id),
      lastSeenTime: Value(lastSeenTime),
      onlineStatus: Value(onlineStatus),
    );
  }

  factory ProfilePrivacySetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProfilePrivacySetting(
      id: serializer.fromJson<int>(json['id']),
      lastSeenTime: serializer.fromJson<bool>(json['lastSeenTime']),
      onlineStatus: serializer.fromJson<bool>(json['onlineStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'lastSeenTime': serializer.toJson<bool>(lastSeenTime),
      'onlineStatus': serializer.toJson<bool>(onlineStatus),
    };
  }

  ProfilePrivacySetting copyWith({
    int? id,
    bool? lastSeenTime,
    bool? onlineStatus,
  }) => ProfilePrivacySetting(
    id: id ?? this.id,
    lastSeenTime: lastSeenTime ?? this.lastSeenTime,
    onlineStatus: onlineStatus ?? this.onlineStatus,
  );
  ProfilePrivacySetting copyWithCompanion(
    ProfilePrivacySettingsCompanion data,
  ) {
    return ProfilePrivacySetting(
      id: data.id.present ? data.id.value : this.id,
      lastSeenTime: data.lastSeenTime.present
          ? data.lastSeenTime.value
          : this.lastSeenTime,
      onlineStatus: data.onlineStatus.present
          ? data.onlineStatus.value
          : this.onlineStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProfilePrivacySetting(')
          ..write('id: $id, ')
          ..write('lastSeenTime: $lastSeenTime, ')
          ..write('onlineStatus: $onlineStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, lastSeenTime, onlineStatus);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProfilePrivacySetting &&
          other.id == this.id &&
          other.lastSeenTime == this.lastSeenTime &&
          other.onlineStatus == this.onlineStatus);
}

class ProfilePrivacySettingsCompanion
    extends UpdateCompanion<ProfilePrivacySetting> {
  final Value<int> id;
  final Value<bool> lastSeenTime;
  final Value<bool> onlineStatus;
  const ProfilePrivacySettingsCompanion({
    this.id = const Value.absent(),
    this.lastSeenTime = const Value.absent(),
    this.onlineStatus = const Value.absent(),
  });
  ProfilePrivacySettingsCompanion.insert({
    this.id = const Value.absent(),
    this.lastSeenTime = const Value.absent(),
    this.onlineStatus = const Value.absent(),
  });
  static Insertable<ProfilePrivacySetting> custom({
    Expression<int>? id,
    Expression<bool>? lastSeenTime,
    Expression<bool>? onlineStatus,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (lastSeenTime != null) 'last_seen_time': lastSeenTime,
      if (onlineStatus != null) 'online_status': onlineStatus,
    });
  }

  ProfilePrivacySettingsCompanion copyWith({
    Value<int>? id,
    Value<bool>? lastSeenTime,
    Value<bool>? onlineStatus,
  }) {
    return ProfilePrivacySettingsCompanion(
      id: id ?? this.id,
      lastSeenTime: lastSeenTime ?? this.lastSeenTime,
      onlineStatus: onlineStatus ?? this.onlineStatus,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (lastSeenTime.present) {
      map['last_seen_time'] = Variable<bool>(lastSeenTime.value);
    }
    if (onlineStatus.present) {
      map['online_status'] = Variable<bool>(onlineStatus.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProfilePrivacySettingsCompanion(')
          ..write('id: $id, ')
          ..write('lastSeenTime: $lastSeenTime, ')
          ..write('onlineStatus: $onlineStatus')
          ..write(')'))
        .toString();
  }
}

class $MyKeyPairTable extends schema.MyKeyPair
    with TableInfo<$MyKeyPairTable, MyKeyPairData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MyKeyPairTable(this.attachedDatabase, [this._alias]);
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
  late final GeneratedColumnWithTypeConverter<PrivateKeyBytes?, Uint8List>
  privateKeyData = GeneratedColumn<Uint8List>(
    'private_key_data',
    aliasedName,
    true,
    type: DriftSqlType.blob,
    requiredDuringInsert: false,
  ).withConverter<PrivateKeyBytes?>($MyKeyPairTable.$converterprivateKeyData);
  @override
  late final GeneratedColumnWithTypeConverter<PublicKeyBytes?, Uint8List>
  publicKeyData = GeneratedColumn<Uint8List>(
    'public_key_data',
    aliasedName,
    true,
    type: DriftSqlType.blob,
    requiredDuringInsert: false,
  ).withConverter<PublicKeyBytes?>($MyKeyPairTable.$converterpublicKeyData);
  @override
  late final GeneratedColumnWithTypeConverter<PublicKeyId?, int> publicKeyId =
      GeneratedColumn<int>(
        'public_key_id',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      ).withConverter<PublicKeyId?>($MyKeyPairTable.$converterpublicKeyId);
  @override
  late final GeneratedColumnWithTypeConverter<PublicKeyId?, int>
  publicKeyIdOnServer = GeneratedColumn<int>(
    'public_key_id_on_server',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  ).withConverter<PublicKeyId?>($MyKeyPairTable.$converterpublicKeyIdOnServer);
  @override
  List<GeneratedColumn> get $columns => [
    id,
    privateKeyData,
    publicKeyData,
    publicKeyId,
    publicKeyIdOnServer,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'my_key_pair';
  @override
  VerificationContext validateIntegrity(
    Insertable<MyKeyPairData> instance, {
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
  MyKeyPairData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MyKeyPairData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      privateKeyData: $MyKeyPairTable.$converterprivateKeyData.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.blob,
          data['${effectivePrefix}private_key_data'],
        ),
      ),
      publicKeyData: $MyKeyPairTable.$converterpublicKeyData.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.blob,
          data['${effectivePrefix}public_key_data'],
        ),
      ),
      publicKeyId: $MyKeyPairTable.$converterpublicKeyId.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}public_key_id'],
        ),
      ),
      publicKeyIdOnServer: $MyKeyPairTable.$converterpublicKeyIdOnServer
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.int,
              data['${effectivePrefix}public_key_id_on_server'],
            ),
          ),
    );
  }

  @override
  $MyKeyPairTable createAlias(String alias) {
    return $MyKeyPairTable(attachedDatabase, alias);
  }

  static TypeConverter<PrivateKeyBytes?, Uint8List?> $converterprivateKeyData =
      const NullAwareTypeConverter.wrap(PrivateKeyBytesConverter());
  static TypeConverter<PublicKeyBytes?, Uint8List?> $converterpublicKeyData =
      const NullAwareTypeConverter.wrap(PublicKeyBytesConverter());
  static TypeConverter<PublicKeyId?, int?> $converterpublicKeyId =
      const NullAwareTypeConverter.wrap(PublicKeyIdConverter());
  static TypeConverter<PublicKeyId?, int?> $converterpublicKeyIdOnServer =
      const NullAwareTypeConverter.wrap(PublicKeyIdConverter());
}

class MyKeyPairData extends DataClass implements Insertable<MyKeyPairData> {
  final int id;
  final PrivateKeyBytes? privateKeyData;
  final PublicKeyBytes? publicKeyData;
  final PublicKeyId? publicKeyId;
  final PublicKeyId? publicKeyIdOnServer;
  const MyKeyPairData({
    required this.id,
    this.privateKeyData,
    this.publicKeyData,
    this.publicKeyId,
    this.publicKeyIdOnServer,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || privateKeyData != null) {
      map['private_key_data'] = Variable<Uint8List>(
        $MyKeyPairTable.$converterprivateKeyData.toSql(privateKeyData),
      );
    }
    if (!nullToAbsent || publicKeyData != null) {
      map['public_key_data'] = Variable<Uint8List>(
        $MyKeyPairTable.$converterpublicKeyData.toSql(publicKeyData),
      );
    }
    if (!nullToAbsent || publicKeyId != null) {
      map['public_key_id'] = Variable<int>(
        $MyKeyPairTable.$converterpublicKeyId.toSql(publicKeyId),
      );
    }
    if (!nullToAbsent || publicKeyIdOnServer != null) {
      map['public_key_id_on_server'] = Variable<int>(
        $MyKeyPairTable.$converterpublicKeyIdOnServer.toSql(
          publicKeyIdOnServer,
        ),
      );
    }
    return map;
  }

  MyKeyPairCompanion toCompanion(bool nullToAbsent) {
    return MyKeyPairCompanion(
      id: Value(id),
      privateKeyData: privateKeyData == null && nullToAbsent
          ? const Value.absent()
          : Value(privateKeyData),
      publicKeyData: publicKeyData == null && nullToAbsent
          ? const Value.absent()
          : Value(publicKeyData),
      publicKeyId: publicKeyId == null && nullToAbsent
          ? const Value.absent()
          : Value(publicKeyId),
      publicKeyIdOnServer: publicKeyIdOnServer == null && nullToAbsent
          ? const Value.absent()
          : Value(publicKeyIdOnServer),
    );
  }

  factory MyKeyPairData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MyKeyPairData(
      id: serializer.fromJson<int>(json['id']),
      privateKeyData: serializer.fromJson<PrivateKeyBytes?>(
        json['privateKeyData'],
      ),
      publicKeyData: serializer.fromJson<PublicKeyBytes?>(
        json['publicKeyData'],
      ),
      publicKeyId: serializer.fromJson<PublicKeyId?>(json['publicKeyId']),
      publicKeyIdOnServer: serializer.fromJson<PublicKeyId?>(
        json['publicKeyIdOnServer'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'privateKeyData': serializer.toJson<PrivateKeyBytes?>(privateKeyData),
      'publicKeyData': serializer.toJson<PublicKeyBytes?>(publicKeyData),
      'publicKeyId': serializer.toJson<PublicKeyId?>(publicKeyId),
      'publicKeyIdOnServer': serializer.toJson<PublicKeyId?>(
        publicKeyIdOnServer,
      ),
    };
  }

  MyKeyPairData copyWith({
    int? id,
    Value<PrivateKeyBytes?> privateKeyData = const Value.absent(),
    Value<PublicKeyBytes?> publicKeyData = const Value.absent(),
    Value<PublicKeyId?> publicKeyId = const Value.absent(),
    Value<PublicKeyId?> publicKeyIdOnServer = const Value.absent(),
  }) => MyKeyPairData(
    id: id ?? this.id,
    privateKeyData: privateKeyData.present
        ? privateKeyData.value
        : this.privateKeyData,
    publicKeyData: publicKeyData.present
        ? publicKeyData.value
        : this.publicKeyData,
    publicKeyId: publicKeyId.present ? publicKeyId.value : this.publicKeyId,
    publicKeyIdOnServer: publicKeyIdOnServer.present
        ? publicKeyIdOnServer.value
        : this.publicKeyIdOnServer,
  );
  MyKeyPairData copyWithCompanion(MyKeyPairCompanion data) {
    return MyKeyPairData(
      id: data.id.present ? data.id.value : this.id,
      privateKeyData: data.privateKeyData.present
          ? data.privateKeyData.value
          : this.privateKeyData,
      publicKeyData: data.publicKeyData.present
          ? data.publicKeyData.value
          : this.publicKeyData,
      publicKeyId: data.publicKeyId.present
          ? data.publicKeyId.value
          : this.publicKeyId,
      publicKeyIdOnServer: data.publicKeyIdOnServer.present
          ? data.publicKeyIdOnServer.value
          : this.publicKeyIdOnServer,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MyKeyPairData(')
          ..write('id: $id, ')
          ..write('privateKeyData: $privateKeyData, ')
          ..write('publicKeyData: $publicKeyData, ')
          ..write('publicKeyId: $publicKeyId, ')
          ..write('publicKeyIdOnServer: $publicKeyIdOnServer')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    privateKeyData,
    publicKeyData,
    publicKeyId,
    publicKeyIdOnServer,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MyKeyPairData &&
          other.id == this.id &&
          other.privateKeyData == this.privateKeyData &&
          other.publicKeyData == this.publicKeyData &&
          other.publicKeyId == this.publicKeyId &&
          other.publicKeyIdOnServer == this.publicKeyIdOnServer);
}

class MyKeyPairCompanion extends UpdateCompanion<MyKeyPairData> {
  final Value<int> id;
  final Value<PrivateKeyBytes?> privateKeyData;
  final Value<PublicKeyBytes?> publicKeyData;
  final Value<PublicKeyId?> publicKeyId;
  final Value<PublicKeyId?> publicKeyIdOnServer;
  const MyKeyPairCompanion({
    this.id = const Value.absent(),
    this.privateKeyData = const Value.absent(),
    this.publicKeyData = const Value.absent(),
    this.publicKeyId = const Value.absent(),
    this.publicKeyIdOnServer = const Value.absent(),
  });
  MyKeyPairCompanion.insert({
    this.id = const Value.absent(),
    this.privateKeyData = const Value.absent(),
    this.publicKeyData = const Value.absent(),
    this.publicKeyId = const Value.absent(),
    this.publicKeyIdOnServer = const Value.absent(),
  });
  static Insertable<MyKeyPairData> custom({
    Expression<int>? id,
    Expression<Uint8List>? privateKeyData,
    Expression<Uint8List>? publicKeyData,
    Expression<int>? publicKeyId,
    Expression<int>? publicKeyIdOnServer,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (privateKeyData != null) 'private_key_data': privateKeyData,
      if (publicKeyData != null) 'public_key_data': publicKeyData,
      if (publicKeyId != null) 'public_key_id': publicKeyId,
      if (publicKeyIdOnServer != null)
        'public_key_id_on_server': publicKeyIdOnServer,
    });
  }

  MyKeyPairCompanion copyWith({
    Value<int>? id,
    Value<PrivateKeyBytes?>? privateKeyData,
    Value<PublicKeyBytes?>? publicKeyData,
    Value<PublicKeyId?>? publicKeyId,
    Value<PublicKeyId?>? publicKeyIdOnServer,
  }) {
    return MyKeyPairCompanion(
      id: id ?? this.id,
      privateKeyData: privateKeyData ?? this.privateKeyData,
      publicKeyData: publicKeyData ?? this.publicKeyData,
      publicKeyId: publicKeyId ?? this.publicKeyId,
      publicKeyIdOnServer: publicKeyIdOnServer ?? this.publicKeyIdOnServer,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (privateKeyData.present) {
      map['private_key_data'] = Variable<Uint8List>(
        $MyKeyPairTable.$converterprivateKeyData.toSql(privateKeyData.value),
      );
    }
    if (publicKeyData.present) {
      map['public_key_data'] = Variable<Uint8List>(
        $MyKeyPairTable.$converterpublicKeyData.toSql(publicKeyData.value),
      );
    }
    if (publicKeyId.present) {
      map['public_key_id'] = Variable<int>(
        $MyKeyPairTable.$converterpublicKeyId.toSql(publicKeyId.value),
      );
    }
    if (publicKeyIdOnServer.present) {
      map['public_key_id_on_server'] = Variable<int>(
        $MyKeyPairTable.$converterpublicKeyIdOnServer.toSql(
          publicKeyIdOnServer.value,
        ),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MyKeyPairCompanion(')
          ..write('id: $id, ')
          ..write('privateKeyData: $privateKeyData, ')
          ..write('publicKeyData: $publicKeyData, ')
          ..write('publicKeyId: $publicKeyId, ')
          ..write('publicKeyIdOnServer: $publicKeyIdOnServer')
          ..write(')'))
        .toString();
  }
}

class $PublicKeyTable extends schema.PublicKey
    with TableInfo<$PublicKeyTable, PublicKeyData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PublicKeyTable(this.attachedDatabase, [this._alias]);
  @override
  late final GeneratedColumnWithTypeConverter<AccountId, String> accountId =
      GeneratedColumn<String>(
        'account_id',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<AccountId>($PublicKeyTable.$converteraccountId);
  static const VerificationMeta _publicKeyDataMeta = const VerificationMeta(
    'publicKeyData',
  );
  @override
  late final GeneratedColumn<Uint8List> publicKeyData =
      GeneratedColumn<Uint8List>(
        'public_key_data',
        aliasedName,
        true,
        type: DriftSqlType.blob,
        requiredDuringInsert: false,
      );
  @override
  late final GeneratedColumnWithTypeConverter<PublicKeyId?, int> publicKeyId =
      GeneratedColumn<int>(
        'public_key_id',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      ).withConverter<PublicKeyId?>($PublicKeyTable.$converterpublicKeyId);
  @override
  List<GeneratedColumn> get $columns => [accountId, publicKeyData, publicKeyId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'public_key';
  @override
  VerificationContext validateIntegrity(
    Insertable<PublicKeyData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('public_key_data')) {
      context.handle(
        _publicKeyDataMeta,
        publicKeyData.isAcceptableOrUnknown(
          data['public_key_data']!,
          _publicKeyDataMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {accountId};
  @override
  PublicKeyData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PublicKeyData(
      accountId: $PublicKeyTable.$converteraccountId.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}account_id'],
        )!,
      ),
      publicKeyData: attachedDatabase.typeMapping.read(
        DriftSqlType.blob,
        data['${effectivePrefix}public_key_data'],
      ),
      publicKeyId: $PublicKeyTable.$converterpublicKeyId.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}public_key_id'],
        ),
      ),
    );
  }

  @override
  $PublicKeyTable createAlias(String alias) {
    return $PublicKeyTable(attachedDatabase, alias);
  }

  static TypeConverter<AccountId, String> $converteraccountId =
      const AccountIdConverter();
  static TypeConverter<PublicKeyId?, int?> $converterpublicKeyId =
      const NullAwareTypeConverter.wrap(PublicKeyIdConverter());
}

class PublicKeyData extends DataClass implements Insertable<PublicKeyData> {
  final AccountId accountId;
  final Uint8List? publicKeyData;
  final PublicKeyId? publicKeyId;
  const PublicKeyData({
    required this.accountId,
    this.publicKeyData,
    this.publicKeyId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    {
      map['account_id'] = Variable<String>(
        $PublicKeyTable.$converteraccountId.toSql(accountId),
      );
    }
    if (!nullToAbsent || publicKeyData != null) {
      map['public_key_data'] = Variable<Uint8List>(publicKeyData);
    }
    if (!nullToAbsent || publicKeyId != null) {
      map['public_key_id'] = Variable<int>(
        $PublicKeyTable.$converterpublicKeyId.toSql(publicKeyId),
      );
    }
    return map;
  }

  PublicKeyCompanion toCompanion(bool nullToAbsent) {
    return PublicKeyCompanion(
      accountId: Value(accountId),
      publicKeyData: publicKeyData == null && nullToAbsent
          ? const Value.absent()
          : Value(publicKeyData),
      publicKeyId: publicKeyId == null && nullToAbsent
          ? const Value.absent()
          : Value(publicKeyId),
    );
  }

  factory PublicKeyData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PublicKeyData(
      accountId: serializer.fromJson<AccountId>(json['accountId']),
      publicKeyData: serializer.fromJson<Uint8List?>(json['publicKeyData']),
      publicKeyId: serializer.fromJson<PublicKeyId?>(json['publicKeyId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'accountId': serializer.toJson<AccountId>(accountId),
      'publicKeyData': serializer.toJson<Uint8List?>(publicKeyData),
      'publicKeyId': serializer.toJson<PublicKeyId?>(publicKeyId),
    };
  }

  PublicKeyData copyWith({
    AccountId? accountId,
    Value<Uint8List?> publicKeyData = const Value.absent(),
    Value<PublicKeyId?> publicKeyId = const Value.absent(),
  }) => PublicKeyData(
    accountId: accountId ?? this.accountId,
    publicKeyData: publicKeyData.present
        ? publicKeyData.value
        : this.publicKeyData,
    publicKeyId: publicKeyId.present ? publicKeyId.value : this.publicKeyId,
  );
  PublicKeyData copyWithCompanion(PublicKeyCompanion data) {
    return PublicKeyData(
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      publicKeyData: data.publicKeyData.present
          ? data.publicKeyData.value
          : this.publicKeyData,
      publicKeyId: data.publicKeyId.present
          ? data.publicKeyId.value
          : this.publicKeyId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PublicKeyData(')
          ..write('accountId: $accountId, ')
          ..write('publicKeyData: $publicKeyData, ')
          ..write('publicKeyId: $publicKeyId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    accountId,
    $driftBlobEquality.hash(publicKeyData),
    publicKeyId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PublicKeyData &&
          other.accountId == this.accountId &&
          $driftBlobEquality.equals(other.publicKeyData, this.publicKeyData) &&
          other.publicKeyId == this.publicKeyId);
}

class PublicKeyCompanion extends UpdateCompanion<PublicKeyData> {
  final Value<AccountId> accountId;
  final Value<Uint8List?> publicKeyData;
  final Value<PublicKeyId?> publicKeyId;
  final Value<int> rowid;
  const PublicKeyCompanion({
    this.accountId = const Value.absent(),
    this.publicKeyData = const Value.absent(),
    this.publicKeyId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PublicKeyCompanion.insert({
    required AccountId accountId,
    this.publicKeyData = const Value.absent(),
    this.publicKeyId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : accountId = Value(accountId);
  static Insertable<PublicKeyData> custom({
    Expression<String>? accountId,
    Expression<Uint8List>? publicKeyData,
    Expression<int>? publicKeyId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (accountId != null) 'account_id': accountId,
      if (publicKeyData != null) 'public_key_data': publicKeyData,
      if (publicKeyId != null) 'public_key_id': publicKeyId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PublicKeyCompanion copyWith({
    Value<AccountId>? accountId,
    Value<Uint8List?>? publicKeyData,
    Value<PublicKeyId?>? publicKeyId,
    Value<int>? rowid,
  }) {
    return PublicKeyCompanion(
      accountId: accountId ?? this.accountId,
      publicKeyData: publicKeyData ?? this.publicKeyData,
      publicKeyId: publicKeyId ?? this.publicKeyId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (accountId.present) {
      map['account_id'] = Variable<String>(
        $PublicKeyTable.$converteraccountId.toSql(accountId.value),
      );
    }
    if (publicKeyData.present) {
      map['public_key_data'] = Variable<Uint8List>(publicKeyData.value);
    }
    if (publicKeyId.present) {
      map['public_key_id'] = Variable<int>(
        $PublicKeyTable.$converterpublicKeyId.toSql(publicKeyId.value),
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PublicKeyCompanion(')
          ..write('accountId: $accountId, ')
          ..write('publicKeyData: $publicKeyData, ')
          ..write('publicKeyId: $publicKeyId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ConversationListTable extends schema.ConversationList
    with TableInfo<$ConversationListTable, ConversationListData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ConversationListTable(this.attachedDatabase, [this._alias]);
  @override
  late final GeneratedColumnWithTypeConverter<AccountId, String> accountId =
      GeneratedColumn<String>(
        'account_id',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<AccountId>($ConversationListTable.$converteraccountId);
  @override
  late final GeneratedColumnWithTypeConverter<UtcDateTime?, int>
  conversationLastChangedTime =
      GeneratedColumn<int>(
        'conversation_last_changed_time',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      ).withConverter<UtcDateTime?>(
        $ConversationListTable.$converterconversationLastChangedTime,
      );
  @override
  late final GeneratedColumnWithTypeConverter<UtcDateTime?, int>
  isInSentBlocks =
      GeneratedColumn<int>(
        'is_in_sent_blocks',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      ).withConverter<UtcDateTime?>(
        $ConversationListTable.$converterisInSentBlocks,
      );
  @override
  List<GeneratedColumn> get $columns => [
    accountId,
    conversationLastChangedTime,
    isInSentBlocks,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'conversation_list';
  @override
  Set<GeneratedColumn> get $primaryKey => {accountId};
  @override
  ConversationListData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ConversationListData(
      accountId: $ConversationListTable.$converteraccountId.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}account_id'],
        )!,
      ),
      conversationLastChangedTime: $ConversationListTable
          .$converterconversationLastChangedTime
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.int,
              data['${effectivePrefix}conversation_last_changed_time'],
            ),
          ),
      isInSentBlocks: $ConversationListTable.$converterisInSentBlocks.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}is_in_sent_blocks'],
        ),
      ),
    );
  }

  @override
  $ConversationListTable createAlias(String alias) {
    return $ConversationListTable(attachedDatabase, alias);
  }

  static TypeConverter<AccountId, String> $converteraccountId =
      const AccountIdConverter();
  static TypeConverter<UtcDateTime?, int?>
  $converterconversationLastChangedTime = const NullAwareTypeConverter.wrap(
    UtcDateTimeConverter(),
  );
  static TypeConverter<UtcDateTime?, int?> $converterisInSentBlocks =
      const NullAwareTypeConverter.wrap(UtcDateTimeConverter());
}

class ConversationListData extends DataClass
    implements Insertable<ConversationListData> {
  final AccountId accountId;
  final UtcDateTime? conversationLastChangedTime;

  /// Sent blocks is here to make conversation list updates faster.
  ///
  /// Values:
  /// * null - Not in local sent blocks
  /// * non-null - Time when added to local sent blocks
  final UtcDateTime? isInSentBlocks;
  const ConversationListData({
    required this.accountId,
    this.conversationLastChangedTime,
    this.isInSentBlocks,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    {
      map['account_id'] = Variable<String>(
        $ConversationListTable.$converteraccountId.toSql(accountId),
      );
    }
    if (!nullToAbsent || conversationLastChangedTime != null) {
      map['conversation_last_changed_time'] = Variable<int>(
        $ConversationListTable.$converterconversationLastChangedTime.toSql(
          conversationLastChangedTime,
        ),
      );
    }
    if (!nullToAbsent || isInSentBlocks != null) {
      map['is_in_sent_blocks'] = Variable<int>(
        $ConversationListTable.$converterisInSentBlocks.toSql(isInSentBlocks),
      );
    }
    return map;
  }

  ConversationListCompanion toCompanion(bool nullToAbsent) {
    return ConversationListCompanion(
      accountId: Value(accountId),
      conversationLastChangedTime:
          conversationLastChangedTime == null && nullToAbsent
          ? const Value.absent()
          : Value(conversationLastChangedTime),
      isInSentBlocks: isInSentBlocks == null && nullToAbsent
          ? const Value.absent()
          : Value(isInSentBlocks),
    );
  }

  factory ConversationListData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ConversationListData(
      accountId: serializer.fromJson<AccountId>(json['accountId']),
      conversationLastChangedTime: serializer.fromJson<UtcDateTime?>(
        json['conversationLastChangedTime'],
      ),
      isInSentBlocks: serializer.fromJson<UtcDateTime?>(json['isInSentBlocks']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'accountId': serializer.toJson<AccountId>(accountId),
      'conversationLastChangedTime': serializer.toJson<UtcDateTime?>(
        conversationLastChangedTime,
      ),
      'isInSentBlocks': serializer.toJson<UtcDateTime?>(isInSentBlocks),
    };
  }

  ConversationListData copyWith({
    AccountId? accountId,
    Value<UtcDateTime?> conversationLastChangedTime = const Value.absent(),
    Value<UtcDateTime?> isInSentBlocks = const Value.absent(),
  }) => ConversationListData(
    accountId: accountId ?? this.accountId,
    conversationLastChangedTime: conversationLastChangedTime.present
        ? conversationLastChangedTime.value
        : this.conversationLastChangedTime,
    isInSentBlocks: isInSentBlocks.present
        ? isInSentBlocks.value
        : this.isInSentBlocks,
  );
  ConversationListData copyWithCompanion(ConversationListCompanion data) {
    return ConversationListData(
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      conversationLastChangedTime: data.conversationLastChangedTime.present
          ? data.conversationLastChangedTime.value
          : this.conversationLastChangedTime,
      isInSentBlocks: data.isInSentBlocks.present
          ? data.isInSentBlocks.value
          : this.isInSentBlocks,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ConversationListData(')
          ..write('accountId: $accountId, ')
          ..write('conversationLastChangedTime: $conversationLastChangedTime, ')
          ..write('isInSentBlocks: $isInSentBlocks')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(accountId, conversationLastChangedTime, isInSentBlocks);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ConversationListData &&
          other.accountId == this.accountId &&
          other.conversationLastChangedTime ==
              this.conversationLastChangedTime &&
          other.isInSentBlocks == this.isInSentBlocks);
}

class ConversationListCompanion extends UpdateCompanion<ConversationListData> {
  final Value<AccountId> accountId;
  final Value<UtcDateTime?> conversationLastChangedTime;
  final Value<UtcDateTime?> isInSentBlocks;
  final Value<int> rowid;
  const ConversationListCompanion({
    this.accountId = const Value.absent(),
    this.conversationLastChangedTime = const Value.absent(),
    this.isInSentBlocks = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ConversationListCompanion.insert({
    required AccountId accountId,
    this.conversationLastChangedTime = const Value.absent(),
    this.isInSentBlocks = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : accountId = Value(accountId);
  static Insertable<ConversationListData> custom({
    Expression<String>? accountId,
    Expression<int>? conversationLastChangedTime,
    Expression<int>? isInSentBlocks,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (accountId != null) 'account_id': accountId,
      if (conversationLastChangedTime != null)
        'conversation_last_changed_time': conversationLastChangedTime,
      if (isInSentBlocks != null) 'is_in_sent_blocks': isInSentBlocks,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ConversationListCompanion copyWith({
    Value<AccountId>? accountId,
    Value<UtcDateTime?>? conversationLastChangedTime,
    Value<UtcDateTime?>? isInSentBlocks,
    Value<int>? rowid,
  }) {
    return ConversationListCompanion(
      accountId: accountId ?? this.accountId,
      conversationLastChangedTime:
          conversationLastChangedTime ?? this.conversationLastChangedTime,
      isInSentBlocks: isInSentBlocks ?? this.isInSentBlocks,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (accountId.present) {
      map['account_id'] = Variable<String>(
        $ConversationListTable.$converteraccountId.toSql(accountId.value),
      );
    }
    if (conversationLastChangedTime.present) {
      map['conversation_last_changed_time'] = Variable<int>(
        $ConversationListTable.$converterconversationLastChangedTime.toSql(
          conversationLastChangedTime.value,
        ),
      );
    }
    if (isInSentBlocks.present) {
      map['is_in_sent_blocks'] = Variable<int>(
        $ConversationListTable.$converterisInSentBlocks.toSql(
          isInSentBlocks.value,
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
    return (StringBuffer('ConversationListCompanion(')
          ..write('accountId: $accountId, ')
          ..write('conversationLastChangedTime: $conversationLastChangedTime, ')
          ..write('isInSentBlocks: $isInSentBlocks, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DailyLikesLeftTable extends schema.DailyLikesLeft
    with TableInfo<$DailyLikesLeftTable, DailyLikesLeftData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyLikesLeftTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _dailyLikesLeftMeta = const VerificationMeta(
    'dailyLikesLeft',
  );
  @override
  late final GeneratedColumn<int> dailyLikesLeft = GeneratedColumn<int>(
    'daily_likes_left',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dailyLikesLeftSyncVersionMeta =
      const VerificationMeta('dailyLikesLeftSyncVersion');
  @override
  late final GeneratedColumn<int> dailyLikesLeftSyncVersion =
      GeneratedColumn<int>(
        'daily_likes_left_sync_version',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    dailyLikesLeft,
    dailyLikesLeftSyncVersion,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_likes_left';
  @override
  VerificationContext validateIntegrity(
    Insertable<DailyLikesLeftData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('daily_likes_left')) {
      context.handle(
        _dailyLikesLeftMeta,
        dailyLikesLeft.isAcceptableOrUnknown(
          data['daily_likes_left']!,
          _dailyLikesLeftMeta,
        ),
      );
    }
    if (data.containsKey('daily_likes_left_sync_version')) {
      context.handle(
        _dailyLikesLeftSyncVersionMeta,
        dailyLikesLeftSyncVersion.isAcceptableOrUnknown(
          data['daily_likes_left_sync_version']!,
          _dailyLikesLeftSyncVersionMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DailyLikesLeftData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyLikesLeftData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      dailyLikesLeft: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}daily_likes_left'],
      ),
      dailyLikesLeftSyncVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}daily_likes_left_sync_version'],
      ),
    );
  }

  @override
  $DailyLikesLeftTable createAlias(String alias) {
    return $DailyLikesLeftTable(attachedDatabase, alias);
  }
}

class DailyLikesLeftData extends DataClass
    implements Insertable<DailyLikesLeftData> {
  final int id;
  final int? dailyLikesLeft;
  final int? dailyLikesLeftSyncVersion;
  const DailyLikesLeftData({
    required this.id,
    this.dailyLikesLeft,
    this.dailyLikesLeftSyncVersion,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || dailyLikesLeft != null) {
      map['daily_likes_left'] = Variable<int>(dailyLikesLeft);
    }
    if (!nullToAbsent || dailyLikesLeftSyncVersion != null) {
      map['daily_likes_left_sync_version'] = Variable<int>(
        dailyLikesLeftSyncVersion,
      );
    }
    return map;
  }

  DailyLikesLeftCompanion toCompanion(bool nullToAbsent) {
    return DailyLikesLeftCompanion(
      id: Value(id),
      dailyLikesLeft: dailyLikesLeft == null && nullToAbsent
          ? const Value.absent()
          : Value(dailyLikesLeft),
      dailyLikesLeftSyncVersion:
          dailyLikesLeftSyncVersion == null && nullToAbsent
          ? const Value.absent()
          : Value(dailyLikesLeftSyncVersion),
    );
  }

  factory DailyLikesLeftData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyLikesLeftData(
      id: serializer.fromJson<int>(json['id']),
      dailyLikesLeft: serializer.fromJson<int?>(json['dailyLikesLeft']),
      dailyLikesLeftSyncVersion: serializer.fromJson<int?>(
        json['dailyLikesLeftSyncVersion'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'dailyLikesLeft': serializer.toJson<int?>(dailyLikesLeft),
      'dailyLikesLeftSyncVersion': serializer.toJson<int?>(
        dailyLikesLeftSyncVersion,
      ),
    };
  }

  DailyLikesLeftData copyWith({
    int? id,
    Value<int?> dailyLikesLeft = const Value.absent(),
    Value<int?> dailyLikesLeftSyncVersion = const Value.absent(),
  }) => DailyLikesLeftData(
    id: id ?? this.id,
    dailyLikesLeft: dailyLikesLeft.present
        ? dailyLikesLeft.value
        : this.dailyLikesLeft,
    dailyLikesLeftSyncVersion: dailyLikesLeftSyncVersion.present
        ? dailyLikesLeftSyncVersion.value
        : this.dailyLikesLeftSyncVersion,
  );
  DailyLikesLeftData copyWithCompanion(DailyLikesLeftCompanion data) {
    return DailyLikesLeftData(
      id: data.id.present ? data.id.value : this.id,
      dailyLikesLeft: data.dailyLikesLeft.present
          ? data.dailyLikesLeft.value
          : this.dailyLikesLeft,
      dailyLikesLeftSyncVersion: data.dailyLikesLeftSyncVersion.present
          ? data.dailyLikesLeftSyncVersion.value
          : this.dailyLikesLeftSyncVersion,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyLikesLeftData(')
          ..write('id: $id, ')
          ..write('dailyLikesLeft: $dailyLikesLeft, ')
          ..write('dailyLikesLeftSyncVersion: $dailyLikesLeftSyncVersion')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, dailyLikesLeft, dailyLikesLeftSyncVersion);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyLikesLeftData &&
          other.id == this.id &&
          other.dailyLikesLeft == this.dailyLikesLeft &&
          other.dailyLikesLeftSyncVersion == this.dailyLikesLeftSyncVersion);
}

class DailyLikesLeftCompanion extends UpdateCompanion<DailyLikesLeftData> {
  final Value<int> id;
  final Value<int?> dailyLikesLeft;
  final Value<int?> dailyLikesLeftSyncVersion;
  const DailyLikesLeftCompanion({
    this.id = const Value.absent(),
    this.dailyLikesLeft = const Value.absent(),
    this.dailyLikesLeftSyncVersion = const Value.absent(),
  });
  DailyLikesLeftCompanion.insert({
    this.id = const Value.absent(),
    this.dailyLikesLeft = const Value.absent(),
    this.dailyLikesLeftSyncVersion = const Value.absent(),
  });
  static Insertable<DailyLikesLeftData> custom({
    Expression<int>? id,
    Expression<int>? dailyLikesLeft,
    Expression<int>? dailyLikesLeftSyncVersion,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (dailyLikesLeft != null) 'daily_likes_left': dailyLikesLeft,
      if (dailyLikesLeftSyncVersion != null)
        'daily_likes_left_sync_version': dailyLikesLeftSyncVersion,
    });
  }

  DailyLikesLeftCompanion copyWith({
    Value<int>? id,
    Value<int?>? dailyLikesLeft,
    Value<int?>? dailyLikesLeftSyncVersion,
  }) {
    return DailyLikesLeftCompanion(
      id: id ?? this.id,
      dailyLikesLeft: dailyLikesLeft ?? this.dailyLikesLeft,
      dailyLikesLeftSyncVersion:
          dailyLikesLeftSyncVersion ?? this.dailyLikesLeftSyncVersion,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (dailyLikesLeft.present) {
      map['daily_likes_left'] = Variable<int>(dailyLikesLeft.value);
    }
    if (dailyLikesLeftSyncVersion.present) {
      map['daily_likes_left_sync_version'] = Variable<int>(
        dailyLikesLeftSyncVersion.value,
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyLikesLeftCompanion(')
          ..write('id: $id, ')
          ..write('dailyLikesLeft: $dailyLikesLeft, ')
          ..write('dailyLikesLeftSyncVersion: $dailyLikesLeftSyncVersion')
          ..write(')'))
        .toString();
  }
}

class $ChatPrivacySettingsTable extends schema.ChatPrivacySettings
    with TableInfo<$ChatPrivacySettingsTable, ChatPrivacySetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChatPrivacySettingsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _messageStateDeliveredMeta =
      const VerificationMeta('messageStateDelivered');
  @override
  late final GeneratedColumn<bool> messageStateDelivered =
      GeneratedColumn<bool>(
        'message_state_delivered',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("message_state_delivered" IN (0, 1))',
        ),
        defaultValue: const Constant(false),
      );
  static const VerificationMeta _messageStateSentMeta = const VerificationMeta(
    'messageStateSent',
  );
  @override
  late final GeneratedColumn<bool> messageStateSent = GeneratedColumn<bool>(
    'message_state_sent',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("message_state_sent" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _typingIndicatorMeta = const VerificationMeta(
    'typingIndicator',
  );
  @override
  late final GeneratedColumn<bool> typingIndicator = GeneratedColumn<bool>(
    'typing_indicator',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("typing_indicator" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    messageStateDelivered,
    messageStateSent,
    typingIndicator,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chat_privacy_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<ChatPrivacySetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('message_state_delivered')) {
      context.handle(
        _messageStateDeliveredMeta,
        messageStateDelivered.isAcceptableOrUnknown(
          data['message_state_delivered']!,
          _messageStateDeliveredMeta,
        ),
      );
    }
    if (data.containsKey('message_state_sent')) {
      context.handle(
        _messageStateSentMeta,
        messageStateSent.isAcceptableOrUnknown(
          data['message_state_sent']!,
          _messageStateSentMeta,
        ),
      );
    }
    if (data.containsKey('typing_indicator')) {
      context.handle(
        _typingIndicatorMeta,
        typingIndicator.isAcceptableOrUnknown(
          data['typing_indicator']!,
          _typingIndicatorMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChatPrivacySetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChatPrivacySetting(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      messageStateDelivered: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}message_state_delivered'],
      )!,
      messageStateSent: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}message_state_sent'],
      )!,
      typingIndicator: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}typing_indicator'],
      )!,
    );
  }

  @override
  $ChatPrivacySettingsTable createAlias(String alias) {
    return $ChatPrivacySettingsTable(attachedDatabase, alias);
  }
}

class ChatPrivacySetting extends DataClass
    implements Insertable<ChatPrivacySetting> {
  final int id;
  final bool messageStateDelivered;
  final bool messageStateSent;
  final bool typingIndicator;
  const ChatPrivacySetting({
    required this.id,
    required this.messageStateDelivered,
    required this.messageStateSent,
    required this.typingIndicator,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['message_state_delivered'] = Variable<bool>(messageStateDelivered);
    map['message_state_sent'] = Variable<bool>(messageStateSent);
    map['typing_indicator'] = Variable<bool>(typingIndicator);
    return map;
  }

  ChatPrivacySettingsCompanion toCompanion(bool nullToAbsent) {
    return ChatPrivacySettingsCompanion(
      id: Value(id),
      messageStateDelivered: Value(messageStateDelivered),
      messageStateSent: Value(messageStateSent),
      typingIndicator: Value(typingIndicator),
    );
  }

  factory ChatPrivacySetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChatPrivacySetting(
      id: serializer.fromJson<int>(json['id']),
      messageStateDelivered: serializer.fromJson<bool>(
        json['messageStateDelivered'],
      ),
      messageStateSent: serializer.fromJson<bool>(json['messageStateSent']),
      typingIndicator: serializer.fromJson<bool>(json['typingIndicator']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'messageStateDelivered': serializer.toJson<bool>(messageStateDelivered),
      'messageStateSent': serializer.toJson<bool>(messageStateSent),
      'typingIndicator': serializer.toJson<bool>(typingIndicator),
    };
  }

  ChatPrivacySetting copyWith({
    int? id,
    bool? messageStateDelivered,
    bool? messageStateSent,
    bool? typingIndicator,
  }) => ChatPrivacySetting(
    id: id ?? this.id,
    messageStateDelivered: messageStateDelivered ?? this.messageStateDelivered,
    messageStateSent: messageStateSent ?? this.messageStateSent,
    typingIndicator: typingIndicator ?? this.typingIndicator,
  );
  ChatPrivacySetting copyWithCompanion(ChatPrivacySettingsCompanion data) {
    return ChatPrivacySetting(
      id: data.id.present ? data.id.value : this.id,
      messageStateDelivered: data.messageStateDelivered.present
          ? data.messageStateDelivered.value
          : this.messageStateDelivered,
      messageStateSent: data.messageStateSent.present
          ? data.messageStateSent.value
          : this.messageStateSent,
      typingIndicator: data.typingIndicator.present
          ? data.typingIndicator.value
          : this.typingIndicator,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChatPrivacySetting(')
          ..write('id: $id, ')
          ..write('messageStateDelivered: $messageStateDelivered, ')
          ..write('messageStateSent: $messageStateSent, ')
          ..write('typingIndicator: $typingIndicator')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, messageStateDelivered, messageStateSent, typingIndicator);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChatPrivacySetting &&
          other.id == this.id &&
          other.messageStateDelivered == this.messageStateDelivered &&
          other.messageStateSent == this.messageStateSent &&
          other.typingIndicator == this.typingIndicator);
}

class ChatPrivacySettingsCompanion extends UpdateCompanion<ChatPrivacySetting> {
  final Value<int> id;
  final Value<bool> messageStateDelivered;
  final Value<bool> messageStateSent;
  final Value<bool> typingIndicator;
  const ChatPrivacySettingsCompanion({
    this.id = const Value.absent(),
    this.messageStateDelivered = const Value.absent(),
    this.messageStateSent = const Value.absent(),
    this.typingIndicator = const Value.absent(),
  });
  ChatPrivacySettingsCompanion.insert({
    this.id = const Value.absent(),
    this.messageStateDelivered = const Value.absent(),
    this.messageStateSent = const Value.absent(),
    this.typingIndicator = const Value.absent(),
  });
  static Insertable<ChatPrivacySetting> custom({
    Expression<int>? id,
    Expression<bool>? messageStateDelivered,
    Expression<bool>? messageStateSent,
    Expression<bool>? typingIndicator,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (messageStateDelivered != null)
        'message_state_delivered': messageStateDelivered,
      if (messageStateSent != null) 'message_state_sent': messageStateSent,
      if (typingIndicator != null) 'typing_indicator': typingIndicator,
    });
  }

  ChatPrivacySettingsCompanion copyWith({
    Value<int>? id,
    Value<bool>? messageStateDelivered,
    Value<bool>? messageStateSent,
    Value<bool>? typingIndicator,
  }) {
    return ChatPrivacySettingsCompanion(
      id: id ?? this.id,
      messageStateDelivered:
          messageStateDelivered ?? this.messageStateDelivered,
      messageStateSent: messageStateSent ?? this.messageStateSent,
      typingIndicator: typingIndicator ?? this.typingIndicator,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (messageStateDelivered.present) {
      map['message_state_delivered'] = Variable<bool>(
        messageStateDelivered.value,
      );
    }
    if (messageStateSent.present) {
      map['message_state_sent'] = Variable<bool>(messageStateSent.value);
    }
    if (typingIndicator.present) {
      map['typing_indicator'] = Variable<bool>(typingIndicator.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChatPrivacySettingsCompanion(')
          ..write('id: $id, ')
          ..write('messageStateDelivered: $messageStateDelivered, ')
          ..write('messageStateSent: $messageStateSent, ')
          ..write('typingIndicator: $typingIndicator')
          ..write(')'))
        .toString();
  }
}

class $MessageTable extends schema.Message
    with TableInfo<$MessageTable, MessageData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MessageTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _localIdMeta = const VerificationMeta(
    'localId',
  );
  @override
  late final GeneratedColumn<int> localId = GeneratedColumn<int>(
    'local_id',
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
  late final GeneratedColumnWithTypeConverter<AccountId, String>
  remoteAccountId = GeneratedColumn<String>(
    'remote_account_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<AccountId>($MessageTable.$converterremoteAccountId);
  @override
  late final GeneratedColumnWithTypeConverter<Message?, Uint8List> message =
      GeneratedColumn<Uint8List>(
        'message',
        aliasedName,
        true,
        type: DriftSqlType.blob,
        requiredDuringInsert: false,
      ).withConverter<Message?>($MessageTable.$convertermessage);
  @override
  late final GeneratedColumnWithTypeConverter<UtcDateTime, int> localUnixTime =
      GeneratedColumn<int>(
        'local_unix_time',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<UtcDateTime>($MessageTable.$converterlocalUnixTime);
  static const VerificationMeta _messageStateMeta = const VerificationMeta(
    'messageState',
  );
  @override
  late final GeneratedColumn<int> messageState = GeneratedColumn<int>(
    'message_state',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _symmetricMessageEncryptionKeyMeta =
      const VerificationMeta('symmetricMessageEncryptionKey');
  @override
  late final GeneratedColumn<Uint8List> symmetricMessageEncryptionKey =
      GeneratedColumn<Uint8List>(
        'symmetric_message_encryption_key',
        aliasedName,
        true,
        type: DriftSqlType.blob,
        requiredDuringInsert: false,
      );
  @override
  late final GeneratedColumnWithTypeConverter<MessageNumber?, int>
  messageNumber = GeneratedColumn<int>(
    'message_number',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  ).withConverter<MessageNumber?>($MessageTable.$convertermessageNumber);
  @override
  late final GeneratedColumnWithTypeConverter<UtcDateTime?, int> sentUnixTime =
      GeneratedColumn<int>(
        'sent_unix_time',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      ).withConverter<UtcDateTime?>($MessageTable.$convertersentUnixTime);
  static const VerificationMeta _backendSignedPgpMessageMeta =
      const VerificationMeta('backendSignedPgpMessage');
  @override
  late final GeneratedColumn<Uint8List> backendSignedPgpMessage =
      GeneratedColumn<Uint8List>(
        'backend_signed_pgp_message',
        aliasedName,
        true,
        type: DriftSqlType.blob,
        requiredDuringInsert: false,
      );
  @override
  late final GeneratedColumnWithTypeConverter<UtcDateTime?, int>
  deliveredUnixTime = GeneratedColumn<int>(
    'delivered_unix_time',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  ).withConverter<UtcDateTime?>($MessageTable.$converterdeliveredUnixTime);
  @override
  late final GeneratedColumnWithTypeConverter<UtcDateTime?, int> seenUnixTime =
      GeneratedColumn<int>(
        'seen_unix_time',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      ).withConverter<UtcDateTime?>($MessageTable.$converterseenUnixTime);
  @override
  late final GeneratedColumnWithTypeConverter<MessageId?, String> messageId =
      GeneratedColumn<String>(
        'message_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<MessageId?>($MessageTable.$convertermessageId);
  @override
  List<GeneratedColumn> get $columns => [
    localId,
    remoteAccountId,
    message,
    localUnixTime,
    messageState,
    symmetricMessageEncryptionKey,
    messageNumber,
    sentUnixTime,
    backendSignedPgpMessage,
    deliveredUnixTime,
    seenUnixTime,
    messageId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'message';
  @override
  VerificationContext validateIntegrity(
    Insertable<MessageData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('local_id')) {
      context.handle(
        _localIdMeta,
        localId.isAcceptableOrUnknown(data['local_id']!, _localIdMeta),
      );
    }
    if (data.containsKey('message_state')) {
      context.handle(
        _messageStateMeta,
        messageState.isAcceptableOrUnknown(
          data['message_state']!,
          _messageStateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_messageStateMeta);
    }
    if (data.containsKey('symmetric_message_encryption_key')) {
      context.handle(
        _symmetricMessageEncryptionKeyMeta,
        symmetricMessageEncryptionKey.isAcceptableOrUnknown(
          data['symmetric_message_encryption_key']!,
          _symmetricMessageEncryptionKeyMeta,
        ),
      );
    }
    if (data.containsKey('backend_signed_pgp_message')) {
      context.handle(
        _backendSignedPgpMessageMeta,
        backendSignedPgpMessage.isAcceptableOrUnknown(
          data['backend_signed_pgp_message']!,
          _backendSignedPgpMessageMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {localId};
  @override
  MessageData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MessageData(
      localId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}local_id'],
      )!,
      remoteAccountId: $MessageTable.$converterremoteAccountId.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}remote_account_id'],
        )!,
      ),
      message: $MessageTable.$convertermessage.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.blob,
          data['${effectivePrefix}message'],
        ),
      ),
      localUnixTime: $MessageTable.$converterlocalUnixTime.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}local_unix_time'],
        )!,
      ),
      messageState: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}message_state'],
      )!,
      symmetricMessageEncryptionKey: attachedDatabase.typeMapping.read(
        DriftSqlType.blob,
        data['${effectivePrefix}symmetric_message_encryption_key'],
      ),
      messageNumber: $MessageTable.$convertermessageNumber.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}message_number'],
        ),
      ),
      sentUnixTime: $MessageTable.$convertersentUnixTime.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}sent_unix_time'],
        ),
      ),
      backendSignedPgpMessage: attachedDatabase.typeMapping.read(
        DriftSqlType.blob,
        data['${effectivePrefix}backend_signed_pgp_message'],
      ),
      deliveredUnixTime: $MessageTable.$converterdeliveredUnixTime.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}delivered_unix_time'],
        ),
      ),
      seenUnixTime: $MessageTable.$converterseenUnixTime.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}seen_unix_time'],
        ),
      ),
      messageId: $MessageTable.$convertermessageId.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}message_id'],
        ),
      ),
    );
  }

  @override
  $MessageTable createAlias(String alias) {
    return $MessageTable(attachedDatabase, alias);
  }

  static TypeConverter<AccountId, String> $converterremoteAccountId =
      const AccountIdConverter();
  static TypeConverter<Message?, Uint8List?> $convertermessage =
      const NullAwareTypeConverter.wrap(MessageConverter());
  static TypeConverter<UtcDateTime, int> $converterlocalUnixTime =
      const UtcDateTimeConverter();
  static TypeConverter<MessageNumber?, int?> $convertermessageNumber =
      const NullAwareTypeConverter.wrap(MessageNumberConverter());
  static TypeConverter<UtcDateTime?, int?> $convertersentUnixTime =
      const NullAwareTypeConverter.wrap(UtcDateTimeConverter());
  static TypeConverter<UtcDateTime?, int?> $converterdeliveredUnixTime =
      const NullAwareTypeConverter.wrap(UtcDateTimeConverter());
  static TypeConverter<UtcDateTime?, int?> $converterseenUnixTime =
      const NullAwareTypeConverter.wrap(UtcDateTimeConverter());
  static TypeConverter<MessageId?, String?> $convertermessageId =
      const NullAwareTypeConverter.wrap(MessageIdConverter());
}

class MessageData extends DataClass implements Insertable<MessageData> {
  /// Local message ID
  final int localId;
  final AccountId remoteAccountId;
  final Message? message;
  final UtcDateTime localUnixTime;
  final int messageState;
  final Uint8List? symmetricMessageEncryptionKey;
  final MessageNumber? messageNumber;
  final UtcDateTime? sentUnixTime;
  final Uint8List? backendSignedPgpMessage;
  final UtcDateTime? deliveredUnixTime;
  final UtcDateTime? seenUnixTime;
  final MessageId? messageId;
  const MessageData({
    required this.localId,
    required this.remoteAccountId,
    this.message,
    required this.localUnixTime,
    required this.messageState,
    this.symmetricMessageEncryptionKey,
    this.messageNumber,
    this.sentUnixTime,
    this.backendSignedPgpMessage,
    this.deliveredUnixTime,
    this.seenUnixTime,
    this.messageId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['local_id'] = Variable<int>(localId);
    {
      map['remote_account_id'] = Variable<String>(
        $MessageTable.$converterremoteAccountId.toSql(remoteAccountId),
      );
    }
    if (!nullToAbsent || message != null) {
      map['message'] = Variable<Uint8List>(
        $MessageTable.$convertermessage.toSql(message),
      );
    }
    {
      map['local_unix_time'] = Variable<int>(
        $MessageTable.$converterlocalUnixTime.toSql(localUnixTime),
      );
    }
    map['message_state'] = Variable<int>(messageState);
    if (!nullToAbsent || symmetricMessageEncryptionKey != null) {
      map['symmetric_message_encryption_key'] = Variable<Uint8List>(
        symmetricMessageEncryptionKey,
      );
    }
    if (!nullToAbsent || messageNumber != null) {
      map['message_number'] = Variable<int>(
        $MessageTable.$convertermessageNumber.toSql(messageNumber),
      );
    }
    if (!nullToAbsent || sentUnixTime != null) {
      map['sent_unix_time'] = Variable<int>(
        $MessageTable.$convertersentUnixTime.toSql(sentUnixTime),
      );
    }
    if (!nullToAbsent || backendSignedPgpMessage != null) {
      map['backend_signed_pgp_message'] = Variable<Uint8List>(
        backendSignedPgpMessage,
      );
    }
    if (!nullToAbsent || deliveredUnixTime != null) {
      map['delivered_unix_time'] = Variable<int>(
        $MessageTable.$converterdeliveredUnixTime.toSql(deliveredUnixTime),
      );
    }
    if (!nullToAbsent || seenUnixTime != null) {
      map['seen_unix_time'] = Variable<int>(
        $MessageTable.$converterseenUnixTime.toSql(seenUnixTime),
      );
    }
    if (!nullToAbsent || messageId != null) {
      map['message_id'] = Variable<String>(
        $MessageTable.$convertermessageId.toSql(messageId),
      );
    }
    return map;
  }

  MessageCompanion toCompanion(bool nullToAbsent) {
    return MessageCompanion(
      localId: Value(localId),
      remoteAccountId: Value(remoteAccountId),
      message: message == null && nullToAbsent
          ? const Value.absent()
          : Value(message),
      localUnixTime: Value(localUnixTime),
      messageState: Value(messageState),
      symmetricMessageEncryptionKey:
          symmetricMessageEncryptionKey == null && nullToAbsent
          ? const Value.absent()
          : Value(symmetricMessageEncryptionKey),
      messageNumber: messageNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(messageNumber),
      sentUnixTime: sentUnixTime == null && nullToAbsent
          ? const Value.absent()
          : Value(sentUnixTime),
      backendSignedPgpMessage: backendSignedPgpMessage == null && nullToAbsent
          ? const Value.absent()
          : Value(backendSignedPgpMessage),
      deliveredUnixTime: deliveredUnixTime == null && nullToAbsent
          ? const Value.absent()
          : Value(deliveredUnixTime),
      seenUnixTime: seenUnixTime == null && nullToAbsent
          ? const Value.absent()
          : Value(seenUnixTime),
      messageId: messageId == null && nullToAbsent
          ? const Value.absent()
          : Value(messageId),
    );
  }

  factory MessageData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MessageData(
      localId: serializer.fromJson<int>(json['localId']),
      remoteAccountId: serializer.fromJson<AccountId>(json['remoteAccountId']),
      message: serializer.fromJson<Message?>(json['message']),
      localUnixTime: serializer.fromJson<UtcDateTime>(json['localUnixTime']),
      messageState: serializer.fromJson<int>(json['messageState']),
      symmetricMessageEncryptionKey: serializer.fromJson<Uint8List?>(
        json['symmetricMessageEncryptionKey'],
      ),
      messageNumber: serializer.fromJson<MessageNumber?>(json['messageNumber']),
      sentUnixTime: serializer.fromJson<UtcDateTime?>(json['sentUnixTime']),
      backendSignedPgpMessage: serializer.fromJson<Uint8List?>(
        json['backendSignedPgpMessage'],
      ),
      deliveredUnixTime: serializer.fromJson<UtcDateTime?>(
        json['deliveredUnixTime'],
      ),
      seenUnixTime: serializer.fromJson<UtcDateTime?>(json['seenUnixTime']),
      messageId: serializer.fromJson<MessageId?>(json['messageId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'localId': serializer.toJson<int>(localId),
      'remoteAccountId': serializer.toJson<AccountId>(remoteAccountId),
      'message': serializer.toJson<Message?>(message),
      'localUnixTime': serializer.toJson<UtcDateTime>(localUnixTime),
      'messageState': serializer.toJson<int>(messageState),
      'symmetricMessageEncryptionKey': serializer.toJson<Uint8List?>(
        symmetricMessageEncryptionKey,
      ),
      'messageNumber': serializer.toJson<MessageNumber?>(messageNumber),
      'sentUnixTime': serializer.toJson<UtcDateTime?>(sentUnixTime),
      'backendSignedPgpMessage': serializer.toJson<Uint8List?>(
        backendSignedPgpMessage,
      ),
      'deliveredUnixTime': serializer.toJson<UtcDateTime?>(deliveredUnixTime),
      'seenUnixTime': serializer.toJson<UtcDateTime?>(seenUnixTime),
      'messageId': serializer.toJson<MessageId?>(messageId),
    };
  }

  MessageData copyWith({
    int? localId,
    AccountId? remoteAccountId,
    Value<Message?> message = const Value.absent(),
    UtcDateTime? localUnixTime,
    int? messageState,
    Value<Uint8List?> symmetricMessageEncryptionKey = const Value.absent(),
    Value<MessageNumber?> messageNumber = const Value.absent(),
    Value<UtcDateTime?> sentUnixTime = const Value.absent(),
    Value<Uint8List?> backendSignedPgpMessage = const Value.absent(),
    Value<UtcDateTime?> deliveredUnixTime = const Value.absent(),
    Value<UtcDateTime?> seenUnixTime = const Value.absent(),
    Value<MessageId?> messageId = const Value.absent(),
  }) => MessageData(
    localId: localId ?? this.localId,
    remoteAccountId: remoteAccountId ?? this.remoteAccountId,
    message: message.present ? message.value : this.message,
    localUnixTime: localUnixTime ?? this.localUnixTime,
    messageState: messageState ?? this.messageState,
    symmetricMessageEncryptionKey: symmetricMessageEncryptionKey.present
        ? symmetricMessageEncryptionKey.value
        : this.symmetricMessageEncryptionKey,
    messageNumber: messageNumber.present
        ? messageNumber.value
        : this.messageNumber,
    sentUnixTime: sentUnixTime.present ? sentUnixTime.value : this.sentUnixTime,
    backendSignedPgpMessage: backendSignedPgpMessage.present
        ? backendSignedPgpMessage.value
        : this.backendSignedPgpMessage,
    deliveredUnixTime: deliveredUnixTime.present
        ? deliveredUnixTime.value
        : this.deliveredUnixTime,
    seenUnixTime: seenUnixTime.present ? seenUnixTime.value : this.seenUnixTime,
    messageId: messageId.present ? messageId.value : this.messageId,
  );
  MessageData copyWithCompanion(MessageCompanion data) {
    return MessageData(
      localId: data.localId.present ? data.localId.value : this.localId,
      remoteAccountId: data.remoteAccountId.present
          ? data.remoteAccountId.value
          : this.remoteAccountId,
      message: data.message.present ? data.message.value : this.message,
      localUnixTime: data.localUnixTime.present
          ? data.localUnixTime.value
          : this.localUnixTime,
      messageState: data.messageState.present
          ? data.messageState.value
          : this.messageState,
      symmetricMessageEncryptionKey: data.symmetricMessageEncryptionKey.present
          ? data.symmetricMessageEncryptionKey.value
          : this.symmetricMessageEncryptionKey,
      messageNumber: data.messageNumber.present
          ? data.messageNumber.value
          : this.messageNumber,
      sentUnixTime: data.sentUnixTime.present
          ? data.sentUnixTime.value
          : this.sentUnixTime,
      backendSignedPgpMessage: data.backendSignedPgpMessage.present
          ? data.backendSignedPgpMessage.value
          : this.backendSignedPgpMessage,
      deliveredUnixTime: data.deliveredUnixTime.present
          ? data.deliveredUnixTime.value
          : this.deliveredUnixTime,
      seenUnixTime: data.seenUnixTime.present
          ? data.seenUnixTime.value
          : this.seenUnixTime,
      messageId: data.messageId.present ? data.messageId.value : this.messageId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MessageData(')
          ..write('localId: $localId, ')
          ..write('remoteAccountId: $remoteAccountId, ')
          ..write('message: $message, ')
          ..write('localUnixTime: $localUnixTime, ')
          ..write('messageState: $messageState, ')
          ..write(
            'symmetricMessageEncryptionKey: $symmetricMessageEncryptionKey, ',
          )
          ..write('messageNumber: $messageNumber, ')
          ..write('sentUnixTime: $sentUnixTime, ')
          ..write('backendSignedPgpMessage: $backendSignedPgpMessage, ')
          ..write('deliveredUnixTime: $deliveredUnixTime, ')
          ..write('seenUnixTime: $seenUnixTime, ')
          ..write('messageId: $messageId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    localId,
    remoteAccountId,
    message,
    localUnixTime,
    messageState,
    $driftBlobEquality.hash(symmetricMessageEncryptionKey),
    messageNumber,
    sentUnixTime,
    $driftBlobEquality.hash(backendSignedPgpMessage),
    deliveredUnixTime,
    seenUnixTime,
    messageId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MessageData &&
          other.localId == this.localId &&
          other.remoteAccountId == this.remoteAccountId &&
          other.message == this.message &&
          other.localUnixTime == this.localUnixTime &&
          other.messageState == this.messageState &&
          $driftBlobEquality.equals(
            other.symmetricMessageEncryptionKey,
            this.symmetricMessageEncryptionKey,
          ) &&
          other.messageNumber == this.messageNumber &&
          other.sentUnixTime == this.sentUnixTime &&
          $driftBlobEquality.equals(
            other.backendSignedPgpMessage,
            this.backendSignedPgpMessage,
          ) &&
          other.deliveredUnixTime == this.deliveredUnixTime &&
          other.seenUnixTime == this.seenUnixTime &&
          other.messageId == this.messageId);
}

class MessageCompanion extends UpdateCompanion<MessageData> {
  final Value<int> localId;
  final Value<AccountId> remoteAccountId;
  final Value<Message?> message;
  final Value<UtcDateTime> localUnixTime;
  final Value<int> messageState;
  final Value<Uint8List?> symmetricMessageEncryptionKey;
  final Value<MessageNumber?> messageNumber;
  final Value<UtcDateTime?> sentUnixTime;
  final Value<Uint8List?> backendSignedPgpMessage;
  final Value<UtcDateTime?> deliveredUnixTime;
  final Value<UtcDateTime?> seenUnixTime;
  final Value<MessageId?> messageId;
  const MessageCompanion({
    this.localId = const Value.absent(),
    this.remoteAccountId = const Value.absent(),
    this.message = const Value.absent(),
    this.localUnixTime = const Value.absent(),
    this.messageState = const Value.absent(),
    this.symmetricMessageEncryptionKey = const Value.absent(),
    this.messageNumber = const Value.absent(),
    this.sentUnixTime = const Value.absent(),
    this.backendSignedPgpMessage = const Value.absent(),
    this.deliveredUnixTime = const Value.absent(),
    this.seenUnixTime = const Value.absent(),
    this.messageId = const Value.absent(),
  });
  MessageCompanion.insert({
    this.localId = const Value.absent(),
    required AccountId remoteAccountId,
    this.message = const Value.absent(),
    required UtcDateTime localUnixTime,
    required int messageState,
    this.symmetricMessageEncryptionKey = const Value.absent(),
    this.messageNumber = const Value.absent(),
    this.sentUnixTime = const Value.absent(),
    this.backendSignedPgpMessage = const Value.absent(),
    this.deliveredUnixTime = const Value.absent(),
    this.seenUnixTime = const Value.absent(),
    this.messageId = const Value.absent(),
  }) : remoteAccountId = Value(remoteAccountId),
       localUnixTime = Value(localUnixTime),
       messageState = Value(messageState);
  static Insertable<MessageData> custom({
    Expression<int>? localId,
    Expression<String>? remoteAccountId,
    Expression<Uint8List>? message,
    Expression<int>? localUnixTime,
    Expression<int>? messageState,
    Expression<Uint8List>? symmetricMessageEncryptionKey,
    Expression<int>? messageNumber,
    Expression<int>? sentUnixTime,
    Expression<Uint8List>? backendSignedPgpMessage,
    Expression<int>? deliveredUnixTime,
    Expression<int>? seenUnixTime,
    Expression<String>? messageId,
  }) {
    return RawValuesInsertable({
      if (localId != null) 'local_id': localId,
      if (remoteAccountId != null) 'remote_account_id': remoteAccountId,
      if (message != null) 'message': message,
      if (localUnixTime != null) 'local_unix_time': localUnixTime,
      if (messageState != null) 'message_state': messageState,
      if (symmetricMessageEncryptionKey != null)
        'symmetric_message_encryption_key': symmetricMessageEncryptionKey,
      if (messageNumber != null) 'message_number': messageNumber,
      if (sentUnixTime != null) 'sent_unix_time': sentUnixTime,
      if (backendSignedPgpMessage != null)
        'backend_signed_pgp_message': backendSignedPgpMessage,
      if (deliveredUnixTime != null) 'delivered_unix_time': deliveredUnixTime,
      if (seenUnixTime != null) 'seen_unix_time': seenUnixTime,
      if (messageId != null) 'message_id': messageId,
    });
  }

  MessageCompanion copyWith({
    Value<int>? localId,
    Value<AccountId>? remoteAccountId,
    Value<Message?>? message,
    Value<UtcDateTime>? localUnixTime,
    Value<int>? messageState,
    Value<Uint8List?>? symmetricMessageEncryptionKey,
    Value<MessageNumber?>? messageNumber,
    Value<UtcDateTime?>? sentUnixTime,
    Value<Uint8List?>? backendSignedPgpMessage,
    Value<UtcDateTime?>? deliveredUnixTime,
    Value<UtcDateTime?>? seenUnixTime,
    Value<MessageId?>? messageId,
  }) {
    return MessageCompanion(
      localId: localId ?? this.localId,
      remoteAccountId: remoteAccountId ?? this.remoteAccountId,
      message: message ?? this.message,
      localUnixTime: localUnixTime ?? this.localUnixTime,
      messageState: messageState ?? this.messageState,
      symmetricMessageEncryptionKey:
          symmetricMessageEncryptionKey ?? this.symmetricMessageEncryptionKey,
      messageNumber: messageNumber ?? this.messageNumber,
      sentUnixTime: sentUnixTime ?? this.sentUnixTime,
      backendSignedPgpMessage:
          backendSignedPgpMessage ?? this.backendSignedPgpMessage,
      deliveredUnixTime: deliveredUnixTime ?? this.deliveredUnixTime,
      seenUnixTime: seenUnixTime ?? this.seenUnixTime,
      messageId: messageId ?? this.messageId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (localId.present) {
      map['local_id'] = Variable<int>(localId.value);
    }
    if (remoteAccountId.present) {
      map['remote_account_id'] = Variable<String>(
        $MessageTable.$converterremoteAccountId.toSql(remoteAccountId.value),
      );
    }
    if (message.present) {
      map['message'] = Variable<Uint8List>(
        $MessageTable.$convertermessage.toSql(message.value),
      );
    }
    if (localUnixTime.present) {
      map['local_unix_time'] = Variable<int>(
        $MessageTable.$converterlocalUnixTime.toSql(localUnixTime.value),
      );
    }
    if (messageState.present) {
      map['message_state'] = Variable<int>(messageState.value);
    }
    if (symmetricMessageEncryptionKey.present) {
      map['symmetric_message_encryption_key'] = Variable<Uint8List>(
        symmetricMessageEncryptionKey.value,
      );
    }
    if (messageNumber.present) {
      map['message_number'] = Variable<int>(
        $MessageTable.$convertermessageNumber.toSql(messageNumber.value),
      );
    }
    if (sentUnixTime.present) {
      map['sent_unix_time'] = Variable<int>(
        $MessageTable.$convertersentUnixTime.toSql(sentUnixTime.value),
      );
    }
    if (backendSignedPgpMessage.present) {
      map['backend_signed_pgp_message'] = Variable<Uint8List>(
        backendSignedPgpMessage.value,
      );
    }
    if (deliveredUnixTime.present) {
      map['delivered_unix_time'] = Variable<int>(
        $MessageTable.$converterdeliveredUnixTime.toSql(
          deliveredUnixTime.value,
        ),
      );
    }
    if (seenUnixTime.present) {
      map['seen_unix_time'] = Variable<int>(
        $MessageTable.$converterseenUnixTime.toSql(seenUnixTime.value),
      );
    }
    if (messageId.present) {
      map['message_id'] = Variable<String>(
        $MessageTable.$convertermessageId.toSql(messageId.value),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MessageCompanion(')
          ..write('localId: $localId, ')
          ..write('remoteAccountId: $remoteAccountId, ')
          ..write('message: $message, ')
          ..write('localUnixTime: $localUnixTime, ')
          ..write('messageState: $messageState, ')
          ..write(
            'symmetricMessageEncryptionKey: $symmetricMessageEncryptionKey, ',
          )
          ..write('messageNumber: $messageNumber, ')
          ..write('sentUnixTime: $sentUnixTime, ')
          ..write('backendSignedPgpMessage: $backendSignedPgpMessage, ')
          ..write('deliveredUnixTime: $deliveredUnixTime, ')
          ..write('seenUnixTime: $seenUnixTime, ')
          ..write('messageId: $messageId')
          ..write(')'))
        .toString();
  }
}

class $UnreadMessagesCountTable extends schema.UnreadMessagesCount
    with TableInfo<$UnreadMessagesCountTable, UnreadMessagesCountData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UnreadMessagesCountTable(this.attachedDatabase, [this._alias]);
  @override
  late final GeneratedColumnWithTypeConverter<AccountId, String> accountId =
      GeneratedColumn<String>(
        'account_id',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<AccountId>($UnreadMessagesCountTable.$converteraccountId);
  @override
  late final GeneratedColumnWithTypeConverter<UnreadMessagesCount, int>
  unreadMessagesCount =
      GeneratedColumn<int>(
        'unread_messages_count',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
      ).withConverter<UnreadMessagesCount>(
        $UnreadMessagesCountTable.$converterunreadMessagesCount,
      );
  @override
  List<GeneratedColumn> get $columns => [accountId, unreadMessagesCount];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'unread_messages_count';
  @override
  Set<GeneratedColumn> get $primaryKey => {accountId};
  @override
  UnreadMessagesCountData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UnreadMessagesCountData(
      accountId: $UnreadMessagesCountTable.$converteraccountId.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}account_id'],
        )!,
      ),
      unreadMessagesCount: $UnreadMessagesCountTable
          .$converterunreadMessagesCount
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.int,
              data['${effectivePrefix}unread_messages_count'],
            )!,
          ),
    );
  }

  @override
  $UnreadMessagesCountTable createAlias(String alias) {
    return $UnreadMessagesCountTable(attachedDatabase, alias);
  }

  static TypeConverter<AccountId, String> $converteraccountId =
      const AccountIdConverter();
  static TypeConverter<UnreadMessagesCount, int> $converterunreadMessagesCount =
      UnreadMessagesCountConverter();
}

class UnreadMessagesCountData extends DataClass
    implements Insertable<UnreadMessagesCountData> {
  final AccountId accountId;
  final UnreadMessagesCount unreadMessagesCount;
  const UnreadMessagesCountData({
    required this.accountId,
    required this.unreadMessagesCount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    {
      map['account_id'] = Variable<String>(
        $UnreadMessagesCountTable.$converteraccountId.toSql(accountId),
      );
    }
    {
      map['unread_messages_count'] = Variable<int>(
        $UnreadMessagesCountTable.$converterunreadMessagesCount.toSql(
          unreadMessagesCount,
        ),
      );
    }
    return map;
  }

  UnreadMessagesCountCompanion toCompanion(bool nullToAbsent) {
    return UnreadMessagesCountCompanion(
      accountId: Value(accountId),
      unreadMessagesCount: Value(unreadMessagesCount),
    );
  }

  factory UnreadMessagesCountData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UnreadMessagesCountData(
      accountId: serializer.fromJson<AccountId>(json['accountId']),
      unreadMessagesCount: serializer.fromJson<UnreadMessagesCount>(
        json['unreadMessagesCount'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'accountId': serializer.toJson<AccountId>(accountId),
      'unreadMessagesCount': serializer.toJson<UnreadMessagesCount>(
        unreadMessagesCount,
      ),
    };
  }

  UnreadMessagesCountData copyWith({
    AccountId? accountId,
    UnreadMessagesCount? unreadMessagesCount,
  }) => UnreadMessagesCountData(
    accountId: accountId ?? this.accountId,
    unreadMessagesCount: unreadMessagesCount ?? this.unreadMessagesCount,
  );
  UnreadMessagesCountData copyWithCompanion(UnreadMessagesCountCompanion data) {
    return UnreadMessagesCountData(
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      unreadMessagesCount: data.unreadMessagesCount.present
          ? data.unreadMessagesCount.value
          : this.unreadMessagesCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UnreadMessagesCountData(')
          ..write('accountId: $accountId, ')
          ..write('unreadMessagesCount: $unreadMessagesCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(accountId, unreadMessagesCount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UnreadMessagesCountData &&
          other.accountId == this.accountId &&
          other.unreadMessagesCount == this.unreadMessagesCount);
}

class UnreadMessagesCountCompanion
    extends UpdateCompanion<UnreadMessagesCountData> {
  final Value<AccountId> accountId;
  final Value<UnreadMessagesCount> unreadMessagesCount;
  final Value<int> rowid;
  const UnreadMessagesCountCompanion({
    this.accountId = const Value.absent(),
    this.unreadMessagesCount = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UnreadMessagesCountCompanion.insert({
    required AccountId accountId,
    this.unreadMessagesCount = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : accountId = Value(accountId);
  static Insertable<UnreadMessagesCountData> custom({
    Expression<String>? accountId,
    Expression<int>? unreadMessagesCount,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (accountId != null) 'account_id': accountId,
      if (unreadMessagesCount != null)
        'unread_messages_count': unreadMessagesCount,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UnreadMessagesCountCompanion copyWith({
    Value<AccountId>? accountId,
    Value<UnreadMessagesCount>? unreadMessagesCount,
    Value<int>? rowid,
  }) {
    return UnreadMessagesCountCompanion(
      accountId: accountId ?? this.accountId,
      unreadMessagesCount: unreadMessagesCount ?? this.unreadMessagesCount,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (accountId.present) {
      map['account_id'] = Variable<String>(
        $UnreadMessagesCountTable.$converteraccountId.toSql(accountId.value),
      );
    }
    if (unreadMessagesCount.present) {
      map['unread_messages_count'] = Variable<int>(
        $UnreadMessagesCountTable.$converterunreadMessagesCount.toSql(
          unreadMessagesCount.value,
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
    return (StringBuffer('UnreadMessagesCountCompanion(')
          ..write('accountId: $accountId, ')
          ..write('unreadMessagesCount: $unreadMessagesCount, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NewMessageNotificationTable extends schema.NewMessageNotification
    with TableInfo<$NewMessageNotificationTable, NewMessageNotificationData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NewMessageNotificationTable(this.attachedDatabase, [this._alias]);
  @override
  late final GeneratedColumnWithTypeConverter<AccountId, String> accountId =
      GeneratedColumn<String>(
        'account_id',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<AccountId>(
        $NewMessageNotificationTable.$converteraccountId,
      );
  @override
  late final GeneratedColumnWithTypeConverter<ConversationId?, int>
  conversationId =
      GeneratedColumn<int>(
        'conversation_id',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      ).withConverter<ConversationId?>(
        $NewMessageNotificationTable.$converterconversationId,
      );
  static const VerificationMeta _notificationShownMeta = const VerificationMeta(
    'notificationShown',
  );
  @override
  late final GeneratedColumn<bool> notificationShown = GeneratedColumn<bool>(
    'notification_shown',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("notification_shown" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    accountId,
    conversationId,
    notificationShown,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'new_message_notification';
  @override
  VerificationContext validateIntegrity(
    Insertable<NewMessageNotificationData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('notification_shown')) {
      context.handle(
        _notificationShownMeta,
        notificationShown.isAcceptableOrUnknown(
          data['notification_shown']!,
          _notificationShownMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {accountId};
  @override
  NewMessageNotificationData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NewMessageNotificationData(
      accountId: $NewMessageNotificationTable.$converteraccountId.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}account_id'],
        )!,
      ),
      conversationId: $NewMessageNotificationTable.$converterconversationId
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.int,
              data['${effectivePrefix}conversation_id'],
            ),
          ),
      notificationShown: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}notification_shown'],
      )!,
    );
  }

  @override
  $NewMessageNotificationTable createAlias(String alias) {
    return $NewMessageNotificationTable(attachedDatabase, alias);
  }

  static TypeConverter<AccountId, String> $converteraccountId =
      const AccountIdConverter();
  static TypeConverter<ConversationId?, int?> $converterconversationId =
      const NullAwareTypeConverter.wrap(ConversationIdConverter());
}

class NewMessageNotificationData extends DataClass
    implements Insertable<NewMessageNotificationData> {
  final AccountId accountId;
  final ConversationId? conversationId;
  final bool notificationShown;
  const NewMessageNotificationData({
    required this.accountId,
    this.conversationId,
    required this.notificationShown,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    {
      map['account_id'] = Variable<String>(
        $NewMessageNotificationTable.$converteraccountId.toSql(accountId),
      );
    }
    if (!nullToAbsent || conversationId != null) {
      map['conversation_id'] = Variable<int>(
        $NewMessageNotificationTable.$converterconversationId.toSql(
          conversationId,
        ),
      );
    }
    map['notification_shown'] = Variable<bool>(notificationShown);
    return map;
  }

  NewMessageNotificationCompanion toCompanion(bool nullToAbsent) {
    return NewMessageNotificationCompanion(
      accountId: Value(accountId),
      conversationId: conversationId == null && nullToAbsent
          ? const Value.absent()
          : Value(conversationId),
      notificationShown: Value(notificationShown),
    );
  }

  factory NewMessageNotificationData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NewMessageNotificationData(
      accountId: serializer.fromJson<AccountId>(json['accountId']),
      conversationId: serializer.fromJson<ConversationId?>(
        json['conversationId'],
      ),
      notificationShown: serializer.fromJson<bool>(json['notificationShown']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'accountId': serializer.toJson<AccountId>(accountId),
      'conversationId': serializer.toJson<ConversationId?>(conversationId),
      'notificationShown': serializer.toJson<bool>(notificationShown),
    };
  }

  NewMessageNotificationData copyWith({
    AccountId? accountId,
    Value<ConversationId?> conversationId = const Value.absent(),
    bool? notificationShown,
  }) => NewMessageNotificationData(
    accountId: accountId ?? this.accountId,
    conversationId: conversationId.present
        ? conversationId.value
        : this.conversationId,
    notificationShown: notificationShown ?? this.notificationShown,
  );
  NewMessageNotificationData copyWithCompanion(
    NewMessageNotificationCompanion data,
  ) {
    return NewMessageNotificationData(
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      conversationId: data.conversationId.present
          ? data.conversationId.value
          : this.conversationId,
      notificationShown: data.notificationShown.present
          ? data.notificationShown.value
          : this.notificationShown,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NewMessageNotificationData(')
          ..write('accountId: $accountId, ')
          ..write('conversationId: $conversationId, ')
          ..write('notificationShown: $notificationShown')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(accountId, conversationId, notificationShown);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NewMessageNotificationData &&
          other.accountId == this.accountId &&
          other.conversationId == this.conversationId &&
          other.notificationShown == this.notificationShown);
}

class NewMessageNotificationCompanion
    extends UpdateCompanion<NewMessageNotificationData> {
  final Value<AccountId> accountId;
  final Value<ConversationId?> conversationId;
  final Value<bool> notificationShown;
  final Value<int> rowid;
  const NewMessageNotificationCompanion({
    this.accountId = const Value.absent(),
    this.conversationId = const Value.absent(),
    this.notificationShown = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NewMessageNotificationCompanion.insert({
    required AccountId accountId,
    this.conversationId = const Value.absent(),
    this.notificationShown = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : accountId = Value(accountId);
  static Insertable<NewMessageNotificationData> custom({
    Expression<String>? accountId,
    Expression<int>? conversationId,
    Expression<bool>? notificationShown,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (accountId != null) 'account_id': accountId,
      if (conversationId != null) 'conversation_id': conversationId,
      if (notificationShown != null) 'notification_shown': notificationShown,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NewMessageNotificationCompanion copyWith({
    Value<AccountId>? accountId,
    Value<ConversationId?>? conversationId,
    Value<bool>? notificationShown,
    Value<int>? rowid,
  }) {
    return NewMessageNotificationCompanion(
      accountId: accountId ?? this.accountId,
      conversationId: conversationId ?? this.conversationId,
      notificationShown: notificationShown ?? this.notificationShown,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (accountId.present) {
      map['account_id'] = Variable<String>(
        $NewMessageNotificationTable.$converteraccountId.toSql(accountId.value),
      );
    }
    if (conversationId.present) {
      map['conversation_id'] = Variable<int>(
        $NewMessageNotificationTable.$converterconversationId.toSql(
          conversationId.value,
        ),
      );
    }
    if (notificationShown.present) {
      map['notification_shown'] = Variable<bool>(notificationShown.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NewMessageNotificationCompanion(')
          ..write('accountId: $accountId, ')
          ..write('conversationId: $conversationId, ')
          ..write('notificationShown: $notificationShown, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AccountDatabase extends GeneratedDatabase {
  _$AccountDatabase(QueryExecutor e) : super(e);
  late final $ProfileFilterFavoritesTable profileFilterFavorites =
      $ProfileFilterFavoritesTable(this);
  late final $ShowAdvancedProfileFiltersTable showAdvancedProfileFilters =
      $ShowAdvancedProfileFiltersTable(this);
  late final $InitialSyncTable initialSync = $InitialSyncTable(this);
  late final $InitialSetupSkippedTable initialSetupSkipped =
      $InitialSetupSkippedTable(this);
  late final $GridSettingsTable gridSettings = $GridSettingsTable(this);
  late final $ChatBackupReminderTable chatBackupReminder =
      $ChatBackupReminderTable(this);
  late final $AdminNotificationTable adminNotification =
      $AdminNotificationTable(this);
  late final $AppNotificationSettingsTable appNotificationSettings =
      $AppNotificationSettingsTable(this);
  late final $NotificationStatusTable notificationStatus =
      $NotificationStatusTable(this);
  late final $NewsTable news = $NewsTable(this);
  late final $PushNotificationTable pushNotification = $PushNotificationTable(
    this,
  );
  late final $ServerMaintenanceTable serverMaintenance =
      $ServerMaintenanceTable(this);
  late final $SyncVersionTable syncVersion = $SyncVersionTable(this);
  late final $ReceivedLikesIteratorStateTable receivedLikesIteratorState =
      $ReceivedLikesIteratorStateTable(this);
  late final $ClientFeaturesConfigTable clientFeaturesConfig =
      $ClientFeaturesConfigTable(this);
  late final $CustomReportsConfigTable customReportsConfig =
      $CustomReportsConfigTable(this);
  late final $ProfileAttributesConfigTable profileAttributesConfig =
      $ProfileAttributesConfigTable(this);
  late final $ProfileAttributesConfigAttributesTable
  profileAttributesConfigAttributes = $ProfileAttributesConfigAttributesTable(
    this,
  );
  late final $ClientLanguageOnServerTable clientLanguageOnServer =
      $ClientLanguageOnServerTable(this);
  late final $NewReceivedLikesCountTable newReceivedLikesCount =
      $NewReceivedLikesCountTable(this);
  late final $LocalAccountIdTable localAccountId = $LocalAccountIdTable(this);
  late final $AccountStateTable accountState = $AccountStateTable(this);
  late final $PermissionsTable permissions = $PermissionsTable(this);
  late final $ProfileVisibilityTable profileVisibility =
      $ProfileVisibilityTable(this);
  late final $EmailAddressTable emailAddress = $EmailAddressTable(this);
  late final $EmailVerifiedTable emailVerified = $EmailVerifiedTable(this);
  late final $AccountIdTable accountId = $AccountIdTable(this);
  late final $LoginSessionTokensTable loginSessionTokens =
      $LoginSessionTokensTable(this);
  late final $MyMediaContentTable myMediaContent = $MyMediaContentTable(this);
  late final $ProfileContentTable profileContent = $ProfileContentTable(this);
  late final $MyProfileTable myProfile = $MyProfileTable(this);
  late final $ProfileTable profile = $ProfileTable(this);
  late final $ProfileSearchAgeRangeTable profileSearchAgeRange =
      $ProfileSearchAgeRangeTable(this);
  late final $ProfileSearchGroupsTable profileSearchGroups =
      $ProfileSearchGroupsTable(this);
  late final $ProfileFiltersTable profileFilters = $ProfileFiltersTable(this);
  late final $InitialProfileAgeTable initialProfileAge =
      $InitialProfileAgeTable(this);
  late final $ProfileStatesTable profileStates = $ProfileStatesTable(this);
  late final $ProfileLocationTable profileLocation = $ProfileLocationTable(
    this,
  );
  late final $FavoriteProfilesTable favoriteProfiles = $FavoriteProfilesTable(
    this,
  );
  late final $AutomaticProfileSearchSettingsTable
  automaticProfileSearchSettings = $AutomaticProfileSearchSettingsTable(this);
  late final $AutomaticProfileSearchBadgeStateTable
  automaticProfileSearchBadgeState = $AutomaticProfileSearchBadgeStateTable(
    this,
  );
  late final $ProfilePrivacySettingsTable profilePrivacySettings =
      $ProfilePrivacySettingsTable(this);
  late final $MyKeyPairTable myKeyPair = $MyKeyPairTable(this);
  late final $PublicKeyTable publicKey = $PublicKeyTable(this);
  late final $ConversationListTable conversationList = $ConversationListTable(
    this,
  );
  late final $DailyLikesLeftTable dailyLikesLeft = $DailyLikesLeftTable(this);
  late final $ChatPrivacySettingsTable chatPrivacySettings =
      $ChatPrivacySettingsTable(this);
  late final $MessageTable message = $MessageTable(this);
  late final $UnreadMessagesCountTable unreadMessagesCount =
      $UnreadMessagesCountTable(this);
  late final $NewMessageNotificationTable newMessageNotification =
      $NewMessageNotificationTable(this);
  late final DaoReadApp daoReadApp = DaoReadApp(
    this as AccountDatabase,
  );
  late final DaoReadAppNotificationSettings daoReadAppNotificationSettings =
      DaoReadAppNotificationSettings(this as AccountDatabase);
  late final DaoReadCommon daoReadCommon = DaoReadCommon(
    this as AccountDatabase,
  );
  late final DaoReadConfig daoReadConfig = DaoReadConfig(
    this as AccountDatabase,
  );
  late final DaoReadAccount daoReadAccount = DaoReadAccount(
    this as AccountDatabase,
  );
  late final DaoReadLoginSession daoReadLoginSession = DaoReadLoginSession(
    this as AccountDatabase,
  );
  late final DaoReadMedia daoReadMedia = DaoReadMedia(
    this as AccountDatabase,
  );
  late final DaoReadMyMedia daoReadMyMedia = DaoReadMyMedia(
    this as AccountDatabase,
  );
  late final DaoReadProfile daoReadProfile = DaoReadProfile(
    this as AccountDatabase,
  );
  late final DaoReadMyProfile daoReadMyProfile = DaoReadMyProfile(
    this as AccountDatabase,
  );
  late final DaoReadProfilePrivacy daoReadProfilePrivacy =
      DaoReadProfilePrivacy(this as AccountDatabase);
  late final DaoReadSearch daoReadSearch = DaoReadSearch(
    this as AccountDatabase,
  );
  late final DaoReadBackup daoReadBackup = DaoReadBackup(
    this as AccountDatabase,
  );
  late final DaoReadConversationList daoReadConversationList =
      DaoReadConversationList(this as AccountDatabase);
  late final DaoReadKey daoReadKey = DaoReadKey(
    this as AccountDatabase,
  );
  late final DaoReadLike daoReadLike = DaoReadLike(
    this as AccountDatabase,
  );
  late final DaoReadMessage daoReadMessage = DaoReadMessage(
    this as AccountDatabase,
  );
  late final DaoReadPrivacy daoReadPrivacy = DaoReadPrivacy(
    this as AccountDatabase,
  );
  late final DaoReadChatUnreadMessagesCount daoReadChatUnreadMessagesCount =
      DaoReadChatUnreadMessagesCount(this as AccountDatabase);
  late final DaoWriteApp daoWriteApp = DaoWriteApp(
    this as AccountDatabase,
  );
  late final DaoWriteAppNotificationSettings daoWriteAppNotificationSettings =
      DaoWriteAppNotificationSettings(this as AccountDatabase);
  late final DaoWriteCommon daoWriteCommon = DaoWriteCommon(
    this as AccountDatabase,
  );
  late final DaoWriteConfig daoWriteConfig = DaoWriteConfig(
    this as AccountDatabase,
  );
  late final DaoWriteAccount daoWriteAccount = DaoWriteAccount(
    this as AccountDatabase,
  );
  late final DaoWriteLoginSession daoWriteLoginSession = DaoWriteLoginSession(
    this as AccountDatabase,
  );
  late final DaoWriteMedia daoWriteMedia = DaoWriteMedia(
    this as AccountDatabase,
  );
  late final DaoWriteMyMedia daoWriteMyMedia = DaoWriteMyMedia(
    this as AccountDatabase,
  );
  late final DaoWriteProfile daoWriteProfile = DaoWriteProfile(
    this as AccountDatabase,
  );
  late final DaoWriteMyProfile daoWriteMyProfile = DaoWriteMyProfile(
    this as AccountDatabase,
  );
  late final DaoWriteProfilePrivacy daoWriteProfilePrivacy =
      DaoWriteProfilePrivacy(this as AccountDatabase);
  late final DaoWriteSearch daoWriteSearch = DaoWriteSearch(
    this as AccountDatabase,
  );
  late final DaoWriteBackup daoWriteBackup = DaoWriteBackup(
    this as AccountDatabase,
  );
  late final DaoWriteConversationList daoWriteConversationList =
      DaoWriteConversationList(this as AccountDatabase);
  late final DaoWriteKey daoWriteKey = DaoWriteKey(
    this as AccountDatabase,
  );
  late final DaoWriteLike daoWriteLike = DaoWriteLike(
    this as AccountDatabase,
  );
  late final DaoWriteMessage daoWriteMessage = DaoWriteMessage(
    this as AccountDatabase,
  );
  late final DaoWritePrivacy daoWritePrivacy = DaoWritePrivacy(
    this as AccountDatabase,
  );
  late final DaoWriteChatUnreadMessagesCount daoWriteChatUnreadMessagesCount =
      DaoWriteChatUnreadMessagesCount(this as AccountDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    profileFilterFavorites,
    showAdvancedProfileFilters,
    initialSync,
    initialSetupSkipped,
    gridSettings,
    chatBackupReminder,
    adminNotification,
    appNotificationSettings,
    notificationStatus,
    news,
    pushNotification,
    serverMaintenance,
    syncVersion,
    receivedLikesIteratorState,
    clientFeaturesConfig,
    customReportsConfig,
    profileAttributesConfig,
    profileAttributesConfigAttributes,
    clientLanguageOnServer,
    newReceivedLikesCount,
    localAccountId,
    accountState,
    permissions,
    profileVisibility,
    emailAddress,
    emailVerified,
    accountId,
    loginSessionTokens,
    myMediaContent,
    profileContent,
    myProfile,
    profile,
    profileSearchAgeRange,
    profileSearchGroups,
    profileFilters,
    initialProfileAge,
    profileStates,
    profileLocation,
    favoriteProfiles,
    automaticProfileSearchSettings,
    automaticProfileSearchBadgeState,
    profilePrivacySettings,
    myKeyPair,
    publicKey,
    conversationList,
    dailyLikesLeft,
    chatPrivacySettings,
    message,
    unreadMessagesCount,
    newMessageNotification,
  ];
}
