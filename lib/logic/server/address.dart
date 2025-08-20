import "package:app/api/api_provider.dart";
import "package:app/ui_utils/snack_bar.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:app/config.dart";
import "package:app/data/login_repository.dart";

sealed class ServerAddressEvent {}

class ChangeCachedServerAddress extends ServerAddressEvent {
  final String value;
  ChangeCachedServerAddress(this.value);
}

class ServerAddressBloc extends Bloc<ServerAddressEvent, String> {
  final LoginRepository login = LoginRepository.getInstance();

  ServerAddressBloc() : super(defaultServerUrl()) {
    on<ChangeCachedServerAddress>((data, emit) async {
      if (data.value == state) {
        return;
      }

      const error = "Error: server address change failed, Details: backend version request failed";
      try {
        final api = ApiProvider(data.value);
        final value = await api.common.getVersion();
        if (value == null) {
          showSnackBar(error);
          return;
        }
      } catch (_) {
        showSnackBar(error);
        return;
      }

      await login.setCurrentServerAddress(data.value);
      showSnackBar("Server address changed");
      emit(data.value);
    });

    login.accountServerAddress.listen((value) => add(ChangeCachedServerAddress(value)));
  }
}
