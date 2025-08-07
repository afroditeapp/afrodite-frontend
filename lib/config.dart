

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

const String _defaultServerAddressAndroid = "http://10.0.2.2:3000"; // Android emulator host
const String _defaultServerAddressIosAndWeb = "http://localhost:3000"; // This address is for iOS simulator and web browsers

const String developmentServerUrl = "https://localhost:3000";

String defaultServerUrl() {
  if (kProfileMode && kIsWeb) {
    return _defaultServerAddressIosAndWeb;
  }

  if (!kDebugMode) {
     return developmentServerUrl;
  }

  if (kIsWeb || Platform.isIOS) {
    return _defaultServerAddressIosAndWeb;
  } else if (Platform.isAndroid) {
    return _defaultServerAddressAndroid;
  } else {
    throw UnimplementedError();
  }
}

const List<DeviceOrientation> DEFAULT_ORIENTATIONS = [
  DeviceOrientation.portraitUp,
  DeviceOrientation.portraitDown,
];

const String? GIT_COMMIT_ID = bool.hasEnvironment("GIT_COMMIT_ID") ?
  String.fromEnvironment("GIT_COMMIT_ID") : null;
