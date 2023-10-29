


import 'package:openapi/api.dart';
import 'package:pihka_frontend/database/account_id_database.dart';
import 'package:pihka_frontend/database/base_database.dart';
import 'package:sqflite/utils/utils.dart';
import 'package:sqflite/sqflite.dart';

class ReceivedBlocksDatabase extends AccountIdDatabase {
  ReceivedBlocksDatabase._private();
  static final _instance = ReceivedBlocksDatabase._private();
  factory ReceivedBlocksDatabase.getInstance() {
    return _instance;
  }

  @override
  DatabaseType get databaseType => DatabaseType.chatReceivedBlocks;
}
