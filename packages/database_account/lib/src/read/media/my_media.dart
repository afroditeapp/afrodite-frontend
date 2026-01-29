import 'package:database_account/src/database.dart';
import 'package:database_model/database_model.dart';
import 'package:drift/drift.dart';
import 'package:rxdart/rxdart.dart';

import '../../schema.dart' as schema;

part 'my_media.g.dart';

@DriftAccessor(tables: [schema.MyMediaContent])
class DaoReadMyMedia extends DatabaseAccessor<AccountDatabase> with _$DaoReadMyMediaMixin {
  DaoReadMyMedia(super.db);

  Future<MyContent?> getMyContentByIndex(int index) async {
    final r = await (select(
      myMediaContent,
    )..where((t) => t.contentIndex.equals(index))).getSingleOrNull();

    return _rowToMyMediaContent(r);
  }

  Stream<MyContent?> watchMyContent(int index) {
    return (select(myMediaContent)..where((t) => t.contentIndex.equals(index)))
        .map((t) => _rowToMyMediaContent(t))
        .watchSingleOrNull();
  }

  Stream<List<MyContent>> watchMyAllProfileContent() {
    return (select(myMediaContent)
          ..where((t) => t.contentIndex.isBiggerOrEqualValue(0))
          ..orderBy([(t) => OrderingTerm(expression: t.contentIndex, mode: OrderingMode.asc)]))
        .map((t) => _rowToMyMediaContent(t))
        .watch()
        .map((l) => l.nonNulls.toList());
  }

  MyContent? _rowToMyMediaContent(MyMediaContentData? r) {
    final state = r?.moderationState?.value;
    if (r == null || state == null) {
      return null;
    }

    return MyContent(
      r.contentId,
      r.faceDetected,
      state,
      r.contentModerationRejectedCategory,
      r.contentModerationRejectedDetails,
    );
  }

  Stream<MyContent?> watchMyCurrentSecurityContent() => watchMyContent(-1);

  Stream<PrimaryProfileContent?> watchMyPrimaryProfileContent() => Rx.combineLatest2(
    db.read.myProfile.watchColumnMyProfile((r) => r),
    watchMyContent(0),
    (r, c) {
      return PrimaryProfileContent(
        content0: c,
        gridCropSize: r?.primaryContentGridCropSize,
        gridCropX: r?.primaryContentGridCropX,
        gridCropY: r?.primaryContentGridCropY,
      );
    },
  );
}
