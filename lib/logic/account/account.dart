import "package:flutter_bloc/flutter_bloc.dart";
import "package:pihka_frontend/data/account_repository.dart";
import "package:pihka_frontend/ui/initial_setup.dart";


class AccountData {

}

abstract class AccountEvent {}

class RegisterEvent extends AccountEvent {}
class LoginEvent extends AccountEvent {}

// class AccountBloc extends Bloc<AccountEvent, void> {
//   final AccountRepository account;

//   MainStateBloc(this.account) : super(MainState.splashScreen) {
//     on<ToSplashScreen>((_, emit) => emit(MainState.splashScreen));
//     on<ToLoginRequiredScreen>((_, emit) => emit(MainState.loginRequired));

//     account.accountState().listen((event) {
//       print("test: $event");

//       if (event == MainState.loginRequired) {
//           print("object");
//           add(ToLoginRequiredScreen());
//         } else if (event == MainState.initialSetup) {
//           add(ToInitialSetup());
//         } else if (event == MainState.initialSetupComplete) {
//           add(ToMainScreen());
//         } else if (event == MainState.accountBanned) {
//           add(ToAccountBannedScreen());
//         } else if (event == MainState.pendingRemoval) {
//           add(ToPendingRemovalScreen());
//         } else if (event == MainState.splashScreen) {
//           add(ToSplashScreen());
//         }
//     });
//   }
// }
