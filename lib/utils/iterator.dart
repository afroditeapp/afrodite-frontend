import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:openapi/api.dart';

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
