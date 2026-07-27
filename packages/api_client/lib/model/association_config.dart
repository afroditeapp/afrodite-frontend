//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AssociationConfig {
  /// Returns a new [AssociationConfig] instance.
  AssociationConfig({
    this.associationInfoMarkdown,
    required this.associationName,
    this.membershipInfoMarkdown,
    this.membershipTypes = const [],
    this.userCanEditExistingMembership = false,
    this.userCanJoinAssociation = false,
    this.userCanViewExistingMembership = false,
  });

  StringResource? associationInfoMarkdown;

  StringResource associationName;

  StringResource? membershipInfoMarkdown;

  List<MembershipType> membershipTypes;

  bool userCanEditExistingMembership;

  bool userCanJoinAssociation;

  bool userCanViewExistingMembership;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AssociationConfig &&
    other.associationInfoMarkdown == associationInfoMarkdown &&
    other.associationName == associationName &&
    other.membershipInfoMarkdown == membershipInfoMarkdown &&
    _deepEquality.equals(other.membershipTypes, membershipTypes) &&
    other.userCanEditExistingMembership == userCanEditExistingMembership &&
    other.userCanJoinAssociation == userCanJoinAssociation &&
    other.userCanViewExistingMembership == userCanViewExistingMembership;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (associationInfoMarkdown == null ? 0 : associationInfoMarkdown!.hashCode) +
    (associationName.hashCode) +
    (membershipInfoMarkdown == null ? 0 : membershipInfoMarkdown!.hashCode) +
    (membershipTypes.hashCode) +
    (userCanEditExistingMembership.hashCode) +
    (userCanJoinAssociation.hashCode) +
    (userCanViewExistingMembership.hashCode);

  @override
  String toString() => 'AssociationConfig[associationInfoMarkdown=$associationInfoMarkdown, associationName=$associationName, membershipInfoMarkdown=$membershipInfoMarkdown, membershipTypes=$membershipTypes, userCanEditExistingMembership=$userCanEditExistingMembership, userCanJoinAssociation=$userCanJoinAssociation, userCanViewExistingMembership=$userCanViewExistingMembership]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.associationInfoMarkdown != null) {
      json[r'association_info_markdown'] = this.associationInfoMarkdown;
    } else {
      json[r'association_info_markdown'] = null;
    }
      json[r'association_name'] = this.associationName;
    if (this.membershipInfoMarkdown != null) {
      json[r'membership_info_markdown'] = this.membershipInfoMarkdown;
    } else {
      json[r'membership_info_markdown'] = null;
    }
      json[r'membership_types'] = this.membershipTypes;
      json[r'user_can_edit_existing_membership'] = this.userCanEditExistingMembership;
      json[r'user_can_join_association'] = this.userCanJoinAssociation;
      json[r'user_can_view_existing_membership'] = this.userCanViewExistingMembership;
    return json;
  }

  /// Returns a new [AssociationConfig] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AssociationConfig? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "AssociationConfig[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "AssociationConfig[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AssociationConfig(
        associationInfoMarkdown: StringResource.fromJson(json[r'association_info_markdown']),
        associationName: StringResource.fromJson(json[r'association_name'])!,
        membershipInfoMarkdown: StringResource.fromJson(json[r'membership_info_markdown']),
        membershipTypes: MembershipType.listFromJson(json[r'membership_types']),
        userCanEditExistingMembership: mapValueOfType<bool>(json, r'user_can_edit_existing_membership') ?? false,
        userCanJoinAssociation: mapValueOfType<bool>(json, r'user_can_join_association') ?? false,
        userCanViewExistingMembership: mapValueOfType<bool>(json, r'user_can_view_existing_membership') ?? false,
      );
    }
    return null;
  }

  static List<AssociationConfig> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AssociationConfig>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AssociationConfig.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AssociationConfig> mapFromJson(dynamic json) {
    final map = <String, AssociationConfig>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AssociationConfig.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AssociationConfig-objects as value to a dart map
  static Map<String, List<AssociationConfig>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AssociationConfig>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AssociationConfig.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'association_name',
    'membership_types',
  };
}

