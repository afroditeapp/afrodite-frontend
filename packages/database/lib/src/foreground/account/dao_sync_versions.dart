
import 'package:openapi/api.dart' show
  AccountSyncVersion,
  ProfileSyncVersion,
  ClientConfigSyncVersion;

import '../account_database.dart';

import 'package:drift/drift.dart';

part 'dao_sync_versions.g.dart';

@DriftAccessor(tables: [Account])
class DaoSyncVersions extends DatabaseAccessor<AccountDatabase> with _$DaoSyncVersionsMixin, AccountTools {
  DaoSyncVersions(super.db);

  Future<void> updateSyncVersionAccount(AccountSyncVersion value) async {
    await into(account).insertOnConflictUpdate(
      AccountCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        syncVersionAccount: Value(value.version),
      ),
    );
  }

  Future<void> updateSyncVersionProfile(ProfileSyncVersion value) async {
    await into(account).insertOnConflictUpdate(
      AccountCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        syncVersionProfile: Value(value.version),
      ),
    );
  }

  Future<void> updateSyncVersionClientConfig(ClientConfigSyncVersion value) async {
    await into(account).insertOnConflictUpdate(
      AccountCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        syncVersionClientConfig: Value(value.version),
      ),
    );
  }

  Future<void> resetSyncVersions() async {
    await into(account).insertOnConflictUpdate(
      AccountCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        syncVersionAccount: Value(null),
        syncVersionProfile: Value(null),
        syncVersionClientConfig: Value(null),
      ),
    );
  }

  Stream<int?> watchSyncVersionAccount() =>
    watchColumn((r) => r.syncVersionAccount);
  Stream<int?> watchSyncVersionProfile() =>
    watchColumn((r) => r.syncVersionProfile);
  Stream<int?> watchSyncVersionMediaContent() =>
    watchColumn((r) => r.syncVersionMediaContent);
  Stream<int?> watchSyncVersionClientConfig() =>
    watchColumn((r) => r.syncVersionClientConfig);
}
