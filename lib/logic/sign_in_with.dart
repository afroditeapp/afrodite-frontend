import "package:flutter_bloc/flutter_bloc.dart";
import "package:app/data/login_repository.dart";
import "package:app/localizations.dart";
import "package:app/model/freezed/logic/sign_in_with.dart";
import "package:app/ui_utils/snack_bar.dart";
import "package:app/utils.dart";

sealed class SignInWithEvent {}
class SignInWithGoogle extends SignInWithEvent {
  SignInWithGoogle();
}
class SignInWithAppleEvent extends SignInWithEvent {
  SignInWithAppleEvent();
}

class SignInWithBloc extends Bloc<SignInWithEvent, SignInWithData> with ActionRunner {
  final LoginRepository login = LoginRepository.getInstance();

  SignInWithBloc() : super(SignInWithData()) {

    on<SignInWithGoogle>((data, emit) async {
      await runOnce(() async {
        await for (final event in login.signInWithGoogle()) {
          switch (event) {
            case SignInWithGoogleEvent.getGoogleAccountTokenCompleted:
              emit(state.copyWith(
                showProgress: true,
              ));
            case SignInWithGoogleEvent.signInWithGoogleFailed:
              ();
            case SignInWithGoogleEvent.serverRequestFailed:
              ();
            case SignInWithGoogleEvent.unsupportedClient:
              ();
            case SignInWithGoogleEvent.otherError:
              ();
          }
          showSnackBarTextsForSignInWithGoogle(event);
        }

        emit(state.copyWith(
          showProgress: false,
        ));
      });
    });
    // Sign in with Apple requires iOS 13.
    on<SignInWithAppleEvent>((data, emit) async {
      await runOnce(() async => await login.signInWithApple());
    });
  }
}

void showSnackBarTextsForSignInWithGoogle(SignInWithGoogleEvent event) {
  switch (event) {
    case SignInWithGoogleEvent.getGoogleAccountTokenCompleted:
      ();
    case SignInWithGoogleEvent.signInWithGoogleFailed:
      showSnackBar(R.strings.login_screen_sign_in_with_error);
    case SignInWithGoogleEvent.serverRequestFailed:
      showSnackBar(R.strings.generic_error_occurred);
    case SignInWithGoogleEvent.unsupportedClient:
      showSnackBar(R.strings.generic_error_app_version_is_unsupported);
    case SignInWithGoogleEvent.otherError:
      showSnackBar(R.strings.generic_error);
  }
}
