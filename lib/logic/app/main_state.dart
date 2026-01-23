import "package:app/data/notification_manager.dart";
import "package:app/data/push_notification_manager.dart";
import "package:app/data/utils/repository_instances.dart";
import "package:app/logic/app/main_state_types.dart";
import "package:app/main.dart";
import "package:app/model/freezed/logic/main/bottom_navigation_state.dart";
import "package:app/model/freezed/logic/main/navigator_state.dart";
import "package:app/ui/initial_setup/navigation.dart";
import "package:app/ui/utils/notification_payload_handler.dart";
import "package:app/utils/immutable_list.dart";
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
  MsLoggedInInitialSetupScreen? cachedInitialSetupScreenState;

  MainStateBloc() : super(MsSplashScreen()) {
    on<UpdateMainState>((data, emit) => emit(data.value), transformer: sequential());

    Rx.combineLatest4(
          login.loginState,
          login.accountState,
          login.initialSetupSkipped,
          globalInitManager.globalInitState,
          (a, b, c, d) => (a, b, c, d),
        )
        .asyncMap((current) async {
          final (ls, accountState, initialSetupSkipped, globalInitCompleted) = current;

          if (globalInitCompleted != GlobalInitState.completed) {
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
                  InitialSetupSkippedExists(value: false) => await restoreInitialSetupScreenState(
                    ls.repositories,
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
    final appLaunchPayloadOther = PushNotificationManager.getInstance()
        .getAndRemoveAppLaunchNotificationPayload();

    final AppLaunchNavigationState? navigationState;
    if (appLaunchPayload != null) {
      _log.info("Handling app launch notification payload");
      navigationState = await handleAppLaunchNotificationPayload(appLaunchPayload, r);
    } else if (appLaunchPayloadOther != null) {
      _log.info("Handling app launch push notification payload");
      navigationState = await handleAppLaunchNotificationPayload(appLaunchPayloadOther, r);
    } else {
      navigationState = null;
    }

    final state = MsLoggedInMainScreen(r, navigationState);
    cachedMainScreenState = state;
    return state;
  }

  Future<MsLoggedInInitialSetupScreen> restoreInitialSetupScreenState(RepositoryInstances r) async {
    // Avoid creating new MsLoggedInInitialSetupScreen if
    // this method runs again.
    final cached = cachedInitialSetupScreenState;
    if (cached != null && cached.repositories == r) {
      return cached;
    }

    final currentPage = await r.accountDb
        .accountStream((db) => db.app.watchInitialSetupCurrentPage())
        .first;

    final AppLaunchNavigationState? navigationState;
    if (currentPage != null && currentPage.isNotEmpty) {
      _log.info("Restoring initial setup to page: $currentPage");
      final pages = _buildInitialSetupPageStack(currentPage);
      navigationState = AppLaunchNavigationState(
        NavigatorStateData(pages: UnmodifiableList(pages)),
        BottomNavigationStateData(),
      );
    } else {
      navigationState = null;
    }

    return MsLoggedInInitialSetupScreen(r, navigationState);
  }

  List<MyScreenPage<Object>> _buildInitialSetupPageStack(String currentPageName) {
    final pageOrder = getInitialSetupPageOrder();

    final currentIndex = pageOrder.indexWhere((page) => page.nameForDb == currentPageName);
    if (currentIndex == -1) {
      // Unknown page, start from beginning
      return [pageOrder.first];
    }

    final pages = <MyScreenPage<Object>>[];

    for (int i = 0; i <= currentIndex; i++) {
      pages.add(pageOrder[i]);
    }

    return pages;
  }
}
