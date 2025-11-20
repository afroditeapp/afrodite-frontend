import "dart:async";

import "package:app/data/account_repository.dart";
import "package:app/data/utils/repository_instances.dart";
import "package:app/model/freezed/logic/account/client_features_config.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:logging/logging.dart";
import "package:openapi/api.dart";
import "package:utils/utils.dart";

final _log = Logger("ClientFeaturesConfigBloc");

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
  final AccountRepository accountRepository;

  StreamSubscription<ClientFeaturesConfig>? _configSubscription;
  StreamSubscription<int?>? _dailyLikesLeftSubscription;

  ClientFeaturesConfigBloc(RepositoryInstances r)
    : accountRepository = r.account,
      super(ClientFeaturesConfigData(config: emptyClientFeaturesConfig())) {
    on<ConfigChanged>((data, emit) async {
      final regex = data.value.profile?.profileNameRegex;
      RegExp? profileNameRegex;
      if (regex != null) {
        try {
          profileNameRegex = RegExp(regex);
        } catch (_) {
          _log.error("Invalid profile name regex");
        }
      }
      emit(state.copyWith(config: data.value, profileNameRegex: profileNameRegex));
    });
    on<DailyLikesLeftChanged>((data, emit) {
      emit(state.copyWith(dailyLikesLeft: data.value));
    });
    _configSubscription = accountRepository.clientFeaturesConfig.listen(
      (value) => add(ConfigChanged(value)),
    );
    _dailyLikesLeftSubscription = r.accountDb
        .accountStream((db) => db.like.watchDailyLikesLeft())
        .listen((value) => add(DailyLikesLeftChanged(value)));
  }

  @override
  Future<void> close() async {
    await _configSubscription?.cancel();
    await _dailyLikesLeftSubscription?.cancel();
    return super.close();
  }
}
