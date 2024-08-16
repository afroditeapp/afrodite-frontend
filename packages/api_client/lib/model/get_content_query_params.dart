//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class GetContentQueryParams {
  /// Returns a new [GetContentQueryParams] instance.
  GetContentQueryParams({
    this.isMatch,
  });

  /// If false media content access is allowed when profile is set as public. If true media content access is allowed when users are a match.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? isMatch;

  @override
  bool operator ==(Object other) => identical(this, other) || other is GetContentQueryParams &&
    other.isMatch == isMatch;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (isMatch == null ? 0 : isMatch!.hashCode);

  @override
  String toString() => 'GetContentQueryParams[isMatch=$isMatch]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.isMatch != null) {
      json[r'is_match'] = this.isMatch;
    } else {
      json[r'is_match'] = null;
    }
    return json;
  }

  /// Returns a new [GetContentQueryParams] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static GetContentQueryParams? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "GetContentQueryParams[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "GetContentQueryParams[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return GetContentQueryParams(
        isMatch: mapValueOfType<bool>(json, r'is_match'),
      );
    }
    return null;
  }

  static List<GetContentQueryParams> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <GetContentQueryParams>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = GetContentQueryParams.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, GetContentQueryParams> mapFromJson(dynamic json) {
    final map = <String, GetContentQueryParams>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = GetContentQueryParams.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of GetContentQueryParams-objects as value to a dart map
  static Map<String, List<GetContentQueryParams>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<GetContentQueryParams>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = GetContentQueryParams.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

