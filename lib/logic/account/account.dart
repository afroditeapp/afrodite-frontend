import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";
import "package:pihka_frontend/data/account_repository.dart";
import "package:pihka_frontend/ui/initial_setup.dart";
import "package:rxdart/rxdart.dart";


import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';

part 'account.freezed.dart';

@freezed
class AccountData with _$AccountData {
  factory AccountData({
    AccountId? accountId,
    AccessToken? accessToken,
    required Capabilities capabilities,
  }) = _AccountData;
}

abstract class AccountEvent {}
class DoRegister extends AccountEvent {
  DoRegister();
}
class DoLogin extends AccountEvent {}
class DoLogout extends AccountEvent {}
class NewAccountIdValue extends AccountEvent {
  final AccountId value;
  NewAccountIdValue(this.value);
}
class NewAccessTokenValue extends AccountEvent {
  final AccessToken value;
  NewAccessTokenValue(this.value);
}
class NewCapabilitiesValue extends AccountEvent {
  final Capabilities value;
  NewCapabilitiesValue(this.value);
}

/// Do register/login operations
class AccountBloc extends Bloc<AccountEvent, AccountData> {
  final AccountRepository account;

  AccountBloc(this.account) : super(AccountData(capabilities: Capabilities())) {
    // TODO: It is possible to start register and login multiple times?
    on<DoRegister>((data, emit) async {
      emit(state.copyWith(
        accountId: await account.register(),
        accessToken: null,
      ));
    });
    on<DoLogin>((_, emit) async {
      emit(state.copyWith(
        accessToken: await account.login(),
      ));
    });
    on<DoLogout>((_, emit) async {
      await account.logout();
    });
    on<NewAccountIdValue>((id, emit) {
      emit(state.copyWith(accountId: id.value));
    });
    on<NewAccessTokenValue>((key, emit) {
      emit(state.copyWith(accessToken: key.value));
    });
    on<NewCapabilitiesValue>((key, emit) {
      emit(state.copyWith(capabilities: key.value));
    });

    account.capabilities.listen((event) {
      add(NewCapabilitiesValue(event));
    });
    account.accountId.whereNotNull().listen((event) {
      add(NewAccountIdValue(event));
    });
    account.accountAccessToken.whereNotNull().listen((event) { add(NewAccessTokenValue(event)); });
  }
}
