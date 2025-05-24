
import "package:app/ui_utils/attribute/attribute.dart";
import "package:app/ui_utils/attribute/filter.dart";
import "package:app/ui_utils/attribute/state.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";
import "package:app/data/login_repository.dart";
import "package:app/data/profile_repository.dart";
import "package:app/model/freezed/logic/profile/edit_profile_filtering_settings.dart";
import "package:app/utils.dart";

sealed class EditProfileFilteringSettingsEvent {}
class ResetStateWith extends EditProfileFilteringSettingsEvent {
  final bool showOnlyFavorites;
  final Map<int, ProfileAttributeFilterValueUpdate> attributeIdAndFilterValueMap;
  final LastSeenTimeFilter? lastSeenTimeFilter;
  final bool? unlimitedLikesFilter;
  final MaxDistanceKm? maxDistanceFilter;
  final ProfileCreatedTimeFilter? profileCreatedFilter;
  final ProfileEditedTimeFilter? profileEditedFilter;
  final bool randomProfileOrder;
  ResetStateWith(
    this.showOnlyFavorites,
    this.attributeIdAndFilterValueMap,
    this.lastSeenTimeFilter,
    this.unlimitedLikesFilter,
    this.maxDistanceFilter,
    this.profileCreatedFilter,
    this.profileEditedFilter,
    this.randomProfileOrder,
  );
}

class SetFavoriteProfilesFilter extends EditProfileFilteringSettingsEvent {
  final bool value;
  SetFavoriteProfilesFilter(this.value);
}
class SetLastSeenTimeFilter extends EditProfileFilteringSettingsEvent {
  final int? value;
  SetLastSeenTimeFilter(this.value);
}
class SetUnlimitedLikesFilter extends EditProfileFilteringSettingsEvent {
  final bool? value;
  SetUnlimitedLikesFilter(this.value);
}
class SetMaxDistanceFilter extends EditProfileFilteringSettingsEvent {
  final MaxDistanceKm? value;
  SetMaxDistanceFilter(this.value);
}
class SetProfileCreatedFilter extends EditProfileFilteringSettingsEvent {
  final ProfileCreatedTimeFilter? value;
  SetProfileCreatedFilter(this.value);
}
class SetProfileEditedFilter extends EditProfileFilteringSettingsEvent {
  final ProfileEditedTimeFilter? value;
  SetProfileEditedFilter(this.value);
}
class SetRandomProfileOrder extends EditProfileFilteringSettingsEvent {
  final bool value;
  SetRandomProfileOrder(this.value);
}
class SetAttributeFilterValueLists extends EditProfileFilteringSettingsEvent {
  final UiAttribute attribute;
  final AttributeStateStorage selected;
  SetAttributeFilterValueLists(this.attribute, this.selected);
}
class SetAttributeFilterSettings extends EditProfileFilteringSettingsEvent {
  final UiAttribute attribute;
  final FilterSettingsState value;
  SetAttributeFilterSettings(this.attribute, this.value);
}

class EditProfileFilteringSettingsBloc extends Bloc<EditProfileFilteringSettingsEvent, EditProfileFilteringSettingsData> with ActionRunner {
  final ProfileRepository profile = LoginRepository.getInstance().repositories.profile;

  EditProfileFilteringSettingsBloc() : super(EditProfileFilteringSettingsData()) {
    on<ResetStateWith>((data, emit) async {
      emit(state.copyWith(
        showOnlyFavorites: data.showOnlyFavorites,
        attributeIdAndFilterValueMap: data.attributeIdAndFilterValueMap,
        lastSeenTimeFilter: data.lastSeenTimeFilter,
        unlimitedLikesFilter: data.unlimitedLikesFilter,
        maxDistanceKmFilter: data.maxDistanceFilter,
        profileCreatedFilter: data.profileCreatedFilter,
        profileEditedFilter: data.profileEditedFilter,
        randomProfileOrder: data.randomProfileOrder,
      ));
    });
    on<SetFavoriteProfilesFilter>((data, emit) async {
      emit(state.copyWith(showOnlyFavorites: data.value));
    });
    on<SetLastSeenTimeFilter>((data, emit) async {
      final newValue = data.value;
      final newLastSeenTimeFilter = newValue == null ? null : LastSeenTimeFilter(value: newValue);
      emit(state.copyWith(lastSeenTimeFilter: newLastSeenTimeFilter));
    });
    on<SetUnlimitedLikesFilter>((data, emit) async {
      emit(state.copyWith(unlimitedLikesFilter: data.value));
    });
    on<SetMaxDistanceFilter>((data, emit) async {
      emit(state.copyWith(maxDistanceKmFilter: data.value));
    });
    on<SetProfileCreatedFilter>((data, emit) async {
      emit(state.copyWith(profileCreatedFilter: data.value));
    });
    on<SetProfileEditedFilter>((data, emit) async {
      emit(state.copyWith(profileEditedFilter: data.value));
    });
    on<SetRandomProfileOrder>((data, emit) async {
      emit(state.copyWith(randomProfileOrder: data.value));
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
  }

  void updateFilters(
    Emitter<EditProfileFilteringSettingsData> emit,
    int attributeId,
    ProfileAttributeFilterValueUpdate Function(ProfileAttributeFilterValueUpdate) modifyCurrentValue,
  ) {
    final newAttributes = <int, ProfileAttributeFilterValueUpdate>{};
    var found = false;
    for (final a in state.attributeIdAndFilterValueMap.values) {
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
    emit(state.copyWith(attributeIdAndFilterValueMap: newAttributes));
  }
}
