
import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";
import "package:pihka_frontend/data/profile_repository.dart";
import "package:pihka_frontend/model/freezed/logic/profile/edit_profile_filtering_settings.dart";
import "package:pihka_frontend/utils.dart";
import "package:pihka_frontend/utils/api.dart";
import "package:pihka_frontend/utils/immutable_list.dart";

sealed class EditProfileFilteringSettingsEvent {}
class ResetStateWith extends EditProfileFilteringSettingsEvent {
  final bool showOnlyFavorites;
  final List<ProfileAttributeFilterValueUpdate> attributeFilters;
  ResetStateWith(this.showOnlyFavorites, this.attributeFilters);
}

class SetFavoriteProfilesFilter extends EditProfileFilteringSettingsEvent {
  final bool value;
  SetFavoriteProfilesFilter(this.value);
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
  final ProfileRepository profile = ProfileRepository.getInstance();

  EditProfileFilteringSettingsBloc() : super(EditProfileFilteringSettingsData()) {
    on<ResetStateWith>((data, emit) async {
      emit(state.copyWith(
        showOnlyFavorites: data.showOnlyFavorites,
        attributeFilters: UnmodifiableList(data.attributeFilters),
      ));
    });
    on<SetFavoriteProfilesFilter>((data, emit) async {
      emit(state.copyWith(showOnlyFavorites: data.value));
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
            filterPart1: useOldFilterValue ? a.filterPart1 : newFilterValue.valuePart1,
            filterPart2: useOldFilterValue ? a.filterPart2 : newFilterValue.valuePart2,
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
            filterPart1: useOldFilterValue ? null : newFilterValue.valuePart1,
            filterPart2: useOldFilterValue ? null : newFilterValue.valuePart2,
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
  final value = ProfileAttributeFilterValueUpdate(
    id: a.id,
    filterPart1: filterPart1,
    filterPart2: filterPart2,
    acceptMissingAttribute: acceptMissingAttribute,
  );

  // Disable filter if it is empty
  final bitflagFilterDisabled = a.isBitflagAttributeWhenFiltering() && (filterPart1 == 0 || filterPart1 == null) && !acceptMissingAttribute;
  final valueFilterDisabled = !a.isBitflagAttributeWhenFiltering() && filterPart1 == null && !acceptMissingAttribute;
  if (bitflagFilterDisabled || valueFilterDisabled) {
    value.acceptMissingAttribute = null;
    value.filterPart1 = null;
    value.filterPart2 = null;
  }

  return value;
}
