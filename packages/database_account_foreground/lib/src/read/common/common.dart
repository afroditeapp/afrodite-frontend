
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
    schema.IteratorSessionId,
    schema.ClientLanguageOnServer,
  ]
)
class DaoReadCommon extends DatabaseAccessor<AccountForegroundDatabase> with _$DaoReadCommonMixin {
  DaoReadCommon(super.db);

  Stream<ServerMaintenanceInfo?> watchServerMaintenanceInfo() {
    return (select(serverMaintenance)
      ..where((t) => t.id.equals(SingleRowTable.ID.value))
    )
      .map((r) {
        return ServerMaintenanceInfo(
          maintenanceLatest: r.serverMaintenanceUnixTime,
          maintenanceViewed: r.serverMaintenanceUnixTimeViewed,
        );
      })
      .watchSingleOrNull();
  }

  Stream<int?> watchSyncVersionAccount() =>
    _watchColumnSyncVersion((r) => r.syncVersionAccount);
  Stream<int?> watchSyncVersionProfile() =>
    _watchColumnSyncVersion((r) => r.syncVersionProfile);
  Stream<int?> watchSyncVersionMediaContent() =>
    _watchColumnSyncVersion((r) => r.syncVersionMediaContent);
  Stream<int?> watchSyncVersionClientConfig() =>
    _watchColumnSyncVersion((r) => r.syncVersionClientConfig);

  Stream<T?> _watchColumnSyncVersion<T extends Object>(T? Function(SyncVersionData) extractColumn) {
    return (select(syncVersion)..where((t) => t.id.equals(SingleRowTable.ID.value)))
      .map(extractColumn)
      .watchSingleOrNull();
  }

  Stream<api.ProfileIteratorSessionId?> watchProfileSessionId() =>
    _watchColumnIteratorSessionId((r) => r.profileIteratorSessionId);

  Stream<api.AutomaticProfileSearchIteratorSessionId?> watchAutomaticProfileSearchSessionId() =>
    _watchColumnIteratorSessionId((r) => r.automatiProfileSearchIteratorSessionId);

  Stream<api.ReceivedLikesIteratorSessionId?> watchReceivedLikesSessionId() =>
    _watchColumnIteratorSessionId((r) => r.receivedLikesIteratorSessionId);

  Stream<api.MatchesIteratorSessionId?> watchMatchesSessionId() =>
    _watchColumnIteratorSessionId((r) => r.matchesIteratorSessionId);

  Stream<T?> _watchColumnIteratorSessionId<T extends Object>(T? Function(IteratorSessionIdData) extractColumn) {
    return (select(iteratorSessionId)..where((t) => t.id.equals(SingleRowTable.ID.value)))
      .map(extractColumn)
      .watchSingleOrNull();
  }

  Stream<api.ClientLanguage?> watchClientLanguageOnServer() =>
    _watchColumnClientLanguage((r) => r.clientLanguageOnServer);

  Stream<T?> _watchColumnClientLanguage<T extends Object>(T? Function(ClientLanguageOnServerData) extractColumn) {
    return (select(clientLanguageOnServer)..where((t) => t.id.equals(SingleRowTable.ID.value)))
      .map(extractColumn)
      .watchSingleOrNull();
  }
}
