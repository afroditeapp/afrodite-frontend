//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class EditVerificationValues {
  /// Returns a new [EditVerificationValues] instance.
  EditVerificationValues({
    this.profileAgeRange,
    this.profileName,
    this.securityContent,
  });

  EditVerificationProfileAgeRange? profileAgeRange;

  EditVerificationProfileName? profileName;

  EditVerificationSecurityContent? securityContent;

  @override
  bool operator ==(Object other) => identical(this, other) || other is EditVerificationValues &&
    other.profileAgeRange == profileAgeRange &&
    other.profileName == profileName &&
    other.securityContent == securityContent;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (profileAgeRange == null ? 0 : profileAgeRange!.hashCode) +
    (profileName == null ? 0 : profileName!.hashCode) +
    (securityContent == null ? 0 : securityContent!.hashCode);

  @override
  String toString() => 'EditVerificationValues[profileAgeRange=$profileAgeRange, profileName=$profileName, securityContent=$securityContent]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.profileAgeRange != null) {
      json[r'profile_age_range'] = this.profileAgeRange;
    } else {
      json[r'profile_age_range'] = null;
    }
    if (this.profileName != null) {
      json[r'profile_name'] = this.profileName;
    } else {
      json[r'profile_name'] = null;
    }
    if (this.securityContent != null) {
      json[r'security_content'] = this.securityContent;
    } else {
      json[r'security_content'] = null;
    }
    return json;
  }

  /// Returns a new [EditVerificationValues] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static EditVerificationValues? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "EditVerificationValues[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "EditVerificationValues[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return EditVerificationValues(
        profileAgeRange: EditVerificationProfileAgeRange.fromJson(json[r'profile_age_range']),
        profileName: EditVerificationProfileName.fromJson(json[r'profile_name']),
        securityContent: EditVerificationSecurityContent.fromJson(json[r'security_content']),
      );
    }
    return null;
  }

  static List<EditVerificationValues> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <EditVerificationValues>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = EditVerificationValues.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, EditVerificationValues> mapFromJson(dynamic json) {
    final map = <String, EditVerificationValues>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = EditVerificationValues.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of EditVerificationValues-objects as value to a dart map
  static Map<String, List<EditVerificationValues>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<EditVerificationValues>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = EditVerificationValues.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

