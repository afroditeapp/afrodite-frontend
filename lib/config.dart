

import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

const String _defaultAccountServerAddressAndroid = "http://10.0.2.2:3000";
const String _defaultAccountServerAddressIos = "http://192.168.0.1:3000";

String defaultAccountServerAddress() {
  if (Platform.isAndroid) {
    return _defaultAccountServerAddressAndroid;
  } else if (Platform.isIOS) {
    return _defaultAccountServerAddressIos;
  } else {
    throw UnimplementedError();
  }
}

const String _defaultMediaServerAddress = "http://10.0.2.2:3000";
const String _defaultProfileServerAddress = "http://10.0.2.2:3000";

String defaultMediaServerAddress() {
  return _defaultMediaServerAddress;
}

String defaultProfileServerAddress() {
  return _defaultProfileServerAddress;
}


enum ConfigStringKey {
  accountServerAddress,
  mediaServerAddress,
  profileServerAddress;

  String key() {
    return "string-key-$name";
  }

  String defaultValue() {
    switch (this) {
      case accountServerAddress: return defaultAccountServerAddress();
      case profileServerAddress: return defaultProfileServerAddress();
      case mediaServerAddress: return defaultMediaServerAddress();
    }
  }
}

class ConfigManager {
  static final _instance = ConfigManager._private();

  ConfigManager._private();

  factory ConfigManager.getInstance() {
    return _instance;
  }

  /// Get current or default value.
  Future<String> getString(ConfigStringKey key) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(key.key()) ?? key.defaultValue();
  }

  Future<void> setString(ConfigStringKey key, String value) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(key.key(), value);
  }
}
