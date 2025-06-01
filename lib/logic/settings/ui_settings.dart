import "dart:async";

import "package:app/database/account_database_manager.dart";
import "package:app/ui_utils/extensions/other.dart";
import "package:database/database.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:app/data/login_repository.dart";
import "package:app/model/freezed/logic/settings/ui_settings.dart";

sealed class UiSettingsEvent {}
class NewGridSettings extends UiSettingsEvent {
  final GridSettings value;
  NewGridSettings(this.value);
}
class ResetGridSettings extends UiSettingsEvent {}
class UpdateHorizontalPadding extends UiSettingsEvent {
  final double value;
  UpdateHorizontalPadding(this.value);
}
class UpdateInternalPadding extends UiSettingsEvent {
  final double value;
  UpdateInternalPadding(this.value);
}
class UpdateProfileThumbnailBorderRadius extends UiSettingsEvent {
  final double value;
  UpdateProfileThumbnailBorderRadius(this.value);
}
class UpdateRowProfileCount extends UiSettingsEvent {
  final int value;
  UpdateRowProfileCount(this.value);
}

class UiSettingsBloc extends Bloc<UiSettingsEvent, UiSettingsData> {
  final AccountDatabaseManager db = LoginRepository.getInstance().repositories.accountDb;

  StreamSubscription<GridSettings?>? _gridSettingsSubscription;

  UiSettingsBloc() : super(UiSettingsData()) {
    on<NewGridSettings>((data, emit) {
      emit(state.copyWith(
        gridSettings: data.value,
      ));
    });
    on<ResetGridSettings>((data, emit) {
      emit(state.copyWith(
        gridSettings: const GridSettings(),
      ));
    });
    on<UpdateHorizontalPadding>((data, emit) {
      emitGridSettings(emit, (s) => s.copyWith(horizontalPadding: data.value));
    });
    on<UpdateInternalPadding>((data, emit) {
      emitGridSettings(emit, (s) => s.copyWith(internalPadding: data.value));
    });
    on<UpdateProfileThumbnailBorderRadius>((data, emit) {
      emitGridSettings(emit, (s) => s.copyWith(profileThumbnailBorderRadius: data.value));
    });
    on<UpdateRowProfileCount>((data, emit) {
      emitGridSettings(emit, (s) => s.copyWith(rowProfileCount: data.value));
    });
    _gridSettingsSubscription = db.accountStream((db) => db.daoUiSettings.watchGridSettings()).listen((value) {
      add(NewGridSettings(value ?? const GridSettings()));
    });
  }

  void emitGridSettings(Emitter<UiSettingsData> emit, GridSettings Function(GridSettings) action) {
    emit(state.copyWith(
      gridSettings: action(state.gridSettings),
    ));
  }

  @override
  Future<void> close() async {
    await _gridSettingsSubscription?.cancel();
    await super.close();
  }
}
