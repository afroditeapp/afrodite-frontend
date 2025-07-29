
import 'package:database/database.dart';
import 'package:database_model/database_model.dart';
import 'package:openapi/api.dart' show GetMediaContentResult;
import 'package:rxdart/rxdart.dart';
import '../account_database.dart';

import 'package:drift/drift.dart';

part 'dao_current_content.g.dart';

@DriftAccessor(tables: [Account])
class DaoCurrentContent extends DatabaseAccessor<AccountDatabase> with _$DaoCurrentContentMixin, AccountTools {
  DaoCurrentContent(super.db);

  Future<void> setMediaContent({
    required GetMediaContentResult info,
  }) async {
    await transaction(() async {
      final securityContent = info.securityContent;
      if (securityContent != null) {
        await db.daoMyMediaContent.updateMyProfileContent(-1, securityContent);
      } else {
        await db.daoMyMediaContent.removeSecurityContent();
      }

      for (final (i, c) in info.profileContent.c.indexed) {
        await db.daoMyMediaContent.updateMyProfileContent(i, c);
      }

      await db.daoMyMediaContent.removeContentStartingFrom(info.profileContent.c.length);

      final content = info.profileContent;
      await into(account).insertOnConflictUpdate(
        AccountCompanion.insert(
          id: ACCOUNT_DB_DATA_ID,
          primaryContentGridCropSize: Value(content.gridCropSize),
          primaryContentGridCropX: Value(content.gridCropX),
          primaryContentGridCropY: Value(content.gridCropY),
          profileContentVersion: Value(info.profileContentVersion),
          syncVersionMediaContent: Value(info.syncVersion.version),
        ),
      );
    });
  }

  Stream<MyContent?> watchCurrentSecurityContent() =>
    db.daoMyMediaContent.watchContent(-1);

  Stream<PrimaryProfileContent?> watchPrimaryProfileContent() =>
    Rx.combineLatest2(
      watchColumn((r) => r),
      db.daoMyMediaContent.watchContent(0),
      (r, c) {
        return PrimaryProfileContent(
          content0: c,
          gridCropSize: r?.primaryContentGridCropSize,
          gridCropX: r?.primaryContentGridCropX,
          gridCropY: r?.primaryContentGridCropY,
        );
      }
    );
}

class PrimaryProfileContent {
  final MyContent? content0;
  final double? gridCropSize;
  final double? gridCropX;
  final double? gridCropY;
  const PrimaryProfileContent({
    required this.content0,
    required this.gridCropSize,
    required this.gridCropX,
    required this.gridCropY,
  });
}
