
import 'dart:math';

import 'package:openapi/api.dart';
import 'package:utils/utils.dart';

class ProfileEntry {
  final AccountId uuid;
  final ContentId imageUuid;
  final double primaryContentGridCropSize;
  final double primaryContentGridCropX;
  final double primaryContentGridCropY;
  final String name;
  final bool nameAccepted;
  final String profileText;
  final bool profileTextAccepted;
  final int age;
  final bool unlimitedLikes;
  /// Possible values:
  /// When -1, the user is currently online.
  /// When 0 or greater, the value is unix timestamp when profile has been
  /// seen online previously.
  final int? lastSeenTimeValue;
  final List<ProfileAttributeValue> attributes;
  final ProfileVersion version;
  final ProfileContentVersion contentVersion;
  final ContentId? content1;
  final ContentId? content2;
  final ContentId? content3;
  final ContentId? content4;
  final ContentId? content5;
  final ContentId? content6;
  final UtcDateTime? newLikeInfoReceivedTime;
  ProfileEntry(
    {
      required this.uuid,
      required this.imageUuid,
      required this.primaryContentGridCropSize,
      required this.primaryContentGridCropX,
      required this.primaryContentGridCropY,
      required this.name,
      required this.nameAccepted,
      required this.profileText,
      required this.profileTextAccepted,
      required this.age,
      required this.unlimitedLikes,
      required this.attributes,
      required this.version,
      required this.contentVersion,
      this.lastSeenTimeValue,
      this.content1,
      this.content2,
      this.content3,
      this.content4,
      this.content5,
      this.content6,
      this.newLikeInfoReceivedTime,
    }
  );

  List<ContentId> primaryImgAndPossibleOtherImgs() {
    final List<ContentId> contentList = [imageUuid];
    final c1 = content1;
    if (c1 != null) {
      contentList.add(c1);
    }
    final c2 = content2;
    if (c2 != null) {
      contentList.add(c2);
    }
    final c3 = content3;
    if (c3 != null) {
      contentList.add(c3);
    }
    final c4 = content4;
    if (c4 != null) {
      contentList.add(c4);
    }
    final c5 = content5;
    if (c5 != null) {
      contentList.add(c5);
    }
    return contentList;
  }

  String profileTitle(bool showNonAcceptedProfileNames) {
    return ProfileTitle(
      name,
      nameAccepted,
      showNonAcceptedProfileNames,
    ).profileTitle();
  }

  String profileTitleWithAge(bool showNonAcceptedProfileNames) {
    return "${profileTitle(showNonAcceptedProfileNames)}, $age";
  }

  String profileTextOrFirstCharacterProfileText(bool showNonAcceptedProfileTexts) {
    if (showNonAcceptedProfileTexts || profileTextAccepted) {
      return profileText;
    } else {
      final iterator = profileText.runes.iterator;
      iterator.moveNext();
      final onlyFirstCharacterVisible = "${iterator.currentAsString}…";
      if (iterator.moveNext()) {
        // String contains more than one character
        return onlyFirstCharacterVisible;
      } else {
        return name;
      }
    }
  }
}

class MyProfileEntry extends ProfileEntry {
  final ProfileNameModerationState profileNameModerationState;
  final ProfileTextModerationState profileTextModerationState;
  final bool faceDetectedContent0;
  final ProfileTextModerationRejectedReasonCategory? profileTextModerationRejectedCategory;
  final ProfileTextModerationRejectedReasonDetails? profileTextModerationRejectedDetails;
  final bool? faceDetectedContent1;
  final bool? faceDetectedContent2;
  final bool? faceDetectedContent3;
  final bool? faceDetectedContent4;
  final bool? faceDetectedContent5;
  final bool? faceDetectedContent6;

  MyProfileEntry({
    required this.profileNameModerationState,
    required this.profileTextModerationState,
    required this.faceDetectedContent0,
    this.profileTextModerationRejectedCategory,
    this.profileTextModerationRejectedDetails,
    this.faceDetectedContent1,
    this.faceDetectedContent2,
    this.faceDetectedContent3,
    this.faceDetectedContent4,
    this.faceDetectedContent5,
    this.faceDetectedContent6,
    required super.uuid,
    required super.imageUuid,
    required super.primaryContentGridCropSize,
    required super.primaryContentGridCropX,
    required super.primaryContentGridCropY,
    required super.name,
    required super.nameAccepted,
    required super.profileText,
    required super.profileTextAccepted,
    required super.age,
    required super.unlimitedLikes,
    required super.attributes,
    required super.version,
    required super.contentVersion,
    super.lastSeenTimeValue,
    super.content1,
    super.content2,
    super.content3,
    super.content4,
    super.content5,
    super.content6,
    super.newLikeInfoReceivedTime,
  });
}

/// Local unique identifier for a profile entry.
///
/// The profile table primary key autoincrements so this ID points only
/// to single AccountId.
class ProfileLocalDbId {
  final int id;
  const ProfileLocalDbId(this.id);
}

class ProfileTitle {
  final String name;
  final bool nameAccepted;
  final bool showNonAcceptedProfileNames;
  const ProfileTitle(this.name, this.nameAccepted, this.showNonAcceptedProfileNames);

  String profileTitle() {
    if (showNonAcceptedProfileNames || nameAccepted) {
      return name;
    } else {
      final iterator = name.runes.iterator;
      iterator.moveNext();
      final onlyFirstCharacterVisible = "${iterator.currentAsString}…";
      if (iterator.moveNext()) {
        // Name is more than one character
        return onlyFirstCharacterVisible;
      } else {
        return name;
      }
    }
  }
}

class NewMessageNotificationId {
  final int id;
  const NewMessageNotificationId(this.id);
}

class InitialAgeInfo {
  final int initialAge;
  final UtcDateTime time;
  const InitialAgeInfo(this.initialAge, this.time);

  AvailableAges availableAges(int maxAgeSupported) {
    final currentTime = UtcDateTime.now();
    final currentYear = currentTime.dateTime.year;
    final initialAgeYear = time.dateTime.year;
    final yearDiff = currentYear - initialAgeYear;

    final minAge = min(initialAge + yearDiff - 1, maxAgeSupported);
    final middleAge = min(minAge + 1, maxAgeSupported);
    final maxAge = min(initialAge + yearDiff + 1, maxAgeSupported);

    final ages = <int>[];

    if (initialAge != middleAge && minAge != middleAge) {
      ages.add(minAge);
    }
    ages.add(middleAge);
    if (middleAge != maxAge) {
      ages.add(maxAge);
    }

    final AutomaticAgeChangeInfo? nextAutomaticAgeChange;
    if (minAge >= maxAgeSupported || initialAge == maxAgeSupported) {
      nextAutomaticAgeChange = null;
    } else {
      if (initialAge == middleAge) {
        nextAutomaticAgeChange = AutomaticAgeChangeInfo(
          age: minAge + 2,
          year: currentYear + 2,
        );
      } else {
        nextAutomaticAgeChange = AutomaticAgeChangeInfo(
          age: minAge + 1,
          year: currentYear + 1,
        );
      }
    }

    return AvailableAges(
      availableAges: ages,
      nextAutomaticAgeChange: nextAutomaticAgeChange,
    );
  }
}

class AvailableAges {
  final List<int> availableAges;
  final AutomaticAgeChangeInfo? nextAutomaticAgeChange;
  AvailableAges({
    required this.availableAges,
    required this.nextAutomaticAgeChange,
  });
}

class AutomaticAgeChangeInfo {
  final int age;
  final int year;
  AutomaticAgeChangeInfo({
    required this.age,
    required this.year,
  });
}
