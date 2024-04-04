import 'dart:async';

import 'package:openapi/api.dart';

class AccountIdDatabaseIterator {
  int currentIndex;
  final Future<List<AccountId>?> Function(int startIndex, int limit) dataGetter;
  AccountIdDatabaseIterator(this.dataGetter, {this.currentIndex = 0});

  void reset() {
    currentIndex = 0;
  }

  Future<List<AccountId>> nextList() async {
    const queryCount = 10;
    final profiles = await dataGetter(currentIndex, queryCount);
    if (profiles != null) {
      currentIndex += queryCount;
      return profiles;
    } else {
      return [];
    }
  }
}
