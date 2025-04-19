// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_database.dart';

// ignore_for_file: type=lint
class $AccountBackgroundTable extends AccountBackground
    with TableInfo<$AccountBackgroundTable, AccountBackgroundData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AccountBackgroundTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  @override
  late final GeneratedColumnWithTypeConverter<AccountId?, String>
      uuidAccountId = GeneratedColumn<String>(
              'uuid_account_id', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<AccountId?>(
              $AccountBackgroundTable.$converteruuidAccountId);
  static const VerificationMeta _localNotificationSettingMessagesMeta =
      const VerificationMeta('localNotificationSettingMessages');
  @override
  late final GeneratedColumn<bool> localNotificationSettingMessages =
      GeneratedColumn<bool>(
          'local_notification_setting_messages', aliasedName, true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("local_notification_setting_messages" IN (0, 1))'));
  static const VerificationMeta _localNotificationSettingLikesMeta =
      const VerificationMeta('localNotificationSettingLikes');
  @override
  late final GeneratedColumn<bool> localNotificationSettingLikes =
      GeneratedColumn<bool>(
          'local_notification_setting_likes', aliasedName, true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("local_notification_setting_likes" IN (0, 1))'));
  static const VerificationMeta
      _localNotificationSettingMediaContentModerationCompletedMeta =
      const VerificationMeta(
          'localNotificationSettingMediaContentModerationCompleted');
  @override
  late final GeneratedColumn<bool>
      localNotificationSettingMediaContentModerationCompleted =
      GeneratedColumn<bool>(
          'local_notification_setting_media_content_moderation_completed',
          aliasedName,
          true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("local_notification_setting_media_content_moderation_completed" IN (0, 1))'));
  static const VerificationMeta
      _localNotificationSettingProfileTextModerationCompletedMeta =
      const VerificationMeta(
          'localNotificationSettingProfileTextModerationCompleted');
  @override
  late final GeneratedColumn<bool>
      localNotificationSettingProfileTextModerationCompleted =
      GeneratedColumn<bool>(
          'local_notification_setting_profile_text_moderation_completed',
          aliasedName,
          true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("local_notification_setting_profile_text_moderation_completed" IN (0, 1))'));
  static const VerificationMeta _localNotificationSettingNewsItemAvailableMeta =
      const VerificationMeta('localNotificationSettingNewsItemAvailable');
  @override
  late final GeneratedColumn<
      bool> localNotificationSettingNewsItemAvailable = GeneratedColumn<
          bool>(
      'local_notification_setting_news_item_available', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("local_notification_setting_news_item_available" IN (0, 1))'));
  static const VerificationMeta
      _userInterfaceSettingShowNonAcceptedProfileNamesMeta =
      const VerificationMeta('userInterfaceSettingShowNonAcceptedProfileNames');
  @override
  late final GeneratedColumn<
      bool> userInterfaceSettingShowNonAcceptedProfileNames = GeneratedColumn<
          bool>('user_interface_setting_show_non_accepted_profile_names',
      aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("user_interface_setting_show_non_accepted_profile_names" IN (0, 1))'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        uuidAccountId,
        localNotificationSettingMessages,
        localNotificationSettingLikes,
        localNotificationSettingMediaContentModerationCompleted,
        localNotificationSettingProfileTextModerationCompleted,
        localNotificationSettingNewsItemAvailable,
        userInterfaceSettingShowNonAcceptedProfileNames
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'account_background';
  @override
  VerificationContext validateIntegrity(
      Insertable<AccountBackgroundData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('local_notification_setting_messages')) {
      context.handle(
          _localNotificationSettingMessagesMeta,
          localNotificationSettingMessages.isAcceptableOrUnknown(
              data['local_notification_setting_messages']!,
              _localNotificationSettingMessagesMeta));
    }
    if (data.containsKey('local_notification_setting_likes')) {
      context.handle(
          _localNotificationSettingLikesMeta,
          localNotificationSettingLikes.isAcceptableOrUnknown(
              data['local_notification_setting_likes']!,
              _localNotificationSettingLikesMeta));
    }
    if (data.containsKey(
        'local_notification_setting_media_content_moderation_completed')) {
      context.handle(
          _localNotificationSettingMediaContentModerationCompletedMeta,
          localNotificationSettingMediaContentModerationCompleted
              .isAcceptableOrUnknown(
                  data[
                      'local_notification_setting_media_content_moderation_completed']!,
                  _localNotificationSettingMediaContentModerationCompletedMeta));
    }
    if (data.containsKey(
        'local_notification_setting_profile_text_moderation_completed')) {
      context.handle(
          _localNotificationSettingProfileTextModerationCompletedMeta,
          localNotificationSettingProfileTextModerationCompleted
              .isAcceptableOrUnknown(
                  data[
                      'local_notification_setting_profile_text_moderation_completed']!,
                  _localNotificationSettingProfileTextModerationCompletedMeta));
    }
    if (data.containsKey('local_notification_setting_news_item_available')) {
      context.handle(
          _localNotificationSettingNewsItemAvailableMeta,
          localNotificationSettingNewsItemAvailable.isAcceptableOrUnknown(
              data['local_notification_setting_news_item_available']!,
              _localNotificationSettingNewsItemAvailableMeta));
    }
    if (data.containsKey(
        'user_interface_setting_show_non_accepted_profile_names')) {
      context.handle(
          _userInterfaceSettingShowNonAcceptedProfileNamesMeta,
          userInterfaceSettingShowNonAcceptedProfileNames.isAcceptableOrUnknown(
              data['user_interface_setting_show_non_accepted_profile_names']!,
              _userInterfaceSettingShowNonAcceptedProfileNamesMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AccountBackgroundData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AccountBackgroundData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      uuidAccountId: $AccountBackgroundTable.$converteruuidAccountId.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}uuid_account_id'])),
      localNotificationSettingMessages: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}local_notification_setting_messages']),
      localNotificationSettingLikes: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}local_notification_setting_likes']),
      localNotificationSettingMediaContentModerationCompleted:
          attachedDatabase.typeMapping.read(
              DriftSqlType.bool,
              data[
                  '${effectivePrefix}local_notification_setting_media_content_moderation_completed']),
      localNotificationSettingProfileTextModerationCompleted:
          attachedDatabase.typeMapping.read(
              DriftSqlType.bool,
              data[
                  '${effectivePrefix}local_notification_setting_profile_text_moderation_completed']),
      localNotificationSettingNewsItemAvailable: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data[
              '${effectivePrefix}local_notification_setting_news_item_available']),
      userInterfaceSettingShowNonAcceptedProfileNames:
          attachedDatabase.typeMapping.read(
              DriftSqlType.bool,
              data[
                  '${effectivePrefix}user_interface_setting_show_non_accepted_profile_names']),
    );
  }

  @override
  $AccountBackgroundTable createAlias(String alias) {
    return $AccountBackgroundTable(attachedDatabase, alias);
  }

  static TypeConverter<AccountId?, String?> $converteruuidAccountId =
      const NullAwareTypeConverter.wrap(AccountIdConverter());
}

class AccountBackgroundData extends DataClass
    implements Insertable<AccountBackgroundData> {
  final int id;
  final AccountId? uuidAccountId;
  final bool? localNotificationSettingMessages;
  final bool? localNotificationSettingLikes;
  final bool? localNotificationSettingMediaContentModerationCompleted;
  final bool? localNotificationSettingProfileTextModerationCompleted;
  final bool? localNotificationSettingNewsItemAvailable;
  final bool? userInterfaceSettingShowNonAcceptedProfileNames;
  const AccountBackgroundData(
      {required this.id,
      this.uuidAccountId,
      this.localNotificationSettingMessages,
      this.localNotificationSettingLikes,
      this.localNotificationSettingMediaContentModerationCompleted,
      this.localNotificationSettingProfileTextModerationCompleted,
      this.localNotificationSettingNewsItemAvailable,
      this.userInterfaceSettingShowNonAcceptedProfileNames});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || uuidAccountId != null) {
      map['uuid_account_id'] = Variable<String>(
          $AccountBackgroundTable.$converteruuidAccountId.toSql(uuidAccountId));
    }
    if (!nullToAbsent || localNotificationSettingMessages != null) {
      map['local_notification_setting_messages'] =
          Variable<bool>(localNotificationSettingMessages);
    }
    if (!nullToAbsent || localNotificationSettingLikes != null) {
      map['local_notification_setting_likes'] =
          Variable<bool>(localNotificationSettingLikes);
    }
    if (!nullToAbsent ||
        localNotificationSettingMediaContentModerationCompleted != null) {
      map['local_notification_setting_media_content_moderation_completed'] =
          Variable<bool>(
              localNotificationSettingMediaContentModerationCompleted);
    }
    if (!nullToAbsent ||
        localNotificationSettingProfileTextModerationCompleted != null) {
      map['local_notification_setting_profile_text_moderation_completed'] =
          Variable<bool>(
              localNotificationSettingProfileTextModerationCompleted);
    }
    if (!nullToAbsent || localNotificationSettingNewsItemAvailable != null) {
      map['local_notification_setting_news_item_available'] =
          Variable<bool>(localNotificationSettingNewsItemAvailable);
    }
    if (!nullToAbsent ||
        userInterfaceSettingShowNonAcceptedProfileNames != null) {
      map['user_interface_setting_show_non_accepted_profile_names'] =
          Variable<bool>(userInterfaceSettingShowNonAcceptedProfileNames);
    }
    return map;
  }

  AccountBackgroundCompanion toCompanion(bool nullToAbsent) {
    return AccountBackgroundCompanion(
      id: Value(id),
      uuidAccountId: uuidAccountId == null && nullToAbsent
          ? const Value.absent()
          : Value(uuidAccountId),
      localNotificationSettingMessages:
          localNotificationSettingMessages == null && nullToAbsent
              ? const Value.absent()
              : Value(localNotificationSettingMessages),
      localNotificationSettingLikes:
          localNotificationSettingLikes == null && nullToAbsent
              ? const Value.absent()
              : Value(localNotificationSettingLikes),
      localNotificationSettingMediaContentModerationCompleted:
          localNotificationSettingMediaContentModerationCompleted == null &&
                  nullToAbsent
              ? const Value.absent()
              : Value(localNotificationSettingMediaContentModerationCompleted),
      localNotificationSettingProfileTextModerationCompleted:
          localNotificationSettingProfileTextModerationCompleted == null &&
                  nullToAbsent
              ? const Value.absent()
              : Value(localNotificationSettingProfileTextModerationCompleted),
      localNotificationSettingNewsItemAvailable:
          localNotificationSettingNewsItemAvailable == null && nullToAbsent
              ? const Value.absent()
              : Value(localNotificationSettingNewsItemAvailable),
      userInterfaceSettingShowNonAcceptedProfileNames:
          userInterfaceSettingShowNonAcceptedProfileNames == null &&
                  nullToAbsent
              ? const Value.absent()
              : Value(userInterfaceSettingShowNonAcceptedProfileNames),
    );
  }

  factory AccountBackgroundData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AccountBackgroundData(
      id: serializer.fromJson<int>(json['id']),
      uuidAccountId: serializer.fromJson<AccountId?>(json['uuidAccountId']),
      localNotificationSettingMessages:
          serializer.fromJson<bool?>(json['localNotificationSettingMessages']),
      localNotificationSettingLikes:
          serializer.fromJson<bool?>(json['localNotificationSettingLikes']),
      localNotificationSettingMediaContentModerationCompleted:
          serializer.fromJson<bool?>(
              json['localNotificationSettingMediaContentModerationCompleted']),
      localNotificationSettingProfileTextModerationCompleted:
          serializer.fromJson<bool?>(
              json['localNotificationSettingProfileTextModerationCompleted']),
      localNotificationSettingNewsItemAvailable: serializer
          .fromJson<bool?>(json['localNotificationSettingNewsItemAvailable']),
      userInterfaceSettingShowNonAcceptedProfileNames:
          serializer.fromJson<bool?>(
              json['userInterfaceSettingShowNonAcceptedProfileNames']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uuidAccountId': serializer.toJson<AccountId?>(uuidAccountId),
      'localNotificationSettingMessages':
          serializer.toJson<bool?>(localNotificationSettingMessages),
      'localNotificationSettingLikes':
          serializer.toJson<bool?>(localNotificationSettingLikes),
      'localNotificationSettingMediaContentModerationCompleted':
          serializer.toJson<bool?>(
              localNotificationSettingMediaContentModerationCompleted),
      'localNotificationSettingProfileTextModerationCompleted':
          serializer.toJson<bool?>(
              localNotificationSettingProfileTextModerationCompleted),
      'localNotificationSettingNewsItemAvailable':
          serializer.toJson<bool?>(localNotificationSettingNewsItemAvailable),
      'userInterfaceSettingShowNonAcceptedProfileNames': serializer
          .toJson<bool?>(userInterfaceSettingShowNonAcceptedProfileNames),
    };
  }

  AccountBackgroundData copyWith(
          {int? id,
          Value<AccountId?> uuidAccountId = const Value.absent(),
          Value<bool?> localNotificationSettingMessages = const Value.absent(),
          Value<bool?> localNotificationSettingLikes = const Value.absent(),
          Value<bool?> localNotificationSettingMediaContentModerationCompleted =
              const Value.absent(),
          Value<bool?> localNotificationSettingProfileTextModerationCompleted =
              const Value.absent(),
          Value<bool?> localNotificationSettingNewsItemAvailable =
              const Value.absent(),
          Value<bool?> userInterfaceSettingShowNonAcceptedProfileNames =
              const Value.absent()}) =>
      AccountBackgroundData(
        id: id ?? this.id,
        uuidAccountId:
            uuidAccountId.present ? uuidAccountId.value : this.uuidAccountId,
        localNotificationSettingMessages:
            localNotificationSettingMessages.present
                ? localNotificationSettingMessages.value
                : this.localNotificationSettingMessages,
        localNotificationSettingLikes: localNotificationSettingLikes.present
            ? localNotificationSettingLikes.value
            : this.localNotificationSettingLikes,
        localNotificationSettingMediaContentModerationCompleted:
            localNotificationSettingMediaContentModerationCompleted.present
                ? localNotificationSettingMediaContentModerationCompleted.value
                : this.localNotificationSettingMediaContentModerationCompleted,
        localNotificationSettingProfileTextModerationCompleted:
            localNotificationSettingProfileTextModerationCompleted.present
                ? localNotificationSettingProfileTextModerationCompleted.value
                : this.localNotificationSettingProfileTextModerationCompleted,
        localNotificationSettingNewsItemAvailable:
            localNotificationSettingNewsItemAvailable.present
                ? localNotificationSettingNewsItemAvailable.value
                : this.localNotificationSettingNewsItemAvailable,
        userInterfaceSettingShowNonAcceptedProfileNames:
            userInterfaceSettingShowNonAcceptedProfileNames.present
                ? userInterfaceSettingShowNonAcceptedProfileNames.value
                : this.userInterfaceSettingShowNonAcceptedProfileNames,
      );
  AccountBackgroundData copyWithCompanion(AccountBackgroundCompanion data) {
    return AccountBackgroundData(
      id: data.id.present ? data.id.value : this.id,
      uuidAccountId: data.uuidAccountId.present
          ? data.uuidAccountId.value
          : this.uuidAccountId,
      localNotificationSettingMessages:
          data.localNotificationSettingMessages.present
              ? data.localNotificationSettingMessages.value
              : this.localNotificationSettingMessages,
      localNotificationSettingLikes: data.localNotificationSettingLikes.present
          ? data.localNotificationSettingLikes.value
          : this.localNotificationSettingLikes,
      localNotificationSettingMediaContentModerationCompleted: data
              .localNotificationSettingMediaContentModerationCompleted.present
          ? data.localNotificationSettingMediaContentModerationCompleted.value
          : this.localNotificationSettingMediaContentModerationCompleted,
      localNotificationSettingProfileTextModerationCompleted: data
              .localNotificationSettingProfileTextModerationCompleted.present
          ? data.localNotificationSettingProfileTextModerationCompleted.value
          : this.localNotificationSettingProfileTextModerationCompleted,
      localNotificationSettingNewsItemAvailable:
          data.localNotificationSettingNewsItemAvailable.present
              ? data.localNotificationSettingNewsItemAvailable.value
              : this.localNotificationSettingNewsItemAvailable,
      userInterfaceSettingShowNonAcceptedProfileNames:
          data.userInterfaceSettingShowNonAcceptedProfileNames.present
              ? data.userInterfaceSettingShowNonAcceptedProfileNames.value
              : this.userInterfaceSettingShowNonAcceptedProfileNames,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AccountBackgroundData(')
          ..write('id: $id, ')
          ..write('uuidAccountId: $uuidAccountId, ')
          ..write(
              'localNotificationSettingMessages: $localNotificationSettingMessages, ')
          ..write(
              'localNotificationSettingLikes: $localNotificationSettingLikes, ')
          ..write(
              'localNotificationSettingMediaContentModerationCompleted: $localNotificationSettingMediaContentModerationCompleted, ')
          ..write(
              'localNotificationSettingProfileTextModerationCompleted: $localNotificationSettingProfileTextModerationCompleted, ')
          ..write(
              'localNotificationSettingNewsItemAvailable: $localNotificationSettingNewsItemAvailable, ')
          ..write(
              'userInterfaceSettingShowNonAcceptedProfileNames: $userInterfaceSettingShowNonAcceptedProfileNames')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      uuidAccountId,
      localNotificationSettingMessages,
      localNotificationSettingLikes,
      localNotificationSettingMediaContentModerationCompleted,
      localNotificationSettingProfileTextModerationCompleted,
      localNotificationSettingNewsItemAvailable,
      userInterfaceSettingShowNonAcceptedProfileNames);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AccountBackgroundData &&
          other.id == this.id &&
          other.uuidAccountId == this.uuidAccountId &&
          other.localNotificationSettingMessages ==
              this.localNotificationSettingMessages &&
          other.localNotificationSettingLikes ==
              this.localNotificationSettingLikes &&
          other.localNotificationSettingMediaContentModerationCompleted ==
              this.localNotificationSettingMediaContentModerationCompleted &&
          other.localNotificationSettingProfileTextModerationCompleted ==
              this.localNotificationSettingProfileTextModerationCompleted &&
          other.localNotificationSettingNewsItemAvailable ==
              this.localNotificationSettingNewsItemAvailable &&
          other.userInterfaceSettingShowNonAcceptedProfileNames ==
              this.userInterfaceSettingShowNonAcceptedProfileNames);
}

class AccountBackgroundCompanion
    extends UpdateCompanion<AccountBackgroundData> {
  final Value<int> id;
  final Value<AccountId?> uuidAccountId;
  final Value<bool?> localNotificationSettingMessages;
  final Value<bool?> localNotificationSettingLikes;
  final Value<bool?> localNotificationSettingMediaContentModerationCompleted;
  final Value<bool?> localNotificationSettingProfileTextModerationCompleted;
  final Value<bool?> localNotificationSettingNewsItemAvailable;
  final Value<bool?> userInterfaceSettingShowNonAcceptedProfileNames;
  const AccountBackgroundCompanion({
    this.id = const Value.absent(),
    this.uuidAccountId = const Value.absent(),
    this.localNotificationSettingMessages = const Value.absent(),
    this.localNotificationSettingLikes = const Value.absent(),
    this.localNotificationSettingMediaContentModerationCompleted =
        const Value.absent(),
    this.localNotificationSettingProfileTextModerationCompleted =
        const Value.absent(),
    this.localNotificationSettingNewsItemAvailable = const Value.absent(),
    this.userInterfaceSettingShowNonAcceptedProfileNames = const Value.absent(),
  });
  AccountBackgroundCompanion.insert({
    this.id = const Value.absent(),
    this.uuidAccountId = const Value.absent(),
    this.localNotificationSettingMessages = const Value.absent(),
    this.localNotificationSettingLikes = const Value.absent(),
    this.localNotificationSettingMediaContentModerationCompleted =
        const Value.absent(),
    this.localNotificationSettingProfileTextModerationCompleted =
        const Value.absent(),
    this.localNotificationSettingNewsItemAvailable = const Value.absent(),
    this.userInterfaceSettingShowNonAcceptedProfileNames = const Value.absent(),
  });
  static Insertable<AccountBackgroundData> custom({
    Expression<int>? id,
    Expression<String>? uuidAccountId,
    Expression<bool>? localNotificationSettingMessages,
    Expression<bool>? localNotificationSettingLikes,
    Expression<bool>? localNotificationSettingMediaContentModerationCompleted,
    Expression<bool>? localNotificationSettingProfileTextModerationCompleted,
    Expression<bool>? localNotificationSettingNewsItemAvailable,
    Expression<bool>? userInterfaceSettingShowNonAcceptedProfileNames,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuidAccountId != null) 'uuid_account_id': uuidAccountId,
      if (localNotificationSettingMessages != null)
        'local_notification_setting_messages': localNotificationSettingMessages,
      if (localNotificationSettingLikes != null)
        'local_notification_setting_likes': localNotificationSettingLikes,
      if (localNotificationSettingMediaContentModerationCompleted != null)
        'local_notification_setting_media_content_moderation_completed':
            localNotificationSettingMediaContentModerationCompleted,
      if (localNotificationSettingProfileTextModerationCompleted != null)
        'local_notification_setting_profile_text_moderation_completed':
            localNotificationSettingProfileTextModerationCompleted,
      if (localNotificationSettingNewsItemAvailable != null)
        'local_notification_setting_news_item_available':
            localNotificationSettingNewsItemAvailable,
      if (userInterfaceSettingShowNonAcceptedProfileNames != null)
        'user_interface_setting_show_non_accepted_profile_names':
            userInterfaceSettingShowNonAcceptedProfileNames,
    });
  }

  AccountBackgroundCompanion copyWith(
      {Value<int>? id,
      Value<AccountId?>? uuidAccountId,
      Value<bool?>? localNotificationSettingMessages,
      Value<bool?>? localNotificationSettingLikes,
      Value<bool?>? localNotificationSettingMediaContentModerationCompleted,
      Value<bool?>? localNotificationSettingProfileTextModerationCompleted,
      Value<bool?>? localNotificationSettingNewsItemAvailable,
      Value<bool?>? userInterfaceSettingShowNonAcceptedProfileNames}) {
    return AccountBackgroundCompanion(
      id: id ?? this.id,
      uuidAccountId: uuidAccountId ?? this.uuidAccountId,
      localNotificationSettingMessages: localNotificationSettingMessages ??
          this.localNotificationSettingMessages,
      localNotificationSettingLikes:
          localNotificationSettingLikes ?? this.localNotificationSettingLikes,
      localNotificationSettingMediaContentModerationCompleted:
          localNotificationSettingMediaContentModerationCompleted ??
              this.localNotificationSettingMediaContentModerationCompleted,
      localNotificationSettingProfileTextModerationCompleted:
          localNotificationSettingProfileTextModerationCompleted ??
              this.localNotificationSettingProfileTextModerationCompleted,
      localNotificationSettingNewsItemAvailable:
          localNotificationSettingNewsItemAvailable ??
              this.localNotificationSettingNewsItemAvailable,
      userInterfaceSettingShowNonAcceptedProfileNames:
          userInterfaceSettingShowNonAcceptedProfileNames ??
              this.userInterfaceSettingShowNonAcceptedProfileNames,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uuidAccountId.present) {
      map['uuid_account_id'] = Variable<String>($AccountBackgroundTable
          .$converteruuidAccountId
          .toSql(uuidAccountId.value));
    }
    if (localNotificationSettingMessages.present) {
      map['local_notification_setting_messages'] =
          Variable<bool>(localNotificationSettingMessages.value);
    }
    if (localNotificationSettingLikes.present) {
      map['local_notification_setting_likes'] =
          Variable<bool>(localNotificationSettingLikes.value);
    }
    if (localNotificationSettingMediaContentModerationCompleted.present) {
      map['local_notification_setting_media_content_moderation_completed'] =
          Variable<bool>(
              localNotificationSettingMediaContentModerationCompleted.value);
    }
    if (localNotificationSettingProfileTextModerationCompleted.present) {
      map['local_notification_setting_profile_text_moderation_completed'] =
          Variable<bool>(
              localNotificationSettingProfileTextModerationCompleted.value);
    }
    if (localNotificationSettingNewsItemAvailable.present) {
      map['local_notification_setting_news_item_available'] =
          Variable<bool>(localNotificationSettingNewsItemAvailable.value);
    }
    if (userInterfaceSettingShowNonAcceptedProfileNames.present) {
      map['user_interface_setting_show_non_accepted_profile_names'] =
          Variable<bool>(userInterfaceSettingShowNonAcceptedProfileNames.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AccountBackgroundCompanion(')
          ..write('id: $id, ')
          ..write('uuidAccountId: $uuidAccountId, ')
          ..write(
              'localNotificationSettingMessages: $localNotificationSettingMessages, ')
          ..write(
              'localNotificationSettingLikes: $localNotificationSettingLikes, ')
          ..write(
              'localNotificationSettingMediaContentModerationCompleted: $localNotificationSettingMediaContentModerationCompleted, ')
          ..write(
              'localNotificationSettingProfileTextModerationCompleted: $localNotificationSettingProfileTextModerationCompleted, ')
          ..write(
              'localNotificationSettingNewsItemAvailable: $localNotificationSettingNewsItemAvailable, ')
          ..write(
              'userInterfaceSettingShowNonAcceptedProfileNames: $userInterfaceSettingShowNonAcceptedProfileNames')
          ..write(')'))
        .toString();
  }
}

class $ProfilesBackgroundTable extends ProfilesBackground
    with TableInfo<$ProfilesBackgroundTable, ProfilesBackgroundData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProfilesBackgroundTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  @override
  late final GeneratedColumnWithTypeConverter<AccountId, String> uuidAccountId =
      GeneratedColumn<String>('uuid_account_id', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: true,
              defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'))
          .withConverter<AccountId>(
              $ProfilesBackgroundTable.$converteruuidAccountId);
  static const VerificationMeta _profileNameMeta =
      const VerificationMeta('profileName');
  @override
  late final GeneratedColumn<String> profileName = GeneratedColumn<String>(
      'profile_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _profileNameAcceptedMeta =
      const VerificationMeta('profileNameAccepted');
  @override
  late final GeneratedColumn<bool> profileNameAccepted = GeneratedColumn<bool>(
      'profile_name_accepted', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("profile_name_accepted" IN (0, 1))'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, uuidAccountId, profileName, profileNameAccepted];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'profiles_background';
  @override
  VerificationContext validateIntegrity(
      Insertable<ProfilesBackgroundData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('profile_name')) {
      context.handle(
          _profileNameMeta,
          profileName.isAcceptableOrUnknown(
              data['profile_name']!, _profileNameMeta));
    }
    if (data.containsKey('profile_name_accepted')) {
      context.handle(
          _profileNameAcceptedMeta,
          profileNameAccepted.isAcceptableOrUnknown(
              data['profile_name_accepted']!, _profileNameAcceptedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProfilesBackgroundData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProfilesBackgroundData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      uuidAccountId: $ProfilesBackgroundTable.$converteruuidAccountId.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}uuid_account_id'])!),
      profileName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}profile_name']),
      profileNameAccepted: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}profile_name_accepted']),
    );
  }

  @override
  $ProfilesBackgroundTable createAlias(String alias) {
    return $ProfilesBackgroundTable(attachedDatabase, alias);
  }

  static TypeConverter<AccountId, String> $converteruuidAccountId =
      const AccountIdConverter();
}

class ProfilesBackgroundData extends DataClass
    implements Insertable<ProfilesBackgroundData> {
  final int id;
  final AccountId uuidAccountId;
  final String? profileName;
  final bool? profileNameAccepted;
  const ProfilesBackgroundData(
      {required this.id,
      required this.uuidAccountId,
      this.profileName,
      this.profileNameAccepted});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['uuid_account_id'] = Variable<String>($ProfilesBackgroundTable
          .$converteruuidAccountId
          .toSql(uuidAccountId));
    }
    if (!nullToAbsent || profileName != null) {
      map['profile_name'] = Variable<String>(profileName);
    }
    if (!nullToAbsent || profileNameAccepted != null) {
      map['profile_name_accepted'] = Variable<bool>(profileNameAccepted);
    }
    return map;
  }

  ProfilesBackgroundCompanion toCompanion(bool nullToAbsent) {
    return ProfilesBackgroundCompanion(
      id: Value(id),
      uuidAccountId: Value(uuidAccountId),
      profileName: profileName == null && nullToAbsent
          ? const Value.absent()
          : Value(profileName),
      profileNameAccepted: profileNameAccepted == null && nullToAbsent
          ? const Value.absent()
          : Value(profileNameAccepted),
    );
  }

  factory ProfilesBackgroundData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProfilesBackgroundData(
      id: serializer.fromJson<int>(json['id']),
      uuidAccountId: serializer.fromJson<AccountId>(json['uuidAccountId']),
      profileName: serializer.fromJson<String?>(json['profileName']),
      profileNameAccepted:
          serializer.fromJson<bool?>(json['profileNameAccepted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uuidAccountId': serializer.toJson<AccountId>(uuidAccountId),
      'profileName': serializer.toJson<String?>(profileName),
      'profileNameAccepted': serializer.toJson<bool?>(profileNameAccepted),
    };
  }

  ProfilesBackgroundData copyWith(
          {int? id,
          AccountId? uuidAccountId,
          Value<String?> profileName = const Value.absent(),
          Value<bool?> profileNameAccepted = const Value.absent()}) =>
      ProfilesBackgroundData(
        id: id ?? this.id,
        uuidAccountId: uuidAccountId ?? this.uuidAccountId,
        profileName: profileName.present ? profileName.value : this.profileName,
        profileNameAccepted: profileNameAccepted.present
            ? profileNameAccepted.value
            : this.profileNameAccepted,
      );
  ProfilesBackgroundData copyWithCompanion(ProfilesBackgroundCompanion data) {
    return ProfilesBackgroundData(
      id: data.id.present ? data.id.value : this.id,
      uuidAccountId: data.uuidAccountId.present
          ? data.uuidAccountId.value
          : this.uuidAccountId,
      profileName:
          data.profileName.present ? data.profileName.value : this.profileName,
      profileNameAccepted: data.profileNameAccepted.present
          ? data.profileNameAccepted.value
          : this.profileNameAccepted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProfilesBackgroundData(')
          ..write('id: $id, ')
          ..write('uuidAccountId: $uuidAccountId, ')
          ..write('profileName: $profileName, ')
          ..write('profileNameAccepted: $profileNameAccepted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, uuidAccountId, profileName, profileNameAccepted);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProfilesBackgroundData &&
          other.id == this.id &&
          other.uuidAccountId == this.uuidAccountId &&
          other.profileName == this.profileName &&
          other.profileNameAccepted == this.profileNameAccepted);
}

class ProfilesBackgroundCompanion
    extends UpdateCompanion<ProfilesBackgroundData> {
  final Value<int> id;
  final Value<AccountId> uuidAccountId;
  final Value<String?> profileName;
  final Value<bool?> profileNameAccepted;
  const ProfilesBackgroundCompanion({
    this.id = const Value.absent(),
    this.uuidAccountId = const Value.absent(),
    this.profileName = const Value.absent(),
    this.profileNameAccepted = const Value.absent(),
  });
  ProfilesBackgroundCompanion.insert({
    this.id = const Value.absent(),
    required AccountId uuidAccountId,
    this.profileName = const Value.absent(),
    this.profileNameAccepted = const Value.absent(),
  }) : uuidAccountId = Value(uuidAccountId);
  static Insertable<ProfilesBackgroundData> custom({
    Expression<int>? id,
    Expression<String>? uuidAccountId,
    Expression<String>? profileName,
    Expression<bool>? profileNameAccepted,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuidAccountId != null) 'uuid_account_id': uuidAccountId,
      if (profileName != null) 'profile_name': profileName,
      if (profileNameAccepted != null)
        'profile_name_accepted': profileNameAccepted,
    });
  }

  ProfilesBackgroundCompanion copyWith(
      {Value<int>? id,
      Value<AccountId>? uuidAccountId,
      Value<String?>? profileName,
      Value<bool?>? profileNameAccepted}) {
    return ProfilesBackgroundCompanion(
      id: id ?? this.id,
      uuidAccountId: uuidAccountId ?? this.uuidAccountId,
      profileName: profileName ?? this.profileName,
      profileNameAccepted: profileNameAccepted ?? this.profileNameAccepted,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uuidAccountId.present) {
      map['uuid_account_id'] = Variable<String>($ProfilesBackgroundTable
          .$converteruuidAccountId
          .toSql(uuidAccountId.value));
    }
    if (profileName.present) {
      map['profile_name'] = Variable<String>(profileName.value);
    }
    if (profileNameAccepted.present) {
      map['profile_name_accepted'] = Variable<bool>(profileNameAccepted.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProfilesBackgroundCompanion(')
          ..write('id: $id, ')
          ..write('uuidAccountId: $uuidAccountId, ')
          ..write('profileName: $profileName, ')
          ..write('profileNameAccepted: $profileNameAccepted')
          ..write(')'))
        .toString();
  }
}

class $ConversationsBackgroundTable extends ConversationsBackground
    with TableInfo<$ConversationsBackgroundTable, ConversationsBackgroundData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ConversationsBackgroundTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  @override
  late final GeneratedColumnWithTypeConverter<AccountId, String> uuidAccountId =
      GeneratedColumn<String>('uuid_account_id', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: true,
              defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'))
          .withConverter<AccountId>(
              $ConversationsBackgroundTable.$converteruuidAccountId);
  @override
  late final GeneratedColumnWithTypeConverter<UnreadMessagesCount, int>
      conversationUnreadMessagesCount = GeneratedColumn<int>(
              'conversation_unread_messages_count', aliasedName, false,
              type: DriftSqlType.int,
              requiredDuringInsert: false,
              defaultValue: const Constant(0))
          .withConverter<UnreadMessagesCount>($ConversationsBackgroundTable
              .$converterconversationUnreadMessagesCount);
  @override
  List<GeneratedColumn> get $columns =>
      [id, uuidAccountId, conversationUnreadMessagesCount];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'conversations_background';
  @override
  VerificationContext validateIntegrity(
      Insertable<ConversationsBackgroundData> instance,
      {bool isInserting = false}) {
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
  ConversationsBackgroundData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ConversationsBackgroundData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      uuidAccountId: $ConversationsBackgroundTable.$converteruuidAccountId
          .fromSql(attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}uuid_account_id'])!),
      conversationUnreadMessagesCount: $ConversationsBackgroundTable
          .$converterconversationUnreadMessagesCount
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.int,
              data['${effectivePrefix}conversation_unread_messages_count'])!),
    );
  }

  @override
  $ConversationsBackgroundTable createAlias(String alias) {
    return $ConversationsBackgroundTable(attachedDatabase, alias);
  }

  static TypeConverter<AccountId, String> $converteruuidAccountId =
      const AccountIdConverter();
  static TypeConverter<UnreadMessagesCount, int>
      $converterconversationUnreadMessagesCount =
      UnreadMessagesCountConverter();
}

class ConversationsBackgroundData extends DataClass
    implements Insertable<ConversationsBackgroundData> {
  final int id;
  final AccountId uuidAccountId;
  final UnreadMessagesCount conversationUnreadMessagesCount;
  const ConversationsBackgroundData(
      {required this.id,
      required this.uuidAccountId,
      required this.conversationUnreadMessagesCount});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['uuid_account_id'] = Variable<String>($ConversationsBackgroundTable
          .$converteruuidAccountId
          .toSql(uuidAccountId));
    }
    {
      map['conversation_unread_messages_count'] = Variable<int>(
          $ConversationsBackgroundTable
              .$converterconversationUnreadMessagesCount
              .toSql(conversationUnreadMessagesCount));
    }
    return map;
  }

  ConversationsBackgroundCompanion toCompanion(bool nullToAbsent) {
    return ConversationsBackgroundCompanion(
      id: Value(id),
      uuidAccountId: Value(uuidAccountId),
      conversationUnreadMessagesCount: Value(conversationUnreadMessagesCount),
    );
  }

  factory ConversationsBackgroundData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ConversationsBackgroundData(
      id: serializer.fromJson<int>(json['id']),
      uuidAccountId: serializer.fromJson<AccountId>(json['uuidAccountId']),
      conversationUnreadMessagesCount: serializer.fromJson<UnreadMessagesCount>(
          json['conversationUnreadMessagesCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uuidAccountId': serializer.toJson<AccountId>(uuidAccountId),
      'conversationUnreadMessagesCount': serializer
          .toJson<UnreadMessagesCount>(conversationUnreadMessagesCount),
    };
  }

  ConversationsBackgroundData copyWith(
          {int? id,
          AccountId? uuidAccountId,
          UnreadMessagesCount? conversationUnreadMessagesCount}) =>
      ConversationsBackgroundData(
        id: id ?? this.id,
        uuidAccountId: uuidAccountId ?? this.uuidAccountId,
        conversationUnreadMessagesCount: conversationUnreadMessagesCount ??
            this.conversationUnreadMessagesCount,
      );
  ConversationsBackgroundData copyWithCompanion(
      ConversationsBackgroundCompanion data) {
    return ConversationsBackgroundData(
      id: data.id.present ? data.id.value : this.id,
      uuidAccountId: data.uuidAccountId.present
          ? data.uuidAccountId.value
          : this.uuidAccountId,
      conversationUnreadMessagesCount:
          data.conversationUnreadMessagesCount.present
              ? data.conversationUnreadMessagesCount.value
              : this.conversationUnreadMessagesCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ConversationsBackgroundData(')
          ..write('id: $id, ')
          ..write('uuidAccountId: $uuidAccountId, ')
          ..write(
              'conversationUnreadMessagesCount: $conversationUnreadMessagesCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, uuidAccountId, conversationUnreadMessagesCount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ConversationsBackgroundData &&
          other.id == this.id &&
          other.uuidAccountId == this.uuidAccountId &&
          other.conversationUnreadMessagesCount ==
              this.conversationUnreadMessagesCount);
}

class ConversationsBackgroundCompanion
    extends UpdateCompanion<ConversationsBackgroundData> {
  final Value<int> id;
  final Value<AccountId> uuidAccountId;
  final Value<UnreadMessagesCount> conversationUnreadMessagesCount;
  const ConversationsBackgroundCompanion({
    this.id = const Value.absent(),
    this.uuidAccountId = const Value.absent(),
    this.conversationUnreadMessagesCount = const Value.absent(),
  });
  ConversationsBackgroundCompanion.insert({
    this.id = const Value.absent(),
    required AccountId uuidAccountId,
    this.conversationUnreadMessagesCount = const Value.absent(),
  }) : uuidAccountId = Value(uuidAccountId);
  static Insertable<ConversationsBackgroundData> custom({
    Expression<int>? id,
    Expression<String>? uuidAccountId,
    Expression<int>? conversationUnreadMessagesCount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuidAccountId != null) 'uuid_account_id': uuidAccountId,
      if (conversationUnreadMessagesCount != null)
        'conversation_unread_messages_count': conversationUnreadMessagesCount,
    });
  }

  ConversationsBackgroundCompanion copyWith(
      {Value<int>? id,
      Value<AccountId>? uuidAccountId,
      Value<UnreadMessagesCount>? conversationUnreadMessagesCount}) {
    return ConversationsBackgroundCompanion(
      id: id ?? this.id,
      uuidAccountId: uuidAccountId ?? this.uuidAccountId,
      conversationUnreadMessagesCount: conversationUnreadMessagesCount ??
          this.conversationUnreadMessagesCount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uuidAccountId.present) {
      map['uuid_account_id'] = Variable<String>($ConversationsBackgroundTable
          .$converteruuidAccountId
          .toSql(uuidAccountId.value));
    }
    if (conversationUnreadMessagesCount.present) {
      map['conversation_unread_messages_count'] = Variable<int>(
          $ConversationsBackgroundTable
              .$converterconversationUnreadMessagesCount
              .toSql(conversationUnreadMessagesCount.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ConversationsBackgroundCompanion(')
          ..write('id: $id, ')
          ..write('uuidAccountId: $uuidAccountId, ')
          ..write(
              'conversationUnreadMessagesCount: $conversationUnreadMessagesCount')
          ..write(')'))
        .toString();
  }
}

class $NewMessageNotificationTable extends NewMessageNotification
    with TableInfo<$NewMessageNotificationTable, NewMessageNotificationData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NewMessageNotificationTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  @override
  late final GeneratedColumnWithTypeConverter<AccountId, String> uuidAccountId =
      GeneratedColumn<String>('uuid_account_id', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: true,
              defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'))
          .withConverter<AccountId>(
              $NewMessageNotificationTable.$converteruuidAccountId);
  static const VerificationMeta _notificationShownMeta =
      const VerificationMeta('notificationShown');
  @override
  late final GeneratedColumn<bool> notificationShown = GeneratedColumn<bool>(
      'notification_shown', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("notification_shown" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [id, uuidAccountId, notificationShown];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'new_message_notification';
  @override
  VerificationContext validateIntegrity(
      Insertable<NewMessageNotificationData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('notification_shown')) {
      context.handle(
          _notificationShownMeta,
          notificationShown.isAcceptableOrUnknown(
              data['notification_shown']!, _notificationShownMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NewMessageNotificationData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NewMessageNotificationData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      uuidAccountId: $NewMessageNotificationTable.$converteruuidAccountId
          .fromSql(attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}uuid_account_id'])!),
      notificationShown: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}notification_shown'])!,
    );
  }

  @override
  $NewMessageNotificationTable createAlias(String alias) {
    return $NewMessageNotificationTable(attachedDatabase, alias);
  }

  static TypeConverter<AccountId, String> $converteruuidAccountId =
      const AccountIdConverter();
}

class NewMessageNotificationData extends DataClass
    implements Insertable<NewMessageNotificationData> {
  final int id;
  final AccountId uuidAccountId;
  final bool notificationShown;
  const NewMessageNotificationData(
      {required this.id,
      required this.uuidAccountId,
      required this.notificationShown});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['uuid_account_id'] = Variable<String>($NewMessageNotificationTable
          .$converteruuidAccountId
          .toSql(uuidAccountId));
    }
    map['notification_shown'] = Variable<bool>(notificationShown);
    return map;
  }

  NewMessageNotificationCompanion toCompanion(bool nullToAbsent) {
    return NewMessageNotificationCompanion(
      id: Value(id),
      uuidAccountId: Value(uuidAccountId),
      notificationShown: Value(notificationShown),
    );
  }

  factory NewMessageNotificationData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NewMessageNotificationData(
      id: serializer.fromJson<int>(json['id']),
      uuidAccountId: serializer.fromJson<AccountId>(json['uuidAccountId']),
      notificationShown: serializer.fromJson<bool>(json['notificationShown']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uuidAccountId': serializer.toJson<AccountId>(uuidAccountId),
      'notificationShown': serializer.toJson<bool>(notificationShown),
    };
  }

  NewMessageNotificationData copyWith(
          {int? id, AccountId? uuidAccountId, bool? notificationShown}) =>
      NewMessageNotificationData(
        id: id ?? this.id,
        uuidAccountId: uuidAccountId ?? this.uuidAccountId,
        notificationShown: notificationShown ?? this.notificationShown,
      );
  NewMessageNotificationData copyWithCompanion(
      NewMessageNotificationCompanion data) {
    return NewMessageNotificationData(
      id: data.id.present ? data.id.value : this.id,
      uuidAccountId: data.uuidAccountId.present
          ? data.uuidAccountId.value
          : this.uuidAccountId,
      notificationShown: data.notificationShown.present
          ? data.notificationShown.value
          : this.notificationShown,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NewMessageNotificationData(')
          ..write('id: $id, ')
          ..write('uuidAccountId: $uuidAccountId, ')
          ..write('notificationShown: $notificationShown')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, uuidAccountId, notificationShown);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NewMessageNotificationData &&
          other.id == this.id &&
          other.uuidAccountId == this.uuidAccountId &&
          other.notificationShown == this.notificationShown);
}

class NewMessageNotificationCompanion
    extends UpdateCompanion<NewMessageNotificationData> {
  final Value<int> id;
  final Value<AccountId> uuidAccountId;
  final Value<bool> notificationShown;
  const NewMessageNotificationCompanion({
    this.id = const Value.absent(),
    this.uuidAccountId = const Value.absent(),
    this.notificationShown = const Value.absent(),
  });
  NewMessageNotificationCompanion.insert({
    this.id = const Value.absent(),
    required AccountId uuidAccountId,
    this.notificationShown = const Value.absent(),
  }) : uuidAccountId = Value(uuidAccountId);
  static Insertable<NewMessageNotificationData> custom({
    Expression<int>? id,
    Expression<String>? uuidAccountId,
    Expression<bool>? notificationShown,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuidAccountId != null) 'uuid_account_id': uuidAccountId,
      if (notificationShown != null) 'notification_shown': notificationShown,
    });
  }

  NewMessageNotificationCompanion copyWith(
      {Value<int>? id,
      Value<AccountId>? uuidAccountId,
      Value<bool>? notificationShown}) {
    return NewMessageNotificationCompanion(
      id: id ?? this.id,
      uuidAccountId: uuidAccountId ?? this.uuidAccountId,
      notificationShown: notificationShown ?? this.notificationShown,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uuidAccountId.present) {
      map['uuid_account_id'] = Variable<String>($NewMessageNotificationTable
          .$converteruuidAccountId
          .toSql(uuidAccountId.value));
    }
    if (notificationShown.present) {
      map['notification_shown'] = Variable<bool>(notificationShown.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NewMessageNotificationCompanion(')
          ..write('id: $id, ')
          ..write('uuidAccountId: $uuidAccountId, ')
          ..write('notificationShown: $notificationShown')
          ..write(')'))
        .toString();
  }
}

class $NewReceivedLikesAvailableTable extends NewReceivedLikesAvailable
    with
        TableInfo<$NewReceivedLikesAvailableTable,
            NewReceivedLikesAvailableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NewReceivedLikesAvailableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _syncVersionReceivedLikesMeta =
      const VerificationMeta('syncVersionReceivedLikes');
  @override
  late final GeneratedColumn<int> syncVersionReceivedLikes =
      GeneratedColumn<int>('sync_version_received_likes', aliasedName, true,
          type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  late final GeneratedColumnWithTypeConverter<NewReceivedLikesCount?, int>
      newReceivedLikesCount = GeneratedColumn<int>(
              'new_received_likes_count', aliasedName, true,
              type: DriftSqlType.int, requiredDuringInsert: false)
          .withConverter<NewReceivedLikesCount?>(
              $NewReceivedLikesAvailableTable.$converternewReceivedLikesCount);
  @override
  late final GeneratedColumnWithTypeConverter<NewReceivedLikesCount?, int>
      newReceivedLikesCountNotViewed = GeneratedColumn<int>(
              'new_received_likes_count_not_viewed', aliasedName, true,
              type: DriftSqlType.int, requiredDuringInsert: false)
          .withConverter<NewReceivedLikesCount?>($NewReceivedLikesAvailableTable
              .$converternewReceivedLikesCountNotViewed);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        syncVersionReceivedLikes,
        newReceivedLikesCount,
        newReceivedLikesCountNotViewed
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'new_received_likes_available';
  @override
  VerificationContext validateIntegrity(
      Insertable<NewReceivedLikesAvailableData> instance,
      {bool isInserting = false}) {
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
              _syncVersionReceivedLikesMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NewReceivedLikesAvailableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NewReceivedLikesAvailableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      syncVersionReceivedLikes: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}sync_version_received_likes']),
      newReceivedLikesCount: $NewReceivedLikesAvailableTable
          .$converternewReceivedLikesCount
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.int,
              data['${effectivePrefix}new_received_likes_count'])),
      newReceivedLikesCountNotViewed: $NewReceivedLikesAvailableTable
          .$converternewReceivedLikesCountNotViewed
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.int,
              data['${effectivePrefix}new_received_likes_count_not_viewed'])),
    );
  }

  @override
  $NewReceivedLikesAvailableTable createAlias(String alias) {
    return $NewReceivedLikesAvailableTable(attachedDatabase, alias);
  }

  static TypeConverter<NewReceivedLikesCount?, int?>
      $converternewReceivedLikesCount =
      const NullAwareTypeConverter.wrap(NewReceivedLikesCountConverter());
  static TypeConverter<NewReceivedLikesCount?, int?>
      $converternewReceivedLikesCountNotViewed =
      const NullAwareTypeConverter.wrap(NewReceivedLikesCountConverter());
}

class NewReceivedLikesAvailableData extends DataClass
    implements Insertable<NewReceivedLikesAvailableData> {
  final int id;
  final int? syncVersionReceivedLikes;
  final NewReceivedLikesCount? newReceivedLikesCount;

  /// Count which will be reset once user views received likes screen
  final NewReceivedLikesCount? newReceivedLikesCountNotViewed;
  const NewReceivedLikesAvailableData(
      {required this.id,
      this.syncVersionReceivedLikes,
      this.newReceivedLikesCount,
      this.newReceivedLikesCountNotViewed});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || syncVersionReceivedLikes != null) {
      map['sync_version_received_likes'] =
          Variable<int>(syncVersionReceivedLikes);
    }
    if (!nullToAbsent || newReceivedLikesCount != null) {
      map['new_received_likes_count'] = Variable<int>(
          $NewReceivedLikesAvailableTable.$converternewReceivedLikesCount
              .toSql(newReceivedLikesCount));
    }
    if (!nullToAbsent || newReceivedLikesCountNotViewed != null) {
      map['new_received_likes_count_not_viewed'] = Variable<int>(
          $NewReceivedLikesAvailableTable
              .$converternewReceivedLikesCountNotViewed
              .toSql(newReceivedLikesCountNotViewed));
    }
    return map;
  }

  NewReceivedLikesAvailableCompanion toCompanion(bool nullToAbsent) {
    return NewReceivedLikesAvailableCompanion(
      id: Value(id),
      syncVersionReceivedLikes: syncVersionReceivedLikes == null && nullToAbsent
          ? const Value.absent()
          : Value(syncVersionReceivedLikes),
      newReceivedLikesCount: newReceivedLikesCount == null && nullToAbsent
          ? const Value.absent()
          : Value(newReceivedLikesCount),
      newReceivedLikesCountNotViewed:
          newReceivedLikesCountNotViewed == null && nullToAbsent
              ? const Value.absent()
              : Value(newReceivedLikesCountNotViewed),
    );
  }

  factory NewReceivedLikesAvailableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NewReceivedLikesAvailableData(
      id: serializer.fromJson<int>(json['id']),
      syncVersionReceivedLikes:
          serializer.fromJson<int?>(json['syncVersionReceivedLikes']),
      newReceivedLikesCount: serializer
          .fromJson<NewReceivedLikesCount?>(json['newReceivedLikesCount']),
      newReceivedLikesCountNotViewed:
          serializer.fromJson<NewReceivedLikesCount?>(
              json['newReceivedLikesCountNotViewed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'syncVersionReceivedLikes':
          serializer.toJson<int?>(syncVersionReceivedLikes),
      'newReceivedLikesCount':
          serializer.toJson<NewReceivedLikesCount?>(newReceivedLikesCount),
      'newReceivedLikesCountNotViewed': serializer
          .toJson<NewReceivedLikesCount?>(newReceivedLikesCountNotViewed),
    };
  }

  NewReceivedLikesAvailableData copyWith(
          {int? id,
          Value<int?> syncVersionReceivedLikes = const Value.absent(),
          Value<NewReceivedLikesCount?> newReceivedLikesCount =
              const Value.absent(),
          Value<NewReceivedLikesCount?> newReceivedLikesCountNotViewed =
              const Value.absent()}) =>
      NewReceivedLikesAvailableData(
        id: id ?? this.id,
        syncVersionReceivedLikes: syncVersionReceivedLikes.present
            ? syncVersionReceivedLikes.value
            : this.syncVersionReceivedLikes,
        newReceivedLikesCount: newReceivedLikesCount.present
            ? newReceivedLikesCount.value
            : this.newReceivedLikesCount,
        newReceivedLikesCountNotViewed: newReceivedLikesCountNotViewed.present
            ? newReceivedLikesCountNotViewed.value
            : this.newReceivedLikesCountNotViewed,
      );
  NewReceivedLikesAvailableData copyWithCompanion(
      NewReceivedLikesAvailableCompanion data) {
    return NewReceivedLikesAvailableData(
      id: data.id.present ? data.id.value : this.id,
      syncVersionReceivedLikes: data.syncVersionReceivedLikes.present
          ? data.syncVersionReceivedLikes.value
          : this.syncVersionReceivedLikes,
      newReceivedLikesCount: data.newReceivedLikesCount.present
          ? data.newReceivedLikesCount.value
          : this.newReceivedLikesCount,
      newReceivedLikesCountNotViewed:
          data.newReceivedLikesCountNotViewed.present
              ? data.newReceivedLikesCountNotViewed.value
              : this.newReceivedLikesCountNotViewed,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NewReceivedLikesAvailableData(')
          ..write('id: $id, ')
          ..write('syncVersionReceivedLikes: $syncVersionReceivedLikes, ')
          ..write('newReceivedLikesCount: $newReceivedLikesCount, ')
          ..write(
              'newReceivedLikesCountNotViewed: $newReceivedLikesCountNotViewed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, syncVersionReceivedLikes,
      newReceivedLikesCount, newReceivedLikesCountNotViewed);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NewReceivedLikesAvailableData &&
          other.id == this.id &&
          other.syncVersionReceivedLikes == this.syncVersionReceivedLikes &&
          other.newReceivedLikesCount == this.newReceivedLikesCount &&
          other.newReceivedLikesCountNotViewed ==
              this.newReceivedLikesCountNotViewed);
}

class NewReceivedLikesAvailableCompanion
    extends UpdateCompanion<NewReceivedLikesAvailableData> {
  final Value<int> id;
  final Value<int?> syncVersionReceivedLikes;
  final Value<NewReceivedLikesCount?> newReceivedLikesCount;
  final Value<NewReceivedLikesCount?> newReceivedLikesCountNotViewed;
  const NewReceivedLikesAvailableCompanion({
    this.id = const Value.absent(),
    this.syncVersionReceivedLikes = const Value.absent(),
    this.newReceivedLikesCount = const Value.absent(),
    this.newReceivedLikesCountNotViewed = const Value.absent(),
  });
  NewReceivedLikesAvailableCompanion.insert({
    this.id = const Value.absent(),
    this.syncVersionReceivedLikes = const Value.absent(),
    this.newReceivedLikesCount = const Value.absent(),
    this.newReceivedLikesCountNotViewed = const Value.absent(),
  });
  static Insertable<NewReceivedLikesAvailableData> custom({
    Expression<int>? id,
    Expression<int>? syncVersionReceivedLikes,
    Expression<int>? newReceivedLikesCount,
    Expression<int>? newReceivedLikesCountNotViewed,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (syncVersionReceivedLikes != null)
        'sync_version_received_likes': syncVersionReceivedLikes,
      if (newReceivedLikesCount != null)
        'new_received_likes_count': newReceivedLikesCount,
      if (newReceivedLikesCountNotViewed != null)
        'new_received_likes_count_not_viewed': newReceivedLikesCountNotViewed,
    });
  }

  NewReceivedLikesAvailableCompanion copyWith(
      {Value<int>? id,
      Value<int?>? syncVersionReceivedLikes,
      Value<NewReceivedLikesCount?>? newReceivedLikesCount,
      Value<NewReceivedLikesCount?>? newReceivedLikesCountNotViewed}) {
    return NewReceivedLikesAvailableCompanion(
      id: id ?? this.id,
      syncVersionReceivedLikes:
          syncVersionReceivedLikes ?? this.syncVersionReceivedLikes,
      newReceivedLikesCount:
          newReceivedLikesCount ?? this.newReceivedLikesCount,
      newReceivedLikesCountNotViewed:
          newReceivedLikesCountNotViewed ?? this.newReceivedLikesCountNotViewed,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (syncVersionReceivedLikes.present) {
      map['sync_version_received_likes'] =
          Variable<int>(syncVersionReceivedLikes.value);
    }
    if (newReceivedLikesCount.present) {
      map['new_received_likes_count'] = Variable<int>(
          $NewReceivedLikesAvailableTable.$converternewReceivedLikesCount
              .toSql(newReceivedLikesCount.value));
    }
    if (newReceivedLikesCountNotViewed.present) {
      map['new_received_likes_count_not_viewed'] = Variable<int>(
          $NewReceivedLikesAvailableTable
              .$converternewReceivedLikesCountNotViewed
              .toSql(newReceivedLikesCountNotViewed.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NewReceivedLikesAvailableCompanion(')
          ..write('id: $id, ')
          ..write('syncVersionReceivedLikes: $syncVersionReceivedLikes, ')
          ..write('newReceivedLikesCount: $newReceivedLikesCount, ')
          ..write(
              'newReceivedLikesCountNotViewed: $newReceivedLikesCountNotViewed')
          ..write(')'))
        .toString();
  }
}

class $NewsTable extends News with TableInfo<$NewsTable, New> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NewsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  @override
  late final GeneratedColumnWithTypeConverter<UnreadNewsCount?, int> newsCount =
      GeneratedColumn<int>('news_count', aliasedName, true,
              type: DriftSqlType.int, requiredDuringInsert: false)
          .withConverter<UnreadNewsCount?>($NewsTable.$converternewsCount);
  static const VerificationMeta _syncVersionNewsMeta =
      const VerificationMeta('syncVersionNews');
  @override
  late final GeneratedColumn<int> syncVersionNews = GeneratedColumn<int>(
      'sync_version_news', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, newsCount, syncVersionNews];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'news';
  @override
  VerificationContext validateIntegrity(Insertable<New> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('sync_version_news')) {
      context.handle(
          _syncVersionNewsMeta,
          syncVersionNews.isAcceptableOrUnknown(
              data['sync_version_news']!, _syncVersionNewsMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  New map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return New(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      newsCount: $NewsTable.$converternewsCount.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}news_count'])),
      syncVersionNews: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sync_version_news']),
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
      map['news_count'] =
          Variable<int>($NewsTable.$converternewsCount.toSql(newsCount));
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

  factory New.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
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

  New copyWith(
          {int? id,
          Value<UnreadNewsCount?> newsCount = const Value.absent(),
          Value<int?> syncVersionNews = const Value.absent()}) =>
      New(
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

  NewsCompanion copyWith(
      {Value<int>? id,
      Value<UnreadNewsCount?>? newsCount,
      Value<int?>? syncVersionNews}) {
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
      map['news_count'] =
          Variable<int>($NewsTable.$converternewsCount.toSql(newsCount.value));
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

class $MediaContentModerationCompletedNotificationTableTable
    extends MediaContentModerationCompletedNotificationTable
    with
        TableInfo<$MediaContentModerationCompletedNotificationTableTable,
            MediaContentModerationCompletedNotificationTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MediaContentModerationCompletedNotificationTableTable(this.attachedDatabase,
      [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _acceptedViewedMeta =
      const VerificationMeta('acceptedViewed');
  @override
  late final GeneratedColumn<int> acceptedViewed = GeneratedColumn<int>(
      'accepted_viewed', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _rejectedViewedMeta =
      const VerificationMeta('rejectedViewed');
  @override
  late final GeneratedColumn<int> rejectedViewed = GeneratedColumn<int>(
      'rejected_viewed', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [id, acceptedViewed, rejectedViewed];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name =
      'media_content_moderation_completed_notification_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<MediaContentModerationCompletedNotificationTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('accepted_viewed')) {
      context.handle(
          _acceptedViewedMeta,
          acceptedViewed.isAcceptableOrUnknown(
              data['accepted_viewed']!, _acceptedViewedMeta));
    }
    if (data.containsKey('rejected_viewed')) {
      context.handle(
          _rejectedViewedMeta,
          rejectedViewed.isAcceptableOrUnknown(
              data['rejected_viewed']!, _rejectedViewedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MediaContentModerationCompletedNotificationTableData map(
      Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MediaContentModerationCompletedNotificationTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      acceptedViewed: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}accepted_viewed'])!,
      rejectedViewed: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}rejected_viewed'])!,
    );
  }

  @override
  $MediaContentModerationCompletedNotificationTableTable createAlias(
      String alias) {
    return $MediaContentModerationCompletedNotificationTableTable(
        attachedDatabase, alias);
  }
}

class MediaContentModerationCompletedNotificationTableData extends DataClass
    implements
        Insertable<MediaContentModerationCompletedNotificationTableData> {
  final int id;
  final int acceptedViewed;
  final int rejectedViewed;
  const MediaContentModerationCompletedNotificationTableData(
      {required this.id,
      required this.acceptedViewed,
      required this.rejectedViewed});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['accepted_viewed'] = Variable<int>(acceptedViewed);
    map['rejected_viewed'] = Variable<int>(rejectedViewed);
    return map;
  }

  MediaContentModerationCompletedNotificationTableCompanion toCompanion(
      bool nullToAbsent) {
    return MediaContentModerationCompletedNotificationTableCompanion(
      id: Value(id),
      acceptedViewed: Value(acceptedViewed),
      rejectedViewed: Value(rejectedViewed),
    );
  }

  factory MediaContentModerationCompletedNotificationTableData.fromJson(
      Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MediaContentModerationCompletedNotificationTableData(
      id: serializer.fromJson<int>(json['id']),
      acceptedViewed: serializer.fromJson<int>(json['acceptedViewed']),
      rejectedViewed: serializer.fromJson<int>(json['rejectedViewed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'acceptedViewed': serializer.toJson<int>(acceptedViewed),
      'rejectedViewed': serializer.toJson<int>(rejectedViewed),
    };
  }

  MediaContentModerationCompletedNotificationTableData copyWith(
          {int? id, int? acceptedViewed, int? rejectedViewed}) =>
      MediaContentModerationCompletedNotificationTableData(
        id: id ?? this.id,
        acceptedViewed: acceptedViewed ?? this.acceptedViewed,
        rejectedViewed: rejectedViewed ?? this.rejectedViewed,
      );
  MediaContentModerationCompletedNotificationTableData copyWithCompanion(
      MediaContentModerationCompletedNotificationTableCompanion data) {
    return MediaContentModerationCompletedNotificationTableData(
      id: data.id.present ? data.id.value : this.id,
      acceptedViewed: data.acceptedViewed.present
          ? data.acceptedViewed.value
          : this.acceptedViewed,
      rejectedViewed: data.rejectedViewed.present
          ? data.rejectedViewed.value
          : this.rejectedViewed,
    );
  }

  @override
  String toString() {
    return (StringBuffer(
            'MediaContentModerationCompletedNotificationTableData(')
          ..write('id: $id, ')
          ..write('acceptedViewed: $acceptedViewed, ')
          ..write('rejectedViewed: $rejectedViewed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, acceptedViewed, rejectedViewed);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MediaContentModerationCompletedNotificationTableData &&
          other.id == this.id &&
          other.acceptedViewed == this.acceptedViewed &&
          other.rejectedViewed == this.rejectedViewed);
}

class MediaContentModerationCompletedNotificationTableCompanion
    extends UpdateCompanion<
        MediaContentModerationCompletedNotificationTableData> {
  final Value<int> id;
  final Value<int> acceptedViewed;
  final Value<int> rejectedViewed;
  const MediaContentModerationCompletedNotificationTableCompanion({
    this.id = const Value.absent(),
    this.acceptedViewed = const Value.absent(),
    this.rejectedViewed = const Value.absent(),
  });
  MediaContentModerationCompletedNotificationTableCompanion.insert({
    this.id = const Value.absent(),
    this.acceptedViewed = const Value.absent(),
    this.rejectedViewed = const Value.absent(),
  });
  static Insertable<MediaContentModerationCompletedNotificationTableData>
      custom({
    Expression<int>? id,
    Expression<int>? acceptedViewed,
    Expression<int>? rejectedViewed,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (acceptedViewed != null) 'accepted_viewed': acceptedViewed,
      if (rejectedViewed != null) 'rejected_viewed': rejectedViewed,
    });
  }

  MediaContentModerationCompletedNotificationTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? acceptedViewed,
      Value<int>? rejectedViewed}) {
    return MediaContentModerationCompletedNotificationTableCompanion(
      id: id ?? this.id,
      acceptedViewed: acceptedViewed ?? this.acceptedViewed,
      rejectedViewed: rejectedViewed ?? this.rejectedViewed,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (acceptedViewed.present) {
      map['accepted_viewed'] = Variable<int>(acceptedViewed.value);
    }
    if (rejectedViewed.present) {
      map['rejected_viewed'] = Variable<int>(rejectedViewed.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer(
            'MediaContentModerationCompletedNotificationTableCompanion(')
          ..write('id: $id, ')
          ..write('acceptedViewed: $acceptedViewed, ')
          ..write('rejectedViewed: $rejectedViewed')
          ..write(')'))
        .toString();
  }
}

class $ProfileTextModerationCompletedNotificationTableTable
    extends ProfileTextModerationCompletedNotificationTable
    with
        TableInfo<$ProfileTextModerationCompletedNotificationTableTable,
            ProfileTextModerationCompletedNotificationTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProfileTextModerationCompletedNotificationTableTable(this.attachedDatabase,
      [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _acceptedViewedMeta =
      const VerificationMeta('acceptedViewed');
  @override
  late final GeneratedColumn<int> acceptedViewed = GeneratedColumn<int>(
      'accepted_viewed', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _rejectedViewedMeta =
      const VerificationMeta('rejectedViewed');
  @override
  late final GeneratedColumn<int> rejectedViewed = GeneratedColumn<int>(
      'rejected_viewed', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [id, acceptedViewed, rejectedViewed];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name =
      'profile_text_moderation_completed_notification_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<ProfileTextModerationCompletedNotificationTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('accepted_viewed')) {
      context.handle(
          _acceptedViewedMeta,
          acceptedViewed.isAcceptableOrUnknown(
              data['accepted_viewed']!, _acceptedViewedMeta));
    }
    if (data.containsKey('rejected_viewed')) {
      context.handle(
          _rejectedViewedMeta,
          rejectedViewed.isAcceptableOrUnknown(
              data['rejected_viewed']!, _rejectedViewedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProfileTextModerationCompletedNotificationTableData map(
      Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProfileTextModerationCompletedNotificationTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      acceptedViewed: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}accepted_viewed'])!,
      rejectedViewed: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}rejected_viewed'])!,
    );
  }

  @override
  $ProfileTextModerationCompletedNotificationTableTable createAlias(
      String alias) {
    return $ProfileTextModerationCompletedNotificationTableTable(
        attachedDatabase, alias);
  }
}

class ProfileTextModerationCompletedNotificationTableData extends DataClass
    implements Insertable<ProfileTextModerationCompletedNotificationTableData> {
  final int id;
  final int acceptedViewed;
  final int rejectedViewed;
  const ProfileTextModerationCompletedNotificationTableData(
      {required this.id,
      required this.acceptedViewed,
      required this.rejectedViewed});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['accepted_viewed'] = Variable<int>(acceptedViewed);
    map['rejected_viewed'] = Variable<int>(rejectedViewed);
    return map;
  }

  ProfileTextModerationCompletedNotificationTableCompanion toCompanion(
      bool nullToAbsent) {
    return ProfileTextModerationCompletedNotificationTableCompanion(
      id: Value(id),
      acceptedViewed: Value(acceptedViewed),
      rejectedViewed: Value(rejectedViewed),
    );
  }

  factory ProfileTextModerationCompletedNotificationTableData.fromJson(
      Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProfileTextModerationCompletedNotificationTableData(
      id: serializer.fromJson<int>(json['id']),
      acceptedViewed: serializer.fromJson<int>(json['acceptedViewed']),
      rejectedViewed: serializer.fromJson<int>(json['rejectedViewed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'acceptedViewed': serializer.toJson<int>(acceptedViewed),
      'rejectedViewed': serializer.toJson<int>(rejectedViewed),
    };
  }

  ProfileTextModerationCompletedNotificationTableData copyWith(
          {int? id, int? acceptedViewed, int? rejectedViewed}) =>
      ProfileTextModerationCompletedNotificationTableData(
        id: id ?? this.id,
        acceptedViewed: acceptedViewed ?? this.acceptedViewed,
        rejectedViewed: rejectedViewed ?? this.rejectedViewed,
      );
  ProfileTextModerationCompletedNotificationTableData copyWithCompanion(
      ProfileTextModerationCompletedNotificationTableCompanion data) {
    return ProfileTextModerationCompletedNotificationTableData(
      id: data.id.present ? data.id.value : this.id,
      acceptedViewed: data.acceptedViewed.present
          ? data.acceptedViewed.value
          : this.acceptedViewed,
      rejectedViewed: data.rejectedViewed.present
          ? data.rejectedViewed.value
          : this.rejectedViewed,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProfileTextModerationCompletedNotificationTableData(')
          ..write('id: $id, ')
          ..write('acceptedViewed: $acceptedViewed, ')
          ..write('rejectedViewed: $rejectedViewed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, acceptedViewed, rejectedViewed);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProfileTextModerationCompletedNotificationTableData &&
          other.id == this.id &&
          other.acceptedViewed == this.acceptedViewed &&
          other.rejectedViewed == this.rejectedViewed);
}

class ProfileTextModerationCompletedNotificationTableCompanion
    extends UpdateCompanion<
        ProfileTextModerationCompletedNotificationTableData> {
  final Value<int> id;
  final Value<int> acceptedViewed;
  final Value<int> rejectedViewed;
  const ProfileTextModerationCompletedNotificationTableCompanion({
    this.id = const Value.absent(),
    this.acceptedViewed = const Value.absent(),
    this.rejectedViewed = const Value.absent(),
  });
  ProfileTextModerationCompletedNotificationTableCompanion.insert({
    this.id = const Value.absent(),
    this.acceptedViewed = const Value.absent(),
    this.rejectedViewed = const Value.absent(),
  });
  static Insertable<ProfileTextModerationCompletedNotificationTableData>
      custom({
    Expression<int>? id,
    Expression<int>? acceptedViewed,
    Expression<int>? rejectedViewed,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (acceptedViewed != null) 'accepted_viewed': acceptedViewed,
      if (rejectedViewed != null) 'rejected_viewed': rejectedViewed,
    });
  }

  ProfileTextModerationCompletedNotificationTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? acceptedViewed,
      Value<int>? rejectedViewed}) {
    return ProfileTextModerationCompletedNotificationTableCompanion(
      id: id ?? this.id,
      acceptedViewed: acceptedViewed ?? this.acceptedViewed,
      rejectedViewed: rejectedViewed ?? this.rejectedViewed,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (acceptedViewed.present) {
      map['accepted_viewed'] = Variable<int>(acceptedViewed.value);
    }
    if (rejectedViewed.present) {
      map['rejected_viewed'] = Variable<int>(rejectedViewed.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer(
            'ProfileTextModerationCompletedNotificationTableCompanion(')
          ..write('id: $id, ')
          ..write('acceptedViewed: $acceptedViewed, ')
          ..write('rejectedViewed: $rejectedViewed')
          ..write(')'))
        .toString();
  }
}

abstract class _$AccountBackgroundDatabase extends GeneratedDatabase {
  _$AccountBackgroundDatabase(QueryExecutor e) : super(e);
  late final $AccountBackgroundTable accountBackground =
      $AccountBackgroundTable(this);
  late final $ProfilesBackgroundTable profilesBackground =
      $ProfilesBackgroundTable(this);
  late final $ConversationsBackgroundTable conversationsBackground =
      $ConversationsBackgroundTable(this);
  late final $NewMessageNotificationTable newMessageNotification =
      $NewMessageNotificationTable(this);
  late final $NewReceivedLikesAvailableTable newReceivedLikesAvailable =
      $NewReceivedLikesAvailableTable(this);
  late final $NewsTable news = $NewsTable(this);
  late final $MediaContentModerationCompletedNotificationTableTable
      mediaContentModerationCompletedNotificationTable =
      $MediaContentModerationCompletedNotificationTableTable(this);
  late final $ProfileTextModerationCompletedNotificationTableTable
      profileTextModerationCompletedNotificationTable =
      $ProfileTextModerationCompletedNotificationTableTable(this);
  late final DaoLocalNotificationSettings daoLocalNotificationSettings =
      DaoLocalNotificationSettings(this as AccountBackgroundDatabase);
  late final DaoUserInterfaceSettings daoUserInterfaceSettings =
      DaoUserInterfaceSettings(this as AccountBackgroundDatabase);
  late final DaoProfilesBackground daoProfilesBackground =
      DaoProfilesBackground(this as AccountBackgroundDatabase);
  late final DaoConversationsBackground daoConversationsBackground =
      DaoConversationsBackground(this as AccountBackgroundDatabase);
  late final DaoNewMessageNotification daoNewMessageNotification =
      DaoNewMessageNotification(this as AccountBackgroundDatabase);
  late final DaoNewReceivedLikesAvailable daoNewReceivedLikesAvailable =
      DaoNewReceivedLikesAvailable(this as AccountBackgroundDatabase);
  late final DaoNews daoNews = DaoNews(this as AccountBackgroundDatabase);
  late final DaoMediaContentModerationCompletedNotificationTable
      daoMediaContentModerationCompletedNotificationTable =
      DaoMediaContentModerationCompletedNotificationTable(
          this as AccountBackgroundDatabase);
  late final DaoProfileTextModerationCompletedNotificationTable
      daoProfileTextModerationCompletedNotificationTable =
      DaoProfileTextModerationCompletedNotificationTable(
          this as AccountBackgroundDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        accountBackground,
        profilesBackground,
        conversationsBackground,
        newMessageNotification,
        newReceivedLikesAvailable,
        news,
        mediaContentModerationCompletedNotificationTable,
        profileTextModerationCompletedNotificationTable
      ];
}
