
import 'dart:math';

import 'package:openapi/api.dart';
import 'package:utils/utils.dart';

class ProfileEntry implements PublicContentProvider {
  final AccountId uuid;
  @override
  final List<ContentIdAndAccepted> content;
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
  /// Use update type also here to avoid extra type conversions when
  /// editing attributes.
  final Map<int, ProfileAttributeValueUpdate> attributeIdAndStateMap;
  final ProfileVersion version;
  final ProfileContentVersion contentVersion;
  final UtcDateTime? newLikeInfoReceivedTime;
  ProfileEntry(
    {
      required this.uuid,
      required this.content,
      required this.primaryContentGridCropSize,
      required this.primaryContentGridCropX,
      required this.primaryContentGridCropY,
      required this.name,
      required this.nameAccepted,
      required this.profileText,
      required this.profileTextAccepted,
      required this.age,
      required this.unlimitedLikes,
      required this.attributeIdAndStateMap,
      required this.version,
      required this.contentVersion,
      this.lastSeenTimeValue,
      this.newLikeInfoReceivedTime,
    }
  );

  bool containsNonAcceptedContent() {
    return content.any((v) => !v.accepted);
  }

  ContentId? acceptedPrimaryImg() {
    final img = content.firstOrNull;
    if (img == null || !img.primary || !img.accepted) {
      return null;
    } else {
      return img.id;
    }
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
    // TODO(prod): Remove showNonAcceptedProfileTexts
    if (showNonAcceptedProfileTexts || profileTextAccepted) {
      return profileText;
    } else {
      return hideOtherCharactersThanTheFirst(profileText);
    }
  }

  String profileNameOrFirstCharacterProfileName() {
    if (nameAccepted) {
      return name;
    } else {
      return hideOtherCharactersThanTheFirst(name);
    }
  }
}

String hideOtherCharactersThanTheFirst(String value) {
  final iterator = value.runes.iterator;
  iterator.moveNext();
  final onlyFirstCharacterVisible = "${iterator.currentAsString}…";
  if (iterator.moveNext()) {
    // String contains more than one character
    return onlyFirstCharacterVisible;
  } else {
    return value;
  }
}

class MyProfileEntry extends ProfileEntry implements MyContentProvider {
  final ProfileNameModerationState profileNameModerationState;
  final ProfileTextModerationState profileTextModerationState;
  final ProfileTextModerationRejectedReasonCategory? profileTextModerationRejectedCategory;
  final ProfileTextModerationRejectedReasonDetails? profileTextModerationRejectedDetails;

  @override
  final List<MyContent> myContent;

  MyProfileEntry({
    required this.profileNameModerationState,
    required this.profileTextModerationState,
    required this.myContent,
    this.profileTextModerationRejectedCategory,
    this.profileTextModerationRejectedDetails,
    required super.uuid,
    required super.primaryContentGridCropSize,
    required super.primaryContentGridCropX,
    required super.primaryContentGridCropY,
    required super.name,
    required super.nameAccepted,
    required super.profileText,
    required super.profileTextAccepted,
    required super.age,
    required super.unlimitedLikes,
    required super.attributeIdAndStateMap,
    required super.version,
    required super.contentVersion,
    super.lastSeenTimeValue,
    super.newLikeInfoReceivedTime,
  }) : super(content: myContent);
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
  // TODO(prod): Remove showNonAcceptedProfileNames
  final bool showNonAcceptedProfileNames;
  const ProfileTitle(this.name, this.nameAccepted, this.showNonAcceptedProfileNames);

  String profileTitle() {
    if (showNonAcceptedProfileNames || nameAccepted) {
      return name;
    } else {
      return hideOtherCharactersThanTheFirst(name);
    }
  }
}

abstract class PublicContentProvider {
  List<ContentIdAndAccepted> get content;
}

class ContentIdAndAccepted {
  final ContentId id;
  final bool accepted;
  final bool primary;
  ContentIdAndAccepted(this.id, this.accepted, this.primary);

  @override
  bool operator ==(Object other) {
    return other is ContentIdAndAccepted &&
      id == other.id &&
      accepted == other.accepted &&
      primary == other.primary;
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    accepted,
    primary,
  );
}

abstract class MyContentProvider {
  List<MyContent> get myContent;
}

class MyContent extends ContentIdAndAccepted {
  final bool faceDetected;
  final ContentModerationState state;
  final ProfileContentModerationRejectedReasonCategory? rejectedCategory;
  final ProfileContentModerationRejectedReasonDetails? rejectedDetails;
  MyContent(
    ContentId id,
    this.faceDetected,
    this.state,
    this.rejectedCategory,
    this.rejectedDetails,
    {
      required bool primaryContent,
    }
  ) : super(
    id,
    state == ContentModerationState.acceptedByBot || state == ContentModerationState.acceptedByHuman,
    primaryContent,
  );

  @override
  bool operator ==(Object other) {
    return other is MyContent &&
      id == other.id &&
      accepted == other.accepted &&
      faceDetected == other.faceDetected &&
      state == other.state &&
      rejectedCategory == other.rejectedCategory &&
      rejectedDetails == other.rejectedDetails;
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    accepted,
    state,
    rejectedCategory,
    rejectedDetails,
  );
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

enum AccountState {
  initialSetup,
  normal,
  banned,
  pendingDeletion,
}

extension AccountStateContainerToAccountState on AccountStateContainer {
  AccountState toAccountState() {
    if (pendingDeletion) {
      return AccountState.pendingDeletion;
    } else if (banned) {
      return AccountState.banned;
    } else if (!initialSetupCompleted) {
      return AccountState.initialSetup;
    } else {
      return AccountState.normal;
    }
  }
}

class ProfileAttributes {
  final AttributeOrderMode attributeOrder;
  /// This list is sorted by Attribute ID and the IDs can be used to
  /// index this list.
  final List<ProfileAttributeAndHash> attributeInfo;
  ProfileAttributes(this.attributeOrder, this.attributeInfo);

  Iterable<Attribute> get attributes => attributeInfo.map((v) => v.attribute);
}

class ProfileAttributeAndHash {
  final ProfileAttributeHash hash;
  final Attribute attribute;
  ProfileAttributeAndHash(this.hash, this.attribute);
}
