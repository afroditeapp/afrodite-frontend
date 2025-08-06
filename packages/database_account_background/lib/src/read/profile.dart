import 'package:database_account_background/database_account_background.dart';
import 'package:database_model/database_model.dart';
import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';
import 'package:openapi/api.dart' as api;

import '../schema.dart' as schema;

part 'profile.g.dart';

@DriftAccessor(
  tables: [
    schema.Profile,
    schema.AutomaticProfileSearchBadgeState,
  ]
)
class DaoReadProfile extends DatabaseAccessor<AccountBackgroundDatabase> with _$DaoReadProfileMixin {
  DaoReadProfile(super.db);

  Future<ProfileTitle?> getProfileTitle(api.AccountId accountId) async {
    final r = await (select(profile)
      ..where((t) => t.accountId.equals(accountId.aid))
    )
      .getSingleOrNull();

    if (r == null) {
      return null;
    }

    final name = r.profileName;
    if (name == null) {
      return null;
    }
    final nameAccepted = r.profileNameAccepted;
    if (nameAccepted == null) {
      return null;
    }

    return ProfileTitle(name, nameAccepted);
  }

  Stream<AutomaticProfileSearchBadgeState?> watchAutomaticProfileSearchUiState() {
    return (select(automaticProfileSearchBadgeState)
      ..where((t) => t.id.equals(SingleRowTable.ID.value))
    )
      .watchSingleOrNull()
      .map((r) {
        if (r == null) {
          return null;
        }
        return AutomaticProfileSearchBadgeState(r.profileCount, r.showBadge);
      });
  }
}
