import "package:app/data/notification_manager.dart";
import "package:app/data/utils/repository_instances.dart";
import "package:app/logic/app/main_state_types.dart";
import "package:app/main.dart";
import "package:app/ui/utils/notification_payload_handler.dart";
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

  MsLoggedInMainScreen? cachedMainScreenState;

  MainStateBloc() : super(MsSplashScreen()) {
    on<UpdateMainState>((data, emit) => emit(data.value), transformer: sequential());

    Rx.combineLatest4(
          login.loginState,
          login.accountState,
          login.initialSetupSkipped,
          globalInitManager.globalInitCompletedStream,
          (a, b, c, d) => (a, b, c, d),
        )
        .asyncMap((current) async {
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
              LoggedInBasicScreen.unsupportedClientVersion,
            ),
            LsLoggedIn() => switch (accountState) {
              AccountStateLoading() => null,
              // Prevent client getting stuck on splash screen when app starts
              // and getting AccountState fails.
              AccountStateEmpty() => MsLoginRequired(),
              AccountStateExists(:final state) => switch (state) {
                AccountState.initialSetup => switch (initialSetupSkipped) {
                  InitialSetupSkippedLoading() => null,
                  InitialSetupSkippedExists(value: true) => await createMainScreenState(
                    ls.repositories,
                  ),
                  InitialSetupSkippedExists(value: false) => ls.toMainState(
                    LoggedInBasicScreen.initialSetup,
                  ),
                },
                AccountState.banned => ls.toMainState(LoggedInBasicScreen.accountBanned),
                AccountState.pendingDeletion => ls.toMainState(LoggedInBasicScreen.pendingRemoval),
                AccountState.normal => await createMainScreenState(ls.repositories),
              },
            },
          };

          if (ms != null) {
            add(UpdateMainState(ms));
          }
        })
        .listen(null);
  }

  Future<MsLoggedInMainScreen> createMainScreenState(RepositoryInstances r) async {
    // Getting notification payload works only once so reuse
    // previous state.
    final cached = cachedMainScreenState;
    if (cached != null && cached.repositories == r) {
      return cached;
    }

    final appLaunchPayload = NotificationManager.getInstance()
        .getAndRemoveAppLaunchNotificationPayload();

    final AppLaunchNotification? notification;
    if (appLaunchPayload != null) {
      _log.info("Handling app launch notification payload");
      notification = await handleAppLaunchNotificationPayload(appLaunchPayload, r);
    } else {
      notification = null;
    }

    final state = MsLoggedInMainScreen(r, notification);
    cachedMainScreenState = state;
    return state;
  }
}
