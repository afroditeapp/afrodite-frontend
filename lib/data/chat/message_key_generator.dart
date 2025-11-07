import 'dart:isolate';

import 'package:database/database.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:logging/logging.dart';
import 'package:native_utils/native_utils.dart';
import 'package:openapi/api.dart';
import 'package:app/api/server_connection_manager.dart';
import 'package:app/database/account_database_manager.dart';
import 'package:utils/utils.dart';
import 'package:app/utils/result.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

final _log = Logger("MessageKeyManager");

enum KeyGeneratorState { idle, inProgress }

class MessageKeyManager {
  final BehaviorSubject<KeyGeneratorState> generation = BehaviorSubject.seeded(
    KeyGeneratorState.idle,
    sync: true,
  );

  final AccountDatabaseManager db;
  final ApiManager api;
  final AccountId currentUser;

  MessageKeyManager(this.db, this.api, this.currentUser);

  Future<void> dispose() async {
    await generation.close();
  }

  Future<Result<AllKeyData, ()>> generateOrLoadMessageKeys() async {
    if (generation.value == KeyGeneratorState.inProgress) {
      try {
        await generation.where((v) => v == KeyGeneratorState.idle).first;
      } catch (_) {
        // Disposed
        return Err(());
      }
      // Key generation is now complete and it should be in database
      final keys = await db.accountData((db) => db.key.getMessageKeys()).ok();
      if (keys == null) {
        return const Err(());
      } else {
        return Ok(keys);
      }
    } else {
      generation.add(KeyGeneratorState.inProgress);
      switch (await db.accountData((db) => db.key.getMessageKeys())) {
        case Err():
          generation.add(KeyGeneratorState.idle);
          return const Err(());
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

  Future<Result<AllKeyData, ()>> _generateMessageKeys() async {
    // For some reason passing the currentUser.accountId directly to closure
    // does not work.
    final currentUserString = currentUser.aid;
    final (GeneratedMessageKeys?, int) generateKeysResult;
    if (kIsWeb) {
      generateKeysResult = await generateMessageKeys(currentUserString);
    } else {
      generateKeysResult = await Isolate.run(() => generateMessageKeys(currentUserString));
    }
    final (newKeys, result) = generateKeysResult;
    if (newKeys == null) {
      _log.error("Generating message keys failed, error: $result");
      return const Err(());
    }

    return await uploadPublicKeyAndSaveAllKeys(newKeys);
  }

  Future<Result<AllKeyData, ()>> uploadPublicKeyAndSaveAllKeys(GeneratedMessageKeys newKeys) async {
    final r = await api
        .chat((api) => api.postAddPublicKey(MultipartFile.fromBytes("", newKeys.public.toList())))
        .ok();

    // TODO(prod): Handle errorTooManyPublicKeys properly
    final keyId = r?.keyId;
    if (r == null || keyId == null || r.error || r.errorTooManyPublicKeys) {
      return const Err(());
    }

    final private = PrivateKeyBytes(data: newKeys.private);
    final public = PublicKeyBytes(data: newKeys.public);

    final dbResult = await db.accountAction(
      (db) => db.key.setMessageKeys(private: private, public: public, publicKeyId: keyId),
    );

    if (dbResult.isErr()) {
      return const Err(());
    } else {
      return Ok(AllKeyData(private: private, public: public, id: keyId));
    }
  }
}
