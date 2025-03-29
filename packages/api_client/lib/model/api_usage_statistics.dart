//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ApiUsageStatistics {
  /// Returns a new [ApiUsageStatistics] instance.
  ApiUsageStatistics({
    required this.name,
    this.values = const [],
  });

  String name;

  List<ApiUsageCount> values;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ApiUsageStatistics &&
    other.name == name &&
    _deepEquality.equals(other.values, values);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (name.hashCode) +
    (values.hashCode);

  @override
  String toString() => 'ApiUsageStatistics[name=$name, values=$values]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'name'] = this.name;
      json[r'values'] = this.values;
    return json;
  }

  /// Returns a new [ApiUsageStatistics] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ApiUsageStatistics? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ApiUsageStatistics[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ApiUsageStatistics[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ApiUsageStatistics(
        name: mapValueOfType<String>(json, r'name')!,
        values: ApiUsageCount.listFromJson(json[r'values']),
      );
    }
    return null;
  }

  static List<ApiUsageStatistics> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ApiUsageStatistics>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ApiUsageStatistics.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ApiUsageStatistics> mapFromJson(dynamic json) {
    final map = <String, ApiUsageStatistics>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ApiUsageStatistics.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ApiUsageStatistics-objects as value to a dart map
  static Map<String, List<ApiUsageStatistics>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ApiUsageStatistics>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ApiUsageStatistics.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'name',
    'values',
  };
}

