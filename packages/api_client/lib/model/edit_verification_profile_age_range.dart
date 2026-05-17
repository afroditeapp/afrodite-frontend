//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class EditVerificationProfileAgeRange {
  /// Returns a new [EditVerificationProfileAgeRange] instance.
  EditVerificationProfileAgeRange({
    required this.currentProfileAge,
    this.verifiedValue,
  });

  int currentProfileAge;

  bool? verifiedValue;

  @override
  bool operator ==(Object other) => identical(this, other) || other is EditVerificationProfileAgeRange &&
    other.currentProfileAge == currentProfileAge &&
    other.verifiedValue == verifiedValue;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (currentProfileAge.hashCode) +
    (verifiedValue == null ? 0 : verifiedValue!.hashCode);

  @override
  String toString() => 'EditVerificationProfileAgeRange[currentProfileAge=$currentProfileAge, verifiedValue=$verifiedValue]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'current_profile_age'] = this.currentProfileAge;
    if (this.verifiedValue != null) {
      json[r'verified_value'] = this.verifiedValue;
    } else {
      json[r'verified_value'] = null;
    }
    return json;
  }

  /// Returns a new [EditVerificationProfileAgeRange] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static EditVerificationProfileAgeRange? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "EditVerificationProfileAgeRange[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "EditVerificationProfileAgeRange[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return EditVerificationProfileAgeRange(
        currentProfileAge: mapValueOfType<int>(json, r'current_profile_age')!,
        verifiedValue: mapValueOfType<bool>(json, r'verified_value'),
      );
    }
    return null;
  }

  static List<EditVerificationProfileAgeRange> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <EditVerificationProfileAgeRange>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = EditVerificationProfileAgeRange.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, EditVerificationProfileAgeRange> mapFromJson(dynamic json) {
    final map = <String, EditVerificationProfileAgeRange>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = EditVerificationProfileAgeRange.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of EditVerificationProfileAgeRange-objects as value to a dart map
  static Map<String, List<EditVerificationProfileAgeRange>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<EditVerificationProfileAgeRange>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = EditVerificationProfileAgeRange.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'current_profile_age',
  };
}

