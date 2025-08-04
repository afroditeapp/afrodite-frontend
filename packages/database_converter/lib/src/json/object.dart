import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:openapi/api.dart';

/// Value might be null if parsing T from string fails.
class JsonObject<T> {
  final T? value;
  JsonObject._(this.value);
}

class NotificationStatusConverter extends TypeConverter<JsonObject<NotificationStatus>, String> {
  const NotificationStatusConverter();

  @override
  JsonObject<NotificationStatus> fromSql(fromDb) {
    return JsonObject._(NotificationStatus.fromJson(jsonDecode(fromDb)));
  }

  @override
  String toSql(value) {
    return jsonEncode(value.value?.toJson());
  }
}

class AdminNotificationConverter extends TypeConverter<JsonObject<AdminNotification>, String> {
  const AdminNotificationConverter();

  @override
  JsonObject<AdminNotification> fromSql(fromDb) {
    return JsonObject._(AdminNotification.fromJson(jsonDecode(fromDb)));
  }

  @override
  String toSql(value) {
    return jsonEncode(value.value?.toJson());
  }
}

class AccountStateContainerConverter extends TypeConverter<JsonObject<AccountStateContainer>, String> {
  const AccountStateContainerConverter();

  @override
  JsonObject<AccountStateContainer> fromSql(fromDb) {
    return JsonObject._(AccountStateContainer.fromJson(jsonDecode(fromDb)));
  }

  @override
  String toSql(value) {
    return jsonEncode(value.value?.toJson());
  }
}

class PermissionsConverter extends TypeConverter<JsonObject<Permissions>, String> {
  const PermissionsConverter();

  @override
  JsonObject<Permissions> fromSql(fromDb) {
    return JsonObject._(Permissions.fromJson(jsonDecode(fromDb)));
  }

  @override
  String toSql(value) {
    return jsonEncode(value.value?.toJson());
  }
}

class GetProfileFiltersConverter extends TypeConverter<JsonObject<GetProfileFilters>, String> {
  const GetProfileFiltersConverter();

  @override
  JsonObject<GetProfileFilters> fromSql(fromDb) {
    return JsonObject._(GetProfileFilters.fromJson(jsonDecode(fromDb)));
  }

  @override
  String toSql(value) {
    return jsonEncode(value.value?.toJson());
  }
}

class SearchGroupsConverter extends TypeConverter<JsonObject<SearchGroups>, String> {
  const SearchGroupsConverter();

  @override
  JsonObject<SearchGroups> fromSql(fromDb) {
    return JsonObject._(SearchGroups.fromJson(jsonDecode(fromDb)));
  }

  @override
  String toSql(value) {
    return jsonEncode(value.value?.toJson());
  }
}

class AttributeConverter extends TypeConverter<JsonObject<Attribute>, String> {
  const AttributeConverter();

  @override
  JsonObject<Attribute> fromSql(fromDb) {
    return JsonObject._(Attribute.fromJson(jsonDecode(fromDb)));
  }

  @override
  String toSql(value) {
    return jsonEncode(value.value?.toJson());
  }
}

class CustomReportsConfigConverter extends TypeConverter<JsonObject<CustomReportsConfig>, String> {
  const CustomReportsConfigConverter();

  @override
  JsonObject<CustomReportsConfig> fromSql(fromDb) {
    return JsonObject._(CustomReportsConfig.fromJson(jsonDecode(fromDb)));
  }

  @override
  String toSql(value) {
    return jsonEncode(value.value?.toJson());
  }
}

class ClientFeaturesConfigConverter extends TypeConverter<JsonObject<ClientFeaturesConfig>, String> {
  const ClientFeaturesConfigConverter();

  @override
  JsonObject<ClientFeaturesConfig> fromSql(fromDb) {
    return JsonObject._(ClientFeaturesConfig.fromJson(jsonDecode(fromDb)));
  }

  @override
  String toSql(value) {
    return jsonEncode(value.value?.toJson());
  }
}

extension NotificationStatusJson on NotificationStatus {
  JsonObject<NotificationStatus> toJsonObject() {
    return JsonObject._(this);
  }
}

extension AdminNotificationJson on AdminNotification {
  JsonObject<AdminNotification> toJsonObject() {
    return JsonObject._(this);
  }
}

extension AccountStateContainerJson on AccountStateContainer {
  JsonObject<AccountStateContainer> toJsonString() {
    return JsonObject._(this);
  }
}

extension PermissionsJson on Permissions {
  JsonObject<Permissions> toJsonString() {
    return JsonObject._(this);
  }
}

extension GetProfileFiltersJson on GetProfileFilters {
  JsonObject<GetProfileFilters> toJsonString() {
    return JsonObject._(this);
  }
}

extension SearchGroupsJson on SearchGroups {
  JsonObject<SearchGroups> toJsonString() {
    return JsonObject._(this);
  }
}

extension AttributeJson on Attribute {
  JsonObject<Attribute> toJsonString() {
    return JsonObject._(this);
  }
}

extension CustomReportsConfigJson on CustomReportsConfig {
  JsonObject<CustomReportsConfig> toJsonString() {
    return JsonObject._(this);
  }
}

extension ClientFeaturesConfigJson on ClientFeaturesConfig {
  JsonObject<ClientFeaturesConfig> toJsonString() {
    return JsonObject._(this);
  }
}
