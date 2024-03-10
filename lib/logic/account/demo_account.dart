import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";
import "package:pihka_frontend/data/account_repository.dart";


import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';
import "package:pihka_frontend/data/login_repository.dart";
import "package:pihka_frontend/ui_utils/snack_bar.dart";
import "package:pihka_frontend/utils.dart";

part 'demo_account.freezed.dart';

@freezed
class DemoAccountBlocData with _$DemoAccountBlocData {
  factory DemoAccountBlocData({
    String? userId,
    String? password,
  }) = _DemoAccountBlocData;
}

abstract class DemoAccountEvent {}
class DoDemoAccountLogin extends DemoAccountEvent {
  final String? userId;
  final String? password;
  DoDemoAccountLogin({this.userId, this.password});
}
class DoDemoAccountLogout extends DemoAccountEvent {}
class NewDemoAccountUserIdValue extends DemoAccountEvent {
  final String? value;
  NewDemoAccountUserIdValue(this.value);
}
class NewDemoAccountPasswordValue extends DemoAccountEvent {
  final String? value;
  NewDemoAccountPasswordValue(this.value);
}

class DemoAccountBloc extends Bloc<DemoAccountEvent, DemoAccountBlocData> with ActionRunner {
  final LoginRepository login = LoginRepository.getInstance();

  DemoAccountBloc() :
    super(DemoAccountBlocData()) {
    on<DoDemoAccountLogin>((_, emit) async {
      await runOnce(() async {

      });
    });
    on<DoDemoAccountLogout>((_, emit) async {
      await runOnce(() async {

      });
    });
    on<NewDemoAccountUserIdValue>((id, emit) {
      emit(state.copyWith(userId: id.value));
    });
    on<NewDemoAccountPasswordValue>((key, emit) {
      emit(state.copyWith(password: key.value));
    });

    login.demoAccountUserId.listen((event) {
      add(NewDemoAccountUserIdValue(event));
    });
    login.demoAccountPassword.listen((event) {
      add(NewDemoAccountPasswordValue(event));
    });
  }
}
