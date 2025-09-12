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

class ReceivedLikeIdConverter extends TypeConverter<ReceivedLikeId, int> {
  const ReceivedLikeIdConverter();

  @override
  ReceivedLikeId fromSql(fromDb) {
    return ReceivedLikeId(id: fromDb);
  }

  @override
  int toSql(value) {
    return value.id;
  }
}
