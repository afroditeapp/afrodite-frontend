import "package:flutter_bloc/flutter_bloc.dart";
import "package:logging/logging.dart";
import "package:openapi/api.dart";
import "package:app/data/login_repository.dart";
import "package:app/localizations.dart";
import "package:app/model/freezed/logic/account/demo_account.dart";
import "package:app/ui_utils/snack_bar.dart";
import "package:app/utils.dart";
import "package:app/utils/immutable_list.dart";
import "package:app/utils/result.dart";

var log = Logger("DemoAccountBloc");

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
      log.info("Refreshing demo account list");
      switch (await login.demoAccountGetAccounts()) {
        case Ok(:final v):
          log.info("Demo account list received");
          emit(state.copyWith(accounts: UnmodifiableList(v)));
        case Err(e: SessionExpired()):
          log.info("Demo account session expired");
          showSnackBar(R.strings.login_screen_demo_account_login_session_expired);
        case Err(e: UnsupportedClient()):
          log.info("Unsupported app version");
          showSnackBar(R.strings.generic_error_app_version_is_unsupported);
        case Err(e: OtherError()):
          log.info("Demo account account list refresh other error");
      }
    });
    on<DoDemoAccountCreateNewAccount>((_, emit) async {
      await runOnce(() async {
        handleErrors(await login.demoAccountRegisterIfNeededAndLogin(null));
      });
    });
    on<DoDemoAccountLoginToAccount>((data, emit) async {
      await runOnce(() async {
        handleErrors(await login.demoAccountRegisterIfNeededAndLogin(data.id));
      });
    });
  }
}

void handleErrors(Result<(), SessionOrOtherError> result) {
  switch (result) {
    case Ok():
      null;
    case Err(e: SessionExpired()):
      showSnackBar(R.strings.login_screen_demo_account_login_session_expired);
    case Err(e: UnsupportedClient()):
      showSnackBar(R.strings.generic_error_app_version_is_unsupported);
    case Err(e: OtherError()):
      showSnackBar(R.strings.generic_error_occurred);
  }
}
