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

  /// Returns `true` when a major/minor downgrade is detected.
  /// Version in shared preferences is not updated when downgrade is detected.
  Future<bool> detectAppVersionDowngradeAndUpdateAppVersionInSharedPrefs() async {
    final prefs = SharedPreferencesAsync();
    final previousVersion = await prefs.getString(_keyPreviousVersion);

    if (previousVersion != null && _isMajorOrMinorDowngrade(previousVersion, appVersion)) {
      return true;
    }

    if (previousVersion != appVersion) {
      await prefs.setString(_keyPreviousVersion, appVersion);
    }

    return false;
  }

  bool _isMajorOrMinorDowngrade(String previousVersion, String currentVersion) {
    final previous = _parseVersion(previousVersion);
    final current = _parseVersion(currentVersion);
    if (previous == null || current == null) {
      return false;
    }

    final (previousMajor, previousMinor, _) = previous;
    final (currentMajor, currentMinor, _) = current;

    if (currentMajor < previousMajor) {
      return true;
    }

    if (currentMajor == previousMajor && currentMinor < previousMinor) {
      return true;
    }

    return false;
  }

  (int, int, int)? _parseVersion(String version) {
    final match = RegExp(r'^(\d+)\.(\d+)\.(\d+)').firstMatch(version);
    if (match == null) {
      return null;
    }

    final majorString = match.group(1);
    final minorString = match.group(2);
    final patchString = match.group(3);
    if (majorString == null || minorString == null || patchString == null) {
      return null;
    }

    final major = int.tryParse(majorString);
    final minor = int.tryParse(minorString);
    final patch = int.tryParse(patchString);
    if (major == null || minor == null || patch == null) {
      return null;
    }

    return (major, minor, patch);
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
