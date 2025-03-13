


import 'package:database/database.dart';
import 'package:drift/drift.dart';
import 'package:openapi/api.dart';
import 'package:utils/utils.dart';

extension ListExtensions<T> on List<T> {
  T? getAtOrNull(int index) {
    if (index < length) {
      return this[index];
    }
    return null;
  }
}

abstract class QueryExcecutorProvider {
  QueryExecutor getQueryExcecutor();
}

class AccountIdConverter extends TypeConverter<AccountId, String> {
  const AccountIdConverter();

  @override
  AccountId fromSql(fromDb) {
    return AccountId(aid: fromDb);
  }

  @override
  String toSql(value) {
    return value.aid;
  }
}

class ContentIdConverter extends TypeConverter<ContentId, String> {
  const ContentIdConverter();

  @override
  ContentId fromSql(fromDb) {
    return ContentId(cid: fromDb);
  }

  @override
  String toSql(value) {
    return value.cid;
  }
}

class ProfileVersionConverter extends TypeConverter<ProfileVersion, String> {
  const ProfileVersionConverter();

  @override
  ProfileVersion fromSql(fromDb) {
    return ProfileVersion(v: fromDb);
  }

  @override
  String toSql(value) {
    return value.v;
  }
}

class ProfileContentVersionConverter extends TypeConverter<ProfileContentVersion, String> {
  const ProfileContentVersionConverter();

  @override
  ProfileContentVersion fromSql(fromDb) {
    return ProfileContentVersion(v: fromDb);
  }

  @override
  String toSql(value) {
    return value.v;
  }
}

class ProfileAttributeHashConverter extends TypeConverter<ProfileAttributeHash, String> {
  const ProfileAttributeHashConverter();

  @override
  ProfileAttributeHash fromSql(fromDb) {
    return ProfileAttributeHash(h: fromDb);
  }

  @override
  String toSql(value) {
    return value.h;
  }
}

class MessageNumberConverter extends TypeConverter<MessageNumber, int> {
  const MessageNumberConverter();

  @override
  MessageNumber fromSql(fromDb) {
    return MessageNumber(mn: fromDb);
  }

  @override
  int toSql(value) {
    return value.mn;
  }
}

class UtcDateTimeConverter extends TypeConverter<UtcDateTime, int> {
  const UtcDateTimeConverter();

  @override
  UtcDateTime fromSql(fromDb) {
    return UtcDateTime.fromUnixEpochMilliseconds(fromDb);
  }

  @override
  int toSql(value) {
    return value.toUnixEpochMilliseconds();
  }
}


class JsonString {
  final Map<String, Object?> jsonMap;
  JsonString(this.jsonMap);

  AccountStateContainer? toAccountStateContainer() {
    return AccountStateContainer.fromJson(jsonMap);
  }

  Permissions? toPermissions() {
    return Permissions.fromJson(jsonMap);
  }

  GetProfileFilteringSettings? toProfileAttributeFilterList() {
    return GetProfileFilteringSettings.fromJson(jsonMap);
  }

  SearchGroups? toSearchGroups() {
    return SearchGroups.fromJson(jsonMap);
  }

  Attribute? toAttribute() {
    return Attribute.fromJson(jsonMap);
  }

  static TypeConverter<JsonString, String> driftConverter = TypeConverter.json(
    fromJson: (json) => JsonString(json as Map<String, Object?>),
    toJson: (object) => object.jsonMap,
  );
}

extension AccountStateContainerJson on AccountStateContainer {
  JsonString toJsonString() {
    return JsonString(toJson());
  }
}

extension PermissionsJson on Permissions {
  JsonString toJsonString() {
    return JsonString(toJson());
  }
}

extension GetProfileFilteringSettingsJson on GetProfileFilteringSettings {
  JsonString toJsonString() {
    return JsonString(toJson());
  }
}

extension SearchGroupsJson on SearchGroups {
  JsonString toJsonString() {
    return JsonString(toJson());
  }
}

extension AttributeJson on Attribute {
  JsonString toJsonString() {
    return JsonString(toJson());
  }
}

class EnumString {
  final String enumString;
  EnumString(this.enumString);

  ProfileVisibility? toProfileVisibility() {
    return ProfileVisibility.fromJson(enumString);
  }

  ProfileNameModerationState? toProfileNameModerationState() {
    return ProfileNameModerationState.fromJson(enumString);
  }

  ProfileTextModerationState? toProfileTextModerationState() {
    return ProfileTextModerationState.fromJson(enumString);
  }

  ContentModerationState? toContentModerationState() {
    return ContentModerationState.fromJson(enumString);
  }

  AttributeOrderMode? toAttributeOrderMode() {
    return AttributeOrderMode.fromJson(enumString);
  }

  static TypeConverter<EnumString, String> driftConverter = const EnumStringConverter();
}

extension ProfileVisibilityConverter on ProfileVisibility {
  EnumString toEnumString() {
    return EnumString(toJson());
  }
}

extension ProfileNameModerationStateConverter on ProfileNameModerationState {
  EnumString toEnumString() {
    return EnumString(toJson());
  }
}

extension ProfileTextModerationStateConverter on ProfileTextModerationState {
  EnumString toEnumString() {
    return EnumString(toJson());
  }
}

extension ContentModerationStateConverter on ContentModerationState {
  EnumString toEnumString() {
    return EnumString(toJson());
  }
}

extension AttributeOrderModeConverter on AttributeOrderMode {
  EnumString toEnumString() {
    return EnumString(toJson());
  }
}

class EnumStringConverter extends TypeConverter<EnumString, String> {
  const EnumStringConverter();

  @override
  EnumString fromSql(fromDb) {
    return EnumString(fromDb);
  }

  @override
  String toSql(value) {
    return value.enumString;
  }
}

class JsonList {
  final List<Object?> jsonList;
  JsonList(this.jsonList);

  List<ProfileAttributeValue>? toProfileAttributes() {
    return ProfileAttributeValue.listFromJson(jsonList);
  }

  static TypeConverter<JsonList, String> driftConverter = TypeConverter.json(
    fromJson: (json) => JsonList(json as List<Object?>),
    toJson: (object) => object.jsonList,
  );
}

extension ProfileAttributeValueListJson on List<ProfileAttributeValue> {
  JsonList toJsonList() {
    return JsonList(map((e) => e.toJson()).toList());
  }
}

class NotificationSessionIdConverter extends TypeConverter<NotificationSessionId, int> {
  const NotificationSessionIdConverter();

  @override
  NotificationSessionId fromSql(fromDb) {
    return NotificationSessionId(id: fromDb);
  }

  @override
  int toSql(value) {
    return value.id;
  }
}

class FcmDeviceTokenConverter extends TypeConverter<FcmDeviceToken, String> {
  const FcmDeviceTokenConverter();

  @override
  FcmDeviceToken fromSql(fromDb) {
    return FcmDeviceToken(token: fromDb);
  }

  @override
  String toSql(value) {
    return value.token;
  }
}

class PendingNotificationTokenConverter extends TypeConverter<PendingNotificationToken, String> {
  const PendingNotificationTokenConverter();

  @override
  PendingNotificationToken fromSql(fromDb) {
    return PendingNotificationToken(token: fromDb);
  }

  @override
  String toSql(value) {
    return value.token;
  }
}

class NewMessageNotificationIdConverter extends TypeConverter<NewMessageNotificationId, int> {
  const NewMessageNotificationIdConverter();

  @override
  NewMessageNotificationId fromSql(fromDb) {
    return NewMessageNotificationId(fromDb);
  }

  @override
  int toSql(value) {
    return value.id;
  }
}

class ProfileIteratorSessionIdConverter extends TypeConverter<ProfileIteratorSessionId, int> {
  const ProfileIteratorSessionIdConverter();

  @override
  ProfileIteratorSessionId fromSql(fromDb) {
    return ProfileIteratorSessionId(id: fromDb);
  }

  @override
  int toSql(value) {
    return value.id;
  }
}

class ReceivedLikesIteratorSessionIdConverter extends TypeConverter<ReceivedLikesIteratorSessionId, int> {
  const ReceivedLikesIteratorSessionIdConverter();

  @override
  ReceivedLikesIteratorSessionId fromSql(fromDb) {
    return ReceivedLikesIteratorSessionId(id: fromDb);
  }

  @override
  int toSql(value) {
    return value.id;
  }
}

class MatchesIteratorSessionIdConverter extends TypeConverter<MatchesIteratorSessionId, int> {
  const MatchesIteratorSessionIdConverter();

  @override
  MatchesIteratorSessionId fromSql(fromDb) {
    return MatchesIteratorSessionId(id: fromDb);
  }

  @override
  int toSql(value) {
    return value.id;
  }
}

class PublicKeyDataConverter extends TypeConverter<PublicKeyData, String> {
  const PublicKeyDataConverter();

  @override
  PublicKeyData fromSql(fromDb) {
    return PublicKeyData(data: fromDb);
  }

  @override
  String toSql(value) {
    return value.data;
  }
}

class PublicKeyIdConverter extends TypeConverter<PublicKeyId, int> {
  const PublicKeyIdConverter();

  @override
  PublicKeyId fromSql(fromDb) {
    return PublicKeyId(id: fromDb);
  }

  @override
  int toSql(value) {
    return value.id;
  }
}

class PublicKeyVersionConverter extends TypeConverter<PublicKeyVersion, int> {
  const PublicKeyVersionConverter();

  @override
  PublicKeyVersion fromSql(fromDb) {
    return PublicKeyVersion(version: fromDb);
  }

  @override
  int toSql(value) {
    return value.version;
  }
}

class PrivateKeyDataConverter extends TypeConverter<PrivateKeyData, String> {
  const PrivateKeyDataConverter();

  @override
  PrivateKeyData fromSql(fromDb) {
    return PrivateKeyData(data: fromDb);
  }

  @override
  String toSql(value) {
    return value.data;
  }
}

class ClientIdConverter extends TypeConverter<ClientId, int> {
  const ClientIdConverter();

  @override
  ClientId fromSql(fromDb) {
    return ClientId(id: fromDb);
  }

  @override
  int toSql(value) {
    return value.id;
  }
}

class UnreadMessagesCountConverter extends TypeConverter<UnreadMessagesCount, int> {
  const UnreadMessagesCountConverter();

  @override
  UnreadMessagesCount fromSql(fromDb) {
    return UnreadMessagesCount(fromDb);
  }

  @override
  int toSql(value) {
    return value.count;
  }
}

class NewReceivedLikesCountConverter extends TypeConverter<NewReceivedLikesCount, int> {
  const NewReceivedLikesCountConverter();

  @override
  NewReceivedLikesCount fromSql(fromDb) {
    return NewReceivedLikesCount(c: fromDb);
  }

  @override
  int toSql(value) {
    return value.c;
  }
}

class UnreadNewsCountConverter extends TypeConverter<UnreadNewsCount, int> {
  const UnreadNewsCountConverter();

  @override
  UnreadNewsCount fromSql(fromDb) {
    return UnreadNewsCount(c: fromDb);
  }

  @override
  int toSql(value) {
    return value.c;
  }
}

class ProfileTextModerationRejectedReasonCategoryConverter extends TypeConverter<ProfileTextModerationRejectedReasonCategory, int> {
  const ProfileTextModerationRejectedReasonCategoryConverter();

  @override
  ProfileTextModerationRejectedReasonCategory fromSql(fromDb) {
    return ProfileTextModerationRejectedReasonCategory(value: fromDb);
  }

  @override
  int toSql(value) {
    return value.value;
  }
}

class ProfileTextModerationRejectedReasonDetailsConverter extends TypeConverter<ProfileTextModerationRejectedReasonDetails, String> {
  const ProfileTextModerationRejectedReasonDetailsConverter();

  @override
  ProfileTextModerationRejectedReasonDetails fromSql(fromDb) {
    return ProfileTextModerationRejectedReasonDetails(value: fromDb);
  }

  @override
  String toSql(value) {
    return value.value;
  }
}

class ProfileContentModerationRejectedReasonCategoryConverter extends TypeConverter<ProfileContentModerationRejectedReasonCategory, int> {
  const ProfileContentModerationRejectedReasonCategoryConverter();

  @override
  ProfileContentModerationRejectedReasonCategory fromSql(fromDb) {
    return ProfileContentModerationRejectedReasonCategory(value: fromDb);
  }

  @override
  int toSql(value) {
    return value.value;
  }
}

class ProfileContentModerationRejectedReasonDetailsConverter extends TypeConverter<ProfileContentModerationRejectedReasonDetails, String> {
  const ProfileContentModerationRejectedReasonDetailsConverter();

  @override
  ProfileContentModerationRejectedReasonDetails fromSql(fromDb) {
    return ProfileContentModerationRejectedReasonDetails(value: fromDb);
  }

  @override
  String toSql(value) {
    return value.value;
  }
}
