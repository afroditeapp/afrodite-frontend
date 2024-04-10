

import 'package:database/database.dart';
import 'package:pihka_frontend/database/database_manager.dart';

class IteratorType {
  /// Resets the iterator to the beginning
  void reset() {}
  /// Returns the next list of profiles
  Future<List<ProfileEntry>> nextList() async {
    return [];
  }
}
