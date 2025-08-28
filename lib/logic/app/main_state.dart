import "package:app/main.dart";
import "package:bloc_concurrency/bloc_concurrency.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:app/data/login_repository.dart";
import "package:database/database.dart";
import "package:logging/logging.dart";
import "package:rxdart/rxdart.dart";

final _log = Logger("MainStateBloc");

/// States for top level UI main states
enum MainState {
  splashScreen,
  loginRequired,
  initialSetup,
  initialSetupSkipped,
  initialSetupComplete,
  accountBanned,
  pendingRemoval,
  unsupportedClientVersion,
  demoAccount,
}

abstract class MainStateEvent {}

class UpdateMainState extends MainStateEvent {
  final MainState value;
  UpdateMainState(this.value);
}

/// Get current main state of the account/app
class MainStateBloc extends Bloc<MainStateEvent, MainState> {
  final globalInitManager = GlobalInitManager.getInstance();
  final login = LoginRepository.getInstance();

  MainStateBloc() : super(MainState.splashScreen) {
    on<UpdateMainState>((data, emit) => emit(data.value), transformer: sequential());

    Rx.combineLatest4(
      login.loginState,
      login.accountState,
      login.initialSetupSkipped,
      globalInitManager.globalInitCompletedStream,
      (a, b, c, d) => (a, b, c, d),
    ).listen((current) {
      final (loginState, accountState, initialSetupSkipped, globalInitCompleted) = current;

      if (globalInitCompleted == false) {
        return;
      }

      _log.finer("$loginState, $accountState, initialSetupSkipped: $initialSetupSkipped");

      final newMainState = switch (loginState) {
        LoginState.loginRequired => MainState.loginRequired,
        LoginState.demoAccount => MainState.demoAccount,
        LoginState.splashScreen => MainState.splashScreen,
        LoginState.unsupportedClientVersion => MainState.unsupportedClientVersion,
        LoginState.viewAccountStateOnceItExists => switch (accountState) {
          // Prevent client getting stuck on splash screen when app starts
          // and getting AccountState fails.
          AccountStateEmpty() =>
            loginState == LoginState.demoAccount ? MainState.demoAccount : MainState.loginRequired,
          AccountStateLoading() => null,
          AccountStateExists(:final state) => switch (state) {
            AccountState.initialSetup => switch (initialSetupSkipped) {
              true => MainState.initialSetupSkipped,
              false => MainState.initialSetup,
            },
            AccountState.banned => MainState.accountBanned,
            AccountState.pendingDeletion => MainState.pendingRemoval,
            AccountState.normal => MainState.initialSetupComplete,
          },
        },
      };

      if (newMainState != null) {
        add(UpdateMainState(newMainState));
      }
    });
  }
}
