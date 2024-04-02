import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";
import "package:pihka_frontend/data/account_repository.dart";


import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';
import "package:pihka_frontend/data/login_repository.dart";
import "package:pihka_frontend/ui_utils/snack_bar.dart";
import "package:pihka_frontend/utils.dart";

part 'account.freezed.dart';

@freezed
class AccountBlocData with _$AccountBlocData {
  factory AccountBlocData({
    AccountId? accountId,
    String? email,
    AccountState? accountState,
    required Capabilities capabilities,
    required ProfileVisibility visibility,
  }) = _AccountBlocData;
}

abstract class AccountEvent {}
class DoRegister extends AccountEvent {
  DoRegister();
}
class DoLogin extends AccountEvent {}
class DoLogout extends AccountEvent {}
class DoProfileVisiblityChange extends AccountEvent {
  final bool profileVisiblity;
  DoProfileVisiblityChange(this.profileVisiblity);
}
class NewAccountIdValue extends AccountEvent {
  final AccountId? value;
  NewAccountIdValue(this.value);
}
class NewCapabilitiesValue extends AccountEvent {
  final Capabilities value;
  NewCapabilitiesValue(this.value);
}
class NewProfileVisibilityValue extends AccountEvent {
  final ProfileVisibility value;
  NewProfileVisibilityValue(this.value);
}
class NewAccountStateValue extends AccountEvent {
  final AccountState? accountState;
  NewAccountStateValue(this.accountState);
}

/// Do register/login operations
class AccountBloc extends Bloc<AccountEvent, AccountBlocData> with ActionRunner {
  final AccountRepository account = AccountRepository.getInstance();
  final LoginRepository login = LoginRepository.getInstance();

  AccountBloc() :
    super(AccountBlocData(
      capabilities: Capabilities(),
      visibility: ProfileVisibility.pendingPrivate
    )) {
    on<DoRegister>((data, emit) async {
      await runOnce(() async {
        emit(state.copyWith(
          accountId: await login.register(),
        ));
      });
    });
    on<DoLogin>((_, emit) async {
      await runOnce(() async {
        await login.login();
      });
    });
    on<DoLogout>((_, emit) async {
      await runOnce(() async {
        await login.logout();
      });
    });
    on<DoProfileVisiblityChange>((state, emit) async {
      await runOnce(() async {
        final successful = await account.doProfileVisibilityChange(state.profileVisiblity);
        if (!successful) {
          showSnackBar("Failed to update profile visibility");
        }
      });
    });
    on<NewAccountIdValue>((id, emit) {
      emit(state.copyWith(accountId: id.value));
    });
    on<NewCapabilitiesValue>((key, emit) {
      emit(state.copyWith(capabilities: key.value));
    });
    on<NewProfileVisibilityValue>((key, emit) {
      emit(state.copyWith(visibility: key.value));
    });
    on<NewAccountStateValue>((key, emit) {
      emit(state.copyWith(accountState: key.accountState));
    });


    login.accountId.listen((event) {
      add(NewAccountIdValue(event));
    });
    account.capabilities.listen((event) {
      add(NewCapabilitiesValue(event));
    });
    account.profileVisibility.listen((event) {
      add(NewProfileVisibilityValue(event));
    });
    account.accountState.listen((event) {
      add(NewAccountStateValue(event));
    });
  }
}
