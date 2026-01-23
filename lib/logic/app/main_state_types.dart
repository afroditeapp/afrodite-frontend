import 'package:app/data/utils/repository_instances.dart';
import 'package:app/model/freezed/logic/main/bottom_navigation_state.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';

sealed class MainState {}

class MsSplashScreen extends MainState {
  @override
  bool operator ==(Object other) {
    return (other is MsSplashScreen);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

class MsLoginRequired extends MainState {
  @override
  bool operator ==(Object other) {
    return (other is MsLoginRequired);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

class MsDemoAccount extends MainState {
  @override
  bool operator ==(Object other) {
    return (other is MsDemoAccount);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

class MsLoggedInBasicScreen extends MainState {
  final RepositoryInstances repositories;
  final LoggedInBasicScreen screen;
  MsLoggedInBasicScreen(this.repositories, this.screen);

  @override
  bool operator ==(Object other) {
    return (other is MsLoggedInBasicScreen &&
        repositories == other.repositories &&
        screen == other.screen);
  }

  @override
  int get hashCode => Object.hash(runtimeType, repositories, screen);
}

enum LoggedInBasicScreen { accountBanned, pendingRemoval, unsupportedClientVersion }

class MsLoggedInInitialSetupScreen extends MainState {
  final RepositoryInstances repositories;
  final AppLaunchNavigationState? navigationState;
  MsLoggedInInitialSetupScreen(this.repositories, this.navigationState);

  @override
  bool operator ==(Object other) {
    return (other is MsLoggedInInitialSetupScreen &&
        repositories == other.repositories &&
        navigationState == other.navigationState);
  }

  @override
  int get hashCode => Object.hash(runtimeType, repositories, navigationState);
}

class MsLoggedInMainScreen extends MainState {
  final RepositoryInstances repositories;
  final AppLaunchNavigationState? navigationState;
  MsLoggedInMainScreen(this.repositories, this.navigationState);

  @override
  bool operator ==(Object other) {
    return (other is MsLoggedInMainScreen &&
        repositories == other.repositories &&
        navigationState == other.navigationState);
  }

  @override
  int get hashCode => Object.hash(runtimeType, repositories, navigationState);
}

class AppLaunchNavigationState {
  final NavigatorStateData navigatorState;
  final BottomNavigationStateData bottomNavigationState;
  AppLaunchNavigationState(this.navigatorState, this.bottomNavigationState);
}
