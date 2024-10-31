import "dart:async";

import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";

import "package:app/data/login_repository.dart";
import "package:app/model/freezed/logic/login.dart";
import "package:app/utils.dart";

sealed class LoginEvent {}
class DoLogout extends LoginEvent {}
class NewAccountIdValue extends LoginEvent {
  final AccountId? value;
  NewAccountIdValue(this.value);
}

/// Do register/login operations
class LoginBloc extends Bloc<LoginEvent, LoginBlocData> with ActionRunner {
  final LoginRepository login = LoginRepository.getInstance();

  StreamSubscription<AccountId?>? _accountIdSubscription;

  LoginBloc() :
    super(LoginBlocData()) {
    on<DoLogout>((_, emit) async {
      await runOnce(() async {
        await login.logout();
      });
    });
    on<NewAccountIdValue>((id, emit) {
      emit(state.copyWith(accountId: id.value));
    });
    _accountIdSubscription = login.accountId.listen((event) {
      add(NewAccountIdValue(event));
    });
  }

  @override
  Future<void> close() async {
    await _accountIdSubscription?.cancel();
    await super.close();
  }
}
