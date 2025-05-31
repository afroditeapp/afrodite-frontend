import "dart:async";

import "package:flutter_bloc/flutter_bloc.dart";
import "package:app/data/login_repository.dart";
import "package:app/database/account_background_database_manager.dart";
import "package:app/model/freezed/logic/settings/user_interface.dart";

sealed class UserInterfaceSettingsEvent {}

class UserInterfaceSettingsBloc extends Bloc<UserInterfaceSettingsEvent, UserInterfaceSettingsData> {
  final AccountBackgroundDatabaseManager db = LoginRepository.getInstance().repositories.accountBackgroundDb;

  UserInterfaceSettingsBloc() : super(UserInterfaceSettingsData());

  @override
  Future<void> close() async {
    await super.close();
  }
}
