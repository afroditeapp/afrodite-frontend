import "package:flutter_bloc/flutter_bloc.dart";
import "package:app/config.dart";
import "package:app/data/app_version.dart";
import "package:app/data/login_repository.dart";
import "package:app/data/utils/login_repository_types.dart";
import "package:app/localizations.dart";
import "package:app/model/freezed/logic/sign_in_with.dart";
import "package:app/ui_utils/snack_bar.dart";
import "package:app/utils.dart";
import "package:openapi/api.dart";

/// Returns the server address to use for a sign in action.
///
/// When [demoServer] is null, the [currentServerAddress] is used as is.
/// When [demoServer] is true, the demo server address is used.
/// When [demoServer] is false, the normal server address is used.
String serverAddressForSignInAction(String currentServerAddress, bool? demoServer) {
  if (demoServer == null) {
    return currentServerAddress;
  }
  return demoServer
      ? serverAddressForDemoAccountLogin(currentServerAddress)
      : serverAddressForSignIn(currentServerAddress);
}

sealed class SignInWithBlocEvent {}

class SignInWithGoogle extends SignInWithBlocEvent {
  /// If true, the sign in is done against the demo server instead of the
  /// normal server. If false, the sign in is done against the normal server.
  /// If null, the current server address is used.
  final bool? demoServer;
  SignInWithGoogle({required this.demoServer});
}

class SignInWithAppleEvent extends SignInWithBlocEvent {
  /// If true, the sign in is done against the demo server instead of the
  /// normal server. If false, the sign in is done against the normal server.
  /// If null, the current server address is used.
  final bool? demoServer;
  SignInWithAppleEvent({required this.demoServer});
}

class SignInWithBloc extends Bloc<SignInWithBlocEvent, SignInWithData> with ActionRunner {
  final LoginRepository login = LoginRepository.getInstance();

  SignInWithBloc() : super(SignInWithData()) {
    on<SignInWithGoogle>((data, emit) async {
      await runOnce(() async {
        final currentServerAddress = await login.accountServerAddress.first;
        final serverAddress = serverAddressForSignInAction(currentServerAddress, data.demoServer);
        await _handleSignInWith(emit, login.signInWithGoogle(serverAddress));
      });
    });
    on<SignInWithAppleEvent>((data, emit) async {
      // On Android this might not never complete
      final currentServerAddress = await login.accountServerAddress.first;
      final serverAddress = serverAddressForSignInAction(currentServerAddress, data.demoServer);
      await _handleSignInWith(emit, login.signInWithApple(serverAddress));
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
    case SignInWithLoginScreenNotOpen():
      showSnackBar(R.strings.login_screen_sign_in_with_login_screen_not_open);
    case SignInWithSignInError(:final error):
      showSnackBar(signInErrorToString(error));
  }
}

String signInErrorToString(CommonSignInError error) {
  switch (error) {
    case CseLoginApiRequestFailed():
      return R.strings.login_screen_login_api_request_failed;
    case CseUnsupportedClient():
      return R.strings.generic_error_app_version_is_unsupported;
    case CseRegistrationAllPlatformsDisabled():
      return R.strings.login_screen_registration_all_platforms_disabled;
    case CseRegistrationPlatformDisabled():
      return R.strings.login_screen_registration_platform_disabled(platformNameFromClientType());
    case CseLoginAllPlatformsDisabled():
      return R.strings.login_screen_login_all_platforms_disabled;
    case CseLoginPlatformDisabled():
      return R.strings.login_screen_login_platform_disabled(platformNameFromClientType());
    case CseSignInWithEmailUnverified():
      return R.strings.login_screen_sign_in_with_email_unverified;
    case CseEmailAlreadyUsed():
      return R.strings.login_screen_email_already_used;
    case CseAccountLocked():
      return R.strings.generic_account_locked_error;
    case CseAppAttestationAppIntegrity():
      return R.strings.login_screen_app_attestation_app_integrity_error;
    case CseAppAttestationDeviceIntegrity():
      return R.strings.login_screen_app_attestation_device_integrity_error;
    case CseAppAttestationFailed():
      return R.strings.login_screen_app_attestation_failed;
    case CseInvalidEmailLoginToken():
      return R.strings.login_screen_invalid_email_login_token;
    case CseCreatingConnectingWebSocketFailed():
      return R.strings.login_screen_connecting_websocket_failed;
    case CseMaintenanceOngoing(:final maintenanceInfo):
      return maintenanceInfo.default_;
    case CseDataSyncFailed():
      return R.strings.generic_data_sync_failed;
    case CseOtherError():
      return R.strings.generic_error;
  }
}

String platformNameFromClientType() {
  final clientType = AppVersionManager.getInstance().clientType;
  if (clientType == ClientType.android) {
    return "Android";
  } else if (clientType == ClientType.ios) {
    return "iOS";
  } else if (clientType == ClientType.web) {
    return "Web";
  } else {
    return "null";
  }
}
