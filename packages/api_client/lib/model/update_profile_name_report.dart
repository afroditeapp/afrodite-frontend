//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class UpdateProfileNameReport {
  /// Returns a new [UpdateProfileNameReport] instance.
  UpdateProfileNameReport({
    required this.profileName,
    required this.target,
  });

  /// A string wrapper that ensures the string is not empty. This type is used for TEXT columns that should not allow empty strings. In the database, these columns are NULL when there is no value, and this type represents non-NULL values that must be non-empty.
  String profileName;

  AccountId target;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UpdateProfileNameReport &&
    other.profileName == profileName &&
    other.target == target;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (profileName.hashCode) +
    (target.hashCode);

  @override
  String toString() => 'UpdateProfileNameReport[profileName=$profileName, target=$target]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'profile_name'] = this.profileName;
      json[r'target'] = this.target;
    return json;
  }

  /// Returns a new [UpdateProfileNameReport] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UpdateProfileNameReport? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "UpdateProfileNameReport[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "UpdateProfileNameReport[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return UpdateProfileNameReport(
        profileName: mapValueOfType<String>(json, r'profile_name')!,
        target: AccountId.fromJson(json[r'target'])!,
      );
    }
    return null;
  }

  static List<UpdateProfileNameReport> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UpdateProfileNameReport>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UpdateProfileNameReport.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UpdateProfileNameReport> mapFromJson(dynamic json) {
    final map = <String, UpdateProfileNameReport>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UpdateProfileNameReport.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UpdateProfileNameReport-objects as value to a dart map
  static Map<String, List<UpdateProfileNameReport>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<UpdateProfileNameReport>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = UpdateProfileNameReport.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'profile_name',
    'target',
  };
}

