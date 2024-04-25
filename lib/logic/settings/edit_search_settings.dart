import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";
import 'package:pihka_frontend/database/database_manager.dart';
import "package:pihka_frontend/model/freezed/logic/settings/edit_search_settings.dart";


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
class UpdateSearchGroups extends EditSearchSettingsEvent {
  final SearchGroups value;
  UpdateSearchGroups(this.value);
}

class EditSearchSettingsBloc extends Bloc<EditSearchSettingsEvent, EditSearchSettingsData> {
  final db = DatabaseManager.getInstance();

  EditSearchSettingsBloc() : super(EditSearchSettingsData()) {
    on<SetInitialValues>((data, emit) async {
      emit(EditSearchSettingsData(
        minAge: data.minAge,
        maxAge: data.maxAge,
        searchGroups: data.searchGroups,
      ));
    });
    on<UpdateMinAge>((data, emit) async {
      emit(state.copyWith(minAge: data.value));
    });
    on<UpdateMaxAge>((data, emit) async {
      emit(state.copyWith(maxAge: data.value));
    });
    on<UpdateSearchGroups>((data, emit) async {
      emit(state.copyWith(searchGroups: data.value));
    });
  }
}
