//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class EditVerificationProfileName {
  /// Returns a new [EditVerificationProfileName] instance.
  EditVerificationProfileName({
    this.currentProfileName,
    this.verifiedValue,
  });

  /// A string wrapper that ensures the string is not empty. This type is used for TEXT columns that should not allow empty strings. In the database, these columns are NULL when there is no value, and this type represents non-NULL values that must be non-empty.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? currentProfileName;

  bool? verifiedValue;

  @override
  bool operator ==(Object other) => identical(this, other) || other is EditVerificationProfileName &&
    other.currentProfileName == currentProfileName &&
    other.verifiedValue == verifiedValue;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (currentProfileName == null ? 0 : currentProfileName!.hashCode) +
    (verifiedValue == null ? 0 : verifiedValue!.hashCode);

  @override
  String toString() => 'EditVerificationProfileName[currentProfileName=$currentProfileName, verifiedValue=$verifiedValue]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.currentProfileName != null) {
      json[r'current_profile_name'] = this.currentProfileName;
    } else {
      json[r'current_profile_name'] = null;
    }
    if (this.verifiedValue != null) {
      json[r'verified_value'] = this.verifiedValue;
    } else {
      json[r'verified_value'] = null;
    }
    return json;
  }

  /// Returns a new [EditVerificationProfileName] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static EditVerificationProfileName? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "EditVerificationProfileName[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "EditVerificationProfileName[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return EditVerificationProfileName(
        currentProfileName: mapValueOfType<String>(json, r'current_profile_name'),
        verifiedValue: mapValueOfType<bool>(json, r'verified_value'),
      );
    }
    return null;
  }

  static List<EditVerificationProfileName> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <EditVerificationProfileName>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = EditVerificationProfileName.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, EditVerificationProfileName> mapFromJson(dynamic json) {
    final map = <String, EditVerificationProfileName>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = EditVerificationProfileName.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of EditVerificationProfileName-objects as value to a dart map
  static Map<String, List<EditVerificationProfileName>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<EditVerificationProfileName>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = EditVerificationProfileName.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

