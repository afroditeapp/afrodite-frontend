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

enum LoggedInBasicScreen { initialSetup, accountBanned, pendingRemoval, unsupportedClientVersion }

class MsLoggedInMainScreen extends MainState {
  final RepositoryInstances repositories;
  final AppLaunchNotification? notification;
  MsLoggedInMainScreen(this.repositories, this.notification);

  @override
  bool operator ==(Object other) {
    return (other is MsLoggedInMainScreen &&
        repositories == other.repositories &&
        notification == other.notification);
  }

  @override
  int get hashCode => Object.hash(runtimeType, repositories, notification);
}

/// Use this state when creating main screen
class AppLaunchNotification {
  final NavigatorStateData navigatorState;
  final BottomNavigationStateData bottomNavigationState;
  AppLaunchNotification(this.navigatorState, this.bottomNavigationState);
}
