
import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';

part 'edit_my_profile.freezed.dart';

@freezed
class EditMyProfileData with _$EditMyProfileData {
  factory EditMyProfileData({
    int? age,
    String? initial,
  }) = _EditMyProfileData;
}
