
import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";
import "package:app/data/login_repository.dart";
import "package:app/data/profile_repository.dart";
import "package:app/model/freezed/logic/profile/edit_profile_filtering_settings.dart";
import "package:app/utils.dart";
import "package:app/utils/api.dart";
import "package:app/utils/immutable_list.dart";

sealed class EditProfileFilteringSettingsEvent {}
class ResetStateWith extends EditProfileFilteringSettingsEvent {
  final bool showOnlyFavorites;
  final List<ProfileAttributeFilterValueUpdate> attributeFilters;
  final LastSeenTimeFilter? lastSeenTimeFilter;
  final bool? unlimitedLikesFilter;
  final MaxDistanceKm? maxDistanceFilter;
  final ProfileCreatedTimeFilter? profileCreatedFilter;
  final ProfileEditedTimeFilter? profileEditedFilter;
  final bool randomProfileOrder;
  ResetStateWith(
    this.showOnlyFavorites,
    this.attributeFilters,
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
class SetAttributeFilterValue extends EditProfileFilteringSettingsEvent {
  final Attribute a;
  final ProfileAttributeValueUpdate value;
  SetAttributeFilterValue(this.a, this.value);
}
class SetMatchWithEmpty extends EditProfileFilteringSettingsEvent {
  final Attribute a;
  final bool value;
  SetMatchWithEmpty(this.a, this.value);
}

class EditProfileFilteringSettingsBloc extends Bloc<EditProfileFilteringSettingsEvent, EditProfileFilteringSettingsData> with ActionRunner {
  final ProfileRepository profile = LoginRepository.getInstance().repositories.profile;

  EditProfileFilteringSettingsBloc() : super(EditProfileFilteringSettingsData()) {
    on<ResetStateWith>((data, emit) async {
      emit(state.copyWith(
        showOnlyFavorites: data.showOnlyFavorites,
        attributeFilters: UnmodifiableList(data.attributeFilters),
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
    on<SetAttributeFilterValue>((data, emit) async {
      final newAttributes = updateAttributesFiltersList(
        state.attributeFilters,
        data.a,
        data.value,
        null,
      );
      emit(state.copyWith(attributeFilters: newAttributes));
    });
    on<SetMatchWithEmpty>((data, emit) async {
      final newAttributes = updateAttributesFiltersList(
        state.attributeFilters,
        data.a,
        null,
        data.value,
      );
      emit(state.copyWith(attributeFilters: newAttributes));
    });
  }

  UnmodifiableList<ProfileAttributeFilterValueUpdate> updateAttributesFiltersList(
    Iterable<ProfileAttributeFilterValueUpdate> current,
    Attribute attribute,
    ProfileAttributeValueUpdate? newFilterValue,
    bool? acceptMissingAttribute,
  ) {
      final useOldFilterValue = newFilterValue == null;

      final newAttributes = <ProfileAttributeFilterValueUpdate>[];
      var found = false;
      for (final a in state.attributeFilters) {
        if (a.id == attribute.id) {
          newAttributes.add(createFilterValueUpdate(
            a: attribute,
            acceptMissingAttribute: acceptMissingAttribute ?? (a.acceptMissingAttribute ?? false),
            filterPart1: useOldFilterValue ? a.firstValue() : newFilterValue.firstValue(),
            filterPart2: useOldFilterValue ? a.secondValue() : newFilterValue.secondValue(),
          ));
          found = true;
        } else {
          newAttributes.add(a);
        }
      }
      if (!found) {
        newAttributes.add(createFilterValueUpdate(
            a: attribute,
            acceptMissingAttribute: acceptMissingAttribute ?? false,
            filterPart1: useOldFilterValue ? null : newFilterValue.firstValue(),
            filterPart2: useOldFilterValue ? null : newFilterValue.secondValue(),
        ));
      }

    return UnmodifiableList(newAttributes);
  }
}

ProfileAttributeFilterValueUpdate createFilterValueUpdate({
  required Attribute a,
  required bool acceptMissingAttribute,
  int? filterPart1,
  int? filterPart2,
}) {
  bool? updatedAcceptMissingAttribute = acceptMissingAttribute;
  int? updatedFilterPart1 = filterPart1;
  int? updatedFilterPart2 = filterPart2;

  // Disable filter if it is empty
  final bitflagFilterDisabled = a.isBitflagAttributeWhenFiltering() && (filterPart1 == 0 || filterPart1 == null) && !acceptMissingAttribute;
  final valueFilterDisabled = !a.isBitflagAttributeWhenFiltering() && filterPart1 == null && !acceptMissingAttribute;
  if (bitflagFilterDisabled || valueFilterDisabled) {
    updatedAcceptMissingAttribute = null;
    updatedFilterPart1 = null;
    updatedFilterPart2 = null;
  }

  final List<int> updatedValues;
  if (updatedFilterPart1 != null && updatedFilterPart2 != null) {
    updatedValues = [updatedFilterPart1, updatedFilterPart2];
  } else if (updatedFilterPart1 != null) {
    updatedValues = [updatedFilterPart1];
  } else {
    updatedValues = [];
  }

  final value = ProfileAttributeFilterValueUpdate(
    id: a.id,
    filterValues: updatedValues,
    acceptMissingAttribute: updatedAcceptMissingAttribute,
  );

  return value;
}
