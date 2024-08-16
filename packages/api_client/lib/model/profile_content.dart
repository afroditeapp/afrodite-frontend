//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProfileContent {
  /// Returns a new [ProfileContent] instance.
  ProfileContent({
    this.contentId0,
    this.contentId1,
    this.contentId2,
    this.contentId3,
    this.contentId4,
    this.contentId5,
    this.gridCropSize,
    this.gridCropX,
    this.gridCropY,
  });

  ContentInfo? contentId0;

  ContentInfo? contentId1;

  ContentInfo? contentId2;

  ContentInfo? contentId3;

  ContentInfo? contentId4;

  ContentInfo? contentId5;

  double? gridCropSize;

  double? gridCropX;

  double? gridCropY;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProfileContent &&
    other.contentId0 == contentId0 &&
    other.contentId1 == contentId1 &&
    other.contentId2 == contentId2 &&
    other.contentId3 == contentId3 &&
    other.contentId4 == contentId4 &&
    other.contentId5 == contentId5 &&
    other.gridCropSize == gridCropSize &&
    other.gridCropX == gridCropX &&
    other.gridCropY == gridCropY;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (contentId0 == null ? 0 : contentId0!.hashCode) +
    (contentId1 == null ? 0 : contentId1!.hashCode) +
    (contentId2 == null ? 0 : contentId2!.hashCode) +
    (contentId3 == null ? 0 : contentId3!.hashCode) +
    (contentId4 == null ? 0 : contentId4!.hashCode) +
    (contentId5 == null ? 0 : contentId5!.hashCode) +
    (gridCropSize == null ? 0 : gridCropSize!.hashCode) +
    (gridCropX == null ? 0 : gridCropX!.hashCode) +
    (gridCropY == null ? 0 : gridCropY!.hashCode);

  @override
  String toString() => 'ProfileContent[contentId0=$contentId0, contentId1=$contentId1, contentId2=$contentId2, contentId3=$contentId3, contentId4=$contentId4, contentId5=$contentId5, gridCropSize=$gridCropSize, gridCropX=$gridCropX, gridCropY=$gridCropY]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.contentId0 != null) {
      json[r'content_id_0'] = this.contentId0;
    } else {
      json[r'content_id_0'] = null;
    }
    if (this.contentId1 != null) {
      json[r'content_id_1'] = this.contentId1;
    } else {
      json[r'content_id_1'] = null;
    }
    if (this.contentId2 != null) {
      json[r'content_id_2'] = this.contentId2;
    } else {
      json[r'content_id_2'] = null;
    }
    if (this.contentId3 != null) {
      json[r'content_id_3'] = this.contentId3;
    } else {
      json[r'content_id_3'] = null;
    }
    if (this.contentId4 != null) {
      json[r'content_id_4'] = this.contentId4;
    } else {
      json[r'content_id_4'] = null;
    }
    if (this.contentId5 != null) {
      json[r'content_id_5'] = this.contentId5;
    } else {
      json[r'content_id_5'] = null;
    }
    if (this.gridCropSize != null) {
      json[r'grid_crop_size'] = this.gridCropSize;
    } else {
      json[r'grid_crop_size'] = null;
    }
    if (this.gridCropX != null) {
      json[r'grid_crop_x'] = this.gridCropX;
    } else {
      json[r'grid_crop_x'] = null;
    }
    if (this.gridCropY != null) {
      json[r'grid_crop_y'] = this.gridCropY;
    } else {
      json[r'grid_crop_y'] = null;
    }
    return json;
  }

  /// Returns a new [ProfileContent] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProfileContent? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ProfileContent[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ProfileContent[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ProfileContent(
        contentId0: ContentInfo.fromJson(json[r'content_id_0']),
        contentId1: ContentInfo.fromJson(json[r'content_id_1']),
        contentId2: ContentInfo.fromJson(json[r'content_id_2']),
        contentId3: ContentInfo.fromJson(json[r'content_id_3']),
        contentId4: ContentInfo.fromJson(json[r'content_id_4']),
        contentId5: ContentInfo.fromJson(json[r'content_id_5']),
        gridCropSize: mapValueOfType<double>(json, r'grid_crop_size'),
        gridCropX: mapValueOfType<double>(json, r'grid_crop_x'),
        gridCropY: mapValueOfType<double>(json, r'grid_crop_y'),
      );
    }
    return null;
  }

  static List<ProfileContent> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProfileContent>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProfileContent.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProfileContent> mapFromJson(dynamic json) {
    final map = <String, ProfileContent>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProfileContent.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProfileContent-objects as value to a dart map
  static Map<String, List<ProfileContent>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ProfileContent>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ProfileContent.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

