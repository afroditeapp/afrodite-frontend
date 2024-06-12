import "dart:async";

import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";
import "package:pihka_frontend/data/account_repository.dart";


import "package:pihka_frontend/data/login_repository.dart";
import "package:pihka_frontend/database/database_manager.dart";
import "package:pihka_frontend/model/freezed/logic/account/account.dart";
import "package:pihka_frontend/utils.dart";

sealed class AccountEvent {}
class DoLogout extends AccountEvent {}
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
class NewEmailAddressValue extends AccountEvent {
  final String? value;
  NewEmailAddressValue(this.value);
}

/// Do register/login operations
class AccountBloc extends Bloc<AccountEvent, AccountBlocData> with ActionRunner {
  final AccountRepository account = AccountRepository.getInstance();
  final LoginRepository login = LoginRepository.getInstance();
  final DatabaseManager db = DatabaseManager.getInstance();

  StreamSubscription<AccountId?>? _accountIdSubscription;
  StreamSubscription<Capabilities>? _capabilitiesSubscription;
  StreamSubscription<ProfileVisibility>? _profileVisibilitySubscription;
  StreamSubscription<AccountState?>? _accountStateSubscription;
  StreamSubscription<String?>? _emailAddressSubscription;

  AccountBloc() :
    super(AccountBlocData(
      capabilities: Capabilities(),
      visibility: ProfileVisibility.pendingPrivate
    )) {
    on<DoLogout>((_, emit) async {
      await runOnce(() async {
        await login.logout();
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
    on<NewEmailAddressValue>((key, emit) {
      emit(state.copyWith(email: key.value));
    });

    _accountIdSubscription = login.accountId.listen((event) {
      add(NewAccountIdValue(event));
    });
    _capabilitiesSubscription = account.capabilities.listen((event) {
      add(NewCapabilitiesValue(event));
    });
    _profileVisibilitySubscription = account.profileVisibility.listen((event) {
      add(NewProfileVisibilityValue(event));
    });
    _accountStateSubscription = account.accountState.listen((event) {
      add(NewAccountStateValue(event));
    });
    _emailAddressSubscription = db.accountStream((db) => db.daoAccountSettings.watchEmailAddress()).listen((event) {
      add(NewEmailAddressValue(event));
    });
  }

  @override
  Future<void> close() async {
    await _accountIdSubscription?.cancel();
    await _capabilitiesSubscription?.cancel();
    await _profileVisibilitySubscription?.cancel();
    await _accountStateSubscription?.cancel();
    await _emailAddressSubscription?.cancel();
    await super.close();
  }
}
