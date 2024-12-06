
import 'package:database/src/utils.dart';
import 'package:openapi/api.dart' show ContentId, MyProfileContent, ProfileContentVersion;
import '../account_database.dart';

import 'package:drift/drift.dart';

part 'dao_current_content.g.dart';

@DriftAccessor(tables: [Account])
class DaoCurrentContent extends DatabaseAccessor<AccountDatabase> with _$DaoCurrentContentMixin, AccountTools {
  DaoCurrentContent(AccountDatabase db) : super(db);

  Future<void> setApiProfileContent({
    required MyProfileContent content,
    required ProfileContentVersion version,
  }) async {
    await into(account).insertOnConflictUpdate(
      AccountCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        uuidContentId0: Value(content.c.getAtOrNull(0)?.cid),
        uuidContentId1: Value(content.c.getAtOrNull(1)?.cid),
        uuidContentId2: Value(content.c.getAtOrNull(2)?.cid),
        uuidContentId3: Value(content.c.getAtOrNull(3)?.cid),
        uuidContentId4: Value(content.c.getAtOrNull(4)?.cid),
        uuidContentId5: Value(content.c.getAtOrNull(5)?.cid),
        faceDetectedContentId0: Value(content.c.getAtOrNull(0)?.fd),
        faceDetectedContentId1: Value(content.c.getAtOrNull(1)?.fd),
        faceDetectedContentId2: Value(content.c.getAtOrNull(2)?.fd),
        faceDetectedContentId3: Value(content.c.getAtOrNull(3)?.fd),
        faceDetectedContentId4: Value(content.c.getAtOrNull(4)?.fd),
        faceDetectedContentId5: Value(content.c.getAtOrNull(5)?.fd),
        primaryContentGridCropSize: Value(content.gridCropSize),
        primaryContentGridCropX: Value(content.gridCropX),
        primaryContentGridCropY: Value(content.gridCropY),
        profileContentVersion: Value(version),
      ),
    );
  }

  Future<void> setSecurityContent({
    Value<ContentId?> securityContent = const Value.absent(),
  }) async {
    await into(account).insertOnConflictUpdate(
      AccountCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        uuidSecurityContentId: securityContent,
      ),
    );
  }

  Stream<ContentId?> watchCurrentSecurityContent() =>
    watchColumn((r) => r.uuidSecurityContentId);
  Stream<CurrentProfileContent?> watchCurrentProfileContent() =>
    watchColumn((r) {
      return CurrentProfileContent(
        contentId0: r.uuidContentId0,
        contentId1: r.uuidContentId1,
        contentId2: r.uuidContentId2,
        contentId3: r.uuidContentId3,
        contentId4: r.uuidContentId4,
        contentId5: r.uuidContentId5,
        gridCropSize: r.primaryContentGridCropSize,
        gridCropX: r.primaryContentGridCropX,
        gridCropY: r.primaryContentGridCropY,
      );
    });
}

class CurrentProfileContent {
  final ContentId? contentId0;
  final ContentId? contentId1;
  final ContentId? contentId2;
  final ContentId? contentId3;
  final ContentId? contentId4;
  final ContentId? contentId5;
  final double? gridCropSize;
  final double? gridCropX;
  final double? gridCropY;
  const CurrentProfileContent({
    required this.contentId0,
    required this.contentId1,
    required this.contentId2,
    required this.contentId3,
    required this.contentId4,
    required this.contentId5,
    required this.gridCropSize,
    required this.gridCropX,
    required this.gridCropY,
  });
}
