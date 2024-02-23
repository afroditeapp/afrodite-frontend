//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ContentAccessCheck {
  /// Returns a new [ContentAccessCheck] instance.
  ContentAccessCheck({
    required this.isMatch,
  });

  /// If false media content access is allowed when profile is set as public. If true media content access is allowed when users are a match.
  bool isMatch;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ContentAccessCheck &&
     other.isMatch == isMatch;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (isMatch.hashCode);

  @override
  String toString() => 'ContentAccessCheck[isMatch=$isMatch]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'is_match'] = this.isMatch;
    return json;
  }

  /// Returns a new [ContentAccessCheck] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ContentAccessCheck? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ContentAccessCheck[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ContentAccessCheck[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ContentAccessCheck(
        isMatch: mapValueOfType<bool>(json, r'is_match')!,
      );
    }
    return null;
  }

  static List<ContentAccessCheck>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ContentAccessCheck>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ContentAccessCheck.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ContentAccessCheck> mapFromJson(dynamic json) {
    final map = <String, ContentAccessCheck>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ContentAccessCheck.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ContentAccessCheck-objects as value to a dart map
  static Map<String, List<ContentAccessCheck>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ContentAccessCheck>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ContentAccessCheck.listFromJson(entry.value, growable: growable,);
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

