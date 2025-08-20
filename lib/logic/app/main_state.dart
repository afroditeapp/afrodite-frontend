import "package:flutter_bloc/flutter_bloc.dart";
import "package:app/data/login_repository.dart";
import "package:database/database.dart";
import "package:rxdart/rxdart.dart";

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

class ToSplashScreen extends MainStateEvent {}

class ToLoginRequiredScreen extends MainStateEvent {}

class ToInitialSetup extends MainStateEvent {}

class ToMainScreenWhenInitialSetupIsSkipped extends MainStateEvent {}

class ToMainScreen extends MainStateEvent {}

class ToAccountBannedScreen extends MainStateEvent {}

class ToPendingRemovalScreen extends MainStateEvent {}

class ToUnsupportedClientScreen extends MainStateEvent {}

class ToDemoAccountScreen extends MainStateEvent {}

/// Get current main state of the account/app
class MainStateBloc extends Bloc<MainStateEvent, MainState> {
  final login = LoginRepository.getInstance();

  MainStateBloc() : super(MainState.splashScreen) {
    on<ToSplashScreen>((_, emit) => emit(MainState.splashScreen));
    on<ToLoginRequiredScreen>((_, emit) => emit(MainState.loginRequired));
    on<ToInitialSetup>((_, emit) => emit(MainState.initialSetup));
    on<ToMainScreenWhenInitialSetupIsSkipped>((_, emit) => emit(MainState.initialSetupSkipped));
    on<ToMainScreen>((_, emit) => emit(MainState.initialSetupComplete));
    on<ToAccountBannedScreen>((_, emit) => emit(MainState.accountBanned));
    on<ToPendingRemovalScreen>((_, emit) => emit(MainState.pendingRemoval));
    on<ToUnsupportedClientScreen>((_, emit) => emit(MainState.unsupportedClientVersion));
    on<ToDemoAccountScreen>((_, emit) => emit(MainState.demoAccount));

    Rx.combineLatest3(
      login.loginState,
      login.accountState,
      login.initialSetupSkipped,
      (a, b, c) => (a, b, c),
    ).listen((current) {
      final (loginState, accountState, initialSetupSkipped) = current;
      log.finer(
        "loginState: $loginState, accountState: $accountState, initialSetupSkipped: $initialSetupSkipped",
      );
      final action = switch (loginState) {
        LoginState.loginRequired => ToLoginRequiredScreen(),
        LoginState.demoAccount => ToDemoAccountScreen(),
        LoginState.splashScreen => ToSplashScreen(),
        LoginState.unsupportedClientVersion => ToUnsupportedClientScreen(),
        LoginState.viewAccountStateOnceItExists => switch (accountState) {
          // Prevent client getting stuck on splash screen when app starts
          // and getting AccountState fails.
          AccountStateEmpty() =>
            loginState == LoginState.demoAccount ? ToDemoAccountScreen() : ToLoginRequiredScreen(),
          AccountStateLoading() => null,
          AccountStateExists(:final state) => switch (state) {
            AccountState.initialSetup => switch (initialSetupSkipped) {
              true => ToMainScreenWhenInitialSetupIsSkipped(),
              false => ToInitialSetup(),
            },
            AccountState.banned => ToAccountBannedScreen(),
            AccountState.pendingDeletion => ToPendingRemovalScreen(),
            AccountState.normal => ToMainScreen(),
          },
        },
      };

      if (action != null) {
        add(action);
      }
    });
  }
}
