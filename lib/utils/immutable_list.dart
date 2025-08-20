import 'package:meta/meta.dart';

/// List with immutable order and elemtents.
class ImmutableList<T extends Immutable> extends Iterable<T> {
  final List<T> _list;

  const ImmutableList.empty() : _list = const [];

  ImmutableList(Iterable<T> data) : _list = List.unmodifiable(data);

  T operator [](int index) => _list[index];

  T? getAtOrNull(int index) {
    if (index < length) {
      return this[index];
    }
    return null;
  }

  @override
  Iterator<T> get iterator => _list.iterator;
}

/// List which has immutable order.
class UnmodifiableList<T> extends Iterable<T> {
  final List<T> _list;

  const UnmodifiableList.empty() : _list = const [];

  UnmodifiableList(Iterable<T> data) : _list = List.unmodifiable(data);

  T operator [](int index) => _list[index];

  /// Create copy of this list and remove element at [index] from the new list.
  UnmodifiableList<T> removeAt(int index) {
    final l = [..._list];

    l.removeAt(index);

    return UnmodifiableList(l);
  }

  /// Create copy of this list and push new value to the new list.
  UnmodifiableList<T> add(T value) {
    final l = [..._list, value];
    return UnmodifiableList(l);
  }

  /// Create copy of this list and push new values to the new list.
  UnmodifiableList<T> addAll(Iterable<T> values) {
    final l = [..._list, ...values];
    return UnmodifiableList(l);
  }

  T? getAtOrNull(int index) {
    if (index < length) {
      return this[index];
    }
    return null;
  }

  Iterable<T> get reversed => _list.reversed;

  @override
  Iterator<T> get iterator => _list.iterator;
}
