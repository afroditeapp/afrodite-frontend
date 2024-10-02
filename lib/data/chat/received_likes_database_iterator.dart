import 'dart:async';

import 'package:database/database.dart';
import 'package:pihka_frontend/database/account_database_manager.dart';
import 'package:pihka_frontend/data/general/iterator/profile_iterator.dart';
import 'package:pihka_frontend/utils/result.dart';

class ReceivedLikesDatabaseIterator extends IteratorType {
  int currentIndex;
  final AccountDatabaseManager db;
  ReceivedLikesDatabaseIterator({this.currentIndex = 0, required this.db});

  @override
  void reset() {
    currentIndex = 0;
  }

  @override
  Future<Result<List<ProfileEntry>, void>> nextList() async {
    const queryCount = 10;
    final profiles = await db.accountData((db) => db.daoProfileStates.getReceivedLikesList(currentIndex, queryCount)).ok();
    if (profiles != null) {
      currentIndex += queryCount;
      return Ok(await db.profileData((db) => db.convertToProfileEntries(profiles)).ok() ?? []);
    } else {
      return const Ok([]);
    }
  }
}
