import "package:app/logic/app/main_state_types.dart";
import "package:app/main.dart";
import "package:bloc_concurrency/bloc_concurrency.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:app/data/login_repository.dart";
import 'package:app/data/utils/login_repository_types.dart';
import "package:database/database.dart";
import "package:logging/logging.dart";
import "package:rxdart/rxdart.dart";

final _log = Logger("MainStateBloc");

abstract class MainStateEvent {}

class UpdateMainState extends MainStateEvent {
  final MainState value;
  UpdateMainState(this.value);
}

/// Get current main state of the account/app
class MainStateBloc extends Bloc<MainStateEvent, MainState> {
  final globalInitManager = GlobalInitManager.getInstance();
  final login = LoginRepository.getInstance();

  MainStateBloc() : super(MsSplashScreen()) {
    on<UpdateMainState>((data, emit) => emit(data.value), transformer: sequential());

    Rx.combineLatest4(
      login.loginState,
      login.accountState,
      login.initialSetupSkipped,
      globalInitManager.globalInitCompletedStream,
      (a, b, c, d) => (a, b, c, d),
    ).listen((current) {
      final (ls, accountState, initialSetupSkipped, globalInitCompleted) = current;

      if (globalInitCompleted == false) {
        return;
      }

      _log.finer("$ls, $accountState, initialSetupSkipped: $initialSetupSkipped");

      final ms = switch (ls) {
        LsSplashScreen() => MsSplashScreen(),
        LsLoginRequired() => MsLoginRequired(),
        LsDemoAccount() => MsDemoAccount(),
        LsLoggedIn() when ls.unsupportedClientVersion => ls.toMainState(
          LoggedInScreen.unsupportedClientVersion,
        ),
        LsLoggedIn() => switch (accountState) {
          AccountStateLoading() => null,
          // Prevent client getting stuck on splash screen when app starts
          // and getting AccountState fails.
          AccountStateEmpty() => MsLoginRequired(),
          AccountStateExists(:final state) => switch (state) {
            AccountState.initialSetup => switch (initialSetupSkipped) {
              true => ls.toMainState(LoggedInScreen.normal),
              false => ls.toMainState(LoggedInScreen.initialSetup),
            },
            AccountState.banned => ls.toMainState(LoggedInScreen.accountBanned),
            AccountState.pendingDeletion => ls.toMainState(LoggedInScreen.pendingRemoval),
            AccountState.normal => ls.toMainState(LoggedInScreen.normal),
          },
        },
      };

      if (ms != null) {
        add(UpdateMainState(ms));
      }
    });
  }
}
