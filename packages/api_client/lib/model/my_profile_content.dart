//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class MyProfileContent {
  /// Returns a new [MyProfileContent] instance.
  MyProfileContent({
    this.content = const [],
    this.gridCropSize,
    this.gridCropX,
    this.gridCropY,
    required this.verificationStatus,
  });

  /// First image is primary profile image which is shown in grid view.
  List<MyContentInfo> content;

  double? gridCropSize;

  double? gridCropX;

  double? gridCropY;

  MediaVerificationStatus verificationStatus;

  @override
  bool operator ==(Object other) => identical(this, other) || other is MyProfileContent &&
    _deepEquality.equals(other.content, content) &&
    other.gridCropSize == gridCropSize &&
    other.gridCropX == gridCropX &&
    other.gridCropY == gridCropY &&
    other.verificationStatus == verificationStatus;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (content.hashCode) +
    (gridCropSize == null ? 0 : gridCropSize!.hashCode) +
    (gridCropX == null ? 0 : gridCropX!.hashCode) +
    (gridCropY == null ? 0 : gridCropY!.hashCode) +
    (verificationStatus.hashCode);

  @override
  String toString() => 'MyProfileContent[content=$content, gridCropSize=$gridCropSize, gridCropX=$gridCropX, gridCropY=$gridCropY, verificationStatus=$verificationStatus]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'content'] = this.content;
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
      json[r'verification_status'] = this.verificationStatus;
    return json;
  }

  /// Returns a new [MyProfileContent] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static MyProfileContent? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "MyProfileContent[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "MyProfileContent[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return MyProfileContent(
        content: MyContentInfo.listFromJson(json[r'content']),
        gridCropSize: mapValueOfType<double>(json, r'grid_crop_size'),
        gridCropX: mapValueOfType<double>(json, r'grid_crop_x'),
        gridCropY: mapValueOfType<double>(json, r'grid_crop_y'),
        verificationStatus: MediaVerificationStatus.fromJson(json[r'verification_status'])!,
      );
    }
    return null;
  }

  static List<MyProfileContent> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <MyProfileContent>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MyProfileContent.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, MyProfileContent> mapFromJson(dynamic json) {
    final map = <String, MyProfileContent>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = MyProfileContent.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of MyProfileContent-objects as value to a dart map
  static Map<String, List<MyProfileContent>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<MyProfileContent>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = MyProfileContent.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'content',
    'verification_status',
  };
}

