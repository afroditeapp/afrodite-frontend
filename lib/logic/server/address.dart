import "package:flutter_bloc/flutter_bloc.dart";
import "package:pihka_frontend/config.dart";
import "package:pihka_frontend/data/login_repository.dart";

sealed class ServerAddressEvent {}
class ChangeCachedServerAddress extends ServerAddressEvent {
  final String value;
  ChangeCachedServerAddress(this.value);
}

class ServerAddressBloc extends Bloc<ServerAddressEvent, String> {
  final LoginRepository login = LoginRepository.getInstance();

  ServerAddressBloc() : super(defaultServerUrlAccount()) {
    on<ChangeCachedServerAddress>((data, emit) async {
      await login.setCurrentServerAddress(data.value);
      emit(data.value);
    });

    login.accountServerAddress.listen((value) => add(ChangeCachedServerAddress(value)));
  }
}
