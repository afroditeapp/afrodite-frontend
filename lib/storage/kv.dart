/// Key value storage

import 'dart:async';

import 'package:pihka_frontend/storage/base.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum KvString implements PreferenceKeyProvider<KvString, String> {
  /// Url
  accountServerAddress,
  /// Url
  mediaServerAddress,
  /// Url
  profileServerAddress,

  /// UUID string
  accountId,
  /// Capabilities json
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
  profileAccessToken,

  // Location json
  profileLocation;

  @override
  String sharedPreferencesKey() {
    return "kv-string-key-$name";
  }

  @override
  KvString getKeyEnum() {
    return this;
  }
}

enum KvDouble implements PreferenceKeyProvider<KvDouble, double> {
  empty;

  /// Get shared preference key for this KvDouble
  @override
  String sharedPreferencesKey() {
    return "kv-double-key-$name";
  }

  @override
  KvDouble getKeyEnum() {
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

class KvDoubleManager extends KvStorageManager<KvDouble, double> {
  static final _instance = KvDoubleManager._private();
  KvDoubleManager._private(): super(
    // Set to shared preferences implementation.
    // Implementing private methods doesn't seem to work as compiler didn't
    // find the method.
    (key, value) async {
      final SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setDouble(key.sharedPreferencesKey(), value);
    }
  );
  factory KvDoubleManager.getInstance() {
    return _instance;
  }

  @override
  Future<double?> getValue(KvDouble key) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getDouble(key.sharedPreferencesKey());
  }
}
