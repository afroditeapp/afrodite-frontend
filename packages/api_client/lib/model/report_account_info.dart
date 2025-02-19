//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ReportAccountInfo {
  /// Returns a new [ReportAccountInfo] instance.
  ReportAccountInfo({
    required this.age,
    required this.name,
  });

  int age;

  String name;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ReportAccountInfo &&
    other.age == age &&
    other.name == name;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (age.hashCode) +
    (name.hashCode);

  @override
  String toString() => 'ReportAccountInfo[age=$age, name=$name]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'age'] = this.age;
      json[r'name'] = this.name;
    return json;
  }

  /// Returns a new [ReportAccountInfo] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ReportAccountInfo? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ReportAccountInfo[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ReportAccountInfo[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ReportAccountInfo(
        age: mapValueOfType<int>(json, r'age')!,
        name: mapValueOfType<String>(json, r'name')!,
      );
    }
    return null;
  }

  static List<ReportAccountInfo> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ReportAccountInfo>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ReportAccountInfo.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ReportAccountInfo> mapFromJson(dynamic json) {
    final map = <String, ReportAccountInfo>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ReportAccountInfo.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ReportAccountInfo-objects as value to a dart map
  static Map<String, List<ReportAccountInfo>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ReportAccountInfo>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ReportAccountInfo.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'age',
    'name',
  };
}

