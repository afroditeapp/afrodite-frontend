


import 'package:pihka_frontend/database/account_id_database.dart';
import 'package:pihka_frontend/database/base_database.dart';

class SentLikesDatabase extends AccountIdDatabase {
  SentLikesDatabase._private();
  static final _instance = SentLikesDatabase._private();
  factory SentLikesDatabase.getInstance() {
    return _instance;
  }

  @override
  DatabaseType get databaseType => DatabaseType.chatSentLikes;
}
