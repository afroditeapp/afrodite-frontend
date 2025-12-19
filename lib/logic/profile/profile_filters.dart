import "dart:async";

import "package:app/data/utils/repository_instances.dart";
import "package:app/ui_utils/attribute/attribute.dart";
import "package:app/ui_utils/attribute/filter.dart";
import "package:app/ui_utils/attribute/state.dart";
import "package:app/utils/age.dart";
import "package:app/utils/api.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";
import "package:app/data/profile_repository.dart";
import "package:app/database/account_database_manager.dart";
import "package:app/localizations.dart";
import "package:app/model/freezed/logic/profile/profile_filters.dart";
import "package:app/ui_utils/common_update_logic.dart";
import "package:app/ui_utils/snack_bar.dart";
import "package:app/utils.dart";
import "package:app/utils/result.dart";
import "package:app/utils/time.dart";
import "package:rxdart/rxdart.dart";

sealed class ProfileFiltersEvent {}

class SaveNewFilterSettings extends ProfileFiltersEvent {}

class ResetEditedValues extends ProfileFiltersEvent {}

class DisableAllFilterSettings extends ProfileFiltersEvent {}

class NewShowAdvancedFiltersValue extends ProfileFiltersEvent {
  final bool value;
  NewShowAdvancedFiltersValue(this.value);
}

class NewFilterFavoriteProfilesValue extends ProfileFiltersEvent {
  final bool filterFavorites;
  NewFilterFavoriteProfilesValue(this.filterFavorites);
}

class NewProfileFilters extends ProfileFiltersEvent {
  final GetProfileFilters? value;
  NewProfileFilters(this.value);
}

class NewMinAge extends ProfileFiltersEvent {
  final int value;
  NewMinAge(this.value);
}

class NewMaxAge extends ProfileFiltersEvent {
  final int value;
  NewMaxAge(this.value);
}

class SetFavoriteProfilesFilter extends ProfileFiltersEvent {
  final bool value;
  final bool waitEventHandling;
  SetFavoriteProfilesFilter(this.value, this.waitEventHandling);
}

class SetShowAdvancedFilters extends ProfileFiltersEvent {
  final bool value;
  SetShowAdvancedFilters(this.value);
}

class SetLastSeenTimeFilter extends ProfileFiltersEvent {
  final int? value;
  SetLastSeenTimeFilter(this.value);
}

class SetUnlimitedLikesFilter extends ProfileFiltersEvent {
  final bool? value;
  SetUnlimitedLikesFilter(this.value);
}

class SetDistanceFilter extends ProfileFiltersEvent {
  final MinDistanceKm? min;
  final MaxDistanceKm? max;
  SetDistanceFilter(this.min, this.max);
}

class SetProfileCreatedFilter extends ProfileFiltersEvent {
  final ProfileCreatedTimeFilter? value;
  SetProfileCreatedFilter(this.value);
}

class SetProfileEditedFilter extends ProfileFiltersEvent {
  final ProfileEditedTimeFilter? value;
  SetProfileEditedFilter(this.value);
}

class SetProfileTextFilter extends ProfileFiltersEvent {
  final ProfileTextMinCharactersFilter? min;
  final ProfileTextMaxCharactersFilter? max;
  SetProfileTextFilter(this.min, this.max);
}

class SetRandomProfileOrderAndSaveSettings extends ProfileFiltersEvent {
  final bool value;
  SetRandomProfileOrderAndSaveSettings(this.value);
}

class SetAttributeFilterValueLists extends ProfileFiltersEvent {
  final UiAttribute attribute;
  final AttributeStateStorage wanted;
  final AttributeStateStorage unwanted;
  SetAttributeFilterValueLists(this.attribute, this.wanted, this.unwanted);
}

class SetAttributeFilterSettings extends ProfileFiltersEvent {
  final UiAttribute attribute;
  final FilterSettingsState value;
  SetAttributeFilterSettings(this.attribute, this.value);
}

class UpdateAgeRange extends ProfileFiltersEvent {
  final int min;
  final int max;
  UpdateAgeRange(this.min, this.max);
}

class ProfileFiltersBloc extends Bloc<ProfileFiltersEvent, ProfileFiltersData> with ActionRunner {
  final ProfileRepository profile;
  final AccountDatabaseManager db;

  StreamSubscription<bool?>? _showAdvancedFiltersSubscription;
  StreamSubscription<bool?>? _filterFavoritesSubscription;
  StreamSubscription<GetProfileFilters?>? _profileFiltersSubscription;
  StreamSubscription<int?>? _minAgeSubscription;
  StreamSubscription<int?>? _maxAgeSubscription;

  ProfileFiltersBloc(RepositoryInstances r)
    : profile = r.profile,
      db = r.accountDb,
      super(ProfileFiltersData(edited: EditedFiltersData())) {
    on<SaveNewFilterSettings>((data, emit) async {
      await runOnce(() async {
        // If online status filter is enabled but privacy setting is disabled, disable the filter
        final lastSeenTimeFilter = state.valueLastSeenTimeFilter();
        final privacySettings = await db
            .accountStream((db) => db.profilePrivacy.watchProfilePrivacySettings())
            .first;

        if (lastSeenTimeFilter?.value == -1) {
          if (privacySettings?.onlineStatus == false) {
            modifyEdited(emit, (e) => e.copyWith(lastSeenTimeFilter: editValue(null)));
          }
        } else if (lastSeenTimeFilter != null && lastSeenTimeFilter.value >= 0) {
          // If last seen time filter is enabled but privacy setting is disabled, disable the filter
          if (privacySettings?.lastSeenTime == false) {
            modifyEdited(emit, (e) => e.copyWith(lastSeenTimeFilter: editValue(null)));
          }
        }

        emit(state.copyWith(updateState: const UpdateStarted()));

        final waitTime = WantedWaitingTimeManager();

        var failureDetected = false;

        emit(state.copyWith(updateState: const UpdateInProgress()));

        final s = state;

        if (s.edited.isProfileFiltersUpdateNeeded()) {
          if (await profile
              .updateProfileFilters(
                s.valueAttributeFilters(),
                s.valueLastSeenTimeFilter(),
                s.valueUnlimitedLikesFilter(),
                s.valueMinDistanceKmFilter(),
                s.valueMaxDistanceKmFilter(),
                s.valueProfileCreatedTime(),
                s.valueProfileEditedTime(),
                s.valueProfileTextMinCharacters(),
                s.valueProfileTextMaxCharacters(),
                s.valueRandomProfileOrder(),
              )
              .isErr()) {
            failureDetected = true;
          }
        }

        if (s.edited.isAgeRangeUpdateNeeded()) {
          if (!await profile.updateSearchAgeRange(s.valueMinAge(), s.valueMaxAge()).isOk()) {
            failureDetected = true;
          }
        }

        await profile.resetMainProfileIterator();

        if (failureDetected) {
          showSnackBar(R.strings.profile_filters_screen_updating_filters_failed);
        }

        await waitTime.waitIfNeeded();

        emit(state.copyWith(updateState: const UpdateIdle()));

        resetEditedValues(emit);
      });
    });
    on<ResetEditedValues>((data, emit) {
      resetEditedValues(emit);
    });
    on<DisableAllFilterSettings>((data, emit) {
      final Map<int, ProfileAttributeFilterValueUpdate> disableAttributeFilters = {};
      for (final a in state.attributeIdAndAttributeFilterMap.values) {
        disableAttributeFilters[a.id] = ProfileAttributeFilterValueUpdate(id: a.id, enabled: false);
      }

      if (disableAttributeFilters.isEmpty) {
        emit(state.copyWith(edited: state.edited.copyWith(attributeIdAndAttributeFilterMap: null)));
      } else {
        emit(
          state.copyWith(
            edited: state.edited.copyWith(
              attributeIdAndAttributeFilterMap: disableAttributeFilters,
            ),
          ),
        );
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
    on<NewProfileFilters>((data, emit) {
      emit(
        state.copyWith(
          filters: data.value,
          attributeIdAndAttributeFilterMap: data.value?.currentFiltersCopy() ?? {},
        ),
      );
    });
    on<NewMinAge>((data, emit) async {
      emit(state.copyWith(minAge: data.value));
    });
    on<NewMaxAge>((data, emit) async {
      emit(state.copyWith(maxAge: data.value));
    });
    on<SetShowAdvancedFilters>((data, emit) async {
      await db.accountAction((db) => db.app.updateShowAdvancedFilters(data.value));
    });
    on<SetFavoriteProfilesFilter>((data, emit) async {
      await runOnce(() async {
        await profile.changeProfileFilterFavorites(data.value);
        final isHandled = EventHandlingTracker();
        await profile.resetMainProfileIterator(eventHandlingTracking: isHandled);
        // Prevent showing all profiles when favorites should be shown. That
        // can happen when toggling favorites filter fast enough.
        if (data.waitEventHandling) {
          await Future.any([
            isHandled._isHandled(),
            // Prevent favorites filter getting stuck as
            // ProfileGrid might not exist.
            Future<void>.delayed(Duration(seconds: 1)),
          ]);
        }
        await isHandled._dispose();
      });
    });
    on<SetLastSeenTimeFilter>((data, emit) {
      final newValue = data.value;
      final newLastSeenTimeFilter = newValue == null ? null : LastSeenTimeFilter(value: newValue);
      modifyEdited(
        emit,
        (e) => state.filters?.lastSeenTimeFilter == newLastSeenTimeFilter
            ? e.copyWith(lastSeenTimeFilter: const NoEdit())
            : e.copyWith(lastSeenTimeFilter: editValue(newLastSeenTimeFilter)),
      );
    });
    on<SetUnlimitedLikesFilter>((data, emit) {
      modifyEdited(
        emit,
        (e) => state.filters?.unlimitedLikesFilter == data.value
            ? e.copyWith(unlimitedLikesFilter: const NoEdit())
            : e.copyWith(unlimitedLikesFilter: editValue(data.value)),
      );
    });
    on<SetDistanceFilter>((data, emit) {
      final min = state.filters?.minDistanceKmFilter == data.min
          ? const NoEdit<MinDistanceKm>()
          : editValue(data.min);
      final max = state.filters?.maxDistanceKmFilter == data.max
          ? const NoEdit<MaxDistanceKm>()
          : editValue(data.max);
      modifyEdited(emit, (e) => e.copyWith(minDistanceKmFilter: min, maxDistanceKmFilter: max));
    });
    on<SetProfileCreatedFilter>((data, emit) {
      modifyEdited(
        emit,
        (e) => state.filters?.profileCreatedFilter == data.value
            ? e.copyWith(profileCreatedFilter: const NoEdit())
            : e.copyWith(profileCreatedFilter: editValue(data.value)),
      );
    });
    on<SetProfileEditedFilter>((data, emit) {
      modifyEdited(
        emit,
        (e) => state.filters?.profileEditedFilter == data.value
            ? e.copyWith(profileEditedFilter: const NoEdit())
            : e.copyWith(profileEditedFilter: editValue(data.value)),
      );
    });
    on<SetProfileTextFilter>((data, emit) {
      final min = state.filters?.profileTextMinCharactersFilter == data.min
          ? const NoEdit<ProfileTextMinCharactersFilter>()
          : editValue(data.min);
      final max = state.filters?.profileTextMaxCharactersFilter == data.max
          ? const NoEdit<ProfileTextMaxCharactersFilter>()
          : editValue(data.max);
      modifyEdited(
        emit,
        (e) => e.copyWith(profileTextMinCharactersFilter: min, profileTextMaxCharactersFilter: max),
      );
    });
    on<SetRandomProfileOrderAndSaveSettings>((data, emit) {
      modifyEdited(
        emit,
        (e) => state.filters?.randomProfileOrder == data.value
            ? e.copyWith(randomProfileOrder: null)
            : e.copyWith(randomProfileOrder: data.value),
      );
      add(SaveNewFilterSettings());
    });
    on<SetAttributeFilterValueLists>((data, emit) {
      updateFilters(
        emit,
        data.attribute.apiAttribute().id,
        (current) => AttributeFilterUpdateBuilder.copyWithValues(
          data.attribute,
          current,
          data.wanted,
          data.unwanted,
        ),
      );
    });
    on<SetAttributeFilterSettings>((data, emit) {
      updateFilters(
        emit,
        data.attribute.apiAttribute().id,
        (current) =>
            AttributeFilterUpdateBuilder.copyWithSettings(data.attribute, current, data.value),
      );
    });
    on<UpdateAgeRange>((data, emit) {
      handleAgeRangeSaving(emit, data.min, data.max);
    });

    _showAdvancedFiltersSubscription = db
        .accountStream((db) => db.app.watchShowAdvancedFilters())
        .listen((event) {
          add(NewShowAdvancedFiltersValue(event ?? false));
        });
    _filterFavoritesSubscription = db
        .accountStream((db) => db.app.watchProfileFilterFavorites())
        .listen((event) {
          add(NewFilterFavoriteProfilesValue(event ?? false));
        });
    _profileFiltersSubscription = db.accountStream((db) => db.search.watchProfileFilters()).listen((
      event,
    ) {
      add(NewProfileFilters(event));
    });
    _minAgeSubscription = db
        .accountStream((db) => db.search.watchProfileSearchAgeRangeMin())
        .listen((event) {
          add(NewMinAge(event ?? MIN_AGE));
        });
    _maxAgeSubscription = db
        .accountStream((db) => db.search.watchProfileSearchAgeRangeMax())
        .listen((event) {
          add(NewMaxAge(event ?? MAX_AGE));
        });
  }

  void handleAgeRangeSaving(Emitter<ProfileFiltersData> emit, int min, int max) {
    if (min == state.minAge) {
      modifyEdited(emit, (e) => e.copyWith(minAge: null));
    } else {
      modifyEdited(emit, (e) => e.copyWith(minAge: min));
    }

    if (max == state.maxAge) {
      modifyEdited(emit, (e) => e.copyWith(maxAge: null));
    } else {
      modifyEdited(emit, (e) => e.copyWith(maxAge: max));
    }
  }

  void resetEditedValues(Emitter<ProfileFiltersData> emit) {
    emit(state.copyWith(edited: EditedFiltersData()));
  }

  void modifyEdited(
    Emitter<ProfileFiltersData> emit,
    EditedFiltersData Function(EditedFiltersData) modify,
  ) {
    emit(state.copyWith(edited: modify(state.edited)));
  }

  void updateFilters(
    Emitter<ProfileFiltersData> emit,
    int attributeId,
    ProfileAttributeFilterValueUpdate Function(ProfileAttributeFilterValueUpdate)
    modifyCurrentValue,
  ) {
    final newAttributes = <int, ProfileAttributeFilterValueUpdate>{};
    var found = false;
    for (final a in state.valueAttributeFilters().values) {
      if (a.id == attributeId) {
        newAttributes[attributeId] = modifyCurrentValue(a);
        found = true;
      } else {
        newAttributes[a.id] = a;
      }
    }
    if (!found) {
      newAttributes[attributeId] = modifyCurrentValue(
        ProfileAttributeFilterValueUpdate(id: attributeId),
      );
    }

    bool different = false;
    for (final a in newAttributes.values) {
      final current =
          state.attributeIdAndAttributeFilterMap[a.id] ??
          ProfileAttributeFilterValueUpdate(id: a.id);
      if (attributeValuesDiffer(a, current)) {
        different = true;
        break;
      }
    }

    if (different) {
      emit(
        state.copyWith(
          edited: state.edited.copyWith(attributeIdAndAttributeFilterMap: newAttributes),
        ),
      );
    } else {
      emit(state.copyWith(edited: state.edited.copyWith(attributeIdAndAttributeFilterMap: null)));
    }
  }

  @override
  Future<void> close() async {
    await _showAdvancedFiltersSubscription?.cancel();
    await _filterFavoritesSubscription?.cancel();
    await _profileFiltersSubscription?.cancel();
    await _minAgeSubscription?.cancel();
    await _maxAgeSubscription?.cancel();
    await super.close();
  }
}

bool attributeValuesDiffer(
  ProfileAttributeFilterValueUpdate a,
  ProfileAttributeFilterValueUpdate current,
) {
  if (a.enabled != current.enabled ||
      a.acceptMissingAttribute != current.acceptMissingAttribute ||
      a.useLogicalOperatorAnd != current.useLogicalOperatorAnd ||
      a.wanted.length != current.wanted.length ||
      a.unwanted.length != current.unwanted.length) {
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

class EventHandlingTracker {
  final _subject = BehaviorSubject.seeded(false);

  Future<void> handleAndDispose() async {
    try {
      _subject.add(true);
    } catch (_) {
      // Disposed
    }
    await _subject.close();
  }

  Future<void> _isHandled() async {
    try {
      await _subject.firstWhere((v) => v == true);
    } catch (_) {
      // Disposed
    }
  }

  Future<void> _dispose() async {
    await _subject.close();
  }
}
