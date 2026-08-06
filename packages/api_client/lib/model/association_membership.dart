//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AssociationMembership {
  /// Returns a new [AssociationMembership] instance.
  AssociationMembership({
    required this.creationUnixTime,
    this.domicile,
    required this.editUnixTime,
    this.fullName,
    required this.membershipType,
  });

  UnixTime creationUnixTime;

  /// A string wrapper that ensures the string is not empty. This type is used for TEXT columns that should not allow empty strings. In the database, these columns are NULL when there is no value, and this type represents non-NULL values that must be non-empty.
  String? domicile;

  UnixTime editUnixTime;

  /// A string wrapper that ensures the string is not empty. This type is used for TEXT columns that should not allow empty strings. In the database, these columns are NULL when there is no value, and this type represents non-NULL values that must be non-empty.
  String? fullName;

  int membershipType;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AssociationMembership &&
    other.creationUnixTime == creationUnixTime &&
    other.domicile == domicile &&
    other.editUnixTime == editUnixTime &&
    other.fullName == fullName &&
    other.membershipType == membershipType;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (creationUnixTime.hashCode) +
    (domicile == null ? 0 : domicile!.hashCode) +
    (editUnixTime.hashCode) +
    (fullName == null ? 0 : fullName!.hashCode) +
    (membershipType.hashCode);

  @override
  String toString() => 'AssociationMembership[creationUnixTime=$creationUnixTime, domicile=$domicile, editUnixTime=$editUnixTime, fullName=$fullName, membershipType=$membershipType]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'creation_unix_time'] = this.creationUnixTime;
    if (this.domicile != null) {
      json[r'domicile'] = this.domicile;
    } else {
      json[r'domicile'] = null;
    }
      json[r'edit_unix_time'] = this.editUnixTime;
    if (this.fullName != null) {
      json[r'full_name'] = this.fullName;
    } else {
      json[r'full_name'] = null;
    }
      json[r'membership_type'] = this.membershipType;
    return json;
  }

  /// Returns a new [AssociationMembership] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AssociationMembership? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'creation_unix_time'), 'Required key "AssociationMembership[creation_unix_time]" is missing from JSON.');
        assert(json[r'creation_unix_time'] != null, 'Required key "AssociationMembership[creation_unix_time]" has a null value in JSON.');
        assert(json.containsKey(r'edit_unix_time'), 'Required key "AssociationMembership[edit_unix_time]" is missing from JSON.');
        assert(json[r'edit_unix_time'] != null, 'Required key "AssociationMembership[edit_unix_time]" has a null value in JSON.');
        assert(json.containsKey(r'membership_type'), 'Required key "AssociationMembership[membership_type]" is missing from JSON.');
        assert(json[r'membership_type'] != null, 'Required key "AssociationMembership[membership_type]" has a null value in JSON.');
        return true;
      }());

      return AssociationMembership(
        creationUnixTime: UnixTime.fromJson(json[r'creation_unix_time'])!,
        domicile: mapValueOfType<String>(json, r'domicile'),
        editUnixTime: UnixTime.fromJson(json[r'edit_unix_time'])!,
        fullName: mapValueOfType<String>(json, r'full_name'),
        membershipType: mapValueOfType<int>(json, r'membership_type')!,
      );
    }
    return null;
  }

  static List<AssociationMembership> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AssociationMembership>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AssociationMembership.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AssociationMembership> mapFromJson(dynamic json) {
    final map = <String, AssociationMembership>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AssociationMembership.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AssociationMembership-objects as value to a dart map
  static Map<String, List<AssociationMembership>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AssociationMembership>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AssociationMembership.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'creation_unix_time',
    'edit_unix_time',
    'membership_type',
  };
}

