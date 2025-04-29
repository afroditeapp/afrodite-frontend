import 'dart:async';

import 'package:database/database.dart';
import 'package:flutter/foundation.dart';
import 'package:openapi/api.dart';
import 'package:openapi/manual_additions.dart';
import 'package:app/api/api_manager.dart';
import 'package:app/database/account_database_manager.dart';
import 'package:app/utils/result.dart';

class PublicKeyUtils {
  final AccountDatabaseManager db;
  final ApiManager api;
  final AccountId currentUser;

  PublicKeyUtils(this.db, this.api, this.currentUser);

  /// If ForeignPublicKey is null then PublicKey for that account does not exist.
  Future<Result<ForeignPublicKey?, void>> getPublicKeyForForeignAccount(
    AccountId accountId,
    {required bool forceDownload}
  ) async {
    if (forceDownload) {
      if (await _refreshForeignPublicKey(accountId).isErr()) {
        return const Err(null);
      }
    }

    switch (await db.accountData((db) => db.daoConversations.getPublicKey(accountId))) {
      case Ok(:final v):
        if (v == null) {
          if (await _refreshForeignPublicKey(accountId).isErr()) {
            return const Err(null);
          }
          return await db.accountData((db) => db.daoConversations.getPublicKey(accountId));
        } else {
          return Ok(v);
        }
      case Err():
        return const Err(null);
    }
  }

  Future<Result<void, void>> _refreshForeignPublicKey(AccountId accountId) async {
    // TODO: use public key ID from message when that is available
    final r = await api.chat((api) => api.getLatestPublicKeyId(accountId.aid));
    final PublicKeyId latestPublicKeyId;
    switch (r) {
      case Ok(:final v):
        final id = v.id;
        if (id == null) {
          return const Err(null);
        } else {
          latestPublicKeyId = id;
        }
      case Err():
        return const Err(null);
    }

    final keyResult = await api.chat((api) => api.getPublicKeyFixed(accountId.aid, latestPublicKeyId.id));
    final Uint8List latestPublicKeyData;
    switch (keyResult) {
      case Ok(:final v):
        latestPublicKeyData = v;
      case Err():
        return const Err(null);
    }

    final InfoMessageState? infoState;
    switch (await db.accountData((db) => db.daoConversations.getPublicKey(accountId))) {
      case Ok(:final v):
        if (v == null) {
          infoState = InfoMessageState.infoMatchFirstPublicKeyReceived;
        } else if (v.id != latestPublicKeyId) {
          infoState = InfoMessageState.infoMatchPublicKeyChanged;
        } else {
          infoState = null;
        }
      case Err():
        return const Err(null);
    }

    return await db.accountAction((db) => db.daoConversations.updatePublicKeyAndAddInfoMessage(currentUser, accountId, latestPublicKeyData, latestPublicKeyId, infoState))
      .mapErr((_) => null);
  }
}
