import 'package:drift/drift.dart';
import 'package:openapi/api.dart';

/// Value might be null if parsing T from string fails.
class EnumString<T> {
  final T? value;
  EnumString._(this.value);
}

class ProfileVisibilityConverter extends TypeConverter<EnumString<ProfileVisibility>, String> {
  const ProfileVisibilityConverter();

  @override
  EnumString<ProfileVisibility> fromSql(fromDb) {
    return EnumString._(ProfileVisibility.fromJson(fromDb));
  }

  @override
  String toSql(value) {
    return value.value?.toJson() ?? "";
  }
}

class ProfileStringModerationStateConverter
    extends TypeConverter<EnumString<ProfileStringModerationState>, String> {
  const ProfileStringModerationStateConverter();

  @override
  EnumString<ProfileStringModerationState> fromSql(fromDb) {
    return EnumString._(ProfileStringModerationState.fromJson(fromDb));
  }

  @override
  String toSql(value) {
    return value.value?.toJson() ?? "";
  }
}

class ContentModerationStateConverter
    extends TypeConverter<EnumString<ContentModerationState>, String> {
  const ContentModerationStateConverter();

  @override
  EnumString<ContentModerationState> fromSql(fromDb) {
    return EnumString._(ContentModerationState.fromJson(fromDb));
  }

  @override
  String toSql(value) {
    return value.value?.toJson() ?? "";
  }
}

class AttributeOrderModeConverter extends TypeConverter<EnumString<AttributeOrderMode>, String> {
  const AttributeOrderModeConverter();

  @override
  EnumString<AttributeOrderMode> fromSql(fromDb) {
    return EnumString._(AttributeOrderMode.fromJson(fromDb));
  }

  @override
  String toSql(value) {
    return value.value?.toJson() ?? "";
  }
}

extension ProfileVisibilityEnumString on ProfileVisibility {
  EnumString<ProfileVisibility> toEnumString() {
    return EnumString._(this);
  }
}

extension ProfileStringModerationStateEnumString on ProfileStringModerationState {
  EnumString<ProfileStringModerationState> toEnumString() {
    return EnumString._(this);
  }
}

extension ContentModerationStateEnumString on ContentModerationState {
  EnumString<ContentModerationState> toEnumString() {
    return EnumString._(this);
  }
}

extension AttributeOrderModeEnumString on AttributeOrderMode {
  EnumString<AttributeOrderMode> toEnumString() {
    return EnumString._(this);
  }
}
