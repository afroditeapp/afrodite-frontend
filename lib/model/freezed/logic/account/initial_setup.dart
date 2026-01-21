import "package:app/logic/media/profile_pictures_interface.dart";
import "package:app/ui/initial_setup/search_settings.dart";
import "package:flutter/material.dart";
import "package:latlong2/latlong.dart";
import "package:openapi/api.dart";

import "package:freezed_annotation/freezed_annotation.dart";
import "package:app/localizations.dart";
import "package:app/model/freezed/logic/media/image_processing.dart";
import "package:app/model/freezed/logic/media/profile_pictures.dart";
import "package:app/utils/immutable_list.dart";

part 'initial_setup.freezed.dart';

@freezed
class InitialSetupData with _$InitialSetupData implements ProfilePicturesStateInterface {
  const InitialSetupData._();
  factory InitialSetupData({
    String? email,
    bool? isAdult,
    String? profileName,
    int? profileAge,
    ProcessedAccountImage? securitySelfie,
    ImmutableList<ImgState>? profileImages,
    Gender? gender,
    @Default(GenderSearchSettingsAll()) GenderSearchSettingsAll genderSearchSetting,
    @Default(false) bool searchAgeRangeInitDone,
    int? searchAgeRangeMin,
    int? searchAgeRangeMax,
    LatLng? profileLocation,
    @Default(ProfileAttributesState([])) ProfileAttributesState profileAttributes,
    @Default(false) bool chatInfoUnderstood,
    @Default(false) bool sendingInProgress,
  }) = _InitialSetupData;

  @override
  List<ImgState> valuePictures() {
    final images = profileImages?.toList() ?? [];
    // Ensure we always return a list of 4 elements
    return [
      if (images.isNotEmpty) images[0] else const Empty(),
      if (images.length > 1) images[1] else const Empty(),
      if (images.length > 2) images[2] else const Empty(),
      if (images.length > 3) images[3] else const Empty(),
    ];
  }

  @override
  int? nextAvailableSlotInInitialSetup() {
    // 0 is for security selfie
    final availableSlots = [1, 2, 3, 4];
    for (final img in valuePictures()) {
      if (img is ImageSelected) {
        final info = img.img;
        if (info is ProfileImage) {
          final slot = info.slot;
          if (slot != null) {
            availableSlots.remove(slot);
          }
        }
      }
    }

    return availableSlots.firstOrNull;
  }
}

enum Gender {
  man,
  woman,
  nonBinary;

  String uiTextSingular(BuildContext context) {
    return switch (this) {
      man => context.strings.generic_gender_man,
      woman => context.strings.generic_gender_woman,
      nonBinary => context.strings.generic_gender_nonbinary,
    };
  }

  String uiTextPlural(BuildContext context) {
    return switch (this) {
      man => context.strings.generic_gender_man_plural,
      woman => context.strings.generic_gender_woman_plural,
      nonBinary => context.strings.generic_gender_nonbinary_plural,
    };
  }
}

class GenderSearchSettingsAll {
  final bool men;
  final bool women;
  final bool nonBinary;
  const GenderSearchSettingsAll({this.men = false, this.women = false, this.nonBinary = false});

  GenderSearchSettingsAll updateWith(bool value, Gender whatUpdated) {
    return switch (whatUpdated) {
      Gender.man => GenderSearchSettingsAll(men: value, women: women, nonBinary: nonBinary),
      Gender.woman => GenderSearchSettingsAll(men: men, women: value, nonBinary: nonBinary),
      Gender.nonBinary => GenderSearchSettingsAll(men: men, women: women, nonBinary: value),
    };
  }

  bool notEmpty() {
    return men || women || nonBinary;
  }

  List<String> toUiTexts(BuildContext context, Gender? gender) {
    final valueOrder = genderSearchSettingCheckboxOrder(gender);
    final selected = <String>[];
    for (final g in valueOrder) {
      switch (g) {
        case Gender.man:
          if (men) {
            selected.add(Gender.man.uiTextPlural(context));
          }
        case Gender.woman:
          if (women) {
            selected.add(Gender.woman.uiTextPlural(context));
          }
        case Gender.nonBinary:
          if (nonBinary) {
            selected.add(Gender.nonBinary.uiTextPlural(context));
          }
      }
    }
    return selected;
  }
}

class ProfileAttributesState {
  final List<ProfileAttributeValueUpdate> answers;
  const ProfileAttributesState(this.answers);

  bool answerForRequiredAttributeExists(int attributeId) {
    for (final a in answers) {
      if (a.id == attributeId) {
        final answer = a.v.firstOrNull;
        return answer != null && answer != 0;
      }
    }
    return false;
  }

  ProfileAttributesState addOrReplace(ProfileAttributeValueUpdate update) {
    final updates = <ProfileAttributeValueUpdate>[];
    bool updated = false;
    for (final u in answers) {
      if (u.id == update.id) {
        updates.add(update);
        updated = true;
      } else {
        updates.add(u);
      }
    }

    if (!updated) {
      updates.add(update);
    }

    return ProfileAttributesState(updates);
  }
}
