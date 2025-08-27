import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:openapi/api.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:utils/utils.dart';

class AppVersionManager extends AppSingleton {
  static final _instance = AppVersionManager._();
  AppVersionManager._();
  factory AppVersionManager.getInstance() {
    return _instance;
  }

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
