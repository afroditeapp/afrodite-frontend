


import 'dart:io';

Future<SecurityContext> createSecurityContextForBackendConnection() async {
  return SecurityContext.defaultContext;
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
