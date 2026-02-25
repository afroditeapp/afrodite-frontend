//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProfileAttributesSchemaExport {
  /// Returns a new [ProfileAttributesSchemaExport] instance.
  ProfileAttributesSchemaExport({
    required this.attributeOrder,
    this.attributes = const [],
  });

  AttributeOrderMode attributeOrder;

  List<Attribute> attributes;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProfileAttributesSchemaExport &&
    other.attributeOrder == attributeOrder &&
    _deepEquality.equals(other.attributes, attributes);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (attributeOrder.hashCode) +
    (attributes.hashCode);

  @override
  String toString() => 'ProfileAttributesSchemaExport[attributeOrder=$attributeOrder, attributes=$attributes]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'attribute_order'] = this.attributeOrder;
      json[r'attributes'] = this.attributes;
    return json;
  }

  /// Returns a new [ProfileAttributesSchemaExport] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProfileAttributesSchemaExport? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ProfileAttributesSchemaExport[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ProfileAttributesSchemaExport[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ProfileAttributesSchemaExport(
        attributeOrder: AttributeOrderMode.fromJson(json[r'attribute_order'])!,
        attributes: Attribute.listFromJson(json[r'attributes']),
      );
    }
    return null;
  }

  static List<ProfileAttributesSchemaExport> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProfileAttributesSchemaExport>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProfileAttributesSchemaExport.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProfileAttributesSchemaExport> mapFromJson(dynamic json) {
    final map = <String, ProfileAttributesSchemaExport>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProfileAttributesSchemaExport.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProfileAttributesSchemaExport-objects as value to a dart map
  static Map<String, List<ProfileAttributesSchemaExport>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ProfileAttributesSchemaExport>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ProfileAttributesSchemaExport.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'attribute_order',
    'attributes',
  };
}

