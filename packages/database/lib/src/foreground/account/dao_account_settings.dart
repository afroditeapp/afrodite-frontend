
import '../account_database.dart';

import 'package:drift/drift.dart';

part 'dao_account_settings.g.dart';

@DriftAccessor(tables: [Account])
class DaoAccountSettings extends DatabaseAccessor<AccountDatabase> with _$DaoAccountSettingsMixin, AccountTools {
  DaoAccountSettings(super.db);

  Future<void> updateEmailAddress(String? value) async {
    await into(account).insertOnConflictUpdate(
      AccountCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        accountEmailAddress: Value(value),
      ),
    );
  }

  Stream<String?> watchEmailAddress() =>
    watchColumn((r) => r.accountEmailAddress);
}
