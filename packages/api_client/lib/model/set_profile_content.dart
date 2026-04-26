//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class SetProfileContent {
  /// Returns a new [SetProfileContent] instance.
  SetProfileContent({
    this.content = const [],
    this.gridCropSize = 1.0,
    this.gridCropX = 0.0,
    this.gridCropY = 0.0,
  });

  /// First image is primary profile image which is shown in grid view.  One content ID is required.  Max item count is 6. Extra items are ignored.
  List<ContentId> content;

  double gridCropSize;

  double gridCropX;

  double gridCropY;

  @override
  bool operator ==(Object other) => identical(this, other) || other is SetProfileContent &&
    _deepEquality.equals(other.content, content) &&
    other.gridCropSize == gridCropSize &&
    other.gridCropX == gridCropX &&
    other.gridCropY == gridCropY;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (content.hashCode) +
    (gridCropSize.hashCode) +
    (gridCropX.hashCode) +
    (gridCropY.hashCode);

  @override
  String toString() => 'SetProfileContent[content=$content, gridCropSize=$gridCropSize, gridCropX=$gridCropX, gridCropY=$gridCropY]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'content'] = this.content;
      json[r'grid_crop_size'] = this.gridCropSize;
      json[r'grid_crop_x'] = this.gridCropX;
      json[r'grid_crop_y'] = this.gridCropY;
    return json;
  }

  /// Returns a new [SetProfileContent] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static SetProfileContent? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "SetProfileContent[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "SetProfileContent[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return SetProfileContent(
        content: ContentId.listFromJson(json[r'content']),
        gridCropSize: mapValueOfType<double>(json, r'grid_crop_size') ?? 1.0,
        gridCropX: mapValueOfType<double>(json, r'grid_crop_x') ?? 0.0,
        gridCropY: mapValueOfType<double>(json, r'grid_crop_y') ?? 0.0,
      );
    }
    return null;
  }

  static List<SetProfileContent> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SetProfileContent>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SetProfileContent.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, SetProfileContent> mapFromJson(dynamic json) {
    final map = <String, SetProfileContent>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SetProfileContent.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of SetProfileContent-objects as value to a dart map
  static Map<String, List<SetProfileContent>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<SetProfileContent>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = SetProfileContent.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'content',
  };
}

