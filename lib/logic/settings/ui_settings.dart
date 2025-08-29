import "dart:async";

import "package:app/data/utils/repository_instances.dart";
import "package:app/database/account_database_manager.dart";
import "package:app/ui_utils/extensions/other.dart";
import "package:database/database.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:app/model/freezed/logic/settings/ui_settings.dart";

sealed class UiSettingsEvent {}

class NewGridSettings extends UiSettingsEvent {
  final GridSettings value;
  NewGridSettings(this.value);
}

class ResetGridSettings extends UiSettingsEvent {}

class UpdateItemSizeMode extends UiSettingsEvent {
  final int value;
  UpdateItemSizeMode(this.value);
}

class UpdatePaddingMode extends UiSettingsEvent {
  final int value;
  UpdatePaddingMode(this.value);
}

class UiSettingsBloc extends Bloc<UiSettingsEvent, UiSettingsData> {
  final AccountDatabaseManager db;

  StreamSubscription<GridSettings?>? _gridSettingsSubscription;

  UiSettingsBloc(RepositoryInstances r) : db = r.accountDb, super(UiSettingsData()) {
    on<NewGridSettings>((data, emit) {
      emit(state.copyWith(gridSettings: data.value));
    });
    on<ResetGridSettings>((data, emit) {
      emit(state.copyWith(gridSettings: const GridSettings()));
    });
    on<UpdateItemSizeMode>((data, emit) {
      saveGridSettings((s) => s.copyWith(itemSizeMode: data.value));
    });
    on<UpdatePaddingMode>((data, emit) {
      saveGridSettings((s) => s.copyWith(paddingMode: data.value));
    });
    _gridSettingsSubscription = db.accountStream((db) => db.app.watchGridSettings()).listen((
      value,
    ) {
      add(NewGridSettings(value ?? const GridSettings()));
    });
  }

  void saveGridSettings(GridSettings Function(GridSettings) action) {
    final newSettings = action(state.gridSettings);
    db.accountAction((db) => db.app.updateGridSettings(newSettings));
  }

  @override
  Future<void> close() async {
    await _gridSettingsSubscription?.cancel();
    await super.close();
  }
}
