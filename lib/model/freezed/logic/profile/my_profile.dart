import 'package:app/ui_utils/profile_pictures.dart';
import 'package:database/database.dart';
import 'package:openapi/api.dart';
import 'package:app/utils/model.dart';
import 'package:app/logic/media/profile_pictures_interface.dart';
import 'package:app/utils/profile_entry.dart';
import 'package:database_utils/database_utils.dart';
import 'package:app/ui_utils/crop_image_screen.dart';

import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';
import 'package:app/ui_utils/common_update_logic.dart';

part 'my_profile.freezed.dart';

@freezed
class MyProfileData
    with _$MyProfileData, UpdateStateProvider
    implements ProfilePicturesStateInterface {
  MyProfileData._();
  factory MyProfileData({
    @Default(UpdateIdle()) UpdateState updateState,
    MyProfileEntry? profile,
    @Default(false) bool loadingMyProfile,
    InitialAgeInfo? initialAgeInfo,
    @Default(false) bool openSelectImageScreen,
    required EditedMyProfileData edited,
  }) = _MyProfileData;

  ImgState get picture0 => _imgState(0);
  ImgState get picture1 => _imgState(1);
  ImgState get picture2 => _imgState(2);
  ImgState get picture3 => _imgState(3);

  ImgState _imgState(int index) {
    final p = profile;
    if (p == null) return const Empty();
    final c = p.myContent.getAtOrNull(index);
    if (c == null) return const Empty();
    final imgId = AccountImageId(p.accountId, c.id, c.faceDetected, c.accepted);
    final cropArea = index == 0 ? p.primaryImageCropArea() : CropArea.full;
    return ImageSelected(imgId, null, cropArea: cropArea);
  }

  bool unsavedChanges() =>
      edited.age != null ||
      edited.name != null ||
      edited.profileText.unsavedChanges() ||
      edited.attributeIdAndStateMap != null ||
      edited.unlimitedLikes != null ||
      edited.picture0.unsavedChanges() ||
      _pictureUnsavedChangesCropAreaIgnored(edited.picture1, picture1) ||
      _pictureUnsavedChangesCropAreaIgnored(edited.picture2, picture2) ||
      _pictureUnsavedChangesCropAreaIgnored(edited.picture3, picture3);

  bool _pictureUnsavedChangesCropAreaIgnored(EditValue<ImgState> edited, ImgState current) {
    if (!edited.unsavedChanges()) return false;
    final val = edited.editedValue(current);
    if (val == null) return current is! Empty;
    if (current is ImageSelected && val is ImageSelected) {
      return current.id != val.id || current.slot != val.slot;
    }
    return current != val;
  }

  int? valueAge() => edited.age ?? profile?.age;
  String? valueName() => edited.name ?? profile?.name;
  String? valueProfileText() => edited.profileText.editedValue(profile?.profileText);
  Map<int, ProfileAttributeValueUpdate> valueAttributeIdAndStateMap() =>
      edited.attributeIdAndStateMap ?? profile?.attributeIdAndStateMap ?? {};
  bool valueUnlimitedLikes() => edited.unlimitedLikes ?? profile?.unlimitedLikes ?? false;

  ImgState valuePicture0() => edited.picture0.editedValue(picture0) ?? picture0;
  ImgState valuePicture1() => edited.picture1.editedValue(picture1) ?? picture1;
  ImgState valuePicture2() => edited.picture2.editedValue(picture2) ?? picture2;
  ImgState valuePicture3() => edited.picture3.editedValue(picture3) ?? picture3;

  @override
  List<ImgState> valuePictures() {
    return [valuePicture0(), valuePicture1(), valuePicture2(), valuePicture3()];
  }

  @override
  int? nextAvailableSlotInInitialSetup() {
    throw Exception("MyProfileData is not used in initial setup");
  }

  SetProfileContent? toSetProfileContent() {
    final pics = valuePictures();

    final img0 = pics[0];
    if (img0 is! ImageSelected) {
      return null;
    }

    final c = [img0.contentId(), pics[1].contentId(), pics[2].contentId(), pics[3].contentId()];

    return SetProfileContent(
      c: c.nonNulls.toList(),
      gridCropSize: img0.cropArea.gridCropSize,
      gridCropX: img0.cropArea.gridCropX,
      gridCropY: img0.cropArea.gridCropY,
    );
  }

  bool faceDetectedFromPrimaryImage() {
    final img0 = valuePictures()[0];
    return img0 is ImageSelected && img0.isFaceDetected();
  }
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
    @Default(NoEdit()) EditValue<ImgState> picture0,
    @Default(NoEdit()) EditValue<ImgState> picture1,
    @Default(NoEdit()) EditValue<ImgState> picture2,
    @Default(NoEdit()) EditValue<ImgState> picture3,
  }) = _EditedMyProfileData;
}
