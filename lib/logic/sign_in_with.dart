import "package:flutter_bloc/flutter_bloc.dart";
import "package:pihka_frontend/data/login_repository.dart";
import "package:pihka_frontend/localizations.dart";
import "package:pihka_frontend/model/freezed/logic/sign_in_with.dart";
import "package:pihka_frontend/ui_utils/snack_bar.dart";
import "package:pihka_frontend/utils.dart";

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
              showSnackBar(R.strings.login_screen_sign_in_with_error);
            case SignInWithGoogleEvent.serverRequestFailed:
              showSnackBar(R.strings.generic_error_occurred);
            case SignInWithGoogleEvent.otherError:
              showSnackBar(R.strings.generic_error);
          }
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
