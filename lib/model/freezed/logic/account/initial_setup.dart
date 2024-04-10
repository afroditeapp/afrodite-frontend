import "dart:io";

import "package:camera/camera.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:latlong2/latlong.dart";
import "package:logging/logging.dart";
import "package:openapi/api.dart";
import "package:pihka_frontend/data/account_repository.dart";

import "package:freezed_annotation/freezed_annotation.dart";
import 'package:image/image.dart' as img;
import "package:pihka_frontend/data/login_repository.dart";
import "package:pihka_frontend/data/media_repository.dart";
import "package:pihka_frontend/localizations.dart";
import "package:pihka_frontend/logic/media/image_processing.dart";
import "package:pihka_frontend/logic/media/profile_pictures.dart";
import "package:pihka_frontend/model/freezed/logic/media/image_processing.dart";
import "package:pihka_frontend/model/freezed/logic/media/profile_pictures.dart";
import "package:pihka_frontend/ui_utils/snack_bar.dart";
import "package:pihka_frontend/utils.dart";
import "package:pihka_frontend/utils/tmp_dir.dart";

part 'initial_setup.freezed.dart';

@freezed
class InitialSetupData with _$InitialSetupData {
  factory InitialSetupData({
    String? email,
    DateTime? birthdate,
    String? profileInitial,
    int? profileAge,
    ProcessedAccountImage? securitySelfie,
    List<ImgState>? profileImages,
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
