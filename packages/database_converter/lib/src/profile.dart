import 'package:drift/drift.dart';
import 'package:openapi/api.dart';

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

class AttributeHashConverter extends TypeConverter<AttributeHash, String> {
  const AttributeHashConverter();

  @override
  AttributeHash fromSql(fromDb) {
    return AttributeHash(h: fromDb);
  }

  @override
  String toSql(value) {
    return value.h;
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

class AutomaticProfileSearchIteratorSessionIdConverter
    extends TypeConverter<AutomaticProfileSearchIteratorSessionId, int> {
  const AutomaticProfileSearchIteratorSessionIdConverter();

  @override
  AutomaticProfileSearchIteratorSessionId fromSql(fromDb) {
    return AutomaticProfileSearchIteratorSessionId(id: fromDb);
  }

  @override
  int toSql(value) {
    return value.id;
  }
}

class ProfileStringModerationRejectedReasonCategoryConverter
    extends TypeConverter<ProfileStringModerationRejectedReasonCategory, int> {
  const ProfileStringModerationRejectedReasonCategoryConverter();

  @override
  ProfileStringModerationRejectedReasonCategory fromSql(fromDb) {
    return ProfileStringModerationRejectedReasonCategory(value: fromDb);
  }

  @override
  int toSql(value) {
    return value.value;
  }
}

class ProfileTextModerationRejectedReasonDetailsConverter
    extends TypeConverter<ProfileStringModerationRejectedReasonDetails, String> {
  const ProfileTextModerationRejectedReasonDetailsConverter();

  @override
  ProfileStringModerationRejectedReasonDetails fromSql(fromDb) {
    return ProfileStringModerationRejectedReasonDetails(value: fromDb);
  }

  @override
  String toSql(value) {
    return value.value;
  }
}
