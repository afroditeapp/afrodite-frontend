import 'dart:js_interop';
import 'dart:js_interop_unsafe';
import 'package:flutter/foundation.dart';
import 'package:web/web.dart';

/// Returns whether the app is running in PWA (Progressive Web App) mode
bool isRunningInPwaMode() {
  // Check if running as standalone PWA
  try {
    // Check display-mode media query
    final isStandalone = window.matchMedia('(display-mode: standalone)').matches;
    if (isStandalone) {
      return true;
    }

    // Check for iOS Safari standalone mode
    final navigatorObj = window.navigator as JSObject;
    final standalone = navigatorObj.getProperty('standalone'.toJS);
    if (standalone != null && standalone.dartify() == true) {
      return true;
    }

    return false;
  } catch (e) {
    return false;
  }
}

/// Returns whether the app is running on iOS web browser
bool isIosWeb() {
  return kIsWeb && defaultTargetPlatform == TargetPlatform.iOS;
}

/// Returns whether the app is running on iOS 26 or newer
bool isIos26OrNewer() {
  if (!isIosWeb()) {
    return false;
  }

  try {
    final userAgent = window.navigator.userAgent;
    // Assume that major version of iOS and Safari matches
    final versionMatch = RegExp(r'Version/(\d+)').firstMatch(userAgent);
    if (versionMatch == null) {
      return false;
    }
    final majorVersion = int.parse(versionMatch.group(1)!);
    return majorVersion >= 26;
  } catch (e) {
    return false;
  }
}
