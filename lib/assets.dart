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
  signInWithGoogleButtonAndroidDark(path: "assets/sign_in_with_google_android_dark_rd_SI@4x.png"),
  signInWithGoogleButtonAndroidLight(path: "assets/sign_in_with_google_android_light_rd_SI@4x.png"),
  signInWithGoogleButtonIosDark(path: "assets/sign_in_with_google_ios_dark_rd_SI@4x.png"),
  signInWithGoogleButtonIosLight(path: "assets/sign_in_with_google_ios_light_rd_SI@4x.png");

  const ImageAsset({required this.path});

  final String path;

  static ImageAsset signInWithGoogleButtonImageDark() {
    if (Platform.isAndroid) {
      return signInWithGoogleButtonAndroidDark;
    } else if (Platform.isIOS) {
      return signInWithGoogleButtonIosDark;
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static ImageAsset signInWithGoogleButtonImageLight() {
    if (Platform.isAndroid) {
      return signInWithGoogleButtonAndroidLight;
    } else if (Platform.isIOS) {
      return signInWithGoogleButtonIosLight;
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }
}
