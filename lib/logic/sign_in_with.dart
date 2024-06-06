import "dart:io";

import "package:flutter_bloc/flutter_bloc.dart";
import "package:google_sign_in/google_sign_in.dart";
import "package:pihka_frontend/data/login_repository.dart";
import "package:pihka_frontend/localizations.dart";
import "package:pihka_frontend/secrets.dart";
import "package:pihka_frontend/ui_utils/snack_bar.dart";
import "package:pihka_frontend/utils.dart";
import "package:pihka_frontend/utils/result.dart";




sealed class SignInWithEvent {}
class SignInWithGoogle extends SignInWithEvent {
  SignInWithGoogle();
}
class SignInWithAppleEvent extends SignInWithEvent {
  SignInWithAppleEvent();
}

class SignInWithBloc extends Bloc<SignInWithEvent, String> with ActionRunner {
  final LoginRepository login = LoginRepository.getInstance();

  SignInWithBloc() : super("") {

    on<SignInWithGoogle>((data, emit) async {
      await runOnce(() async {
        final result = await login.signInWithGoogle();
        switch (result) {
          case Ok():
            ();
          case Err(e: SignInWithGoogleError.signInWithGoogleFailed):
            showSnackBar(R.strings.login_screen_sign_in_with_error);
          case Err(e: SignInWithGoogleError.serverRequestFailed):
            showSnackBar(R.strings.generic_error_occurred);
          case Err(e: SignInWithGoogleError.otherError):
            showSnackBar(R.strings.generic_error);
        }
      });
    });
    // Sign in with Apple requires iOS 13.
    on<SignInWithAppleEvent>((data, emit) async {
      await runOnce(() async => await login.signInWithApple());
    });
  }
}
