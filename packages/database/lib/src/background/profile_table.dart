


import 'package:openapi/api.dart' show AccountId;
import 'package:openapi/api.dart' as api;
import 'package:utils/utils.dart';
import 'account_database.dart';

import 'package:drift/drift.dart';
import '../profile_entry.dart';
import '../utils.dart';

part 'profile_table.g.dart';

class ProfilesBackground extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get uuidAccountId => text().map(const AccountIdConverter()).unique()();
  TextColumn get profileName => text().nullable()();
  BoolColumn get profileNameAccepted => boolean().nullable()();
}

@DriftAccessor(tables: [ProfilesBackground])
class DaoProfilesBackground extends DatabaseAccessor<AccountBackgroundDatabase> with _$DaoProfilesBackgroundMixin {
  DaoProfilesBackground(AccountBackgroundDatabase db) : super(db);

  Future<List<AccountId>> _getProfilesList(int? startIndex, int? limit, GeneratedColumnWithTypeConverter<UtcDateTime?, int> Function($ProfilesBackgroundTable) getter) async {
    final q = select(profilesBackground)
      ..where((t) => getter(t).isNotNull())
      ..orderBy([
        (t) => OrderingTerm(expression: getter(t)),
        // If list is added, the time values can have same value, so
        // order by id to make the order deterministic.
        (t) => OrderingTerm(expression: t.id),
      ]);

    if (limit != null) {
      q.limit(limit, offset: startIndex);
    }

    final r = await q
      .map((t) => t.uuidAccountId)
      .get();

    return r;
  }

  Future<bool> _existenceCheck(AccountId accountId, Expression<bool> Function($ProfilesBackgroundTable) additionalCheck) async {
    final r = await (select(profilesBackground)
      ..where((t) => Expression.and([
        t.uuidAccountId.equals(accountId.aid),
        additionalCheck(t),
       ]))
    ).getSingleOrNull();
    return r != null;
  }

  Value<UtcDateTime?> _toGroupValue(bool value) {
    if (value) {
      return Value(UtcDateTime.now());
    } else {
      return const Value(null);
    }
  }

  Future<void> removeProfileData(AccountId accountId) async {
    await (update(profilesBackground)..where((t) => t.uuidAccountId.equals(accountId.aid)))
      .write(const ProfilesBackgroundCompanion(
        profileName: Value(null),
        profileNameAccepted: Value(null),
      ));
  }

  Future<void> updateProfileData(AccountId accountId, api.Profile profile) async {
    await into(profilesBackground).insert(
      ProfilesBackgroundCompanion.insert(
        uuidAccountId: accountId,
        profileName: Value(profile.name),
        profileNameAccepted: Value(profile.nameAccepted),
      ),
      onConflict: DoUpdate((old) => ProfilesBackgroundCompanion(
        profileName: Value(profile.name),
        profileNameAccepted: Value(profile.nameAccepted),
      ),
        target: [profilesBackground.uuidAccountId]
      ),
    );
  }

  Future<ProfileLocalDbId?> getProfileLocalDbId(AccountId accountId) async {
    final r = await (select(profilesBackground)
      ..where((t) => t.uuidAccountId.equals(accountId.aid))
    )
      .getSingleOrNull();

    if (r == null) {
      return null;
    }

    return ProfileLocalDbId(r.id);
  }

  Future<ProfileTitle?> getProfileTitle(AccountId accountId) async {
    final r = await (select(profilesBackground)
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

    final result = await db.daoUserInterfaceSettings.watchShowNonAcceptedProfileNames().first;
    return ProfileTitle(name, nameAccepted, result ?? false);
  }
}
