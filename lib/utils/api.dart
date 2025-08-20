import 'package:database/database.dart';
import 'package:latlong2/latlong.dart';
import 'package:openapi/api.dart';
import 'package:app/model/freezed/logic/account/initial_setup.dart';
import 'package:utils/utils.dart';

extension ProfileVisibilityExtensions on ProfileVisibility {
  bool isInitialModerationOngoing() {
    return this == ProfileVisibility.pendingPrivate || this == ProfileVisibility.pendingPublic;
  }

  /// Convert visibility to boolean without the pending state
  bool isPublic() {
    return this == ProfileVisibility.public || this == ProfileVisibility.pendingPublic;
  }
}

extension ProfileAttributeFilterValueUpdateExtensions on ProfileAttributeFilterValueUpdate {
  void updateIsEnabled() {
    enabled = acceptMissingAttribute || wanted.isNotEmpty || unwanted.isNotEmpty;
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

extension GetProfileFiltersExtension on GetProfileFilters {
  Map<int, ProfileAttributeFilterValueUpdate> currentFiltersCopy() {
    final values = attributeFilters.map((e) {
      final convertedValue = ProfileAttributeFilterValueUpdate(
        acceptMissingAttribute: e.acceptMissingAttribute,
        useLogicalOperatorAnd: e.useLogicalOperatorAnd,
        wanted: [...e.wanted],
        unwanted: [...e.unwanted],
        id: e.id,
      );
      convertedValue.updateIsEnabled();
      return convertedValue;
    });
    return {for (var e in values) e.id: e};
  }
}

extension MapCoordinateExtension on MapCoordinate {
  LatLng toLatLng() {
    return LatLng(lat, lon);
  }
}

class AutomaticProfileSearchSettingsDefaults {
  static AutomaticProfileSearchSettings defaultValue = AutomaticProfileSearchSettings(
    distanceFilters: distanceFiltersDefault,
    newProfiles: newProfilesDefault,
    attributeFilters: attributeFiltersDefault,
    weekdays: weekdaysDefault,
  );

  static const bool distanceFiltersDefault = false;
  static const bool newProfilesDefault = false;
  static const bool attributeFiltersDefault = false;
  static const int weekdaysDefault = 0x7F;
}

extension NotificationIdExtension on NotificationId {
  NotificationIdViewed toViewed() {
    return NotificationIdViewed(id: id);
  }
}
