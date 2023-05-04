import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";
import "package:pihka_frontend/data/account_repository.dart";
import "package:pihka_frontend/ui/initial_setup.dart";
import "package:rxdart/rxdart.dart";


class AccountData {
  AccountIdLight? accountId;
  ApiKey? apiKey;
}

// abstract class InitialSetupEvent {}
// class StepCancel extends InitialSetupEvent {}
// class StepContinue extends InitialSetupEvent {}
// class SelectStep extends InitialSetupEvent {
//   final AccountIdLight value;
//   NewAccountIdValue(this.value);
// }
// class NewApiKeyValue extends AccountEvent {
//   final ApiKey value;
//   NewApiKeyValue(this.value);
// }

// /// Do register/login operations
// class AccountBloc extends Bloc<AccountEvent, AccountData> {
//   final AccountRepository account;

//   AccountBloc(this.account) : super(AccountData()) {
//     on<DoRegister>((_, emit) {
//       return account.register();
//     });
//     on<DoLogin>((_, emit) {
//       return account.login();
//     });
//     on<NewAccountIdValue>((id, emit) {
//       state.accountId = id.value;
//       emit(state);
//     });
//     on<NewApiKeyValue>((key, emit) {
//       state.apiKey = key.value;
//       emit(state);
//     });

//     account.currentAccountId().whereNotNull().listen((event) {
//       add(NewAccountIdValue(event));
//     });
//     account.currentApiKey().whereNotNull().listen((event) { add(NewApiKeyValue(event)); });
//   }
// }
