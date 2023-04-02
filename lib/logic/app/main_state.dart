import "package:flutter_bloc/flutter_bloc.dart";

/// States for top level UI main states
enum MainState {
  splashScreen, loginRequired, loggedIn, accountBanned, pendingRemoval,
}

abstract class MainStateEvent {}

class ToSplashScreen extends MainStateEvent {}
class ToLoginRequiredScreen extends MainStateEvent {}
class ToLoggedInScreen extends MainStateEvent {}
class ToAccountBannedScreen extends MainStateEvent {}
class ToPendingRemovalScreen extends MainStateEvent {}

class MainStateBloc extends Bloc<MainStateEvent, MainState> {
  MainStateBloc() : super(MainState.splashScreen) {
    on<ToSplashScreen>((_, emit) => emit(MainState.splashScreen));
    on<ToLoginRequiredScreen>((_, emit) => emit(MainState.loginRequired));
    on<ToLoggedInScreen>((_, emit) => emit(MainState.loggedIn));
    on<ToAccountBannedScreen>((_, emit) => emit(MainState.accountBanned));
    on<ToPendingRemovalScreen>((_, emit) => emit(MainState.pendingRemoval));
  }
}


