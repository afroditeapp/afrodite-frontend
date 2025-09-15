import 'package:database_account_foreground/src/database.dart';
import 'package:database_model/database_model.dart';
import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';
import 'package:openapi/api.dart' as api;

import '../../schema.dart' as schema;

part 'common.g.dart';

@DriftAccessor(
  tables: [
    schema.ServerMaintenance,
    schema.SyncVersion,
    schema.ReceivedLikesIteratorState,
    schema.ClientLanguageOnServer,
  ],
)
class DaoReadCommon extends DatabaseAccessor<AccountForegroundDatabase> with _$DaoReadCommonMixin {
  DaoReadCommon(super.db);

  Stream<ServerMaintenanceInfo?> watchServerMaintenanceInfo() {
    return (select(serverMaintenance)..where((t) => t.id.equals(SingleRowTable.ID.value))).map((r) {
      return ServerMaintenanceInfo(
        maintenanceLatest: r.serverMaintenanceUnixTime,
        maintenanceViewed: r.serverMaintenanceUnixTimeViewed,
      );
    }).watchSingleOrNull();
  }

  Stream<int?> watchSyncVersionAccount() => _watchColumnSyncVersion((r) => r.syncVersionAccount);
  Stream<int?> watchSyncVersionProfile() => _watchColumnSyncVersion((r) => r.syncVersionProfile);
  Stream<int?> watchSyncVersionMediaContent() =>
      _watchColumnSyncVersion((r) => r.syncVersionMediaContent);
  Stream<int?> watchSyncVersionClientConfig() =>
      _watchColumnSyncVersion((r) => r.syncVersionClientConfig);

  Stream<T?> _watchColumnSyncVersion<T extends Object>(T? Function(SyncVersionData) extractColumn) {
    return (select(
      syncVersion,
    )..where((t) => t.id.equals(SingleRowTable.ID.value))).map(extractColumn).watchSingleOrNull();
  }

  Stream<api.ReceivedLikesIteratorState?> watchReceivedLikesIteratorState() =>
      _watchColumnIteratorState((r) {
        final idAtReset = r.idAtReset;
        if (idAtReset == null) {
          return null;
        } else {
          return api.ReceivedLikesIteratorState(idAtReset: idAtReset, page: r.page);
        }
      });

  Stream<T?> _watchColumnIteratorState<T extends Object>(
    T? Function(ReceivedLikesIteratorStateData) extractColumn,
  ) {
    return (select(
      receivedLikesIteratorState,
    )..where((t) => t.id.equals(SingleRowTable.ID.value))).map(extractColumn).watchSingleOrNull();
  }

  Stream<api.ClientLanguage?> watchClientLanguageOnServer() =>
      _watchColumnClientLanguage((r) => r.clientLanguageOnServer);

  Stream<T?> _watchColumnClientLanguage<T extends Object>(
    T? Function(ClientLanguageOnServerData) extractColumn,
  ) {
    return (select(
      clientLanguageOnServer,
    )..where((t) => t.id.equals(SingleRowTable.ID.value))).map(extractColumn).watchSingleOrNull();
  }
}
