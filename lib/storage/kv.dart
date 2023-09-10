/// Key value storage

import 'dart:async';

import 'package:pihka_frontend/config.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum KvString implements KvStringProvider {
  /// Url
  accountServerAddress,
  /// Url
  mediaServerAddress,
  /// Url
  profileServerAddress,

  accountId,
  accountCapabilities,
  /// AccountState json
  accountState,
  /// Base64 string
  accountRefreshToken,
  accountAccessToken,
  /// Base64 string
  mediaRefreshToken,
  mediaAccessToken,
  /// Base64 string
  profileRefreshToken,
  profileAccessToken;

  /// Get shared preference key for this KvString
  String _key() {
    return "kv-string-key-$name";
  }

  @override
  KvString getKvString() {
    return this;
  }
}

abstract class KvStringProvider {
  KvString getKvString();
}

class KvStorageManager {
  static final _instance = KvStorageManager._private();
  KvStorageManager._private();
  factory KvStorageManager.getInstance() {
    return _instance;
  }

  final PublishSubject<(KvString, String?)> _updates =
    PublishSubject();

  Stream<(KvString, String?)> get updates => _updates;

  Future<String?> getString(KvString key) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(key._key());
  }

  Future<String> getStringOrDefault(KvStringWithDefault key) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(key.key._key()) ?? key.defaultValue();
  }

  /// Set new string. If it is same than the previous, then nothing is done.
  Future<void> setString(KvStringProvider keyProvider, String? value) async {
    final key = keyProvider.getKvString();
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final current = preferences.getString(key._key());
    if (current == value) {
      return;
    }
    if (value == null) {
      await preferences.remove(key._key());
    } else {
      await preferences.setString(key._key(), value);
    }

    _updates.add((key, value));
  }

  Stream<T?> getUpdatesForWithConversion<T extends Object>(KvString key, T Function(String) convert) async* {
    final current = await getString(key);
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

  Stream<T> getUpdatesForWithConversionAndDefaultIfNull<T extends Object>(KvString key, T Function(String) convert, T defaultValue) async* {
    final current = await getString(key);
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
