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

final _log = Logger("MessageKeyManager");

class MessageKeyManager {
  final AccountDatabaseManager db;
  final ApiManager api;
  final AccountId currentUser;

  MessageKeyManager(this.db, this.api, this.currentUser);

  Future<void> dispose() async {
    // Empty
  }

  Future<Result<(), ()>> generateNewKeypairAndUploadPublicKey() async {
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

    return await _uploadPublicKeyAndSaveAllKeys(newKeys);
  }

  Future<Result<(), ()>> _uploadPublicKeyAndSaveAllKeys(GeneratedMessageKeys newKeys) async {
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
      (db) => db.key.setMessageKeys(
        private: private,
        public: public,
        publicKeyId: keyId,
        publicKeyIdOnServer: keyId,
      ),
    );

    if (dbResult.isErr()) {
      return const Err(());
    } else {
      return Ok(());
    }
  }

  /// Keys are returned only if local public key exists and the same
  /// key is on server as well.
  Future<Result<AllKeyData, ()>> getKeysWhenChatIsEnabled() async {
    switch (await db.accountData((db) => db.key.getMessageKeys())) {
      case Err():
        return const Err(());
      case Ok(:final v):
        if (v != null && v.publicKeyId == v.publicKeyIdOnServer) {
          return Ok(v);
        } else {
          return const Err(());
        }
    }
  }
}
