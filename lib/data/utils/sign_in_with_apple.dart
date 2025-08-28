import 'dart:convert';

import 'package:app/data/login_repository.dart';
import 'package:app/data/utils/web_api_empty.dart'
    if (dart.library.js_interop) 'package:web/web.dart'
    show window;
import 'package:app/service_config.dart';
import 'package:app/utils/result.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:openapi/api.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:utils/utils.dart';

Uri signInWithAppleRedirectUrlForWeb() {
  return Uri.parse("https://${window.location.host}");
}

Uint8List generateNonceBytes() {
  return generate256BitRandomValue();
}

class SignInWithAppleManager {
  /// On Android this might not never complete
  static Future<Result<SignInWithAppleInfo, SignInWithEvent>> signInWithApple({
    required String currentServerAddress,
  }) async {
    final Uri serverUrl;
    try {
      serverUrl = Uri.parse(currentServerAddress);
    } catch (_) {
      return Err(SignInWithSignInError(CommonSignInError.otherError));
    }

    final nonce = generateNonceBytes().toList();
    final nonceBase64Url = base64UrlEncode(nonce);
    final hashedNonceBase64Url = base64UrlEncode(sha256.convert(nonce).bytes);

    AuthorizationCredentialAppleID signedIn;
    try {
      // On Android this might not never complete
      signedIn = await SignInWithApple.getAppleIDCredential(
        scopes: [AppleIDAuthorizationScopes.email],
        webAuthenticationOptions: WebAuthenticationOptions(
          clientId: signInWithAppleServiceIdForAndroidAndWebLogin(),
          redirectUri: kIsWeb
              ? signInWithAppleRedirectUrlForWeb()
              : serverUrl.replace(path: "account_api/sign_in_with_apple_redirect_to_app"),
        ),
        nonce: hashedNonceBase64Url,
      );
    } on SignInWithAppleException catch (_) {
      return Err(SignInWithGetTokenFailed());
    }

    final token = signedIn.identityToken;
    if (token == null) {
      return Err(SignInWithGetTokenFailed());
    }

    return Ok(SignInWithAppleInfo(nonce: nonceBase64Url, token: token));
  }
}
