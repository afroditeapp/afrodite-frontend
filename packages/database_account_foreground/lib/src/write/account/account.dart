import 'package:database_account_foreground/src/database.dart';
import 'package:database_model/database_model.dart' as dbm;
import 'package:database_utils/database_utils.dart';
import 'package:database_converter/database_converter.dart';
import 'package:drift/drift.dart';
import 'package:openapi/api.dart' as api;

import '../../schema.dart' as schema;

part 'account.g.dart';

@DriftAccessor(
  tables: [
    schema.LocalAccountId,
    schema.AccountState,
    schema.Permissions,
    schema.ProfileVisibility,
    schema.EmailAddress,
  ],
)
class DaoWriteAccount extends DatabaseAccessor<AccountForegroundDatabase>
    with _$DaoWriteAccountMixin {
  DaoWriteAccount(super.db);

  Future<void> updateAccountState(api.Account value) async {
    await transaction(() async {
      await into(accountState).insertOnConflictUpdate(
        AccountStateCompanion.insert(
          id: SingleRowTable.ID,
          jsonAccountState: Value(value.state.toJsonObject()),
        ),
      );
      await into(permissions).insertOnConflictUpdate(
        PermissionsCompanion.insert(
          id: SingleRowTable.ID,
          jsonPermissions: Value(value.permissions.toJsonObject()),
        ),
      );
      await into(profileVisibility).insertOnConflictUpdate(
        ProfileVisibilityCompanion.insert(
          id: SingleRowTable.ID,
          jsonProfileVisibility: Value(value.visibility.toEnumString()),
        ),
      );
      await db.write.common.updateSyncVersionAccount(value.syncVersion);
    });
  }

  Future<void> updateEmailAddress(String? value) async {
    await into(emailAddress).insertOnConflictUpdate(
      EmailAddressCompanion.insert(id: SingleRowTable.ID, emailAddress: Value(value)),
    );
  }

  Future<dbm.LocalAccountId> createLocalAccountIdIfNeeded(api.AccountId value) async {
    return await transaction(() async {
      final localId = await (select(
        localAccountId,
      )..where((t) => t.uuid.equals(value.aid))).map((r) => r.id).getSingleOrNull();
      if (localId != null) {
        return localId;
      }
      final r = await into(
        localAccountId,
      ).insertReturning(LocalAccountIdCompanion.insert(uuid: value));
      return r.id;
    });
  }
}
