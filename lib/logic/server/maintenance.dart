import "dart:async";

import "package:app/database/account_database_manager.dart";
import "package:database/database.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:app/data/login_repository.dart";

sealed class ServerMaintenanceEvent {}

class MaintenanceInfoChanged extends ServerMaintenanceEvent {
  final ServerMaintenanceInfo value;
  MaintenanceInfoChanged(this.value);
}

class ViewServerMaintenanceInfo extends ServerMaintenanceEvent {}

class ServerMaintenanceBloc extends Bloc<ServerMaintenanceEvent, ServerMaintenanceInfo> {
  final AccountDatabaseManager db = LoginRepository.getInstance().repositories.accountDb;

  StreamSubscription<ServerMaintenanceInfo?>? _maintenanceInfoSubscription;

  ServerMaintenanceBloc() : super(ServerMaintenanceInfo.empty()) {
    on<MaintenanceInfoChanged>((data, emit) async {
      emit(data.value);
    });
    on<ViewServerMaintenanceInfo>((data, emit) async {
      final latest = state.maintenanceLatest;
      if (latest != null && state.uiBadgeCount() == 1) {
        await db.accountAction((db) => db.common.setMaintenanceTimeViewed(time: latest));
      }
    });

    _maintenanceInfoSubscription = db
        .accountStream((db) => db.common.watchServerMaintenanceInfo())
        .listen((value) => add(MaintenanceInfoChanged(value ?? ServerMaintenanceInfo.empty())));
  }

  @override
  Future<void> close() async {
    await _maintenanceInfoSubscription?.cancel();
    return super.close();
  }
}
