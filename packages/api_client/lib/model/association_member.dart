//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AssociationMember {
  /// Returns a new [AssociationMember] instance.
  AssociationMember({
    this.aidCreator,
    this.aidEditor,
    required this.aidMember,
    required this.creationUnixTime,
    this.domicile,
    required this.editUnixTime,
    this.email,
    this.fullName,
    required this.membershipType,
  });

  AccountId? aidCreator;

  AccountId? aidEditor;

  AccountId aidMember;

  UnixTime creationUnixTime;

  /// A string wrapper that ensures the string is not empty. This type is used for TEXT columns that should not allow empty strings. In the database, these columns are NULL when there is no value, and this type represents non-NULL values that must be non-empty.
  String? domicile;

  UnixTime editUnixTime;

  /// A string wrapper that ensures the string is not empty. This type is used for TEXT columns that should not allow empty strings. In the database, these columns are NULL when there is no value, and this type represents non-NULL values that must be non-empty.
  String? email;

  /// A string wrapper that ensures the string is not empty. This type is used for TEXT columns that should not allow empty strings. In the database, these columns are NULL when there is no value, and this type represents non-NULL values that must be non-empty.
  String? fullName;

  int membershipType;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AssociationMember &&
    other.aidCreator == aidCreator &&
    other.aidEditor == aidEditor &&
    other.aidMember == aidMember &&
    other.creationUnixTime == creationUnixTime &&
    other.domicile == domicile &&
    other.editUnixTime == editUnixTime &&
    other.email == email &&
    other.fullName == fullName &&
    other.membershipType == membershipType;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (aidCreator == null ? 0 : aidCreator!.hashCode) +
    (aidEditor == null ? 0 : aidEditor!.hashCode) +
    (aidMember.hashCode) +
    (creationUnixTime.hashCode) +
    (domicile == null ? 0 : domicile!.hashCode) +
    (editUnixTime.hashCode) +
    (email == null ? 0 : email!.hashCode) +
    (fullName == null ? 0 : fullName!.hashCode) +
    (membershipType.hashCode);

  @override
  String toString() => 'AssociationMember[aidCreator=$aidCreator, aidEditor=$aidEditor, aidMember=$aidMember, creationUnixTime=$creationUnixTime, domicile=$domicile, editUnixTime=$editUnixTime, email=$email, fullName=$fullName, membershipType=$membershipType]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.aidCreator != null) {
      json[r'aid_creator'] = this.aidCreator;
    } else {
      json[r'aid_creator'] = null;
    }
    if (this.aidEditor != null) {
      json[r'aid_editor'] = this.aidEditor;
    } else {
      json[r'aid_editor'] = null;
    }
      json[r'aid_member'] = this.aidMember;
      json[r'creation_unix_time'] = this.creationUnixTime;
    if (this.domicile != null) {
      json[r'domicile'] = this.domicile;
    } else {
      json[r'domicile'] = null;
    }
      json[r'edit_unix_time'] = this.editUnixTime;
    if (this.email != null) {
      json[r'email'] = this.email;
    } else {
      json[r'email'] = null;
    }
    if (this.fullName != null) {
      json[r'full_name'] = this.fullName;
    } else {
      json[r'full_name'] = null;
    }
      json[r'membership_type'] = this.membershipType;
    return json;
  }

  /// Returns a new [AssociationMember] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AssociationMember? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'aid_member'), 'Required key "AssociationMember[aid_member]" is missing from JSON.');
        assert(json[r'aid_member'] != null, 'Required key "AssociationMember[aid_member]" has a null value in JSON.');
        assert(json.containsKey(r'creation_unix_time'), 'Required key "AssociationMember[creation_unix_time]" is missing from JSON.');
        assert(json[r'creation_unix_time'] != null, 'Required key "AssociationMember[creation_unix_time]" has a null value in JSON.');
        assert(json.containsKey(r'edit_unix_time'), 'Required key "AssociationMember[edit_unix_time]" is missing from JSON.');
        assert(json[r'edit_unix_time'] != null, 'Required key "AssociationMember[edit_unix_time]" has a null value in JSON.');
        assert(json.containsKey(r'membership_type'), 'Required key "AssociationMember[membership_type]" is missing from JSON.');
        assert(json[r'membership_type'] != null, 'Required key "AssociationMember[membership_type]" has a null value in JSON.');
        return true;
      }());

      return AssociationMember(
        aidCreator: AccountId.fromJson(json[r'aid_creator']),
        aidEditor: AccountId.fromJson(json[r'aid_editor']),
        aidMember: AccountId.fromJson(json[r'aid_member'])!,
        creationUnixTime: UnixTime.fromJson(json[r'creation_unix_time'])!,
        domicile: mapValueOfType<String>(json, r'domicile'),
        editUnixTime: UnixTime.fromJson(json[r'edit_unix_time'])!,
        email: mapValueOfType<String>(json, r'email'),
        fullName: mapValueOfType<String>(json, r'full_name'),
        membershipType: mapValueOfType<int>(json, r'membership_type')!,
      );
    }
    return null;
  }

  static List<AssociationMember> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AssociationMember>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AssociationMember.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AssociationMember> mapFromJson(dynamic json) {
    final map = <String, AssociationMember>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AssociationMember.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AssociationMember-objects as value to a dart map
  static Map<String, List<AssociationMember>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AssociationMember>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AssociationMember.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'aid_member',
    'creation_unix_time',
    'edit_unix_time',
    'membership_type',
  };
}

