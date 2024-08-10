import "package:flutter_bloc/flutter_bloc.dart";
import "package:pihka_frontend/data/account_repository.dart";
import "package:pihka_frontend/data/login_repository.dart";
import "package:pihka_frontend/localizations.dart";
import "package:pihka_frontend/model/freezed/logic/account/account_details.dart";
import "package:pihka_frontend/ui_utils/snack_bar.dart";
import "package:pihka_frontend/utils.dart";
import "package:pihka_frontend/utils/result.dart";

abstract class AccountDetailsEvent {}
class Reload extends AccountDetailsEvent {}
class MoveAccountToPendingDeletionState extends AccountDetailsEvent {}

class AccountDetailsBloc extends Bloc<AccountDetailsEvent, AccountDetailsBlocData> with ActionRunner {
  final AccountRepository account = LoginRepository.getInstance().repositories.account;

  AccountDetailsBloc() : super(AccountDetailsBlocData()) {
    on<Reload>((key, emit) async {
      await runOnce(() async {
        emit(AccountDetailsBlocData().copyWith(isLoading: true));

        final accountData = await account.downloadAccountData().ok();
        if (accountData == null) {
          emit(state.copyWith(isLoading: false, isError: true));
          return;
        }

        final birthdate = await account.downloadLatestBirthdate().ok();
        if (birthdate == null) {
          emit(state.copyWith(isLoading: false, isError: true));
          return;
        }

        emit(state.copyWith(
          isLoading: false,
          isError: false,
          email: accountData.email,
          birthdate: birthdate.birthdate,
        ));
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
