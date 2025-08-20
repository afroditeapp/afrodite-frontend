extension ListExtensions<T> on List<T> {
  T? getAtOrNull(int index) {
    if (index < length) {
      return this[index];
    }
    return null;
  }
}
