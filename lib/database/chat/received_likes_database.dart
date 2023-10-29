


import 'package:openapi/api.dart';
import 'package:pihka_frontend/database/account_id_database.dart';
import 'package:pihka_frontend/database/base_database.dart';
import 'package:sqflite/utils/utils.dart';
import 'package:sqflite/sqflite.dart';

class ReceivedLikesDatabase extends AccountIdDatabase {
  ReceivedLikesDatabase._private();
  static final _instance = ReceivedLikesDatabase._private();
  factory ReceivedLikesDatabase.getInstance() {
    return _instance;
  }

  @override
  DatabaseType get databaseType => DatabaseType.chatReceivedLikes;
}
