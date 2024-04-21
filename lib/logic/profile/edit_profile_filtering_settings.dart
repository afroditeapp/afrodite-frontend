
import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";
import "package:pihka_frontend/data/profile_repository.dart";
import "package:pihka_frontend/model/freezed/logic/profile/edit_profile_filtering_settings.dart";
import "package:pihka_frontend/utils.dart";

sealed class EditProfileFilteringSettingsEvent {}
class ResetStateWith extends EditProfileFilteringSettingsEvent {
  final bool showOnlyFavorites;
  final List<ProfileAttributeFilterValueUpdate> attributeFilters;
  ResetStateWith(this.showOnlyFavorites, this.attributeFilters);
}

class SetFavoriteProfilesFilter extends EditProfileFilteringSettingsEvent {
  final bool value;
  SetFavoriteProfilesFilter(this.value);
}

class EditProfileFilteringSettingsBloc extends Bloc<EditProfileFilteringSettingsEvent, EditProfileFilteringSettingsData> with ActionRunner {
  final ProfileRepository profile = ProfileRepository.getInstance();

  EditProfileFilteringSettingsBloc() : super(EditProfileFilteringSettingsData()) {
    on<ResetStateWith>((data, emit) async {
      emit(state.copyWith(showOnlyFavorites: data.showOnlyFavorites));
    });
    on<SetFavoriteProfilesFilter>((data, emit) async {
      emit(state.copyWith(showOnlyFavorites: data.value));
    });
  }
}
