import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:utils/utils.dart';

final _log = Logger("AppVersionManager");

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

  String? _previousVersion;

  ClientVersion get clientVersion => ClientVersion(major: major, minor: minor, patch_: patch);

  @override
  Future<void> init() async {
    final packageInfo = await PackageInfo.fromPlatform();
    appVersion = packageInfo.version;

    final numbers = appVersion.split(".");

    major = int.parse(numbers[0]);
    minor = int.parse(numbers[1]);
    patch = int.parse(numbers[2]);

    // Load previous version from shared preferences
    final prefs = SharedPreferencesAsync();
    _previousVersion = await prefs.getString(_keyPreviousVersion);

    // Save current version for next launch
    await prefs.setString(_keyPreviousVersion, appVersion);
  }

  /// Returns true if the app major version is 0 and the minor version has changed
  /// since the last run, or if the app transitioned from major version 0 to 1+.
  /// This is useful for preview versions where breaking changes may
  /// require database resets.
  bool previewVersionMinorVersionChangedOrTransitionToStableVersionsHappened() {
    final previousVersion = _previousVersion;
    if (previousVersion == null) {
      return false;
    }

    final previousNumbers = previousVersion.split(".");
    if (previousNumbers.length < 2) {
      return false;
    }

    final previousMajor = int.tryParse(previousNumbers[0]);
    if (previousMajor == null) {
      return false;
    }

    if (previousMajor == 0 && major >= 1) {
      _log.info("App version changed, previous: $previousVersion, current: $appVersion");
      return true;
    }

    if (major != 0) {
      return false;
    }

    final previousMinor = int.tryParse(previousNumbers[1]);
    if (previousMinor == null) {
      return false;
    }

    if (previousMinor != minor) {
      _log.info("App version changed, previous: $previousVersion, current: $appVersion");
      return true;
    } else {
      return false;
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
