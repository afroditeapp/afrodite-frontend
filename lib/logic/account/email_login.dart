import "dart:async";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:app/data/login_repository.dart";
import "package:app/model/freezed/logic/account/email_login.dart";
import "package:app/ui_utils/common_update_logic.dart";
import "package:app/utils.dart";
import "package:app/utils/result.dart";
import "package:app/utils/time.dart";

abstract class EmailLoginEvent {}

class RequestEmailToken extends EmailLoginEvent {
  final String email;
  RequestEmailToken(this.email);
}

class SubmitLoginCode extends EmailLoginEvent {
  final String code;
  SubmitLoginCode(this.code);
}

class UpdateTokenValidity extends EmailLoginEvent {}

class EmailLoginBloc extends Bloc<EmailLoginEvent, EmailLoginBlocData> with ActionRunner {
  final LoginRepository login;
  Timer? _tokenValidityTimer;

  EmailLoginBloc() : login = LoginRepository.getInstance(), super(EmailLoginBlocData()) {
    on<RequestEmailToken>((event, emit) async {
      await runOnce(() async {
        emit(state.copyWith(isLoading: true, error: null));

        final waitTime = WantedWaitingTimeManager();

        final result = await login.emailLoginRequestToken(event.email);

        await waitTime.waitIfNeeded();

        switch (result) {
          case Ok(:final v):
            emit(
              state.copyWith(
                isLoading: false,
                error: null,
                email: event.email,
                tokenValiditySeconds: v.tokenValiditySeconds,
                resendWaitSeconds: v.resendWaitSeconds,
              ),
            );
          case Err():
            emit(state.copyWith(isLoading: false, error: EmailLoginError.requestTokenFailed));
        }
      });
    });

    on<SubmitLoginCode>((event, emit) async {
      await runOnce(() async {
        emit(state.copyWith(error: null, updateState: const UpdateStarted()));

        final waitTime = WantedWaitingTimeManager();

        emit(state.copyWith(updateState: const UpdateInProgress()));

        final result = await login.emailLoginWithToken(event.code);

        await waitTime.waitIfNeeded();

        switch (result) {
          case Ok(:final v):
            // Other LoginResult errors are not related to email login
            if (v.errorUnsupportedClient) {
              emit(
                state.copyWith(
                  error: EmailLoginError.unsupportedClient,
                  updateState: const UpdateIdle(),
                ),
              );
            } else if (v.tokens != null && v.aid != null) {
              // Login successful - the login repository will handle the session
              emit(state.copyWith(error: null, updateState: const UpdateIdle()));
            } else {
              emit(
                state.copyWith(error: EmailLoginError.loginFailed, updateState: const UpdateIdle()),
              );
            }
          case Err():
            emit(
              state.copyWith(error: EmailLoginError.loginFailed, updateState: const UpdateIdle()),
            );
        }
      });
    });

    on<UpdateTokenValidity>((event, emit) async {
      if (state.tokenValiditySeconds != null && state.tokenValiditySeconds! > 0) {
        emit(state.copyWith(tokenValiditySeconds: state.tokenValiditySeconds! - 1));
      } else {
        _tokenValidityTimer?.cancel();
      }
    });
  }

  void startTokenValidityTimer() {
    _tokenValidityTimer?.cancel();
    _tokenValidityTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      add(UpdateTokenValidity());
    });
  }

  @override
  Future<void> close() {
    _tokenValidityTimer?.cancel();
    return super.close();
  }
}
