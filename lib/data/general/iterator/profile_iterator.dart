

import 'package:database/database.dart';
import 'package:app/utils/result.dart';

class IteratorType {
  bool clearsDatabase;
  IteratorType(this.clearsDatabase);

  /// Resets the iterator to the beginning
  void reset() {}
  /// Returns the next list of profiles.
  ///
  /// Error should be returned only when online iterator is used and downloading
  /// next profile page fails.
  Future<Result<List<ProfileEntry>, ()>> nextList() async {
    return const Ok([]);
  }
}
