import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:openapi/api.dart';

/// List does not contain objects which can't be parsed from string to T
class JsonList<T> {
  final List<T> value;
  JsonList._(this.value);

  factory JsonList.create(List<T> Function() value) {
    try {
      return JsonList._(value());
    } catch (_) {
      return JsonList._([]);
    }
  }
}

class ProfileAttributeValueConverter
    extends TypeConverter<JsonList<ProfileAttributeValue>, String> {
  const ProfileAttributeValueConverter();

  @override
  JsonList<ProfileAttributeValue> fromSql(fromDb) {
    return JsonList.create(() => ProfileAttributeValue.listFromJson(jsonDecode(fromDb)));
  }

  @override
  String toSql(value) {
    return jsonEncode(value.value.map((e) => e.toJson()).toList());
  }
}

extension ProfileAttributeValueJsonList on List<ProfileAttributeValue> {
  JsonList<ProfileAttributeValue> toJsonList() {
    return JsonList._(this);
  }

  Map<int, ProfileAttributeValueUpdate> toProfileAttributesMap() {
    final attributes = map((v) => ProfileAttributeValueUpdate(id: v.id, v: v.v));
    return {for (var e in attributes) e.id: e};
  }
}
