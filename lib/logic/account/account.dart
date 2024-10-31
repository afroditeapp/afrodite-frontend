import "dart:async";

import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";
import "package:app/data/account_repository.dart";
import "package:app/data/login_repository.dart";
import "package:app/model/freezed/logic/account/account.dart";
import "package:app/utils.dart";

sealed class AccountEvent {}
class NewPermissionsValue extends AccountEvent {
  final Permissions value;
  NewPermissionsValue(this.value);
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

  StreamSubscription<Permissions>? _permissionsSubscription;
  StreamSubscription<ProfileVisibility>? _profileVisibilitySubscription;
  StreamSubscription<AccountState?>? _accountStateSubscription;
  StreamSubscription<String?>? _emailAddressSubscription;

  AccountBloc() :
    super(AccountBlocData(
      permissions: Permissions(),
      // Use cached profile visiblity to avoid profile grid UI changing quickly
      // from private profile info to profile grid after login.
      visibility: LoginRepository.getInstance().repositories.account.profileVisibilityValue,
      // Use cached email to avoid showing input field UI for email
      // when initial setup is displayed.
      email: LoginRepository.getInstance().repositories.account.emailAddressValue,
    )) {
    on<NewPermissionsValue>((key, emit) {
      emit(state.copyWith(permissions: key.value));
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

    _permissionsSubscription = account.permissions.listen((event) {
      add(NewPermissionsValue(event));
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
    await _permissionsSubscription?.cancel();
    await _profileVisibilitySubscription?.cancel();
    await _accountStateSubscription?.cancel();
    await _emailAddressSubscription?.cancel();
    await super.close();
  }
}
