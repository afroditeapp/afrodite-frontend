import 'package:database_converter/database_converter.dart';
import 'package:drift/drift.dart';


class MyMediaContent extends Table {
  /// Security content has index -1. Profile content indexes start from 0.
  IntColumn get contentIndex => integer()();

  TextColumn get uuidContentId => text().map(const ContentIdConverter())();
  BoolColumn get faceDetected => boolean()();
  TextColumn get moderationState => text().map(NullAwareTypeConverter.wrap(EnumString.driftConverter)).nullable()();
  IntColumn get contentModerationRejectedCategory => integer().map(const NullAwareTypeConverter.wrap(MediaContentModerationRejectedReasonCategoryConverter())).nullable()();
  TextColumn get contentModerationRejectedDetails => text().map(const NullAwareTypeConverter.wrap(MediaContentModerationRejectedReasonDetailsConverter())).nullable()();

  @override
  Set<Column<Object>> get primaryKey => {contentIndex};
}

class ProfileContent extends Table {
  TextColumn get accountId => text().map(const AccountIdConverter())();
  IntColumn get contentIndex => integer()();

  TextColumn get uuidContentId => text().map(const ContentIdConverter())();
  BoolColumn get contentAccepted => boolean()();
  BoolColumn get primaryContent => boolean()();

  @override
  Set<Column<Object>> get primaryKey => {accountId, contentIndex};
}
