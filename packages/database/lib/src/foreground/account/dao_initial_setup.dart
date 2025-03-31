
import '../account_database.dart';

import 'package:drift/drift.dart';

part 'dao_initial_setup.g.dart';

@DriftAccessor(tables: [Account])
class DaoInitialSetup extends DatabaseAccessor<AccountDatabase> with _$DaoInitialSetupMixin, AccountTools {
  DaoInitialSetup(super.db);

  Future<void> updateInitialSetupSkipped(
    bool skipped,
  ) async {
    await into(account).insertOnConflictUpdate(
      AccountCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        initialSetupSkipped: Value(skipped),
      ),
    );
  }

  Stream<bool?> watchInitialSetupSkipped() =>
    watchColumn((r) => r.initialSetupSkipped);
}
