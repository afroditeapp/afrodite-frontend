import "dart:async";

import "package:app/data/account_repository.dart";
import "package:app/data/utils/repository_instances.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";

sealed class DynamicClientFeaturesConfigEvent {}

class DynamicConfigChanged extends DynamicClientFeaturesConfigEvent {
  final DynamicClientFeaturesConfig value;
  DynamicConfigChanged(this.value);
}

class DynamicClientFeaturesConfigBloc
    extends Bloc<DynamicClientFeaturesConfigEvent, DynamicClientFeaturesConfig> {
  final AccountRepository accountRepository;

  StreamSubscription<DynamicClientFeaturesConfig>? _configSubscription;

  DynamicClientFeaturesConfigBloc(RepositoryInstances r)
    : accountRepository = r.account,
      super(r.account.dynamicClientFeaturesConfigValue) {
    on<DynamicConfigChanged>((data, emit) {
      emit(data.value);
    });
    _configSubscription = accountRepository.dynamicClientFeaturesConfig.listen(
      (value) => add(DynamicConfigChanged(value)),
    );
  }

  @override
  Future<void> close() async {
    await _configSubscription?.cancel();
    return super.close();
  }
}
