import 'package:database_account_foreground/src/database.dart';
import 'package:database_utils/database_utils.dart';
import 'package:database_model/database_model.dart' as dbm;
import 'package:drift/drift.dart';
import 'package:openapi/api.dart' as api;

import '../../schema.dart' as schema;

part 'key.g.dart';

@DriftAccessor(tables: [schema.MyKeyPair, schema.PublicKey])
class DaoWriteKey extends DatabaseAccessor<AccountForegroundDatabase> with _$DaoWriteKeyMixin {
  DaoWriteKey(super.db);

  Future<void> setMessageKeys({
    required dbm.PrivateKeyBytes private,
    required dbm.PublicKeyBytes public,
    required api.PublicKeyId publicKeyId,
  }) async {
    await into(myKeyPair).insertOnConflictUpdate(
      MyKeyPairCompanion.insert(
        id: SingleRowTable.ID,
        privateKeyData: Value(private),
        publicKeyData: Value(public),
        publicKeyId: Value(publicKeyId),
      ),
    );
  }

  Future<void> updatePublicKeyAndAddInfoMessage(
    api.AccountId localAccountId,
    api.AccountId remoteAccountId,
    Uint8List publicKeyData,
    api.PublicKeyId publicKeyId,
    dbm.InfoMessageState? infoState,
  ) async {
    await transaction(() async {
      await into(publicKey).insertOnConflictUpdate(
        PublicKeyCompanion.insert(
          accountId: remoteAccountId,
          publicKeyData: Value(publicKeyData),
          publicKeyId: Value(publicKeyId),
        ),
      );

      if (infoState != null) {
        await db.write.message.insertInfoMessage(localAccountId, remoteAccountId, infoState);
      }
    });
  }
}
