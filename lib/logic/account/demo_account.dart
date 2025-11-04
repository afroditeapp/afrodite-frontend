import "package:app/logic/sign_in_with.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";
import "package:app/data/login_repository.dart";
import "package:app/localizations.dart";
import "package:app/model/freezed/logic/account/demo_account.dart";
import "package:app/ui_utils/snack_bar.dart";
import "package:app/utils.dart";
import "package:app/utils/immutable_list.dart";
import "package:app/utils/result.dart";

abstract class DemoAccountEvent {}

class DoDemoAccountLogout extends DemoAccountEvent {}

class DoDemoAccountRefreshAccountList extends DemoAccountEvent {}

class DoDemoAccountCreateNewAccount extends DemoAccountEvent {}

class DoDemoAccountLoginToAccount extends DemoAccountEvent {
  final AccountId id;
  DoDemoAccountLoginToAccount(this.id);
}

class DemoAccountBloc extends Bloc<DemoAccountEvent, DemoAccountBlocData> with ActionRunner {
  final LoginRepository login = LoginRepository.getInstance();

  DemoAccountBloc() : super(DemoAccountBlocData()) {
    on<DoDemoAccountLogout>((_, emit) async {
      await runOnce(() async {
        emit(state.copyWith(logoutInProgress: true));
        await login.demoAccountLogout();
        emit(state.copyWith(logoutInProgress: false));
      });
    });
    on<DoDemoAccountRefreshAccountList>((_, emit) async {
      switch (await login.demoAccountGetAccounts()) {
        case Ok(:final v):
          emit(state.copyWith(accounts: UnmodifiableList(v), isLoading: false));
        case Err(:final e):
          _handleError(e);
      }
    });
    on<DoDemoAccountCreateNewAccount>((_, emit) async {
      await runOnce(() async {
        _handleResult(await login.demoAccountRegisterIfNeededAndLogin(null));
      });
    });
    on<DoDemoAccountLoginToAccount>((data, emit) async {
      await runOnce(() async {
        _handleResult(await login.demoAccountRegisterIfNeededAndLogin(data.id));
      });
    });
  }
}

void _handleResult(Result<(), DemoAccountError> result) {
  switch (result) {
    case Ok():
      null;
    case Err():
      _handleError(result.e);
  }
}

void _handleError(DemoAccountError e) {
  switch (e) {
    case DemoAccountLoggedOutFromDemoAccount():
      showSnackBar(R.strings.generic_error_occurred);
    case DemoAccountSessionExpired():
      showSnackBar(R.strings.login_screen_demo_account_login_session_expired);
    case DemoAccountSignInError(:final error):
      showSnackBarTextsForSignInError(error);
    case DemoAccountMaxAccountCountError():
      showSnackBar(R.strings.demo_account_screen_max_account_count_error);
    case DemoAccountGeneralError():
      showSnackBar(R.strings.generic_error);
  }
}
