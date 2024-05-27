/// Key value storage (unencrypted)

import 'dart:async';

import 'package:pihka_frontend/storage/base.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum KvString implements PreferenceKeyProvider<KvString, String> {
  empty;

  @override
  String sharedPreferencesKey() {
    return "kv-string-key-$name";
  }

  @override
  KvString getKeyEnum() {
    return this;
  }
}

class KvStringManager extends KvStorageManager<KvString, String> {
  static final _instance = KvStringManager._private();
  KvStringManager._private(): super(
    // Set to shared preferences implementation.
    // Implementing private methods doesn't seem to work as compiler didn't
    // find the method.
    (key, value) async {
      final SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setString(key.sharedPreferencesKey(), value);
    }
  );
  factory KvStringManager.getInstance() {
    return _instance;
  }

  @override
  Future<String?> getValue(KvString key) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(key.sharedPreferencesKey());
  }
}

enum KvInt implements PreferenceKeyProvider<KvInt, int> {
  empty;

  @override
  String sharedPreferencesKey() {
    return "kv-int-key-$name";
  }

  @override
  KvInt getKeyEnum() {
    return this;
  }
}

class KvIntManager extends KvStorageManager<KvInt, int> {
  static final _instance = KvIntManager._private();
  KvIntManager._private(): super(
    // Set to shared preferences implementation.
    // Implementing private methods doesn't seem to work as compiler didn't
    // find the method.
    (key, value) async {
      final SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setInt(key.sharedPreferencesKey(), value);
    }
  );
  factory KvIntManager.getInstance() {
    return _instance;
  }

  @override
  Future<int?> getValue(KvInt key) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt(key.sharedPreferencesKey());
  }
}

enum KvBoolean implements PreferenceKeyProvider<KvBoolean, bool> {
  empty;

  /// Get shared preference key for this type
  @override
  String sharedPreferencesKey() {
    return "kv-boolean-key-$name";
  }

  @override
  KvBoolean getKeyEnum() {
    return this;
  }
}

class KvBooleanManager extends KvStorageManager<KvBoolean, bool> {
  static final _instance = KvBooleanManager._private();
  KvBooleanManager._private(): super(
    // Set to shared preferences implementation.
    // Implementing private methods doesn't seem to work as compiler didn't
    // find the method.
    (key, value) async {
      final SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setBool(key.sharedPreferencesKey(), value);
    }
  );
  factory KvBooleanManager.getInstance() {
    return _instance;
  }

  @override
  Future<bool?> getValue(KvBoolean key) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(key.sharedPreferencesKey());
  }
}
