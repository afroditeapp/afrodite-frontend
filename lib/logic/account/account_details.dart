import "package:app/data/utils/repository_instances.dart";
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

abstract class AccountDetailsEvent {}

class Reload extends AccountDetailsEvent {}

class MoveAccountToPendingDeletionState extends AccountDetailsEvent {}

class SendVerificationEmail extends AccountDetailsEvent {}

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

        emit(state.copyWith(isLoading: false, isError: false, email: accountData.email));
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
  }
}

void showSnackBarTextsForSendVerificationEmailResult(SendConfirmEmailMessageResult result) {
  if (result.errorEmailAlreadyVerified) {
    showSnackBar(R.strings.account_settings_screen_verify_email_already_verified);
  } else if (result.errorEmailSendingFailed) {
    showSnackBar(R.strings.account_settings_screen_verify_email_sending_failed);
  } else if (result.errorEmailSendingTimeout) {
    showSnackBar(R.strings.account_settings_screen_verify_email_sending_timeout);
  } else if (result.errorTryAgainLaterAfterSeconds != null) {
    showSnackBar(
      R.strings.account_settings_screen_verify_email_try_again_later(
        result.errorTryAgainLaterAfterSeconds.toString(),
      ),
    );
  } else {
    showSnackBar(R.strings.account_settings_screen_verify_email_sent_successfully);
  }
}
