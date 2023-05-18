import "package:flutter_bloc/flutter_bloc.dart";
import "package:google_sign_in/google_sign_in.dart";
import "package:openapi/api.dart";
import "package:pihka_frontend/data/account_repository.dart";
import "package:pihka_frontend/secrets.dart";
import "package:pihka_frontend/ui/initial_setup.dart";
import "package:rxdart/rxdart.dart";


import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';


abstract class SignInWithEvent {}
class SignInWithGoogle extends SignInWithEvent {
  SignInWithGoogle();
}
class LogOutFromGoogle extends SignInWithEvent {
  LogOutFromGoogle();
}

class SignInWithBloc extends Bloc<SignInWithEvent, String> {
  final AccountRepository account;

  bool signInOngoing = false;
  GoogleSignIn google = GoogleSignIn(serverClientId: signInWithGoogleBackendClientId());

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
  }
}
