import "dart:async";

import "package:app/data/login_repository.dart";
import "package:app/data/utils/repository_instances.dart";
import "package:app/data/utils/sign_in_with_apple.dart";
import "package:app/localizations.dart";
import "package:app/model/freezed/logic/account/sign_in_with_management.dart";
import "package:app/ui_utils/common_update_logic.dart";
import "package:app/ui_utils/snack_bar.dart";
import "package:app/utils/app_error.dart";
import "package:app/utils/result.dart";
import "package:app/utils/time.dart";
import "package:app/utils.dart";
import "package:flutter/foundation.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";

sealed class SignInWithManagementEvent {}

class ReloadSignInWithManagement extends SignInWithManagementEvent {}

class LinkAppleSignInWith extends SignInWithManagementEvent {}

class LinkGoogleSignInWith extends SignInWithManagementEvent {}

class HandleSignInWithGoogleEvent extends SignInWithManagementEvent {
  final SignInWithGoogleInfo info;
  HandleSignInWithGoogleEvent(this.info);
}

class UnlinkAppleSignInWith extends SignInWithManagementEvent {}

class UnlinkGoogleSignInWith extends SignInWithManagementEvent {}

class SetEmailLoginEnabledEvent extends SignInWithManagementEvent {
  final bool enabled;
  SetEmailLoginEnabledEvent(this.enabled);
}

class SignInWithManagementBloc extends Bloc<SignInWithManagementEvent, SignInWithManagementBlocData>
    with ActionRunner {
  final RepositoryInstances r;
  final LoginRepository _login = LoginRepository.getInstance();
  StreamSubscription<SignInWithGoogleInfo>? _linkingSub;

  SignInWithManagementBloc(this.r) : super(SignInWithManagementBlocData()) {
    if (kIsWeb) {
      _login.googleManager.enableLinking();
      _linkingSub = _login.googleManager.linkingEvents.listen(
        (info) => add(HandleSignInWithGoogleEvent(info)),
      );
    }
    on<ReloadSignInWithManagement>((event, emit) async {
      await runOnce(() async {
        await _reload(emit);
      });
    });
    on<LinkAppleSignInWith>((event, emit) async {
      await _linkSignInWith(
        emit,
        () => SignInWithAppleManager.signInWithApple(currentServerAddress: r.api.serverAddress),
        (apple) => r.account.api.account(
          (api) => api.putSignInWithApple(PutSignInWithApple(apple: apple)),
        ),
      );
    });
    on<LinkGoogleSignInWith>((event, emit) async {
      await _linkSignInWith(
        emit,
        () => _login.googleManager.login(),
        (google) => r.account.api.account(
          (api) => api.putSignInWithGoogle(PutSignInWithGoogle(google: google)),
        ),
      );
    });
    on<HandleSignInWithGoogleEvent>((event, emit) async {
      await _linkSignInWith(
        emit,
        () async => Ok<SignInWithGoogleInfo, ()>(event.info),
        (google) => r.account.api.account(
          (api) => api.putSignInWithGoogle(PutSignInWithGoogle(google: google)),
        ),
      );
    });
    on<UnlinkAppleSignInWith>((event, emit) async {
      await _unlinkSignInWith(
        emit,
        () => r.account.api.accountAction(
          (api) => api.putSignInWithApple(PutSignInWithApple(apple: null)),
        ),
      );
    });
    on<UnlinkGoogleSignInWith>((event, emit) async {
      await _unlinkSignInWith(
        emit,
        () => r.account.api.accountAction(
          (api) => api.putSignInWithGoogle(PutSignInWithGoogle(google: null)),
        ),
      );
    });
    on<SetEmailLoginEnabledEvent>((event, emit) async {
      await _setEmailLoginEnabled(emit, event.enabled);
    });
  }

  Future<void> _reload(Emitter<SignInWithManagementBlocData> emit) async {
    final state = await r.account.api.account((api) => api.getSignInWithInfo()).ok();
    final emailState = await r.account.api.account((api) => api.getEmailAddressState()).ok();
    if (state != null) {
      emit(
        this.state.copyWith(
          isLoading: false,
          isError: false,
          apple: state.apple,
          google: state.google,
          emailLoginEnabled: emailState?.emailLoginEnabled ?? true,
        ),
      );
    } else {
      emit(this.state.copyWith(isLoading: false, isError: true));
    }
  }

  Future<void> _setEmailLoginEnabled(
    Emitter<SignInWithManagementBlocData> emit,
    bool enabled,
  ) async {
    await runOnce(() async {
      emit(state.copyWith(updateState: const UpdateStarted()));

      final waitTime = WantedWaitingTimeManager();
      emit(state.copyWith(updateState: const UpdateInProgress()));

      final request = SetEmailLoginEnabled(aid: r.accountId, enabled: enabled);
      final ok = await r.account.api
          .accountAction((api) => api.postSetEmailLoginEnabled(request))
          .ok();

      await waitTime.waitIfNeeded();

      if (ok != null) {
        await _reload(emit);
      } else {
        showSnackBar(R.strings.generic_error_occurred);
      }

      emit(state.copyWith(updateState: const UpdateIdle()));
    });
  }

  /// Links a new sign in method. Result of [getInfo] is either the sign in
  /// info or an error, for example when the user cancelled the sign in.
  Future<void> _linkSignInWith<Info, Failure>(
    Emitter<SignInWithManagementBlocData> emit,
    Future<Result<Info, Failure>> Function() getInfo,
    Future<Result<PutSignInWithResult, ValueApiError>> Function(Info) link,
  ) async {
    await runOnce(() async {
      emit(state.copyWith(updateState: const UpdateStarted()));

      final waitTime = WantedWaitingTimeManager();
      emit(state.copyWith(updateState: const UpdateInProgress()));

      final info = await getInfo();
      final Result<PutSignInWithResult, ValueApiError>? result;
      switch (info) {
        case Ok(:final v):
          result = await link(v);
        case Err():
          result = null;
      }

      await waitTime.waitIfNeeded();

      if (result != null) {
        switch (result) {
          case Ok(:final v):
            if (v.errorHistoryLimitReached != null) {
              showSnackBar(
                R.strings.sign_in_with_management_screen_link_history_limit_reached(
                  formatSeconds(v.errorHistoryLimitReached!),
                ),
              );
            } else if (v.error) {
              showSnackBar(R.strings.sign_in_with_management_screen_link_failed);
            } else {
              await _reload(emit);
            }
          case Err():
            showSnackBar(R.strings.sign_in_with_management_screen_link_failed);
        }
      } else {
        showSnackBar(R.strings.sign_in_with_management_screen_link_failed);
      }

      emit(state.copyWith(updateState: const UpdateIdle()));
    });
  }

  Future<void> _unlinkSignInWith(
    Emitter<SignInWithManagementBlocData> emit,
    Future<Result<(), ActionApiError>> Function() action,
  ) async {
    await runOnce(() async {
      emit(state.copyWith(updateState: const UpdateStarted()));

      final waitTime = WantedWaitingTimeManager();
      emit(state.copyWith(updateState: const UpdateInProgress()));

      final ok = await action().ok();

      await waitTime.waitIfNeeded();

      if (ok != null) {
        await _reload(emit);
      } else {
        showSnackBar(R.strings.sign_in_with_management_screen_unlink_failed);
      }

      emit(state.copyWith(updateState: const UpdateIdle()));
    });
  }

  @override
  Future<void> close() async {
    await _linkingSub?.cancel();
    _login.googleManager.disableLinking();
    await super.close();
  }
}
