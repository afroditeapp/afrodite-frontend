//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class GetAssociationMembership {
  /// Returns a new [GetAssociationMembership] instance.
  GetAssociationMembership({
    this.membership,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  AssociationMembership? membership;

  @override
  bool operator ==(Object other) => identical(this, other) || other is GetAssociationMembership &&
    other.membership == membership;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (membership == null ? 0 : membership!.hashCode);

  @override
  String toString() => 'GetAssociationMembership[membership=$membership]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.membership != null) {
      json[r'membership'] = this.membership;
    } else {
      json[r'membership'] = null;
    }
    return json;
  }

  /// Returns a new [GetAssociationMembership] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static GetAssociationMembership? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        return true;
      }());

      return GetAssociationMembership(
        membership: AssociationMembership.fromJson(json[r'membership']),
      );
    }
    return null;
  }

  static List<GetAssociationMembership> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <GetAssociationMembership>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = GetAssociationMembership.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, GetAssociationMembership> mapFromJson(dynamic json) {
    final map = <String, GetAssociationMembership>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = GetAssociationMembership.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of GetAssociationMembership-objects as value to a dart map
  static Map<String, List<GetAssociationMembership>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<GetAssociationMembership>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = GetAssociationMembership.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

