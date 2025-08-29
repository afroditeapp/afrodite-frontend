import "package:app/data/utils/repository_instances.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:app/data/account_repository.dart";
import "package:app/localizations.dart";
import "package:app/model/freezed/logic/account/account_details.dart";
import "package:app/ui_utils/snack_bar.dart";
import "package:app/utils.dart";
import "package:app/utils/result.dart";

abstract class AccountDetailsEvent {}

class Reload extends AccountDetailsEvent {}

class MoveAccountToPendingDeletionState extends AccountDetailsEvent {}

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
  }
}
