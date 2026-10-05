import 'package:database_account/src/database.dart';
import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';

import '../../schema.dart' as schema;

part 'apple_app_attest.g.dart';

@DriftAccessor(tables: [schema.AppleAppAttestKey])
class DaoReadAppleAppAttest extends DatabaseAccessor<AccountDatabase>
    with _$DaoReadAppleAppAttestMixin {
  DaoReadAppleAppAttest(super.db);

  /// Returns the stored Apple App Attest key identifier, or null if no key has
  /// been stored.
  Future<String?> getAppleAppAttestKey() async {
    final row = await (select(
      appleAppAttestKey,
    )..where((t) => t.id.equals(SingleRowTable.ID.value))).getSingleOrNull();
    return row?.keyId;
  }
}
