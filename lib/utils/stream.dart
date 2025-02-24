
import 'dart:async';

extension StreamItearatorExtensions<T> on StreamIterator<T> {
  Future<T?> next() async {
    if (await moveNext()) {
      return current;
    } else {
      return null;
    }
  }
}
