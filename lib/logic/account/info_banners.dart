import 'dart:async';

import 'package:app/data/account_repository.dart';
import 'package:app/data/utils/repository_instances.dart';
import 'package:database/database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

sealed class InfoBannersEvent {}

class InfoBannerDismissStatesChanged extends InfoBannersEvent {
  final Map<String, InfoBannerDismissState> value;
  InfoBannerDismissStatesChanged(this.value);
}

class DismissInfoBanner extends InfoBannersEvent {
  final String bannerKey;
  final int bannerVersion;

  DismissInfoBanner({required this.bannerKey, required this.bannerVersion});
}

class InfoBannersBloc extends Bloc<InfoBannersEvent, Map<String, InfoBannerDismissState>> {
  final AccountRepository accountRepository;

  StreamSubscription<Map<String, InfoBannerDismissState>>? _dismissStatesSubscription;

  InfoBannersBloc(RepositoryInstances r)
    : accountRepository = r.account,
      super(Map.unmodifiable(r.account.infoBannerDismissStatesValue)) {
    on<InfoBannerDismissStatesChanged>((data, emit) {
      emit(Map.unmodifiable(data.value));
    });
    on<DismissInfoBanner>((data, emit) async {
      await accountRepository.dismissInfoBanner(
        bannerKey: data.bannerKey,
        bannerVersion: data.bannerVersion,
      );
    });

    _dismissStatesSubscription = accountRepository.infoBannerDismissStates.listen(
      (value) => add(InfoBannerDismissStatesChanged(value)),
    );
  }

  @override
  Future<void> close() async {
    await _dismissStatesSubscription?.cancel();
    return super.close();
  }
}
