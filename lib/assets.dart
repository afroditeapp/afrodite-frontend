


import 'dart:io';

import 'package:flutter/services.dart';

Future<Uint8List> loadServerRootCert() async {
  final data = await rootBundle.load("assets_not_in_git/server_root.crt");
  return data.buffer.asUint8List();
}

Future<SecurityContext> createSecurityContextForBackendConnection() async {
    final context = SecurityContext(withTrustedRoots: false);
    context.setTrustedCertificatesBytes(await loadServerRootCert());
    context.allowLegacyUnsafeRenegotiation = false;
    return context;
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
