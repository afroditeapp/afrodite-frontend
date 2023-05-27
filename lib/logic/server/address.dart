import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";
import "package:pihka_frontend/config.dart";
import "package:pihka_frontend/data/account_repository.dart";
import 'package:pihka_frontend/api/api_provider.dart';
import "package:pihka_frontend/ui/initial_setup.dart";
import "package:rxdart/rxdart.dart";

sealed class ServerAddressEvent {}
class ChangeCachedServerAddress extends ServerAddressEvent {
  final String value;
  ChangeCachedServerAddress(this.value);
}

class ServerAddressBloc extends Bloc<ServerAddressEvent, String> {
  final AccountRepository account;

  ServerAddressBloc(this.account) : super(ConfigStringKey.accountServerAddress.defaultValue()) {
    on<ChangeCachedServerAddress>((data, emit) async {
      emit(data.value);
    });

    account.getCurrentServerAddress().then((value) => add(ChangeCachedServerAddress(value)));
  }
}
