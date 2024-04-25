import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/model/freezed/logic/account/initial_setup.dart';

part 'edit_search_settings.freezed.dart';

@freezed
class EditSearchSettingsData with _$EditSearchSettingsData {
  EditSearchSettingsData._();
  factory EditSearchSettingsData({
    int? minAge,
    int? maxAge,
    Gender? gender,
    @Default(GenderSearchSettingsAll()) GenderSearchSettingsAll genderSearchSetting,
  }) = _EditSearchSettingsData;
}
