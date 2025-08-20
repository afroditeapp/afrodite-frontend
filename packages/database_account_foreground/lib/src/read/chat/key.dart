import 'package:database_account_foreground/src/database.dart';
import 'package:database_utils/database_utils.dart';
import 'package:database_model/database_model.dart' as dbm;
import 'package:drift/drift.dart';
import 'package:openapi/api.dart' as api;

import '../../schema.dart' as schema;

part 'key.g.dart';

@DriftAccessor(tables: [schema.MyKeyPair, schema.PublicKey])
class DaoReadKey extends DatabaseAccessor<AccountForegroundDatabase> with _$DaoReadKeyMixin {
  DaoReadKey(super.db);

  Future<dbm.AllKeyData?> getMessageKeys() async {
    final r = await (select(
      myKeyPair,
    )..where((t) => t.id.equals(SingleRowTable.ID.value))).getSingleOrNull();

    final privateData = r?.privateKeyData;
    final publicData = r?.publicKeyData;
    final id = r?.publicKeyId;

    if (privateData != null && publicData != null && id != null) {
      return dbm.AllKeyData(private: privateData, public: publicData, id: id);
    } else {
      return null;
    }
  }

  Future<dbm.ForeignPublicKey?> getPublicKey(api.AccountId accountId) async {
    final r = await (select(
      publicKey,
    )..where((t) => t.accountId.equals(accountId.aid))).getSingleOrNull();

    final data = r?.publicKeyData;
    final id = r?.publicKeyId;

    if (data != null && id != null) {
      return dbm.ForeignPublicKey(data: data, id: id);
    } else {
      return null;
    }
  }
}
