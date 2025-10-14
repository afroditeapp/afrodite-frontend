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
  List<GeneratedColumn> get $columns => [
    accountId,
    profileName,
    profileNameAccepted,
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
      profileName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_name'],
      ),
      profileNameAccepted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}profile_name_accepted'],
      ),
    );
  }

  @override
  $ProfileTable createAlias(String alias) {
    return $ProfileTable(attachedDatabase, alias);
  }

  static TypeConverter<AccountId, String> $converteraccountId =
      const AccountIdConverter();
}

class ProfileData extends DataClass implements Insertable<ProfileData> {
  final AccountId accountId;
  final String? profileName;
  final bool? profileNameAccepted;
  const ProfileData({
    required this.accountId,
    this.profileName,
    this.profileNameAccepted,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    {
      map['account_id'] = Variable<String>(
        $ProfileTable.$converteraccountId.toSql(accountId),
      );
    }
    if (!nullToAbsent || profileName != null) {
      map['profile_name'] = Variable<String>(profileName);
    }
    if (!nullToAbsent || profileNameAccepted != null) {
      map['profile_name_accepted'] = Variable<bool>(profileNameAccepted);
    }
    return map;
  }

  ProfileCompanion toCompanion(bool nullToAbsent) {
    return ProfileCompanion(
      accountId: Value(accountId),
      profileName: profileName == null && nullToAbsent
          ? const Value.absent()
          : Value(profileName),
      profileNameAccepted: profileNameAccepted == null && nullToAbsent
          ? const Value.absent()
          : Value(profileNameAccepted),
    );
  }

  factory ProfileData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProfileData(
      accountId: serializer.fromJson<AccountId>(json['accountId']),
      profileName: serializer.fromJson<String?>(json['profileName']),
      profileNameAccepted: serializer.fromJson<bool?>(
        json['profileNameAccepted'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'accountId': serializer.toJson<AccountId>(accountId),
      'profileName': serializer.toJson<String?>(profileName),
      'profileNameAccepted': serializer.toJson<bool?>(profileNameAccepted),
    };
  }

  ProfileData copyWith({
    AccountId? accountId,
    Value<String?> profileName = const Value.absent(),
    Value<bool?> profileNameAccepted = const Value.absent(),
  }) => ProfileData(
    accountId: accountId ?? this.accountId,
    profileName: profileName.present ? profileName.value : this.profileName,
    profileNameAccepted: profileNameAccepted.present
        ? profileNameAccepted.value
        : this.profileNameAccepted,
  );
  ProfileData copyWithCompanion(ProfileCompanion data) {
    return ProfileData(
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      profileName: data.profileName.present
          ? data.profileName.value
          : this.profileName,
      profileNameAccepted: data.profileNameAccepted.present
          ? data.profileNameAccepted.value
          : this.profileNameAccepted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProfileData(')
          ..write('accountId: $accountId, ')
          ..write('profileName: $profileName, ')
          ..write('profileNameAccepted: $profileNameAccepted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(accountId, profileName, profileNameAccepted);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProfileData &&
          other.accountId == this.accountId &&
          other.profileName == this.profileName &&
          other.profileNameAccepted == this.profileNameAccepted);
}

class ProfileCompanion extends UpdateCompanion<ProfileData> {
  final Value<AccountId> accountId;
  final Value<String?> profileName;
  final Value<bool?> profileNameAccepted;
  final Value<int> rowid;
  const ProfileCompanion({
    this.accountId = const Value.absent(),
    this.profileName = const Value.absent(),
    this.profileNameAccepted = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProfileCompanion.insert({
    required AccountId accountId,
    this.profileName = const Value.absent(),
    this.profileNameAccepted = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : accountId = Value(accountId);
  static Insertable<ProfileData> custom({
    Expression<String>? accountId,
    Expression<String>? profileName,
    Expression<bool>? profileNameAccepted,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (accountId != null) 'account_id': accountId,
      if (profileName != null) 'profile_name': profileName,
      if (profileNameAccepted != null)
        'profile_name_accepted': profileNameAccepted,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProfileCompanion copyWith({
    Value<AccountId>? accountId,
    Value<String?>? profileName,
    Value<bool?>? profileNameAccepted,
    Value<int>? rowid,
  }) {
    return ProfileCompanion(
      accountId: accountId ?? this.accountId,
      profileName: profileName ?? this.profileName,
      profileNameAccepted: profileNameAccepted ?? this.profileNameAccepted,
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
    if (profileName.present) {
      map['profile_name'] = Variable<String>(profileName.value);
    }
    if (profileNameAccepted.present) {
      map['profile_name_accepted'] = Variable<bool>(profileNameAccepted.value);
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
          ..write('profileName: $profileName, ')
          ..write('profileNameAccepted: $profileNameAccepted, ')
          ..write('rowid: $rowid')
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

abstract class _$AccountBackgroundDatabase extends GeneratedDatabase {
  _$AccountBackgroundDatabase(QueryExecutor e) : super(e);
  late final $AccountIdTable accountId = $AccountIdTable(this);
  late final $AdminNotificationTable adminNotification =
      $AdminNotificationTable(this);
  late final $AppNotificationSettingsTable appNotificationSettings =
      $AppNotificationSettingsTable(this);
  late final $NotificationStatusTable notificationStatus =
      $NotificationStatusTable(this);
  late final $UnreadMessagesCountTable unreadMessagesCount =
      $UnreadMessagesCountTable(this);
  late final $NewMessageNotificationTable newMessageNotification =
      $NewMessageNotificationTable(this);
  late final $NewReceivedLikesCountTable newReceivedLikesCount =
      $NewReceivedLikesCountTable(this);
  late final $NewsTable news = $NewsTable(this);
  late final $ProfileTable profile = $ProfileTable(this);
  late final $AutomaticProfileSearchBadgeStateTable
  automaticProfileSearchBadgeState = $AutomaticProfileSearchBadgeStateTable(
    this,
  );
  late final $PushNotificationTable pushNotification = $PushNotificationTable(
    this,
  );
  late final DaoReadAppNotificationSettings daoReadAppNotificationSettings =
      DaoReadAppNotificationSettings(this as AccountBackgroundDatabase);
  late final DaoReadLoginSession daoReadLoginSession = DaoReadLoginSession(
    this as AccountBackgroundDatabase,
  );
  late final DaoReadNotification daoReadNotification = DaoReadNotification(
    this as AccountBackgroundDatabase,
  );
  late final DaoReadNews daoReadNews = DaoReadNews(
    this as AccountBackgroundDatabase,
  );
  late final DaoReadNewReceivedLikesCount daoReadNewReceivedLikesCount =
      DaoReadNewReceivedLikesCount(this as AccountBackgroundDatabase);
  late final DaoReadUnreadMessagesCount daoReadUnreadMessagesCount =
      DaoReadUnreadMessagesCount(this as AccountBackgroundDatabase);
  late final DaoReadProfile daoReadProfile = DaoReadProfile(
    this as AccountBackgroundDatabase,
  );
  late final DaoWriteAppNotificationSettings daoWriteAppNotificationSettings =
      DaoWriteAppNotificationSettings(this as AccountBackgroundDatabase);
  late final DaoWriteLoginSession daoWriteLoginSession = DaoWriteLoginSession(
    this as AccountBackgroundDatabase,
  );
  late final DaoWriteNotification daoWriteNotification = DaoWriteNotification(
    this as AccountBackgroundDatabase,
  );
  late final DaoWriteNews daoWriteNews = DaoWriteNews(
    this as AccountBackgroundDatabase,
  );
  late final DaoWriteNewReceivedLikesCount daoWriteNewReceivedLikesCount =
      DaoWriteNewReceivedLikesCount(this as AccountBackgroundDatabase);
  late final DaoWriteUnreadMessagesCount daoWriteUnreadMessagesCount =
      DaoWriteUnreadMessagesCount(this as AccountBackgroundDatabase);
  late final DaoWriteProfile daoWriteProfile = DaoWriteProfile(
    this as AccountBackgroundDatabase,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    accountId,
    adminNotification,
    appNotificationSettings,
    notificationStatus,
    unreadMessagesCount,
    newMessageNotification,
    newReceivedLikesCount,
    news,
    profile,
    automaticProfileSearchBadgeState,
    pushNotification,
  ];
}
