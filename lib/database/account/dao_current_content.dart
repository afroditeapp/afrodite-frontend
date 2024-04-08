
import 'package:openapi/api.dart' show ContentId, ProfileContent;
import 'package:pihka_frontend/database/account_database.dart';

import 'package:drift/drift.dart';

part 'dao_current_content.g.dart';

@DriftAccessor(tables: [Account])
class DaoCurrentContent extends DatabaseAccessor<AccountDatabase> with _$DaoCurrentContentMixin, AccountTools {
  DaoCurrentContent(AccountDatabase db) : super(db);

  Future<void> setApiProfileContent({
    required ProfileContent content,
  }) async {
    await into(account).insertOnConflictUpdate(
      AccountCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        uuidContentId0: Value(content.contentId0?.id),
        uuidContentId1: Value(content.contentId1?.id),
        uuidContentId2: Value(content.contentId2?.id),
        uuidContentId3: Value(content.contentId3?.id),
        uuidContentId4: Value(content.contentId4?.id),
        uuidContentId5: Value(content.contentId5?.id),
        primaryContentGridCropSize: Value(content.gridCropSize),
        primaryContentGridCropX: Value(content.gridCropX),
        primaryContentGridCropY: Value(content.gridCropY),
      ),
    );
  }

  Future<void> setProfileContent({
    Value<ContentId?> uuidContentId0 = const Value.absent(),
    Value<ContentId?> uuidContentId1 = const Value.absent(),
    Value<ContentId?> uuidContentId2 = const Value.absent(),
    Value<ContentId?> uuidContentId3 = const Value.absent(),
    Value<ContentId?> uuidContentId4 = const Value.absent(),
    Value<ContentId?> uuidContentId5 = const Value.absent(),
    Value<double?> primaryContentGridCropSize = const Value.absent(),
    Value<double?> primaryContentGridCropX = const Value.absent(),
    Value<double?> primaryContentGridCropY = const Value.absent(),
  }) async {
    await into(account).insertOnConflictUpdate(
      AccountCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        uuidContentId0: uuidContentId0,
        uuidContentId1: uuidContentId1,
        uuidContentId2: uuidContentId2,
        uuidContentId3: uuidContentId3,
        uuidContentId4: uuidContentId4,
        uuidContentId5: uuidContentId5,
        primaryContentGridCropSize: primaryContentGridCropSize,
        primaryContentGridCropX: primaryContentGridCropX,
        primaryContentGridCropY: primaryContentGridCropY,
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
