import 'dart:async';

extension StreamIteratorExtensions<T> on StreamIterator<T> {
  Future<T?> next() async {
    if (await moveNext()) {
      return current;
    } else {
      return null;
    }
  }
}
