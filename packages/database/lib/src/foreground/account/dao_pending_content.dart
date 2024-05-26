
import 'package:openapi/api.dart' show ContentId, PendingProfileContent;
import '../account_database.dart';

import 'package:drift/drift.dart';


part 'dao_pending_content.g.dart';


@DriftAccessor(tables: [Account])
class DaoPendingContent extends DatabaseAccessor<AccountDatabase> with _$DaoPendingContentMixin, AccountTools {
  DaoPendingContent(super.db);


  Future<void> setApiPendingProfileContent({
    required PendingProfileContent pendingContent,
  }) async {
    await into(account).insertOnConflictUpdate(
      AccountCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        uuidPendingContentId0: Value(pendingContent.contentId0?.id),
        uuidPendingContentId1: Value(pendingContent.contentId1?.id),
        uuidPendingContentId2: Value(pendingContent.contentId2?.id),
        uuidPendingContentId3: Value(pendingContent.contentId3?.id),
        uuidPendingContentId4: Value(pendingContent.contentId4?.id),
        uuidPendingContentId5: Value(pendingContent.contentId5?.id),
        pendingPrimaryContentGridCropSize: Value(pendingContent.gridCropSize),
        pendingPrimaryContentGridCropX: Value(pendingContent.gridCropX),
        pendingPrimaryContentGridCropY: Value(pendingContent.gridCropY),
      ),
    );
  }

  Future<void> setPendingProfileContent({
    Value<ContentId?> pendingContentId0 = const Value.absent(),
    Value<ContentId?> pendingContentId1 = const Value.absent(),
    Value<ContentId?> pendingContentId2 = const Value.absent(),
    Value<ContentId?> pendingContentId3 = const Value.absent(),
    Value<ContentId?> pendingContentId4 = const Value.absent(),
    Value<ContentId?> pendingContentId5 = const Value.absent(),
    Value<double?> pendingGridCropSize = const Value.absent(),
    Value<double?> pendingGridCropX = const Value.absent(),
    Value<double?> pendingGridCropY = const Value.absent(),
  }) async {
    await into(account).insertOnConflictUpdate(
      AccountCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        uuidPendingContentId0: pendingContentId0,
        uuidPendingContentId1: pendingContentId1,
        uuidPendingContentId2: pendingContentId2,
        uuidPendingContentId3: pendingContentId3,
        uuidPendingContentId4: pendingContentId4,
        uuidPendingContentId5: pendingContentId5,
        pendingPrimaryContentGridCropSize: pendingGridCropSize,
        pendingPrimaryContentGridCropX: pendingGridCropX,
        pendingPrimaryContentGridCropY: pendingGridCropY,
      ),
    );
  }

  Future<void> setPendingSecurityContent({
    Value<ContentId?> pendingSecurityContent = const Value.absent(),
  }) async {
    await into(account).insertOnConflictUpdate(
      AccountCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        uuidPendingSecurityContentId: pendingSecurityContent,
      ),
    );
  }

  Stream<ContentId?> watchPendingSecurityContent() =>
    watchColumn((r) => r.uuidSecurityContentId);
  Stream<PendingProfileContentInternal?> watchPendingProfileContent() =>
    watchColumn((r) {
      return PendingProfileContentInternal(
        pendingContentId0: r.uuidPendingContentId0,
        pendingContentId1: r.uuidPendingContentId1,
        pendingContentId2: r.uuidPendingContentId2,
        pendingContentId3: r.uuidPendingContentId3,
        pendingContentId4: r.uuidPendingContentId4,
        pendingContentId5: r.uuidPendingContentId5,
        pendingGridCropSize: r.pendingPrimaryContentGridCropSize,
        pendingGridCropX: r.pendingPrimaryContentGridCropX,
        pendingGridCropY: r.pendingPrimaryContentGridCropY,
      );
    });
}


class PendingProfileContentInternal {
  final ContentId? pendingContentId0;
  final ContentId? pendingContentId1;
  final ContentId? pendingContentId2;
  final ContentId? pendingContentId3;
  final ContentId? pendingContentId4;
  final ContentId? pendingContentId5;
  final double? pendingGridCropSize;
  final double? pendingGridCropX;
  final double? pendingGridCropY;
  const PendingProfileContentInternal({
    required this.pendingContentId0,
    required this.pendingContentId1,
    required this.pendingContentId2,
    required this.pendingContentId3,
    required this.pendingContentId4,
    required this.pendingContentId5,
    required this.pendingGridCropSize,
    required this.pendingGridCropX,
    required this.pendingGridCropY,
  });
}
