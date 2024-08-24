

import 'package:openapi/api.dart';

extension IntIteratorExtensions on Iterator<int> {
  /// Get current iterator value and advance iterator to next item.
  int? next() {
    if (!moveNext()) {
      return null;
    }
    return current;
  }
}

extension AccountIteratorExtensions on Iterator<AccountId> {
  /// Get current iterator value and advance iterator to next item.
  AccountId? next() {
    if (!moveNext()) {
      return null;
    }
    return current;
  }
}
