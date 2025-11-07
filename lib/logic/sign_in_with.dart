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

  Future<void> _handleSignInWith(
    Emitter<SignInWithData> emit,
    Stream<SignInWithEvent> stream,
  ) async {
    await for (final event in stream) {
      if (event is SignInWithGetTokenCompleted) {
        emit(state.copyWith(showProgress: true));
      }
      showSnackBarTextsForSignInWithEvent(event);
    }

    emit(state.copyWith(showProgress: false));
  }
}

void showSnackBarTextsForSignInWithEvent(SignInWithEvent event) {
  switch (event) {
    case SignInWithGetTokenCompleted():
      ();
    case SignInWithGetTokenFailed():
      showSnackBar(R.strings.login_screen_sign_in_with_error);
    case SignInWithSignInError(:final error):
      showSnackBar(signInErrorToString(error));
  }
}

String signInErrorToString(CommonSignInError error) {
  switch (error) {
    case CommonSignInError.loginApiRequestFailed:
      return R.strings.login_screen_login_api_request_failed;
    case CommonSignInError.unsupportedClient:
      return R.strings.generic_error_app_version_is_unsupported;
    case CommonSignInError.signInWithEmailUnverified:
      return R.strings.login_screen_sign_in_with_email_unverified;
    case CommonSignInError.emailAlreadyUsed:
      return R.strings.login_screen_email_already_used;
    case CommonSignInError.accountLocked:
      return R.strings.generic_account_locked_error;
    case CommonSignInError.invalidEmailLoginToken:
      return R.strings.login_screen_invalid_email_login_token;
    case CommonSignInError.creatingConnectingWebSocketFailed:
      return R.strings.login_screen_connecting_websocket_failed;
    case CommonSignInError.dataSyncFailed:
      return R.strings.generic_data_sync_failed;
    case CommonSignInError.otherError:
      return R.strings.generic_error;
  }
}
