

extension IntIteratorExtensions on Iterator<int> {
  /// Get current iterator value and advance iterator to next item.
  int? next() {
    if (!moveNext()) {
      return null;
    }
    return current;
  }
}
