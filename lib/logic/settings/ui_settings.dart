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

class NewUserPreferredContentQuality extends UiSettingsEvent {
  final UserPreferredContentQuality value;
  NewUserPreferredContentQuality(this.value);
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

class UpdateUserPreferredContentQuality extends UiSettingsEvent {
  final String? value;
  UpdateUserPreferredContentQuality(this.value);
}

class UiSettingsBloc extends Bloc<UiSettingsEvent, UiSettingsData> {
  final AccountDatabaseManager db;

  StreamSubscription<GridSettings?>? _gridSettingsSubscription;
  StreamSubscription<UserPreferredContentQuality?>? _userPreferredContentQualitySubscription;

  UiSettingsBloc(RepositoryInstances r) : db = r.accountDb, super(UiSettingsData()) {
    on<NewGridSettings>((data, emit) {
      emit(state.copyWith(gridSettings: data.value));
    });
    on<NewUserPreferredContentQuality>((data, emit) {
      emit(state.copyWith(userPreferredContentQuality: data.value));
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
    on<UpdateUserPreferredContentQuality>((data, emit) {
      saveUserPreferredContentQuality(data.value);
    });
    _gridSettingsSubscription = db.accountStream((db) => db.app.watchGridSettings()).listen((
      value,
    ) {
      add(NewGridSettings(value ?? const GridSettings()));
    });
    _userPreferredContentQualitySubscription = db
        .accountStream((db) => db.app.watchUserPreferredContentQuality())
        .listen((value) {
          add(NewUserPreferredContentQuality(value ?? const UserPreferredContentQuality()));
        });
  }

  void saveGridSettings(GridSettings Function(GridSettings) action) {
    final newSettings = action(state.gridSettings);
    db.accountAction((db) => db.app.updateGridSettings(newSettings));
  }

  void saveUserPreferredContentQuality(String? quality) {
    db.accountAction((db) => db.app.updateUserPreferredContentQuality(quality));
  }

  @override
  Future<void> close() async {
    await _gridSettingsSubscription?.cancel();
    await _userPreferredContentQualitySubscription?.cancel();
    await super.close();
  }
}
