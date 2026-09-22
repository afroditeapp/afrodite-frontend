import 'dart:convert';
import 'dart:io';

import 'package:app/data/app_version.dart';
import 'package:app/data/login_repository.dart';
import 'package:app/data/utils/sign_in_with_apple.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/logic/sign_in_with.dart';
import 'package:app/config.dart';
import 'package:app/config_services.dart';
import 'package:app/ui/demo_account.dart';
import 'package:app/ui/login_new.dart';
import 'package:app/utils/result.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:rxdart/rxdart.dart';
import 'package:utils/utils.dart';

final _log = Logger("SignInWithGoogleManager");

const String emailScope = "https://www.googleapis.com/auth/userinfo.email";

class SignInWithGoogleManager {
  String _nonceBase64Url = "";
  String _hashedNonceBase64Url = "";

  bool _initDone = false;
  bool _linkingEnabled = false;
  final PublishSubject<SignInWithGoogleInfo> _linkingEvents = PublishSubject();
  Stream<SignInWithGoogleInfo> get linkingEvents => _linkingEvents.stream;

  Future<void> init() async {
    final nonce = generateNonceBytes().toList();
    _nonceBase64Url = base64UrlEncode(nonce);
    _hashedNonceBase64Url = base64UrlEncode(sha256.convert(nonce).bytes);

    if (!(kIsWeb || Platform.isAndroid || Platform.isIOS)) {
      throw UnsupportedError("Unsupported platform");
    }

    try {
      if (!kIsWeb && Platform.isAndroid) {
        await GoogleSignIn.instance.initialize(
          nonce: _hashedNonceBase64Url,
          serverClientId: signInWithGoogleWebClientId(),
        );
      } else {
        await GoogleSignIn.instance.initialize(nonce: _hashedNonceBase64Url);
      }
    } catch (_) {
      _log.error("Init failed");
      return;
    }

    if (kIsWeb) {
      GoogleSignIn.instance.authenticationEvents
          .asyncMap((signedIn) async {
            if (_linkingEnabled) {
              switch (signedIn) {
                case GoogleSignInAuthenticationEventSignIn():
                  final possibleToken = signedIn.user.authentication.idToken;
                  if (possibleToken != null) {
                    _linkingEvents.add(
                      SignInWithGoogleInfo(nonce: _nonceBase64Url, token: possibleToken),
                    );
                  }
                case GoogleSignInAuthenticationEventSignOut():
                  ();
              }
              return;
            }

            final String token;
            switch (signedIn) {
              case GoogleSignInAuthenticationEventSignIn():
                final possibleToken = signedIn.user.authentication.idToken;
                if (possibleToken == null) {
                  showSnackBarTextsForSignInWithEvent(SignInWithGetTokenFailed());
                  return;
                }
                token = possibleToken;
              case GoogleSignInAuthenticationEventSignOut():
                return;
            }

            final info = SignInWithLoginInfo(
              google: SignInWithGoogleInfo(nonce: _nonceBase64Url, token: token),
              clientInfo: await AppVersionManager.getInstance().clientInfoWithAppAttestation(),
            );
            final login = LoginRepository.getInstance();
            final currentServerAddress = await login.accountServerAddress.first;
            final serverAddress = _serverAddressForWebSignIn(currentServerAddress);
            if (serverAddress == null) {
              showSnackBarTextsForSignInWithEvent(SignInWithLoginScreenNotOpen());
              return;
            }
            switch (await login.sendSignInWithLoginCmd(info, serverAddress)) {
              case Ok():
                ();
              case Err(:final e):
                showSnackBarTextsForSignInWithEvent(e);
            }
          })
          .listen((_) {});
    }

    _initDone = true;
  }

  void enableLinking() {
    _linkingEnabled = true;
  }

  void disableLinking() {
    _linkingEnabled = false;
  }

  /// Returns appropriate server address if login screen is open
  String? _serverAddressForWebSignIn(String currentServerAddress) {
    final topPage = NavigationStateBlocInstance.getInstance().navigationState.pages.lastOrNull;
    if (topPage is DemoServerSignInPage) {
      return serverAddressForDemoAccountLogin(currentServerAddress);
    }
    if (topPage is LoginPage) {
      return serverAddressForSignIn(currentServerAddress);
    }
    return null;
  }

  Future<Result<SignInWithGoogleInfo, ()>> login() async {
    if (!_initDone) {
      _log.error("Init is not done");
      return const Err(());
    }

    final String token;

    try {
      final session = await GoogleSignIn.instance.authenticate(scopeHint: [emailScope]);
      final possibleToken = session.authentication.idToken;
      if (possibleToken == null) {
        _log.error("Token is null");
        return const Err(());
      }
      token = possibleToken;
    } catch (_) {
      _log.error("Authenticate method failed");
      return const Err(());
    }

    return Ok(SignInWithGoogleInfo(nonce: _nonceBase64Url, token: token));
  }

  Future<void> logout() async {
    if (!_initDone) {
      _log.error("Init is not done");
      return;
    }

    try {
      await GoogleSignIn.instance.signOut();
    } catch (_) {
      _log.error("Sign out failed");
    }
  }
}
