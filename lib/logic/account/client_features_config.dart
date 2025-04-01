import "dart:async";

import "package:app/database/account_database_manager.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:app/data/login_repository.dart";
import "package:openapi/api.dart";

sealed class ClientFeaturesConfigEvent {}
class ConfigChanged extends ClientFeaturesConfigEvent {
  final ClientFeaturesConfig value;
  ConfigChanged(this.value);
}

class ClientFeaturesConfigBloc extends Bloc<ClientFeaturesConfigEvent, ClientFeaturesConfig> {
  final AccountDatabaseManager db = LoginRepository.getInstance().repositories.accountDb;

  StreamSubscription<ClientFeaturesConfig?>? _configSubscription;

  ClientFeaturesConfigBloc() : super(_emptyClientFeaturesConfig()) {
    on<ConfigChanged>((data, emit) async {
      emit(data.value);
    });
    _configSubscription = db.accountStream((db) => db.daoClientFeatures.watchClientFeaturesConfig())
      .listen((value) => add(ConfigChanged(value ?? _emptyClientFeaturesConfig())));
  }

  @override
  Future<void> close() async {
    await _configSubscription?.cancel();
    return super.close();
  }
}

ClientFeaturesConfig _emptyClientFeaturesConfig() {
  return ClientFeaturesConfig(
    features: FeaturesConfig(news: false),
    map: MapConfig(
      bounds: MapBounds(
        topLeft: MapCoordinate(lat: 90, lon: -180),
        bottomRight: MapCoordinate(lat: -90, lon: 180),
      ),
      initialLocation: MapCoordinate(lat: 0, lon: 0),
      zoom: MapZoom(
        locationNotSelected: 0,
        locationSelected: 0,
        max: 19,
        maxTileDownloading: 19,
        min: 0,
      ),
    ),
  );
}
