import "dart:async";

import "package:bloc_concurrency/bloc_concurrency.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:pihka_frontend/data/login_repository.dart";
import "package:pihka_frontend/database/account_background_database_manager.dart";
import "package:pihka_frontend/model/freezed/logic/settings/user_interface.dart";

sealed class UserInterfaceSettingsEvent {}
class NewShowNonAcceptedProfileNames extends UserInterfaceSettingsEvent {
  final bool value;
  NewShowNonAcceptedProfileNames(this.value);
}
class UpdateShowNonAcceptedProfileNames extends UserInterfaceSettingsEvent {
  final bool value;
  UpdateShowNonAcceptedProfileNames(this.value);
}

class UserInterfaceSettingsBloc extends Bloc<UserInterfaceSettingsEvent, UserInterfaceSettingsData> {
  final AccountBackgroundDatabaseManager db = LoginRepository.getInstance().repositories.accountBackgroundDb;

  StreamSubscription<bool?>? _showNonAcceptedProfileNamesSubscription;

  UserInterfaceSettingsBloc() : super(UserInterfaceSettingsData()) {
    on<UpdateShowNonAcceptedProfileNames>((data, emit) async {
      await db.accountAction((db) => db.daoUserInterfaceSettings.updateShowNonAcceptedProfileNames(data.value));
    },
      transformer: sequential(),
    );
    on<NewShowNonAcceptedProfileNames>((data, emit) {
      emit(state.copyWith(showNonAcceptedProfileNames: data.value));
    });

    _showNonAcceptedProfileNamesSubscription = db.accountStream((db) => db.daoUserInterfaceSettings.watchShowNonAcceptedProfileNames()).listen((event) {
      add(NewShowNonAcceptedProfileNames(event ?? false));
    });
  }

  @override
  Future<void> close() async {
    await _showNonAcceptedProfileNamesSubscription?.cancel();
    await super.close();
  }
}
