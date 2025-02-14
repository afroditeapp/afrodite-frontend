//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class GetProfileReportList {
  /// Returns a new [GetProfileReportList] instance.
  GetProfileReportList({
    this.values = const [],
  });

  List<ProfileReportDetailed> values;

  @override
  bool operator ==(Object other) => identical(this, other) || other is GetProfileReportList &&
    _deepEquality.equals(other.values, values);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (values.hashCode);

  @override
  String toString() => 'GetProfileReportList[values=$values]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'values'] = this.values;
    return json;
  }

  /// Returns a new [GetProfileReportList] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static GetProfileReportList? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "GetProfileReportList[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "GetProfileReportList[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return GetProfileReportList(
        values: ProfileReportDetailed.listFromJson(json[r'values']),
      );
    }
    return null;
  }

  static List<GetProfileReportList> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <GetProfileReportList>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = GetProfileReportList.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, GetProfileReportList> mapFromJson(dynamic json) {
    final map = <String, GetProfileReportList>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = GetProfileReportList.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of GetProfileReportList-objects as value to a dart map
  static Map<String, List<GetProfileReportList>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<GetProfileReportList>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = GetProfileReportList.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'values',
  };
}

