
import 'package:database_account_foreground/src/database.dart';
import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';
import 'package:openapi/api.dart' as api;

import '../../schema.dart' as schema;

part 'login_session.g.dart';

@DriftAccessor(
  tables: [
    schema.AccountId,
    schema.ClientId,
    schema.LoginSessionTokens,
  ]
)
class DaoReadLoginSession extends DatabaseAccessor<AccountForegroundDatabase> with _$DaoReadLoginSessionMixin {
  DaoReadLoginSession(super.db);

  Stream<api.AccountId?> watchAccountId() =>
    (select(accountId)..where((t) => t.id.equals(SingleRowTable.ID.value)))
      .map((r) => r.uuidAccountId)
      .watchSingleOrNull();

  Stream<api.ClientId?> watchClientId() =>
    (select(clientId)..where((t) => t.id.equals(SingleRowTable.ID.value)))
      .map((r) => r.clientId)
      .watchSingleOrNull();

  Stream<api.RefreshToken?> watchRefreshTokenAccount() =>
    _watchColumnLoginSessionTokens((r) => r.refreshTokenAccount);

  Stream<api.RefreshToken?> watchRefreshTokenMedia() =>
    _watchColumnLoginSessionTokens((r) => r.refreshTokenMedia);

  Stream<api.RefreshToken?> watchRefreshTokenProfile() =>
    _watchColumnLoginSessionTokens((r) => r.refreshTokenProfile);

  Stream<api.RefreshToken?> watchRefreshTokenChat() =>
    _watchColumnLoginSessionTokens((r) => r.refreshTokenChat);

  Stream<api.AccessToken?> watchAccessTokenAccount() =>
    _watchColumnLoginSessionTokens((r) => r.accessTokenAccount);

  Stream<api.AccessToken?> watchAccessTokenMedia() =>
    _watchColumnLoginSessionTokens((r) => r.accessTokenMedia);

  Stream<api.AccessToken?> watchAccessTokenProfile() =>
    _watchColumnLoginSessionTokens((r) => r.accessTokenProfile);

  Stream<api.AccessToken?> watchAccessTokenChat() =>
    _watchColumnLoginSessionTokens((r) => r.accessTokenChat);

  Stream<T?> _watchColumnLoginSessionTokens<T extends Object>(T? Function(LoginSessionToken) extractColumn) {
    return (select(loginSessionTokens)..where((t) => t.id.equals(SingleRowTable.ID.value)))
      .map(extractColumn)
      .watchSingleOrNull();
  }
}
