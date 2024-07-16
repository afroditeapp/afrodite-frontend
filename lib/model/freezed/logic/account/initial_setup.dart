
import "package:flutter/material.dart";
import "package:latlong2/latlong.dart";
import "package:openapi/api.dart";

import "package:freezed_annotation/freezed_annotation.dart";
import "package:pihka_frontend/localizations.dart";
import "package:pihka_frontend/model/freezed/logic/media/image_processing.dart";
import "package:pihka_frontend/model/freezed/logic/media/profile_pictures.dart";
import "package:pihka_frontend/utils/immutable_list.dart";

part 'initial_setup.freezed.dart';

@freezed
class InitialSetupData with _$InitialSetupData {
  factory InitialSetupData({
    String? email,
    DateTime? birthdate,
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
    @Default(PartiallyAnswered([]))ProfileAttributesState profileAttributes,
    @Default(false) bool sendingInProgress,
  }) = _InitialSetupData;
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

enum GenderSearchSetting {
  men,
  women,
  all;

  String uiText(BuildContext context) {
    return switch (this) {
      men => context.strings.generic_gender_man_plural,
      women => context.strings.generic_gender_woman_plural,
      all => context.strings.generic_search_settings_looking_for_all_genders_text,
    };
  }

  GenderSearchSettingsAll toGenderSearchSettingsAll() {
    return switch (this) {
      men => const GenderSearchSettingsAll(men: true),
      women => const GenderSearchSettingsAll(women: true),
      all => const GenderSearchSettingsAll(men: true, women: true, nonBinary: true),
    };
  }
}

class GenderSearchSettingsAll {
  final bool men;
  final bool women;
  final bool nonBinary;
  const GenderSearchSettingsAll({
    this.men = false,
    this.women = false,
    this.nonBinary = false,
  });

  GenderSearchSetting? toGenderSearchSetting() {
    return switch (this) {
      GenderSearchSettingsAll(men: true, women: true, nonBinary: true) => GenderSearchSetting.all,
      GenderSearchSettingsAll(men: true, women: false) => GenderSearchSetting.men,
      GenderSearchSettingsAll(women: true, men: false) => GenderSearchSetting.women,
      _ => null,
    };
  }

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
    if (gender == Gender.nonBinary) {
      final selected = <String>[];
      if (nonBinary) {
        selected.add(Gender.nonBinary.uiTextPlural(context));
      }
      if (men) {
        selected.add(Gender.man.uiTextPlural(context));
      }
      if (women) {
        selected.add(Gender.woman.uiTextPlural(context));
      }
      return selected;
    } else {
      final setting = toGenderSearchSetting();
      if (setting == null) {
        return [];
      }
      return [setting.uiText(context)];
    }
  }
}

sealed class ProfileAttributesState {
  final List<ProfileAttributeValueUpdate> answers;
  const ProfileAttributesState(this.answers);
}
class PartiallyAnswered extends ProfileAttributesState {
  const PartiallyAnswered(super.answers);
}
class FullyAnswered extends ProfileAttributesState {
  const FullyAnswered(super.answers);
}
