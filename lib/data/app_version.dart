import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:openapi/api.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:utils/utils.dart';

class AppVersionManager extends AppSingleton {
  static final _instance = AppVersionManager._();
  AppVersionManager._();
  factory AppVersionManager.getInstance() {
    return _instance;
  }

  static const String _keyPreviousVersion = 'previous_app_version';

  late String appVersion;
  late int major;
  late int minor;
  late int patch;

  ClientVersion get clientVersion => ClientVersion(major: major, minor: minor, patch_: patch);

  @override
  Future<void> init() async {
    final packageInfo = await PackageInfo.fromPlatform();
    appVersion = packageInfo.version;

    final numbers = appVersion.split(".");

    major = int.parse(numbers[0]);
    minor = int.parse(numbers[1]);
    patch = int.parse(numbers[2]);
  }

  /// Persists the current app version for use on next app launch.
  Future<void> updateAppVersionInSharedPrefs() async {
    final prefs = SharedPreferencesAsync();
    final previousVersion = await prefs.getString(_keyPreviousVersion);

    if (previousVersion != appVersion) {
      await prefs.setString(_keyPreviousVersion, appVersion);
    }
  }

  ClientInfo clientInfo() {
    final ClientType clientType;
    if (kIsWeb) {
      clientType = ClientType.web;
    } else if (Platform.isAndroid) {
      clientType = ClientType.android;
    } else if (Platform.isIOS) {
      clientType = ClientType.ios;
    } else {
      throw UnsupportedError("Unsupported platform");
    }
    return ClientInfo(clientType: clientType, clientVersion: clientVersion);
  }
}
