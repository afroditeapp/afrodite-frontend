


import 'package:camera/camera.dart';
import 'package:http/http.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/api/api_manager.dart';
import 'package:pihka_frontend/logic/account/initial_setup.dart';
import 'package:pihka_frontend/logic/media/profile_pictures.dart';
import 'package:pihka_frontend/utils.dart';
import 'package:pihka_frontend/utils/result.dart';

var log = Logger("InitialSetupUtils");

class InitialSetupUtils {

  final ApiManager _api = ApiManager.getInstance();

  /// Returns null on success. Returns String if error.
  Future<WaitProcessingResult> _waitContentProcessing(int slot) async {
    while (true) {
      final state = await _api.media((api) => api.getContentSlotState(slot)).ok();
      if (state == null) {
        return ProcessingError("Server did not return content processing state");
      }

      switch (state.state) {
        case ContentProcessingStateType.processing || ContentProcessingStateType.inQueue: {
          await Future<void>.delayed(const Duration(seconds: 1));
        }
        case ContentProcessingStateType.failed: return ProcessingError("Security selfie processing failed");
        case ContentProcessingStateType.empty: return ProcessingError("Slot is empty");
        case ContentProcessingStateType.completed: {
          final contentId = state.contentId;
          if (contentId == null) {
            return ProcessingError("Server did not return content ID");
          } else {
            return ProcessingSuccess(contentId);
          }
        }
      }
    }
  }

  /// Do quick initial setup with some predefined values.
  ///
  /// Return null on success. Return String if error.
  Future<String?> doDeveloperInitialSetup(
    String email,
    String name,
    XFile securitySelfieFile,
    XFile profileImageFile
  ) async {
    // Handle images

    final String securitySelfiePath = securitySelfieFile.path;
    final String profileImagePath = profileImageFile.path;
    final securitySelfie = await MultipartFile.fromPath("", securitySelfiePath);
    final processingId = await _api.media((api) => api.putContentToContentSlot(0, true, MediaContentType.jpegImage, securitySelfie));
    if (processingId case Err()) {
      return "Server did not return content processing ID";
    }
    final result = await _waitContentProcessing(0);
    final ContentId contentId0;
    switch (result) {
      case ProcessingError(): return result.message;
      case ProcessingSuccess(): contentId0 = result.contentId;
    }
    await _api.mediaAction((api) => api.putPendingSecurityContentInfo(contentId0));

    final profileImage = await MultipartFile.fromPath("", profileImagePath);
    final processingId2 = await _api.media((api) => api.putContentToContentSlot(1, false, MediaContentType.jpegImage, profileImage));
    if (processingId2 case Err()) {
      return "Server did not return content processing ID";
    }
    final result2 = await _waitContentProcessing(1);
    final ContentId contentId1;
    switch (result2) {
      case ProcessingError(): return result2.message;
      case ProcessingSuccess(): contentId1 = result2.contentId;
    }
    await _api.mediaAction((api) => api.putPendingProfileContent(SetProfileContent(contentId0: contentId1)));
    await _api.mediaAction((api) => api.putModerationRequest(ModerationRequestContent(content0: contentId0, content1: contentId1)));

    // Other setup

    await _api.accountAction((api) => api.postAccountData(AccountData(email: email)));
    await _api.accountAction((api) => api.postAccountSetup(AccountSetup(birthdate: "1.1.2000")));


    final update = ProfileUpdate(
      age: 30,
      name: "X",
      profileText: "",
      attributes: [],
    );
    await _api.profileAction((api) => api.postProfile(update));
    final location = Location(latitude: 61, longitude: 24.5);
    await _api.profileAction((api) => api.putLocation(location));
    final ageRange = ProfileSearchAgeRange(min: 18, max: 99);
    await _api.profileAction((api) => api.postSearchAgeRange(ageRange));
    final groups = SearchGroups(
      manForMan: true,
      manForWoman: true,
      manForNonBinary: true,
    );
    await _api.profileAction((api) => api.postSearchGroups(groups));

    await _api.accountAction((api) => api.putSettingProfileVisiblity(BooleanSetting(value: true)));

    await _api.accountAction((api) => api.postCompleteSetup());

    final state = await _api.account((api) => api.getAccountState()).ok();
    if (state == null || state.state != AccountState.normal) {
      return "Error";
    }

    return null;
  }

  Future<Result<(), ()>> doInitialSetup(
    InitialSetupData data,
  ) async {

    {
      // Email can be null if Apple or Google login was used.
      final email = data.email;
      if (email != null) {
        final r = await _api.accountAction((api) => api.postAccountData(AccountData(email: email)));
        if (r.isErr()) return errAndLog("Setting email address failed");
      }
    }

    {
      // TODO(prod): Check does birthdate need time zone handling.
      //             Client and Server should use same time zone for checking
      //             if the user is old enough.
      final birthdate = data.birthdate;
      if (birthdate == null) return errAndLog("Birthdate is null");
      final datePart = birthdate.toIso8601String().substring(0, 10);
      final r = await _api.accountAction((api) => api.postAccountSetup(AccountSetup(birthdate: datePart)));
      if (r.isErr()) return errAndLog("Setting birthdate failed");
    }

    {
      final age = data.profileAge;
      if (age == null) return errAndLog("Age is null");
      final initial = data.profileInitial;
      if (initial == null) return errAndLog("Initial is null");
      final update = ProfileUpdate(
        age: age,
        name: initial,
        profileText: "",
        attributes: data.profileAttributes.answers,
      );
      final r = await _api.profileAction((api) => api.postProfile(update));
      if (r.isErr()) return errAndLog("Setting profile failed");
    }

    {
      final location = data.profileLocation;
      if (location == null) return errAndLog("Location is null");
      final update = Location(latitude: location.latitude, longitude: location.longitude);
      final r = await _api.profileAction((api) => api.putLocation(update));
      if (r.isErr()) return errAndLog("Setting location failed");
    }

    {
      final minAge = data.searchAgeRangeMin;
      if (minAge == null) return errAndLog("Min age is null");
      final maxAge = data.searchAgeRangeMax;
      if (maxAge == null) return errAndLog("Max age is null");
      final ageRange = ProfileSearchAgeRange(min: minAge, max: maxAge);
      final r = await _api.profileAction((api) => api.postSearchAgeRange(ageRange));
      if (r.isErr()) return errAndLog("Setting search age range failed");
    }

    {
      final gender = data.gender;
      if (gender == null) return errAndLog("Gender is null");
      final groups = createSearchGroups(gender, data.genderSearchSetting);
      final r = await _api.profileAction((api) => api.postSearchGroups(groups));
      if (r.isErr()) return errAndLog("Setting search groups failed");
    }

    {
      final r = await _api.accountAction((api) => api.putSettingProfileVisiblity(BooleanSetting(value: true)));
      if (r.isErr()) return errAndLog("Setting profile visibility failed");
    }

    // Images
    {
      final securitySelfie = data.securitySelfie?.contentId;
      if (securitySelfie == null) return errAndLog("Security selfie is null");
      final r1 = await _api.mediaAction((api) => api.putPendingSecurityContentInfo(securitySelfie));
      if (r1.isErr()) return errAndLog("Setting security selfie failed");

      final profileImages = data.profileImages;
      if (profileImages == null) return errAndLog("Profile images is null");
      final newProfileContent = createProfileContent(securitySelfie, profileImages).ok();
      if (newProfileContent == null) return errAndLog("Creating profile content failed");
      final r2 = await _api.mediaAction((api) => api.putPendingProfileContent(newProfileContent));
      if (r2.isErr()) return errAndLog("Setting profile images failed");

      final moderationRequest = ModerationRequestContent(
        content0: securitySelfie,
        content1: newProfileContent.contentId0,
        content2: newProfileContent.contentId1,
        content3: newProfileContent.contentId2,
        content4: newProfileContent.contentId3,
        content5: newProfileContent.contentId4,
        content6: newProfileContent.contentId5,
      );

      final r3 = await _api.mediaAction((api) => api.putModerationRequest(moderationRequest));
      if (r3.isErr()) return errAndLog("Moderation request sending failed");
    }

    {
      final r = await _api.accountAction((api) => api.postCompleteSetup());
      if (r.isErr()) return errAndLog("Completing setup failed");
    }

    return Ok(());
  }
}

Result<SetProfileContent, ()> createProfileContent(
  ContentId securitySelfie,
  List<ImgState> imgs,
) {
  double? gridCropSize;
  double? gridCropX;
  double? gridCropY;
  ContentId? contentId0;
  ContentId? contentId1;
  ContentId? contentId2;
  ContentId? contentId3;

  for (final (i, img) in imgs.indexed) {
    if (img is! ImageSelected) {
      if (i == 0) {
        return errAndLog("First profile image is not selected");
      } else {
        break;
      }
    }
    switch (i) {
      case 0:
        gridCropSize = img.cropResults.gridCropSize;
        gridCropX = img.cropResults.gridCropX;
        gridCropY = img.cropResults.gridCropY;
        contentId0 = getId(img.img, securitySelfie);
      case 1:
        contentId1 = getId(img.img, securitySelfie);
      case 2:
        contentId2 = getId(img.img, securitySelfie);
      case 3:
        contentId3 = getId(img.img, securitySelfie);
      default:
        ();
    }
  }

  if (contentId0 == null) return errAndLog("First profile image is not selected");

  return Ok(SetProfileContent(
    contentId0: contentId0,
    contentId1: contentId1,
    contentId2: contentId2,
    contentId3: contentId3,
    gridCropSize: gridCropSize,
    gridCropX: gridCropX,
    gridCropY: gridCropY,
  ));
}

SearchGroups createSearchGroups(Gender gender, GenderSearchSettingsAll genderSearchSetting) {
  switch (gender) {
    case Gender.man:
      return SearchGroups(
        manForMan: genderSearchSetting.men,
        manForWoman: genderSearchSetting.women,
        manForNonBinary: genderSearchSetting.nonBinary,
      );
    case Gender.woman:
      return SearchGroups(
        womanForMan: genderSearchSetting.men,
        womanForWoman: genderSearchSetting.women,
        womanForNonBinary: genderSearchSetting.nonBinary,
      );
    case Gender.nonBinary:
      return SearchGroups(
        nonBinaryForMan: genderSearchSetting.men,
        nonBinaryForWoman: genderSearchSetting.women,
        nonBinaryForNonBinary: genderSearchSetting.nonBinary,
      );
  }
}

ContentId getId(SelectedImageInfo info, ContentId securitySelfie) {
  return switch (info) {
    InitialSetupSecuritySelfie() => securitySelfie,
    ProfileImage(:final img) => img.contentId,
  };
}

Result<T, ()> errAndLog<T>(String message) {
  log.error(message);
  return Err(());
}

sealed class WaitProcessingResult {}
class ProcessingError extends WaitProcessingResult {
  final String message;
  ProcessingError(this.message);
}
class ProcessingSuccess extends WaitProcessingResult {
  final ContentId contentId;
  ProcessingSuccess(this.contentId);
}
