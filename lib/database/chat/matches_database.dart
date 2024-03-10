


import 'package:pihka_frontend/database/account_id_database.dart';
import 'package:pihka_frontend/database/base_database.dart';

class MatchesDatabase extends AccountIdDatabase {
  MatchesDatabase._private();
  static final _instance = MatchesDatabase._private();
  factory MatchesDatabase.getInstance() {
    return _instance;
  }

  @override
  DatabaseType get databaseType => DatabaseType.chatMatches;
}
