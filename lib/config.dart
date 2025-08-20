import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

const String _debugServerUrlAndroid = "http://10.0.2.2:3000"; // Android emulator host
const String _debugServerUrlIosAndWeb =
    "http://localhost:3000"; // This address is for iOS simulator and web browsers

const String _serverUrl = "https://localhost:3000";

String defaultServerUrl() {
  if (kReleaseMode) {
    return _serverUrl;
  }

  if (kIsWeb || Platform.isIOS) {
    return _debugServerUrlIosAndWeb;
  } else if (Platform.isAndroid) {
    return _debugServerUrlAndroid;
  } else {
    throw UnimplementedError();
  }
}

const List<DeviceOrientation> DEFAULT_ORIENTATIONS = [
  DeviceOrientation.portraitUp,
  DeviceOrientation.portraitDown,
];

const String? GIT_COMMIT_ID = bool.hasEnvironment("GIT_COMMIT_ID")
    ? String.fromEnvironment("GIT_COMMIT_ID")
    : null;
