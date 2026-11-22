import 'dart:async';

import 'package:openapi/api.dart';
import 'package:app/utils/result.dart';

class AccountIdDatabaseIterator {
  int currentIndex;
  final Future<List<AccountId>?> Function(int startIndex, int limit) dataGetter;
  AccountIdDatabaseIterator(this.dataGetter, {this.currentIndex = 0});

  void reset() {
    currentIndex = 0;
  }

  Future<Result<List<AccountId>, ()>> nextList() async {
    const queryCount = 10;
    final profiles = await dataGetter(currentIndex, queryCount);
    if (profiles != null) {
      currentIndex += queryCount;
      return Ok(profiles);
    } else {
      return const Err(());
    }
  }
}
