
import "dart:async";

import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";
import "package:app/data/login_repository.dart";
import "package:app/data/profile_repository.dart";
import "package:app/database/account_database_manager.dart";
import "package:app/localizations.dart";
import "package:app/model/freezed/logic/profile/profile_filtering_settings.dart";
import "package:app/ui_utils/common_update_logic.dart";
import "package:app/ui_utils/snack_bar.dart";
import "package:app/utils.dart";
import "package:app/utils/result.dart";
import "package:app/utils/time.dart";

sealed class ProfileFilteringSettingsEvent {}
class SaveNewFilterSettings extends ProfileFilteringSettingsEvent {
  final bool showOnlyFavorites;
  final List<ProfileAttributeFilterValueUpdate> attributeFilters;
  final LastSeenTimeFilter? lastSeenTimeFilter;
  final bool? unlimitedLikesFilter;
  final MaxDistanceKm? maxDistanceFilter;
  final AccountCreatedTimeFilter? accountCreatedFilter;
  final ProfileEditedTimeFilter? profileEditedFilter;
  final bool randomProfileOrder;
  SaveNewFilterSettings(
    this.showOnlyFavorites,
    this.attributeFilters,
    this.lastSeenTimeFilter,
    this.unlimitedLikesFilter,
    this.maxDistanceFilter,
    this.accountCreatedFilter,
    this.profileEditedFilter,
    this.randomProfileOrder,
  );
}

class NewFilterFavoriteProfilesValue extends ProfileFilteringSettingsEvent {
  final bool filterFavorites;
  NewFilterFavoriteProfilesValue(this.filterFavorites);
}

class NewProfileFilteringSettings extends ProfileFilteringSettingsEvent {
  final GetProfileFilteringSettings? value;
  NewProfileFilteringSettings(this.value);
}

class ProfileFilteringSettingsBloc extends Bloc<ProfileFilteringSettingsEvent, ProfileFilteringSettingsData> with ActionRunner {
  final ProfileRepository profile = LoginRepository.getInstance().repositories.profile;
  final AccountDatabaseManager db = LoginRepository.getInstance().repositories.accountDb;

  StreamSubscription<bool?>? _filterFavoritesSubscription;
  StreamSubscription<GetProfileFilteringSettings?>? _profileFilteringSettingsSubscription;

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
          await profile.updateProfileFilteringSettings(
            data.attributeFilters,
            data.lastSeenTimeFilter,
            data.unlimitedLikesFilter,
            data.maxDistanceFilter,
            data.accountCreatedFilter,
            data.profileEditedFilter,
            data.randomProfileOrder,
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
    on<NewProfileFilteringSettings>((data, emit) async {
      emit(state.copyWith(filteringSettings: data.value));
    });

    _filterFavoritesSubscription = db.accountStream((db) => db.watchProfileFilterFavorites()).listen((event) {
      add(NewFilterFavoriteProfilesValue(event ?? false));
    });
    _profileFilteringSettingsSubscription = db.accountStream((db) => db.daoProfileSettings.watchProfileFilteringSettings()).listen((event) {
      add(NewProfileFilteringSettings(event));
    });
  }

  @override
  Future<void> close() async {
    await _filterFavoritesSubscription?.cancel();
    await _profileFilteringSettingsSubscription?.cancel();
    await super.close();
  }
}
