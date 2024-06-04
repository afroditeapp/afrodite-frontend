import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:pihka_frontend/data/notification_manager.dart';

Future<Uint8List> loadLetsEncryptRootCertificates() async {
  final data = await rootBundle.load("assets/isrg-root-x1-and-x2.pem");
  return data.buffer.asUint8List();
}

Future<SecurityContext> createSecurityContextForBackendConnection() async {
  if (Platform.isAndroid) {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    if (androidInfo.version.sdkInt >= ANDROID_8_API_LEVEL) {
      return SecurityContext.defaultContext;
    } else {
      // Workaround Android 7 and older Let's Encrypt root certificate issue
      // https://letsencrypt.org/docs/certificate-compatibility/
      final context = SecurityContext(withTrustedRoots: true);
      context.setTrustedCertificatesBytes(await loadLetsEncryptRootCertificates());
      return context;
    }
  } else {
    return SecurityContext.defaultContext;
  }
}

enum ImageAsset {
  appLogo(path: "assets/app-icon.png"),
  signInWithGoogleButtonAndroid(path: "assets/sign_in_with_google_android_dark_rd_SI@4x.png"),
  signInWithGoogleButtonIos(path: "assets/sign_in_with_google_ios_dark_rd_SI@4x.png");

  const ImageAsset({required this.path});

  final String path;

  static ImageAsset signInWithGoogleButtonImage() {
    if (Platform.isAndroid) {
      return signInWithGoogleButtonAndroid;
    } else if (Platform.isIOS) {
      return signInWithGoogleButtonIos;
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }
}
