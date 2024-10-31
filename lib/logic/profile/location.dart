import "dart:async";

import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";
import "package:app/data/login_repository.dart";
import "package:app/data/profile_repository.dart";
import "package:app/utils.dart";


sealed class LocationEvent {}
class SetLocation extends LocationEvent {
  final Location location;
  SetLocation(this.location);
}
class NewLocation extends LocationEvent {
  final Location location;
  NewLocation(this.location);
}

class LocationBloc extends Bloc<LocationEvent, Location?> with ActionRunner {
  final ProfileRepository profile = LoginRepository.getInstance().repositories.profile;

  StreamSubscription<Location?>? _locationSubscription;

  LocationBloc() : super(null) {
    on<SetLocation>((data, emit) async {
      await profile.updateLocation(data.location);
    });
    on<NewLocation>((data, emit) async {
      emit(data.location);
    });

    _locationSubscription = profile
      .location
      .listen((value) => add(NewLocation(value)));
  }

  @override
  Future<void> close() async {
    await _locationSubscription?.cancel();
    await super.close();
  }
}
