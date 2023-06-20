//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ImageAccessCheck {
  /// Returns a new [ImageAccessCheck] instance.
  ImageAccessCheck({
    required this.isMatch,
  });

  /// If false image access is allowed when profile is set as public. If true image access is allowed when users are a match.
  bool isMatch;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ImageAccessCheck &&
     other.isMatch == isMatch;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (isMatch.hashCode);

  @override
  String toString() => 'ImageAccessCheck[isMatch=$isMatch]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'is_match'] = this.isMatch;
    return json;
  }

  /// Returns a new [ImageAccessCheck] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ImageAccessCheck? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ImageAccessCheck[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ImageAccessCheck[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ImageAccessCheck(
        isMatch: mapValueOfType<bool>(json, r'is_match')!,
      );
    }
    return null;
  }

  static List<ImageAccessCheck>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ImageAccessCheck>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ImageAccessCheck.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ImageAccessCheck> mapFromJson(dynamic json) {
    final map = <String, ImageAccessCheck>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ImageAccessCheck.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ImageAccessCheck-objects as value to a dart map
  static Map<String, List<ImageAccessCheck>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ImageAccessCheck>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ImageAccessCheck.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'is_match',
  };
}

