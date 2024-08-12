

import 'dart:isolate';

import 'package:database/database.dart';
import 'package:logging/logging.dart';
import 'package:native_utils/message.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/api/api_manager.dart';
import 'package:pihka_frontend/data/login_repository.dart';
import 'package:pihka_frontend/database/account_database_manager.dart';
import 'package:pihka_frontend/utils.dart';
import 'package:pihka_frontend/utils/result.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

// TODO(architechture): Consider collecting all singletons which contains
//                      account specific data to one singleton which can
//                      recreate the singletons when account is changed.
//                      That style would avoid the AccountId checking
//                      in MessageKeyGenerator.
//                      Or prehaps account specific database and API access
//                      needs accessor objects which guarantee access to
//                      only specific database and API when login is valid.

final log = Logger("MessageKeyManager");

enum KeyGeneratorState {
  idle,
  inProgress,
}

class MessageKeyManager {
  final BehaviorSubject<KeyGeneratorState> generation =
    BehaviorSubject.seeded(KeyGeneratorState.idle, sync: true);

  final AccountDatabaseManager db;
  final LoginRepository login = LoginRepository.getInstance();
  final ApiManager api = ApiManager.getInstance();

  MessageKeyManager(this.db);

  Future<Result<AllKeyData, void>> generateOrLoadMessageKeys(AccountId accountId) async {
    if (generation.value == KeyGeneratorState.inProgress) {
      await generation.where((v) => v == KeyGeneratorState.idle).first;
      if (accountId != await login.accountId.first) {
        return const Err(null);
      }
      return await _loadMessageKeys(accountId);
    } else {
      generation.add(KeyGeneratorState.inProgress);
      if (accountId != await login.accountId.first) {
        return const Err(null);
      }
      var result = await _loadMessageKeys(accountId);
      if (result.isErr()) {
        result = await _generateMessageKeys(accountId);
      }
      generation.add(KeyGeneratorState.idle);
      return result;
    }
  }

  Future<Result<AllKeyData, void>> _loadMessageKeys(AccountId accountId) async {
    final value = await db.accountData((db) => db.daoMessageKeys.getMessageKeys()).ok();
    if (value == null) {
      return const Err(null);
    } else {
      return Ok(value);
    }
  }

  Future<Result<AllKeyData, void>> _generateMessageKeys(AccountId accountId) async {
    final (newKeys, result) = await Isolate.run(() => generateMessageKeys(accountId.accountId));
    if (accountId != await login.accountId.first) {
      return const Err(null);
    }
    if (newKeys == null) {
      log.error("Generating message keys failed, error: $result");
      return const Err(null);
    }

    return await uploadPublicKeyAndSaveAllKeys(newKeys);
  }

  Future<Result<AllKeyData, void>> uploadPublicKeyAndSaveAllKeys(
    GeneratedMessageKeys newKeys,
  ) async {
    final version = PublicKeyVersion(version: 1);
    final keyId = await api.chat((api) => api.postPublicKey(SetPublicKey(
      data: PublicKeyData(data: newKeys.armoredPublicKey),
      version: version,
    ))).ok();

    if (keyId == null) {
      return const Err(null);
    }

    final private = PrivateKeyData(data: newKeys.armoredPrivateKey);
    final public = PublicKey(
      data: PublicKeyData(data: newKeys.armoredPublicKey),
      id: keyId,
      version: version,
    );
    final dbResult = await db.accountAction((db) => db.daoMessageKeys.setMessageKeys(
      private: private,
      public: public,
    ));

    if (dbResult.isErr()) {
      return const Err(null);
    } else {
      return Ok(AllKeyData(private: private, public: public));
    }
  }
}
