import 'package:database_account/src/database.dart';
import 'package:database_model/database_model.dart';
import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';

import '../../schema.dart' as schema;

part 'apple_app_attest.g.dart';

@DriftAccessor(tables: [schema.AppleAppAttestKey])
class DaoReadAppleAppAttest extends DatabaseAccessor<AccountDatabase>
    with _$DaoReadAppleAppAttestMixin {
  DaoReadAppleAppAttest(super.db);

  Future<AppleAppAttestKeyState?> getAppleAppAttestKey() async {
    final row = await (select(
      appleAppAttestKey,
    )..where((t) => t.id.equals(SingleRowTable.ID.value))).getSingleOrNull();
    final keyId = row?.keyId;
    if (keyId == null) {
      return null;
    }
    return AppleAppAttestKeyState(keyId, row?.attestationPending ?? false);
  }
}
