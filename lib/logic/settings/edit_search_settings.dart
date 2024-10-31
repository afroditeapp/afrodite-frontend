import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";
import 'package:app/database/database_manager.dart';
import "package:app/model/freezed/logic/account/initial_setup.dart";
import "package:app/model/freezed/logic/settings/edit_search_settings.dart";
import "package:app/utils/api.dart";

sealed class EditSearchSettingsEvent {}
class SetInitialValues extends EditSearchSettingsEvent {
  final int? minAge;
  final int? maxAge;
  final SearchGroups? searchGroups;
  SetInitialValues(
    {
      required this.minAge,
      required this.maxAge,
      required this.searchGroups,
    }
  );
}
class UpdateMinAge extends EditSearchSettingsEvent {
  final int? value;
  UpdateMinAge(this.value);
}
class UpdateMaxAge extends EditSearchSettingsEvent {
  final int? value;
  UpdateMaxAge(this.value);
}
class UpdateGender extends EditSearchSettingsEvent {
  final Gender value;
  UpdateGender(this.value);
}
class UpdateGenderSearchSettingAll extends EditSearchSettingsEvent {
  final GenderSearchSettingsAll settings;
  UpdateGenderSearchSettingAll(this.settings);
}

class EditSearchSettingsBloc extends Bloc<EditSearchSettingsEvent, EditSearchSettingsData> {
  final db = DatabaseManager.getInstance();

  EditSearchSettingsBloc() : super(EditSearchSettingsData()) {
    on<SetInitialValues>((data, emit) async {
      emit(EditSearchSettingsData(
        minAge: data.minAge,
        maxAge: data.maxAge,
        gender: data.searchGroups?.toGender(),
        genderSearchSetting: data.searchGroups?.toGenderSearchSettingsAll() ?? const GenderSearchSettingsAll(),
      ));
    });
    on<UpdateMinAge>((data, emit) async {
      emit(state.copyWith(minAge: data.value));
    });
    on<UpdateMaxAge>((data, emit) async {
      emit(state.copyWith(maxAge: data.value));
    });
    on<UpdateGenderSearchSettingAll>((data, emit) async {
      emit(state.copyWith(genderSearchSetting: data.settings));
    });
    on<UpdateGender>((data, emit) async {
      emit(
        state.copyWith(
          gender: data.value,
          genderSearchSetting: const GenderSearchSettingsAll(),
        )
      );
    });
  }
}
