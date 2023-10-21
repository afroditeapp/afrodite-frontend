

import 'package:pihka_frontend/database/profile_database.dart';
import 'package:pihka_frontend/database/profile_list_database.dart';

class IteratorType {
  /// Resets the iterator to the beginning
  void reset() {}
  /// Returns the next list of profiles
  Future<List<ProfileEntry>> nextList() async {
    return [];
  }
}
