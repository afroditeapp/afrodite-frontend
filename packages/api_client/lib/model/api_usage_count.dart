//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ApiUsageCount {
  /// Returns a new [ApiUsageCount] instance.
  ApiUsageCount({
    required this.c,
    required this.t,
  });

  int c;

  UnixTime t;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ApiUsageCount &&
    other.c == c &&
    other.t == t;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (c.hashCode) +
    (t.hashCode);

  @override
  String toString() => 'ApiUsageCount[c=$c, t=$t]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'c'] = this.c;
      json[r't'] = this.t;
    return json;
  }

  /// Returns a new [ApiUsageCount] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ApiUsageCount? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ApiUsageCount[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ApiUsageCount[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ApiUsageCount(
        c: mapValueOfType<int>(json, r'c')!,
        t: UnixTime.fromJson(json[r't'])!,
      );
    }
    return null;
  }

  static List<ApiUsageCount> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ApiUsageCount>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ApiUsageCount.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ApiUsageCount> mapFromJson(dynamic json) {
    final map = <String, ApiUsageCount>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ApiUsageCount.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ApiUsageCount-objects as value to a dart map
  static Map<String, List<ApiUsageCount>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ApiUsageCount>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ApiUsageCount.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'c',
    't',
  };
}

