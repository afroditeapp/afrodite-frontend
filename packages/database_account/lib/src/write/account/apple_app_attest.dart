import 'package:database_account/src/database.dart';
import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';

import '../../schema.dart' as schema;

part 'apple_app_attest.g.dart';

@DriftAccessor(tables: [schema.AppleAppAttestKey])
class DaoWriteAppleAppAttest extends DatabaseAccessor<AccountDatabase>
    with _$DaoWriteAppleAppAttestMixin {
  DaoWriteAppleAppAttest(super.db);

  /// Stores the Apple App Attest key identifier and the [challenge] used to
  /// attest it.
  ///
  /// Sets attestationPending to false.
  Future<void> saveAppleAppAttestKey({required String keyId, required String challenge}) async {
    await into(appleAppAttestKey).insertOnConflictUpdate(
      AppleAppAttestKeyCompanion.insert(
        id: SingleRowTable.ID,
        keyId: Value(keyId),
        challenge: Value(challenge),
        attestationPending: Value(false),
      ),
    );
  }

  /// Remove key ID and challenge. Set attestationPending to false.
  Future<void> resetAppleAppAttestKey() async {
    await into(appleAppAttestKey).insertOnConflictUpdate(
      AppleAppAttestKeyCompanion.insert(
        id: SingleRowTable.ID,
        keyId: Value(null),
        challenge: Value(null),
        attestationPending: Value(false),
      ),
    );
  }

  Future<void> markAttestationPending({required String keyId, required String challenge}) async {
    await into(appleAppAttestKey).insertOnConflictUpdate(
      AppleAppAttestKeyCompanion.insert(
        id: SingleRowTable.ID,
        keyId: Value(keyId),
        challenge: Value(challenge),
        attestationPending: Value(true),
      ),
    );
  }
}
