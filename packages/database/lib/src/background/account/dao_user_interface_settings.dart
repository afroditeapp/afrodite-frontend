
import '../account_database.dart';

import 'package:drift/drift.dart';

part 'dao_user_interface_settings.g.dart';

@DriftAccessor(tables: [AccountBackground])
class DaoUserInterfaceSettings extends DatabaseAccessor<AccountBackgroundDatabase> with _$DaoUserInterfaceSettingsMixin, AccountBackgroundTools {
  DaoUserInterfaceSettings(super.db);

  Future<void> updateShowNonAcceptedProfileNames(bool value) async {
    await into(accountBackground).insertOnConflictUpdate(
      AccountBackgroundCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        userInterfaceSettingShowNonAcceptedProfileNames: Value(value),
      ),
    );
  }

  Stream<bool?> watchShowNonAcceptedProfileNames() =>
    watchColumn((r) => r.userInterfaceSettingShowNonAcceptedProfileNames);
}
