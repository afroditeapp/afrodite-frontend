import "dart:async";

import "package:app/api/api_manager.dart";
import "package:app/database/account_background_database_manager.dart";
import "package:app/model/freezed/logic/account/initial_setup.dart";
import "package:app/utils/age.dart";
import "package:app/utils/api.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";
import "package:app/data/login_repository.dart";
import "package:app/data/profile_repository.dart";
import "package:app/database/account_database_manager.dart";
import "package:app/localizations.dart";
import "package:app/model/freezed/logic/settings/search_settings.dart";
import "package:app/ui_utils/common_update_logic.dart";
import "package:app/ui_utils/snack_bar.dart";
import "package:app/utils.dart";
import "package:app/utils/result.dart";
import "package:app/utils/time.dart";

sealed class SearchSettingsEvent {}
class NewMinAge extends SearchSettingsEvent {
  final int value;
  NewMinAge(this.value);
}
class NewMaxAge extends SearchSettingsEvent {
  final int value;
  NewMaxAge(this.value);
}
class NewSearchGroups extends SearchSettingsEvent {
  final SearchGroups value;
  NewSearchGroups(this.value);
}
class NewProfileAppNotificationSettings extends SearchSettingsEvent {
  final ProfileAppNotificationSettings value;
  NewProfileAppNotificationSettings(this.value);
}
class UpdateMinAge extends SearchSettingsEvent {
  final int value;
  UpdateMinAge(this.value);
}
class UpdateMaxAge extends SearchSettingsEvent {
  final int value;
  UpdateMaxAge(this.value);
}
class UpdateGender extends SearchSettingsEvent {
  final Gender value;
  UpdateGender(this.value);
}
class UpdateGenderSearchSettingsAll extends SearchSettingsEvent {
  final GenderSearchSettingsAll settings;
  UpdateGenderSearchSettingsAll(this.settings);
}
class ToggleSearchDistanceFilters extends SearchSettingsEvent {}
class ToggleSearchAttributeFilters extends SearchSettingsEvent {}
class ToggleSearchNewProfiles extends SearchSettingsEvent {}
class UpdateSearchWeekday extends SearchSettingsEvent {
  final int value;
  UpdateSearchWeekday(this.value);
}
class ResetEditedValues extends SearchSettingsEvent {}
class SaveSearchSettings extends SearchSettingsEvent {
  final SearchGroups searchGroups;
  SaveSearchSettings(this.searchGroups);
}

class SearchSettingsBloc extends Bloc<SearchSettingsEvent, SearchSettingsData> with ActionRunner {
  final ProfileRepository profile = LoginRepository.getInstance().repositories.profile;
  final AccountDatabaseManager db = LoginRepository.getInstance().repositories.accountDb;
  final AccountBackgroundDatabaseManager accountBackgroundDb = LoginRepository.getInstance().repositories.accountBackgroundDb;
  final ApiManager api = LoginRepository.getInstance().repositories.api;

  StreamSubscription<int?>? _minAgeSubscription;
  StreamSubscription<int?>? _maxAgeSubscription;
  StreamSubscription<SearchGroups?>? _searchGroupsSubscription;
  StreamSubscription<ProfileAppNotificationSettings?>? _profileSettingsSubscription;

  SearchSettingsBloc() : super(SearchSettingsData(
    profileSettings: ProfileAppNotificationSettingsDefaults.defaultValue,
  )) {
    on<SaveSearchSettings>((data, emit) async {
      await runOnce(() async {
        final currentState = state;

        emit(state.copyWith(
          updateState: const UpdateStarted(),
        ));

        final waitTime = WantedWaitingTimeManager();

        var failureDetected = false;

        emit(state.copyWith(
          updateState: const UpdateInProgress(),
        ));

        if (!await profile.updateSearchAgeRange(currentState.valueMinAge(), currentState.valueMaxAge()).isOk()) {
          failureDetected = true;
        }

        if (!await profile.updateSearchGroups(data.searchGroups).isOk()) {
          failureDetected = true;
        }

        {
          final settings = ProfileAppNotificationSettings(
            profileTextModeration: state.profileSettings.profileTextModeration,
            automaticProfileSearch: state.profileSettings.automaticProfileSearch,
            automaticProfileSearchDistanceFilters: state.valueSearchDistanceFilters(),
            automaticProfileSearchNewProfiles: state.valueSearchNewProfiles(),
            automaticProfileSearchAttributeFilters: state.valueSearchAttributeFilters(),
            automaticProfileSearchWeekdays: state.valueSearchWeekdays(),
          );
          final r = await api.profileAction((api) => api.postProfileAppNotificationSettings(settings))
            .andThen((_) => accountBackgroundDb.accountAction((db) => db.appNotificationSettings.updateProfileNotificationSettings(settings)));
          if (r.isErr()) {
            failureDetected = true;
          }
        }

        await profile.resetMainProfileIterator();

        await waitTime.waitIfNeeded();

        if (failureDetected) {
          showSnackBar(R.strings.search_settings_screen_search_settings_update_failed);
        }

        emit(state.copyWith(
          updateState: const UpdateIdle(),
        ));

        _resetEditedValues(emit);
      });
    });
    on<ResetEditedValues>((data, emit) async {
      _resetEditedValues(emit);
    });
    on<NewMinAge>((data, emit) async {
      emit(state.copyWith(minAge: data.value));
    });
    on<NewMaxAge>((data, emit) async {
      emit(state.copyWith(maxAge: data.value));
    });
    on<NewSearchGroups>((data, emit) async {
      emit(state.copyWith(
        gender: data.value.toGender(),
        genderSearchSettingsAll: data.value.toGenderSearchSettingsAll() ?? const GenderSearchSettingsAll(),
      ));
    });
    on<NewProfileAppNotificationSettings>((data, emit) async {
      emit(state.copyWith(
        profileSettings: data.value,
      ));
    });
    on<UpdateMinAge>((data, emit) async {
      if (data.value == state.minAge) {
        emit(state.copyWith(editedMinAge: null));
      } else {
        emit(state.copyWith(editedMinAge: data.value));
      }
    });
    on<UpdateMaxAge>((data, emit) async {
      if (data.value == state.maxAge) {
        emit(state.copyWith(editedMaxAge: null));
      } else {
        emit(state.copyWith(editedMaxAge: data.value));
      }
    });
    on<UpdateGender>((data, emit) async {
      if (data.value == state.gender) {
        emit(state.copyWith(editedGender: null));
      } else {
        emit(state.copyWith(editedGender: data.value));
      }
    });
    on<UpdateGenderSearchSettingsAll>((data, emit) async {
      if (data.settings == state.genderSearchSettingsAll) {
        emit(state.copyWith(editedGenderSearchSettingsAll: null));
      } else {
        emit(state.copyWith(editedGenderSearchSettingsAll: data.settings));
      }
    });
    on<ToggleSearchDistanceFilters>((data, emit) async {
      if (state.editedSearchDistanceFilters == null) {
        emit(state.copyWith(editedSearchDistanceFilters: !state.profileSettings.automaticProfileSearchDistanceFilters));
      } else {
        emit(state.copyWith(editedSearchDistanceFilters: null));
      }
    });
    on<ToggleSearchAttributeFilters>((data, emit) async {
      if (state.editedSearchAttributeFilters == null) {
        emit(state.copyWith(editedSearchAttributeFilters: !state.profileSettings.automaticProfileSearchAttributeFilters));
      } else {
        emit(state.copyWith(editedSearchAttributeFilters: null));
      }
    });
    on<ToggleSearchNewProfiles>((data, emit) async {
      if (state.editedSearchNewProfiles == null) {
        emit(state.copyWith(editedSearchNewProfiles: !state.profileSettings.automaticProfileSearchNewProfiles));
      } else {
        emit(state.copyWith(editedSearchNewProfiles: null));
      }
    });
    on<UpdateSearchWeekday>((data, emit) async {
      if (data.value == state.profileSettings.automaticProfileSearchWeekdays) {
        emit(state.copyWith(
          editedSearchWeekdays: null,
        ));
      } else {
        emit(state.copyWith(
          editedSearchWeekdays: data.value,
        ));
      }
    });

    _minAgeSubscription = db.accountStream((db) => db.search.watchProfileSearchAgeRangeMin()).listen((event) {
      add(NewMinAge(event ?? MIN_AGE));
    });
    _maxAgeSubscription = db.accountStream((db) => db.search.watchProfileSearchAgeRangeMax()).listen((event) {
      add(NewMaxAge(event ?? MAX_AGE));
    });
    _searchGroupsSubscription = db.accountStream((db) => db.search.watchSearchGroups()).listen((event) {
      add(NewSearchGroups(event ?? SearchGroups()));
    });
    _profileSettingsSubscription = accountBackgroundDb
      .accountStream((db) => db.appNotificationSettings.watchProfileAppNotificationSettings())
      .listen((state) {
        add(NewProfileAppNotificationSettings(state ?? ProfileAppNotificationSettingsDefaults.defaultValue));
      });
  }

  void _resetEditedValues(Emitter<SearchSettingsData> emit) {
    emit(state.copyWith(
      editedMinAge: null,
      editedMaxAge: null,
      editedGenderSearchSettingsAll: null,
      editedGender: null,
      editedSearchDistanceFilters: null,
      editedSearchAttributeFilters: null,
      editedSearchNewProfiles: null,
      editedSearchWeekdays: null,
    ));
  }

  @override
  Future<void> close() async {
    await _minAgeSubscription?.cancel();
    await _maxAgeSubscription?.cancel();
    await _searchGroupsSubscription?.cancel();
    await _profileSettingsSubscription?.cancel();
    await super.close();
  }
}
