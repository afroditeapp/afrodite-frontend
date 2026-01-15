import 'package:database_account/src/database.dart';
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
    schema.ReceivedLikesIteratorState,
    schema.ClientLanguageOnServer,
    schema.NewReceivedLikesCount,
  ],
)
class DaoWriteCommon extends DatabaseAccessor<AccountDatabase> with _$DaoWriteCommonMixin {
  DaoWriteCommon(super.db);

  Future<void> setMaintenanceTime({required UtcDateTime? start, required UtcDateTime? end}) async {
    await into(serverMaintenance).insertOnConflictUpdate(
      ServerMaintenanceCompanion.insert(
        id: SingleRowTable.ID,
        startTime: Value(start),
        endTime: Value(end),
      ),
    );
  }

  Future<void> setMaintenanceTimeViewed({required UtcDateTime time}) async {
    await into(serverMaintenance).insertOnConflictUpdate(
      ServerMaintenanceCompanion.insert(id: SingleRowTable.ID, infoViewed: Value(time)),
    );
  }

  Future<void> updateSyncVersionAccount(api.AccountSyncVersion value) async {
    await into(syncVersion).insertOnConflictUpdate(
      SyncVersionCompanion.insert(id: SingleRowTable.ID, syncVersionAccount: Value(value.version)),
    );
  }

  Future<void> updateSyncVersionProfile(api.ProfileSyncVersion value) async {
    await into(syncVersion).insertOnConflictUpdate(
      SyncVersionCompanion.insert(id: SingleRowTable.ID, syncVersionProfile: Value(value.version)),
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

  Future<void> updateReceivedLikesIteratorState(api.ReceivedLikesIteratorState value) async {
    await into(receivedLikesIteratorState).insertOnConflictUpdate(
      ReceivedLikesIteratorStateCompanion.insert(
        id: SingleRowTable.ID,
        idAtReset: Value(value.idAtReset),
        page: Value(value.page),
      ),
    );
  }

  Future<void> updateReceivedLikesIteratorStatePageValue(int value) async {
    await into(receivedLikesIteratorState).insertOnConflictUpdate(
      ReceivedLikesIteratorStateCompanion.insert(id: SingleRowTable.ID, page: Value(value)),
    );
  }

  Future<void> updateClientLanguageOnServer(api.ClientLanguage? value) async {
    await into(clientLanguageOnServer).insertOnConflictUpdate(
      ClientLanguageOnServerCompanion.insert(
        id: SingleRowTable.ID,
        clientLanguageOnServer: Value(value),
      ),
    );
  }

  Future<void> updateSyncVersionReceivedLikes(api.NewReceivedLikesCountResult value) async {
    await into(newReceivedLikesCount).insertOnConflictUpdate(
      NewReceivedLikesCountCompanion.insert(
        id: SingleRowTable.ID,
        syncVersionReceivedLikes: Value(value.v.version),
        newReceivedLikesCount: Value(value.c),
        latestReceivedLikeId: Value(value.l),
      ),
    );
  }

  Future<void> resetReceivedLikesSyncVersion() async {
    await into(newReceivedLikesCount).insertOnConflictUpdate(
      NewReceivedLikesCountCompanion.insert(
        id: SingleRowTable.ID,
        syncVersionReceivedLikes: Value(null),
      ),
    );
  }
}
