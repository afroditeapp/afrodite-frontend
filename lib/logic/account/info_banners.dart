import 'dart:async';

import 'package:app/data/account_repository.dart';
import 'package:app/data/utils/repository_instances.dart';
import 'package:app/database/account_database_manager.dart';
import 'package:app/model/freezed/logic/account/info_banners.dart';
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

class MaintenanceInfoChanged extends InfoBannersEvent {
  final ServerMaintenanceInfo value;
  MaintenanceInfoChanged(this.value);
}

class ViewServerMaintenanceInfo extends InfoBannersEvent {}

class InfoBannersBloc extends Bloc<InfoBannersEvent, InfoBannersData> {
  final AccountRepository accountRepository;
  final AccountDatabaseManager db;

  StreamSubscription<Map<String, InfoBannerDismissState>>? _dismissStatesSubscription;
  StreamSubscription<ServerMaintenanceInfo?>? _maintenanceInfoSubscription;

  InfoBannersBloc(RepositoryInstances r)
    : accountRepository = r.account,
      db = r.accountDb,
      super(
        InfoBannersData(
          dismissStates: r.account.infoBannerDismissStatesValue,
          maintenanceInfo: ServerMaintenanceInfo.empty(),
        ),
      ) {
    on<InfoBannerDismissStatesChanged>((data, emit) {
      emit(state.copyWith(dismissStates: data.value));
    });
    on<DismissInfoBanner>((data, emit) async {
      await accountRepository.dismissInfoBanner(
        bannerKey: data.bannerKey,
        bannerVersion: data.bannerVersion,
      );
    });
    on<MaintenanceInfoChanged>((data, emit) {
      emit(state.copyWith(maintenanceInfo: data.value));
    });
    on<ViewServerMaintenanceInfo>((data, emit) async {
      if (state.maintenanceInfo.showBadge) {
        await db.accountAction((db) => db.common.setMaintenanceBadgeViewed());
      }
    });

    _dismissStatesSubscription = accountRepository.infoBannerDismissStates.listen(
      (value) => add(InfoBannerDismissStatesChanged(value)),
    );
    _maintenanceInfoSubscription = db
        .accountStream((db) => db.common.watchServerMaintenanceInfo())
        .listen((value) => add(MaintenanceInfoChanged(value ?? ServerMaintenanceInfo.empty())));
  }

  @override
  Future<void> close() async {
    await _dismissStatesSubscription?.cancel();
    await _maintenanceInfoSubscription?.cancel();
    return super.close();
  }
}
