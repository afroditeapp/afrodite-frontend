
import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';
import 'package:openapi/api.dart';

part 'edit_my_profile.freezed.dart';

@freezed
class EditMyProfileData with _$EditMyProfileData {
  const EditMyProfileData._();
  factory EditMyProfileData({
    int? age,
    String? name,
    String? profileText,
    @Default({}) Map<int, ProfileAttributeValueUpdate> attributeIdAndStateMap,
    @Default(false) bool unlimitedLikes,
  }) = _EditMyProfileData;

  bool profileTextByteLenghtLessOrMaxValue() {
    final length = profileText?.length ?? 0;
    return length <= 2000;
  }
}
