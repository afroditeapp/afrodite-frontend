import "dart:async";
import "package:app/logic/sign_in_with.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:app/config.dart";
import "package:app/data/login_repository.dart";
import "package:app/data/utils/login_repository_types.dart";
import "package:app/model/freezed/logic/account/email_login.dart";
import "package:app/ui_utils/common_update_logic.dart";
import "package:app/utils.dart";
import "package:app/utils/result.dart";
import "package:app/utils/time.dart";

abstract class EmailLoginEvent {}

class RequestEmailToken extends EmailLoginEvent {
  final String email;

  /// If true, the token is requested for logging in to an existing account.
  final bool loginOnly;
  RequestEmailToken(this.email, {this.loginOnly = false});
}

class SubmitLoginCode extends EmailLoginEvent {
  final String clientToken;
  final String emailToken;
  SubmitLoginCode(this.clientToken, this.emailToken);
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

        final currentServerAddress = await login.accountServerAddress.first;
        final serverAddress = serverAddressForSignIn(currentServerAddress);
        final result = await login.emailLoginRequestToken(
          event.email,
          serverAddress,
          loginOnly: event.loginOnly,
        );

        await waitTime.waitIfNeeded();

        switch (result) {
          case Ok(:final v):
            emit(
              state.copyWith(
                isLoading: false,
                error: null,
                email: event.email,
                clientToken: v.clientToken,
                tokenValiditySeconds: v.tokenValiditySeconds,
                resendWaitSeconds: v.resendWaitSeconds,
              ),
            );
          case Err(:final e):
            emit(state.copyWith(isLoading: false, error: _requestTokenErrorToEmailLoginError(e)));
        }
      });
    });

    on<SubmitLoginCode>((event, emit) async {
      await runOnce(() async {
        emit(state.copyWith(error: null, updateState: const UpdateStarted()));

        final waitTime = WantedWaitingTimeManager();

        emit(state.copyWith(updateState: const UpdateInProgress()));

        final result = await login.emailLoginWithToken(event.clientToken, event.emailToken);

        await waitTime.waitIfNeeded();

        switch (result) {
          case Ok():
            emit(state.copyWith(error: null, updateState: const UpdateIdle()));
          case Err(:final e):
            emit(
              state.copyWith(
                error: LoginFailed(signInErrorToString(e)),
                updateState: const UpdateIdle(),
              ),
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

EmailLoginError _requestTokenErrorToEmailLoginError(EmailLoginRequestTokenError error) {
  switch (error) {
    case ElrteMaintenanceOngoing(:final maintenanceInfo):
      return RequestTokenFailed(maintenanceInfo: maintenanceInfo);
    case ElrteRegistrationAllPlatformsDisabled():
      return RegistrationAllPlatformsDisabledError();
    case ElrteRegistrationPlatformDisabled():
      return RegistrationPlatformDisabledError();
    case ElrteRegistrationIpAddressLimitReached():
      return RegistrationIpAddressLimitReachedError();
    case ElrteRegistrationLimitReached():
      return RegistrationLimitReachedError();
    case ElrteRegistrationDomainNotAccepted(:final domain):
      return RegistrationDomainNotAcceptedError(domain);
    case ElrteErrorOccurred():
      return RequestTokenFailed();
  }
}
