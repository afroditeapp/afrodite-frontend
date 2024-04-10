
import "package:flutter_bloc/flutter_bloc.dart";
import "package:pihka_frontend/data/profile_repository.dart";
import "package:pihka_frontend/model/freezed/logic/profile/profile_filtering_settings.dart";
import "package:pihka_frontend/utils.dart";


import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';


sealed class ProfileFilteringSettingsEvent {}
class ShowOnlyFavoritesChange extends ProfileFilteringSettingsEvent {
  final bool showOnlyFavorites;
  ShowOnlyFavoritesChange(this.showOnlyFavorites);
}
class LoadSavedFilterValues extends ProfileFilteringSettingsEvent {}

class ProfileFilteringSettingsBloc extends Bloc<ProfileFilteringSettingsEvent, ProfileFilteringSettingsData> with ActionRunner {
  final ProfileRepository profile = ProfileRepository.getInstance();

  ProfileFilteringSettingsBloc() : super(ProfileFilteringSettingsData()) {
    on<ShowOnlyFavoritesChange>((data, emit) async {
      await runOnce(() async {
        await profile.changeProfileFilteringSettings(data.showOnlyFavorites);
        emit(state.copyWith(showOnlyFavorites: data.showOnlyFavorites));
      });
    });
    on<LoadSavedFilterValues>((data, emit) async {
      final showOnlyFavorites = await profile.getFilterFavoriteProfilesValue();
      emit(state.copyWith(showOnlyFavorites: showOnlyFavorites));
    });

    add(LoadSavedFilterValues());
  }
}
