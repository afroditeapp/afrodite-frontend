
import 'dart:convert';
import 'dart:io';

import 'package:app/data/login_repository.dart';
import 'package:app/data/utils/sign_in_with_apple.dart';
import 'package:app/logic/sign_in_with.dart';
import 'package:app/service_config.dart';
import 'package:app/utils/result.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:utils/utils.dart';

final log = Logger("SignInWithGoogleManager");

const String emailScope = "https://www.googleapis.com/auth/userinfo.email";

class SignInWithGoogleManager {
  String _nonceBase64Url = "";
  String _hashedNonceBase64Url = "";

  bool _initDone = false;

  Future<void> init() async {
    final nonce = generateNonceBytes().toList();
    _nonceBase64Url = base64UrlEncode(nonce);
    _hashedNonceBase64Url = base64UrlEncode(sha256.convert(nonce).bytes);

    if (!(kIsWeb || Platform.isAndroid || Platform.isIOS)) {
      throw UnsupportedError("Unsupported platform");
    }

    try {
      if (kIsWeb || Platform.isAndroid) {
        await GoogleSignIn.instance.initialize(
          nonce: _hashedNonceBase64Url,
        );
      } else if (Platform.isIOS) {
        await GoogleSignIn.instance.initialize(
          serverClientId: signInWithGoogleBackendClientId(),
        );
      }
    } catch (_) {
      log.error("Init failed");
      return;
    }

    if (kIsWeb) {
      GoogleSignIn
        .instance
        .authenticationEvents
        .asyncMap((signedIn) async {
          final String token;
          switch (signedIn) {
            case GoogleSignInAuthenticationEventSignIn():
              final possibleToken = signedIn.user.authentication.idToken;
              if (possibleToken == null) {
                showSnackBarTextsForSignInWithEvent(SignInWithEvent.getTokenFailed);
                return;
              }
              token = possibleToken;
            case GoogleSignInAuthenticationEventSignOut():
              return;
          }

          final info = SignInWithLoginInfo(
            google: SignInWithGoogleInfo(nonce: _nonceBase64Url, token: token),
            clientInfo: LoginRepository.getInstance().clientInfo(),
          );
          switch (await LoginRepository.getInstance().handleSignInWithLoginInfo(info)) {
            case Ok():
              ();
            case Err(:final e):
              showSnackBarTextsForSignInWithEvent(e);
          }
        }).listen((_) {});
    }

    _initDone = true;
  }

  Future<Result<SignInWithLoginInfo, void>> login() async {
    if (!_initDone) {
      log.error("Init is not done");
      return const Err(null);
    }

    final String token;

    try {
      final session = await GoogleSignIn.instance.authenticate(scopeHint: [emailScope]);
      final possibleToken = session.authentication.idToken;
      if (possibleToken == null) {
        log.error("Token is null");
        return const Err(null);
      }
      token = possibleToken;
    } catch (_) {
      log.error("Authenticate method failed");
      return const Err(null);
    }

    return Ok(SignInWithLoginInfo(
      google: SignInWithGoogleInfo(nonce: _nonceBase64Url, token: token),
      clientInfo: LoginRepository.getInstance().clientInfo(),
    ));
  }

  Future<void> logout() async {
    if (!_initDone) {
      log.error("Init is not done");
      return;
    }

    try {
      await GoogleSignIn.instance.signOut();
    } catch (_) {
      log.error("Sign out failed");
    }
  }
}
