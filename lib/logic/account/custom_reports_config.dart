import "dart:async";

import "package:app/data/utils/repository_instances.dart";
import "package:app/database/account_database_manager.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";

sealed class CustomReportsConfigEvent {}

class ConfigChanged extends CustomReportsConfigEvent {
  final CustomReportsConfig value;
  ConfigChanged(this.value);
}

class CustomReportsConfigBloc extends Bloc<CustomReportsConfigEvent, CustomReportsConfig> {
  final AccountDatabaseManager db;

  StreamSubscription<CustomReportsConfig?>? _configSubscription;

  CustomReportsConfigBloc(RepositoryInstances r)
    : db = r.accountDb,
      super(emptyCustomReportConfig()) {
    on<ConfigChanged>((data, emit) async {
      emit(data.value);
    });
    _configSubscription = db
        .accountStream((db) => db.config.watchCustomReportsConfig())
        .listen((value) => add(ConfigChanged(value ?? emptyCustomReportConfig())));
  }

  @override
  Future<void> close() async {
    await _configSubscription?.cancel();
    return super.close();
  }
}

CustomReportsConfig emptyCustomReportConfig() {
  return CustomReportsConfig(reportOrder: CustomReportsOrderMode.orderNumber, report: []);
}
