
import "dart:async";

import "package:app/ui_utils/attribute/attribute.dart";
import "package:app/ui_utils/attribute/filter.dart";
import "package:app/ui_utils/attribute/state.dart";
import "package:app/utils/api.dart";
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
import "package:rxdart/rxdart.dart";

sealed class ProfileFilteringSettingsEvent {}
class SaveNewFilterSettings extends ProfileFilteringSettingsEvent {}
class ResetEditedValues extends ProfileFilteringSettingsEvent {}
class DisableAllFilterSettings extends ProfileFilteringSettingsEvent {}
class NewShowAdvancedFiltersValue extends ProfileFilteringSettingsEvent {
  final bool value;
  NewShowAdvancedFiltersValue(this.value);
}
class NewFilterFavoriteProfilesValue extends ProfileFilteringSettingsEvent {
  final bool filterFavorites;
  NewFilterFavoriteProfilesValue(this.filterFavorites);
}
class NewProfileFilteringSettings extends ProfileFilteringSettingsEvent {
  final GetProfileFilteringSettings? value;
  NewProfileFilteringSettings(this.value);
}
class SetFavoriteProfilesFilter extends ProfileFilteringSettingsEvent {
  final bool value;
  SetFavoriteProfilesFilter(this.value);
}
class SetShowAdvancedFilters extends ProfileFilteringSettingsEvent {
  final bool value;
  SetShowAdvancedFilters(this.value);
}
class SetLastSeenTimeFilter extends ProfileFilteringSettingsEvent {
  final int? value;
  SetLastSeenTimeFilter(this.value);
}
class SetUnlimitedLikesFilter extends ProfileFilteringSettingsEvent {
  final bool? value;
  SetUnlimitedLikesFilter(this.value);
}
class SetDistanceFilter extends ProfileFilteringSettingsEvent {
  final MinDistanceKm? min;
  final MaxDistanceKm? max;
  SetDistanceFilter(this.min, this.max);
}
class SetProfileCreatedFilter extends ProfileFilteringSettingsEvent {
  final ProfileCreatedTimeFilter? value;
  SetProfileCreatedFilter(this.value);
}
class SetProfileEditedFilter extends ProfileFilteringSettingsEvent {
  final ProfileEditedTimeFilter? value;
  SetProfileEditedFilter(this.value);
}
class SetProfileTextFilter extends ProfileFilteringSettingsEvent {
  final ProfileTextMinCharactersFilter? min;
  final ProfileTextMaxCharactersFilter? max;
  SetProfileTextFilter(this.min, this.max);
}
class SetRandomProfileOrderAndSaveSettings extends ProfileFilteringSettingsEvent {
  final bool value;
  SetRandomProfileOrderAndSaveSettings(this.value);
}
class SetAttributeFilterValueLists extends ProfileFilteringSettingsEvent {
  final UiAttribute attribute;
  final AttributeStateStorage wanted;
  final AttributeStateStorage unwanted;
  SetAttributeFilterValueLists(this.attribute, this.wanted, this.unwanted);
}
class SetAttributeFilterSettings extends ProfileFilteringSettingsEvent {
  final UiAttribute attribute;
  final FilterSettingsState value;
  SetAttributeFilterSettings(this.attribute, this.value);
}

class ProfileFilteringSettingsBloc extends Bloc<ProfileFilteringSettingsEvent, ProfileFilteringSettingsData> with ActionRunner {
  final ProfileRepository profile = LoginRepository.getInstance().repositories.profile;
  final AccountDatabaseManager db = LoginRepository.getInstance().repositories.accountDb;

  StreamSubscription<bool?>? _showAdvancedFiltersSubscription;
  StreamSubscription<bool?>? _filterFavoritesSubscription;
  StreamSubscription<GetProfileFilteringSettings?>? _profileFilteringSettingsSubscription;

  ProfileFilteringSettingsBloc() : super(ProfileFilteringSettingsData(edited: EditedFilteringSettingsData())) {
    on<SaveNewFilterSettings>((data, emit) async {
      await runOnce(() async {
        final s = state;
        emit(state.copyWith(
          updateState: const UpdateStarted(),
        ));

        final waitTime = WantedWaitingTimeManager();

        var failureDetected = false;

        emit(state.copyWith(
          updateState: const UpdateInProgress(),
        ));

        if (
          await profile.updateProfileFilteringSettings(
            s.valueAttributes(),
            s.valueLastSeenTimeFilter(),
            s.valueUnlimitedLikesFilter(),
            s.valueMinDistanceKmFilter(),
            s.valueMaxDistanceKmFilter(),
            s.valueProfileCreatedTime(),
            s.valueProfileEditedTime(),
            s.valueProfileTextMinCharacters(),
            s.valueProfileTextMaxCharacters(),
            s.valueRandomProfileOrder(),
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

        resetEditedValues(emit);
      });
    });
    on<ResetEditedValues>((data, emit) {
      resetEditedValues(emit);
    });
    on<DisableAllFilterSettings>((data, emit) {
      final Map<int, ProfileAttributeFilterValueUpdate> disableAttributeFilters = {};
      for (final a in state.attributeIdAndFilterValueMap.values) {
        disableAttributeFilters[a.id] = ProfileAttributeFilterValueUpdate(
          id: a.id,
          enabled: false,
        );
      }

      if (disableAttributeFilters.isEmpty) {
        emit(state.copyWith(
          edited: state.edited.copyWith(
            attributeIdAndFilterValueMap: null,
          )
        ));
      } else {
        emit(state.copyWith(
          edited: state.edited.copyWith(
            attributeIdAndFilterValueMap: disableAttributeFilters,
          )
        ));
      }

      add(SetLastSeenTimeFilter(null));
      add(SetUnlimitedLikesFilter(null));
      add(SetDistanceFilter(null, null));
      add(SetProfileCreatedFilter(null));
      add(SetProfileEditedFilter(null));
      add(SetProfileTextFilter(null, null));
    });
    on<NewShowAdvancedFiltersValue>((data, emit) {
      emit(state.copyWith(showAdvancedFilters: data.value));
    });
    on<NewFilterFavoriteProfilesValue>((data, emit) {
      emit(state.copyWith(showOnlyFavorites: data.filterFavorites));
    });
    on<NewProfileFilteringSettings>((data, emit) {
      emit(state.copyWith(
        filteringSettings: data.value,
        attributeIdAndFilterValueMap: data.value?.currentFiltersCopy() ?? {},
      ));
    });
    on<SetShowAdvancedFilters>((data, emit) async {
      await db.accountAction((db) => db.app.updateShowAdvancedFilters(data.value));
    });
    on<SetFavoriteProfilesFilter>((data, emit) async {
      await runOnce(() async {
        await profile.changeProfileFilteringSettings(data.value);
        final isHandled = BehaviorSubject.seeded(false);
        await profile.resetMainProfileIterator(eventHandlingTracking: isHandled);
        // Prevent showing all profiles when favorites should be shown. That
        // can happen when toggling favorites filter fast enough.
        await isHandled.firstWhere((v) => v == true);
      });
    });
    on<SetLastSeenTimeFilter>((data, emit) {
      final newValue = data.value;
      final newLastSeenTimeFilter = newValue == null ? null : LastSeenTimeFilter(value: newValue);
      modifyEdited(
        emit,
        (e) => state.filteringSettings?.lastSeenTimeFilter == newLastSeenTimeFilter ?
          e.copyWith(lastSeenTimeFilter: const NoEdit()) :
          e.copyWith(lastSeenTimeFilter: editValue(newLastSeenTimeFilter))
      );
    });
    on<SetUnlimitedLikesFilter>((data, emit) {
      modifyEdited(
        emit,
        (e) => state.filteringSettings?.unlimitedLikesFilter == data.value ?
          e.copyWith(unlimitedLikesFilter: const NoEdit()) :
          e.copyWith(unlimitedLikesFilter: editValue(data.value))
      );
    });
    on<SetDistanceFilter>((data, emit) {
      final min = state.filteringSettings?.minDistanceKmFilter == data.min ? const NoEdit<MinDistanceKm>() : editValue(data.min);
      final max = state.filteringSettings?.maxDistanceKmFilter == data.max ? const NoEdit<MaxDistanceKm>() : editValue(data.max);
      modifyEdited(
        emit,
        (e) => e.copyWith(minDistanceKmFilter: min, maxDistanceKmFilter: max),
      );
    });
    on<SetProfileCreatedFilter>((data, emit) {
      modifyEdited(
        emit,
        (e) => state.filteringSettings?.profileCreatedFilter == data.value ?
          e.copyWith(profileCreatedFilter: const NoEdit()) :
          e.copyWith(profileCreatedFilter: editValue(data.value))
      );
    });
    on<SetProfileEditedFilter>((data, emit) {
      modifyEdited(
        emit,
        (e) => state.filteringSettings?.profileEditedFilter == data.value ?
          e.copyWith(profileEditedFilter: const NoEdit()) :
          e.copyWith(profileEditedFilter: editValue(data.value))
      );
    });
    on<SetProfileTextFilter>((data, emit) {
      final min = state.filteringSettings?.profileTextMinCharactersFilter == data.min ? const NoEdit<ProfileTextMinCharactersFilter>() : editValue(data.min);
      final max = state.filteringSettings?.profileTextMaxCharactersFilter == data.max ? const NoEdit<ProfileTextMaxCharactersFilter>() : editValue(data.max);
      modifyEdited(
        emit,
        (e) => e.copyWith(profileTextMinCharactersFilter: min, profileTextMaxCharactersFilter: max),
      );
    });
    on<SetRandomProfileOrderAndSaveSettings>((data, emit) {
      modifyEdited(
        emit,
        (e) => state.filteringSettings?.randomProfileOrder == data.value ?
          e.copyWith(randomProfileOrder: null) :
          e.copyWith(randomProfileOrder: data.value)
      );
      add(SaveNewFilterSettings());
    });
    on<SetAttributeFilterValueLists>((data, emit) {
      updateFilters(
        emit,
        data.attribute.apiAttribute().id,
        (current) => AttributeFilterUpdateBuilder.copyWithValues(data.attribute, current, data.wanted, data.unwanted),
      );
    });
    on<SetAttributeFilterSettings>((data, emit) {
      updateFilters(
        emit,
        data.attribute.apiAttribute().id,
        (current) => AttributeFilterUpdateBuilder.copyWithSettings(data.attribute, current, data.value),
      );
    });

    _showAdvancedFiltersSubscription = db.accountStream((db) => db.app.watchShowAdvancedFilters()).listen((event) {
      add(NewShowAdvancedFiltersValue(event ?? false));
    });
    _filterFavoritesSubscription = db.accountStream((db) => db.app.watchProfileFilterFavorites()).listen((event) {
      add(NewFilterFavoriteProfilesValue(event ?? false));
    });
    _profileFilteringSettingsSubscription = db.accountStream((db) => db.search.watchProfileFilteringSettings()).listen((event) {
      add(NewProfileFilteringSettings(event));
    });
  }

  void resetEditedValues(Emitter<ProfileFilteringSettingsData> emit) {
    emit(state.copyWith(
      edited: EditedFilteringSettingsData(),
    ));
  }

  void modifyEdited(Emitter<ProfileFilteringSettingsData> emit, EditedFilteringSettingsData Function(EditedFilteringSettingsData) modify) {
    emit(state.copyWith(
      edited: modify(state.edited),
    ));
  }

  void updateFilters(
    Emitter<ProfileFilteringSettingsData> emit,
    int attributeId,
    ProfileAttributeFilterValueUpdate Function(ProfileAttributeFilterValueUpdate) modifyCurrentValue,
  ) {
    final newAttributes = <int, ProfileAttributeFilterValueUpdate>{};
    var found = false;
    for (final a in state.valueAttributes().values) {
      if (a.id == attributeId) {
        newAttributes[attributeId] = modifyCurrentValue(a);
        found = true;
      } else {
        newAttributes[a.id] = a;
      }
    }
    if (!found) {
      newAttributes[attributeId] = modifyCurrentValue(ProfileAttributeFilterValueUpdate(id: attributeId));
    }

    bool different = false;
    for (final a in newAttributes.values) {
      final current = state.attributeIdAndFilterValueMap[a.id] ?? ProfileAttributeFilterValueUpdate(id: a.id);
      if (attributeValuesDiffer(a, current)) {
        different = true;
        break;
      }
    }

    if (different) {
      emit(state.copyWith(
        edited: state.edited.copyWith(
          attributeIdAndFilterValueMap: newAttributes
        ),
      ));
    } else {
      emit(state.copyWith(
        edited: state.edited.copyWith(
          attributeIdAndFilterValueMap: null,
        ),
      ));
    }
  }

  @override
  Future<void> close() async {
    await _showAdvancedFiltersSubscription?.cancel();
    await _filterFavoritesSubscription?.cancel();
    await _profileFilteringSettingsSubscription?.cancel();
    await super.close();
  }
}

bool attributeValuesDiffer(
  ProfileAttributeFilterValueUpdate a,
  ProfileAttributeFilterValueUpdate current,
) {
  if (
    a.enabled != current.enabled ||
    a.acceptMissingAttribute != current.acceptMissingAttribute ||
    a.useLogicalOperatorAnd != current.useLogicalOperatorAnd ||
    a.wanted.length != current.wanted.length ||
    a.unwanted.length != current.unwanted.length
  ) {
    return true;
  }
  for (final v in a.wanted) {
    if (!current.wanted.contains(v)) {
      return true;
    }
  }
  for (final v in a.unwanted) {
    if (!current.unwanted.contains(v)) {
      return true;
    }
  }
  return false;
}
