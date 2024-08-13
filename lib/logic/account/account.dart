import "dart:async";

import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";
import "package:pihka_frontend/data/account_repository.dart";
import "package:pihka_frontend/data/login_repository.dart";
import "package:pihka_frontend/model/freezed/logic/account/account.dart";
import "package:pihka_frontend/utils.dart";

sealed class AccountEvent {}
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
  final AccountRepository account = LoginRepository.getInstance().repositories.account;

  StreamSubscription<Capabilities>? _capabilitiesSubscription;
  StreamSubscription<ProfileVisibility>? _profileVisibilitySubscription;
  StreamSubscription<AccountState?>? _accountStateSubscription;
  StreamSubscription<String?>? _emailAddressSubscription;

  AccountBloc() :
    super(AccountBlocData(
      capabilities: Capabilities(),
      // Use cached profile visiblity to avoid profile grid UI changing quickly
      // from private profile info to profile grid after login.
      visibility: LoginRepository.getInstance().repositories.account.profileVisibilityValue,
      // Use cached email to avoid showing input field UI for email
      // when initial setup is displayed.
      email: LoginRepository.getInstance().repositories.account.emailAddressValue,
    )) {
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

    _capabilitiesSubscription = account.capabilities.listen((event) {
      add(NewCapabilitiesValue(event));
    });
    _profileVisibilitySubscription = account.profileVisibility.listen((event) {
      add(NewProfileVisibilityValue(event));
    });
    _accountStateSubscription = account.accountState.listen((event) {
      add(NewAccountStateValue(event));
    });
    _emailAddressSubscription = account.emailAddress.listen((event) {
      add(NewEmailAddressValue(event));
    });
  }

  @override
  Future<void> close() async {
    await _capabilitiesSubscription?.cancel();
    await _profileVisibilitySubscription?.cancel();
    await _accountStateSubscription?.cancel();
    await _emailAddressSubscription?.cancel();
    await super.close();
  }
}
