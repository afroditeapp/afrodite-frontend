import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";
import "package:pihka_frontend/data/account_repository.dart";
import "package:pihka_frontend/data/login_repository.dart";
import "package:rxdart/rxdart.dart";

/// States for top level UI main states
enum MainState {
  splashScreen,
  loginRequired,
  initialSetup,
  initialSetupComplete,
  accountBanned,
  pendingRemoval,
  unsupportedClientVersion,
  demoAccount;
}

abstract class MainStateEvent {}

class ToSplashScreen extends MainStateEvent {}
class ToLoginRequiredScreen extends MainStateEvent {}
class ToInitialSetup extends MainStateEvent {}
class ToMainScreen extends MainStateEvent {}
class ToAccountBannedScreen extends MainStateEvent {}
class ToPendingRemovalScreen extends MainStateEvent {}
class ToUnsupportedClientScreen extends MainStateEvent {}
class ToDemoAccountScreen extends MainStateEvent {}

/// Get current main state of the account/app
class MainStateBloc extends Bloc<MainStateEvent, MainState> {
  MainStateBloc() : super(MainState.splashScreen) {
    on<ToSplashScreen>((_, emit) => emit(MainState.splashScreen));
    on<ToLoginRequiredScreen>((_, emit) => emit(MainState.loginRequired));
    on<ToInitialSetup>((_, emit) => emit(MainState.initialSetup));
    on<ToMainScreen>((_, emit) => emit(MainState.initialSetupComplete));
    on<ToAccountBannedScreen>((_, emit) => emit(MainState.accountBanned));
    on<ToPendingRemovalScreen>((_, emit) => emit(MainState.pendingRemoval));
    on<ToUnsupportedClientScreen>((_, emit) => emit(MainState.unsupportedClientVersion));
    on<ToDemoAccountScreen>((_, emit) => emit(MainState.demoAccount));

    Rx.combineLatest2(
      LoginRepository.getInstance().loginState,
      AccountRepository.getInstance().accountState,
      (a, b) => (a, b),
    ).listen((current) {
      final (loginState, accountState) = current;
      final action = switch (loginState) {
        LoginState.loginRequired => ToLoginRequiredScreen(),
        LoginState.demoAccount => ToDemoAccountScreen(),
        LoginState.splashScreen => ToSplashScreen(),
        LoginState.unsupportedClientVersion => ToUnsupportedClientScreen(),
        LoginState.viewAccountStateOnceItExists => switch (accountState) {
          AccountState.initialSetup => ToInitialSetup(),
          AccountState.banned => ToAccountBannedScreen(),
          AccountState.pendingDeletion => ToPendingRemovalScreen(),
          AccountState.normal => ToMainScreen(),
          _ => null,
        },
      };

      if (action != null) {
        add(action);
      }
    });
  }
}
