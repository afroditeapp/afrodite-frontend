

import 'dart:io';

import 'package:flutter/foundation.dart';

const String _defaultAccountServerAddressAndroid = "http://10.0.2.2:3000"; // Android emulator host
const String _defaultAccountServerAddressIosAndWeb = "http://localhost:3000"; // This address is for iOS simulator and web browsers

const String developmentServerUrl = "https://localhost:3000";

String defaultServerUrlAccount() {
  if (kProfileMode && kIsWeb) {
    return _defaultAccountServerAddressIosAndWeb;
  }

  if (!kDebugMode) {
     return developmentServerUrl;
  }

  if (kIsWeb || Platform.isIOS) {
    return _defaultAccountServerAddressIosAndWeb;
  } else if (Platform.isAndroid) {
    return _defaultAccountServerAddressAndroid;
  } else {
    throw UnimplementedError();
  }
}

String defaultServerUrlMedia() {
  return defaultServerUrlAccount();
}

String defaultServerUrlProfile() {
  return defaultServerUrlAccount();
}

String defaultServerUrlChat() {
  return defaultServerUrlAccount();
}
