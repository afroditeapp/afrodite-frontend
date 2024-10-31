

import 'package:database/database.dart';
import 'package:openapi/api.dart';
import 'package:app/model/freezed/logic/account/initial_setup.dart';
import 'package:app/utils/list.dart';
import 'package:utils/utils.dart';

extension ModerationExtensions on Moderation {
  List<ContentId> contentList() {
    final l = [
      content.c0,
    ];
    _addNotNull(l, content.c1);
    _addNotNull(l, content.c2);
    _addNotNull(l, content.c3);
    _addNotNull(l, content.c4);
    _addNotNull(l, content.c5);
    _addNotNull(l, content.c6);
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
      content.c0,
    ];
    _addNotNull(l, content.c1);
    _addNotNull(l, content.c2);
    _addNotNull(l, content.c3);
    _addNotNull(l, content.c4);
    _addNotNull(l, content.c5);
    _addNotNull(l, content.c6);
    return l;
  }
}

extension ModerationRequestContentExtensions on ModerationRequestContent {
  static ModerationRequestContent? fromList(List<ContentId> content) {
    if (content.isEmpty) {
      return null;
    }
    return ModerationRequestContent(
      c0: content[0],
      c1: content.getAtOrNull(1),
      c2: content.getAtOrNull(2),
      c3: content.getAtOrNull(3),
      c4: content.getAtOrNull(4),
      c5: content.getAtOrNull(5),
      c6: content.getAtOrNull(6),
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

extension ClientLocalIdExtensions on ClientLocalId {
  LocalMessageId toLocalMessageId() {
    return LocalMessageId(id);
  }
}

extension UnixTimeExtensions on UnixTime {
  UtcDateTime toUtcDateTime() {
    return UtcDateTime.fromUnixEpochMilliseconds(ut * 1000);
  }
}
