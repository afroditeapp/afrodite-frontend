

import '../account_database.dart';

import 'package:drift/drift.dart';



part 'dao_tokens.g.dart';


@DriftAccessor(tables: [Account])
class DaoTokens extends DatabaseAccessor<AccountDatabase> with _$DaoTokensMixin, AccountTools {
  DaoTokens(super.db);


   Future<void> updateRefreshTokenAccount(String? token) async {
    await into(account).insertOnConflictUpdate(
      AccountCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        refreshTokenAccount: Value(token),
      ),
    );
  }

  Future<void> updateRefreshTokenMedia(String? token) async {
    await into(account).insertOnConflictUpdate(
      AccountCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        refreshTokenMedia: Value(token),
      ),
    );
  }

  Future<void> updateRefreshTokenProfile(String? token) async {
    await into(account).insertOnConflictUpdate(
      AccountCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        refreshTokenProfile: Value(token),
      ),
    );
  }

  Future<void> updateRefreshTokenChat(String? token) async {
    await into(account).insertOnConflictUpdate(
      AccountCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        refreshTokenChat: Value(token),
      ),
    );
  }

  Future<void> updateAccessTokenAccount(String? token) async {
    await into(account).insertOnConflictUpdate(
      AccountCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        accessTokenAccount: Value(token),
      ),
    );
  }

  Future<void> updateAccessTokenMedia(String? token) async {
    await into(account).insertOnConflictUpdate(
      AccountCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        accessTokenMedia: Value(token),
      ),
    );
  }

  Future<void> updateAccessTokenProfile(String? token) async {
    await into(account).insertOnConflictUpdate(
      AccountCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        accessTokenProfile: Value(token),
      ),
    );
  }

  Future<void> updateAccessTokenChat(String? token) async {
    await into(account).insertOnConflictUpdate(
      AccountCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        accessTokenChat: Value(token),
      ),
    );
  }

  Stream<String?> watchRefreshTokenAccount() =>
    watchColumn((r) => r.refreshTokenAccount);

  Stream<String?> watchRefreshTokenMedia() =>
    watchColumn((r) => r.refreshTokenMedia);

  Stream<String?> watchRefreshTokenProfile() =>
    watchColumn((r) => r.refreshTokenProfile);

  Stream<String?> watchRefreshTokenChat() =>
    watchColumn((r) => r.refreshTokenChat);

  Stream<String?> watchAccessTokenAccount() =>
    watchColumn((r) => r.accessTokenAccount);

  Stream<String?> watchAccessTokenMedia() =>
    watchColumn((r) => r.accessTokenMedia);

  Stream<String?> watchAccessTokenProfile() =>
    watchColumn((r) => r.accessTokenProfile);

  Stream<String?> watchAccessTokenChat() =>
    watchColumn((r) => r.accessTokenChat);
}
