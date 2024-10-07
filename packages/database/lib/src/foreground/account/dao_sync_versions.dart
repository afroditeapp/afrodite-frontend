
import 'package:openapi/api.dart' show
  AccountSyncVersion,
  ProfileSyncVersion,
  SentBlocksSyncVersion,
  ProfileAttributesSyncVersion;

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

  Future<void> updateSyncVersionSentBlocks(SentBlocksSyncVersion value) async {
    await into(account).insertOnConflictUpdate(
      AccountCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        syncVersionSentBlocks: Value(value.version),
      ),
    );
  }

  Future<void> updateSyncVersionAvailableProfileAttributes(ProfileAttributesSyncVersion value) async {
    await into(account).insertOnConflictUpdate(
      AccountCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        syncVersionAvailableProfileAttributes: Value(value.version),
      ),
    );
  }

  Stream<int?> watchSyncVersionAccount() =>
    watchColumn((r) => r.syncVersionAccount);
  Stream<int?> watchSyncVersionProfile() =>
    watchColumn((r) => r.syncVersionProfile);
  Stream<int?> watchSyncVersionReceivedBlocks() =>
    watchColumn((r) => r.syncVersionReceivedBlocks);
  Stream<int?> watchSyncVersionSentBlocks() =>
    watchColumn((r) => r.syncVersionSentBlocks);
  Stream<int?> watchSyncVersionAvailableProfileAttributes() =>
    watchColumn((r) => r.syncVersionAvailableProfileAttributes);
}
