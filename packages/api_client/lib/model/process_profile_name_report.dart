//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProcessProfileNameReport {
  /// Returns a new [ProcessProfileNameReport] instance.
  ProcessProfileNameReport({
    required this.creator,
    required this.profileName,
    required this.target,
  });

  AccountId creator;

  String profileName;

  AccountId target;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProcessProfileNameReport &&
    other.creator == creator &&
    other.profileName == profileName &&
    other.target == target;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (creator.hashCode) +
    (profileName.hashCode) +
    (target.hashCode);

  @override
  String toString() => 'ProcessProfileNameReport[creator=$creator, profileName=$profileName, target=$target]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'creator'] = this.creator;
      json[r'profile_name'] = this.profileName;
      json[r'target'] = this.target;
    return json;
  }

  /// Returns a new [ProcessProfileNameReport] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProcessProfileNameReport? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ProcessProfileNameReport[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ProcessProfileNameReport[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ProcessProfileNameReport(
        creator: AccountId.fromJson(json[r'creator'])!,
        profileName: mapValueOfType<String>(json, r'profile_name')!,
        target: AccountId.fromJson(json[r'target'])!,
      );
    }
    return null;
  }

  static List<ProcessProfileNameReport> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProcessProfileNameReport>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProcessProfileNameReport.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProcessProfileNameReport> mapFromJson(dynamic json) {
    final map = <String, ProcessProfileNameReport>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProcessProfileNameReport.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProcessProfileNameReport-objects as value to a dart map
  static Map<String, List<ProcessProfileNameReport>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ProcessProfileNameReport>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ProcessProfileNameReport.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'creator',
    'profile_name',
    'target',
  };
}

