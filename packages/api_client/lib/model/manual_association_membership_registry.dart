//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ManualAssociationMembershipRegistry {
  /// Returns a new [ManualAssociationMembershipRegistry] instance.
  ManualAssociationMembershipRegistry({
    required this.registry,
  });

  String registry;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ManualAssociationMembershipRegistry &&
    other.registry == registry;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (registry.hashCode);

  @override
  String toString() => 'ManualAssociationMembershipRegistry[registry=$registry]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'registry'] = this.registry;
    return json;
  }

  /// Returns a new [ManualAssociationMembershipRegistry] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ManualAssociationMembershipRegistry? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ManualAssociationMembershipRegistry[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ManualAssociationMembershipRegistry[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ManualAssociationMembershipRegistry(
        registry: mapValueOfType<String>(json, r'registry')!,
      );
    }
    return null;
  }

  static List<ManualAssociationMembershipRegistry> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ManualAssociationMembershipRegistry>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ManualAssociationMembershipRegistry.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ManualAssociationMembershipRegistry> mapFromJson(dynamic json) {
    final map = <String, ManualAssociationMembershipRegistry>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ManualAssociationMembershipRegistry.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ManualAssociationMembershipRegistry-objects as value to a dart map
  static Map<String, List<ManualAssociationMembershipRegistry>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ManualAssociationMembershipRegistry>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ManualAssociationMembershipRegistry.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'registry',
  };
}

