//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class SystemInfoList {
  /// Returns a new [SystemInfoList] instance.
  SystemInfoList({
    this.info = const [],
  });

  List<SystemInfo> info;

  @override
  bool operator ==(Object other) => identical(this, other) || other is SystemInfoList &&
    _deepEquality.equals(other.info, info);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (info.hashCode);

  @override
  String toString() => 'SystemInfoList[info=$info]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'info'] = this.info;
    return json;
  }

  /// Returns a new [SystemInfoList] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static SystemInfoList? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "SystemInfoList[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "SystemInfoList[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return SystemInfoList(
        info: SystemInfo.listFromJson(json[r'info']),
      );
    }
    return null;
  }

  static List<SystemInfoList> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SystemInfoList>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SystemInfoList.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, SystemInfoList> mapFromJson(dynamic json) {
    final map = <String, SystemInfoList>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SystemInfoList.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of SystemInfoList-objects as value to a dart map
  static Map<String, List<SystemInfoList>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<SystemInfoList>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = SystemInfoList.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'info',
  };
}

