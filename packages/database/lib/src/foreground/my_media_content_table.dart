


import 'package:database/database.dart';
import 'package:database_converter/database_converter.dart';
import 'package:openapi/api.dart' show ContentInfoWithFd;
import 'account_database.dart';

import 'package:drift/drift.dart';

part 'my_media_content_table.g.dart';

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

@DriftAccessor(tables: [MyMediaContent])
class DaoMyMediaContent extends DatabaseAccessor<AccountDatabase> with _$DaoMyMediaContentMixin {
  DaoMyMediaContent(super.db);

  Future<void> removeSecurityContent() async {
    await (delete(myMediaContent)..where((t) => t.contentIndex.equals(-1)))
      .go();
  }

  Future<void> removeContentStartingFrom(int index) async {
    await (delete(myMediaContent)..where((t) => t.contentIndex.isBiggerOrEqualValue(index)))
      .go();
  }

  Future<void> updateMyProfileContent(
    int index,
    ContentInfoWithFd content,
  ) async {
    await into(myMediaContent).insert(
      MyMediaContentCompanion.insert(
        contentIndex: Value(index),
        uuidContentId: content.cid,
        faceDetected: content.fd,
        moderationState: Value(content.state.toEnumString()),
        contentModerationRejectedCategory: Value(content.rejectedReasonCategory),
        contentModerationRejectedDetails: Value(content.rejectedReasonDetails),
      ),
      onConflict: DoUpdate((old) => MyMediaContentCompanion(
        uuidContentId: Value(content.cid),
        faceDetected: Value(content.fd),
        moderationState: Value(content.state.toEnumString()),
        contentModerationRejectedCategory: Value(content.rejectedReasonCategory),
        contentModerationRejectedDetails: Value(content.rejectedReasonDetails),
      ),
        target: [myMediaContent.contentIndex]
      ),
    );
  }

  Future<MyContent?> getContent(int index) async {
    final r = await (select(myMediaContent)
      ..where((t) => t.contentIndex.equals(index))
    )
      .getSingleOrNull();

    return _rowToMyMediaContent(r);
  }

  Stream<MyContent?> watchContent(int index) {
    return (select(myMediaContent)
      ..where((t) => t.contentIndex.equals(index))
    )
      .map((t) => _rowToMyMediaContent(t))
      .watchSingleOrNull();
  }

  Stream<List<MyContent>> watchAllProfileContent() {
    return (select(myMediaContent)
      ..where((t) => t.contentIndex.isBiggerOrEqualValue(0))
      ..orderBy([
        (t) => OrderingTerm(
          expression: t.contentIndex,
          mode: OrderingMode.asc,
        ),
      ])
    )
      .map((t) => _rowToMyMediaContent(t))
      .watch()
      .map((l) => l.nonNulls.toList());
  }

  MyContent? _rowToMyMediaContent(MyMediaContentData? r) {
    final state = r?.moderationState?.toContentModerationState();
    if (r == null || state == null) {
      return null;
    }

    return MyContent(
      r.uuidContentId,
      r.faceDetected,
      state,
      r.contentModerationRejectedCategory,
      r.contentModerationRejectedDetails,
      primaryContent: r.contentIndex == 0 && r.faceDetected,
    );
  }
}
