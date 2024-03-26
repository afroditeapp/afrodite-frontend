
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PreferenceKeyProvider<K, V> {
  K getKeyEnum();

  /// Get shared preference key for this key
  String sharedPreferencesKey();
}

abstract class DefaultProvider<K, V> extends PreferenceKeyProvider<K, V> {
  V getDefault();
}

abstract class KvStorageManager<K extends PreferenceKeyProvider<K, V>, V> {
  final PublishSubject<(K, V?)> _updates =
    PublishSubject();

  Stream<(K, V?)> get updates => _updates;

  final Future<void> Function(K, V) _setToSharedPreferencesImplementation;
  Future<V?> getValue(K key);

  KvStorageManager(this._setToSharedPreferencesImplementation);

  /// Set new value. If it is same than the previous, then nothing is done.
  Future<void> setValue(PreferenceKeyProvider<K, V> key, V? value) async {
    final current = await getValue(key.getKeyEnum());
    if (current == value) {
      return;
    }
    if (value == null) {
      final SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.remove(key.getKeyEnum().sharedPreferencesKey());
    } else {
      await _setToSharedPreferencesImplementation(key.getKeyEnum(), value);
    }

    _updates.add((key.getKeyEnum(), value));
  }

  Future<V> getValueOrDefault(DefaultProvider<K, V> key) async {
    return await getValue(key.getKeyEnum()) ?? key.getDefault();
  }

  Stream<T?> getUpdatesForWithConversion<T extends Object>(K key, T Function(V) convert) async* {
    final current = await getValue(key);
    if (current != null) {
      yield convert(current);
    } else {
      yield null;
    }

    yield* _updates
      .where((event) => event.$1 == key)
      .map((event) => event.$2)
      .map((event) {
        if (event != null) {
          return convert(event);
        } else {
          return null;
        }
      });
  }

  Stream<T?> getUpdatesForWithConversionFailurePossible<T extends Object>(K key, T? Function(V) convert) async* {
    final current = await getValue(key);
    if (current != null) {
      yield convert(current);
    } else {
      yield null;
    }

    yield* _updates
      .where((event) => event.$1 == key)
      .map((event) => event.$2)
      .map((event) {
        if (event != null) {
          return convert(event);
        } else {
          return null;
        }
      });
  }

  Stream<T> getUpdatesForWithConversionAndDefaultIfNull<T extends Object>(K key, T Function(V) convert, T defaultValue) async* {
    final current = await getValue(key);
    if (current != null) {
      yield convert(current);
    } else {
      yield defaultValue;
    }

    yield* _updates
      .where((event) => event.$1 == key)
      .map((event) => event.$2)
      .map((event) {
        if (event != null) {
          return convert(event);
        } else {
          return defaultValue;
        }
      });
  }
}
