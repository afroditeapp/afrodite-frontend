
import "package:flutter_bloc/flutter_bloc.dart";
import "package:pihka_frontend/data/profile_repository.dart";
import "package:pihka_frontend/storage/kv.dart";
import "package:pihka_frontend/ui/utils.dart";
import "package:pihka_frontend/utils.dart";


import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';

part 'profile_filtering_settings.freezed.dart';

@freezed
class ProfileFilteringSettingsData with _$ProfileFilteringSettingsData {
  factory ProfileFilteringSettingsData({
    @Default(false) bool showOnlyFavorites,
  }) = _ProfileFilteringSettingsData;
}

sealed class ProfileFilteringSettingsEvent {}
class ShowOnlyFavoritesChange extends ProfileFilteringSettingsEvent {
  final bool showOnlyFavorites;
  ShowOnlyFavoritesChange(this.showOnlyFavorites);
}
class LoadSavedFilterValues extends ProfileFilteringSettingsEvent {}

class ProfileFilteringSettingsBloc extends Bloc<ProfileFilteringSettingsEvent, ProfileFilteringSettingsData> with ActionRunner {
  final ProfileRepository profile;

  ProfileFilteringSettingsBloc(this.profile) : super(ProfileFilteringSettingsData()) {
    on<ShowOnlyFavoritesChange>((data, emit) async {
      await runOnce(() async {
        await profile.changeProfileFilteringSettings(data.showOnlyFavorites);
        emit(state.copyWith(showOnlyFavorites: data.showOnlyFavorites));
      });
    });
    on<LoadSavedFilterValues>((data, emit) async {
      final showOnlyFavorites = await KvBooleanManager.getInstance().getValue(KvBoolean.profileFilterFavorites) ?? false;
      emit(state.copyWith(showOnlyFavorites: showOnlyFavorites));
    });

    add(LoadSavedFilterValues());
  }
}
