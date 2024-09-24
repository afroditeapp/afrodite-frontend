


import 'package:database/database.dart';
import 'package:drift/drift.dart';
import 'package:openapi/api.dart';
import 'package:utils/utils.dart';


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

  Capabilities? toCapabilities() {
    return Capabilities.fromJson(jsonMap);
  }

  AvailableProfileAttributes? toAvailableProfileAttributes() {
    return AvailableProfileAttributes.fromJson(jsonMap);
  }

  ProfileAttributeFilterList? toProfileAttributeFilterList() {
    return ProfileAttributeFilterList.fromJson(jsonMap);
  }

  SearchGroups? toSearchGroups() {
    return SearchGroups.fromJson(jsonMap);
  }

  static TypeConverter<JsonString, String> driftConverter = TypeConverter.json(
    fromJson: (json) => JsonString(json as Map<String, Object?>),
    toJson: (object) => object.jsonMap,
  );
}

extension CapabilitiesJson on Capabilities {
  JsonString toJsonString() {
    return JsonString(toJson());
  }
}

extension AvailableProfileAttributesJson on AvailableProfileAttributes {
  JsonString toJsonString() {
    return JsonString(toJson());
  }
}

extension ProfileAttributeFilterListJson on ProfileAttributeFilterList {
  JsonString toJsonString() {
    return JsonString(toJson());
  }
}

extension SearchGroupsJson on SearchGroups {
  JsonString toJsonString() {
    return JsonString(toJson());
  }
}

class EnumString {
  final String enumString;
  EnumString(this.enumString);

  AccountState? toAccountState() {
    return AccountState.fromJson(enumString);
  }

  ProfileVisibility? toProfileVisibility() {
    return ProfileVisibility.fromJson(enumString);
  }

  static TypeConverter<EnumString, String> driftConverter = const EnumStringConverter();
}

extension AccountStateConverter on AccountState {
  EnumString toEnumString() {
    return EnumString(toJson());
  }
}

extension ProfileVisibilityConverter on ProfileVisibility {
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

class IteratorSessionIdConverter extends TypeConverter<IteratorSessionId, String> {
  const IteratorSessionIdConverter();

  @override
  IteratorSessionId fromSql(fromDb) {
    return IteratorSessionId(id: fromDb);
  }

  @override
  String toSql(value) {
    return value.id;
  }
}

class LastSeenTimeFilterConverter extends TypeConverter<LastSeenTimeFilter, int> {
  const LastSeenTimeFilterConverter();

  @override
  LastSeenTimeFilter fromSql(fromDb) {
    return LastSeenTimeFilter(value: fromDb);
  }

  @override
  int toSql(value) {
    return value.value;
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
