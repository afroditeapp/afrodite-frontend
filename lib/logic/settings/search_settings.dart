import "dart:async";

import "package:app/api/server_connection_manager.dart";
import "package:app/data/utils/repository_instances.dart";
import "package:app/database/account_background_database_manager.dart";
import "package:app/model/freezed/logic/account/initial_setup.dart";
import "package:app/utils/api.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";
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

class NewSearchGroups extends SearchSettingsEvent {
  final SearchGroups value;
  NewSearchGroups(this.value);
}

class NewAutomaticProfileSearchSettings extends SearchSettingsEvent {
  final AutomaticProfileSearchSettings value;
  NewAutomaticProfileSearchSettings(this.value);
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
  final ProfileRepository profile;
  final AccountDatabaseManager db;
  final AccountBackgroundDatabaseManager accountBackgroundDb;
  final ApiManager api;

  StreamSubscription<SearchGroups?>? _searchGroupsSubscription;
  StreamSubscription<AutomaticProfileSearchSettings?>? _automaticProfileSearchSettingsSubscription;

  SearchSettingsBloc(RepositoryInstances r)
    : profile = r.profile,
      db = r.accountDb,
      accountBackgroundDb = r.accountBackgroundDb,
      api = r.api,
      super(
        SearchSettingsData(
          automaticProfileSearchSettings: AutomaticProfileSearchSettingsDefaults.defaultValue,
        ),
      ) {
    on<SaveSearchSettings>((data, emit) async {
      await runOnce(() async {
        final currentState = state;

        emit(state.copyWith(updateState: const UpdateStarted()));

        final waitTime = WantedWaitingTimeManager();

        var failureDetected = false;

        emit(state.copyWith(updateState: const UpdateInProgress()));

        if (!await profile.updateSearchGroups(data.searchGroups).isOk()) {
          failureDetected = true;
        }

        {
          final settings = AutomaticProfileSearchSettings(
            weekdays: currentState.valueSearchWeekdays(),
            attributeFilters: currentState.valueSearchAttributeFilters(),
            distanceFilters: currentState.valueSearchDistanceFilters(),
            newProfiles: currentState.valueSearchNewProfiles(),
          );
          if (!await profile.updateAutomaticProfileSearchSettings(settings).isOk()) {
            failureDetected = true;
          }
        }

        await profile.resetMainProfileIterator();

        await waitTime.waitIfNeeded();

        if (failureDetected) {
          showSnackBar(R.strings.search_settings_screen_search_settings_update_failed);
        }

        emit(state.copyWith(updateState: const UpdateIdle()));

        _resetEditedValues(emit);
      });
    });
    on<ResetEditedValues>((data, emit) async {
      _resetEditedValues(emit);
    });
    on<NewSearchGroups>((data, emit) async {
      emit(
        state.copyWith(
          gender: data.value.toGender(),
          genderSearchSettingsAll:
              data.value.toGenderSearchSettingsAll() ?? const GenderSearchSettingsAll(),
        ),
      );
    });
    on<NewAutomaticProfileSearchSettings>((data, emit) async {
      emit(state.copyWith(automaticProfileSearchSettings: data.value));
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
        emit(
          state.copyWith(
            editedSearchDistanceFilters: !state.automaticProfileSearchSettings.distanceFilters,
          ),
        );
      } else {
        emit(state.copyWith(editedSearchDistanceFilters: null));
      }
    });
    on<ToggleSearchAttributeFilters>((data, emit) async {
      if (state.editedSearchAttributeFilters == null) {
        emit(
          state.copyWith(
            editedSearchAttributeFilters: !state.automaticProfileSearchSettings.attributeFilters,
          ),
        );
      } else {
        emit(state.copyWith(editedSearchAttributeFilters: null));
      }
    });
    on<ToggleSearchNewProfiles>((data, emit) async {
      if (state.editedSearchNewProfiles == null) {
        emit(
          state.copyWith(
            editedSearchNewProfiles: !state.automaticProfileSearchSettings.newProfiles,
          ),
        );
      } else {
        emit(state.copyWith(editedSearchNewProfiles: null));
      }
    });
    on<UpdateSearchWeekday>((data, emit) async {
      if (data.value == state.automaticProfileSearchSettings.weekdays) {
        emit(state.copyWith(editedSearchWeekdays: null));
      } else {
        emit(state.copyWith(editedSearchWeekdays: data.value));
      }
    });

    _searchGroupsSubscription = db.accountStream((db) => db.search.watchSearchGroups()).listen((
      event,
    ) {
      add(NewSearchGroups(event ?? SearchGroups()));
    });
    _automaticProfileSearchSettingsSubscription = db
        .accountStream((db) => db.search.watchAutomaticProfileSearchSettings())
        .listen((state) {
          add(
            NewAutomaticProfileSearchSettings(
              state ?? AutomaticProfileSearchSettingsDefaults.defaultValue,
            ),
          );
        });
  }

  void _resetEditedValues(Emitter<SearchSettingsData> emit) {
    emit(
      state.copyWith(
        editedGenderSearchSettingsAll: null,
        editedGender: null,
        editedSearchDistanceFilters: null,
        editedSearchAttributeFilters: null,
        editedSearchNewProfiles: null,
        editedSearchWeekdays: null,
      ),
    );
  }

  @override
  Future<void> close() async {
    await _searchGroupsSubscription?.cancel();
    await _automaticProfileSearchSettingsSubscription?.cancel();
    await super.close();
  }
}
