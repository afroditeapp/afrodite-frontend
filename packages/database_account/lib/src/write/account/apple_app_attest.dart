import 'package:database_account/src/database.dart';
import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';

import '../../schema.dart' as schema;

part 'apple_app_attest.g.dart';

@DriftAccessor(tables: [schema.AppleAppAttestKey])
class DaoWriteAppleAppAttest extends DatabaseAccessor<AccountDatabase>
    with _$DaoWriteAppleAppAttestMixin {
  DaoWriteAppleAppAttest(super.db);

  /// Stores the Apple App Attest key identifier. Set [keyId] to null to clear
  /// the key.
  Future<void> updateAppleAppAttestKey(String? keyId) async {
    await into(appleAppAttestKey).insertOnConflictUpdate(
      AppleAppAttestKeyCompanion.insert(id: SingleRowTable.ID, keyId: Value(keyId)),
    );
  }
}
