import 'dart:async';
import 'dart:convert';

import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/api/api_manager.dart';
import 'package:pihka_frontend/data/utils.dart';
import 'package:pihka_frontend/database/account_id_database.dart';
import 'package:pihka_frontend/database/favorite_profiles_database.dart';
import 'package:pihka_frontend/database/profile_database.dart';
import 'package:pihka_frontend/database/profile_list_database.dart';
import 'package:pihka_frontend/storage/kv.dart';
import 'package:pihka_frontend/utils.dart';
import 'package:pihka_frontend/data/profile/profile_iterator.dart';


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
