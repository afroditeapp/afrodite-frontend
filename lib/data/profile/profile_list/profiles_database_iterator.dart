import 'dart:async';

import 'package:openapi/api.dart';
import 'package:app/data/general/iterator/base_database_iterator.dart';
import 'package:app/utils/app_error.dart';
import 'package:app/utils/result.dart';

class ProfileListDatabaseIterator extends BaseDatabaseIterator {
  ProfileListDatabaseIterator({required super.db});

  @override
  Future<Result<List<AccountId>, DatabaseError>> getAccountListFromDatabase(int startIndex, int limit) =>
    db.accountData((db) => db.profile.getProfileGridList(startIndex, limit));
}
