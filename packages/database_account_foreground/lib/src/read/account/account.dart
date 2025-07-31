
import 'package:database_account_foreground/src/database.dart';
import 'package:database_utils/database_utils.dart';
import 'package:database_model/database_model.dart' as dbm;
import 'package:drift/drift.dart';
import 'package:openapi/api.dart' as api;

import '../../schema.dart' as schema;

part 'account.g.dart';

@DriftAccessor(
  tables: [
    schema.AccountState,
    schema.Permissions,
    schema.ProfileVisibility,
    schema.AccountEmailAddress,
  ]
)
class DaoReadAccount extends DatabaseAccessor<AccountForegroundDatabase> with _$DaoReadAccountMixin {
  DaoReadAccount(super.db);

  Stream<dbm.AccountState?> watchAccountState() =>
    (select(accountState)..where((t) => t.id.equals(SingleRowTable.ID.value)))
      .map((r) => r.jsonAccountState?.toAccountStateContainer()?.toAccountState())
      .watchSingleOrNull();

  Stream<api.ProfileVisibility?> watchProfileVisibility() =>
    (select(profileVisibility)..where((t) => t.id.equals(SingleRowTable.ID.value)))
      .map((r) => r.jsonProfileVisibility?.toProfileVisibility())
      .watchSingleOrNull();

  Stream<api.Permissions?> watchPermissions() =>
    (select(permissions)..where((t) => t.id.equals(SingleRowTable.ID.value)))
      .map((r) => r.jsonPermissions?.toPermissions())
      .watchSingleOrNull();

  Stream<String?> watchEmailAddress() =>
    (select(accountEmailAddress)..where((t) => t.id.equals(SingleRowTable.ID.value)))
      .map((r) => r.accountEmailAddress)
      .watchSingleOrNull();
}
