
import 'package:database_account_foreground/src/database.dart';
import 'package:drift/drift.dart';
import 'package:database_converter/database_converter.dart';
import 'package:openapi/api.dart' as api;

import '../../schema.dart' as schema;

part 'my_media.g.dart';

@DriftAccessor(
  tables: [
    schema.MyMediaContent,
  ]
)
class DaoWriteMyMedia extends DatabaseAccessor<AccountForegroundDatabase> with _$DaoWriteMyMediaMixin {
  DaoWriteMyMedia(super.db);

  Future<void> removeMySecurityContent() async {
    await (delete(myMediaContent)..where((t) => t.contentIndex.equals(-1)))
      .go();
  }

  Future<void> removeMyContentStartingFrom(int index) async {
    await (delete(myMediaContent)..where((t) => t.contentIndex.isBiggerOrEqualValue(index)))
      .go();
  }

  Future<void> updateMyProfileContent(
    int index,
    api.ContentInfoWithFd content,
  ) async {
    await into(myMediaContent).insertOnConflictUpdate(
      MyMediaContentCompanion.insert(
        contentIndex: Value(index),
        uuidContentId: content.cid,
        faceDetected: content.fd,
        moderationState: Value(content.state.toEnumString()),
        contentModerationRejectedCategory: Value(content.rejectedReasonCategory),
        contentModerationRejectedDetails: Value(content.rejectedReasonDetails),
      ),
    );
  }

  Future<void> setMyMediaContent({
    required api.GetMediaContentResult info,
  }) async {
    await transaction(() async {
      final securityContent = info.securityContent;
      if (securityContent != null) {
        await updateMyProfileContent(-1, securityContent);
      } else {
        await removeMySecurityContent();
      }

      for (final (i, c) in info.profileContent.c.indexed) {
        await updateMyProfileContent(i, c);
      }

      await removeMyContentStartingFrom(info.profileContent.c.length);

      await db.write.myProfile.dbInternalMethodUpdateContentInfo(info: info);
      await db.write.common.updateSyncVersionMediaContent(info.syncVersion);
    });
  }
}
