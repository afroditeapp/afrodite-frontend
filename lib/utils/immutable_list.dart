

import 'package:meta/meta.dart';

/// List with immutable order and elemtents.
class ImmutableList<T extends Immutable> extends Iterable<T> {
  final List<T> _list;

  const ImmutableList.empty() : _list = const [];

  ImmutableList(Iterable<T> data) : _list = List.unmodifiable(data);

  T operator [](int index) => _list[index];

  @override
  Iterator<T> get iterator => _list.iterator;
}

/// List which has immutable order.
class UnmodifiableList<T> extends Iterable<T> {
  final List<T> _list;

  const UnmodifiableList.empty() : _list = const [];

  UnmodifiableList(Iterable<T> data) : _list = List.unmodifiable(data);

  T operator [](int index) => _list[index];

  @override
  Iterator<T> get iterator => _list.iterator;
}
