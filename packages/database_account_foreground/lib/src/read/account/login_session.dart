import 'package:database_account_foreground/src/database.dart';
import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';
import 'package:openapi/api.dart' as api;

import '../../schema.dart' as schema;

part 'login_session.g.dart';

@DriftAccessor(tables: [schema.AccountId, schema.LoginSessionTokens])
class DaoReadLoginSession extends DatabaseAccessor<AccountForegroundDatabase>
    with _$DaoReadLoginSessionMixin {
  DaoReadLoginSession(super.db);

  Stream<api.AccountId?> watchAccountId() =>
      (select(accountId)..where((t) => t.id.equals(SingleRowTable.ID.value)))
          .map((r) => r.accountId)
          .watchSingleOrNull();

  Stream<api.RefreshToken?> watchRefreshToken() =>
      _watchColumnLoginSessionTokens((r) => r.refreshToken);

  Stream<api.AccessToken?> watchAccessToken() =>
      _watchColumnLoginSessionTokens((r) => r.accessToken);

  Stream<T?> _watchColumnLoginSessionTokens<T extends Object>(
    T? Function(LoginSessionToken) extractColumn,
  ) {
    return (select(
      loginSessionTokens,
    )..where((t) => t.id.equals(SingleRowTable.ID.value))).map(extractColumn).watchSingleOrNull();
  }
}
