import "package:flutter_bloc/flutter_bloc.dart";
import "package:pihka_frontend/data/account_repository.dart";

/// States for top level UI main states
enum MainState {
  splashScreen, loginRequired, initialSetup, initialSetupComplete, accountBanned, pendingRemoval, unsupportedClientVersion
}

abstract class MainStateEvent {}

class ToSplashScreen extends MainStateEvent {}
class ToLoginRequiredScreen extends MainStateEvent {}
class ToInitialSetup extends MainStateEvent {}
class ToMainScreen extends MainStateEvent {}
class ToAccountBannedScreen extends MainStateEvent {}
class ToPendingRemovalScreen extends MainStateEvent {}
class ToUnsupportedClientScreen extends MainStateEvent {}

/// Get current main state of the account/app
class MainStateBloc extends Bloc<MainStateEvent, MainState> {
  final AccountRepository account;

  MainStateBloc(this.account) : super(MainState.splashScreen) {
    on<ToSplashScreen>((_, emit) => emit(MainState.splashScreen));
    on<ToLoginRequiredScreen>((_, emit) => emit(MainState.loginRequired));
    on<ToInitialSetup>((_, emit) => emit(MainState.initialSetup));
    on<ToMainScreen>((_, emit) => emit(MainState.initialSetupComplete));
    on<ToAccountBannedScreen>((_, emit) => emit(MainState.accountBanned));
    on<ToPendingRemovalScreen>((_, emit) => emit(MainState.pendingRemoval));
    on<ToUnsupportedClientScreen>((_, emit) => emit(MainState.unsupportedClientVersion));

    account.mainState.listen((event) {
      switch (event) {
        case MainState.loginRequired:
          add(ToLoginRequiredScreen());
        case MainState.initialSetup:
          add(ToInitialSetup());
        case MainState.initialSetupComplete:
          add(ToMainScreen());
        case MainState.accountBanned:
          add(ToAccountBannedScreen());
        case MainState.pendingRemoval:
          add(ToPendingRemovalScreen());
        case MainState.splashScreen:
          add(ToSplashScreen());
        case MainState.unsupportedClientVersion:
          add(ToUnsupportedClientScreen());
      }
    });
  }
}
