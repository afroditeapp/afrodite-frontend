


import 'package:openapi/api.dart';
import 'package:pihka_frontend/database/account_database.dart';

import 'package:drift/drift.dart';

part 'favorite_profiles_database.g.dart';

class FavoriteProfiles extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get uuid => text().map(const AccountIdConverter()).unique()();
}

@DriftAccessor(tables: [FavoriteProfiles])
class DaoFavoriteProfiles extends DatabaseAccessor<AccountDatabase> with _$DaoFavoriteProfilesMixin {
  DaoFavoriteProfiles(AccountDatabase db) : super(db);

  Future<void> clearFavoriteProfiles() async {
    await delete(favoriteProfiles).go();
  }

  Future<void> insertProfile(AccountId accountId) async {
    await into(favoriteProfiles).insertOnConflictUpdate(
      FavoriteProfilesCompanion.insert(
        uuid: accountId,
      ),
    );
  }

  Future<void> removeFromFavorites(AccountId accountId) async {
    await (delete(favoriteProfiles)..where((r) => r.uuid.equals(accountId.accountId))).go();
  }

  Future<bool> isInFavorites(AccountId accountId) async {
    final r = await (select(favoriteProfiles)..where((r) => r.uuid.equals(accountId.accountId))).getSingleOrNull();
    return r != null;
  }

  Future<List<AccountId>> getFavoriteProfilesList(int startIndex, int limit) async {
    final r = await (select(favoriteProfiles)
      ..orderBy([(t) => OrderingTerm(expression: t.id)])
      ..limit(limit, offset: startIndex)
    )
      .map((r) => r.uuid)
      .get();

    return r;
  }
}
class AccountIdConverter extends TypeConverter<AccountId, String> {
  const AccountIdConverter();

  @override
  AccountId fromSql(fromDb) {
    return AccountId(accountId: fromDb);
  }

  @override
  String toSql(value) {
    return value.accountId;
  }
}
