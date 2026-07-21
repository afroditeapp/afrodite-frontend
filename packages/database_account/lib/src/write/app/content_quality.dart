import 'package:database_account/src/database.dart';
import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';
import 'package:utils/utils.dart';

import '../../schema.dart' as schema;

part 'content_quality.g.dart';

@DriftAccessor(tables: [schema.ContentQuality, schema.ContentQualityCleanupState])
class DaoWriteContentQuality extends DatabaseAccessor<AccountDatabase>
    with _$DaoWriteContentQualityMixin {
  DaoWriteContentQuality(super.db);

  static const _staleContentQualityThreshold = Duration(days: 90);

  /// Store or update quality info for a content.
  Future<void> setQualityInfo({
    required String accountId,
    required String contentId,
    required String quality,
    required UtcDateTime lastRequestTime,
  }) async {
    await into(contentQuality).insertOnConflictUpdate(
      ContentQualityCompanion.insert(
        accountId: accountId,
        contentId: contentId,
        quality: quality,
        lastRequestTime: lastRequestTime,
      ),
    );
  }

  /// Cleanup old content quality entries. Should be called periodically.
  Future<int> cleanupStaleContentQualityIfNeeded() async {
    final now = UtcDateTime.now();
    return await transaction(() async {
      final state = await (select(
        contentQualityCleanupState,
      )..where((t) => t.id.equals(SingleRowTable.ID.value))).getSingleOrNull();

      final lastCleanupTime = state?.lastCleanupTime;
      if (lastCleanupTime != null && now.difference(lastCleanupTime) < const Duration(days: 1)) {
        return 0;
      }

      final staleBefore = now.substract(_staleContentQualityThreshold);
      final staleBeforeUnixEpochMs = staleBefore.toUnixEpochMilliseconds();

      final deleted = await (delete(
        contentQuality,
      )..where((t) => t.lastRequestTime.isSmallerOrEqualValue(staleBeforeUnixEpochMs))).go();

      await into(contentQualityCleanupState).insertOnConflictUpdate(
        ContentQualityCleanupStateCompanion.insert(
          id: SingleRowTable.ID,
          lastCleanupTime: Value(now),
        ),
      );

      return deleted;
    });
  }
}
