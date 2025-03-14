import "dart:async";

import "package:app/database/account_database_manager.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:app/data/login_repository.dart";
import "package:openapi/api.dart";

sealed class CustomReportsConfigEvent {}
class ConfigChanged extends CustomReportsConfigEvent {
  final CustomReportsConfig value;
  ConfigChanged(this.value);
}

class CustomReportsConfigBloc extends Bloc<CustomReportsConfigEvent, CustomReportsConfig> {
  final AccountDatabaseManager db = LoginRepository.getInstance().repositories.accountDb;

  StreamSubscription<CustomReportsConfig?>? _configSubscription;

  CustomReportsConfigBloc() : super(emptyCustomReportConfig()) {
    on<ConfigChanged>((data, emit) async {
      emit(data.value);
    });
    _configSubscription = db.accountStream((db) => db.daoCustomReports.watchCustomReportsConfig())
      .listen((value) => add(ConfigChanged(value ?? emptyCustomReportConfig())));
  }

  @override
  Future<void> close() async {
    await _configSubscription?.cancel();
    return super.close();
  }
}

CustomReportsConfig emptyCustomReportConfig() {
  return CustomReportsConfig(
    reportOrder: CustomReportsOrderMode.orderNumber,
    report: [],
  );
}
