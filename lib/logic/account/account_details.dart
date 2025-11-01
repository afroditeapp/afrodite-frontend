import "package:app/data/utils/repository_instances.dart";
import "package:app/utils/api.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:app/data/account_repository.dart";
import "package:app/localizations.dart";
import "package:app/model/freezed/logic/account/account_details.dart";
import "package:app/ui_utils/common_update_logic.dart";
import "package:app/ui_utils/snack_bar.dart";
import "package:app/utils.dart";
import "package:app/utils/result.dart";
import "package:app/utils/time.dart";
import "package:openapi/api.dart";
import "package:openapi/api.dart" as api;

abstract class AccountDetailsEvent {}

class Reload extends AccountDetailsEvent {}

class MoveAccountToPendingDeletionState extends AccountDetailsEvent {}

class SendVerificationEmail extends AccountDetailsEvent {}

class RequestInitEmailChange extends AccountDetailsEvent {
  final String newEmail;
  RequestInitEmailChange(this.newEmail);
}

class RequestCancelEmailChange extends AccountDetailsEvent {}

class AccountDetailsBloc extends Bloc<AccountDetailsEvent, AccountDetailsBlocData>
    with ActionRunner {
  final AccountRepository account;

  AccountDetailsBloc(RepositoryInstances r) : account = r.account, super(AccountDetailsBlocData()) {
    on<Reload>((key, emit) async {
      await runOnce(() async {
        emit(AccountDetailsBlocData().copyWith(isLoading: true));

        final accountData = await account.downloadAccountData().ok();
        if (accountData == null) {
          emit(state.copyWith(isLoading: false, isError: true));
          return;
        }

        emit(
          state.copyWith(
            isLoading: false,
            isError: false,
            email: accountData.email,
            emailChange: accountData.emailChange,
            emailChangeVerified: accountData.emailChangeVerified,
            emailChangeCompletionTime: accountData.emailChangeCompletionTime?.toUtcDateTime(),
          ),
        );
      });
    });
    on<MoveAccountToPendingDeletionState>((key, emit) async {
      await runOnce(() async {
        if (await account.moveAccountToPendingDeletionState().isErr()) {
          showSnackBar(R.strings.account_settings_screen_delete_account_action_error);
        }
      });
    });
    on<SendVerificationEmail>((key, emit) async {
      await runOnce(() async {
        emit(state.copyWith(updateState: const UpdateStarted()));

        final waitTime = WantedWaitingTimeManager();

        emit(state.copyWith(updateState: const UpdateInProgress()));

        final result = await account.sendVerificationEmail().ok();

        await waitTime.waitIfNeeded();

        if (result != null) {
          showSnackBarTextsForSendVerificationEmailResult(result);
        } else {
          showSnackBar(R.strings.generic_error);
        }

        emit(state.copyWith(updateState: const UpdateIdle()));
      });
    });
    on<RequestInitEmailChange>((event, emit) async {
      await runOnce(() async {
        emit(state.copyWith(updateState: const UpdateStarted()));

        final waitTime = WantedWaitingTimeManager();

        emit(state.copyWith(updateState: const UpdateInProgress()));

        final result = await account.api
            .account(
              (apiClient) =>
                  apiClient.postInitEmailChange(api.InitEmailChange(newEmail: event.newEmail)),
            )
            .ok();

        await waitTime.waitIfNeeded();

        if (result != null) {
          showSnackBarTextsForInitEmailChangeResult(result);
          add(Reload());
        } else {
          showSnackBar(R.strings.generic_error_occurred);
        }

        emit(state.copyWith(updateState: const UpdateIdle()));
      });
    });
    on<RequestCancelEmailChange>((event, emit) async {
      await runOnce(() async {
        emit(state.copyWith(updateState: const UpdateStarted()));

        final waitTime = WantedWaitingTimeManager();

        emit(state.copyWith(updateState: const UpdateInProgress()));

        final result = await account.api.accountAction((api) => api.postCancelEmailChange()).ok();

        await waitTime.waitIfNeeded();

        if (result != null) {
          showSnackBar(R.strings.account_settings_screen_email_change_cancelled);
          add(Reload());
        } else {
          showSnackBar(R.strings.generic_error_occurred);
        }

        emit(state.copyWith(updateState: const UpdateIdle()));
      });
    });
  }
}

void showSnackBarTextsForSendVerificationEmailResult(SendVerifyEmailMessageResult result) {
  if (result.errorEmailAlreadyVerified) {
    showSnackBar(R.strings.account_settings_screen_verify_email_already_verified);
  } else if (result.errorEmailSendingFailed) {
    showSnackBar(R.strings.generic_email_sending_failed);
  } else if (result.errorEmailSendingTimeout) {
    showSnackBar(R.strings.generic_email_sending_timeout);
  } else if (result.errorTryAgainLaterAfterSeconds != null) {
    showSnackBar(
      R.strings.generic_try_again_later_seconds(result.errorTryAgainLaterAfterSeconds.toString()),
    );
  } else {
    showSnackBar(R.strings.account_settings_screen_verify_email_sent_successfully);
  }
}

void showSnackBarTextsForInitEmailChangeResult(InitEmailChangeResult result) {
  if (result.errorEmailSendingFailed) {
    showSnackBar(R.strings.generic_email_sending_failed);
  } else if (result.errorEmailSendingTimeout) {
    showSnackBar(R.strings.generic_email_sending_timeout);
  } else if (result.errorTryAgainLaterAfterSeconds != null) {
    showSnackBar(
      R.strings.generic_try_again_later_seconds(result.errorTryAgainLaterAfterSeconds.toString()),
    );
  } else {
    showSnackBar(R.strings.account_settings_screen_email_change_initiated);
  }
}
