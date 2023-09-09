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

  ServerAddressBloc(this.account) : super(defaultAccountServerAddress()) {
    on<ChangeCachedServerAddress>((data, emit) async {
      await account.setCurrentServerAddress(data.value);
      emit(data.value);
    });

    account.accountServerAddress.listen((value) => add(ChangeCachedServerAddress(value)));
  }
}
