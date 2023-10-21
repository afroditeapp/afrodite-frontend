import 'dart:async';
import 'dart:convert';

import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/api/api_manager.dart';
import 'package:pihka_frontend/data/utils.dart';
import 'package:pihka_frontend/database/favorite_profiles_database.dart';
import 'package:pihka_frontend/database/profile_database.dart';
import 'package:pihka_frontend/database/profile_list_database.dart';
import 'package:pihka_frontend/storage/kv.dart';
import 'package:pihka_frontend/utils.dart';
import 'package:pihka_frontend/data/profile/profile_iterator.dart';


class DatabaseIterator extends IteratorType {
  int currentIndex;
  DatabaseIterator({this.currentIndex = 0});

  @override
  void reset() {
    currentIndex = 0;
  }

  @override
  Future<List<ProfileEntry>> nextList() async {
    const queryCount = 10;
    final profiles = await ProfileListDatabase.getInstance().getProfileList(currentIndex, queryCount);
    if (profiles != null) {
      currentIndex += queryCount;
      return await ProfileDatabase.getInstance().convertList(profiles);
    } else {
      return [];
    }
  }
}
