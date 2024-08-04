

import 'package:database/database.dart';
import 'package:openapi/api.dart' as api;
import '../account_database.dart';

import 'package:drift/drift.dart';



part 'dao_message_keys.g.dart';

@DriftAccessor(tables: [Account])
class DaoMessageKeys extends DatabaseAccessor<AccountDatabase> with _$DaoMessageKeysMixin, AccountTools {
  DaoMessageKeys(AccountDatabase db) : super(db);

  Future<void> setMessageKeys({
    required PrivateKeyData private,
    required api.PublicKey public,
  }) async {
    await into(account).insertOnConflictUpdate(
      AccountCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        privateKeyData: Value(private),
        publicKeyData: Value(public.data),
        publicKeyId: Value(public.id),
        publicKeyVersion: Value(public.version),
      ),
    );
  }

  Future<AllKeyData?> getMessageKeys() async {
    final r = await (select(account)
      ..where((t) => t.id.equals(ACCOUNT_DB_DATA_ID.value))
    )
      .getSingleOrNull();

    final privateData = r?.privateKeyData;
    final data = r?.publicKeyData;
    final id = r?.publicKeyId;
    final version = r?.publicKeyVersion;

    if (privateData != null && data != null && id != null && version != null) {
      final public = api.PublicKey(data: data, id: id, version: version);
      return AllKeyData(private: privateData, public: public);
    } else {
      return null;
    }
  }
}
