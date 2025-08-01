
import 'package:database_account_foreground/src/database.dart';
import 'package:database_model/database_model.dart';
import 'package:drift/drift.dart';
import 'package:openapi/api.dart' as api;

import '../../schema.dart' as schema;

part 'media.g.dart';

@DriftAccessor(
  tables: [
    schema.ProfileContent,
  ]
)
class DaoReadMedia extends DatabaseAccessor<AccountForegroundDatabase> with _$DaoReadMediaMixin {
  DaoReadMedia(super.db);

  Future<ContentIdAndAccepted?> getContent(api.AccountId accountId, int index) async {
    final r = await (select(profileContent)
      ..where((t) => t.accountId.equals(accountId.aid) & t.contentIndex.equals(index))
    )
      .getSingleOrNull();

    return _rowToProfileContent(r);
  }

  Stream<ContentIdAndAccepted?> watchContent(api.AccountId accountId, int index) {
    return (select(profileContent)
      ..where((t) => t.accountId.equals(accountId.aid) & t.contentIndex.equals(index))
    )
      .map((t) => _rowToProfileContent(t))
      .watchSingleOrNull();
  }

  Stream<List<ContentIdAndAccepted>> watchAllProfileContent(api.AccountId accountId) {
    return (select(profileContent)
      ..where((t) => t.accountId.equalsValue(accountId))
      ..orderBy([
        (t) => OrderingTerm(
          expression: t.contentIndex,
          mode: OrderingMode.asc,
        ),
      ])
    )
      .map((t) => _rowToProfileContent(t))
      .watch()
      .map((l) => l.nonNulls.toList());
  }

  ContentIdAndAccepted? _rowToProfileContent(ProfileContentData? r) {
    if (r == null) {
      return null;
    }

    return ContentIdAndAccepted(r.contentId, r.contentAccepted, r.primaryContent);
  }
}
