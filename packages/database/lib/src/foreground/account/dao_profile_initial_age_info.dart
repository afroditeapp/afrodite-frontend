
import 'package:database_model/database_model.dart';
import 'package:openapi/api.dart' as api;
import 'package:utils/utils.dart';
import '../account_database.dart';

import 'package:drift/drift.dart';

part 'dao_profile_initial_age_info.g.dart';

@DriftAccessor(tables: [Account])
class DaoProfileInitialAgeInfo extends DatabaseAccessor<AccountDatabase> with _$DaoProfileInitialAgeInfoMixin, AccountTools {
  DaoProfileInitialAgeInfo(super.db);

  Future<void> setInitialAgeInfo({
    required api.AcceptedProfileAges info,
  }) async {
    final time = UtcDateTime.fromUnixEpochMilliseconds(info.profileInitialAgeSetUnixTime.ut * 1000);
    await into(account).insertOnConflictUpdate(
      AccountCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        profileInitialAge: Value(info.profileInitialAge),
        profileInitialAgeSetUnixTime: Value(time),
      ),
    );
  }

  Stream<InitialAgeInfo?> watchInitialAgeInfo() {
    return (select(account)
      ..where((t) => t.id.equals(ACCOUNT_DB_DATA_ID.value))
    )
      .map((r) {
        final age = r.profileInitialAge;
        final ageSetUnixTime = r.profileInitialAgeSetUnixTime;

        if (age != null && ageSetUnixTime != null) {
          return InitialAgeInfo(age, ageSetUnixTime);
        } else {
          return null;
        }
      })
      .watchSingleOrNull();
  }
}
