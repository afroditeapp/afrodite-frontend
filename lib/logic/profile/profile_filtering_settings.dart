
import "dart:async";

import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";
import "package:pihka_frontend/data/login_repository.dart";
import "package:pihka_frontend/data/profile_repository.dart";
import "package:pihka_frontend/database/database_manager.dart";
import "package:pihka_frontend/localizations.dart";
import "package:pihka_frontend/model/freezed/logic/profile/profile_filtering_settings.dart";
import "package:pihka_frontend/ui_utils/common_update_logic.dart";
import "package:pihka_frontend/ui_utils/snack_bar.dart";
import "package:pihka_frontend/utils.dart";
import "package:pihka_frontend/utils/result.dart";
import "package:pihka_frontend/utils/time.dart";

sealed class ProfileFilteringSettingsEvent {}
class SaveNewFilterSettings extends ProfileFilteringSettingsEvent {
  final bool showOnlyFavorites;
  final List<ProfileAttributeFilterValueUpdate> attributeFilters;
  final LastSeenTimeFilter? lastSeenTimeFilter;
  final bool? unlimitedLikesFilter;
  SaveNewFilterSettings(
    this.showOnlyFavorites,
    this.attributeFilters,
    this.lastSeenTimeFilter,
    this.unlimitedLikesFilter,
  );
}

class NewFilterFavoriteProfilesValue extends ProfileFilteringSettingsEvent {
  final bool filterFavorites;
  NewFilterFavoriteProfilesValue(this.filterFavorites);
}

class NewProfileAttributeFilters extends ProfileFilteringSettingsEvent {
  final ProfileAttributeFilterList? value;
  NewProfileAttributeFilters(this.value);
}

class ProfileFilteringSettingsBloc extends Bloc<ProfileFilteringSettingsEvent, ProfileFilteringSettingsData> with ActionRunner {
  final ProfileRepository profile = LoginRepository.getInstance().repositories.profile;
  final db = DatabaseManager.getInstance();

  StreamSubscription<bool?>? _filterFavoritesSubscription;
  StreamSubscription<ProfileAttributeFilterList?>? _attributeFiltersSubscription;

  ProfileFilteringSettingsBloc() : super(ProfileFilteringSettingsData()) {
    on<SaveNewFilterSettings>((data, emit) async {
      await runOnce(() async {
        emit(state.copyWith(
          updateState: const UpdateStarted(),
        ));

        final waitTime = WantedWaitingTimeManager();

        var failureDetected = false;

        emit(state.copyWith(
          updateState: const UpdateInProgress(),
        ));

        await profile.changeProfileFilteringSettings(data.showOnlyFavorites);

        if (
          await profile.updateAttributeFilters(
            data.attributeFilters,
            data.lastSeenTimeFilter,
            data.unlimitedLikesFilter,
          ).isErr()
        ) {
          failureDetected = true;
        }

        await profile.resetMainProfileIterator();

        if (failureDetected) {
          showSnackBar(R.strings.profile_filtering_settings_screen_updating_filters_failed);
        }

        await waitTime.waitIfNeeded();

        emit(state.copyWith(
          updateState: const UpdateIdle(),
        ));
      });
    });
    on<NewFilterFavoriteProfilesValue>((data, emit) async {
      emit(state.copyWith(showOnlyFavorites: data.filterFavorites));
    });
    on<NewProfileAttributeFilters>((data, emit) async {
      emit(state.copyWith(attributeFilters: data.value));
    });

    _filterFavoritesSubscription = db.accountStream((db) => db.watchProfileFilterFavorites()).listen((event) {
      add(NewFilterFavoriteProfilesValue(event ?? false));
    });
    _attributeFiltersSubscription = db.accountStream((db) => db.daoProfileSettings.watchProfileAttributeFilters()).listen((event) {
      add(NewProfileAttributeFilters(event));
    });
  }

  @override
  Future<void> close() async {
    await _filterFavoritesSubscription?.cancel();
    await _attributeFiltersSubscription?.cancel();
    await super.close();
  }
}
