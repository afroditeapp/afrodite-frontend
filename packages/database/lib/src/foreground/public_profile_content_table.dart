


import 'package:openapi/api.dart' show AccountId, ContentId;
import 'account_database.dart';

import 'package:drift/drift.dart';
import '../profile_entry.dart';
import '../utils.dart';

part 'public_profile_content_table.g.dart';

class PublicProfileContent extends Table {
  TextColumn get uuidAccountId => text().map(const AccountIdConverter())();
  IntColumn get contentIndex => integer()();

  TextColumn get uuidContentId => text().map(const ContentIdConverter())();
  BoolColumn get contentAccepted => boolean()();
  BoolColumn get primaryContent => boolean()();

  @override
  Set<Column<Object>> get primaryKey => {uuidAccountId, contentIndex};
}

@DriftAccessor(tables: [PublicProfileContent])
class DaoPublicProfileContent extends DatabaseAccessor<AccountDatabase> with _$DaoPublicProfileContentMixin {
  DaoPublicProfileContent(AccountDatabase db) : super(db);

  Future<void> removeProfileContentData(AccountId accountId) async {
    await (delete(publicProfileContent)..where((t) => t.uuidAccountId.equals(accountId.aid)))
      .go();
  }

  Future<void> removeContentStartingFrom(AccountId accountId, int index) async {
    await (delete(publicProfileContent)..where((t) => t.uuidAccountId.equals(accountId.aid) & t.contentIndex.isBiggerOrEqualValue(index)))
      .go();
  }

  Future<void> updateProfileContent(
    AccountId accountId,
    int index,
    ContentId contentId,
    bool accepted,
    bool primary,
  ) async {
    await into(publicProfileContent).insert(
      PublicProfileContentCompanion.insert(
        uuidAccountId: accountId,
        contentIndex: index,
        uuidContentId: contentId,
        contentAccepted: accepted,
        primaryContent: primary,
      ),
      onConflict: DoUpdate((old) => PublicProfileContentCompanion(
        uuidContentId: Value(contentId),
        contentAccepted: Value(accepted),
        primaryContent: Value(primary),
      ),
        target: [publicProfileContent.uuidAccountId, publicProfileContent.contentIndex]
      ),
    );
  }

  Future<ContentIdAndAccepted?> getContent(AccountId accountId, int index) async {
    final r = await (select(publicProfileContent)
      ..where((t) => t.uuidAccountId.equals(accountId.aid) & t.contentIndex.equals(index))
    )
      .getSingleOrNull();

    return _rowToProfileContent(r);
  }

  Stream<ContentIdAndAccepted?> watchContent(AccountId accountId, int index) {
    return (select(publicProfileContent)
      ..where((t) => t.uuidAccountId.equals(accountId.aid) & t.contentIndex.equals(index))
    )
      .map((t) => _rowToProfileContent(t))
      .watchSingleOrNull();
  }

  Stream<List<ContentIdAndAccepted>> watchAllProfileContent(AccountId accountId) {
    return (select(publicProfileContent)
      ..where((t) => t.uuidAccountId.equalsValue(accountId))
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

  ContentIdAndAccepted? _rowToProfileContent(PublicProfileContentData? r) {
    if (r == null) {
      return null;
    }

    return ContentIdAndAccepted(r.uuidContentId, r.contentAccepted, r.primaryContent);
  }
}
