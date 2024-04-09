
import 'package:openapi/api.dart' show AccountId, ProfileContent, ProfileVisibility, Location;
import 'package:openapi/api.dart' as api;
import 'package:pihka_frontend/database/account_database.dart';

import 'package:drift/drift.dart';

part 'dao_initial_sync.g.dart';

@DriftAccessor(tables: [Account])
class DaoInitialSync extends DatabaseAccessor<AccountDatabase> with _$DaoInitialSyncMixin, AccountTools {
  DaoInitialSync(AccountDatabase db) : super(db);

  Future<void> updateLoginSyncDone(bool value) async {
    await into(account).insertOnConflictUpdate(
      AccountCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        initialSyncDoneLoginRepository: Value(value),
      ),
    );
  }

  Future<void> updateAccountSyncDone(bool value) async {
    await into(account).insertOnConflictUpdate(
      AccountCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        initialSyncDoneAccountRepository: Value(value),
      ),
    );
  }

  Future<void> updateMediaSyncDone(bool value) async {
    await into(account).insertOnConflictUpdate(
      AccountCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        initialSyncDoneMediaRepository: Value(value),
      ),
    );
  }

  Future<void> updateProfileSyncDone(bool value) async {
    await into(account).insertOnConflictUpdate(
      AccountCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        initialSyncDoneProfileRepository: Value(value),
      ),
    );
  }

  Future<void> updateChatSyncDone(bool value) async {
    await into(account).insertOnConflictUpdate(
      AccountCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        initialSyncDoneChatRepository: Value(value),
      ),
    );
  }

  Stream<bool?> watchLoginSyncDone() =>
    watchColumn((r) => r.initialSyncDoneLoginRepository);
  Stream<bool?> watchAccountSyncDone() =>
    watchColumn((r) => r.initialSyncDoneAccountRepository);
  Stream<bool?> watchMediaSyncDone() =>
    watchColumn((r) => r.initialSyncDoneMediaRepository);
  Stream<bool?> watchProfileSyncDone() =>
    watchColumn((r) => r.initialSyncDoneProfileRepository);
  Stream<bool?> watchChatSyncDone() =>
    watchColumn((r) => r.initialSyncDoneChatRepository);
}
