
import 'package:database_account_foreground/src/database.dart';
import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';
import 'package:utils/utils.dart';
import 'package:openapi/api.dart' as api;

import '../../schema.dart' as schema;

part 'common.g.dart';

@DriftAccessor(
  tables: [
    schema.ServerMaintenance,
    schema.SyncVersion,
    schema.IteratorSessionId,
  ],
)
class DaoWriteCommon extends DatabaseAccessor<AccountForegroundDatabase> with _$DaoWriteCommonMixin {
  DaoWriteCommon(super.db);

  Future<void> setMaintenanceTime({
    required UtcDateTime? time,
  }) async {
    await into(serverMaintenance).insertOnConflictUpdate(
      ServerMaintenanceCompanion.insert(
        id: SingleRowTable.ID,
        serverMaintenanceUnixTime: Value(time),
      ),
    );
  }

  Future<void> setMaintenanceTimeViewed({
    required UtcDateTime time,
  }) async {
    await into(serverMaintenance).insertOnConflictUpdate(
      ServerMaintenanceCompanion.insert(
        id: SingleRowTable.ID,
        serverMaintenanceUnixTimeViewed: Value(time),
      ),
    );
  }

  Future<void> updateSyncVersionAccount(api.AccountSyncVersion value) async {
    await into(syncVersion).insertOnConflictUpdate(
      SyncVersionCompanion.insert(
        id: SingleRowTable.ID,
        syncVersionAccount: Value(value.version),
      ),
    );
  }

  Future<void> updateSyncVersionProfile(api.ProfileSyncVersion value) async {
    await into(syncVersion).insertOnConflictUpdate(
      SyncVersionCompanion.insert(
        id: SingleRowTable.ID,
        syncVersionProfile: Value(value.version),
      ),
    );
  }

  Future<void> updateSyncVersionClientConfig(api.ClientConfigSyncVersion value) async {
    await into(syncVersion).insertOnConflictUpdate(
      SyncVersionCompanion.insert(
        id: SingleRowTable.ID,
        syncVersionClientConfig: Value(value.version),
      ),
    );
  }

  Future<void> updateSyncVersionMediaContent(api.MediaContentSyncVersion value) async {
    await into(syncVersion).insertOnConflictUpdate(
      SyncVersionCompanion.insert(
        id: SingleRowTable.ID,
        syncVersionMediaContent: Value(value.version),
      ),
    );
  }

  Future<void> resetSyncVersions() async {
    await into(syncVersion).insertOnConflictUpdate(
      SyncVersionCompanion.insert(
        id: SingleRowTable.ID,
        syncVersionAccount: Value(null),
        syncVersionProfile: Value(null),
        syncVersionClientConfig: Value(null),
        syncVersionMediaContent: Value(null),
      ),
    );
  }

  Future<void> updateProfileIteratorSessionId(api.ProfileIteratorSessionId value) async {
    await into(iteratorSessionId).insertOnConflictUpdate(
      IteratorSessionIdCompanion.insert(
        id: SingleRowTable.ID,
        profileIteratorSessionId: Value(value),
      ),
    );
  }

  Future<void> updateAutomaticProfileSearchIteratorSessionId(api.AutomaticProfileSearchIteratorSessionId value) async {
    await into(iteratorSessionId).insertOnConflictUpdate(
      IteratorSessionIdCompanion.insert(
        id: SingleRowTable.ID,
        automatiProfileSearchIteratorSessionId: Value(value),
      ),
    );
  }

  Future<void> updateReceivedLikesIteratorSessionId(api.ReceivedLikesIteratorSessionId value) async {
    await into(iteratorSessionId).insertOnConflictUpdate(
      IteratorSessionIdCompanion.insert(
        id: SingleRowTable.ID,
        receivedLikesIteratorSessionId: Value(value),
      ),
    );
  }

  Future<void> updateMatchesIteratorSessionId(api.MatchesIteratorSessionId value) async {
    await into(iteratorSessionId).insertOnConflictUpdate(
      IteratorSessionIdCompanion.insert(
        id: SingleRowTable.ID,
        matchesIteratorSessionId: Value(value),
      ),
    );
  }
}
