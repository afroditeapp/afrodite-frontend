

import 'package:database/src/utils.dart';
import 'package:openapi/api.dart' as api;
import '../account_database.dart';

import 'package:drift/drift.dart';



part 'dao_my_profile.g.dart';

@DriftAccessor(tables: [Account])
class DaoMyProfile extends DatabaseAccessor<AccountDatabase> with _$DaoMyProfileMixin, AccountTools {
  DaoMyProfile(super.db);

  Future<void> setApiProfile({
    required api.GetMyProfileResult result,
  }) async {
    final profile = result.p;
    await into(account).insertOnConflictUpdate(
      AccountCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        profileName: Value(profile.name),
        profileNameAccepted: Value(profile.nameAccepted),
        profileNameModerationState: Value(result.nameModerationInfo?.state.toEnumString()),
        profileText: Value(profile.ptext),
        profileTextAccepted: Value(result.p.ptextAccepted),
        profileTextModerationState: Value(result.textModerationInfo?.state.toEnumString()),
        profileTextModerationRejectedCategory: Value(result.textModerationInfo?.rejectedReasonCategory),
        profileTextModerationRejectedDetails: Value(result.textModerationInfo?.rejectedReasonDetails),
        profileAge: Value(profile.age),
        profileVersion: Value(result.v),
        profileUnlimitedLikes: Value(profile.unlimitedLikes),
        jsonProfileAttributes: Value(profile.attributes.toJsonList()),
      ),
    );
  }

  Stream<Map<int, api.ProfileAttributeValueUpdate>?> watchProfileAttributes() =>
    watchColumn((r) => r.jsonProfileAttributes?.toProfileAttributes());
}
