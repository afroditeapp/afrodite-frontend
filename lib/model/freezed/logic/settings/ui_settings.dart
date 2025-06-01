import 'package:database/database.dart';
import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';

part 'ui_settings.freezed.dart';

@freezed
class UiSettingsData with _$UiSettingsData {
  UiSettingsData._();
  factory UiSettingsData({
    @Default(false) bool showNonAcceptedProfileNames,
    @Default(GridSettings()) GridSettings gridSettings,
  }) = _UiSettingsData;
}
