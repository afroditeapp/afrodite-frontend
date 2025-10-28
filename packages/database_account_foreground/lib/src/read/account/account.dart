import 'package:database_account_foreground/src/database.dart';
import 'package:database_utils/database_utils.dart';
import 'package:database_model/database_model.dart' as dbm;
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
    schema.EmailVerified,
  ],
)
class DaoReadAccount extends DatabaseAccessor<AccountForegroundDatabase>
    with _$DaoReadAccountMixin {
  DaoReadAccount(super.db);

  Stream<dbm.AccountState?> watchAccountState() =>
      (select(accountState)..where((t) => t.id.equals(SingleRowTable.ID.value)))
          .map((r) => r.jsonAccountState?.value?.toAccountState())
          .watchSingleOrNull();

  Stream<api.ProfileVisibility?> watchProfileVisibility() =>
      (select(profileVisibility)..where((t) => t.id.equals(SingleRowTable.ID.value)))
          .map((r) => r.jsonProfileVisibility?.value)
          .watchSingleOrNull();

  Stream<api.Permissions?> watchPermissions() =>
      (select(permissions)..where((t) => t.id.equals(SingleRowTable.ID.value)))
          .map((r) => r.jsonPermissions?.value)
          .watchSingleOrNull();

  Stream<String?> watchEmailAddress() =>
      (select(emailAddress)..where((t) => t.id.equals(SingleRowTable.ID.value)))
          .map((r) => r.emailAddress)
          .watchSingleOrNull();

  Stream<bool> watchEmailVerified() =>
      (select(emailVerified)..where((t) => t.id.equals(SingleRowTable.ID.value)))
          .map((r) => r.emailVerified)
          .watchSingleOrNull()
          .map((value) => value ?? true);

  Future<api.AccountId?> localAccountIdToAccountId(dbm.LocalAccountId id) async {
    return (select(
      localAccountId,
    )..where((t) => t.id.equals(id.id))).map((r) => r.uuid).getSingleOrNull();
  }
}
