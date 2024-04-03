/// Key value storage

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
