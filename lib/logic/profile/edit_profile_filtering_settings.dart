
import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";
import "package:pihka_frontend/data/profile_repository.dart";
import "package:pihka_frontend/model/freezed/logic/profile/edit_profile_filtering_settings.dart";
import "package:pihka_frontend/utils.dart";
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
  final ProfileAttributeValueUpdate value;
  SetAttributeFilterValue(this.value);
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
        data.value.id,
        data.value,
        null,
      );
      emit(state.copyWith(attributeFilters: newAttributes));
    });
    on<SetMatchWithEmpty>((data, emit) async {
      final newAttributes = updateAttributesFiltersList(
        state.attributeFilters,
        data.a.id,
        null,
        data.value,
      );
      emit(state.copyWith(attributeFilters: newAttributes));
    });
  }

  UnmodifiableList<ProfileAttributeFilterValueUpdate> updateAttributesFiltersList(
    Iterable<ProfileAttributeFilterValueUpdate> current,
    int attributeId,
    ProfileAttributeValueUpdate? newFilterValue,
    bool? acceptMissingAttribute,
  ) {
      final useOldFilterValue = newFilterValue == null;
      final int? part1 = newFilterValue?.valuePart1;
      final int? part2 = newFilterValue?.valuePart2;

      final newAttributes = <ProfileAttributeFilterValueUpdate>[];
      var found = false;
      for (final a in state.attributeFilters) {
        if (a.id == attributeId) {
          newAttributes.add(ProfileAttributeFilterValueUpdate(
            id: attributeId,
            acceptMissingAttribute: acceptMissingAttribute ?? a.acceptMissingAttribute,
            filterPart1: useOldFilterValue ? a.filterPart1 : part1,
            filterPart2: useOldFilterValue ? a.filterPart2 : part2,
          ));
          found = true;
        } else {
          newAttributes.add(a);
        }
      }
      if (!found) {
        newAttributes.add(ProfileAttributeFilterValueUpdate(
            id: attributeId,
            acceptMissingAttribute: acceptMissingAttribute ?? false,
            filterPart1: useOldFilterValue ? null : part1,
            filterPart2: useOldFilterValue ? null : part2,
        ));
      }

    return UnmodifiableList(newAttributes);
  }
}
