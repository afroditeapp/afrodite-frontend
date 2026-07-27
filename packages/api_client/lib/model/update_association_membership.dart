//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class UpdateAssociationMembership {
  /// Returns a new [UpdateAssociationMembership] instance.
  UpdateAssociationMembership({
    this.domicile,
    this.fullName,
    required this.membershipType,
  });

  /// A string wrapper that ensures the string is not empty. This type is used for TEXT columns that should not allow empty strings. In the database, these columns are NULL when there is no value, and this type represents non-NULL values that must be non-empty.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? domicile;

  /// A string wrapper that ensures the string is not empty. This type is used for TEXT columns that should not allow empty strings. In the database, these columns are NULL when there is no value, and this type represents non-NULL values that must be non-empty.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? fullName;

  int membershipType;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UpdateAssociationMembership &&
    other.domicile == domicile &&
    other.fullName == fullName &&
    other.membershipType == membershipType;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (domicile == null ? 0 : domicile!.hashCode) +
    (fullName == null ? 0 : fullName!.hashCode) +
    (membershipType.hashCode);

  @override
  String toString() => 'UpdateAssociationMembership[domicile=$domicile, fullName=$fullName, membershipType=$membershipType]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.domicile != null) {
      json[r'domicile'] = this.domicile;
    } else {
      json[r'domicile'] = null;
    }
    if (this.fullName != null) {
      json[r'full_name'] = this.fullName;
    } else {
      json[r'full_name'] = null;
    }
      json[r'membership_type'] = this.membershipType;
    return json;
  }

  /// Returns a new [UpdateAssociationMembership] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UpdateAssociationMembership? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "UpdateAssociationMembership[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "UpdateAssociationMembership[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return UpdateAssociationMembership(
        domicile: mapValueOfType<String>(json, r'domicile'),
        fullName: mapValueOfType<String>(json, r'full_name'),
        membershipType: mapValueOfType<int>(json, r'membership_type')!,
      );
    }
    return null;
  }

  static List<UpdateAssociationMembership> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UpdateAssociationMembership>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UpdateAssociationMembership.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UpdateAssociationMembership> mapFromJson(dynamic json) {
    final map = <String, UpdateAssociationMembership>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UpdateAssociationMembership.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UpdateAssociationMembership-objects as value to a dart map
  static Map<String, List<UpdateAssociationMembership>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<UpdateAssociationMembership>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = UpdateAssociationMembership.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'membership_type',
  };
}

