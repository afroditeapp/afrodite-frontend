

import 'dart:isolate';

import 'package:database/database.dart';
import 'package:logging/logging.dart';
import 'package:native_utils/native_utils.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/api/api_manager.dart';
import 'package:pihka_frontend/database/account_database_manager.dart';
import 'package:pihka_frontend/utils.dart';
import 'package:pihka_frontend/utils/result.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

final log = Logger("MessageKeyManager");

enum KeyGeneratorState {
  idle,
  inProgress,
}

class MessageKeyManager {
  final BehaviorSubject<KeyGeneratorState> generation =
    BehaviorSubject.seeded(KeyGeneratorState.idle, sync: true);

  final AccountDatabaseManager db;
  final ApiManager api;
  final AccountId currentUser;

  MessageKeyManager(this.db, this.api, this.currentUser);

  Future<Result<AllKeyData, void>> generateOrLoadMessageKeys() async {
    if (generation.value == KeyGeneratorState.inProgress) {
      await generation.where((v) => v == KeyGeneratorState.idle).first;
      // Key generation is now complete and it should be in database
      final keys = await db.accountData((db) => db.daoMessageKeys.getMessageKeys()).ok();
      if (keys == null) {
        return const Err(null);
      } else {
        return Ok(keys);
      }
    } else {
      generation.add(KeyGeneratorState.inProgress);
      switch (await db.accountData((db) => db.daoMessageKeys.getMessageKeys())) {
        case Err():
          generation.add(KeyGeneratorState.idle);
          return const Err(null);
        case Ok(:final v):
          if (v != null) {
            // Key is already created
            generation.add(KeyGeneratorState.idle);
            return Ok(v);
          }
      }
      final result = await _generateMessageKeys();
      generation.add(KeyGeneratorState.idle);
      return result;
    }
  }

  Future<Result<AllKeyData, void>> _generateMessageKeys() async {
    // For some reason passing the currentUser.accountId directly to closure
    // does not work.
    final currentUserString = currentUser.accountId;
    final (newKeys, result) = await Isolate.run(() => generateMessageKeys(currentUserString));
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
