//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PrimaryImage {
  /// Returns a new [PrimaryImage] instance.
  PrimaryImage({
    this.contentId,
    required this.gridCropSize,
    required this.gridCropX,
    required this.gridCropY,
  });

  ContentId? contentId;

  double gridCropSize;

  double gridCropX;

  double gridCropY;

  @override
  bool operator ==(Object other) => identical(this, other) || other is PrimaryImage &&
     other.contentId == contentId &&
     other.gridCropSize == gridCropSize &&
     other.gridCropX == gridCropX &&
     other.gridCropY == gridCropY;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (contentId == null ? 0 : contentId!.hashCode) +
    (gridCropSize.hashCode) +
    (gridCropX.hashCode) +
    (gridCropY.hashCode);

  @override
  String toString() => 'PrimaryImage[contentId=$contentId, gridCropSize=$gridCropSize, gridCropX=$gridCropX, gridCropY=$gridCropY]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.contentId != null) {
      json[r'content_id'] = this.contentId;
    } else {
      json[r'content_id'] = null;
    }
      json[r'grid_crop_size'] = this.gridCropSize;
      json[r'grid_crop_x'] = this.gridCropX;
      json[r'grid_crop_y'] = this.gridCropY;
    return json;
  }

  /// Returns a new [PrimaryImage] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PrimaryImage? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "PrimaryImage[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "PrimaryImage[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return PrimaryImage(
        contentId: ContentId.fromJson(json[r'content_id']),
        gridCropSize: mapValueOfType<double>(json, r'grid_crop_size')!,
        gridCropX: mapValueOfType<double>(json, r'grid_crop_x')!,
        gridCropY: mapValueOfType<double>(json, r'grid_crop_y')!,
      );
    }
    return null;
  }

  static List<PrimaryImage>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PrimaryImage>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PrimaryImage.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PrimaryImage> mapFromJson(dynamic json) {
    final map = <String, PrimaryImage>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PrimaryImage.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PrimaryImage-objects as value to a dart map
  static Map<String, List<PrimaryImage>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<PrimaryImage>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PrimaryImage.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'grid_crop_size',
    'grid_crop_x',
    'grid_crop_y',
  };
}

