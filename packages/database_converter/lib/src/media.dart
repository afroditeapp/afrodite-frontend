import 'package:drift/drift.dart';
import 'package:openapi/api.dart';

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


class MediaContentModerationRejectedReasonCategoryConverter extends TypeConverter<MediaContentModerationRejectedReasonCategory, int> {
  const MediaContentModerationRejectedReasonCategoryConverter();

  @override
  MediaContentModerationRejectedReasonCategory fromSql(fromDb) {
    return MediaContentModerationRejectedReasonCategory(value: fromDb);
  }

  @override
  int toSql(value) {
    return value.value;
  }
}

class MediaContentModerationRejectedReasonDetailsConverter extends TypeConverter<MediaContentModerationRejectedReasonDetails, String> {
  const MediaContentModerationRejectedReasonDetailsConverter();

  @override
  MediaContentModerationRejectedReasonDetails fromSql(fromDb) {
    return MediaContentModerationRejectedReasonDetails(value: fromDb);
  }

  @override
  String toSql(value) {
    return value.value;
  }
}
