import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";
import "package:pihka_frontend/api/api_manager.dart";
import "package:pihka_frontend/data/profile_repository.dart";
import "package:pihka_frontend/utils.dart";
import "package:pihka_frontend/utils/result.dart";


sealed class LocationEvent {}
class SetLocation extends LocationEvent {
  final Location location;
  SetLocation(this.location);
}
class LoadLocation extends LocationEvent {
  LoadLocation();
}
class NewLocation extends LocationEvent {
  final Location location;
  NewLocation(this.location);
}

class LocationBloc extends Bloc<LocationEvent, Location> with ActionRunner {
  final ProfileRepository profile;

  LocationBloc(this.profile) : super(Location(latitude: 0.0, longitude: 0.0)) {
    on<SetLocation>((data, emit) async {
      await ProfileRepository.getInstance().updateLocation(data.location);
    });
    on<LoadLocation>((data, emit) async {
      final location = await ApiManager.getInstance().profile((api) => api.getLocation());
      if (location case Ok(:final v)) {
        emit(v);
      }
    });
    on<NewLocation>((data, emit) async {
      emit(data.location);
    });

    ProfileRepository.getInstance().location.listen((value) => add(NewLocation(value)));
  }
}
