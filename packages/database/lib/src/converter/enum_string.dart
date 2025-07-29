import 'package:drift/drift.dart';
import 'package:openapi/api.dart';

class EnumString {
  final String enumString;
  EnumString(this.enumString);

  ProfileVisibility? toProfileVisibility() {
    return ProfileVisibility.fromJson(enumString);
  }

  ProfileStringModerationState? toProfileStringModerationState() {
    return ProfileStringModerationState.fromJson(enumString);
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

extension ProfileStringModerationStateConverter on ProfileStringModerationState {
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
