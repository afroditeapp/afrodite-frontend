
import 'package:database_account_foreground/src/database.dart';
import 'package:drift/drift.dart';
import 'package:openapi/api.dart' as api;

import '../../schema.dart' as schema;

part 'media.g.dart';

@DriftAccessor(
  tables: [
    schema.ProfileContent,
  ]
)
class DaoWriteMedia extends DatabaseAccessor<AccountForegroundDatabase> with _$DaoWriteMediaMixin {
  DaoWriteMedia(super.db);

  Future<void> removeProfileContentData(api.AccountId accountId) async {
    await (delete(profileContent)..where((t) => t.uuidAccountId.equals(accountId.aid)))
      .go();
  }

  Future<void> removeContentStartingFrom(api.AccountId accountId, int index) async {
    await (delete(profileContent)..where((t) => t.uuidAccountId.equals(accountId.aid) & t.contentIndex.isBiggerOrEqualValue(index)))
      .go();
  }

  Future<void> updateProfileContent(
    api.AccountId accountId,
    int index,
    api.ContentId contentId,
    bool accepted,
    bool primary,
  ) async {
    await into(profileContent).insertOnConflictUpdate(
      ProfileContentCompanion.insert(
        uuidAccountId: accountId,
        contentIndex: index,
        uuidContentId: contentId,
        contentAccepted: accepted,
        primaryContent: primary,
      ),
    );
  }
}
