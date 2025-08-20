import "dart:async";

import "package:flutter_bloc/flutter_bloc.dart";
import "package:app/data/login_repository.dart";
import "package:app/model/freezed/logic/login.dart";
import "package:app/utils.dart";

sealed class LoginEvent {}

class DoLogout extends LoginEvent {}

/// Do register/login operations
class LoginBloc extends Bloc<LoginEvent, LoginBlocData> with ActionRunner {
  final LoginRepository login = LoginRepository.getInstance();

  LoginBloc() : super(LoginBlocData()) {
    on<DoLogout>((_, emit) async {
      await runOnce(() async {
        emit(state.copyWith(logoutInProgress: true));
        await login.logout();
        emit(state.copyWith(logoutInProgress: false));
      });
    });
  }

  @override
  Future<void> close() async {
    await super.close();
  }
}
