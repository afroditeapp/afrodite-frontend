import 'package:database_account_background/database_account_background.dart';
import 'package:database_model/database_model.dart';
import 'package:drift/drift.dart';
import 'package:openapi/api.dart' as api;

import '../schema.dart' as schema;

part 'profile.g.dart';

@DriftAccessor(
  tables: [
    schema.Profile,
  ]
)
class DaoReadProfile extends DatabaseAccessor<AccountBackgroundDatabase> with _$DaoReadProfileMixin {
  DaoReadProfile(super.db);

  Future<ProfileTitle?> getProfileTitle(api.AccountId accountId) async {
    final r = await (select(profile)
      ..where((t) => t.uuidAccountId.equals(accountId.aid))
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
}
