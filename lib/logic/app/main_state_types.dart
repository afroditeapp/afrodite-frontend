import 'package:app/data/utils/repository_instances.dart';

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

class MsLoggedIn extends MainState {
  final RepositoryInstances repositories;
  final LoggedInScreen screen;
  MsLoggedIn(this.repositories, this.screen);

  @override
  bool operator ==(Object other) {
    return (other is MsLoggedIn && repositories == other.repositories && screen == other.screen);
  }

  @override
  int get hashCode => Object.hash(runtimeType, repositories, screen);
}

enum LoggedInScreen {
  initialSetup,
  normal,
  accountBanned,
  pendingRemoval,
  unsupportedClientVersion,
}
