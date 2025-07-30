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
