import 'package:app/data/utils/repository_instances.dart';
import 'package:app/logic/app/main_state_types.dart';
import 'package:openapi/api.dart';

sealed class LoginState {}

class LsSplashScreen extends LoginState {
  @override
  bool operator ==(Object other) {
    return (other is LsSplashScreen);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

class LsLoginRequired extends LoginState {
  @override
  bool operator ==(Object other) {
    return (other is LsLoginRequired);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

class LsDemoAccount extends LoginState {
  @override
  bool operator ==(Object other) {
    return (other is LsDemoAccount);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

class LsLoggedIn extends LoginState {
  final RepositoryInstances repositories;

  /// If false, view account state
  final bool unsupportedClientVersion;

  LsLoggedIn(this.repositories, {this.unsupportedClientVersion = false});

  MsLoggedInBasicScreen toMainState(LoggedInBasicScreen screen) =>
      MsLoggedInBasicScreen(repositories, screen);

  @override
  bool operator ==(Object other) {
    return (other is LsLoggedIn &&
        repositories == other.repositories &&
        unsupportedClientVersion == other.unsupportedClientVersion);
  }

  @override
  int get hashCode => Object.hash(runtimeType, repositories, unsupportedClientVersion);
}

sealed class RepositoriesStreamValue {
  RepositoryInstances? get repositoriesOrNull => null;
}

class RepositoriesLoading extends RepositoriesStreamValue {
  @override
  String toString() {
    return "RepositoriesLoading";
  }
}

class RepositoriesEmpty extends RepositoriesStreamValue {
  @override
  String toString() {
    return "RepositoriesEmpty";
  }
}

class RepositoriesExists extends RepositoriesStreamValue {
  final RepositoryInstances repositories;
  RepositoriesExists(this.repositories);

  @override
  RepositoryInstances? get repositoriesOrNull => repositories;

  @override
  String toString() {
    return "RepositoriesExists";
  }
}

sealed class CommonSignInError {}

class CseLoginApiRequestFailed extends CommonSignInError {}

class CseUnsupportedClient extends CommonSignInError {}

class CseAccountRegistrationDisabled extends CommonSignInError {}

class CseSignInWithEmailUnverified extends CommonSignInError {}

class CseEmailAlreadyUsed extends CommonSignInError {}

class CseAccountLocked extends CommonSignInError {}

class CseInvalidEmailLoginToken extends CommonSignInError {}

class CseCreatingConnectingWebSocketFailed extends CommonSignInError {}

class CseMaintenanceOngoing extends CommonSignInError {
  final StringResource maintenanceInfo;
  CseMaintenanceOngoing(this.maintenanceInfo);
}

class CseDataSyncFailed extends CommonSignInError {}

class CseOtherError extends CommonSignInError {}

sealed class EmailLoginRequestTokenError {}

class ElrteErrorOccurred extends EmailLoginRequestTokenError {}

class ElrteMaintenanceOngoing extends EmailLoginRequestTokenError {
  final StringResource maintenanceInfo;
  ElrteMaintenanceOngoing(this.maintenanceInfo);
}
