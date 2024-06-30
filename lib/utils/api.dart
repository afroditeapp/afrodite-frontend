

import 'package:openapi/api.dart';
import 'package:pihka_frontend/model/freezed/logic/account/initial_setup.dart';
import 'package:pihka_frontend/utils/list.dart';

extension ModerationExtensions on Moderation {
  List<ContentId> contentList() {
    final l = [
      content.content0,
    ];
    _addNotNull(l, content.content1);
    _addNotNull(l, content.content2);
    _addNotNull(l, content.content3);
    _addNotNull(l, content.content4);
    _addNotNull(l, content.content5);
    _addNotNull(l, content.content6);
    return l;
  }
}

void _addNotNull<T>(List<T> l, T? e) {
  if (e != null) l.add(e);
}

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

extension ModerationRequestStateExtensions on ModerationRequest {
  bool isOngoing() {
    return state == ModerationRequestState.waiting ||
      state == ModerationRequestState.inProgress;
  }

  List<ContentId> contentList() {
    final l = [
      content.content0,
    ];
    _addNotNull(l, content.content1);
    _addNotNull(l, content.content2);
    _addNotNull(l, content.content3);
    _addNotNull(l, content.content4);
    _addNotNull(l, content.content5);
    _addNotNull(l, content.content6);
    return l;
  }
}

extension ModerationRequestContentExtensions on ModerationRequestContent {
  static ModerationRequestContent? fromList(List<ContentId> content) {
    if (content.isEmpty) {
      return null;
    }
    return ModerationRequestContent(
      content0: content[0],
      content1: content.getAtOrNull(1),
      content2: content.getAtOrNull(2),
      content3: content.getAtOrNull(3),
      content4: content.getAtOrNull(4),
      content5: content.getAtOrNull(5),
      content6: content.getAtOrNull(6),
    );
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
}

extension ProfileAttributeValueUpdateExtensions on ProfileAttributeValueUpdate {
  void setBitflagValue(int value) {
    values = [value];
  }

  int? bitflagValue() {
    return values.firstOrNull;
  }

  int? firstValue() {
    return values.firstOrNull;
  }

  int? secondValue() {
    return values.getAtOrNull(1);
  }
}

extension ProfileAttributeValueExtensions on ProfileAttributeValue {
  int? firstValue() {
    return values.firstOrNull;
  }

  int? secondValue() {
    return values.getAtOrNull(1);
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

extension CapabilitiesExtensions on Capabilities {
  bool adminSettingsVisible() {
    // TODO(prod): Add missing capabilities once
    // capability properies are non-nullable
    return adminModerateImages;
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
