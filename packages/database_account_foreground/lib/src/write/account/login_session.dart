
import 'package:async/async.dart';
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
class DaoWriteLoginSession extends DatabaseAccessor<AccountForegroundDatabase> with _$DaoWriteLoginSessionMixin {
  DaoWriteLoginSession(super.db);

  Future<void> setAccountIdIfNull(api.AccountId id) async {
    await transaction(() async {
      final currentAccountId = await db.read.loginSession.watchAccountId().firstOrNull;
      if (currentAccountId == null) {
        await into(accountId).insertOnConflictUpdate(
          AccountIdCompanion.insert(
            id: SingleRowTable.ID,
            uuidAccountId: Value(id),
          ),
        );
      }
    });
  }

  Future<void> updateClientIdIfNull(api.ClientId value) async {
    await transaction(() async {
      final currentClientId = await db.read.loginSession.watchClientId().firstOrNull;
      if (currentClientId == null) {
        await into(clientId).insertOnConflictUpdate(
          ClientIdCompanion.insert(
            id: SingleRowTable.ID,
            clientId: Value(value),
          ),
        );
      }
    });
  }

  Future<void> updateRefreshTokenAccount(String? token) async {
    await into(loginSessionTokens).insertOnConflictUpdate(
      LoginSessionTokensCompanion.insert(
        id: SingleRowTable.ID,
        refreshTokenAccount: Value(token),
      ),
    );
  }

  Future<void> updateRefreshTokenMedia(String? token) async {
    await into(loginSessionTokens).insertOnConflictUpdate(
      LoginSessionTokensCompanion.insert(
        id: SingleRowTable.ID,
        refreshTokenMedia: Value(token),
      ),
    );
  }

  Future<void> updateRefreshTokenProfile(String? token) async {
    await into(loginSessionTokens).insertOnConflictUpdate(
      LoginSessionTokensCompanion.insert(
        id: SingleRowTable.ID,
        refreshTokenProfile: Value(token),
      ),
    );
  }

  Future<void> updateRefreshTokenChat(String? token) async {
    await into(loginSessionTokens).insertOnConflictUpdate(
      LoginSessionTokensCompanion.insert(
        id: SingleRowTable.ID,
        refreshTokenChat: Value(token),
      ),
    );
  }

  Future<void> updateAccessTokenAccount(String? token) async {
    await into(loginSessionTokens).insertOnConflictUpdate(
      LoginSessionTokensCompanion.insert(
        id: SingleRowTable.ID,
        accessTokenAccount: Value(token),
      ),
    );
  }

  Future<void> updateAccessTokenMedia(String? token) async {
    await into(loginSessionTokens).insertOnConflictUpdate(
      LoginSessionTokensCompanion.insert(
        id: SingleRowTable.ID,
        accessTokenMedia: Value(token),
      ),
    );
  }

  Future<void> updateAccessTokenProfile(String? token) async {
    await into(loginSessionTokens).insertOnConflictUpdate(
      LoginSessionTokensCompanion.insert(
        id: SingleRowTable.ID,
        accessTokenProfile: Value(token),
      ),
    );
  }

  Future<void> updateAccessTokenChat(String? token) async {
    await into(loginSessionTokens).insertOnConflictUpdate(
      LoginSessionTokensCompanion.insert(
        id: SingleRowTable.ID,
        accessTokenChat: Value(token),
      ),
    );
  }
}
