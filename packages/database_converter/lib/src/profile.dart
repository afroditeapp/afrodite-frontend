import 'package:database_model/database_model.dart';
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

class ProfileStringModerationRejectedReasonDetailsConverter
    extends TypeConverter<ProfileStringModerationRejectedReasonDetails, String> {
  const ProfileStringModerationRejectedReasonDetailsConverter();

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

class LocalAccountInteractionStateConverter
    extends TypeConverter<LocalAccountInteractionState, int> {
  const LocalAccountInteractionStateConverter();

  @override
  LocalAccountInteractionState fromSql(fromDb) {
    switch (fromDb) {
      case 0:
        return LocalAccountInteractionState.receivedLike;
      case 1:
        return LocalAccountInteractionState.sentLike;
      case 2:
        return LocalAccountInteractionState.match;
      default:
        throw ArgumentError('Invalid LocalAccountInteractionState DB value: $fromDb');
    }
  }

  @override
  int toSql(value) {
    switch (value) {
      case LocalAccountInteractionState.receivedLike:
        return 0;
      case LocalAccountInteractionState.sentLike:
        return 1;
      case LocalAccountInteractionState.match:
        return 2;
    }
  }
}
