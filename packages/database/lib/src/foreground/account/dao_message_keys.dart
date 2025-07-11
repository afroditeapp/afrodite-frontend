

import 'package:database/database.dart';
import 'package:openapi/api.dart' as api;
import '../account_database.dart';

import 'package:drift/drift.dart';

part 'dao_message_keys.g.dart';

@DriftAccessor(tables: [Account])
class DaoMessageKeys extends DatabaseAccessor<AccountDatabase> with _$DaoMessageKeysMixin, AccountTools {
  DaoMessageKeys(super.db);

  Future<void> setMessageKeys({
    required PrivateKeyData private,
    required PublicKeyData public,
    required api.PublicKeyId publicKeyId,
  }) async {
    await into(account).insertOnConflictUpdate(
      AccountCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        privateKeyData: Value(private),
        publicKeyData: Value(public),
        publicKeyId: Value(publicKeyId),
      ),
    );
  }

  Future<AllKeyData?> getMessageKeys() async {
    final r = await (select(account)
      ..where((t) => t.id.equals(ACCOUNT_DB_DATA_ID.value))
    )
      .getSingleOrNull();

    final privateData = r?.privateKeyData;
    final publicData = r?.publicKeyData;
    final id = r?.publicKeyId;

    if (privateData != null && publicData != null && id != null) {
      return AllKeyData(private: privateData, public: publicData, id: id);
    } else {
      return null;
    }
  }
}
