
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

sealed class ProfileFilteringSettingsEvent {}
class SaveNewFilterSettings extends ProfileFilteringSettingsEvent {}
class ResetEditedValues extends ProfileFilteringSettingsEvent {}
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
class SetLastSeenTimeFilter extends ProfileFilteringSettingsEvent {
  final int? value;
  SetLastSeenTimeFilter(this.value);
}
class SetUnlimitedLikesFilter extends ProfileFilteringSettingsEvent {
  final bool? value;
  SetUnlimitedLikesFilter(this.value);
}
class SetMaxDistanceFilter extends ProfileFilteringSettingsEvent {
  final MaxDistanceKm? value;
  SetMaxDistanceFilter(this.value);
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
class SetRandomProfileOrder extends ProfileFilteringSettingsEvent {
  final bool value;
  SetRandomProfileOrder(this.value);
}
class SetAttributeFilterValueLists extends ProfileFilteringSettingsEvent {
  final UiAttribute attribute;
  final AttributeStateStorage selected;
  SetAttributeFilterValueLists(this.attribute, this.selected);
}
class SetAttributeFilterSettings extends ProfileFilteringSettingsEvent {
  final UiAttribute attribute;
  final FilterSettingsState value;
  SetAttributeFilterSettings(this.attribute, this.value);
}

class ProfileFilteringSettingsBloc extends Bloc<ProfileFilteringSettingsEvent, ProfileFilteringSettingsData> with ActionRunner {
  final ProfileRepository profile = LoginRepository.getInstance().repositories.profile;
  final AccountDatabaseManager db = LoginRepository.getInstance().repositories.accountDb;

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

        await profile.changeProfileFilteringSettings(s.valueShowOnlyFavorites());

        if (
          await profile.updateProfileFilteringSettings(
            s.valueAttributes(),
            s.valueLastSeenTimeFilter(),
            s.valueUnlimitedLikesFilter(),
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
    on<ResetEditedValues>((data, emit) async {
      resetEditedValues(emit);
    });
    on<NewFilterFavoriteProfilesValue>((data, emit) async {
      emit(state.copyWith(showOnlyFavorites: data.filterFavorites));
    });
    on<NewProfileFilteringSettings>((data, emit) async {
      emit(state.copyWith(
        filteringSettings: data.value,
        attributeIdAndFilterValueMap: data.value?.currentFiltersCopy() ?? {},
      ));
    });
    on<SetFavoriteProfilesFilter>((data, emit) async {
      modifyEdited(
        emit,
        (e) => state.showOnlyFavorites == data.value ?
          e.copyWith(showOnlyFavorites: null) :
          e.copyWith(showOnlyFavorites: data.value)
      );
    });
    on<SetLastSeenTimeFilter>((data, emit) async {
      final newValue = data.value;
      final newLastSeenTimeFilter = newValue == null ? null : LastSeenTimeFilter(value: newValue);
      modifyEdited(
        emit,
        (e) => state.filteringSettings?.lastSeenTimeFilter == newLastSeenTimeFilter ?
          e.copyWith(lastSeenTimeFilter: const NoEdit()) :
          e.copyWith(lastSeenTimeFilter: editValue(newLastSeenTimeFilter))
      );
    });
    on<SetUnlimitedLikesFilter>((data, emit) async {
      modifyEdited(
        emit,
        (e) => state.filteringSettings?.unlimitedLikesFilter == data.value ?
          e.copyWith(unlimitedLikesFilter: const NoEdit()) :
          e.copyWith(unlimitedLikesFilter: editValue(data.value))
      );
    });
    on<SetMaxDistanceFilter>((data, emit) async {
      modifyEdited(
        emit,
        (e) => state.filteringSettings?.maxDistanceKmFilter == data.value ?
          e.copyWith(maxDistanceKmFilter: const NoEdit()) :
          e.copyWith(maxDistanceKmFilter: editValue(data.value))
      );
    });
    on<SetProfileCreatedFilter>((data, emit) async {
      modifyEdited(
        emit,
        (e) => state.filteringSettings?.profileCreatedFilter == data.value ?
          e.copyWith(profileCreatedFilter: const NoEdit()) :
          e.copyWith(profileCreatedFilter: editValue(data.value))
      );
    });
    on<SetProfileEditedFilter>((data, emit) async {
      modifyEdited(
        emit,
        (e) => state.filteringSettings?.profileEditedFilter == data.value ?
          e.copyWith(profileEditedFilter: const NoEdit()) :
          e.copyWith(profileEditedFilter: editValue(data.value))
      );
    });
    on<SetProfileTextFilter>((data, emit) async {
      final min = state.filteringSettings?.profileTextMinCharactersFilter == data.min ? const NoEdit<ProfileTextMinCharactersFilter>() : editValue(data.min);
      final max = state.filteringSettings?.profileTextMaxCharactersFilter == data.max ? const NoEdit<ProfileTextMaxCharactersFilter>() : editValue(data.max);
      modifyEdited(
        emit,
        (e) => e.copyWith(profileTextMinCharactersFilter: min, profileTextMaxCharactersFilter: max),
      );
    });
    on<SetRandomProfileOrder>((data, emit) async {
      modifyEdited(
        emit,
        (e) => state.filteringSettings?.randomProfileOrder == data.value ?
          e.copyWith(randomProfileOrder: null) :
          e.copyWith(randomProfileOrder: data.value)
      );
    });
    on<SetAttributeFilterValueLists>((data, emit) async {
      updateFilters(
        emit,
        data.attribute.apiAttribute().id,
        (current) => AttributeFilterUpdateBuilder.copyWithValues(data.attribute, current, data.selected),
      );
    });
    on<SetAttributeFilterSettings>((data, emit) async {
      updateFilters(
        emit,
        data.attribute.apiAttribute().id,
        (current) => AttributeFilterUpdateBuilder.copyWithSettings(data.attribute, current, data.value),
      );
    });

    _filterFavoritesSubscription = db.accountStream((db) => db.watchProfileFilterFavorites()).listen((event) {
      add(NewFilterFavoriteProfilesValue(event ?? false));
    });
    _profileFilteringSettingsSubscription = db.accountStream((db) => db.daoProfileSettings.watchProfileFilteringSettings()).listen((event) {
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
    a.filterValues.length != current.filterValues.length ||
    a.filterValuesNonselected.length != current.filterValuesNonselected.length
  ) {
    return true;
  }
  for (final v in a.filterValues) {
    if (!current.filterValues.contains(v)) {
      return true;
    }
  }
  for (final v in a.filterValuesNonselected) {
    if (!current.filterValuesNonselected.contains(v)) {
      return true;
    }
  }
  return false;
}
