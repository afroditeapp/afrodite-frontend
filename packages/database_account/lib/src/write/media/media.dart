import 'package:database_account/src/database.dart';
import 'package:drift/drift.dart';
import 'package:openapi/api.dart' as api;

import '../../schema.dart' as schema;

part 'media.g.dart';

@DriftAccessor(tables: [schema.ProfileContent])
class DaoWriteMedia extends DatabaseAccessor<AccountDatabase> with _$DaoWriteMediaMixin {
  DaoWriteMedia(super.db);

  Future<void> removeProfileContentData(api.AccountId accountId) async {
    await (delete(profileContent)..where((t) => t.accountId.equals(accountId.aid))).go();
  }

  Future<void> removeContentStartingFrom(api.AccountId accountId, int index) async {
    await (delete(profileContent)..where(
          (t) => t.accountId.equals(accountId.aid) & t.contentIndex.isBiggerOrEqualValue(index),
        ))
        .go();
  }

  Future<void> updateProfileContent(
    api.AccountId accountId,
    int index,
    api.ContentId contentId,
    bool accepted,
    bool faceDetected,
  ) async {
    await into(profileContent).insertOnConflictUpdate(
      ProfileContentCompanion.insert(
        accountId: accountId,
        contentIndex: index,
        contentId: contentId,
        contentAccepted: accepted,
        faceDetected: faceDetected,
      ),
    );
  }
}
