

import 'dart:isolate';

import 'package:database/database.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:logging/logging.dart';
import 'package:native_utils/native_utils.dart';
import 'package:openapi/api.dart';
import 'package:app/api/api_manager.dart';
import 'package:app/database/account_database_manager.dart';
import 'package:utils/utils.dart';
import 'package:app/utils/result.dart';
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
    if (kIsWeb) {
      // Messages are not supported on web
      return const Err(null);
    }

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
    final currentUserString = currentUser.aid;
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
    // TODO: update
    final Uint8List data = Uint8List.fromList([]);
    final List<int> keyData = data.toList();
    final r = await api.chat((api) => api.postAddPublicKey(MultipartFile.fromBytes("", keyData))).ok();

    final keyId = r?.keyId;
    if (r == null || keyId == null || r.errorTooManyPublicKeys) {
      return const Err(null);
    }

    // TODO: update
    final private = PrivateKeyData(data: data);
    final public = PublicKeyData(data: data);

    final dbResult = await db.accountAction((db) => db.daoMessageKeys.setMessageKeys(
      private: private,
      public: public,
      publicKeyId: keyId,
    ));

    if (dbResult.isErr()) {
      return const Err(null);
    } else {
      return Ok(AllKeyData(private: private, public: public, id: keyId));
    }
  }
}
