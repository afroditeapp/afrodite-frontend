import "package:flutter_bloc/flutter_bloc.dart";
import "package:pihka_frontend/data/account_repository.dart";


import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';
import "package:pihka_frontend/utils.dart";

part 'account_details.freezed.dart';

@freezed
class AccountDetailsBlocData with _$AccountDetailsBlocData {
  factory AccountDetailsBlocData({
    String? email,
    String? birthdate,
  }) = _AccountDetailsBlocData;
}

abstract class AccountDetailsEvent {}
class NewEmailValue extends AccountDetailsEvent {
  final String value;
  NewEmailValue(this.value);
}
class NewBirthdateValue extends AccountDetailsEvent {
  final String value;
  NewBirthdateValue(this.value);
}


class AccountDetailsBloc extends Bloc<AccountDetailsEvent, AccountDetailsBlocData> with ActionRunner {
  final AccountRepository account = AccountRepository.getInstance();

  AccountDetailsBloc() :
    super(AccountDetailsBlocData()) {

    on<NewEmailValue>((key, emit) {
      emit(state.copyWith(email: key.value));
    });
    on<NewBirthdateValue>((key, emit) {
      emit(state.copyWith(birthdate: key.value));
    });


    // account.capabilities.listen((event) {
    //   add(NewCapabilitiesValue(event));
    // });
    // TODO: listening
  }
}
