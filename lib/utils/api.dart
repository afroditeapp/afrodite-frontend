

import 'package:database/database.dart';
import 'package:openapi/api.dart';
import 'package:app/model/freezed/logic/account/initial_setup.dart';
import 'package:app/utils/list.dart';
import 'package:utils/utils.dart';

extension ProfileVisibilityExtensions on ProfileVisibility {
  bool isInitialModerationOngoing() {
    return this == ProfileVisibility.pendingPrivate ||
      this == ProfileVisibility.pendingPublic;
  }

  /// Convert visibility to boolean without the pending state
  bool isPublic() {
    return this == ProfileVisibility.public ||
      this == ProfileVisibility.pendingPublic;
  }
}

extension AttributeExtensions on Attribute {
  bool isBitflagAttributeWhenFiltering() {
    return mode == AttributeMode.selectMultipleFilterMultiple ||
      mode == AttributeMode.selectSingleFilterMultiple;
  }

  bool isStoredAsBitflagValue() {
    return mode == AttributeMode.selectMultipleFilterMultiple ||
      mode == AttributeMode.selectSingleFilterMultiple;
  }

  bool isNumberListAttribute() {
    return mode == AttributeMode.selectMultipleFilterMultipleNumberList;
  }
}

extension ProfileAttributeValueUpdateExtensions on ProfileAttributeValueUpdate {
  void setBitflagValue(int value) {
    v = [value];
  }

  int? bitflagValue() {
    return v.firstOrNull;
  }

  int? firstValue() {
    return v.firstOrNull;
  }

  int? secondValue() {
    return v.getAtOrNull(1);
  }
}

extension ProfileAttributeValueExtensions on ProfileAttributeValue {
  int? firstValue() {
    return v.firstOrNull;
  }

  int? secondValue() {
    return v.getAtOrNull(1);
  }
}

extension ProfileAttributeFilterValueUpdateExtensions on ProfileAttributeFilterValueUpdate {
  int? firstValue() {
    return filterValues.firstOrNull;
  }

  int? secondValue() {
    return filterValues.getAtOrNull(1);
  }
}

extension PermissionsExtensions on Permissions {
  bool adminSettingsVisible() {
    // TODO(prod): Add missing permissions once
    // capability properies are non-nullable
    return adminModerateProfileContent;
  }
}

extension SearchGroupsExtensions on SearchGroups {
  Gender? toGender() {
    if (manForMan || manForWoman || manForNonBinary) {
      return Gender.man;
    } else if (womanForMan || womanForWoman || womanForNonBinary) {
      return Gender.woman;
    } else if (nonBinaryForMan || nonBinaryForWoman || nonBinaryForNonBinary) {
      return Gender.nonBinary;
    }

    return null;
  }

  GenderSearchSettingsAll? toGenderSearchSettingsAll() {
    switch (toGender()) {
      case Gender.man:
        return GenderSearchSettingsAll(
          men: manForMan,
          women: manForWoman,
          nonBinary: manForNonBinary,
        );
      case Gender.woman:
        return GenderSearchSettingsAll(
          men: womanForMan,
          women: womanForWoman,
          nonBinary: womanForNonBinary,
        );
      case Gender.nonBinary:
        return GenderSearchSettingsAll(
          men: nonBinaryForMan,
          women: nonBinaryForWoman,
          nonBinary: nonBinaryForNonBinary,
        );
      case null:
        return null;
    }
  }

  bool somethingIsSelected() {
    return manForMan ||
      manForWoman ||
      manForNonBinary ||
      womanForMan ||
      womanForWoman ||
      womanForNonBinary ||
      nonBinaryForMan ||
      nonBinaryForWoman ||
      nonBinaryForNonBinary;
  }

  static SearchGroups createFrom(Gender gender, GenderSearchSettingsAll genderSearchSetting) {
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
}

extension ClientLocalIdExtensions on ClientLocalId {
  LocalMessageId toLocalMessageId() {
    return LocalMessageId(id);
  }
}

extension UnixTimeExtensions on UnixTime {
  UtcDateTime toUtcDateTime() {
    return UtcDateTime.fromUnixEpochMilliseconds(ut * 1000);
  }

  void addSeconds(int seconds) {
    ut = ut + seconds;
  }
}

extension UtcDateTimeExtensions on UtcDateTime {
  UnixTime toUnixTime() {
    return UnixTime(ut: toUnixEpochMilliseconds() ~/ 1000);
  }
}

extension ContentInfoDetailedExtensions on ContentInfoDetailed {
  bool accepted() {
    return state == ContentModerationState.acceptedByBot ||
      state == ContentModerationState.acceptedByHuman;
  }
}

extension GetProfileFilteringSettingsExtension on GetProfileFilteringSettings {
  List<ProfileAttributeFilterValueUpdate> currentFiltersCopy() {
    return filters.map((e) => ProfileAttributeFilterValueUpdate(
      acceptMissingAttribute: e.acceptMissingAttribute,
      filterValues: [...e.filterValues],
      id: e.id,
    )).toList();
  }
}
