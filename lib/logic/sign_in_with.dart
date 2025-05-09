import "package:flutter_bloc/flutter_bloc.dart";
import "package:app/data/login_repository.dart";
import "package:app/localizations.dart";
import "package:app/model/freezed/logic/sign_in_with.dart";
import "package:app/ui_utils/snack_bar.dart";
import "package:app/utils.dart";

sealed class SignInWithBlocEvent {}
class SignInWithGoogle extends SignInWithBlocEvent {}
class SignInWithAppleEvent extends SignInWithBlocEvent {}

class SignInWithBloc extends Bloc<SignInWithBlocEvent, SignInWithData> with ActionRunner {
  final LoginRepository login = LoginRepository.getInstance();

  SignInWithBloc() : super(SignInWithData()) {
    on<SignInWithGoogle>((data, emit) async {
      await runOnce(() async {
        await _handleSignInWith(emit, login.signInWithGoogle());
      });
    });
    on<SignInWithAppleEvent>((data, emit) async {
      // On Android this might not never complete
      await _handleSignInWith(emit, login.signInWithApple());
    });
  }

  Future<void> _handleSignInWith(Emitter<SignInWithData> emit, Stream<SignInWithEvent> stream) async {
    await for (final event in stream) {
      switch (event) {
        case SignInWithEvent.getTokenCompleted:
          emit(state.copyWith(
            showProgress: true,
          ));
        case SignInWithEvent.getTokenFailed:
          ();
        case SignInWithEvent.serverRequestFailed:
          ();
        case SignInWithEvent.unsupportedClient:
          ();
        case SignInWithEvent.otherError:
          ();
      }
      showSnackBarTextsForSignInWithEvent(event);
    }

    emit(state.copyWith(
      showProgress: false,
    ));
  }
}

void showSnackBarTextsForSignInWithEvent(SignInWithEvent event) {
  switch (event) {
    case SignInWithEvent.getTokenCompleted:
      ();
    case SignInWithEvent.getTokenFailed:
      showSnackBar(R.strings.login_screen_sign_in_with_error);
    case SignInWithEvent.serverRequestFailed:
      showSnackBar(R.strings.generic_error_occurred);
    case SignInWithEvent.unsupportedClient:
      showSnackBar(R.strings.generic_error_app_version_is_unsupported);
    case SignInWithEvent.otherError:
      showSnackBar(R.strings.generic_error);
  }
}
