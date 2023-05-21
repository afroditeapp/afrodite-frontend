import "dart:io";

import "package:flutter/services.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:google_sign_in/google_sign_in.dart";
import "package:openapi/api.dart";
import "package:pihka_frontend/data/account_repository.dart";
import "package:pihka_frontend/secrets.dart";
import "package:pihka_frontend/ui/initial_setup.dart";
import "package:rxdart/rxdart.dart";


import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';
import "package:sign_in_with_apple/sign_in_with_apple.dart";


abstract class SignInWithEvent {}
class SignInWithGoogle extends SignInWithEvent {
  SignInWithGoogle();
}
class LogOutFromGoogle extends SignInWithEvent {
  LogOutFromGoogle();
}

class SignInWithAppleEvent extends SignInWithEvent {
  SignInWithAppleEvent();
}
class SignOutFromAppleEvent extends SignInWithEvent {
  SignOutFromAppleEvent();
}

class SignInWithBloc extends Bloc<SignInWithEvent, String> {
  final AccountRepository account;

  bool signInOngoing = false;
  GoogleSignIn google = createSignInWithGoogle();

  SignInWithBloc(this.account) : super("") {

    on<SignInWithGoogle>((data, emit) async {
      if (!signInOngoing) {
        signInOngoing = true;
        final signedIn = await google.signIn();
        if (signedIn != null) {
          print(signedIn.toString());
          print(signedIn.email.toString());

          var token = await signedIn.authentication;
          print(token.accessToken);
          print(token.idToken);

          await account.api.account.postSignInWithLogin(SignInWithLoginInfo(googleToken: token.idToken));
        }
        signInOngoing = false;
      }
    });
    on<LogOutFromGoogle>((data, emit) async {
      if (!signInOngoing) {
        signInOngoing = true;
        final signedIn = await google.disconnect();
        print(signedIn);
        if (signedIn != null) {
          print(signedIn.toString());
          print(signedIn.email.toString());
        }
        signInOngoing = false;
      }
    });

    // Sign in with Apple requires iOS 13.
    on<SignInWithAppleEvent>((data, emit) async {
      if (!signInOngoing) {
        signInOngoing = true;
        AuthorizationCredentialAppleID signedIn;

        try {
          signedIn = await SignInWithApple.getAppleIDCredential(scopes: [
            AppleIDAuthorizationScopes.email,
          ]);
          print(signedIn);
          await account.api.account.postSignInWithLogin(SignInWithLoginInfo(appleToken: signedIn.identityToken));
        } on SignInWithAppleException catch (e) {
          print(e);
        }
        signInOngoing = false;
      }
    });

    // TODO: or is not possible to support?
    on<SignOutFromAppleEvent>((data, emit) async {
      if (!signInOngoing) {
        signInOngoing = true;
        // TODO
        signInOngoing = false;
      }
    });
  }
}

// TODO: make sure that iOS client id does not end in Android apk.

GoogleSignIn createSignInWithGoogle() {
  if (Platform.isAndroid) {
    return GoogleSignIn(serverClientId: signInWithGoogleBackendClientId());
  } else if (Platform.isIOS) {
    return GoogleSignIn(
      clientId: signInWithGoogleIosClientId(),
      serverClientId: signInWithGoogleBackendClientId()
    );
  } else {
    throw UnsupportedError("Unsupported platform");
  }
}
