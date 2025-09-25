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
  late final GeneratedColumnWithTypeConverter<UtcDateTime?, int>
  serverMaintenanceUnixTime =
      GeneratedColumn<int>(
        'server_maintenance_unix_time',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      ).withConverter<UtcDateTime?>(
        $ServerMaintenanceTable.$converterserverMaintenanceUnixTime,
      );
  @override
  late final GeneratedColumnWithTypeConverter<UtcDateTime?, int>
  serverMaintenanceUnixTimeViewed =
      GeneratedColumn<int>(
        'server_maintenance_unix_time_viewed',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      ).withConverter<UtcDateTime?>(
        $ServerMaintenanceTable.$converterserverMaintenanceUnixTimeViewed,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    serverMaintenanceUnixTime,
    serverMaintenanceUnixTimeViewed,
  ];
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
      serverMaintenanceUnixTime: $ServerMaintenanceTable
          .$converterserverMaintenanceUnixTime
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.int,
              data['${effectivePrefix}server_maintenance_unix_time'],
            ),
          ),
      serverMaintenanceUnixTimeViewed: $ServerMaintenanceTable
          .$converterserverMaintenanceUnixTimeViewed
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.int,
              data['${effectivePrefix}server_maintenance_unix_time_viewed'],
            ),
          ),
    );
  }

  @override
  $ServerMaintenanceTable createAlias(String alias) {
    return $ServerMaintenanceTable(attachedDatabase, alias);
  }

  static TypeConverter<UtcDateTime?, int?> $converterserverMaintenanceUnixTime =
      const NullAwareTypeConverter.wrap(UtcDateTimeConverter());
  static TypeConverter<UtcDateTime?, int?>
  $converterserverMaintenanceUnixTimeViewed = const NullAwareTypeConverter.wrap(
    UtcDateTimeConverter(),
  );
}

class ServerMaintenanceData extends DataClass
    implements Insertable<ServerMaintenanceData> {
  final int id;
  final UtcDateTime? serverMaintenanceUnixTime;
  final UtcDateTime? serverMaintenanceUnixTimeViewed;
  const ServerMaintenanceData({
    required this.id,
    this.serverMaintenanceUnixTime,
    this.serverMaintenanceUnixTimeViewed,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || serverMaintenanceUnixTime != null) {
      map['server_maintenance_unix_time'] = Variable<int>(
        $ServerMaintenanceTable.$converterserverMaintenanceUnixTime.toSql(
          serverMaintenanceUnixTime,
        ),
      );
    }
    if (!nullToAbsent || serverMaintenanceUnixTimeViewed != null) {
      map['server_maintenance_unix_time_viewed'] = Variable<int>(
        $ServerMaintenanceTable.$converterserverMaintenanceUnixTimeViewed.toSql(
          serverMaintenanceUnixTimeViewed,
        ),
      );
    }
    return map;
  }

  ServerMaintenanceCompanion toCompanion(bool nullToAbsent) {
    return ServerMaintenanceCompanion(
      id: Value(id),
      serverMaintenanceUnixTime:
          serverMaintenanceUnixTime == null && nullToAbsent
          ? const Value.absent()
          : Value(serverMaintenanceUnixTime),
      serverMaintenanceUnixTimeViewed:
          serverMaintenanceUnixTimeViewed == null && nullToAbsent
          ? const Value.absent()
          : Value(serverMaintenanceUnixTimeViewed),
    );
  }

  factory ServerMaintenanceData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ServerMaintenanceData(
      id: serializer.fromJson<int>(json['id']),
      serverMaintenanceUnixTime: serializer.fromJson<UtcDateTime?>(
        json['serverMaintenanceUnixTime'],
      ),
      serverMaintenanceUnixTimeViewed: serializer.fromJson<UtcDateTime?>(
        json['serverMaintenanceUnixTimeViewed'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'serverMaintenanceUnixTime': serializer.toJson<UtcDateTime?>(
        serverMaintenanceUnixTime,
      ),
      'serverMaintenanceUnixTimeViewed': serializer.toJson<UtcDateTime?>(
        serverMaintenanceUnixTimeViewed,
      ),
    };
  }

  ServerMaintenanceData copyWith({
    int? id,
    Value<UtcDateTime?> serverMaintenanceUnixTime = const Value.absent(),
    Value<UtcDateTime?> serverMaintenanceUnixTimeViewed = const Value.absent(),
  }) => ServerMaintenanceData(
    id: id ?? this.id,
    serverMaintenanceUnixTime: serverMaintenanceUnixTime.present
        ? serverMaintenanceUnixTime.value
        : this.serverMaintenanceUnixTime,
    serverMaintenanceUnixTimeViewed: serverMaintenanceUnixTimeViewed.present
        ? serverMaintenanceUnixTimeViewed.value
        : this.serverMaintenanceUnixTimeViewed,
  );
  ServerMaintenanceData copyWithCompanion(ServerMaintenanceCompanion data) {
    return ServerMaintenanceData(
      id: data.id.present ? data.id.value : this.id,
      serverMaintenanceUnixTime: data.serverMaintenanceUnixTime.present
          ? data.serverMaintenanceUnixTime.value
          : this.serverMaintenanceUnixTime,
      serverMaintenanceUnixTimeViewed:
          data.serverMaintenanceUnixTimeViewed.present
          ? data.serverMaintenanceUnixTimeViewed.value
          : this.serverMaintenanceUnixTimeViewed,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ServerMaintenanceData(')
          ..write('id: $id, ')
          ..write('serverMaintenanceUnixTime: $serverMaintenanceUnixTime, ')
          ..write(
            'serverMaintenanceUnixTimeViewed: $serverMaintenanceUnixTimeViewed',
          )
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    serverMaintenanceUnixTime,
    serverMaintenanceUnixTimeViewed,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ServerMaintenanceData &&
          other.id == this.id &&
          other.serverMaintenanceUnixTime == this.serverMaintenanceUnixTime &&
          other.serverMaintenanceUnixTimeViewed ==
              this.serverMaintenanceUnixTimeViewed);
}

class ServerMaintenanceCompanion
    extends UpdateCompanion<ServerMaintenanceData> {
  final Value<int> id;
  final Value<UtcDateTime?> serverMaintenanceUnixTime;
  final Value<UtcDateTime?> serverMaintenanceUnixTimeViewed;
  const ServerMaintenanceCompanion({
    this.id = const Value.absent(),
    this.serverMaintenanceUnixTime = const Value.absent(),
    this.serverMaintenanceUnixTimeViewed = const Value.absent(),
  });
  ServerMaintenanceCompanion.insert({
    this.id = const Value.absent(),
    this.serverMaintenanceUnixTime = const Value.absent(),
    this.serverMaintenanceUnixTimeViewed = const Value.absent(),
  });
  static Insertable<ServerMaintenanceData> custom({
    Expression<int>? id,
    Expression<int>? serverMaintenanceUnixTime,
    Expression<int>? serverMaintenanceUnixTimeViewed,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (serverMaintenanceUnixTime != null)
        'server_maintenance_unix_time': serverMaintenanceUnixTime,
      if (serverMaintenanceUnixTimeViewed != null)
        'server_maintenance_unix_time_viewed': serverMaintenanceUnixTimeViewed,
    });
  }

  ServerMaintenanceCompanion copyWith({
    Value<int>? id,
    Value<UtcDateTime?>? serverMaintenanceUnixTime,
    Value<UtcDateTime?>? serverMaintenanceUnixTimeViewed,
  }) {
    return ServerMaintenanceCompanion(
      id: id ?? this.id,
      serverMaintenanceUnixTime:
          serverMaintenanceUnixTime ?? this.serverMaintenanceUnixTime,
      serverMaintenanceUnixTimeViewed:
          serverMaintenanceUnixTimeViewed ??
          this.serverMaintenanceUnixTimeViewed,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (serverMaintenanceUnixTime.present) {
      map['server_maintenance_unix_time'] = Variable<int>(
        $ServerMaintenanceTable.$converterserverMaintenanceUnixTime.toSql(
          serverMaintenanceUnixTime.value,
        ),
      );
    }
    if (serverMaintenanceUnixTimeViewed.present) {
      map['server_maintenance_unix_time_viewed'] = Variable<int>(
        $ServerMaintenanceTable.$converterserverMaintenanceUnixTimeViewed.toSql(
          serverMaintenanceUnixTimeViewed.value,
        ),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ServerMaintenanceCompanion(')
          ..write('id: $id, ')
          ..write('serverMaintenanceUnixTime: $serverMaintenanceUnixTime, ')
          ..write(
            'serverMaintenanceUnixTimeViewed: $serverMaintenanceUnixTimeViewed',
          )
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
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
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
  List<GeneratedColumn> get $columns => [id, jsonAttribute, attributeHash];
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
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProfileAttributesConfigAttribute map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProfileAttributesConfigAttribute(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
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
  final int id;
  final JsonObject<Attribute> jsonAttribute;
  final AttributeHash attributeHash;
  const ProfileAttributesConfigAttribute({
    required this.id,
    required this.jsonAttribute,
    required this.attributeHash,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
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
      id: Value(id),
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
      id: serializer.fromJson<int>(json['id']),
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
      'id': serializer.toJson<int>(id),
      'jsonAttribute': serializer.toJson<JsonObject<Attribute>>(jsonAttribute),
      'attributeHash': serializer.toJson<AttributeHash>(attributeHash),
    };
  }

  ProfileAttributesConfigAttribute copyWith({
    int? id,
    JsonObject<Attribute>? jsonAttribute,
    AttributeHash? attributeHash,
  }) => ProfileAttributesConfigAttribute(
    id: id ?? this.id,
    jsonAttribute: jsonAttribute ?? this.jsonAttribute,
    attributeHash: attributeHash ?? this.attributeHash,
  );
  ProfileAttributesConfigAttribute copyWithCompanion(
    ProfileAttributesConfigAttributesCompanion data,
  ) {
    return ProfileAttributesConfigAttribute(
      id: data.id.present ? data.id.value : this.id,
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
          ..write('id: $id, ')
          ..write('jsonAttribute: $jsonAttribute, ')
          ..write('attributeHash: $attributeHash')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, jsonAttribute, attributeHash);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProfileAttributesConfigAttribute &&
          other.id == this.id &&
          other.jsonAttribute == this.jsonAttribute &&
          other.attributeHash == this.attributeHash);
}

class ProfileAttributesConfigAttributesCompanion
    extends UpdateCompanion<ProfileAttributesConfigAttribute> {
  final Value<int> id;
  final Value<JsonObject<Attribute>> jsonAttribute;
  final Value<AttributeHash> attributeHash;
  const ProfileAttributesConfigAttributesCompanion({
    this.id = const Value.absent(),
    this.jsonAttribute = const Value.absent(),
    this.attributeHash = const Value.absent(),
  });
  ProfileAttributesConfigAttributesCompanion.insert({
    this.id = const Value.absent(),
    required JsonObject<Attribute> jsonAttribute,
    required AttributeHash attributeHash,
  }) : jsonAttribute = Value(jsonAttribute),
       attributeHash = Value(attributeHash);
  static Insertable<ProfileAttributesConfigAttribute> custom({
    Expression<int>? id,
    Expression<String>? jsonAttribute,
    Expression<String>? attributeHash,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (jsonAttribute != null) 'json_attribute': jsonAttribute,
      if (attributeHash != null) 'attribute_hash': attributeHash,
    });
  }

  ProfileAttributesConfigAttributesCompanion copyWith({
    Value<int>? id,
    Value<JsonObject<Attribute>>? jsonAttribute,
    Value<AttributeHash>? attributeHash,
  }) {
    return ProfileAttributesConfigAttributesCompanion(
      id: id ?? this.id,
      jsonAttribute: jsonAttribute ?? this.jsonAttribute,
      attributeHash: attributeHash ?? this.attributeHash,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
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
          ..write('id: $id, ')
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

class $ClientIdTable extends schema.ClientId
    with TableInfo<$ClientIdTable, ClientIdData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClientIdTable(this.attachedDatabase, [this._alias]);
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
  late final GeneratedColumnWithTypeConverter<ClientId?, int> clientId =
      GeneratedColumn<int>(
        'client_id',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      ).withConverter<ClientId?>($ClientIdTable.$converterclientId);
  @override
  List<GeneratedColumn> get $columns => [id, clientId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'client_id';
  @override
  VerificationContext validateIntegrity(
    Insertable<ClientIdData> instance, {
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
  ClientIdData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ClientIdData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      clientId: $ClientIdTable.$converterclientId.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}client_id'],
        ),
      ),
    );
  }

  @override
  $ClientIdTable createAlias(String alias) {
    return $ClientIdTable(attachedDatabase, alias);
  }

  static TypeConverter<ClientId?, int?> $converterclientId =
      const NullAwareTypeConverter.wrap(ClientIdConverter());
}

class ClientIdData extends DataClass implements Insertable<ClientIdData> {
  final int id;
  final ClientId? clientId;
  const ClientIdData({required this.id, this.clientId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || clientId != null) {
      map['client_id'] = Variable<int>(
        $ClientIdTable.$converterclientId.toSql(clientId),
      );
    }
    return map;
  }

  ClientIdCompanion toCompanion(bool nullToAbsent) {
    return ClientIdCompanion(
      id: Value(id),
      clientId: clientId == null && nullToAbsent
          ? const Value.absent()
          : Value(clientId),
    );
  }

  factory ClientIdData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ClientIdData(
      id: serializer.fromJson<int>(json['id']),
      clientId: serializer.fromJson<ClientId?>(json['clientId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'clientId': serializer.toJson<ClientId?>(clientId),
    };
  }

  ClientIdData copyWith({
    int? id,
    Value<ClientId?> clientId = const Value.absent(),
  }) => ClientIdData(
    id: id ?? this.id,
    clientId: clientId.present ? clientId.value : this.clientId,
  );
  ClientIdData copyWithCompanion(ClientIdCompanion data) {
    return ClientIdData(
      id: data.id.present ? data.id.value : this.id,
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ClientIdData(')
          ..write('id: $id, ')
          ..write('clientId: $clientId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, clientId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ClientIdData &&
          other.id == this.id &&
          other.clientId == this.clientId);
}

class ClientIdCompanion extends UpdateCompanion<ClientIdData> {
  final Value<int> id;
  final Value<ClientId?> clientId;
  const ClientIdCompanion({
    this.id = const Value.absent(),
    this.clientId = const Value.absent(),
  });
  ClientIdCompanion.insert({
    this.id = const Value.absent(),
    this.clientId = const Value.absent(),
  });
  static Insertable<ClientIdData> custom({
    Expression<int>? id,
    Expression<int>? clientId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (clientId != null) 'client_id': clientId,
    });
  }

  ClientIdCompanion copyWith({Value<int>? id, Value<ClientId?>? clientId}) {
    return ClientIdCompanion(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (clientId.present) {
      map['client_id'] = Variable<int>(
        $ClientIdTable.$converterclientId.toSql(clientId.value),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClientIdCompanion(')
          ..write('id: $id, ')
          ..write('clientId: $clientId')
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
        ProfileTextModerationRejectedReasonDetailsConverter(),
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
  List<GeneratedColumn> get $columns => [
    id,
    privateKeyData,
    publicKeyData,
    publicKeyId,
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
}

class MyKeyPairData extends DataClass implements Insertable<MyKeyPairData> {
  final int id;
  final PrivateKeyBytes? privateKeyData;
  final PublicKeyBytes? publicKeyData;
  final PublicKeyId? publicKeyId;
  const MyKeyPairData({
    required this.id,
    this.privateKeyData,
    this.publicKeyData,
    this.publicKeyId,
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
    };
  }

  MyKeyPairData copyWith({
    int? id,
    Value<PrivateKeyBytes?> privateKeyData = const Value.absent(),
    Value<PublicKeyBytes?> publicKeyData = const Value.absent(),
    Value<PublicKeyId?> publicKeyId = const Value.absent(),
  }) => MyKeyPairData(
    id: id ?? this.id,
    privateKeyData: privateKeyData.present
        ? privateKeyData.value
        : this.privateKeyData,
    publicKeyData: publicKeyData.present
        ? publicKeyData.value
        : this.publicKeyData,
    publicKeyId: publicKeyId.present ? publicKeyId.value : this.publicKeyId,
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
    );
  }

  @override
  String toString() {
    return (StringBuffer('MyKeyPairData(')
          ..write('id: $id, ')
          ..write('privateKeyData: $privateKeyData, ')
          ..write('publicKeyData: $publicKeyData, ')
          ..write('publicKeyId: $publicKeyId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, privateKeyData, publicKeyData, publicKeyId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MyKeyPairData &&
          other.id == this.id &&
          other.privateKeyData == this.privateKeyData &&
          other.publicKeyData == this.publicKeyData &&
          other.publicKeyId == this.publicKeyId);
}

class MyKeyPairCompanion extends UpdateCompanion<MyKeyPairData> {
  final Value<int> id;
  final Value<PrivateKeyBytes?> privateKeyData;
  final Value<PublicKeyBytes?> publicKeyData;
  final Value<PublicKeyId?> publicKeyId;
  const MyKeyPairCompanion({
    this.id = const Value.absent(),
    this.privateKeyData = const Value.absent(),
    this.publicKeyData = const Value.absent(),
    this.publicKeyId = const Value.absent(),
  });
  MyKeyPairCompanion.insert({
    this.id = const Value.absent(),
    this.privateKeyData = const Value.absent(),
    this.publicKeyData = const Value.absent(),
    this.publicKeyId = const Value.absent(),
  });
  static Insertable<MyKeyPairData> custom({
    Expression<int>? id,
    Expression<Uint8List>? privateKeyData,
    Expression<Uint8List>? publicKeyData,
    Expression<int>? publicKeyId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (privateKeyData != null) 'private_key_data': privateKeyData,
      if (publicKeyData != null) 'public_key_data': publicKeyData,
      if (publicKeyId != null) 'public_key_id': publicKeyId,
    });
  }

  MyKeyPairCompanion copyWith({
    Value<int>? id,
    Value<PrivateKeyBytes?>? privateKeyData,
    Value<PublicKeyBytes?>? publicKeyData,
    Value<PublicKeyId?>? publicKeyId,
  }) {
    return MyKeyPairCompanion(
      id: id ?? this.id,
      privateKeyData: privateKeyData ?? this.privateKeyData,
      publicKeyData: publicKeyData ?? this.publicKeyData,
      publicKeyId: publicKeyId ?? this.publicKeyId,
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MyKeyPairCompanion(')
          ..write('id: $id, ')
          ..write('privateKeyData: $privateKeyData, ')
          ..write('publicKeyData: $publicKeyData, ')
          ..write('publicKeyId: $publicKeyId')
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
  isInConversationList =
      GeneratedColumn<int>(
        'is_in_conversation_list',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      ).withConverter<UtcDateTime?>(
        $ConversationListTable.$converterisInConversationList,
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
    isInConversationList,
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
      isInConversationList: $ConversationListTable
          .$converterisInConversationList
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.int,
              data['${effectivePrefix}is_in_conversation_list'],
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
  static TypeConverter<UtcDateTime?, int?> $converterisInConversationList =
      const NullAwareTypeConverter.wrap(UtcDateTimeConverter());
  static TypeConverter<UtcDateTime?, int?> $converterisInSentBlocks =
      const NullAwareTypeConverter.wrap(UtcDateTimeConverter());
}

class ConversationListData extends DataClass
    implements Insertable<ConversationListData> {
  final AccountId accountId;
  final UtcDateTime? conversationLastChangedTime;
  final UtcDateTime? isInConversationList;
  final UtcDateTime? isInSentBlocks;
  const ConversationListData({
    required this.accountId,
    this.conversationLastChangedTime,
    this.isInConversationList,
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
    if (!nullToAbsent || isInConversationList != null) {
      map['is_in_conversation_list'] = Variable<int>(
        $ConversationListTable.$converterisInConversationList.toSql(
          isInConversationList,
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
      isInConversationList: isInConversationList == null && nullToAbsent
          ? const Value.absent()
          : Value(isInConversationList),
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
      isInConversationList: serializer.fromJson<UtcDateTime?>(
        json['isInConversationList'],
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
      'isInConversationList': serializer.toJson<UtcDateTime?>(
        isInConversationList,
      ),
      'isInSentBlocks': serializer.toJson<UtcDateTime?>(isInSentBlocks),
    };
  }

  ConversationListData copyWith({
    AccountId? accountId,
    Value<UtcDateTime?> conversationLastChangedTime = const Value.absent(),
    Value<UtcDateTime?> isInConversationList = const Value.absent(),
    Value<UtcDateTime?> isInSentBlocks = const Value.absent(),
  }) => ConversationListData(
    accountId: accountId ?? this.accountId,
    conversationLastChangedTime: conversationLastChangedTime.present
        ? conversationLastChangedTime.value
        : this.conversationLastChangedTime,
    isInConversationList: isInConversationList.present
        ? isInConversationList.value
        : this.isInConversationList,
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
      isInConversationList: data.isInConversationList.present
          ? data.isInConversationList.value
          : this.isInConversationList,
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
          ..write('isInConversationList: $isInConversationList, ')
          ..write('isInSentBlocks: $isInSentBlocks')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    accountId,
    conversationLastChangedTime,
    isInConversationList,
    isInSentBlocks,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ConversationListData &&
          other.accountId == this.accountId &&
          other.conversationLastChangedTime ==
              this.conversationLastChangedTime &&
          other.isInConversationList == this.isInConversationList &&
          other.isInSentBlocks == this.isInSentBlocks);
}

class ConversationListCompanion extends UpdateCompanion<ConversationListData> {
  final Value<AccountId> accountId;
  final Value<UtcDateTime?> conversationLastChangedTime;
  final Value<UtcDateTime?> isInConversationList;
  final Value<UtcDateTime?> isInSentBlocks;
  final Value<int> rowid;
  const ConversationListCompanion({
    this.accountId = const Value.absent(),
    this.conversationLastChangedTime = const Value.absent(),
    this.isInConversationList = const Value.absent(),
    this.isInSentBlocks = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ConversationListCompanion.insert({
    required AccountId accountId,
    this.conversationLastChangedTime = const Value.absent(),
    this.isInConversationList = const Value.absent(),
    this.isInSentBlocks = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : accountId = Value(accountId);
  static Insertable<ConversationListData> custom({
    Expression<String>? accountId,
    Expression<int>? conversationLastChangedTime,
    Expression<int>? isInConversationList,
    Expression<int>? isInSentBlocks,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (accountId != null) 'account_id': accountId,
      if (conversationLastChangedTime != null)
        'conversation_last_changed_time': conversationLastChangedTime,
      if (isInConversationList != null)
        'is_in_conversation_list': isInConversationList,
      if (isInSentBlocks != null) 'is_in_sent_blocks': isInSentBlocks,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ConversationListCompanion copyWith({
    Value<AccountId>? accountId,
    Value<UtcDateTime?>? conversationLastChangedTime,
    Value<UtcDateTime?>? isInConversationList,
    Value<UtcDateTime?>? isInSentBlocks,
    Value<int>? rowid,
  }) {
    return ConversationListCompanion(
      accountId: accountId ?? this.accountId,
      conversationLastChangedTime:
          conversationLastChangedTime ?? this.conversationLastChangedTime,
      isInConversationList: isInConversationList ?? this.isInConversationList,
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
    if (isInConversationList.present) {
      map['is_in_conversation_list'] = Variable<int>(
        $ConversationListTable.$converterisInConversationList.toSql(
          isInConversationList.value,
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
          ..write('isInConversationList: $isInConversationList, ')
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

class $MessageTable extends schema.Message
    with TableInfo<$MessageTable, MessageData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MessageTable(this.attachedDatabase, [this._alias]);
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
  late final GeneratedColumnWithTypeConverter<AccountId, String>
  localAccountId = GeneratedColumn<String>(
    'local_account_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<AccountId>($MessageTable.$converterlocalAccountId);
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
  late final GeneratedColumnWithTypeConverter<MessageId?, int> messageId =
      GeneratedColumn<int>(
        'message_id',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      ).withConverter<MessageId?>($MessageTable.$convertermessageId);
  @override
  late final GeneratedColumnWithTypeConverter<UtcDateTime?, int> unixTime =
      GeneratedColumn<int>(
        'unix_time',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      ).withConverter<UtcDateTime?>($MessageTable.$converterunixTime);
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
  List<GeneratedColumn> get $columns => [
    id,
    localAccountId,
    remoteAccountId,
    message,
    localUnixTime,
    messageState,
    symmetricMessageEncryptionKey,
    messageId,
    unixTime,
    backendSignedPgpMessage,
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
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
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
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MessageData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MessageData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      localAccountId: $MessageTable.$converterlocalAccountId.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}local_account_id'],
        )!,
      ),
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
      messageId: $MessageTable.$convertermessageId.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}message_id'],
        ),
      ),
      unixTime: $MessageTable.$converterunixTime.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}unix_time'],
        ),
      ),
      backendSignedPgpMessage: attachedDatabase.typeMapping.read(
        DriftSqlType.blob,
        data['${effectivePrefix}backend_signed_pgp_message'],
      ),
    );
  }

  @override
  $MessageTable createAlias(String alias) {
    return $MessageTable(attachedDatabase, alias);
  }

  static TypeConverter<AccountId, String> $converterlocalAccountId =
      const AccountIdConverter();
  static TypeConverter<AccountId, String> $converterremoteAccountId =
      const AccountIdConverter();
  static TypeConverter<Message?, Uint8List?> $convertermessage =
      const NullAwareTypeConverter.wrap(MessageConverter());
  static TypeConverter<UtcDateTime, int> $converterlocalUnixTime =
      const UtcDateTimeConverter();
  static TypeConverter<MessageId?, int?> $convertermessageId =
      const NullAwareTypeConverter.wrap(MessageIdConverter());
  static TypeConverter<UtcDateTime?, int?> $converterunixTime =
      const NullAwareTypeConverter.wrap(UtcDateTimeConverter());
}

class MessageData extends DataClass implements Insertable<MessageData> {
  /// Local message ID
  final int id;
  final AccountId localAccountId;
  final AccountId remoteAccountId;
  final Message? message;
  final UtcDateTime localUnixTime;
  final int messageState;
  final Uint8List? symmetricMessageEncryptionKey;
  final MessageId? messageId;
  final UtcDateTime? unixTime;
  final Uint8List? backendSignedPgpMessage;
  const MessageData({
    required this.id,
    required this.localAccountId,
    required this.remoteAccountId,
    this.message,
    required this.localUnixTime,
    required this.messageState,
    this.symmetricMessageEncryptionKey,
    this.messageId,
    this.unixTime,
    this.backendSignedPgpMessage,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['local_account_id'] = Variable<String>(
        $MessageTable.$converterlocalAccountId.toSql(localAccountId),
      );
    }
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
    if (!nullToAbsent || messageId != null) {
      map['message_id'] = Variable<int>(
        $MessageTable.$convertermessageId.toSql(messageId),
      );
    }
    if (!nullToAbsent || unixTime != null) {
      map['unix_time'] = Variable<int>(
        $MessageTable.$converterunixTime.toSql(unixTime),
      );
    }
    if (!nullToAbsent || backendSignedPgpMessage != null) {
      map['backend_signed_pgp_message'] = Variable<Uint8List>(
        backendSignedPgpMessage,
      );
    }
    return map;
  }

  MessageCompanion toCompanion(bool nullToAbsent) {
    return MessageCompanion(
      id: Value(id),
      localAccountId: Value(localAccountId),
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
      messageId: messageId == null && nullToAbsent
          ? const Value.absent()
          : Value(messageId),
      unixTime: unixTime == null && nullToAbsent
          ? const Value.absent()
          : Value(unixTime),
      backendSignedPgpMessage: backendSignedPgpMessage == null && nullToAbsent
          ? const Value.absent()
          : Value(backendSignedPgpMessage),
    );
  }

  factory MessageData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MessageData(
      id: serializer.fromJson<int>(json['id']),
      localAccountId: serializer.fromJson<AccountId>(json['localAccountId']),
      remoteAccountId: serializer.fromJson<AccountId>(json['remoteAccountId']),
      message: serializer.fromJson<Message?>(json['message']),
      localUnixTime: serializer.fromJson<UtcDateTime>(json['localUnixTime']),
      messageState: serializer.fromJson<int>(json['messageState']),
      symmetricMessageEncryptionKey: serializer.fromJson<Uint8List?>(
        json['symmetricMessageEncryptionKey'],
      ),
      messageId: serializer.fromJson<MessageId?>(json['messageId']),
      unixTime: serializer.fromJson<UtcDateTime?>(json['unixTime']),
      backendSignedPgpMessage: serializer.fromJson<Uint8List?>(
        json['backendSignedPgpMessage'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'localAccountId': serializer.toJson<AccountId>(localAccountId),
      'remoteAccountId': serializer.toJson<AccountId>(remoteAccountId),
      'message': serializer.toJson<Message?>(message),
      'localUnixTime': serializer.toJson<UtcDateTime>(localUnixTime),
      'messageState': serializer.toJson<int>(messageState),
      'symmetricMessageEncryptionKey': serializer.toJson<Uint8List?>(
        symmetricMessageEncryptionKey,
      ),
      'messageId': serializer.toJson<MessageId?>(messageId),
      'unixTime': serializer.toJson<UtcDateTime?>(unixTime),
      'backendSignedPgpMessage': serializer.toJson<Uint8List?>(
        backendSignedPgpMessage,
      ),
    };
  }

  MessageData copyWith({
    int? id,
    AccountId? localAccountId,
    AccountId? remoteAccountId,
    Value<Message?> message = const Value.absent(),
    UtcDateTime? localUnixTime,
    int? messageState,
    Value<Uint8List?> symmetricMessageEncryptionKey = const Value.absent(),
    Value<MessageId?> messageId = const Value.absent(),
    Value<UtcDateTime?> unixTime = const Value.absent(),
    Value<Uint8List?> backendSignedPgpMessage = const Value.absent(),
  }) => MessageData(
    id: id ?? this.id,
    localAccountId: localAccountId ?? this.localAccountId,
    remoteAccountId: remoteAccountId ?? this.remoteAccountId,
    message: message.present ? message.value : this.message,
    localUnixTime: localUnixTime ?? this.localUnixTime,
    messageState: messageState ?? this.messageState,
    symmetricMessageEncryptionKey: symmetricMessageEncryptionKey.present
        ? symmetricMessageEncryptionKey.value
        : this.symmetricMessageEncryptionKey,
    messageId: messageId.present ? messageId.value : this.messageId,
    unixTime: unixTime.present ? unixTime.value : this.unixTime,
    backendSignedPgpMessage: backendSignedPgpMessage.present
        ? backendSignedPgpMessage.value
        : this.backendSignedPgpMessage,
  );
  MessageData copyWithCompanion(MessageCompanion data) {
    return MessageData(
      id: data.id.present ? data.id.value : this.id,
      localAccountId: data.localAccountId.present
          ? data.localAccountId.value
          : this.localAccountId,
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
      messageId: data.messageId.present ? data.messageId.value : this.messageId,
      unixTime: data.unixTime.present ? data.unixTime.value : this.unixTime,
      backendSignedPgpMessage: data.backendSignedPgpMessage.present
          ? data.backendSignedPgpMessage.value
          : this.backendSignedPgpMessage,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MessageData(')
          ..write('id: $id, ')
          ..write('localAccountId: $localAccountId, ')
          ..write('remoteAccountId: $remoteAccountId, ')
          ..write('message: $message, ')
          ..write('localUnixTime: $localUnixTime, ')
          ..write('messageState: $messageState, ')
          ..write(
            'symmetricMessageEncryptionKey: $symmetricMessageEncryptionKey, ',
          )
          ..write('messageId: $messageId, ')
          ..write('unixTime: $unixTime, ')
          ..write('backendSignedPgpMessage: $backendSignedPgpMessage')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    localAccountId,
    remoteAccountId,
    message,
    localUnixTime,
    messageState,
    $driftBlobEquality.hash(symmetricMessageEncryptionKey),
    messageId,
    unixTime,
    $driftBlobEquality.hash(backendSignedPgpMessage),
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MessageData &&
          other.id == this.id &&
          other.localAccountId == this.localAccountId &&
          other.remoteAccountId == this.remoteAccountId &&
          other.message == this.message &&
          other.localUnixTime == this.localUnixTime &&
          other.messageState == this.messageState &&
          $driftBlobEquality.equals(
            other.symmetricMessageEncryptionKey,
            this.symmetricMessageEncryptionKey,
          ) &&
          other.messageId == this.messageId &&
          other.unixTime == this.unixTime &&
          $driftBlobEquality.equals(
            other.backendSignedPgpMessage,
            this.backendSignedPgpMessage,
          ));
}

class MessageCompanion extends UpdateCompanion<MessageData> {
  final Value<int> id;
  final Value<AccountId> localAccountId;
  final Value<AccountId> remoteAccountId;
  final Value<Message?> message;
  final Value<UtcDateTime> localUnixTime;
  final Value<int> messageState;
  final Value<Uint8List?> symmetricMessageEncryptionKey;
  final Value<MessageId?> messageId;
  final Value<UtcDateTime?> unixTime;
  final Value<Uint8List?> backendSignedPgpMessage;
  const MessageCompanion({
    this.id = const Value.absent(),
    this.localAccountId = const Value.absent(),
    this.remoteAccountId = const Value.absent(),
    this.message = const Value.absent(),
    this.localUnixTime = const Value.absent(),
    this.messageState = const Value.absent(),
    this.symmetricMessageEncryptionKey = const Value.absent(),
    this.messageId = const Value.absent(),
    this.unixTime = const Value.absent(),
    this.backendSignedPgpMessage = const Value.absent(),
  });
  MessageCompanion.insert({
    this.id = const Value.absent(),
    required AccountId localAccountId,
    required AccountId remoteAccountId,
    this.message = const Value.absent(),
    required UtcDateTime localUnixTime,
    required int messageState,
    this.symmetricMessageEncryptionKey = const Value.absent(),
    this.messageId = const Value.absent(),
    this.unixTime = const Value.absent(),
    this.backendSignedPgpMessage = const Value.absent(),
  }) : localAccountId = Value(localAccountId),
       remoteAccountId = Value(remoteAccountId),
       localUnixTime = Value(localUnixTime),
       messageState = Value(messageState);
  static Insertable<MessageData> custom({
    Expression<int>? id,
    Expression<String>? localAccountId,
    Expression<String>? remoteAccountId,
    Expression<Uint8List>? message,
    Expression<int>? localUnixTime,
    Expression<int>? messageState,
    Expression<Uint8List>? symmetricMessageEncryptionKey,
    Expression<int>? messageId,
    Expression<int>? unixTime,
    Expression<Uint8List>? backendSignedPgpMessage,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (localAccountId != null) 'local_account_id': localAccountId,
      if (remoteAccountId != null) 'remote_account_id': remoteAccountId,
      if (message != null) 'message': message,
      if (localUnixTime != null) 'local_unix_time': localUnixTime,
      if (messageState != null) 'message_state': messageState,
      if (symmetricMessageEncryptionKey != null)
        'symmetric_message_encryption_key': symmetricMessageEncryptionKey,
      if (messageId != null) 'message_id': messageId,
      if (unixTime != null) 'unix_time': unixTime,
      if (backendSignedPgpMessage != null)
        'backend_signed_pgp_message': backendSignedPgpMessage,
    });
  }

  MessageCompanion copyWith({
    Value<int>? id,
    Value<AccountId>? localAccountId,
    Value<AccountId>? remoteAccountId,
    Value<Message?>? message,
    Value<UtcDateTime>? localUnixTime,
    Value<int>? messageState,
    Value<Uint8List?>? symmetricMessageEncryptionKey,
    Value<MessageId?>? messageId,
    Value<UtcDateTime?>? unixTime,
    Value<Uint8List?>? backendSignedPgpMessage,
  }) {
    return MessageCompanion(
      id: id ?? this.id,
      localAccountId: localAccountId ?? this.localAccountId,
      remoteAccountId: remoteAccountId ?? this.remoteAccountId,
      message: message ?? this.message,
      localUnixTime: localUnixTime ?? this.localUnixTime,
      messageState: messageState ?? this.messageState,
      symmetricMessageEncryptionKey:
          symmetricMessageEncryptionKey ?? this.symmetricMessageEncryptionKey,
      messageId: messageId ?? this.messageId,
      unixTime: unixTime ?? this.unixTime,
      backendSignedPgpMessage:
          backendSignedPgpMessage ?? this.backendSignedPgpMessage,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (localAccountId.present) {
      map['local_account_id'] = Variable<String>(
        $MessageTable.$converterlocalAccountId.toSql(localAccountId.value),
      );
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
    if (messageId.present) {
      map['message_id'] = Variable<int>(
        $MessageTable.$convertermessageId.toSql(messageId.value),
      );
    }
    if (unixTime.present) {
      map['unix_time'] = Variable<int>(
        $MessageTable.$converterunixTime.toSql(unixTime.value),
      );
    }
    if (backendSignedPgpMessage.present) {
      map['backend_signed_pgp_message'] = Variable<Uint8List>(
        backendSignedPgpMessage.value,
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MessageCompanion(')
          ..write('id: $id, ')
          ..write('localAccountId: $localAccountId, ')
          ..write('remoteAccountId: $remoteAccountId, ')
          ..write('message: $message, ')
          ..write('localUnixTime: $localUnixTime, ')
          ..write('messageState: $messageState, ')
          ..write(
            'symmetricMessageEncryptionKey: $symmetricMessageEncryptionKey, ',
          )
          ..write('messageId: $messageId, ')
          ..write('unixTime: $unixTime, ')
          ..write('backendSignedPgpMessage: $backendSignedPgpMessage')
          ..write(')'))
        .toString();
  }
}

abstract class _$AccountForegroundDatabase extends GeneratedDatabase {
  _$AccountForegroundDatabase(QueryExecutor e) : super(e);
  late final $ProfileFilterFavoritesTable profileFilterFavorites =
      $ProfileFilterFavoritesTable(this);
  late final $ShowAdvancedProfileFiltersTable showAdvancedProfileFilters =
      $ShowAdvancedProfileFiltersTable(this);
  late final $InitialSyncTable initialSync = $InitialSyncTable(this);
  late final $InitialSetupSkippedTable initialSetupSkipped =
      $InitialSetupSkippedTable(this);
  late final $GridSettingsTable gridSettings = $GridSettingsTable(this);
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
  late final $LocalAccountIdTable localAccountId = $LocalAccountIdTable(this);
  late final $AccountStateTable accountState = $AccountStateTable(this);
  late final $PermissionsTable permissions = $PermissionsTable(this);
  late final $ProfileVisibilityTable profileVisibility =
      $ProfileVisibilityTable(this);
  late final $EmailAddressTable emailAddress = $EmailAddressTable(this);
  late final $AccountIdTable accountId = $AccountIdTable(this);
  late final $ClientIdTable clientId = $ClientIdTable(this);
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
  late final $MyKeyPairTable myKeyPair = $MyKeyPairTable(this);
  late final $PublicKeyTable publicKey = $PublicKeyTable(this);
  late final $ConversationListTable conversationList = $ConversationListTable(
    this,
  );
  late final $DailyLikesLeftTable dailyLikesLeft = $DailyLikesLeftTable(this);
  late final $MessageTable message = $MessageTable(this);
  late final DaoReadApp daoReadApp = DaoReadApp(
    this as AccountForegroundDatabase,
  );
  late final DaoReadCommon daoReadCommon = DaoReadCommon(
    this as AccountForegroundDatabase,
  );
  late final DaoReadConfig daoReadConfig = DaoReadConfig(
    this as AccountForegroundDatabase,
  );
  late final DaoReadAccount daoReadAccount = DaoReadAccount(
    this as AccountForegroundDatabase,
  );
  late final DaoReadLoginSession daoReadLoginSession = DaoReadLoginSession(
    this as AccountForegroundDatabase,
  );
  late final DaoReadMedia daoReadMedia = DaoReadMedia(
    this as AccountForegroundDatabase,
  );
  late final DaoReadMyMedia daoReadMyMedia = DaoReadMyMedia(
    this as AccountForegroundDatabase,
  );
  late final DaoReadProfile daoReadProfile = DaoReadProfile(
    this as AccountForegroundDatabase,
  );
  late final DaoReadMyProfile daoReadMyProfile = DaoReadMyProfile(
    this as AccountForegroundDatabase,
  );
  late final DaoReadSearch daoReadSearch = DaoReadSearch(
    this as AccountForegroundDatabase,
  );
  late final DaoReadConversationList daoReadConversationList =
      DaoReadConversationList(this as AccountForegroundDatabase);
  late final DaoReadKey daoReadKey = DaoReadKey(
    this as AccountForegroundDatabase,
  );
  late final DaoReadLike daoReadLike = DaoReadLike(
    this as AccountForegroundDatabase,
  );
  late final DaoReadMessage daoReadMessage = DaoReadMessage(
    this as AccountForegroundDatabase,
  );
  late final DaoWriteApp daoWriteApp = DaoWriteApp(
    this as AccountForegroundDatabase,
  );
  late final DaoWriteCommon daoWriteCommon = DaoWriteCommon(
    this as AccountForegroundDatabase,
  );
  late final DaoWriteConfig daoWriteConfig = DaoWriteConfig(
    this as AccountForegroundDatabase,
  );
  late final DaoWriteAccount daoWriteAccount = DaoWriteAccount(
    this as AccountForegroundDatabase,
  );
  late final DaoWriteLoginSession daoWriteLoginSession = DaoWriteLoginSession(
    this as AccountForegroundDatabase,
  );
  late final DaoWriteMedia daoWriteMedia = DaoWriteMedia(
    this as AccountForegroundDatabase,
  );
  late final DaoWriteMyMedia daoWriteMyMedia = DaoWriteMyMedia(
    this as AccountForegroundDatabase,
  );
  late final DaoWriteProfile daoWriteProfile = DaoWriteProfile(
    this as AccountForegroundDatabase,
  );
  late final DaoWriteMyProfile daoWriteMyProfile = DaoWriteMyProfile(
    this as AccountForegroundDatabase,
  );
  late final DaoWriteSearch daoWriteSearch = DaoWriteSearch(
    this as AccountForegroundDatabase,
  );
  late final DaoWriteConversationList daoWriteConversationList =
      DaoWriteConversationList(this as AccountForegroundDatabase);
  late final DaoWriteKey daoWriteKey = DaoWriteKey(
    this as AccountForegroundDatabase,
  );
  late final DaoWriteLike daoWriteLike = DaoWriteLike(
    this as AccountForegroundDatabase,
  );
  late final DaoWriteMessage daoWriteMessage = DaoWriteMessage(
    this as AccountForegroundDatabase,
  );
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
    serverMaintenance,
    syncVersion,
    receivedLikesIteratorState,
    clientFeaturesConfig,
    customReportsConfig,
    profileAttributesConfig,
    profileAttributesConfigAttributes,
    clientLanguageOnServer,
    localAccountId,
    accountState,
    permissions,
    profileVisibility,
    emailAddress,
    accountId,
    clientId,
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
    myKeyPair,
    publicKey,
    conversationList,
    dailyLikesLeft,
    message,
  ];
}
