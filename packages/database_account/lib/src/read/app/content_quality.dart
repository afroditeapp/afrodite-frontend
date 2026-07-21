import 'package:database_account/src/database.dart';
import 'package:database_account/src/schema.dart' as schema;
import 'package:drift/drift.dart';

part 'content_quality.g.dart';

@DriftAccessor(tables: [schema.ContentQuality])
class DaoReadContentQuality extends DatabaseAccessor<AccountDatabase>
    with _$DaoReadContentQualityMixin {
  DaoReadContentQuality(super.db);

  /// Get stored quality info for a content, or null if unknown.
  Future<ContentQualityData?> getQualityInfo(String accountId, String contentId) async {
    return await (select(contentQuality)
          ..where((t) => t.accountId.equals(accountId) & t.contentId.equals(contentId)))
        .getSingleOrNull();
  }
}
