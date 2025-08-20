import "dart:async";

import "package:app/model/freezed/logic/account/demo_account_login.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:logging/logging.dart";
import "package:app/data/login_repository.dart";
import "package:app/localizations.dart";
import "package:app/ui_utils/snack_bar.dart";
import "package:app/utils.dart";
import "package:app/utils/result.dart";

var log = Logger("DemoAccountBloc");

abstract class DemoAccountLoginEvent {}

class DoDemoAccountLogin extends DemoAccountLoginEvent {
  final DemoAccountCredentials credentials;
  DoDemoAccountLogin(this.credentials);
}

class NewDemoAccountUsernameValue extends DemoAccountLoginEvent {
  final String? value;
  NewDemoAccountUsernameValue(this.value);
}

class NewDemoAccountPasswordValue extends DemoAccountLoginEvent {
  final String? value;
  NewDemoAccountPasswordValue(this.value);
}

class NewLoginProgressValue extends DemoAccountLoginEvent {
  final bool value;
  NewLoginProgressValue(this.value);
}

class DemoAccountLoginBloc extends Bloc<DemoAccountLoginEvent, DemoAccountLoginData>
    with ActionRunner {
  final LoginRepository login = LoginRepository.getInstance();

  StreamSubscription<String?>? usernameSubscription;
  StreamSubscription<String?>? passwordSubscription;
  StreamSubscription<bool>? demoAccountLoginSubscription;

  DemoAccountLoginBloc() : super(DemoAccountLoginData()) {
    on<DoDemoAccountLogin>((data, emit) async {
      switch (await login.demoAccountLogin(data.credentials)) {
        case Ok():
          null;
        case Err(e: DemoAccountLoginError.otherError):
          showSnackBar(R.strings.login_screen_demo_account_login_failed);
        case Err(e: DemoAccountLoginError.accountLocked):
          showSnackBar(R.strings.login_screen_demo_account_locked);
      }
    });
    on<NewDemoAccountUsernameValue>((id, emit) {
      emit(state.copyWith(username: id.value));
    });
    on<NewDemoAccountPasswordValue>((key, emit) {
      emit(state.copyWith(password: key.value));
    });
    on<NewLoginProgressValue>((key, emit) {
      emit(state.copyWith(loginProgressVisible: key.value));
    });

    usernameSubscription = login.demoAccountUsername.listen((event) {
      add(NewDemoAccountUsernameValue(event));
    });
    passwordSubscription = login.demoAccountPassword.listen((event) {
      add(NewDemoAccountPasswordValue(event));
    });
    demoAccountLoginSubscription = login.demoAccountLoginProgress.listen((event) {
      add(NewLoginProgressValue(event));
    });
  }

  @override
  Future<void> close() {
    usernameSubscription?.cancel();
    passwordSubscription?.cancel();
    demoAccountLoginSubscription?.cancel();
    return super.close();
  }
}
