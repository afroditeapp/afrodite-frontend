import 'package:async/async.dart';
import 'package:database_account_foreground/src/database.dart';
import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';
import 'package:openapi/api.dart' as api;

import '../../schema.dart' as schema;

part 'login_session.g.dart';

@DriftAccessor(tables: [schema.AccountId, schema.ClientId, schema.LoginSessionTokens])
class DaoWriteLoginSession extends DatabaseAccessor<AccountForegroundDatabase>
    with _$DaoWriteLoginSessionMixin {
  DaoWriteLoginSession(super.db);

  Future<void> setAccountIdIfNull(api.AccountId id) async {
    await transaction(() async {
      final currentAccountId = await db.read.loginSession.watchAccountId().firstOrNull;
      if (currentAccountId == null) {
        await into(
          accountId,
        ).insertOnConflictUpdate(AccountIdCompanion.insert(id: SingleRowTable.ID, accountId: id));
      }
    });
  }

  Future<void> updateClientIdIfNull(api.ClientId value) async {
    await transaction(() async {
      final currentClientId = await db.read.loginSession.watchClientId().firstOrNull;
      if (currentClientId == null) {
        await into(clientId).insertOnConflictUpdate(
          ClientIdCompanion.insert(id: SingleRowTable.ID, clientId: Value(value)),
        );
      }
    });
  }

  Future<void> updateRefreshToken(api.RefreshToken? token) async {
    await into(loginSessionTokens).insertOnConflictUpdate(
      LoginSessionTokensCompanion.insert(id: SingleRowTable.ID, refreshToken: Value(token)),
    );
  }

  Future<void> updateAccessToken(api.AccessToken? token) async {
    await into(loginSessionTokens).insertOnConflictUpdate(
      LoginSessionTokensCompanion.insert(id: SingleRowTable.ID, accessToken: Value(token)),
    );
  }
}
