//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class UpdateAssociationMembershipType {
  /// Returns a new [UpdateAssociationMembershipType] instance.
  UpdateAssociationMembershipType({
    required this.member,
    required this.membershipType,
  });

  AccountId member;

  int membershipType;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UpdateAssociationMembershipType &&
    other.member == member &&
    other.membershipType == membershipType;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (member.hashCode) +
    (membershipType.hashCode);

  @override
  String toString() => 'UpdateAssociationMembershipType[member=$member, membershipType=$membershipType]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'member'] = this.member;
      json[r'membership_type'] = this.membershipType;
    return json;
  }

  /// Returns a new [UpdateAssociationMembershipType] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UpdateAssociationMembershipType? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "UpdateAssociationMembershipType[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "UpdateAssociationMembershipType[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return UpdateAssociationMembershipType(
        member: AccountId.fromJson(json[r'member'])!,
        membershipType: mapValueOfType<int>(json, r'membership_type')!,
      );
    }
    return null;
  }

  static List<UpdateAssociationMembershipType> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UpdateAssociationMembershipType>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UpdateAssociationMembershipType.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UpdateAssociationMembershipType> mapFromJson(dynamic json) {
    final map = <String, UpdateAssociationMembershipType>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UpdateAssociationMembershipType.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UpdateAssociationMembershipType-objects as value to a dart map
  static Map<String, List<UpdateAssociationMembershipType>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<UpdateAssociationMembershipType>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = UpdateAssociationMembershipType.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'member',
    'membership_type',
  };
}

