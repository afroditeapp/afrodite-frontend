import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";
import "package:pihka_frontend/data/profile_repository.dart";
import "package:pihka_frontend/utils.dart";


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
  final ProfileRepository profile = ProfileRepository.getInstance();

  LocationBloc() : super(null) {
    on<SetLocation>((data, emit) async {
      await ProfileRepository.getInstance().updateLocation(data.location);
    });
    on<NewLocation>((data, emit) async {
      emit(data.location);
    });

    ProfileRepository.getInstance().location.listen((value) => add(NewLocation(value)));
  }
}
