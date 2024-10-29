import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';

part 'user_interface.freezed.dart';

@freezed
class UserInterfaceSettingsData with _$UserInterfaceSettingsData {
  UserInterfaceSettingsData._();
  factory UserInterfaceSettingsData({
    @Default(false) bool showNonAcceptedProfileNames,
  }) = _UserInterfaceSettingsData;
}
