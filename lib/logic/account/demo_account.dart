import "package:flutter_bloc/flutter_bloc.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';
import "package:pihka_frontend/data/login_repository.dart";
import "package:pihka_frontend/localizations.dart";
import "package:pihka_frontend/ui_utils/snack_bar.dart";
import "package:pihka_frontend/utils.dart";
import "package:pihka_frontend/utils/result.dart";

part 'demo_account.freezed.dart';

@freezed
class DemoAccountBlocData with _$DemoAccountBlocData {
  factory DemoAccountBlocData({
    String? userId,
    String? password,
    @Default(false) bool loginProgressVisible,
  }) = _DemoAccountBlocData;
}

abstract class DemoAccountEvent {}
class DoDemoAccountLogin extends DemoAccountEvent {
  final DemoAccountCredentials credentials;
  DoDemoAccountLogin(this.credentials);
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
class NewLoginProgressValue extends DemoAccountEvent {
  final bool value;
  NewLoginProgressValue(this.value);
}

class DemoAccountBloc extends Bloc<DemoAccountEvent, DemoAccountBlocData> with ActionRunner {
  final LoginRepository login = LoginRepository.getInstance();

  DemoAccountBloc() :
    super(DemoAccountBlocData()) {
    on<DoDemoAccountLogin>((data, emit) async {
      await runOnce(() async {
        if (await login.demoAccountLogin(data.credentials).isErr()) {
          showSnackBar(R.strings.login_screen_demo_account_login_failed);
        }
      });
    });
    on<DoDemoAccountLogout>((_, emit) async {
      await runOnce(() async {
        await login.demoAccountLogout();
      });
    });
    on<NewDemoAccountUserIdValue>((id, emit) {
      emit(state.copyWith(userId: id.value));
    });
    on<NewDemoAccountPasswordValue>((key, emit) {
      emit(state.copyWith(password: key.value));
    });
    on<NewLoginProgressValue>((key, emit) {
      emit(state.copyWith(loginProgressVisible: key.value));
    });

    login.demoAccountUserId.listen((event) {
      add(NewDemoAccountUserIdValue(event));
    });
    login.demoAccountPassword.listen((event) {
      add(NewDemoAccountPasswordValue(event));
    });
    login.demoAccountLoginInProgress.listen((event) {
      add(NewLoginProgressValue(event));
    });
  }
}
