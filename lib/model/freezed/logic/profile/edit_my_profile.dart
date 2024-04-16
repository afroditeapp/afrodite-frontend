
import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/utils/immutable_list.dart';

part 'edit_my_profile.freezed.dart';

@freezed
class EditMyProfileData with _$EditMyProfileData {
  factory EditMyProfileData({
    int? age,
    String? initial,
    @Default(UnmodifiableList<ProfileAttributeValueUpdate>.empty())
      UnmodifiableList<ProfileAttributeValueUpdate> attributes,
  }) = _EditMyProfileData;
}
