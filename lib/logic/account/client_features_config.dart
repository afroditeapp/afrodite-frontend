import "dart:async";

import "package:app/database/account_database_manager.dart";
import "package:app/model/freezed/logic/account/client_features_config.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:app/data/login_repository.dart";
import "package:openapi/api.dart";

sealed class ClientFeaturesConfigEvent {}
class ConfigChanged extends ClientFeaturesConfigEvent {
  final ClientFeaturesConfig value;
  ConfigChanged(this.value);
}
class DailyLikesLeftChanged extends ClientFeaturesConfigEvent {
  final int? value;
  DailyLikesLeftChanged(this.value);
}

class ClientFeaturesConfigBloc extends Bloc<ClientFeaturesConfigEvent, ClientFeaturesConfigData> {
  final AccountDatabaseManager db = LoginRepository.getInstance().repositories.accountDb;

  StreamSubscription<ClientFeaturesConfig?>? _configSubscription;
  StreamSubscription<int?>? _dailyLikesLeftSubscription;

  ClientFeaturesConfigBloc() : super(ClientFeaturesConfigData(config: _emptyClientFeaturesConfig())) {
    on<ConfigChanged>((data, emit) async {
      emit(state.copyWith(config: data.value));
    });
    on<DailyLikesLeftChanged>((data, emit) {
      emit(state.copyWith(dailyLikesLeft: data.value));
    });
    _configSubscription = db.accountStream((db) => db.config.watchClientFeaturesConfig())
      .listen((value) => add(ConfigChanged(value ?? _emptyClientFeaturesConfig())));
    _dailyLikesLeftSubscription = db.accountStream((db) => db.like.watchDailyLikesLeft())
      .listen((value) => add(DailyLikesLeftChanged(value)));
  }

  @override
  Future<void> close() async {
    await _configSubscription?.cancel();
    await _dailyLikesLeftSubscription?.cancel();
    return super.close();
  }
}

ClientFeaturesConfig _emptyClientFeaturesConfig() {
  return ClientFeaturesConfig(
    attribution: AttributionConfig(),
    features: FeaturesConfig(
      videoCalls: false,
    ),
    news: NewsConfig(),
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
      tileDataVersion: 0,
    ),
    limits: LimitsConfig(
      likes: LikeLimitsConfig(
        likeSending: null,
        unlimitedLikesDisablingTime: null,
      ),
    )
  );
}
