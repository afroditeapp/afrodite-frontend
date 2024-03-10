import 'dart:async';

import 'package:openapi/api.dart';
import 'package:pihka_frontend/database/account_id_database.dart';


class AccountIdDatabaseIterator {
  int currentIndex;
  final AccountIdDatabase database;
  AccountIdDatabaseIterator(this.database, {this.currentIndex = 0});

  void reset() {
    currentIndex = 0;
  }

  Future<List<AccountId>> nextList() async {
    const queryCount = 10;
    final profiles = await database.getAccountIdList(currentIndex, queryCount);
    if (profiles != null) {
      currentIndex += queryCount;
      return profiles;
    } else {
      return [];
    }
  }
}
