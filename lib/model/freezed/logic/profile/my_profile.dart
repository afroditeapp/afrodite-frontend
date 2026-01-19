import 'package:database/database.dart';
import 'package:openapi/api.dart';
import 'package:app/utils/model.dart';

import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';
import 'package:app/ui_utils/common_update_logic.dart';

part 'my_profile.freezed.dart';

@freezed
class MyProfileData with _$MyProfileData, UpdateStateProvider {
  MyProfileData._();
  factory MyProfileData({
    @Default(UpdateIdle()) UpdateState updateState,
    MyProfileEntry? profile,
    @Default(false) bool loadingMyProfile,
    InitialAgeInfo? initialAgeInfo,
    required EditedMyProfileData edited,
  }) = _MyProfileData;

  bool unsavedChanges() =>
      edited.age != null ||
      edited.name != null ||
      edited.profileText.unsavedChanges() ||
      edited.attributeIdAndStateMap != null ||
      edited.unlimitedLikes != null;

  int? valueAge() => edited.age ?? profile?.age;
  String? valueName() => edited.name ?? profile?.name;
  String? valueProfileText() => edited.profileText.editedValue(profile?.profileText);
  Map<int, ProfileAttributeValueUpdate> valueAttributeIdAndStateMap() =>
      edited.attributeIdAndStateMap ?? profile?.attributeIdAndStateMap ?? {};
  bool valueUnlimitedLikes() => edited.unlimitedLikes ?? profile?.unlimitedLikes ?? false;
}

@freezed
class EditedMyProfileData with _$EditedMyProfileData {
  EditedMyProfileData._();
  factory EditedMyProfileData({
    int? age,
    String? name,
    @Default(NoEdit()) EditValue<String> profileText,
    Map<int, ProfileAttributeValueUpdate>? attributeIdAndStateMap,
    bool? unlimitedLikes,
  }) = _EditedMyProfileData;
}
