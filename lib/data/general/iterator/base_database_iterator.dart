import 'dart:async';

import 'package:database/database.dart';
import 'package:openapi/api.dart';
import 'package:app/database/account_database_manager.dart';
import 'package:app/data/general/iterator/profile_iterator.dart';
import 'package:app/utils/app_error.dart';
import 'package:app/utils/result.dart';

abstract class BaseDatabaseIterator extends IteratorType {
  int _currentIndex = 0;
  final int _queryCount;
  final AccountDatabaseManager db;
  BaseDatabaseIterator({
    required this.db,
    int queryCount = 10
  }) :
    _queryCount = queryCount,
    super(false);

  @override
  void reset() {
    _currentIndex = 0;
  }

  Future<Result<List<AccountId>, DatabaseError>> getAccountListFromDatabase(int startIndex, int limit);

  @override
  Future<Result<List<ProfileEntry>, void>> nextList() async {
    final profiles = await getAccountListFromDatabase(_currentIndex, _queryCount).ok();
    if (profiles != null) {
      _currentIndex += _queryCount;
      return Ok(await db.accountData((db) => db.profile.convertToProfileEntries(profiles)).ok() ?? []);
    } else {
      return const Ok([]);
    }
  }
}
