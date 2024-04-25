import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/ui_utils/common_update_logic.dart';

part 'search_settings.freezed.dart';

@freezed
class SearchSettingsData with _$SearchSettingsData, UpdateStateProvider {
  SearchSettingsData._();
  factory SearchSettingsData({
    @Default(UpdateIdle()) UpdateState updateState,
    int? minAge,
    int? maxAge,
    SearchGroups? searchGroups,
  }) = _SearchSettingsData;
}
