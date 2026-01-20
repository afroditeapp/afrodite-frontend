import 'dart:convert';

import 'package:database_model/database_model.dart';
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

class ProfileAttributeValueUpdateListConverter
    extends TypeConverter<JsonList<ProfileAttributeValueUpdate>, String> {
  const ProfileAttributeValueUpdateListConverter();

  @override
  JsonList<ProfileAttributeValueUpdate> fromSql(fromDb) {
    return JsonList.create(() => ProfileAttributeValueUpdate.listFromJson(jsonDecode(fromDb)));
  }

  @override
  String toSql(value) {
    return jsonEncode(value.value.map((e) => e.toJson()).toList());
  }
}

extension ProfileAttributeValueUpdateJsonList on List<ProfileAttributeValueUpdate> {
  JsonList<ProfileAttributeValueUpdate> toJsonList() {
    return JsonList._(this);
  }
}

class ProfilePictureEntryListConverter
    extends TypeConverter<JsonList<ProfilePictureEntry>, String> {
  const ProfilePictureEntryListConverter();

  @override
  JsonList<ProfilePictureEntry> fromSql(fromDb) {
    return JsonList.create(() {
      final list = jsonDecode(fromDb) as List<dynamic>;
      return list.map((e) => ProfilePictureEntry.fromJson(e as Map<String, dynamic>)).toList();
    });
  }

  @override
  String toSql(value) {
    return jsonEncode(value.value.map((e) => e.toJson()).toList());
  }
}

extension ProfilePictureEntryJsonList on List<ProfilePictureEntry> {
  JsonList<ProfilePictureEntry> toJsonList() {
    return JsonList._(this);
  }
}
