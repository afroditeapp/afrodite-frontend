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

  Future<Result<ForeignPublicKey, void>> getLatestPublicKeyForForeignAccount(
    AccountId accountId,
  ) async {
    // Download and return latest public key
    final r = await _refreshForeignPublicKey(accountId, null);
    if (r.isErr()) {
      return const Err(null);
    } else {
      return await db.accountData((db) => db.key.getPublicKey(accountId))
        .errorIfNull();
    }
  }

  Future<Result<ForeignPublicKey, void>> getSpecificPublicKeyForForeignAccount(
    AccountId accountId,
    PublicKeyId wantedPublicKeyId,
  ) async {
    switch (await db.accountData((db) => db.key.getPublicKey(accountId))) {
      case Ok(:final v):
        if (v == null || v.id != wantedPublicKeyId) {
          if (await _refreshForeignPublicKey(accountId, wantedPublicKeyId).isErr()) {
            return const Err(null);
          } else {
            return await db.accountData((db) => db.key.getPublicKey(accountId))
              .errorIfNull();
          }
        } else {
          return Ok(v);
        }
      case Err():
        return const Err(null);
    }
  }

  Future<Result<ForeignPublicKey, void>> getPublicKeyForForeignAccountFromDbOrDownloadIfNotExits(
    AccountId accountId,
  ) async {
    switch (await db.accountData((db) => db.key.getPublicKey(accountId))) {
      case Ok(:final v):
        if (v == null) {
          if (await _refreshForeignPublicKey(accountId, null).isErr()) {
            return const Err(null);
          } else {
            return await db.accountData((db) => db.key.getPublicKey(accountId))
              .errorIfNull();
          }
        } else {
          return Ok(v);
        }
      case Err():
        return const Err(null);
    }
  }

  Future<Result<void, void>> _refreshForeignPublicKey(AccountId accountId, PublicKeyId? wantedKey) async {
    final PublicKeyId wantedPublicKeyId;
    if (wantedKey == null) {
      // Get latest key
      final r = await api.chat((api) => api.getLatestPublicKeyId(accountId.aid));
      switch (r) {
        case Ok(:final v):
          final id = v.id;
          if (id == null) {
            return const Err(null);
          } else {
            wantedPublicKeyId = id;
          }
        case Err():
          return const Err(null);
      }
    } else {
      wantedPublicKeyId = wantedKey;
    }

    final keyResult = await api.chat((api) => api.getPublicKeyFixed(accountId.aid, wantedPublicKeyId.id));
    final Uint8List latestPublicKeyData;
    switch (keyResult) {
      case Ok(:final v):
        latestPublicKeyData = v;
      case Err():
        return const Err(null);
    }

    final InfoMessageState? infoState;
    switch (await db.accountData((db) => db.key.getPublicKey(accountId))) {
      case Ok(:final v):
        if (v == null) {
          infoState = InfoMessageState.infoMatchFirstPublicKeyReceived;
        } else if (v.id != wantedPublicKeyId) {
          infoState = InfoMessageState.infoMatchPublicKeyChanged;
        } else {
          infoState = null;
        }
      case Err():
        return const Err(null);
    }

    return await db.accountAction((db) => db.key.updatePublicKeyAndAddInfoMessage(currentUser, accountId, latestPublicKeyData, wantedPublicKeyId, infoState))
      .mapErr((_) => null);
  }
}
