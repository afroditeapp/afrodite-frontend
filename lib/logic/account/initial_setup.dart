import "package:camera/camera.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";
import "package:pihka_frontend/data/account_repository.dart";
import "package:pihka_frontend/ui/initial_setup.dart";
import "package:rxdart/rxdart.dart";

class InitialSetupData {
  String email = "";
  String profileName = "";
  XFile? securitySelfie;
}

abstract class InitialSetupEvent {}
class SetEmail extends InitialSetupEvent {
  final String email;
  SetEmail(this.email);
}
class SetProfileName extends InitialSetupEvent {
  final String profileName;
  SetProfileName(this.profileName);
}
class SetSecuritySelfie extends InitialSetupEvent {
  final XFile securitySelfie;
  SetSecuritySelfie(this.securitySelfie);
}
class SendAll extends InitialSetupEvent {}

/// Do register/login operations
class InitialSetupBloc extends Bloc<InitialSetupEvent, InitialSetupData> {
  final AccountRepository account;

  InitialSetupBloc(this.account) : super(InitialSetupData()) {
    on<SetEmail>((data, emit) {
      state.email = data.email;
      emit(state);
    });
    on<SetProfileName>((data, emit) {
      state.profileName = data.profileName;
      emit(state);
    });
    on<SetSecuritySelfie>((data, emit) {
      state.securitySelfie = data.securitySelfie;
      emit(state);
    });
    on<SendAll>((_, emit) {
      // TODO: run account setup api calls
    });
  }
}
