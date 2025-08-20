import 'dart:collection';

import 'package:collection/collection.dart';

class RemoveOldestCache<K, V> {
  final int maxValues;
  RemoveOldestCache({required this.maxValues});

  LinkedHashMap<K, V> data = LinkedHashMap();

  /// Adds or updates key value pair in the cache. If there is too many
  /// entries in the cache, the oldest is removed.
  void update(K key, V value) {
    if (data.length >= maxValues) {
      final oldest = data.entries.firstOrNull;
      if (oldest != null) {
        data.remove(oldest.key);
      }
    }

    final current = data[key];
    if (current == null) {
      data[key] = value;
    } else {
      // The data already exists, so it needs to be removed and added
      // again so that usage tracking works.
      data.remove(key);
      data[key] = value;
    }
  }

  V? get(K key) {
    return data[key];
  }
}
