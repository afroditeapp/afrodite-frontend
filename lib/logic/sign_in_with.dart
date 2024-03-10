import "dart:io";

import "package:flutter_bloc/flutter_bloc.dart";
import "package:google_sign_in/google_sign_in.dart";
import "package:pihka_frontend/data/account_repository.dart";
import "package:pihka_frontend/secrets.dart";
import "package:pihka_frontend/utils.dart";




sealed class SignInWithEvent {}
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

class SignInWithBloc extends Bloc<SignInWithEvent, String> with ActionRunner {
  final AccountRepository account;

  GoogleSignIn google = createSignInWithGoogle();

  SignInWithBloc(this.account) : super("") {

    on<SignInWithGoogle>((data, emit) async {
      await runOnce(() async => await account.signInWithGoogle(google));
    });
    on<LogOutFromGoogle>((data, emit) async {
      await runOnce(() async => await account.signOutFromGoogle(google));
    });

    // Sign in with Apple requires iOS 13.
    on<SignInWithAppleEvent>((data, emit) async {
      await runOnce(() async => await account.signInWithApple());
    });

    // TODO: or is not possible to support?
    on<SignOutFromAppleEvent>((data, emit) async {
      // TODO
    });
  }
}

// TODO: make sure that iOS client id does not end in Android apk.

GoogleSignIn createSignInWithGoogle() {
  if (Platform.isAndroid) {
    return GoogleSignIn(
      serverClientId: signInWithGoogleBackendClientId(),
      scopes: ["email"],
    );
  } else if (Platform.isIOS) {
    return GoogleSignIn(
      clientId: signInWithGoogleIosClientId(),
      serverClientId: signInWithGoogleBackendClientId(),
      scopes: ["email"],
    );
  } else {
    throw UnsupportedError("Unsupported platform");
  }
}
