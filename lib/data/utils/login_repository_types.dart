import 'package:app/data/utils/repository_instances.dart';

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
