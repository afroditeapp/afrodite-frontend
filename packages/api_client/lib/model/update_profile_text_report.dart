//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class UpdateProfileTextReport {
  /// Returns a new [UpdateProfileTextReport] instance.
  UpdateProfileTextReport({
    required this.profileText,
    required this.target,
  });

  /// A string wrapper that ensures the string is not empty. This type is used for TEXT columns that should not allow empty strings. In the database, these columns are NULL when there is no value, and this type represents non-NULL values that must be non-empty.
  String profileText;

  AccountId target;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UpdateProfileTextReport &&
    other.profileText == profileText &&
    other.target == target;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (profileText.hashCode) +
    (target.hashCode);

  @override
  String toString() => 'UpdateProfileTextReport[profileText=$profileText, target=$target]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'profile_text'] = this.profileText;
      json[r'target'] = this.target;
    return json;
  }

  /// Returns a new [UpdateProfileTextReport] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UpdateProfileTextReport? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "UpdateProfileTextReport[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "UpdateProfileTextReport[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return UpdateProfileTextReport(
        profileText: mapValueOfType<String>(json, r'profile_text')!,
        target: AccountId.fromJson(json[r'target'])!,
      );
    }
    return null;
  }

  static List<UpdateProfileTextReport> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UpdateProfileTextReport>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UpdateProfileTextReport.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UpdateProfileTextReport> mapFromJson(dynamic json) {
    final map = <String, UpdateProfileTextReport>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UpdateProfileTextReport.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UpdateProfileTextReport-objects as value to a dart map
  static Map<String, List<UpdateProfileTextReport>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<UpdateProfileTextReport>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = UpdateProfileTextReport.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'profile_text',
    'target',
  };
}

