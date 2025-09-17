import 'dart:typed_data';

import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:openapi/api.dart';

extension IntIteratorExtensions on Iterator<int> {
  /// Get current iterator value and advance iterator to next item.
  int? next() {
    if (!moveNext()) {
      return null;
    }
    return current;
  }

  /// Returns null if there was not enough numbers.
  List<int>? takeAndAdvance(int count) {
    final numbers = <int>[];
    for (var i = 0; i < count; i++) {
      final current = next();
      if (current == null) {
        return null;
      }
      numbers.add(current);
    }
    return numbers;
  }

  Uint8List takeAllAsBytes() {
    final data = <int>[];
    while (true) {
      final current = next();
      if (current == null) {
        break;
      }
      data.add(current);
    }
    return Uint8List.fromList(data);
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

extension MyPageWithUrlNavigationIteratorExtensions on Iterator<MyPageWithUrlNavigation<Object>> {
  /// Get current iterator value and advance iterator to next item.
  MyPageWithUrlNavigation<Object>? next() {
    if (!moveNext()) {
      return null;
    }
    return current;
  }
}
