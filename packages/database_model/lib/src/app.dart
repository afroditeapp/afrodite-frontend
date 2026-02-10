import 'package:openapi/api.dart';
import 'package:utils/utils.dart';

class GridSettings {
  final int? itemSizeMode;
  final int? paddingMode;
  const GridSettings({this.itemSizeMode, this.paddingMode});

  GridSettingMode _intToGridSettingMode(int? value, GridSettingMode defaultValue) {
    return switch (value) {
      0 => GridSettingMode.small,
      1 => GridSettingMode.medium,
      2 => GridSettingMode.large,
      3 => GridSettingMode.disabled,
      _ => defaultValue,
    };
  }

  GridSettingMode valueItemSizeMode() => _intToGridSettingMode(itemSizeMode, GridSettingMode.large);
  GridSettingMode valuePaddingMode() => _intToGridSettingMode(paddingMode, GridSettingMode.large);

  double valueHorizontalPadding() => switch (valuePaddingMode()) {
    GridSettingMode.small => 4,
    GridSettingMode.medium => 8,
    GridSettingMode.large => 16,
    GridSettingMode.disabled => 0,
  };

  double valueInternalPadding() => switch (valuePaddingMode()) {
    GridSettingMode.small => 2,
    GridSettingMode.medium => 4,
    GridSettingMode.large => 8,
    GridSettingMode.disabled => 0,
  };

  double valueProfileThumbnailBorderRadius() => switch (valuePaddingMode()) {
    GridSettingMode.disabled => 0,
    _ => 10,
  };

  int valueRowProfileCount() {
    const int DEFAULT = 2;
    return switch (valueItemSizeMode()) {
      GridSettingMode.small => 4,
      GridSettingMode.medium => 3,
      GridSettingMode.large => DEFAULT,
      _ => DEFAULT,
    };
  }
}

enum GridSettingMode {
  small,
  medium,
  large,
  disabled;

  int toInt() => switch (this) {
    small => 0,
    medium => 1,
    large => 2,
    disabled => 3,
  };
}

class ChatBackupReminder {
  final int? reminderIntervalDays;
  final UtcDateTime? lastBackupTime;
  final UtcDateTime? lastDialogOpenedTime;

  const ChatBackupReminder({
    this.reminderIntervalDays,
    this.lastBackupTime,
    this.lastDialogOpenedTime,
  });
}

class InitialSetupProgressEntry {
  final String? email;
  final bool? isAdult;
  final String? profileName;
  final int? profileAge;

  // Security selfie (slot is always 0)
  final String? securitySelfieContentId;
  final bool? securitySelfieFaceDetected;

  // Profile images with all data (content IDs, slots, face detected, crop areas)
  final List<ProfilePictureEntry>? profileImages;

  // Gender and search settings
  final String? gender;
  final bool? searchSettingMen;
  final bool? searchSettingWomen;
  final bool? searchSettingNonBinary;

  // Search age range
  final bool? searchAgeRangeInitDone;
  final int? searchAgeRangeMin;
  final int? searchAgeRangeMax;

  // Location
  final double? latitude;
  final double? longitude;

  // Profile attributes
  final List<ProfileAttributeValueUpdate>? profileAttributes;

  // First chat backup
  final bool? firstChatBackupCreated;

  const InitialSetupProgressEntry({
    this.email,
    this.isAdult,
    this.profileName,
    this.profileAge,
    this.securitySelfieContentId,
    this.securitySelfieFaceDetected,
    this.profileImages,
    this.gender,
    this.searchSettingMen,
    this.searchSettingWomen,
    this.searchSettingNonBinary,
    this.searchAgeRangeInitDone,
    this.searchAgeRangeMin,
    this.searchAgeRangeMax,
    this.latitude,
    this.longitude,
    this.profileAttributes,
    this.firstChatBackupCreated,
  });
}

class EditProfileProgressEntry {
  final int? age;
  final String? name;
  final String? profileText;
  final List<ProfileAttributeValueUpdate>? profileAttributes;
  final bool? unlimitedLikes;
  final List<ProfilePictureEntry>? profileImages;

  const EditProfileProgressEntry({
    this.age,
    this.name,
    this.profileText,
    this.profileAttributes,
    this.unlimitedLikes,
    this.profileImages,
  });
}

/// Data model for a single profile picture stored in initial setup progress
class ProfilePictureEntry {
  final String contentId;
  final int? slot;
  final bool faceDetected;
  final bool accepted;
  final double cropSize;
  final double cropX;
  final double cropY;

  const ProfilePictureEntry({
    required this.contentId,
    required this.slot,
    required this.faceDetected,
    required this.accepted,
    required this.cropSize,
    required this.cropX,
    required this.cropY,
  });

  Map<String, dynamic> toJson() {
    return {
      'contentId': contentId,
      'slot': slot,
      'faceDetected': faceDetected,
      'accepted': accepted,
      'cropSize': cropSize,
      'cropX': cropX,
      'cropY': cropY,
    };
  }

  factory ProfilePictureEntry.fromJson(Map<String, dynamic> json) {
    return ProfilePictureEntry(
      contentId: json['contentId'] as String,
      slot: json['slot'] as int?,
      faceDetected: json['faceDetected'] as bool,
      accepted: json['accepted'] as bool,
      cropSize: (json['cropSize'] as num).toDouble(),
      cropX: (json['cropX'] as num).toDouble(),
      cropY: (json['cropY'] as num).toDouble(),
    );
  }
}
